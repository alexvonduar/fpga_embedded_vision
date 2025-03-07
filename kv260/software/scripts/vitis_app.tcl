set XSA_FILE [lindex $argv 0]
set SW_SRC_DIR [lindex $argv 1]
set VITIS_WS [lindex $argv 2]

set platform_name "hw_platform"

puts "\n#\n#"
puts "# XSA: ${XSA_FILE}"
puts "# platform: ${platform_name}"
puts "# workspace: ${VITIS_WS}"
puts "#\n#"

# Set workspace and import hardware platform
setws ${VITIS_WS}

# Generate Platform

set plist [platform list]
set platform_exist [string match "*$platform_name *" $plist]

puts "\n#\n#\n# Creating Platform ${platform_name} ...\n#\n#\n"
#getprocessors ${XSA_FILE}
if {$platform_exist} {
    platform remove ${platform_name}
    puts "**** ${platform_name} removed"
}
platform create -name ${platform_name} -hw ${XSA_FILE} -proc {psu_cortexa53_0} -os standalone
platform write

set app_name "app"
set sysproj_name "app_sys"
set build_type "release"


puts "\n#\n#"
puts "# app_name: ${app_name}"
puts "# sysproj_name: ${sysproj_name}"
puts "# build_type: ${build_type}"
puts "#\n#"

puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
repo -set ${SW_SRC_DIR}


puts "\n#\n#\n# Updating BSP ...\n#\n#\n"

# add libraries for FSBL
bsp setlib -name xilffs
#bsp setlib -name xilrsa
# add libraries for APP
#bsp setlib -name fmc_iic_sw
#bsp setlib -name fmc_hdmi_cam_sw
#bsp setlib -name onsemi_python_sw
# regen and build
bsp regenerate
bsp config -append extra_compiler_flags "-Wno-comment -Wno-unused-but-set-variable -Wno-unused-variable"
#platform generate

# Create APP
puts "\n#\n#\n# Creating ${app_name} ...\n#\n#\n"
if {[catch {app remove ${app_name}} errmsg]} {
    puts "**** ${app_name} ${errmsg}"
} else {
    puts "**** ${app_name} removed"
}
if {[catch {sysproj remove ${sysproj_name}} errmsg]} {
    puts "**** ${sysproj_name} ${errmsg}"
} else {
    puts "**** ${sysproj_name} removed"
}
app create -name ${app_name} -sysproj ${sysproj_name} -platform ${platform_name} -domain standalone_domain -proc psu_cortexa53_0 -os standalone -lang C -template {Empty Application(C)}

if {[string match -nocase "debug" $build_type]} {
    app config -name ${app_name} -set build-config Debug
}
if {[string match -nocase "release" $build_type]} {
    app config -name ${app_name} -set build-config Release
}

# APP : copy sources to empty application
#set app_src_dir ${top}/avnet/Projects/${project}/software/${project}_app/src
importsources -name ${app_name} -path ${SW_SRC_DIR} -soft-link
app config -add -name ${app_name} include-path ${SW_SRC_DIR}
app config -add -name ${app_name} compiler-misc {-Wno-comment -DBOARD=1}
app report ${app_name}

# build APP
puts "\n#\n#\n# Build ${app_name}, ${sysproj_name} and generate BOOT.bin ...\n#\n#\n"
#app build -name ${app_name}
sysproj build -name ${sysproj_name}

exit
