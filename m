From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/fsl-espi: Don't wait transaction completion forever" to the spi tree
Date: Tue, 29 Mar 2016 00:42:22 -0700
Message-ID: <E1akoIA-0007pS-QU@finisterre>
References: <59EFBE2126ED0E4AA25DF57320AFF129051FE3BB@BPXM14GP.gisp.nec.co.jp>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59EFBE2126ED0E4AA25DF57320AFF129051FE3BB-ZmjkEB1lVlLt6d3pZDjeaEtBU8KWyXPq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/fsl-espi: Don't wait transaction completion forever

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

>From aa70e567c4f0eeb849c6bcef3685bdf1fc3ca19d Mon Sep 17 00:00:00 2001
From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Date: Fri, 18 Mar 2016 11:35:21 +0000
Subject: [PATCH] spi/fsl-espi: Don't wait transaction completion forever

Because the eSPI driver uses wait_for_completion(), any stuck-able
phenomenon at half-way transaction progress made worker task hang up.
This phenomenon is perhaps caused by eSPI device errata which seems not
to be published from vendor site yet.

Anyway, we fix hang task by using fixed 2 seconds timeout
that is our preferred value for eSPI maximum transaction size.

It seems to be better that eSPI driver can detect this stuck and
report error (EMSGSIZE) to the upper device driver because
the upper device driver can decide to retry or recover.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 5d7fb81240cd..64d794b99803 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -245,7 +245,12 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (ret)
 		return ret;
 
-	wait_for_completion(&mpc8xxx_spi->done);
+	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
+	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
+	if (ret == 0)
+		dev_err(mpc8xxx_spi->dev,
+			"Transaction hanging up (left %d bytes)\n",
+			mpc8xxx_spi->count);
 
 	/* disable rx ints */
 	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
