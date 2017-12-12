From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: Initialize dspi->done before any possible use of it" to the spi tree
Date: Tue, 12 Dec 2017 11:17:07 +0000
Message-ID: <E1eOiYd-0007yj-1c@debutante>
References: <20171212101048.28278-2-michele.dionisio@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171212101048.28278-2-michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: Initialize dspi->done before any possible use of it

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

>From 87248dc79236575908568810a61e0953f738516f Mon Sep 17 00:00:00 2001
From: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 12 Dec 2017 11:36:59 +0100
Subject: [PATCH] spi: davinci: Initialize dspi->done before any possible use
 of it

On SOC with multiple cpu (like omal l138) it is possible that spi
periferic is already initialized when this module is loaded and so
it is possible to recieve interrupt when the modules is not fully
initialized.

this patch initialize dspi->done before refister the interrupt
handler that use it

Signed-off-by: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 6ddb6ef1fda4..60d59b003aa4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -945,6 +945,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
+	init_completion(&dspi->done);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret == 0)
 		ret = -EINVAL;
@@ -1021,8 +1023,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	dspi->get_rx = davinci_spi_rx_buf_u8;
 	dspi->get_tx = davinci_spi_tx_buf_u8;
 
-	init_completion(&dspi->done);
-
 	/* Reset In/OUT SPI module */
 	iowrite32(0, dspi->base + SPIGCR0);
 	udelay(100);
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
