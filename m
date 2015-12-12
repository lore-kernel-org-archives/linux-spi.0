From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: fix spurious i/o error" to the spi tree
Date: Sat, 12 Dec 2015 23:08:09 +0000
Message-ID: <E1a7tGr-0002tQ-De@finisterre>
References: <fbcc972e6612cf3d069e7230dd078d8a1e0e2e5a.1449764266.git.nsekhar@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fbcc972e6612cf3d069e7230dd078d8a1e0e2e5a.1449764266.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: fix spurious i/o error

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

>From 7f3ac71ac3b05aaa2c55c266448f973188275a8c Mon Sep 17 00:00:00 2001
From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Date: Thu, 10 Dec 2015 21:59:04 +0530
Subject: [PATCH] spi: davinci: fix spurious i/o error

davinci_spi_bufs() uses wait_for_completion_interruptible()
without bothering to handle -ERESTARTSYS. Due to this,
sometime, it returns prematurely when a signal is received.
Since the return value is never checked, userspace eventually
receives a spurious -EIO.

To fix this, use un-interruptible wait_for_completion_timeout().

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7d3af3e..57d6960 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -703,7 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	/* Wait for the transfer to complete */
 	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
-		wait_for_completion_interruptible(&(dspi->done));
+		if (wait_for_completion_timeout(&dspi->done, HZ) == 0)
+			errors = SPIFLG_TIMEOUT_MASK;
 	} else {
 		while (dspi->rcount > 0 || dspi->wcount > 0) {
 			errors = davinci_spi_process_events(dspi);
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
