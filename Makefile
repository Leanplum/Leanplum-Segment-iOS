####################################################################
#
# Rules used to build and release the SDK.
#
####################################################################

# Updates the version in the 3rd line of the header files with the version specified in sdk-version.txt.
# Example: Leanplum Segment iOS Integration Version 1.1.4.
updateVersion:
	sed -i '' -e "3 s/Version .*/Version `cat sdk-version.txt`/g" "./LeanplumSegment/Classes/SEGLeanplumIntegration.h"
	sed -i '' -e "3 s/Version .*/Version `cat sdk-version.txt`/g" "./LeanplumSegment/Classes/SEGLeanplumIntegrationFactory.h"

# Adds the headers files with the updated version; Commit; Tag; Push;
tagCommit:
	git add LeanplumSegment/Classes/SEGLeanplumIntegration.h; git add LeanplumSegment/Classes/SEGLeanplumIntegrationFactory.h; git commit -am 'update version'; git tag `cat sdk-version.txt`; git push; git push origin `cat sdk-version.txt`

# Pushes to Cocoapods using trunk
pushPod: 
	./push.sh;

deploy: updateVersion tagCommit pushPod