From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/6] spi: Add file i/o to spidev_test
Date: Wed, 18 Nov 2015 14:30:36 -0800
Message-ID: <cover.1447880230.git.stillcompiling@gmail.com>
References: <2760715.DGIOLUoqL9@jclayton-pc>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2760715.DGIOLUoqL9@jclayton-pc>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add to spidev_test, the ability to read from and write to a file.
Clean up code along the way.
As I finished, I found that a request has been made to move
spidev_test from Documentation to tools, so I did that as well.

Thanks to Mark Brown and Anton Bodarenko for feedback on v1

v2 Changes:
- Move spidev_test to tools in the first commit instead of the last.
- Drop the patch that formats tools/Makefile
- Drop the patch that changes rx to a local variable in transfer()
- Check the result of malloc everywhere it is called.
- Change all the patch subjects to spi: spidev_test
- Removed a check of the spi transfer buffer size, in favor of
    letting the kernel give an error in the ioctl if too big.

Joshua Clayton (6):
  spi: Move spi code from Documentation to tools
  spi: spidev_test: transfer_escaped_string function
  spi: spidev_test: accept input from a file
  spi: spidev_test: output to a file
  spi: spidev_test: check error
  spi: spidev_test: fix whitespace

 Documentation/Makefile          |   2 +-
 Documentation/spi/Makefile      |   8 -
 Documentation/spi/spidev_fdx.c  | 158 ----------------
 Documentation/spi/spidev_test.c | 318 --------------------------------
 tools/Makefile                  |   7 +-
 tools/spi/Makefile              |   4 +
 tools/spi/spidev_fdx.c          | 158 ++++++++++++++++
 tools/spi/spidev_test.c         | 399 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 566 insertions(+), 488 deletions(-)
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
