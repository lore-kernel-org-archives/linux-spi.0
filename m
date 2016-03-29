From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/fsl-espi: Don't spin forever on SPIE_RXCNT" to the spi tree
Date: Tue, 29 Mar 2016 00:42:23 -0700
Message-ID: <E1akoIB-0007pu-5p@finisterre>
References: <59EFBE2126ED0E4AA25DF57320AFF129051FE3AF@BPXM14GP.gisp.nec.co.jp>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59EFBE2126ED0E4AA25DF57320AFF129051FE3AF-ZmjkEB1lVlLt6d3pZDjeaEtBU8KWyXPq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/fsl-espi: Don't spin forever on SPIE_RXCNT

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

>From a12ddd60ed0a88c3bb83a8d4c07762e41620bf8c Mon Sep 17 00:00:00 2001
From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Date: Fri, 18 Mar 2016 11:35:21 +0000
Subject: [PATCH] spi/fsl-espi: Don't spin forever on SPIE_RXCNT

Infinite loop on SPIE_RXCNT occurred.

while (SPIE_RXCNT(events) < min(4, mspi->len)) {
        cpu_relax();
        events = mpc8xxx_spi_read_reg(&reg_base->event);
}

We met a soft lockup at fsl_espi_cpu_irq() because of this.

Fix it by using spin_event_timeout() so that fsl_espi_cpu_irq()
can break loop with timeouts dmesg.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7cb0c1921495..5d7fb81240cd 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -539,11 +539,18 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (events & SPIE_NE) {
 		u32 rx_data, tmp;
 		u8 rx_data_8;
+		int ret;
 
 		/* Spin until RX is done */
-		while (SPIE_RXCNT(events) < min(4, mspi->len)) {
-			cpu_relax();
-			events = mpc8xxx_spi_read_reg(&reg_base->event);
+		if (SPIE_RXCNT(events) < min(4, mspi->len)) {
+			ret = spin_event_timeout(
+				!(SPIE_RXCNT(events =
+				mpc8xxx_spi_read_reg(&reg_base->event)) <
+						min(4, mspi->len)),
+						10000, 0); /* 10 msec */
+			if (!ret)
+				dev_err(mspi->dev,
+					 "tired waiting for SPIE_RXCNT\n");
 		}
 
 		if (mspi->len >= 4) {
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
