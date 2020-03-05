From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode" to the spi tree
Date: Thu, 05 Mar 2020 14:37:39 +0000
Message-ID: <applied-20200304220044.11193-7-olteanv@gmail.com>
References: <20200304220044.11193-7-olteanv@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-7-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode

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

>From a3185c38dc6cd664b2b576eb9d3e5d2f49101a10 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 5 Mar 2020 00:00:38 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Implement .max_message_size method for EOQ
 mode

When it gets set, End Of Queue Flag halts the DSPI controller and forces
the chip select signal to deassert.

This operating mode is not ideal, but it is used for the DSPI
instantiations where there is no other notification from the controller
that the data in the FIFO has finished transmission. So in practice, it
means that transmitting buffers larger than the FIFO size will yield
unpredictable results.

The only controller that operates in EOQ mode is MCF5441X (Coldfire). I
would say that the way EOQ is used (and documented in the reference
manual, too) on this chip is incorrect, and I would personally migrate
it to TCFQ, but that's notably worse in terms of performance (it can
only use 1 entry of the 16-deep FIFO) and if this limitation didn't
bother any Coldfire DSPI user so far, it's likely that we just need to
throw an error for larger buffers to make sure that callers are aware
their transfers are getting truncated/split.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Link: https://lore.kernel.org/r/20200304220044.11193-7-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f37090ad7ad1..158cb48c0f4a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1084,6 +1084,22 @@ static int dspi_slave_abort(struct spi_master *master)
 	return 0;
 }
 
+/*
+ * EOQ mode will inevitably deassert its PCS signal on last word in a queue
+ * (hardware limitation), so we need to inform the spi_device that larger
+ * buffers than the FIFO size are going to have the chip select randomly
+ * toggling, so it has a chance to adapt its message sizes.
+ */
+static size_t dspi_max_message_size(struct spi_device *spi)
+{
+	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
+		return dspi->devtype_data->fifo_size;
+
+	return SIZE_MAX;
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1105,6 +1121,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	ctlr->setup = dspi_setup;
 	ctlr->transfer_one_message = dspi_transfer_one_message;
+	ctlr->max_message_size = dspi_max_message_size;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
-- 
2.20.1
