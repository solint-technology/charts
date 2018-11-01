#!/usr/bin/env python

import argparse
import subprocess
import sys
import os

def is_windows():
    return sys.platform == "win32"

def main():
    # Parsing command line arguments
    parser = argparse.ArgumentParser(
        description="Compliance Server stopper",
        formatter_class=argparse.RawDescriptionHelpFormatter)
    args = parser.parse_args()

    if is_windows():
        # Windows
        # Find Compliance Server processes with Windows Management Instrumentation Command-line
        cmd = "wmic process where \"CommandLine like \'%%com.trmsys.compliance.server.ServerMain" \
              + "%%' and name like \'%%java.exe%%\'\" get ProcessID"
        wmicProcess = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        wmicProcess.stdout.readline()

        # Kill Compliance Server processes found with taskkill
        for line in wmicProcess.stdout:
            processId = line.strip()
            if len(processId) != 0:
                print "Stopping Compliance Server process with PID " + processId + " ..."
                cmdTaskKill = "taskkill /f /pid " + processId
                returncode = subprocess.call(cmdTaskKill)
                if 0 != returncode:
                    sys.exit(returncode)

        wmicProcess.communicate()
        returncode = wmicProcess.returncode
        if 0 != returncode:
            sys.exit(returncode)
    else:
        # Unix
        psCommand = ['ps', 'auxww']
        if os.path.exists('/usr/ucb/ps'):
            # Solaris
            psCommand = ['/usr/ucb/ps', 'auxww']

        processFound = False
        psProcess = subprocess.Popen(psCommand, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        psProcess.stdout.readline()
        for line in psProcess.stdout:
            line = line.strip()
            if len(line) == 0:
                continue
            if not 'com.trmsys.compliance.server.ServerMain' in line:
                continue
            splitedLine = line.split()
            if len(splitedLine) < 2:
                continue
            processFound = True
            processId = splitedLine[1]
            print "Stopping Compliance Server process with PID " + processId + " ..."
            returncode = subprocess.call(['kill', '-9', processId])
            if 0 != returncode:
                sys.exit(returncode)
        if not processFound:
            print "No Compliance Server process has been found"

if __name__ == "__main__":
   main()
