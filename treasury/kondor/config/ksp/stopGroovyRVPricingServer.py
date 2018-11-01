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
        description="KSP Groovy RV Pricing Server stopper",
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-pricer', dest='pricerName', default=None, help='Pricer name', nargs=1)
    args = parser.parse_args()
    if args.pricerName is not None:
        pricerArgs = "-pricer " + args.pricerName[0]
    else:
        pricerArgs = ""

    if is_windows():
        # Windows
        # Find KSP Groovy RV Pricing Server processes with Windows Management Instrumentation Command-line
        cmd = "wmic process where \"CommandLine like \'%%com.reuters.ksp.groovyrvpricer.KSPGroovyRVPricingServer " \
              "-daemon tcp:kplus-front-rvd:7500 -service 6659 -network \"eth0;;\" " \
              + pricerArgs + "%%' and name like \'%%java.exe%%\'\" get ProcessID"
        wmicProcess = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        wmicProcess.stdout.readline()

        # Kill KSP Groovy RV Pricing Server processes found with taskkill
        for line in wmicProcess.stdout:
            processId = line.strip()
            if len(processId) != 0:
                print "Stopping KSP Groovy RV Pricing Server process with PID " + processId + " ..."
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
        psProcess = subprocess.Popen(psCommand, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        psProcess.stdout.readline()

        processFound = False
        for line in psProcess.stdout:
            line = line.strip()
            if len(line) == 0:
                continue
            if not 'com.reuters.ksp.groovyrvpricer.KSPGroovyRVPricingServer' in line:
                continue
            if args.pricerName is not None:
                if not pricerArgs in line:
                    continue
            splitedLine = line.split()
            if len(splitedLine) < 2:
                continue
            processFound = True
            processId = splitedLine[1]
            print "Stopping KSP Groovy RV Pricing Server process with PID " + processId + " ..."
            returncode = subprocess.call(['kill', '-9', processId])
            if 0 != returncode:
                sys.exit(returncode)
        if not processFound:
            print "No KSP Groovy RV Pricing Server process has been found"
            
if __name__ == "__main__":
   main()
