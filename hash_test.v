module test

import password

fn test_hash_returns_different_password() {
	assert password.hash("foo", 4) or { "foo" } != "foo"
}
