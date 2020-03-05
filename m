From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx functions" to the spi tree
Date: Thu, 05 Mar 2020 14:37:48 +0000
Message-ID: <applied-20200304220044.11193-5-olteanv@gmail.com>
References: <20200304220044.11193-5-olteanv@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-5-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx functions

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8f8303ee05857e1b3084c467dde8bb31c58464bd Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 5 Mar 2020 00:00:36 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Add comments around dspi_pop_tx and
 dspi_push_rx functions

Their names are confusing, since dspi_pop_tx prepares a word to be
written to the PUSHR register, and dspi_push_rx gets a word from the
POPR register.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Link: https://lore.kernel.org/r/20200304220044.11193-5-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b92c2b84a94b..a8077d4903c7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -245,6 +245,10 @@ struct fsl_dspi {
 	struct fsl_dspi_dma			*dma;
 };
 
+/*
+ * Pop one word from the TX buffer for pushing into the
+ * PUSHR register (TX FIFO)
+ */
 static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
 	u32 txdata = 0;
@@ -257,6 +261,7 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+/* Prepare one TX FIFO entry (txdata plus cmd) */
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
@@ -269,6 +274,7 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+/* Push one word to the RX buffer from the POPR register (RX FIFO) */
 static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 {
 	if (!dspi->rx)
-- 
2.20.1
