From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH TRIVIAL] spi: rspi: Spelling s/transmition/transmission/
Date: Sun, 12 Jan 2014 14:06:58 +0100
Message-ID: <1389532018-6449-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-rspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0d6d6cf07100..8f0bd2694568 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -528,7 +528,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 		remain--;
 	}
 
-	/* Waiting for the last transmition */
+	/* Waiting for the last transmission */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
 	if (!rspi->txmode && !(rspi->sppcr & SPPCR_SPLP)) {
@@ -574,7 +574,7 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 		remain--;
 	}
 
-	/* Waiting for the last transmition */
+	/* Waiting for the last transmission */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
 	return 0;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
