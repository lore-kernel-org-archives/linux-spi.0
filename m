From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] spi: atmel: add support to FIFOs and the internal chip-select
Date: Fri, 29 May 2015 16:56:41 +0200
Message-ID: <cover.1432910696.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series of patches add support to features introduced by the Atmel sama5d2x
SoC.

Cyrille Pitchen (2):
  spi: atmel: add support for the internal chip-select of the spi
    controller
  spi: atmel: add support to FIFOs

 drivers/spi/spi-atmel.c | 276 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 257 insertions(+), 19 deletions(-)

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
