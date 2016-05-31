From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ti-qspi: Suspend the queue before removing the device" to the spi tree
Date: Tue, 31 May 2016 18:52:46 +0100
Message-ID: <E1b7nqQ-0006Tj-Lg@debutante>
References: <1463486227-6110-1-git-send-email-x0248073@ti.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org
To: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463486227-6110-1-git-send-email-x0248073-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ti-qspi: Suspend the queue before removing the device

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

>From 3ac066e2227cb272c097f34475247fa0a6cdd2ff Mon Sep 17 00:00:00 2001
From: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
Date: Tue, 31 May 2016 17:56:23 +0200
Subject: [PATCH] spi: spi-ti-qspi: Suspend the queue before removing the
 device

Before disabling the pm_runtime, we must ensure that there is no transfer
in progress nor will a new one be started. Otherwise the message pump will
fail and in the end, the process requesting the transfer will be stuck.
This behavior has been observed when transferring data from a SPI flash
with dd while removing the module on a DRA7x-evm.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 443f664534e1..29ea8d2f9824 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -646,6 +646,13 @@ free_master:
 
 static int ti_qspi_remove(struct platform_device *pdev)
 {
+	struct ti_qspi *qspi = platform_get_drvdata(pdev);
+	int rc;
+
+	rc = spi_master_suspend(qspi->master);
+	if (rc)
+		return rc;
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
