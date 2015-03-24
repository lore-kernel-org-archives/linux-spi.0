From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/2] spi: pxa2xx: allow to set mostly any baudrate for Quark case
Date: Tue, 24 Mar 2015 17:43:20 +0200
Message-ID: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently driver relies on a table that is really unflexible and contains only
small subset of all possible variabts.

The patch series replaces the table by an approximation.

The code has been tested on Galileo Gen 1 board with loopback mode enabled.

Mark, it would be nice to have this in 4.0-rcX since it will be the first
kernel with Quark support. And I applied necessary patch to allow user to
select SPI driver for it, though it's up to you.

P.S. It was my bad I had to insist to use the approximation instead of some
unflexible tables in the first place.

Andy Shevchenko (2):
  spi: pxa2xx: shift clk_div in one place
  spi: pxa2xx: replace ugly table by approximation

 drivers/spi/spi-pxa2xx.c | 161 +++++++++++++++++++++++++++--------------------
 1 file changed, 94 insertions(+), 67 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
