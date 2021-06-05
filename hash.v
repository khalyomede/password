module password

import os

pub fn hash(password string, force int) ?string {
	escaped_password := password.replace('"', '\\"')

	if force < 4 || force > 17 {
		return error("Expected argument 2 to be between 4 and 17 (learn more by browsing the -C option: https://httpd.apache.org/docs/2.4/en/programs/htpasswd.html).")
	}

	result := os.execute('htpasswd -bBnC $force "" "$escaped_password"')

	if result.exit_code != 0 {
		return error("Error while hashing password (${result.output}).")
	}

	return result.output.replace(":", "")
}
