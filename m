From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 0/4] spi: Fix module autoload for different platform drivers
Date: Wed, 23 Nov 2016 13:37:07 -0300
Message-ID: <1479919031-5112-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

This patch series contains trivial fixes for SPI platform drivers that
can be build as a module but did not have module alias information.

Best regards,
Javier


Javier Martinez Canillas (4):
  spi: spi-axi: Fix module autoload
  spi: jcore: Fix module autoload for OF registration
  spi: xlp: Fix module autoload for OF registration
  spi: ath79: Fix module autoload for OF registration

 drivers/spi/spi-ath79.c          | 1 +
 drivers/spi/spi-axi-spi-engine.c | 1 +
 drivers/spi/spi-jcore.c          | 1 +
 drivers/spi/spi-xlp.c            | 1 +
 4 files changed, 4 insertions(+)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
