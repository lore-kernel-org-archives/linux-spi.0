From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH 0/8] spi: spi-ep93xx: tidy up and convert to queued driver infrastructure
Date: Fri, 28 Jun 2013 11:41:38 -0700
Message-ID: <201306281141.38864.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<broonie@kernel.org>, <grant.likely@linaro.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Do a bit of housecleaning in this driver and convert it to use the
SPI queued driver infrastructure.

H Hartley Sweeten (8):
  spi: spi-ep93xx: use read,write instead of __raw_* variants
  spi: spi-ep93xx: use bits_per_word_mask
  spi: spi-ep93xx: always handle transfer specific settings
  spi: spi-ep93xx: remove bits_per_word() helper
  spi: spi-ep93xx: remove 'dss' from per chip private data
  spi: spi-ep93xx: don't bother calculating the divisors in ep93xx_spi_setup()
  spi: spi-ep93xx: move the clock divider calcs into ep93xx_spi_chip_setup()
  spi: spi-ep93xx: convert to the queued driver infrastructure

 drivers/spi/spi-ep93xx.c | 366 ++++++++++-------------------------------------
 1 file changed, 75 insertions(+), 291 deletions(-)

-- 
1.8.1.4
