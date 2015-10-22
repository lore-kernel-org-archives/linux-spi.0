From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 0/2] spi: fix kernel-doc warnings
Date: Thu, 22 Oct 2015 18:59:21 +0200
Message-ID: <1445533163-3366-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hello Mark,

This trivial series fixes some warnings that I noticed in the SPI
subsystem when builing the kernel DocBook. All the warnings were
due missing description for some functions return values.

Patch #1 fixes the warnings from the include/linux/spi/spi.h header
file and patch #2 fixes the warnings in the drivers/spi/spi.c file.

Best regards,
Javier


Javier Martinez Canillas (2):
  spi: fix kernel-doc warnings about missing return desc in spi.h
  spi: fix kernel-doc warnings about missing return desc in spi.c

 drivers/spi/spi.c       | 41 ++++++++++++++++++++++++++++++++---------
 include/linux/spi/spi.h | 34 ++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
