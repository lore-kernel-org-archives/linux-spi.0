From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] spi: loopback-test: add new tests and bug fixes
Date: Sat, 18 Mar 2017 03:17:25 +0900
Message-ID: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series fixes a few minor bugs and adds the following new
tests for spi-loopback-test.

- execute various spi_messages including zero-length transfer
- execute spi_messages with delay after transfers

Akinobu Mita (6):
  spi: loopback-test: correct mismatched test description and
    configuration
  spi: loopback-test: don't skip comparing the first byte of rx_buf
  spi: loopback-test: add ability to test zero-length transfer
  spi: loopback-test: test zero-length transfer
  spi: loopback-test: add elapsed time check
  spi: loopback-test: add test spi_message with delay after transfers

 drivers/spi/spi-loopback-test.c | 118 ++++++++++++++++++++++++++--------------
 drivers/spi/spi-test.h          |  21 +++----
 2 files changed, 88 insertions(+), 51 deletions(-)

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
