From: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] spi: spidev_test: Added functionalities
Date: Sat,  7 Mar 2015 12:56:31 -0500
Message-ID: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a patch series add functionalities to the spidev_test tool found
in Documentation/spi/spidev_test.c.

- Cleaned hexadecimal dump
- Added verbose mode to see the transmitting sequence
- Added input buffer from the terminal. Now it is possible to send
  string and hexadecimal data as an input parameter:

  Example that shows verbose mode and a sending sequence:

  root@microZed:~# ./a.out -D /dev/spidev32766.1 -p "\x23ab1" -v
  spi mode: 0x0
  bits per word: 8
  max speed: 500000 Hz (500 KHz)
  TX | 23 61 62 31 __ __ __ __  | #ab1
  RX | FF FF FF FF __ __ __ __  | ....

Adrian Remonda (4):
  Cleaned hexadecimal dump
  Added verbose output
  Added input buffer from the terminal.
  Created spi directory in tools

 Documentation/spi/spidev_test.c |  243 ------------------------------
 tools/spi/spidev_test.c         |  318 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+), 243 deletions(-)
 delete mode 100644 Documentation/spi/spidev_test.c
 create mode 100644 tools/spi/spidev_test.c

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
