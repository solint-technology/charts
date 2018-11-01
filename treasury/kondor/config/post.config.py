#!/usr/bin/env python
# This script is called at the end of JKonfigure
# See call in svn://rfssvn/kplus-front/trunk/install/entities/defaultconfig/JKonfigure.winnt.profile

import os
import sys
import tarfile
import subprocess
import shutil
import unzipTomcat


KPLUSHOME3 = None
ENTITY_DIR = None
ENTITY_CONFIG_DIR = None
SUITE_CONFIG_ROOT = None


def is_windows():
    return sys.platform == "win32"


def extract_entity_dirs():
    print "Copying entity fixed files..."
    tar = tarfile.open(os.path.join(KPLUSHOME3, "entities", "defaultconfig", "new_entity_dirs.tar"))
    tar.extractall(path=ENTITY_DIR)
    tar.close()
    sys.stdout.flush()


def copy_ksp_env():
    print "Deploying ksp_env.sh"
    src = os.path.join(ENTITY_CONFIG_DIR, "ksp", "ksp_env.ksh")
    dst = os.path.join(ENTITY_DIR, "env")
    shutil.copy(src, dst)
    sys.stdout.flush()


def run_suite_post_config():
    print "Running Suite post.config.py..."
    suite_post_config_script = os.path.join(SUITE_CONFIG_ROOT, "post.config.py")
    subprocess.call(suite_post_config_script, shell=True)
    sys.stdout.flush()


def install_tomcat():
    unzipTomcat.main()
    sys.stdout.flush()


def main():
    global KPLUSHOME3
    global ENTITY_DIR
    global ENTITY_CONFIG_DIR
    global SUITE_CONFIG_ROOT

    if is_windows():
        KPLUSHOME3 = r"C:\Program Files\Reuters\Kplus30"
        ENTITY_DIR = r"C:\Program Files\Reuters\Kplus30\entities\Standalone"
        ENTITY_CONFIG_DIR = r"C:\Program Files\Reuters\Kplus30\entities\Standalone\config"
        SUITE_CONFIG_ROOT = r"C:\Program Files\Reuters\Kplus30\entities\Standalone\config\suite"
    else:
        KPLUSHOME3 = r"/opt/finastra/kplus-front"
        ENTITY_DIR = r"/opt/finastra/kplus-front/entities/Standalone"
        ENTITY_CONFIG_DIR = r"/opt/finastra/kplus-front/entities/Standalone/config"
        SUITE_CONFIG_ROOT = r"/opt/finastra/kplus-front/entities/Standalone/config/suite"

    extract_entity_dirs()
    copy_ksp_env()
    install_tomcat()

    run_suite_post_config()
    print "Post config done."

if __name__ == '__main__':
    main()
