module password

import os

pub fn matches(hashed_password string, password string) ?bool {
	path := os.join_path(os.temp_dir(), "password")

	os.write_file(path, ':$hashed_password') ?

	escaped_password := password.replace('"', '\\"')

	result := os.execute('htpasswd -vb $path "" "$escaped_password"')

	println('result of command: {$result.output}')

	return result.exit_code == 0
}
