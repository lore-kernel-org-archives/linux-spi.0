From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xlp: Enable SPI driver for Broadcom Vulcan ARM64" to the spi tree
Date: Wed, 23 Mar 2016 13:43:12 +0000
Message-ID: <E1aij44-0004Hg-6I@debutante>
References: <1458652094-4484-1-git-send-email-kamlakant.patel@broadcom.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458652094-4484-1-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xlp: Enable SPI driver for Broadcom Vulcan ARM64

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

>From bf23d1917d551487e85378c4f4a7a0efcfe77f4e Mon Sep 17 00:00:00 2001
From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Date: Tue, 22 Mar 2016 18:38:14 +0530
Subject: [PATCH] spi: xlp: Enable SPI driver for Broadcom Vulcan ARM64

- Vulcan spi controller is compatible with netlogic,xlp832-spi.
- Add depends on ARCH_VULCAN to Kconfig to enable spi controller
  driver for Broadcom Vulcan ARM64 SoCs.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9d8c84bb1544..6536068ce74f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -656,7 +656,7 @@ config SPI_XILINX
 
 config SPI_XLP
 	tristate "Netlogic XLP SPI controller driver"
-	depends on CPU_XLP || COMPILE_TEST
+	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Netlogic XLP SoCs.
 	  Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX, XLP9XX
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
