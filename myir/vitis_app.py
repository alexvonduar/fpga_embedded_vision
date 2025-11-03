import vitis
import os
import shutil
import platform as os_platform
import argparse

def build_app(args):
    print ("\n-----------------------------------------------------------------")
    print("top dir: {}".format(args.top))

    #proj_name = "fmchc_python1300c"

    #target_dir = os.path.join(top_dir, args.project + "_" + args.target + "_" + args.version)

    client = vitis.create_client()

    vitis_workspace = os.path.join(args.output, args.project + ".vitis")

    #Delete the vitis workspace if already exists.
    if (os.path.exists(vitis_workspace)):
        shutil.rmtree(vitis_workspace)
        print(f"Deleted vitis workspace {vitis_workspace}")

    client.set_workspace(path=vitis_workspace)
    print("Vitis workspace set to : " + vitis_workspace)

    #print("===============================================================")
    local_repo_name = 'avnet_drivers'
    local_repo_path = os.path.join(args.top, "avnet/Projects", args.project, "software/sw_repository")
    local_repo_description = "avnet driver repository"
    #os.makedirs(local_repo_path, exist_ok = True)

    # Add the local path to the examples/library repository
    status = client.add_embedded_sw_repo(level="local", path=local_repo_path)
    print(f"Local repo '{local_repo_name}' added")

    #print("===============================================================")
    # XSA directory path
    #xsa_dir = os.environ.get('XILINX_VITIS')
    #xsa = os.path.join(xsa_dir, "data/embeddedsw/lib/fixed_hwplatforms/vck190.xsa")
    xsa = os.path.join(args.output, args.project + ".xsa")
    platform_name = args.project + "_platform"

    #advanced_options = client.create_advanced_options_dict(dt_overlay = "1",dt_zocl = "1")

    #platform = client.create_platform_component(name = "platform_vck", hw_design = xsa, no_boot_bsp = True, generate_dtb = True, advanced_options = advanced_options, architecture = "64-bit", desc = "A base platform targeting vck190")
    platform = client.create_platform_component(name = platform_name, hw_design = xsa, cpu = "ps7_cortexa9_0", os = "standalone")
    #platform = client.create_platform_component(name = platform_name, hw_design = 'zcu102', cpu = "psu_cortexa53", os = "linux", domain_name = "linux_a53")
    #platform.report()
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
    #standalone_a9_0.report()


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

    app_name = args.project + "_app"
    app_src = os.path.join(args.top, "avnet/Projects/" + args.project + "/software/" + args.project + "_app/src")
    print("app source: {}".format(app_src))
    exported_plaftorm = os.path.join(vitis_workspace, platform_name, "export", platform_name, platform_name + ".xpfm")
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

    bif_name = os.path.join(args.output, "boot.bif")
    fsbl_name = os.path.join(vitis_workspace, platform_name, "export", platform_name, "sw/boot/fsbl.elf")
    bitfile_name = os.path.join(vitis_workspace, platform_name, "export", platform_name, "hw/sdt/" + args.project + ".bit")
    appfile_name = os.path.join(vitis_workspace, app_name, "build", app_name + ".elf")
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

# input arguments
# top: top directory mandatory
# build type: debug/release optional debug as default
# target: target name mandatory
# project: project name mandatory
# version: version string mandatory
# output: output directory opitional use current directory as default
if __name__ == "__main__":
    print("Test script is running.")
    print("Current working directory:", os.getcwd())
    parser = argparse.ArgumentParser(description="Test script for myir.")
    parser.add_argument("--top", help="Top directory", type=str)
    parser.add_argument("--build_type", help="Build type (debug/release)", type=str, default="debug")
    parser.add_argument("--target", help="Target name", type=str)
    parser.add_argument("--project", help="Project name", type=str)
    parser.add_argument("--version", help="Version string", type=str)
    parser.add_argument("--output", help="Output directory", type=str)
    args = parser.parse_args()
    if not args.top or not args.target or not args.project or not args.version:
        parser.print_help()
        exit(1)
    print("Top directory:", args.top)
    print("Build type:", args.build_type)
    print("Target name:", args.target)
    print("Project name:", args.project)
    print("Version string:", args.version)
    if not args.output:
        args.output = os.getcwd()
    print("Output directory: ", args.output)
    build_app(args)
    exit(0)

