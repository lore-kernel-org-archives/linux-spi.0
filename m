From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] spi: atmel: trivial: remove unused fields in DMA structure
Date: Thu, 24 Nov 2016 12:25:00 +0100
Message-ID: <b9945f7ce52c8368843c7de850de302c34d828d7.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1479985886.git.nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The atmel_spi_dma structure was cluttered with unused fields relative
to older DMA channel selection API. Remove them.

Signed-off-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f62bc2d27c9e..f3a225585575 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -268,10 +268,6 @@
 struct atmel_spi_dma {
 	struct dma_chan			*chan_rx;
 	struct dma_chan			*chan_tx;
-	struct dma_async_tx_descriptor	*data_desc_rx;
-	struct dma_async_tx_descriptor	*data_desc_tx;
-
-	struct at_dma_slave	dma_slave;
 };
 
 struct atmel_spi_caps {
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
