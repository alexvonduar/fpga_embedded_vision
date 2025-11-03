import vitis
import os
import shutil
import platform as os_platform
import argparse

def build_app(args):
    client = vitis.create_client()

    #Delete the vitis workspace if already exists.
    if (os.path.exists(args.workspace)):
        shutil.rmtree(args.workspace)
        print(f"Deleted vitis workspace {args.workspace}")

    client.set_workspace(path=args.workspace)
    print("Vitis workspace set to : " + args.workspace)

    platform_name = args.project + "_platform"

    platform = client.create_platform_component(
        name = platform_name,
        hw_design = args.hardware,
        cpu = "psu_cortexa53_0",
        os = "standalone"
    )
    platform.report()

    domain = platform.get_domain(name = "standalone_psu_cortexa53_0")

    domain.set_lib('xilffs')
    domain.report()

    status = platform.build()

    app_name = args.project + "_app"
    exported_plaftorm = os.path.join(args.workspace, platform_name, "export", platform_name, platform_name + ".xpfm")
    print("exported plaftorm: " + exported_plaftorm)
    app = client.create_app_component(name=app_name, platform=exported_plaftorm, domain="standalone_ps7_cortexa9_0")
    app.import_files(from_loc=args.source, dest_dir_in_cmp='src')
    app.generate_build_files()
    
    app.append_app_config(
        key="USER_INCLUDE_DIRECTORIES",
        values=[
            '.'
        ]
    )
    app.append_app_config(
        key = "USER_COMPILE_DEFINITIONS",
        values = [
            '-DBOARD=1'
        ]
    )
    app.set_app_config(key='USER_COMPILE_OTHER_FLAGS', values='-Wno-unused-variable -Wno-unused-function -Wno-unused-but-set-variable')
    #app.set_app_config(key = 'USER_COMPILE_WARNINGS_AS_ERRORS',values = 'TRUE')

    values = app.get_app_config()
    print("Application configuration before build:")
    for key, val in values.items():
        print(f"{key}: {val}")

    app.report()
    app.build()


    bif_name = os.path.join(args.workspace, "boot.bif")
    fsbl_name = os.path.join(args.workspace, platform_name, "export", platform_name, "sw/boot/fsbl.elf")
    bitfile_name = os.path.join(args.workspace, platform_name, "export", platform_name, "hw/sdt/" + args.project + ".bit")
    appfile_name = os.path.join(args.workspace, app_name, "build", app_name + ".elf")
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
# workspace: workspace directory mandatory use current directory as default
if __name__ == "__main__":
    print("Test script is running.")
    print("Current working directory:", os.getcwd())
    parser = argparse.ArgumentParser(description="Test script for myir.")
    #parser.add_argument("--top", help="Top directory", type=str)
    parser.add_argument("--build_type", help="Build type (debug/release)", type=str, default="debug")
    #parser.add_argument("--target", help="Target name", type=str)
    parser.add_argument("--project", help="Project name", type=str, required=True)
    #parser.add_argument("--version", help="Version string", type=str)
    parser.add_argument("--workspace", help="Workspace directory", type=str, required=True)
    parser.add_argument("--source", help="Source directory", type=str, required=True)
    parser.add_argument("--hardware", help="XSA hardware design file", type=str, required=True)
    args = parser.parse_args()
    if not args.project or not args.workspace or not args.source or not args.hardware:
        parser.print_help()
        exit(1)
    #print("Top directory:", args.top)
    print("Build type:", args.build_type)
    #print("Target name:", args.target)
    print("Project name:", args.project)
    #print("Version string:", args.version)
    print("Workspace directory: ", args.workspace)
    print("Source directory: ", args.source)
    print("Hardware design file: ", args.hardware)
    build_app(args)
    exit(0)
