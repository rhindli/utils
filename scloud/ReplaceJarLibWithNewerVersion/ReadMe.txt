How to check if a library can be replaced with a newer version:

1. copy all jars from all projects to a folder

cd <workspacefolder>
find . \( -path ./.metadata -o -path ./dev -o -path ./XXPatch -o -path ./Utils \) -prune -o -type f -name '*.jar' -exec cp -f {} /dest/folder/to/copy/to \;

This will copy all jars except those from .metadata, dev, XXPatch, Utils projects to /dest/folder/to/copy/to folder

Note1: /dest/folder/to/copy/to must be previously created
Note2: You may add other projects to exclude copying jars from them.

e.g.
cd ~/dev/workspace/scloud
find . \( -path ./.metadata -o -path ./dev -o -path ./XXPatch -o -path ./Utils \) -prune -o -type f -name '*.jar' -exec cp -f {} ~/dev/tmp/jars2 \;

2. Remove from copied jars the following jars:
apps-marketplace.jar
capi_core.jar
capi_war.jar
core-api.jar
core-business.jar
core-framework.jar
gwt-*.jar
jclient.jar
lib-1.0.jar
lib.jar
server.jar
soweb.jar
test-api.jar

3. Run JarAnalyzer for the jars folder

cd <JarAnalyzer folder>
./runxmlsummary.sh

When prompted for parameters fill in the following:\

Please enter input directory name: /path/to/the/jars/folder/created/at/step/1
Please enter output file name: path/to/the/file/that/will/be/created

This will create an xml file with all the dependencies between jars.

Note: runxmlsummary.sh is not in the original archive of JarAnalyzer. It was created manually and added to the archive. Take care in case you get a newer version of JarAnalyzer.

4. For the library to be replaced with a newer version run japi-compliance-checker to see if the new version is compatible with the old one

cd <japi-compliance-checker folder>
./japi-compliance-checker old.jar new.jar

The report will be created as a html file in <japi-compliance-checker folder>/compat_reports/

If there are no changes that could cause incompatibility library can be replaced.
If there are changes that could cause incompatibilities we need to check further; 

5. Open the xml created by JarAnalyzer and look for the old library jar entry.
For each jar in the IncomingDependencies section we need to check whether the new jar version can be used.

Follow these steps for each jar in the IncomingDependencies section:

5.1. Copy to a separate folder the jar file
5.2. In the xml created by JarAnalyzer look for this jar entry and find its OutgoingDependencies jars. 
     Copy all of them except the jar library to be replaced by a new version, to the same folder where you copied the jar file at previous point 5.1.
5.3. Copy the new version of the library to the same folder
5.4. Edit the build.xml file from animal_sniffer folder and set the following properties:

     <property name="workdir" value="path/to/folder/from/point/5.1"/>
     <property name="appjar" value="${workdir}/<IncomingDependencyJarFile>.jar"/>

     Note: You might need to update the first time also the path to animal-sniffer-ant-tasks-1.16.jar that is located in the animal_sniffer folder

5.5. Run the build.xml file using ant

     cd <folder from point 5.1>
     ant check-lib-signatures

     If run is successful the you can replace the library with the new version.

