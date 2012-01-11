default[:bootstrap][:packages][:install] = [
  'ack-grep',   # Ack is designed as a replacement for 99% of the uses of grep. ack is
                # intelligent about the files it searches. It knows about certain file
                # types, based on both the extension on the file and, in some cases, the
                # contents of the file.
                # .
                # Ack ignores backup files and files under CVS and .svn directories. It
                # also highlights matches to help you see where the match was. Ack uses
                # perl regular expressions.

  'apache2-utils',  # Description: utility programs for webservers
                    # Provides some add-on programs useful for any webserver.  These include:
                    # - ab (Apache benchmark tool)
                    # - logresolve (Resolve IP addresses to hostname in logfiles)
                    # - htpasswd (Manipulate basic authentication files)
                    # - htdigest (Manipulate digest authentication files)
                    # - dbmmanage (Manipulate basic authentication files in DBM format, using perl)
                    # - htdbm (Manipulate basic authentication files in DBM format, using APR)
                    # - rotatelogs (Periodically stop writing to a logfile and open a new one)
                    # - split-logfile (Split a single log including multiple vhosts)
                    # - checkgid (Checks whether the caller can setgid to the specified group)
                    # - check_forensic (Extract mod_log_forensic output from Apache log files)

  'bind9-host', # This package provides the 'host' program in the form that is bundled with
                # the BIND 9.X sources. This version differs from the one provided in the
                # package called host, which is from NIKHEF, and has a similar but different
                # set of features/options.

  'bzip2',      # bzip2 is a freely available, patent free, high-quality data compressor.
                # It typically compresses files to within 10% to 15% of the best available
                # techniques, whilst being around twice as fast at compression and six
                # times faster at decompression.
                # .
                # bzip2 compresses files using the Burrows-Wheeler block-sorting text
                # compression algorithm, and Huffman coding. Compression is generally
                # considerably better than that achieved by more conventional
                # LZ77/LZ78-based compressors, and approaches the performance of the PPM
                # family of statistical compressors.

  'curl',       # curl is a client to get files from servers using any of the supported
                # protocols. The command is designed to work without user interaction
                # or any kind of interactivity.
                # .
                # curl offers a busload of useful tricks like proxy support, user
                # authentication, ftp upload, HTTP post, file transfer resume and more.

  'dstat',      # Dstat is a versatile replacement for vmstat, iostat and ifstat. Dstat
                # overcomes some of the limitations of these programs and adds some
                # extra features.
                # .
                # Dstat allows you to view all of your network resources instantly, you
                # can for example, compare disk usage in combination with interrupts
                # from your IDE controller, or compare the network bandwidth numbers
                # directly with the disk throughput (in the same interval).
                # .
                # Dstat also cleverly gives you the most detailed information in columns
                # and clearly indicates in what magnitude and unit the output is displayed.
                # .
                # Dstat is also unique in letting you aggregate block device throughput for
                # a certain diskset or network bandwidth for a group of interfaces, i.e. you
                # can see the throughput for all the block devices that make up a single
                # filesystem or storage system.
                # .
                # Dstat's output, in its current form, is not suited for post-processing by
                # other tools, it's mostly meant for humans to interpret real-time data
                # as easy as possible.

   'ethtool',   # ethtool can be used to query and change settings such as speed, auto-
                # negotiation and checksum offload on many network devices, especially
                # Ethernet devices.

  'file',       # File tests each argument in an attempt to classify it. There are three sets of
                # tests, performed in this order: filesystem tests, magic number tests, and
                # language tests. The first test that succeeds causes the file type to be
                # printed.
                # .
                # Starting with version 4, the file command is not much more than a wrapper
                # around the "magic" library.

  'gawk',       #`awk', a program that you can use to select particular records in a
                # file and perform operations upon them.
                # .
                # Gawk is the GNU Project's implementation of the AWK programming language.
                # It conforms to the definition of the language in the POSIX 1003.2 Command
                # Language And Utilities Standard. This version in turn is based on the
                # description in The AWK Programming Language, by Aho, Kernighan, and
                # Weinberger, with the additional features defined in the System V Release
                # 4 version of UNIX awk. Gawk also provides more recent Bell Labs awk
                # extensions, and some GNU-specific extensions.

  'hddtemp',    #  The hddtemp program monitors and reports the temperature of PATA, SATA
                # or SCSI hard drives by reading Self-Monitoring Analysis and Reporting
                # Technology (S.M.A.R.T.) information on drives that support this feature.

  'htop',       #  Htop is an ncursed-based process viewer similar to top, but it
                # allows to scroll the list vertically and horizontally to see
                # all processes and their full command lines.
                # .
                # Tasks related to processes (killing, renicing) can be done without
                # entering their PIDs.

  'iftop',      # iftop does for network usage what top(1) does for CPU usage. It listens to
                # network traffic on a named interface and displays a table of current bandwidth
                # usage by pairs of hosts. Handy for answering the question "Why is my Internet
                # link so slow?".

  'lm-sensors', # Lm-sensors is a hardware health monitoring package for Linux. It allows you
                # to access information from temperature, voltage, and fan speed sensors. It
                # works with most newer systems.

  'logrotate',  # The logrotate utility is designed to simplify the administration of
                # log files on a system which generates a lot of log files. Logrotate
                # allows for the automatic rotation compression, removal and mailing of
                # log files. Logrotate can be set to handle a log file daily, weekly,
                # monthly or when the log file gets to a certain size. Normally, logrotate
                # runs as a daily cron job.

  'lsof',       # Lsof is a Unix-specific diagnostic tool. Its name stands
                # for LiSt Open Files, and it does just that. It lists
                # information about any files that are open, by processes
                # currently running on the system.

  'lynx',       # Lynx is a fully-featured World Wide Web (WWW) client for users running
                # cursor-addressable, character-cell display devices (e.g., vt100 terminals,
                # vt100 emulators running on Windows 95/NT or Macintoshes, or any other
                # "curses-oriented" display). It will display hypertext markup language
                # (HTML) documents containing links to files residing on the local system, as
                # well as files residing on remote systems running Gopher, HTTP, FTP, WAIS,
                # and NNTP servers. Current versions of Lynx run on Unix, VMS, Windows
                # 95/NT, 386DOS and OS/2 EMX.

  'ntp',        # NTP, the Network Time Protocol, is used to keep computer clocks
                # accurate by synchronizing them over the Internet or a local network,
                # or by following an accurate hardware receiver that interprets GPS,
                # DCF-77, NIST or similar time signals.
                # .
                # This package contains the NTP daemon and utility programs. An NTP
                # daemon needs to be running on each host that is to have its clock
                # accuracy controlled by NTP. The same NTP daemon is also used to
                # provide NTP service to other hosts.

  'ntpdate',    # ntpdate is a simple NTP client that sets a system's clock to match
                # the time obtained by communicating with one or more NTP servers. It
                # is not sufficient, however, for maintaining an accurate clock in the
                # long run. ntpdate by itself is useful for occasionally setting the
                # time on machines that do not have full-time network access, such as
                # laptops.

  'openssl',    # It is part of the OpenSSL implementation of SSL.
                # .
                # You need it to perform certain cryptographic actions like:
                # -  Creation of RSA, DH and DSA key parameters;
                # -  Creation of X.509 certificates, CSRs and CRLs;
                # -  Calculation of message digests;
                # -  Encryption and decryption with ciphers;
                # -  SSL/TLS client and server tests;
                # -  Handling of S/MIME signed or encrypted mail.

  'patch',      # Patch will take a patch file containing any of the four forms
                # of difference listing produced by the diff program and apply
                # those differences to an original file, producing a patched
                # version.

  'pwgen',      # pwgen generates random, meaningless but pronounceable passwords.
                # These passwords contain either only lowercase letters, or upper
                # and lower case mixed, or digits thrown in.
                # Uppercase letters and digits are placed in a way that eases
                # remembering their position when memorizing only the word.

  'screen',     # screen is a terminal multiplexor that runs several separate "screens" on a
                # single physical character-based terminal.  Each virtual terminal emulates a
                # DEC VT100 plus several ANSI X3.64 and ISO 2022 functions.  Screen sessions
                # can be detached and resumed later on a different terminal.
                # .
                # Screen also supports a whole slew of other features.  Some of these are:
                # configurable input and output translation, serial port support, configurable
                # logging, multi-user support, and utf8 charset support.

  'ssl-cert',   #  This package enables unattended installs of packages that
                # need to create SSL certificates.
                # .
                # It is a simple wrapper for OpenSSL's certificate request utility that
                # feeds it with the correct user variables.

  'strace',     # strace is a system call tracer, i.e. a debugging tool which prints out
                # a trace of all the system calls made by a another process/program.
                # The program to be traced need not be recompiled for this, so you can
                # use it on binaries for which you don't have source.
                # .
                # System calls and signals are events that happen at the user/kernel
                # interface. A close examination of this boundary is very useful for bug
                # isolation, sanity checking and attempting to capture race conditions.

  'sysstat',    # The sysstat package contains the following system performance tools:
                # - sar: collects and reports system activity information;
                # - iostat: reports CPU utilization and disk I/O statistics;
                # - mpstat: reports global and per-processor statistics;
                # - pidstat: reports statistics for Linux tasks (processes);
                # - sadf: displays data collected by sar in various formats.
                # .
                # The statistics reported by sar deal with I/O transfer rates,
                # paging activity, process-related activities, interrupts,
                # network activity, memory and swap space utilization, CPU
                # utilization, kernel activities and TTY statistics, among
                # others. Both UP and SMP machines are fully supported.

  'tmux',       # tmux enables a number of terminals (or windows) to be accessed and
                # controlled from a single terminal like screen. tmux runs as a
                # server-client system.  A server is created automatically when
                # necessary and holds a number of sessions, each of which may have
                # a number of windows linked to it. Any number of clients may connect
                # to a session, or the server may be controlled by issuing commands
                # with tmux. Communication takes place through a socket, by default
                # placed in /var/run. Moreover tmux provides a consistent and
                # well-documented command interface, with the same syntax whether used
                # interactively, as a key binding, or from the shell. It offers a
                # choice of vim or emacs key layouts.

  'traceroute', # The traceroute utility displays the route used by IP packets on their way to a
                # specified network (or Internet) host. Traceroute displays the IP number and
                # host name (if possible) of the machines along the route taken by the packets.
                # Traceroute is used as a network debugging tool. If you're having network
                # connectivity problems, traceroute will show you where the trouble is coming
                # from along the route.
                # .
                # Install traceroute if you need a tool for diagnosing network connectivity
                # problems.

  'tree',       # Displays an indented directory tree, using the same color assignments as
                # ls, via the LS_COLORS environment variable.

  'unrar',      # Unrar can extract files from .rar archives. If you want to create .rar
                # archives, install package rar.

  'unzip',      # InfoZIP's unzip program. With the exception of multi-volume archives
                # (ie, .ZIP files that are split across several disks using PKZIP's /& option),
                # this can handle any file produced either by PKZIP, or the corresponding
                # InfoZIP zip program.

  'vim',        # Vim is an almost compatible version of the UNIX editor Vi.
                # .
                # Many new features have been added: multi level undo, syntax
                # highlighting, command line history, on-line help, filename
                # completion, block operations, folding, Unicode support, etc.
                # .
                # This package contains a version of vim compiled with a rather
                # standard set of features. This package does not provide a GUI
                # version of Vim.  See the other vim-* packages if you need more
                # (or less).

  'vnstat',     # vnStat is a network traffic monitor for Linux. It keeps a log of
                # daily network traffic for the selected interface(s). vnStat is not
                # a packet sniffer. The traffic information is analyzed from the /proc
                # filesystem, so vnStat can be used without root permissions.

  'whois',      # This is a new whois (RFC 3912) client rewritten from scratch.
                # It is inspired from and compatible with the usual BSD and RIPE whois(1)
                # programs.
                # It is intelligent and can automatically select the appropriate whois
                # server for most queries.

  'zip',        # This is InfoZIP's zip program. It produces files that are fully
                # compatible with the popular PKZIP program; however, the command line
                # options are not identical. In other words, the end result is the same,
                # but the methods differ. :-)
]

default[:bootstrap][:packages][:remove] = []
