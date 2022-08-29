#This script is very hardcoded for use in certain bats. The aforementioned .bats are: "set_module_branch", "set_local_unity_packages" and "set_remote_unity_packages"

from pathlib import Path
import sys
import re
if(len(sys.argv) != 4):
    print('Error - Could not execute pythonscript.\nThis script needs 3 parameters:  "relative Path To File", "keyword to replace line", "Stringreplacement for that line"')
    print('Parameters given: ', len(sys.argv) -1 )
    for arg in sys.argv:
        print('Parameter: ',arg)
    quit()


path = sys.argv[1]
#Keyword for gitmodules is %branch% and keyword for manifest are the specific modulenames: %de.dfki.mmiunity-core% and %de.dfki.mmiunity-targetengine%
keyword = sys.argv[2]
replacement = sys.argv[3]

newlines = []

with open(path, 'r') as file: 
    for line in file.readlines():
        if keyword in line:
            # Replace anything which comes after '=' for .gitmodules and anything which comes after ': "' for manifest.json 

            if '=' in line:
                strsplit = line.split('=', 1)
                strsplit[1] = replacement
                newline = strsplit[0] + '= ' + strsplit[1]
                if(line != newline):
                    print('Successfully changed\n', line, '\nto\n', newline)
                else: 
                    print("No changes needed for:\n", line)
            else:
                strsplit = line.split(':', 1)

                #Change possbile backslashes in replacement to slashes.
                replacement = replacement.replace('\\', '/')
                strsplit[1] = replacement
                newline = strsplit[0] + ': "' + strsplit[1] + '",\n'
                if(line != newline):
                    print('Successfully changed\n', line, '\nto\n', newline)
                else: 
                    print("No changes needed for:\n", line)


            newlines.append(newline)
        
        else:
            newlines.append(line)

with open(path, 'w') as file: 
    for line in newlines:
        file.write(line)

