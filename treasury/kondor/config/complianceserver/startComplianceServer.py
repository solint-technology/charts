#!/usr/bin/env python

import argparse
import os
import platform
import subprocess
import sys

# External jar list. This list is duplicated in install/common/java/starterconfigs/complianceserverstart.properties
externalClassPath = [
    'action-1.0.jar',
    'commons-collections-3.2.1.jar',
    'commons-configuration-1.6.jar',
    'commons-dbcp-1.4.jar',
    'commons-lang-2.6.jar',
    'commons-logging-1.1.1.jar',
    'commons-pool-1.5.4.jar',
    'jackson-core-asl-1.9.5.jar',
    'jackson-mapper-asl-1.9.5.jar',
    'jtds-1.2.5.jar',
    'kondor-security-cipher-10.01.000.jar',
    'log4j-1.2.16.jar',
    'tibrv-8.4.4.jar']

def is_windows():
    return sys.platform == "win32"

def is_sparc_sol():
    return platform.system() == "SunOS" and platform.machine().startswith("sun4") # KPL-44976: platform.machine() can be sun4u or sun4v

def is_x86_sol():
    return platform.system() == "SunOS" and platform.machine() == "i86pc"

def is_linux():
    return platform.system() == "Linux"

def main():
    parser = argparse.ArgumentParser(
        description="Compliance Server starter",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Usage:")
    args = parser.parse_args()

    # Set Kplus home installation path
    if is_windows():
        kplusHome3 = os.path.abspath(r"C:\Program Files\Reuters\Kplus30")
    else:
        kplusHome3 = os.path.abspath(r"/opt/finastra/kplus-front")

    # Set Java home installation path
    if is_windows():
        javaPath = os.path.join(r"C:\Program Files\Java\jdk1.8.0_60", "bin", "java.exe")
        archFolder = "win"
        libFolder = "lib64"
    elif is_sparc_sol():
        javaPath = os.path.join(r"/opt/jdk1.8.0_60", "bin", "java")
        archFolder = "sun4sol"
        libFolder = "lib"
    elif is_x86_sol():
        javaPath = os.path.join(r"/opt/jdk1.8.0_60", "bin", "java")
        archFolder = "sol"
        libFolder = "lib64"
    elif is_linux():
        javaPath = os.path.join(r"/usr/java/latest/jre", "bin", "java")
        archFolder = "lin"
        libFolder = "lib64"

    # JAVA library path and system LD_LIBRARY_PATH
    javaLibraryPath = os.path.join(kplusHome3, libFolder, "ext", archFolder)
    print "javaLibraryPath: " + javaLibraryPath
    if is_windows():
        os.environ['PATH'] = javaLibraryPath + os.pathsep + os.environ['PATH']
        print "PATH: " + os.environ['PATH']
    else:
        os.environ['LD_LIBRARY_PATH'] = javaLibraryPath + os.pathsep + os.environ['LD_LIBRARY_PATH']
        print "LD_LIBRARY_PATH: " + os.environ['LD_LIBRARY_PATH']

    # Path to the ComplianceServer jar and its dependencies
    libExtJava = os.path.join(kplusHome3, "lib", "ext", "java")
    javaClassPath = None
    for jar in externalClassPath:
        if javaClassPath:
            javaClassPath = javaClassPath + os.pathsep + os.path.join(libExtJava, jar)
        else:
            javaClassPath = os.path.join(libExtJava, jar)
    javaClassPath = javaClassPath + os.pathsep + \
        os.path.join(kplusHome3, "api", "lib", "java", "compliance", "*")      + os.pathsep + \
        os.path.join(kplusHome3, "api", "lib", "java", "okapi", "*")           + os.pathsep + \
        os.path.join(kplusHome3, "lib", "int", "java", "kondor-services", "*") + os.pathsep + \
        os.path.join(kplusHome3, "lib", "int", "java", "compliance", "*")
    
    # Start Compliance Server (optionaly we could add -d64)
    cmd = [javaPath, "-Djava.library.path=" + javaLibraryPath, "-classpath", javaClassPath, "com.trmsys.compliance.server.ServerMain"]
    print "cmd: " + str(cmd)
    subprocess.call(cmd)

if __name__ == "__main__":
   main()
