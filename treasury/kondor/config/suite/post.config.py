#!/usr/bin/env python

import os
import sys
import platform
import subprocess

from os.path import join as join_path
from sys import argv

DEBUG = False


def debug(msg):
    if DEBUG:
        print "[DEBUG] " + msg


class SuitePostConfig:

    def __init__(self):
        self.machine = platform.machine()
        self.system = platform.system()

        self.kplushome3 = None
        self.suiteWorkDir = None
        self.suiteConfigRoot = None
        self.suiteKplusTpConfigRoot = None
        self.suiteKgrRoot = None

        self.applications = []

        if self.is_windows():
            self.init_windows_differing_variables(
                r"C:\Program Files\Reuters\Kplus30",
                r"C:\Program Files\Reuters\Kplus30\entities\Standalone\config\suite\work",
                r"C:\Program Files\Reuters\Kplus30\entities\Standalone\config\suite",
                r"",
                r""
            )
        else:
            self.init_windows_differing_variables(
                r"/opt/finastra/kplus-front",
                r"/opt/finastra/kplus-front/entities/Standalone/config/suite/work",
                r"/opt/finastra/kplus-front/entities/Standalone/config/suite",
                r"/opt/finastra/kplus-back",
                r""
            )

        self.userLogin = ""
        self.kplustp_navigationPath = join_path(self.suiteKplusTpConfigRoot, "resource", "xml")

        param = len(argv)

        if param > 1:
            print "SuitePostConfig - custom parameters:"
                     
            self.userLogin = argv[1]
            print "User login:", self.userLogin

            if param > 2:  
                self.kplustp_navigationPath = argv[2]
                                                                   
            print "K+TP navigation path:", self.kplustp_navigationPath

        self.javaHome = self.get_java_home()
        self.classPathXalan = self.get_classpath_xalan()

        self.xslDir = join_path(self.kplushome3, "entities", "defaultconfig", "config", "suite", "navigation")
        self.destDir = join_path(self.suiteConfigRoot, "portal", "runtime", self.userLogin)
        self.waXmlDir = join_path(self.kplushome3, "webaccess", "xml")
        self.params = []

        if not os.path.isdir(self.javaHome):
            raise EnvironmentError("JAVA_HOME is not correctly set in JKonfigure: " + self.javaHome + " not found")

    def is_sparc_sol(self):
        return self.system == "SunOS" and self.machine.startswith("sun4") # KPL-44976: platform.machine() can be sun4u or sun4v

    def is_x86_sol(self):
        return self.system == "SunOS" and self.machine == "i86pc"

    def is_linux(self):
        return self.system == "Linux"

    def is_windows(self):
        return self.system == "Windows"

    def init_windows_differing_variables(self,
                                         kplushome3,
                                         suiteWorkDir,
                                         suiteConfigRoot,
                                         suiteKplusTpConfigRoot,
                                         suiteKgrRoot):
        self.kplushome3 = kplushome3
        self.suiteWorkDir = suiteWorkDir
        self.suiteConfigRoot = suiteConfigRoot
        self.suiteKplusTpConfigRoot = suiteKplusTpConfigRoot
        self.suiteKgrRoot = suiteKgrRoot

    def get_java_home(self):
        if self.is_linux():
            return r"/usr/java/latest/jre"
        elif self.is_windows():
            return r"C:\Program Files\Java\jdk1.8.0_60"
        elif self.is_x86_sol():
            return r"/opt/jdk1.8.0_60"
        elif self.is_sparc_sol():
            return r"/opt/jdk1.8.0_60"
        else:
            raise Exception("Unknown architecture! [" + self.system + " " + self.machine + "]")

    def call_java(self, call_array):
        assert self.javaHome is not None and self.classPathXalan is not None

        java_cmd = [
            join_path(self.javaHome, "bin", "java"),
            "-cp", self.classPathXalan,
            "org.apache.xalan.xslt.Process"
        ]
        java_cmd.extend(call_array)

        debug(" ".join(java_cmd))
        subprocess.call(java_cmd)

    def create_jmsdatastore_directory(self):
        jmsdatastore_dir = join_path(self.suiteWorkDir, "jmsdatastore")

        if not os.path.exists(jmsdatastore_dir):
            os.makedirs(jmsdatastore_dir)

    @staticmethod
    def get_navigation_file_name(appliname):
        return "navigation_" + appliname + ".appliNamed.xml"

    def generate_appli_named_without_extending_arrays(self, dir, appliname):
        assert self.javaHome is not None and self.classPathXalan is not None

        in_xml = join_path(dir, "navigation.xml")
        if not os.path.isfile(in_xml):
            print "ERROR: Can't locate " + appliname + " navigation.xml"
            debug("(" + in_xml + ")")
            return False
        else:
            print "generate.appliNamed." + appliname
            self.call_java([
                    "-IN", in_xml,
                    "-XSL", join_path(self.xslDir, "appliName.xsl"),
                    "-OUT", join_path(self.suiteWorkDir, self.get_navigation_file_name(appliname)),
                    "-PARAM", appliname + "_xml_dir", dir,
                    "-PARAM", "appliName", appliname
                ])
        return True

    def generate_appli_named(self, url, dir, appliname):
            if not self.generate_appli_named_without_extending_arrays(dir, appliname):
                return
            self.params.extend(["-PARAM", "with-" + appliname, self.get_navigation_file_name(appliname)])
            self.params.extend(["-PARAM", appliname + "-url", url])
            self.applications.extend([appliname])

# CHECKERS

    def should_proceed_kplus_tp(self):
        if not os.path.isdir(self.suiteKplusTpConfigRoot):
            debug("Kplus TP Config directory not found: " + self.suiteKplusTpConfigRoot)
            return False
        return True

    def should_proceed_ksp(self):
        ksp_home = join_path(self.kplushome3, "ksp")
        if "TRUE" != "TRUE":
            debug("KSP is not enabled in settings.")
        elif not os.path.isdir(ksp_home):
            debug("KSP home directory does not exist: " + ksp_home)
        else:
            return True
        return False

    def should_proceed_kgr(self):
        if not os.path.isdir(self.suiteKgrRoot):
            debug("KGR directory not found: " + self.suiteKgrRoot)
            return False
        return True

# Regenerate navigation for w@, kplustp, ksp, kgr

    def regenerate_webaccess_navigation(self):
        self.applications = ["wa"]
        self.params = [
            "-IN", join_path(self.suiteWorkDir, "navigation_wa.appliNamed.xml"),
            "-XSL", join_path(self.xslDir, "navigationMerge.xsl"),
            "-OUT", join_path(self.destDir, "navigation.xml"),
            "-PARAM", "wa-url", r"http://webaccess:7600/webaccess"
        ]
        self.generate_appli_named_without_extending_arrays(self.waXmlDir, "wa")

    def regenerate_kplus_tp_navigation(self):
        if not self.should_proceed_kplus_tp():
            return
        url = r"http://kplus-back-web:7000/kplustp"
        self.generate_appli_named(url, self.kplustp_navigationPath, "kplustp")

    def regenerate_ksp_navigation(self):
        if not self.should_proceed_ksp():
            return
        url = r"http://ksp-web:7777/ksp"
        navigation_dir = join_path(self.kplushome3, "ksp", "webconf", "xml")
        self.generate_appli_named(url, navigation_dir, "ksp")

    def regenerate_kgr_navigation(self):
        if not self.should_proceed_kgr():
            return
        url = r"http://localhost:8084/kgr"
        navigation_dir = join_path(self.suiteKgrRoot, "gui", "xml")
        self.generate_appli_named(url, navigation_dir, "kgr")

    def regenerate_navigation_final(self):
        if not os.path.exists(self.destDir):
            os.makedirs(self.destDir)

        print "generate.navigation : " + " ".join(self.applications)
        self.call_java(self.params)

        to_remove = join_path(self.suiteWorkDir, "toremove")

        print "check.idUnicity"
        self.call_java([
                "-IN", join_path(self.destDir, "navigation.xml"),
                "-XSL", join_path(self.xslDir, "idUnicity.xsl"),
                "-OUT", to_remove
        ])

        os.remove(to_remove)

    def regenerate_navigation(self):
        # Mandatory first
        self.regenerate_webaccess_navigation()

        self.regenerate_kplus_tp_navigation()
        self.regenerate_ksp_navigation()
        self.regenerate_kgr_navigation()
        self.regenerate_navigation_final()

    def get_classpath_xalan(self):
        assert self.kplushome3 is not None

        jar_list = ["xml-resolver-1.2.jar", "xml-apis-1.3.04.jar", "xercesImpl-2.9.1.jar", "xalan-2.7.1.jar", "serializer-2.7.1.jar"]
        jar_dir = join_path(self.kplushome3, "lib", "ext", "java")
        jar_paths = []

        for jar in jar_list:
            jar_paths.extend([join_path(jar_dir, jar)])

        return os.pathsep.join(jar_paths)


def main():
    try:
        post_config = SuitePostConfig()
        post_config.create_jmsdatastore_directory()
        post_config.regenerate_navigation()
    except Exception as e:
        print "[ERROR] [SUITE] " + str(e)
        return False
    return True

if __name__ == "__main__":
    sys.exit(0 if main() else 1)
