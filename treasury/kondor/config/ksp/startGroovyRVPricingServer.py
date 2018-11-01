#!/usr/bin/env python

import argparse
import os
import platform
import subprocess
import sys

def is_windows():
    return sys.platform == "win32"

def is_sparc_sol():
    return platform.system() == "SunOS" and platform.machine().startswith("sun4") # KPL-44976: platform.machine() can be sun4u or sun4v

def is_x86_sol():
    return platform.system() == "SunOS" and platform.machine() == "i86pc"

def is_linux():
    return platform.system() == "Linux"

def main():
    # Parsing command line arguments
    parser = argparse.ArgumentParser(
        description="KSP Groovy RV Pricing Server",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Usage:")
    parser.add_argument('-debug',       dest='debug',       action='store_const', const=True, default=False, help='Debug mode')
    parser.add_argument('-distributed', dest='distributed', action='store_const', const=True, default=False, help='Distributed mode')
    parser.add_argument('-pricer',      dest='pricerName',                                    default=None,  help='Pricer name', nargs=1)
    args = parser.parse_args()
    complianceAdditionalArgs = []
    if args.pricerName is not None:
        complianceAdditionalArgs.append("-pricer")
        complianceAdditionalArgs.append(args.pricerName[0])
    if args.debug:
        complianceAdditionalArgs.append("-debug")
    if args.distributed:
        complianceAdditionalArgs.append("-distributed")

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

    # Path to the Groovy RV Pricing Server jar and its dependencies
    javaClassPath = os.path.join(kplusHome3, "ksp", "GroovyDependencies", "ksp-groovy-rv-pricer.jar") + os.pathsep + \
                    os.path.join(kplusHome3, "lib", "ext", "java", "tibrv-8.4.4.jar")
    # Set JVM options
    jvmOpts = "-d64"

    # Start Groovy RV Pricing Server
    cmd = [javaPath, jvmOpts, "-Djava.library.path=" + javaLibraryPath, "-classpath", javaClassPath, "com.reuters.ksp.groovyrvpricer.KSPGroovyRVPricingServer",
          "-daemon", "tcp:kplus-front-rvd:7500", "-service", "6659", "-network", "eth0;;"]
    cmd.extend(complianceAdditionalArgs)
    print "cmd: " + str(cmd)
    subprocess.call(cmd)

if __name__ == "__main__":
   main()
