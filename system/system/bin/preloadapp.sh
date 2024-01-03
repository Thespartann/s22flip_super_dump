#!/system/bin/sh

PRELOAD_FLAG=/data/app/.preload_done
PRELOAD_SOURCE=/system/preloadapp/*/*.apk

if [ ! -f ${PRELOAD_FLAG} ]; then
    for apk in $PRELOAD_SOURCE
    do
        /system/bin/pm install $apk
        echo "install $apk" >> ${PRELOAD_FLAG}
    done
    echo "done" >> ${PRELOAD_FLAG}
else
    for apk in $PRELOAD_SOURCE
    do
        if [ `grep -c "$apk" ${PRELOAD_FLAG}` -eq '0' ]; then
            /system/bin/pm install $apk
            echo "install $apk" >> ${PRELOAD_FLAG}
        fi
    done
fi
