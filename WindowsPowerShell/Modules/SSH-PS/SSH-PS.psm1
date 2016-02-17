<#
.SYNOPSIS
A set of functions for dealing with SSH connections from PowerShell, using portable OpenSSH for Windows.

See further information at:
https://github.com/PowerShell/Win32-OpenSSH

Copyright (c) 2015, Michael Millar.
All rights reserved.
Author: Michael Millar

.DESCRIPTION
See:
Connect-SSHSession
New-SSHKey
Connect-SFTPSession
#>

# Resolve full path to script directory

$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Begin Function block

function Connect-SSHSession {
<#
.SYNOPSIS
Creates SSH sessions to remote SSH-compatible hosts, such as Linux or Unix computers or network equipment. You can later issue commands to be executed on one or more of these hosts.

.DESCRIPTION
SSH is a program for logging into a remote machine and for executing commands on a remote machine. It is intended to replace rlogin and rsh, and provide secure encrypted communications between two untrusted hosts over an insecure network. X11 connections and arbitrary TCP ports can also be forwarded over the secure channel. SSH connects and logs into the specified hostname (with optional user name). The user must prove his/her identity to the remote machine using one of several methods depending on the protocol version used. If command is specified, it is executed on the remote host instead of a login shell.

.SYNTAX
Get-SSHSession [[-1246AaCfgKkMNnqsTtVvXxYy] <user@foo>]

.PARAMETER 1246AaCfgKkMNnqsTtVvXxYy

-1
Optional. Forces SSH to try protocol version 1 only.

-2
Optional. Forces SSH to try protocol version 2 only.

-4
Optional. Forces SSH to use IPv4 addresses only.

-6
Optional. Forces SSH to use IPv6 addresses only.

-A
Optional. Enables forwarding of the authentication agent connection. This can also be specified on a per-host basis in a configuration file. Agent forwarding should be enabled with caution.  Users with the ability to bypass file permissions on the remote host (for the agent's Unix-domain socket) can access the local agent through the forwarded connection. An attacker cannot obtain key material from the agent, however they can perform operations on the keys that enable them to authenticate using the identities loaded into the agent.

-a
Optional. Disables forwarding of the authentication agent connection.

-b
Optional. Use bind_address on the local machine as the source address of the connection. Only useful on systems with more than one address.

-C
Optional. Requests compression of all data (including stdin, stdout, stderr, and data for forwarded X11 and TCP connections). The compression algorithm is the same used by gzip(1), and the "level" can be controlled by the CompressionLevel option for protocol version 1. Compression is desirable on modem lines and other slow connections, but will only slow down things on fast networks. The default value can be set on a host-by-host basis in the configuration files; see the Compression option.

-c
Optional. Selects the cipher specification for encrypting the session. Protocol version 1 allows specification of a single cipher. The supported values are "3des", "blowfish", and "des". 3des (triple-des) is an encrypt-decrypt-encrypt triple with three different keys. It is believed to be secure. blowfish is a fast block cipher; it appears very secure and is much faster than 3des.  des is only supported in the SSH client for interoperability with legacy protocol 1 implementations that do not support the 3des cipher.  Its use is strongly discouraged due to cryptographic weaknesses. The default is "3des". For protocol version 2, cipher_spec is a comma-separated list of ciphers listed in order of preference.  The supported ciphers are: 3des-cbc, aes128-cbc, aes192-cbc, aes256-cbc, aes128-ctr, aes192-ctr, aes256-ctr, arcfour128, arcfour256, arcfour, blowfish-cbc, and cast128-cbc.

-D
Optional. Specifies a local "dynamic" application-level port forwarding. This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine.  Currently the SOCKS4 and SOCKS5 protocols are supported, and SSH will act as a SOCKS server. Only root can forward privileged ports. Dynamic port forwardings can also be specified in the configuration file. IPv6 addresses can be specified with an alternative syntax: [bind_address/]port or by enclosing the address in square brackets. Only the system administrator can forward privileged ports. By default, the local port is bound in accordance with the GatewayPorts setting. However, an explicit bind_address may be used to bind the connection to a specific address. The bind_address of "localhost" indicates that the listening port be bound for local use only, while an empty address or '*' indicates that the port should be available from all interfaces.

-e
Optional. Sets the escape character for sessions with a pty (default: '~'). The escape character is only recognized at the beginning of a line. The escape character followed by a dot ('.') closes the connection; followed by control-Z suspends the connection; and followed by itself sends the escape character once. Setting the character to "none" disables any escapes and makes the session fully transparent.

-F
Optional. Specifies an alternative per-user configuration file. If a configuration file is given on the command line, the system-wide configuration file will be ignored. The default for the per-user configuration file is ~/.ssh/config.

-f
Optional. Requests SSH to go to background just before command execution. This is useful if SSH is going to ask for passwords or passphrases, but the user wants it in the background. This implies -n. The recommended way to start X11 programs at a remote site is with something like SSH -f host xterm.

-g
Optional. Allows remote hosts to connect to local forwarded ports.

-I
Optional. Specify the device SSH should use to communicate with a smartcard used for storing the user's private RSA key. This option is only available if support for smartcard devices is compiled in (default is no support).

-i
Optional. Selects a file from which the identity (private key) for RSA or DSA authentication is read. The default is ~/.ssh/identity for protocol version 1, and ~/.ssh/id_rsa and ~/.ssh/id_dsa for protocol version 2. Identity files may also be specified on a per-host basis in the configuration file. It is possible to have multiple -i options (and multiple identities specified in configuration files).

-k
Optional. Disables forwarding (delegation) of GSSAPI credentials to the server.

-L
Optional. Specifies that the given port on the local (client) host is to be forwarded to the given host and port on the remote side. This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address. Whenever a connection is made to this port, the connection is forwarded over the secure channel, and a connection is made to host port hostport from the remote machine. Port forwardings can also be specified in the configuration file. IPv6 addresses can be specified with an alternative syntax: [bind_address/]port/host/hostport or by enclosing the address in square brackets. Only the system administrator can forward privileged ports. By default, the local port is bound in accordance with the GatewayPorts setting. However, an explicit bind_address may be used to bind the connection to a specific address. The bind_address of "localhost" indicates that the listening port be bound for local use only, while an empty address or '*' indicates that the port should be available from all interfaces.

-l
Optional. Specifies the user to log in as on the remote machine. This also may be specified on a per-host basis in the configuration file.

-M
Optional. Places the SSH client into "master" mode for connection sharing. Multiple -M options places SSH into "master" mode with confirmation required before slave connections are accepted.

-m
Optional. Additionally, for protocol version 2 a comma-separated list of MAC (message authentication code) algorithms can be specified in order of preference. See the MACs keyword for more information.

-N
Optional. Do not execute a remote command.  This is useful for just forwarding ports (protocol version 2 only).

-n
Optional. Redirects stdin from /dev/null (actually, prevents reading from stdin). This must be used when SSH is run in the background. A common trick is to use this to run X11 programs on a remote machine. For example, SSH -n shadows.cs.hut.fi emacs & will start an emacs on shadows.cs.hut.fi, and the X11 connection will be automatically forwarded over an encrypted channel. The SSH program will be put in the background. (This does not work if SSH needs to ask for a password or passphrase; see also the -f option.)

-O
Optional. Control an active connection multiplexing master process.	When the -O option is specified, the ctl_cmd argument is interpreted and passed to the master process. Valid commands are: "check" (check that the master process is running) and "exit" (request the master to exit).

-o
Optional. Can be used to give options in the format used in the configuration file. This is useful for specifying options for which there is no separate command-line flag. Options include: AddressFamily, BatchMode, BindAddress, ChallengeResponseAuthentication, CheckHostIP, Cipher, Ciphers, ClearAllForwardings, Compression, CompressionLevel, ConnectionAttempts, ConnectTimeout, ControlMaster, ControlPath, DynamicForward, EscapeChar, ForwardAgent, ForwardX11, ForwardX11Trusted, GatewayPorts, GlobalKnownHostsFile, GSSAPIAuthentication, GSSAPIDelegateCredentials, HashKnownHosts, Host, HostbasedAuthentication, HostKeyAlgorithms, HostKeyAlias, HostName, IdentityFile, IdentitiesOnly, KbdInteractiveDevices, LocalCommand, LocalForward, LogLevel, MACs, NoHostAuthenticationForLocalhost, NumberOfPasswordPrompts, PasswordAuthentication, PermitLocalCommand, Port, PreferredAuthentications, Protocol, ProxyCommand, PubkeyAuthentication, RekeyLimit, RemoteForward, RhostsRSAAuthentication, RSAAuthentication, SendEnv, ServerAliveInterval, ServerAliveCountMax, SmartcardDevice, StrictHostKeyChecking, TCPKeepAlive, Tunnel, TunnelDevice, UsePrivilegedPort, User, UserKnownHostsFile, VerifyHostKeyDNS, XAuthLocation

-p
Optional. Port to connect to on the remote host. This can be specified on a per-host basis in the configuration file.

-q
Optional. Quiet mode. Causes all warning and diagnostic messages to be suppressed.

-R
Optional. Specifies that the given port on the remote (server) host is to be forwarded to the given host and port on the local side. This works by allocating a socket to listen to port on the remote side, and whenever a connection is made to this port, the connection is forwarded over the secure channel, and a connection is made to host port hostport from the local machine. Port forwardings can also be specified in the configuration file. Privileged ports can be forwarded only when logging in as root on the remote machine. IPv6 addresses can be specified by enclosing the address in square braces or using an alternative syntax: [bind_address/]host/port/hostport. By default, the listening socket on the server will be bound to the loopback interface only. This may be overriden by specifying a bind_address.  An empty bind_address, or the address '*', indicates that the remote socket should listen on all interfaces. Specifying a remote bind_address will only succeed if the server's GatewayPorts option is enabled.

-S
Optional. Specifies the location of a control socket for connection sharing.

-s
Optional. May be used to request invocation of a subsystem on the remote system. Subsystems are a feature of the SSH2 protocol which facilitate the use of SSH as a secure transport for other applications (eg. sftp). The subsystem is specified as the remote command.

-T
Optional. Disable pseudo-tty allocation.

-t
Optional. Force pseudo-tty allocation. This can be used to execute arbitrary screen-based programs on a remote machine, which can be very useful, e.g., when implementing menu services.  Multiple -t options force tty allocation, even if SSH has no local tty.

-V
Optional. Display the version number and exit.

-v
Optional. Verbose mode.  Causes SSH to print debugging messages about its progress. This is helpful in debugging connection, authentication, and configuration problems. Multiple -v options increase the verbosity. The maximum is 3.

-w
Optional. Requests a tun(4) device on the client (first tunnel arg) and server (second tunnel arg). The devices may be specified by numerical ID or the keyword "any", which uses the next available tunnel device.

-X
Optional. Enables X11 forwarding. This can also be specified on a per-host basis in a configuration file. X11 forwarding should be enabled with caution.  Users with the ability to bypass file permissions on the remote host (for the user's X authorization database) can access the local X11 display through the forwarded connection. An attacker may then be able to perform activities such as keystroke monitoring. For this reason, X11 forwarding is subjected to X11 SECURITY extension restrictions by default. Please refer to the -Y option for more information.

-x
Optional. Disables X11 forwarding.

-Y
Optional. Enables trusted X11 forwarding. Trusted X11 forwardings are not subjected to the X11 SECURITY extension controls.
#>
    Invoke-Expression "& $ScriptDir\bin\ssh.exe $args"
}
New-Alias -Name ssh -value Connect-SSHSession

function New-SSHKey {
<#
.SYNOPSIS
Authentication key generation, management and conversion.

.DESCRIPTION
New-SSHKey generates, manages and converts authentication keys for SSH. New-SSHKey can create RSA keys for use by SSH protocol version 1 and DSA, ECDSA, ED25519 or RSA keys for use by SSH protocol version 2. The type of key to be generated is specified  with the -t option. If invoked without any arguments, New-SSHKey will generate an RSA key for use in SSH protocol 2 connections. New-SSHKey is also used to generate groups for use in Diffie-Hellman group exchange (DH-GEX). Finally, New-SSHKey can be used to generate and update Key Revocation Lists, and to test whether given keys have been revoked by one. See the KEY REVOCATION LISTS section for details. Normally each user wishing to use SSH with public key authentication runs this once to create the authentication key in ~/.ssh/identity, ~/.ssh/id_dsa, ~/.ssh/id_ecdsa, ~/.ssh/id_ed25519 or ~/.ssh/id_rsa. Additionally, the system administrator may use this to generate host keys, as seen in /etc/rc. Normally this program generates the key and asks for a file in which to store the private key. The public key is stored in a file with the same name but “.pub” appended. The program also asks for a passphrase. The passphrase may be empty to indicate no passphrase (host keys must have an empty passphrase), or it may be a string of arbitrary length. A passphrase is similar to a password, except it can be a phrase with a series of words, punctuation, numbers, whitespace, or any string of characters you want. Good passphrases are 10-30 characters long, are not simple sentences or otherwise easily guessable (English prose has only 1-2 bits of entropy per character, and provides very bad passphrases), and contain a mix of upper and lowercase letters, numbers, and non-alphanumeric characters. The passphrase can be changed later by using the -p option. There is no way to recover a lost passphrase. If the passphrase is lost or forgotten, a new key must be generated and the corresponding public key copied to other machines. For RSA1 keys, there is also a comment field in the key file that is only for convenience to the user to help identify the key. The comment can tell what the key is for, or whatever is useful. The comment is initialized to “user@host” when the key is created, but can be changed using the -c option.

.PARAMETER AaBbCcDeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtuVvWYy

-A
Optional. For each of the key types (rsa1, rsa, dsa, ecdsa and ed25519) for which host keys do not exist, generate the host keys with the default key file path, an empty passphrase, default bits for the key type, and default comment.

-a rounds
Optional. When saving a new-format private key (i.e. an ed25519 key or any SSH protocol 2 key when the -o flag is set), this option specifies the number of KDF (key derivation function) rounds used. Higher numbers result in slower passphrase verification and increased resistance to brute-force password cracking (should the keys be stolen). When screening DH-GEX candidates ( using the -T command). This option specifies the number of primality tests to perform.

-B
Optional. Show the bubblebabble digest of specified private or public key file.

-b bits
Optional. Specifies the number of bits in the key to create. For RSA keys, the minimum size is 768 bits and the default is 2048 bits. Generally, 2048 bits is considered sufficient. DSA keys must be exactly 1024 bits as specified by FIPS 186-2. For ECDSA keys, the -b flag determines the key length by selecting from one of three elliptic curve sizes: 256, 384 or 521 bits. Attempting to use bit lengths other than these three values for ECDSA keys will fail. ED25519 keys have a fixed length and the -b flag will be ignored.

-C comment
Optional. Provides a new comment.

-c
Optional. Requests changing the comment in the private and public key files. This operation is only supported for RSA1 keys. The program will prompt for the file containing the private keys, for the passphrase if the key has one, and for the new comment.

-D pkcs11
Optional. Download the RSA public keys provided by the PKCS#11 shared library pkcs11. When used in combination with -s, this option indicates that a CA key resides in a PKCS#11 token (see the CERTIFICATES section for details).

-e
Optional. This option will read a private or public OpenSSH key file and print to stdout the key in one of the formats specified by the -m option. The default export format is “RFC4716”. This option allows exporting OpenSSH keys for use by other programs, including several commercial SSH implementations.

-F hostname
Optional. Search for the specified hostname in a known_hosts file, listing any occurrences found. This option is useful to find hashed host names or addresses and may also be used in conjunction with the -H option to print found keys in a hashed format.

-f filename
Optional. Specifies the filename of the key file.

-G output_file
Optional. Generate candidate primes for DH-GEX. These primes must be screened for safety (using the -T option) before use.

-g
Optional. Use generic DNS format when printing fingerprint resource records using the -r command.

-H
Optional. Hash a known_hosts file. This replaces all hostnames and addresses with hashed representations within the specified file; the original content is moved to a file with a .old suffix. These hashes may be used normally by SSH and SSHd, but they do not reveal identifying information should the file's contents be disclosed. This option will not modify existing hashed hostnames and is therefore safe to use on files that mix hashed and non-hashed names.

-h
Optional. When signing a key, create a host certificate instead of a user certificate. Please see the CERTIFICATES section for details.

-I certificate_identity
Optional. Specify the key identity when signing a public key. Please see the CERTIFICATES section for details.

-i
Optional. This option will read an unencrypted private (or public) key file in the format specified by the -m option and print an OpenSSH compatible private (or public) key to stdout. This option allows importing keys from other software, including several commercial SSH implementations. The default import format is “RFC4716”.

-J num_lines
Optional. Exit after screening the specified number of lines while performing DH candidate screening using the -T option.

-j start_line
Optional. Start screening at the specified line number while performing DH candidate screening using the -T option.

-K checkpt
Optional. Write the last line processed to the file checkpt while performing DH candidate screening using the -T option. This will be used to skip lines in the input file that have already been processed if the job is restarted.

-k
Optional. Generate a KRL file. In this mode, New-SSHKey will generate a KRL file at the location specified via the -f flag that revokes every key or certificate presented on the command line. Keys/certificates to be revoked may be specified by public key file or using the format described in the KEY REVOCATION LISTS section.

-L
Optional. Prints the contents of a certificate.

-l
Optional. Show fingerprint of specified public key file. Private RSA1 keys are also supported. For RSA and DSA keys New-SSHKey tries to find the matching public key file and prints its fingerprint. If combined with -v, an ASCII art representation of the key is supplied with the fingerprint.

-M memory
Optional. Specify the amount of memory to use (in megabytes) when generating candidate moduli for DH-GEX.

-m key_format
Optional. Specify a key format for the -i (import) or -e (export) conversion options. The supported key formats are: “RFC4716” (RFC 4716/SSH2 public or private key), “PKCS8” (PEM PKCS8 public key) or “PEM” (PEM public key). The default conversion format is “RFC4716”.

-N new_passphrase
Optional. Provides the new passphrase.

-n principals
Optional. Specify one or more principals (user or host names) to be included in a certificate when signing a key. Multiple principals may be specified, separated by commas. Please see the CERTIFICATES section for details.

-O option
Optional. Specify a certificate option when signing a key. This option may be specified multiple times. Please see the CERTIFICATES section for details. The options that are valid for user certificates are: clear, force-command, no-agent-forwarding, no-port-forwarding, no-pty, no-user-rc, no-x11-forwarding, permit-agent-forwarding, permit-port-forwarding, permit-pty, permit-user-rc, permit-x11-forwarding, source-address.

-o
Optional. Causes New-SSHKey to save SSH protocol 2 private keys using the new OpenSSH format rather than the more compatible PEM format. The new format has increased resistance to brute-force password cracking but is not supported by versions of OpenSSH prior to 6.5. Ed25519 keys always use the new private key format.

-P passphrase
Optional. Provides the (old) passphrase.

-p
Optional. Requests changing the passphrase of a private key file instead of creating a new private key. The program will prompt for the file containing the private key, for the old passphrase, and twice for the new passphrase.

-Q
Optional. Test whether keys have been revoked in a KRL.

-q
Optional. Silence New-SSHKey.

-R hostname
Optional. Removes all keys belonging to hostname from a known_hosts file. This option is useful to delete hashed hosts (see the -H option above).

-r hostname
Optional. Print the SSHFP fingerprint resource record named hostname for the specified public key file.

-S start
Optional. Specify start point (in hex) when generating candidate moduli for DH-GEX.

-s ca_key
Optional. Certify (sign) a public key using the specified CA key. When generating a KRL, -s specifies a path to a CA public key file used to revoke certificates directly by key ID or serial number. See the KEY REVOCATION LISTS section for details.

-T output_file
Optional. Test DH group exchange candidate primes (generated using the -G option) for safety.

-t dsa | ecdsa | ed25519 | rsa | rsa1
Optional. Specifies the type of key to create. The possible values are “rsa1” for protocol version 1 and “dsa”, “ecdsa”, “ed25519”, or “rsa” for protocol version 2.

-u
Optional. Update a KRL. When specified with -k, keys listed via the command line are added to the existing KRL rather than a new KRL being created.

-V validity_interval
Optional. Specify a validity interval when signing a certificate. A validity interval may consist of a single time, indicating that the certificate is valid beginning now and expiring at that time, or may consist of two times separated by a colon to indicate an explicit time interval. The start time may be specified as a date in YYYYMMDD format, a time in YYYYMMDDHHMMSS format or a relative time (to the current time) consisting of a minus sign followed by a relative time in the format described in the TIME FORMATS section of sshd_config. The end time may be specified as a YYYYMMDD date, a YYYYMMDDHHMMSS time or a relative time starting with a plus character.

-v
Optional. Verbose mode. Causes New-SSHKey to print debugging messages about its progress. This is helpful for debugging moduli generation. Multiple -v options increase the verbosity. The maximum is 3.

-W generator
Optional. Specify desired generator when testing candidate moduli for DH-GEX.

-y
Optional. This option will read a private OpenSSH format file and print an OpenSSH public key to stdout.

-z serial_number
Optional. Specifies a serial number to be embedded in the certificate to distinguish this certificate from others from the same CA. The default serial number is zero. When generating a KRL, the -z flag is used to specify a KRL version number.
#>
    Invoke-Expression "& $ScriptDir\bin\ssh-keygen.exe $args"
}
New-Alias -Name ssh-keygen -value New-SSHKey

function Connect-SFTPSession {
    Invoke-Expression "& $ScriptDir\bin\sftp.exe $args"
}
New-Alias -Name sftp -value Connect-SFTPSession

######## END OF FUNCTIONS ########

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

${global:SSH-PS} = @{}

Export-ModuleMember -Alias ssh, ssh-keygen, sftp -Function Connect-SSHSession, New-SSHKey, Connect-SFTPSession