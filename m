From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Thu, 26 Dec 2013 09:00:15 +0200
Message-ID: <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
References: <cover.1388040447.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw.c | 1 -
 drivers/spi/spi-dw.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c3354e8..4e01019 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -427,7 +427,6 @@ static void pump_transfers(unsigned long data)
 	dws->tx_end = dws->tx + transfer->len;
 	dws->rx = transfer->rx_buf;
 	dws->rx_end = dws->rx + transfer->len;
-	dws->cs_change = transfer->cs_change;
 	dws->len = dws->cur_transfer->len;
 	if (chip != dws->prev_chip)
 		cs_change = 1;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 1ccfc18..cb52cfe 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -135,7 +135,6 @@ struct dw_spi {
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	u8			max_bits_per_word;	/* maxim is 16b */
 	u32			dma_width;
-	int			cs_change;
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
 	void			(*cs_control)(u32 command);
 
-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
