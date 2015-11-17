From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/8] spi: Add file i/o to spidev_test
Date: Tue, 17 Nov 2015 07:24:20 -0800
Message-ID: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add to spidev_test, the ability to read from and write to a file.
Clean up code along the way.
As I finished, I found that a request has been made to move
spidev_test from Documentation to tools, so I did that as well.

Joshua Clayton (8):
  Documentation/spi/spidev_test.c: use one rx buffer
  Documentation/spi/spidev_test.c: clean up input_tx
  Documentation/spi/spidev_test.c: accept input from a file
  Documentation/spi/spidev_test.c: output to a file
  Documentation/spi/spidev_test.c: check error
  Documentation/spi/spidev_test.c: fix whitespace
  tools/Makefile: minor whitespace cleanup
  spi: Move spi code from Documentation to tools

 Documentation/Makefile          |   2 +-
 Documentation/spi/Makefile      |   8 -
 Documentation/spi/spidev_fdx.c  | 158 -----------------
 Documentation/spi/spidev_test.c | 318 ---------------------------------
 tools/Makefile                  |  43 ++++-
 tools/spi/Makefile              |   4 +
 tools/spi/spidev_fdx.c          | 158 +++++++++++++++++
 tools/spi/spidev_test.c         | 385 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 582 insertions(+), 494 deletions(-)
 delete mode 100644 Documentation/spi/Makefile
 delete mode 100644 Documentation/spi/spidev_fdx.c
 delete mode 100644 Documentation/spi/spidev_test.c
 create mode 100644 tools/spi/Makefile
 create mode 100644 tools/spi/spidev_fdx.c
 create mode 100644 tools/spi/spidev_test.c

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
