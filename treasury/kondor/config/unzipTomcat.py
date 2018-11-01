#!/usr/bin/env python

import os
import sys
import stat
import zipfile
import shutil
import glob
import contextlib


def is_windows():
	return sys.platform == "win32"


class TomcatInstallation:

	def __init__(self):
		self.KPLUSHOME3 = r"C:\Program Files\Reuters\Kplus30" if is_windows() else r"/opt/finastra/kplus-front"
		self.TOMCAT_HOME_DIR = r"C:\Program Files\Tomcat" if is_windows() else r"/opt/finastra/kplus-front/3rdparties/tomcat"
		self.tomcat_installer_dir = os.path.join(self.KPLUSHOME3, "3rdparties", "installers", "tomcat")
		self.tomcat_archive = None

	def is_already_installed(self):
		if os.path.isdir(self.TOMCAT_HOME_DIR):
			print "Previous " + self.TOMCAT_HOME_DIR + " exists => skip."
			return True
		return False

	def unzip(self):
		if not os.path.isdir(self.tomcat_installer_dir):
			raise RuntimeError(self.tomcat_installer_dir + " does not exist")

		tomcat_file_pattern = 'apache-tomcat-' + '*' + ".zip"

		tomcat_installer_pattern = os.path.join(self.tomcat_installer_dir, tomcat_file_pattern)
		tomcats = glob.glob(tomcat_installer_pattern)

		if len(tomcats) != 1:
			raise RuntimeError("Incorrect content of directory: " + self.tomcat_installer_dir)

		self.tomcat_archive = tomcats[0]

		print "Tomcat archive " + self.tomcat_archive + " found"
		print "Tomcat archive " + self.tomcat_archive + " will be uncompressed to " + self.TOMCAT_HOME_DIR

		os.makedirs(self.TOMCAT_HOME_DIR)

		print "------ starting Tomcat archive extraction ... ---------"
		with contextlib.closing(zipfile.ZipFile(self.tomcat_archive)) as zf:
		    zf.extractall(self.TOMCAT_HOME_DIR)


	def install_into_target_directory(self):
		extracted_tomcat_dir_list = glob.glob(os.path.join(self.TOMCAT_HOME_DIR, "*tomcat*"))
		if len(extracted_tomcat_dir_list) != 1:
			raise RuntimeError("can t find tomcat unzipped while processing unzip => skip tomcat installation")

		extracted_tomcat_dir = extracted_tomcat_dir_list[0]

		# Move files from <TOMCAT_HOME_DIR>/apache-tomcat-XYZ/ to <TOMCAT_HOME_DIR>/
		# and remove empty directory <TOMCAT_HOME_DIR>/apache-tomcat-XYZ
		for elem in glob.glob(os.path.join(extracted_tomcat_dir, '*')):
			shutil.move(elem, self.TOMCAT_HOME_DIR)

		os.rmdir(extracted_tomcat_dir)

	def chmod_executables(self):
		# chmod +x on <TOMCAT_HOME_DIR>/bin
		for binFile in glob.glob(os.path.join(self.TOMCAT_HOME_DIR, 'bin', '*')):
			current_mode = os.stat(binFile).st_mode
			os.chmod(binFile, current_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

	def print_summary(self):
		print "Tomcat archive " + self.tomcat_archive + " uncompressed as " + self.TOMCAT_HOME_DIR
		print "------ ... end Tomcat archive extraction -----------"
		print "------ ... end Tomcat install -----------"


def main():
	tomcat_installation = TomcatInstallation()

	if tomcat_installation.is_already_installed():
		return True
	try:
		tomcat_installation.unzip()
		tomcat_installation.install_into_target_directory()
		tomcat_installation.chmod_executables()
		tomcat_installation.print_summary()
	except Exception as E:
		print "[ERROR] [TOMCAT] " + str(E)
		return False
	return True


if __name__ == '__main__':
	sys.exit(0 if main() else 1)
