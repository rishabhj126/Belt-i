#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/vikasnew/hackference_ws/src/camera_calibration"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/vikasnew/hackference_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/vikasnew/hackference_ws/install/lib/python2.7/dist-packages:/home/vikasnew/hackference_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/vikasnew/hackference_ws/build" \
    "/usr/bin/python" \
    "/home/vikasnew/hackference_ws/src/camera_calibration/setup.py" \
    build --build-base "/home/vikasnew/hackference_ws/build/camera_calibration" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/vikasnew/hackference_ws/install" --install-scripts="/home/vikasnew/hackference_ws/install/bin"
