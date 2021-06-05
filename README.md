# password

Password hashing and verification for V.

## Summary

- [About](#about)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Examples](#examples)
- [Test](#test)

## About

I created this library because I need to make an authentication system for my web app. This library should remain temporary until [vlang/libsodium](https://github.com/vlang/libsodium) supports password hashing and verification.

## Features

- Can hash password
- Can verify if a password matches a hashed password
- Uses bcrypt
- Can control the entropy (more entropic means more CPU time to compute the hash) when hasing a password
- Automatically salt the password (so never 2 same hashes for 2 same passwords)
- Uses Apache's [htpasswd](https://httpd.apache.org/docs/2.4/fr/programs/htpasswd.html) commands internally

## Requirements

- `htpasswd` executable (included in **apache2-utils** package in various Linux based OS)

## Installation

```v
v install khalyomede.password
```

## Examples

- [1. Hash a password](#1-hash-a-password)
- [2. Verify a password matches a hashed password](#2-verify-a-password-matches-a-hashed-password)
- [3. Increase the entropy when hashing a password](#3-increase-the-entropy-when-hashing-a-password)

### 1. Hash a password

In this example, we will hash a password (good to be stored in your storage place like a database).

```v
import khalyomede.password

fn main() {
  hashed_password := password.hash("mypassword", 5) or {
    panic(err)
  }

  println(hashed_password)
}
```

```
$2y$04$48a6fVykURq6eeOOXbrC3enLaDQEaO45akOdRu9hmnC0YGn25C4x6
```

### 2. Verify a password matches a hashed password

In this example, we will check that a previously hashed password matches a clear password.

```v
import khalyomede.password

fn main() {
  hashed_password := password.hash("mypassword", 5) or {
    panic(err)
  }

  matched := password.matches(hashed_password, "mypassword") or {
    panic(err)
  }

  if matched {
    println("password matched")
  } else {
    println("password did not matched")
  }
}
```

```
password matched
```

### 3. Increase the entropy when hashing a password

In this example, we will use the entropy option of [htpasswd](https://httpd.apache.org/docs/2.4/en/programs/htpasswd.html) executable to stenghten it against brute-force attacks.

The second option of `password.hash()` takes an integer between 4 and 17 according to the "-C" option of the documentation of htpasswd. Using a high entropy will result in a slower computation time, but will increase the strength of the password.

```v
import khalyomede.password

fn main() {
  hashed_password := password.hash("mypassword", 17) or {
    panic(err)
  }
}
```

## Test

```v
v test .
```
