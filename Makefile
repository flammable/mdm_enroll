USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
TITLE=mdm_enroll
REVERSE_DOMAIN=com.domain
PB_EXTRA_ARGS+= --sign "Developer ID Installer: Your Organization (12345ABCDE)"
PACKAGE_VERSION=1.1.6
PAYLOAD=\
	l_tmp\
	pack-enrollment_profile\
	pack-script-postinstall

l_tmp: l_root
	@sudo mkdir -p ${WORK_D}/tmp/profiles
	@sudo chown -R root:wheel ${WORK_D}/tmp/profiles
	@sudo chmod -R 755 ${WORK_D}/tmp/profiles

pack-enrollment_profile:
	@sudo ${CP} ./profiles/sample.mobileconfig ${WORK_D}/tmp/profiles/sample.mobileconfig

munkiimport: pkg
		munkiimport \
--nointeractive \
--subdirectory scripts \
--name "${TITLE}" \
--displayname "MDM Enrollment" \
--description "Enrolls this Mac into Your Org's Mobile Device Management server." \
--category "Scripts" \
--developer "Your Organization" \
--minimum_os_version "10.7.0" \
--unattended_install \
--installcheck_script "./munki_installcheck_script.sh" \
--requires "IAs_preflight_file.txt" \
"${PACKAGE_FILE}"