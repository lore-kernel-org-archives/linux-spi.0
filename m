From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] spi: atmel: enhance the DMA handling
Date: Thu, 24 Nov 2016 12:24:56 +0100
Message-ID: <cover.1479985886.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the dummy buffer handling and DMA mapping core infrastructure to simplify
spi-atmel driver.
By using these frameworks we also fix the use of any kind of memory with
dmaengine. This work was triggered by issues encountered while using UBI/UBIFS
on a serial flash.

Some good ideas of this series have been inspired by spi-rspi.c and commits by
Geert Uytterhoeven.

I have a side question still: is the is_dma_mapped tag still used and considered into
the core spi routines or is it always the driver itself that have to deal with
it (so how to do with the can_dma() routine)?

Cyrille Pitchen (1):
  spi: atmel: Use SPI core DMA mapping framework

Nicolas Ferre (4):
  spi: atmel: trivial: move info banner to latest probe action
  spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling
  spi: atmel: trivial: remove unused fields in DMA structure
  spi: atmel: remove the use of private channel fields

 drivers/spi/spi-atmel.c | 268 ++++++++++++++++++------------------------------
 1 file changed, 98 insertions(+), 170 deletions(-)

-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
