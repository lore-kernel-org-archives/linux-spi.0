From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xtensa-xtfpga: fix register endianness" to the spi tree
Date: Tue, 22 Sep 2015 09:35:05 -0700
Message-ID: <E1ZeQX3-0000bC-Mz@finisterre>
References: <1442921523-1265-1-git-send-email-jcmvbkbc@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442921523-1265-1-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xtensa-xtfpga: fix register endianness

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

>From b0b4855099e301c8603ea37da9a0103a96c2e0b1 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 22 Sep 2015 14:32:03 +0300
Subject: [PATCH] spi: xtensa-xtfpga: fix register endianness

XTFPGA SPI controller has native endian registers.
Fix register acessors so that they work in big-endian configurations.

Signed-off-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-xtensa-xtfpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 2e32ea2..be6155cb 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -34,13 +34,13 @@ struct xtfpga_spi {
 static inline void xtfpga_spi_write32(const struct xtfpga_spi *spi,
 				      unsigned addr, u32 val)
 {
-	iowrite32(val, spi->regs + addr);
+	__raw_writel(val, spi->regs + addr);
 }
 
 static inline unsigned int xtfpga_spi_read32(const struct xtfpga_spi *spi,
 					     unsigned addr)
 {
-	return ioread32(spi->regs + addr);
+	return __raw_readl(spi->regs + addr);
 }
 
 static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
