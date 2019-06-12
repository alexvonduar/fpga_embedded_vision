TARGET = vcu_qt
QT += qml quick widgets core gui
QT += charts
QT += network

CONFIG += c++11
CONFIG += qwt
SOURCES += \
    src/main.cpp \
    src/CPUStat.cpp \
    src/maincontroller.cpp \
    src/dirop.cpp \
    src/video_cfg.cpp

HEADERS += \
    include/CPUStat.h \
    include/maincontroller.h \
    include/dirop.h \
    include/video_cfg.h

RESOURCES += qml.qrc

QML_IMPORT_PATH =

QML_DESIGNER_IMPORT_PATH =

DEFINES += \
    QT_DEPRECATED_WARNINGS \
    ENABLE_DEBUG_MODE

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    VCU.pro.user \
    VCU_TRD.pro.user

MOC_DIR = moc

OBJECTS_DIR = obj

mkdirs.commands = $(MKDIR) $$MOC_DIR $$OBJECTS_DIR

QMAKE_EXTRA_TARGETS += mkdirs

INCLUDEPATH += \
        include \
        ../vcu_gst_lib/include \
        ../vcu_apm_lib/include \
        ../vcu_video_lib/include \
        =/usr/include/gstreamer-1.0 \
        =/usr/include/gstreamer-1.0/gst \
        =/usr/include/glib-2.0 \
        =/usr/lib/glib-2.0/include \
        =/usr/lib/gstreamer-1.0/include \
        =/usr/lib/gstreamer-1.0/include/gst \
        =/usr/include


QMAKE_LIBDIR_FLAGS += \
        -L../vcu_video_lib/Release \
        -L../vcu_video_lib/Debug \
        -L../vcu_gst_lib/Release \
        -L../vcu_gst_lib/Debug \
        -L../vcu_apm_lib/Release \
        -L../vcu_apm_lib/Debug \
        -L=/usr/lib \
        -L=/lib \
        -L=/usr/lib/gstreamer-1.0

LIBS += \
        -lQt5PrintSupport \
        -lQt5OpenGL \
        -lQt5Svg \
        -lvcu_apm_lib \
        -lvcu_gst_lib \
        -lvideo \
        -ldrm \
        -lgstvideo-1.0 \
        -lgstreamer-1.0 \
        -lgthread-2.0 \
        -lgobject-2.0 \
        -lglib-2.0 \
        -lmediactl \
        -lv4l2subdev


CONFIG += "release"

QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CFLAGS_RELEASE -= -O2
QMAKE_CFLAGS_RELEASE += -O3 --sysroot=${SDKTARGETSYSROOT}
QMAKE_CXXFLAGS_RELEASE += -O3 --sysroot=${SDKTARGETSYSROOT}
QMAKE_LFLAGS_RELEASE += --sysroot=${SDKTARGETSYSROOT}
QMAKE_LFLAGS_RELEASE += -Wl,-rpath-link=${SDKTARGETSYSROOT}/lib,-rpath-link=${SDKTARGETSYSROOT}/usr/lib

