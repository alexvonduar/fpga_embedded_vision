import vitis
import os
import shutil
import platform as os_platform

print ("\n-----------------------------------------------------------------")
print ("Creation of Platform and Add Domain and OS details Test-Case\n")
print("script dir: {}".format(os.getcwd()))
script_dir = os.getcwd()
#get parent directory of script_dir
top_dir,_ = os.path.split(script_dir)
print("top dir: {}".format(top_dir))

proj_name = "fmchc_python1300c"

target_dir = os.path.join(top_dir, proj_name + "_MYIR7020_2024.2")

client = vitis.create_client()

workspace = os.path.join(target_dir, proj_name + ".vitis")

#Delete the workspace if already exists.
if (os.path.exists(workspace)):
    shutil.rmtree(workspace)
    print(f"Deleted workspace {workspace}")

client.set_workspace(path=workspace)
print("Workspace set to : " + workspace)

#print("===============================================================")
local_repo_name = 'avnet_drivers'
local_repo_path = os.path.join(top_dir, "avnet/Projects", proj_name, "software/sw_repository")
local_repo_description = "avnet driver repository"
#os.makedirs(local_repo_path, exist_ok = True)

# Add the local path to the examples/library repository
status = client.add_embedded_sw_repo(level="local", path=local_repo_path)
print(f"Local repo '{local_repo_name}' added")

#print("===============================================================")
# XSA directory path
#xsa_dir = os.environ.get('XILINX_VITIS')
#xsa = os.path.join(xsa_dir, "data/embeddedsw/lib/fixed_hwplatforms/vck190.xsa")
xsa = os.path.join(target_dir, proj_name + ".xsa")
platform_name = proj_name + "_platform"

#advanced_options = client.create_advanced_options_dict(dt_overlay = "1",dt_zocl = "1")

#platform = client.create_platform_component(name = "platform_vck", hw_design = xsa, no_boot_bsp = True, generate_dtb = True, advanced_options = advanced_options, architecture = "64-bit", desc = "A base platform targeting vck190")
platform = client.create_platform_component(name = platform_name, hw_design = xsa, cpu = "ps7_cortexa9_0", os = "standalone")
#platform = client.create_platform_component(name = platform_name, hw_design = 'zcu102', cpu = "psu_cortexa53", os = "linux", domain_name = "linux_a53")
platform.report()
#platform.list_embedded_sw_repos()

# Add platform repository and get required platform
#platforms_dir = os.environ.get('PLATFORM_REPO_PATHS')
#if (platforms_dir == None):
#    print(f"Set 'PLATFORM_REPO_PATHS' environment variable to add Platform repository")
#    exit()

#print("===============================================================")
#platform = client.get_component(name = "platform_vck")
#for domain in platform.list_domains():
#    print(domain)

# Create a standlone domain and edit the bsp settings
#standalone_a9_0 = platform.add_domain(name = "standalone_a9_0", cpu = "ps7_cortex_a9_0", os = "standalone")
standalone_a9_0 = platform.get_domain(name = "standalone_ps7_cortexa9_0")
standalone_a9_0.report()


#print("===============================================================")
# Add, get libraries and library parameters
#print("Applicable libraries:")
#standalone_a9_0.get_applicable_libs()
standalone_a9_0.set_lib('xilffs')
standalone_a9_0.set_lib('xilrsa')
standalone_a9_0.set_lib('onsemi_python_sw')
standalone_a9_0.set_lib('fmc_iic_sw')
standalone_a9_0.set_lib('fmc_hdmi_cam_sw')
#print("List of configured libraries:")
#standalone_a9_0.get_libs()


#status = standalone_a9_0.build()

#status = domain.set_dtb(path=dtb) # used to bypass sdtgen from generate platform

status = platform.build()

app_name = proj_name + "_app"
app_src = os.path.join(top_dir, "avnet/Projects/" + proj_name + "/software/" + proj_name + "_app/src")
print("app source: {}".format(app_src))
exported_plaftorm = workspace + "/" + platform_name + "/export/" + platform_name + "/" + platform_name + ".xpfm"
print("exported_plaftorm: " + exported_plaftorm)
app = client.create_app_component(name=app_name, platform=exported_plaftorm, domain="standalone_ps7_cortexa9_0")
app.import_files(from_loc=app_src, dest_dir_in_cmp='src')
app.generate_build_files()
app.append_app_config(
    key="USER_INCLUDE_DIRECTORIES",
    values=[
        '.',
        './adi_adv7511_hal/',
        './adi_adv7511_hal/TX/',
        './adi_adv7511_hal/TX/HAL/COMMON/',
        './adi_adv7511_hal/TX/HAL/WIRED/ADV7511/',
        './adi_adv7511_hal/TX/HAL/WIRED/ADV7511/MACROS/',
        './adi_adv7511_hal/TX/LIB/']
)
app.report()
app.build()

'''
# Delete domain
platform.delete_domain("standalone_ps7_cortexa9_0")
#platform.delete_domain("standalone_a9_0")
client.delete_component(platform_name)

# # Delete the workspace
if (os.path.isdir(workspace)):
    shutil.rmtree(workspace, ignore_errors=True)
    print(f"Deleted workspace {workspace}")
'''

bif_name = os.path.join(target_dir, "boot.bif")
fsbl_name = os.path.join(workspace, platform_name, "export", platform_name, "sw/boot/fsbl.elf")
bitfile_name = os.path.join(workspace, platform_name, "export", platform_name, "hw/sdt/" + proj_name + ".bit")
appfile_name = os.path.join(workspace, app_name, "build", app_name + ".elf")
with open(bif_name, "w") as bif_file:
    bif_file.write("the_ROM_image:\n")
    bif_file.write("{\n")
    bif_file.write("  [bootloader] " + fsbl_name + "\n")
    bif_file.write("  " + bitfile_name + "\n")
    bif_file.write("  " + appfile_name + "\n")
    bif_file.write("}\n")

print(f"Boot image BIF file created at: {bif_name}")

# Close the client connection and terminate the vitis server
vitis.dispose()
