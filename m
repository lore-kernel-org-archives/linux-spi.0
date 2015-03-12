From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv5] spi: Convert DesignWare SPI driver to 32-bit accesses
Date: Thu, 12 Mar 2015 14:19:30 -0500
Message-ID: <1426187971-8794-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <jkosina-AlSwsSmVLrQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	<wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Altera's Arria10 SoC requires that all write accesses of APB
peripherals be 32-bit. The DesignWare documentation indicates
this change is supported by the design.

Request for Testing:
Please test on legacy DesignWare SPI platforms. If a problem is
discovered, please reply to this thread.

Thor Thayer (1):
  spi: dw-spi: Convert 16bit accesses to 32bit accesses

 drivers/spi/spi-dw-mid.c |   10 +++++-----
 drivers/spi/spi-dw.c     |   24 ++++++++++++------------
 drivers/spi/spi-dw.h     |   10 ----------
 3 files changed, 17 insertions(+), 27 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
