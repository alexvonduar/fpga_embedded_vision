import vitis
import os
import shutil
import platform as os_platform
import argparse
from datetime import datetime

def build_app(args):
    print ("\n-----------------------------------------------------------------")
    print("top dir: {}".format(args.top))

    #proj_name = "fmchc_python1300c"

    client = vitis.create_client()

    vitis_workspace = os.path.join(args.output, args.project + "_vitis")

    #Delete the vitis workspace if already exists.
    if (os.path.exists(vitis_workspace)):
        shutil.rmtree(vitis_workspace)
        print(f"Deleted vitis workspace {vitis_workspace}")

    client.set_workspace(path=vitis_workspace)
    print("Vitis workspace set to : " + vitis_workspace)

    #print("===============================================================")
    local_repo_name = 'avnet_drivers'
    local_repo_path = os.path.join(args.top, "avnet/Projects/fmchc_python1300c/software/sw_repository")
    local_repo_description = "avnet driver repository"
    #os.makedirs(local_repo_path, exist_ok = True)

    # Add the local path to the examples/library repository
    status = client.add_embedded_sw_repo(level="local", path=local_repo_path)
    print(f"Local repo '{local_repo_name}' added")

    platform_name = args.project + "_platform"

    platform = client.create_platform_component(name = platform_name, hw_design = args.hw, cpu = "ps7_cortexa9_0", os = "standalone")
    standalone_a9_0 = platform.get_domain(name = "standalone_ps7_cortexa9_0")

    standalone_a9_0.set_lib('xilffs')
    standalone_a9_0.set_lib('xilrsa')
    standalone_a9_0.set_lib('onsemi_python_sw')
    standalone_a9_0.set_lib('fmc_iic_sw')
    standalone_a9_0.set_lib('fmc_hdmi_cam_sw')
    #print("List of configured libraries:")
    #standalone_a9_0.get_libs()
    #standalone_a9_0.report()
    #status = standalone_a9_0.build()
    if (args.build_type.lower() == "debug"):
        config = standalone_a9_0.get_config(option="proc", param="proc_extra_compiler_flags")
        default_flags = config['default_value'].split()
        print("Default compiler flags: " + str(default_flags))
        for flag in default_flags:
            if flag.startswith("-O"):
                default_flags.remove(flag)
            if flag == "-g":
                default_flags.remove(flag)
        #default_flags.append("-g3")
        #default_flags.append("-O0")
        #default_flags = default_flags.join(" ")
        default_flags = ' '.join(['-O0', '-g3', '-DDEBUG=1'] + default_flags)
        print("Modified compiler flags for debug build: " + str(default_flags))
        standalone_a9_0.set_config(
            option="proc",
            param="proc_extra_compiler_flags",
            value=default_flags
        )

    status = platform.build()

    exported_plaftorm = os.path.join(vitis_workspace, platform_name, "export", platform_name, platform_name + ".xpfm")
    print("exported_plaftorm: " + exported_plaftorm)

    now = datetime.now()
    #print(f"Current datetime: {now}")
    #print(f"Date only: {now:%Y-%m-%d}")
    #print(f"Time only: {now:%H:%M:%S}")
    #print(f"Version date: {now:+%d%b%Y}")

    if (args.fmc_board):
        print("FMC board selected: {}".format(args.fmc_board))
        fru=client.create_library_component(name='fru', platform=exported_plaftorm, domain='standalone_ps7_cortexa9_0')
        fru_sources = [
            "operating-system.c",
            "fru.c",
            "fru.h",
            "fru-parse.c",
            "ipmi-fru.h",
            "ipmi.c",
            "ipmi.h"
        ]
        fru_sources_dir = os.path.join(args.top, "fru")
        fru.import_files(from_loc=fru_sources_dir, files=fru_sources, dest_dir_in_cmp='src', is_skip_copy_sources = False)
        #fru.import_files(from_loc=fru_sources_dir, dest_dir_in_cmp='src', is_skip_copy_sources = True)
        fru.append_app_config(key="USER_INCLUDE_DIRECTORIES", values=['./'])
        VERSION_STR='\"VERSION=\\\"0.8.1.9\\\"\"'
        VERSION_DATE_STR = '\"VERSION_DATE=\\\"' + now.strftime("%d%b%Y") +'\\\"\"'
        fru.append_app_config(key="USER_COMPILE_DEFINITIONS", values=["LIBRARY_BUILD=1", VERSION_STR, VERSION_DATE_STR])
        if args.build_type.lower() == "debug":
            fru.set_app_config(key='USER_COMPILE_OPTIMIZATION_LEVEL', values=['-O0'])
            fru.set_app_config(key='USER_COMPILE_DEBUG_LEVEL', values=['-g3'])
            #fru.set_app_config(key='USER_COMPILE_DEBUG_OTHER_FLAGS', values=['-DDEBUG=1'])
        fru.report()
        fru.build()

    USE_EDID_DECODE = False
    if (args.board.lower() == "myir7020" and (args.output_port.lower() == "fmc_hdmi" or args.output_port.lower() == "hdmi")):
        USE_EDID_DECODE = True
    elif (args.board.lower() == "zynqdev" and (args.output_port.lower() == "fmc_hdmi" or args.output_port.lower() == "hdmi2")):
        USE_EDID_DECODE = True

    if (USE_EDID_DECODE):
        print("EDID DECODE ENABLED")
        edid_decode=client.create_library_component(name='edid_decode', platform=exported_plaftorm, domain='standalone_ps7_cortexa9_0')
        edid_decode_sources = [
            "edid-decode.cpp",
            "parse-cta-block.cpp",
            "parse-ls-ext-block.cpp",
            "parse-vtb-ext-block.cpp",
            "parse-eld.cpp",
            "parse-if.cpp",
            "calc-ovt.cpp",
            "parse-displayid-block.cpp",
            "parse-base-block.cpp",
            "calc-gtf-cvt.cpp",
            "parse-di-ext-block.cpp",
            "oui.h",
            "edid-decode.h",
            "edid-decode-export.h"
        ]
        print("edid_decode source dir: {}".format(os.path.join(args.top, "edid-sdecode")))
        edid_decode_source_dir = os.path.join(args.top, "edid-decode")
        edid_decode.import_files(from_loc=edid_decode_source_dir, files=edid_decode_sources, dest_dir_in_cmp='src', is_skip_copy_sources = False)
        #edid_decode.generate_build_files()
        edid_decode.append_app_config(key="USER_INCLUDE_DIRECTORIES", values=['./'])
        edid_decode.append_app_config(key="USER_COMPILE_DEFINITIONS", values=["__EMSCRIPTEN__=1"])
        if args.build_type.lower() == "debug":
            edid_decode.set_app_config(key='USER_COMPILE_OPTIMIZATION_LEVEL', values=['-O0'])
            edid_decode.set_app_config(key='USER_COMPILE_DEBUG_LEVEL', values=['-g3'])
            #edid_decode.set_app_config(key='USER_COMPILE_DEBUG_OTHER_FLAGS', values=['-DDEBUG=1'])
        edid_decode.report()
        edid_decode.build()

    app_name = args.project + "_app"
    app_src = os.path.join(args.top, "avnet/Projects/fmchc_python1300c/software/fmchc_python1300c_app/src")
    print("app source: {}".format(app_src))

    app = client.create_app_component(name=app_name, platform=exported_plaftorm, domain="standalone_ps7_cortexa9_0")
    app.import_files(from_loc=app_src, dest_dir_in_cmp='src', is_skip_copy_sources = True)
    if USE_EDID_DECODE:
        ldscript = app.get_ld_script()
        ldscript.set_heap_size(size='0x100000')  # 1 MB
        ldscript.set_stack_size(size='0x100000') # 1 MB
    app.generate_build_files()
    app.append_app_config(
        key="USER_INCLUDE_DIRECTORIES",
        values=[
            app_src,
            os.path.join(app_src, 'adi_adv7511_hal/'),
            os.path.join(app_src, 'adi_adv7511_hal/TX/'),
            os.path.join(app_src, 'adi_adv7511_hal/TX/HAL/COMMON/'),
            os.path.join(app_src, 'adi_adv7511_hal/TX/HAL/WIRED/ADV7511/'),
            os.path.join(app_src, 'adi_adv7511_hal/TX/HAL/WIRED/ADV7511/MACROS/'),
            os.path.join(app_src, 'adi_adv7511_hal/TX/LIB/')]
    )
    if USE_EDID_DECODE:
        app.append_app_config(
            key="USER_INCLUDE_DIRECTORIES",
            values=[os.path.join(args.top, "edid-decode")]
        )
    if args.fmc_board:
        app.append_app_config(
            key="USER_INCLUDE_DIRECTORIES",
            values=[os.path.join(args.top, "fru")]
        )

    user_compile_defs = []
    if args.fmc_board:
        user_compile_defs.append('-DFMC_BOARD='+args.fmc_board)
    if USE_EDID_DECODE:
        user_compile_defs.append('__EMSCRIPTEN__=1')
    if args.fmc_board:
        user_compile_defs.append('-D'+args.fmc_board.upper()+"=1")
    user_compile_defs.append('-D'+args.board.upper()+"=1")
    if args.board.lower() == 'myir7020':
        if args.input_port.lower() == 'fmc_hdmi':
            user_compile_defs.append('-DFMC_HDMI_IN=1')
        elif args.input_port.lower() == 'fmc_python1300c':
            user_compile_defs.append('-DPYTHON1300=1')
        else:
            print("Error: Invalid input port selected")
            exit(1)
        if args.output_port.lower() == 'fmc_hdmi':
            user_compile_defs.append('-DFMC_HDMI_OUT=1')
    elif args.board.lower() == 'zynqdev':
        if args.input_port.lower() == 'fmc_python1300c':
            user_compile_defs.append('-DPYTHON1300=1')
        elif args.input_port.lower() == 'fmc_hdmi':
            user_compile_defs.append('-DFMC_HDMI_IN=1')
        elif args.input_port.lower() == 'mipi1':
            user_compile_defs.append('-DMIPI_IN=1')
        else:
            print("Error: Invalid input port selected")
            exit(1)
        if args.output_port.lower() == 'fmc_hdmi':
            user_compile_defs.append('-DFMC_HDMI_OUT=1')
        elif args.output_port.lower() == 'hdmi2':
            user_compile_defs.append('-DHDMI_OUT=2')
        elif args.output_port.lower() == 'hdmi1':
            user_compile_defs.append('-DHDMI_OUT=1')
        else:
            print("Error: Invalid output port selected")
            exit(1)
    else:
        print("No board selected or unsupported board.")
        exit(1)

    if USE_EDID_DECODE:
        user_compile_defs.append('-DUSE_EDID_DECODE=1')

    app.append_app_config(
        key = "USER_COMPILE_DEFINITIONS",
        values = user_compile_defs
    )
    app.set_app_config(key='USER_COMPILE_OTHER_FLAGS', values='-Wno-unused-variable -Wno-unused-function -Wno-unused-but-set-variable -Wno-unused-parameter')
    if args.build_type.lower() == "debug":
        app.set_app_config(key='USER_COMPILE_OPTIMIZATION_LEVEL', values=['-O0'])
        app.set_app_config(key='USER_COMPILE_DEBUG_LEVEL', values=['-g3'])
        app.set_app_config(key='USER_COMPILE_DEBUG_OTHER_FLAGS', values=['-DDEBUG=1'])
    if USE_EDID_DECODE or args.build_type.lower() == "debug":
        app.append_app_config(key='USER_LINK_LIBRARIES', values=['m'])
    if USE_EDID_DECODE:
        linkpath = app.get_app_config(key='USER_LINK_DIRECTORIES')
        linkpath.append(os.path.join(vitis_workspace, 'edid_decode', 'build'))
        print("EDID DECODE link path: {}".format(linkpath))
        app.set_app_config(key='USER_LINK_DIRECTORIES', values=linkpath)
        #app.append_app_config(key='USER_LINK_FLAGS', values=['-L' + os.path.join(vitis_workspace, 'edid_decode', 'build')])
        app.append_app_config(key='USER_LINK_LIBRARIES', values=['edid_decode', 'stdc++'])
        #app.get_app_config()
    if args.fmc_board:
        linkpath = app.get_app_config(key='USER_LINK_DIRECTORIES')
        linkpath.append(os.path.join(vitis_workspace, 'fru', 'build'))
        app.set_app_config(key='USER_LINK_DIRECTORIES', values=linkpath)
        #app.append_app_config(key='USER_LINK_FLAGS', values=['-L' +  os.path.join(vitis_workspace, 'fru', 'build')])
        app.append_app_config(key='USER_LINK_LIBRARIES', values=['fru'])
    #app.get_app_config()
    app.report()
    app.build()

    # Create the boot image BIF file
    bif_name = os.path.join(vitis_workspace, args.project + "_BOOT.bif")
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

if __name__ == "__main__":
    print("Test script is running.")
    print("Current working directory:", os.getcwd())
    parser = argparse.ArgumentParser(description="Test script for myir.")
    parser.add_argument("--top", help="Top directory", type=str, required=True)
    parser.add_argument("--build_type", help="Build type (debug/release)", type=str, default="debug")
    parser.add_argument("--project", help="Project name", type=str)
    parser.add_argument("--hw", help="Hardware file", type=str, required=True)
    parser.add_argument("--version", help="Version string", type=str)
    parser.add_argument("--output", help="Output directory", type=str, required=True)
    parser.add_argument("--input_port", help="input port", type=str, required=True)
    parser.add_argument("--output_port", help="output port", type=str, required=True)
    parser.add_argument("--board", help="board name", type=str, required=True)
    parser.add_argument("--fmc_board", help="FMC board", type=str, default="")
    args = parser.parse_args()

    print("Top directory:", args.top)
    print("Hardware file:", args.hw)
    print("Build type:", args.build_type)
    print("Project name:", args.project)
    print("Version string:", args.version)
    print("Board:", args.board)
    if (args.fmc_board):
        print("FMC board:", args.fmc_board)
    print("Input port:", args.input_port)
    print("Output port:", args.output_port)
    if not args.output:
        args.output = os.getcwd()
    print("Output directory: ", args.output)
    build_app(args)
    exit(0)
