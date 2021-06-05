module test

import password

fn test_password_matches_encrypted_one() {
	matched := password.matches("$2y$04$/UaJ09dDxkYVBn8e7avyPO8jYzofgrM1Al0BUW7fEg0xMfl/kJ5Ru", "foo") or { false }

	assert matched
}
