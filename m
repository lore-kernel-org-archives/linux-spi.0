From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw-mid: constify dw_spi_dma_ops structure" to the spi tree
Date: Mon, 30 Nov 2015 12:25:46 +0000
Message-ID: <E1a3NWc-0003WT-CN@debutante>
References: <1448719778-32271-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>,
	Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448719778-32271-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw-mid: constify dw_spi_dma_ops structure

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4fe338c94986df105c3966a39b5a0af608762891 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Date: Sat, 28 Nov 2015 15:09:38 +0100
Subject: [PATCH] spi: dw-mid: constify dw_spi_dma_ops structure

The dw_spi_dma_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Acked-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 2 +-
 drivers/spi/spi-dw.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index bb1052e748f2..9185f6c08459 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -283,7 +283,7 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
-static struct dw_spi_dma_ops mid_dma_ops = {
+static const struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
 	.dma_setup	= mid_spi_dma_setup,
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 35589a270468..61bc3cbab38d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -130,7 +130,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
-	struct dw_spi_dma_ops	*dma_ops;
+	const struct dw_spi_dma_ops *dma_ops;
 	void			*dma_tx;
 	void			*dma_rx;
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
