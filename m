From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-lpspi: quit reading rx fifo under error condition" to the spi tree
Date: Mon, 05 Dec 2016 12:10:00 +0000
Message-ID: <E1cDs5o-0003wF-Mn@finisterre>
References: <1480650601-12810-2-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480650601-12810-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-lpspi: quit reading rx fifo under error condition

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

>From d989eed20791534dc624c7b29568b263c67a286f Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Fri, 2 Dec 2016 11:50:01 +0800
Subject: [PATCH] spi: fsl-lpspi: quit reading rx fifo under error condition

In case that error occurs during waiting for txfifo empty, it is
not necessary to read rx fifo. It's better to return directly.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c4a4e2622a53..52551f6d0c7d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -350,9 +350,12 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 	}
 
 	ret = fsl_lpspi_txfifo_empty(fsl_lpspi);
+	if (ret)
+		return ret;
+
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
 
-	return ret;
+	return 0;
 }
 
 static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
