From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-lpspi: use wait_for_completion_timeout() while waiting transfer done" to the spi tree
Date: Wed, 30 Nov 2016 18:08:10 +0000
Message-ID: <E1cC9Ig-0008RX-Em@debutante>
References: <1480302180-15550-1-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480302180-15550-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-lpspi: use wait_for_completion_timeout() while waiting transfer done

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

>From d2ad0a62d4ee235fbfcf7816a0bee5d09da8ddbe Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Mon, 28 Nov 2016 11:02:59 +0800
Subject: [PATCH] spi: fsl-lpspi: use wait_for_completion_timeout() while
 waiting transfer done

It's a potential problem to use wait_for_completion() because the
completion condition may never come. Thus, it's better to repalce
wait_for_completion() with wait_for_completion_timeout().

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 539c971b9f05..47a97add0639 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -348,7 +348,12 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 
 	reinit_completion(&fsl_lpspi->xfer_done);
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
-	wait_for_completion(&fsl_lpspi->xfer_done);
+
+	ret = wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ);
+	if (!ret) {
+		dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
+		return -ETIMEDOUT;
+	}
 
 	ret = fsl_lpspi_txfifo_empty(fsl_lpspi);
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
