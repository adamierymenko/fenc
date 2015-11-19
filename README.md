fenc: a utility to just f~~ucking~~ully encrypt a file
======

**"Because sometimes you just want to f~~ucking~~ully encrypt a file."**

I wrote this as a short big of rage coding because I was working on some stuff on an air gapped machine and I just wanted to f~~ucking~~ully encrypt a file with a simple passphrase to safely store it in a repo for transfer back into dangerousland.

It turns out that f~~ucking~~ully encrypting a file from the command line is a remarkable pain. I had GPG, but I didn't want to encrypt to someone's public key with a bunch of RSA crap. I just wanted to f~~ucking~~ully encrypt a file with a simple ~~fucking~~ passphrase. You can do this with GPG but the arguments are ~~fucking~~ confusing. I used "--symmetric" and everything seemed okay but it turns out that by default this also generates a ~~fucking~~ key that I don't want and also seems to encrypt to that key and WTF and I give up ~~fuck it~~. It's also possible to ~~just encrypt a goddamn fucking file~~ with OpenSSH's command line utility but this is also confusing and when I go to decrypt it I'll probably have the key but I'll forget the exact ~~goddamn fucking~~ command line arguments I used for OpenSSH so I'll never be able to recover my ~~fucking~~ data.

All I wanted to do was to f~~ucking~~ully encrypt a file from the command line, so I broke down and wrote a ~~fucking~~ C program to do it.

### Usage

It's a tiny C program so just type *make* to build or:

    cc -O -o fenc fenc.c

It has no dependencies so it will build anywhere.

Using a key stored in a file:

    fenc e file-with-key plaintext ciphertext
    fenc d file-with-key ciphertext plaintext

Using a key on the command line:

    fenc e '!s00pers3kret' plaintext ciphertext
    fenc d '!s00pers3kret' ciphertext plaintext

Piping:

    cat /some/file | fenc e '!foo' >>bar
    cat bar | fenc d '!foo' >>baz

*Warning: using a key on the command line is often unsafe since it might get saved to your history. If you do this symlink your history to /dev/null and be aware of what you are doing. But I won't stop you because I don't think you are an idiot.*

### Internals

This program uses ~~Gandalf the White~~Daniel Bernstein's excellent Salsa20 encryption algorithm to just ~~fucking~~ encrypt a file. It reads from an input file or STDIN and writes to an output file or STDOUT. It does not support any complicated advanced features because if I wanted that I would ~~get a fucking Ph.D in~~ learn GPG's command line arguments.

The key is read from a file or from the command line (see security section below) and is then hashed by being self-encrypted with Salsa20. Then a random 64-bit IV is generated and is prepended to the output. At the end a checksum is encrypted and written so you can tell if you got the key right on decrypt.

It's only 323 lines of C code and should compile on almost anything. It's missing code to generate a good random IV on Windows, so if someone wants to build it there they can do a ~~fucking~~ pull request and add it.

### Security

Security is probably pretty good. It's tiny and simple so there's not a lot of bug surface area. It uses 256-bit keys and a well-regarded modern algorithm.

Using a simple checksum for authentication would be bad if this were a network protocol since it would make it vulnerable to oracle attacks, but this is just for simple one-off encryption of files. Brute force oracle attacks aren't practical here unless you're using it as part of some kind of interactive API that someone can hammer all day ~~in which case you are a dumb shit.~~

A 64-bit random IV is used to make the key stream unique, so technically it's okay to use the same key more than once for different files. This also means that encrypting the same data multiple times with the same key will yield different results, so if you see this it's a feature not a bug.

### Warranty

None. This is for doing stuff like encrypting your AWS secrets to put them in a private repo, not for classified war plans or pics of dead aliens from Roswell.

### License

2-clause BSD, so do whatever you want with it.
