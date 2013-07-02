From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH v2 00/11] spi: spi-ep93xx: tidy up and convert to queued driver infrastructure
Date: Tue, 2 Jul 2013 10:04:50 -0700
Message-ID: <201307021004.51080.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<broonie@kernel.org>, <grant.likely@linaro.org>,
	<hsweeten@visionengravers.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Do a bit of housekeeping in this driver and convert it to use the
SPI queued driver infrastructure.

v2: rebased on next-20130702
    address some comments from Ryan Mallon and Mika Westerberg
    added a couple more cleanup patches

    Patch 1/11 was already applied by Mark Brown. It is included here only for
    completeness.

H Hartley Sweeten (11):
  spi: spi-ep93xx: always handle transfer specific settings
  spi: spi-ep93xx: use read,write instead of __raw_* variants
  spi: spi-ep93xx: remove bits_per_word() helper
  spi: spi-ep93xx: get platform resources early in (*probe)
  spi: spi-ep93xx: use devm_clk_get()
  spi: spi-ep93xx: remove dev_err() for kzalloc() failure
  spi: spi-ep93xx: remove 'dss' from per chip private data
  spi: spi-ep93xx: don't bother calculating the divisors in ep93xx_spi_setup()
  spi: spi-ep93xx: move the clock divider calcs into ep93xx_spi_chip_setup()
  spi: spi-ep93xx: convert to the queued driver infrastructure
  spi: spi-ep93xx: use master->cur_msg for in-flight message

 drivers/spi/spi-ep93xx.c | 437 ++++++++++++++---------------------------------
 1 file changed, 127 insertions(+), 310 deletions(-)

-- 
1.8.1.4
