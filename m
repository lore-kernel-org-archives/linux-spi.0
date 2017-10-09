From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: tegra114: correct register name in definition" to the spi tree
Date: Mon, 09 Oct 2017 11:44:39 +0100
Message-ID: <E1e1VY7-0001lb-3m@debutante>
References: <20171005112236.4242-1-ralf.ramsauer@oth-regensburg.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171005112236.4242-1-ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: correct register name in definition

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

>From 979a9afe399f7c75e1be9f235fa8bf1a90d2e77d Mon Sep 17 00:00:00 2001
From: Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
Date: Thu, 5 Oct 2017 13:22:36 +0200
Subject: [PATCH] spi: tegra114: correct register name in definition

According to "Tegra K1 Processor Technical Reference Manual" (p. 2448),
bit 20 of SPI_COMMAND1 is called CS_SW_VAL and not CS_SS_VAL.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 44550182a4a3..a76acedd7e2f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -50,7 +50,7 @@
 #define SPI_IDLE_SDA_PULL_LOW			(2 << 18)
 #define SPI_IDLE_SDA_PULL_HIGH			(3 << 18)
 #define SPI_IDLE_SDA_MASK			(3 << 18)
-#define SPI_CS_SS_VAL				(1 << 20)
+#define SPI_CS_SW_VAL				(1 << 20)
 #define SPI_CS_SW_HW				(1 << 21)
 /* SPI_CS_POL_INACTIVE bits are default high */
 						/* n from 0 to 3 */
@@ -705,9 +705,9 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SS_VAL;
+			command1 |= SPI_CS_SW_VAL;
 		else
-			command1 &= ~SPI_CS_SS_VAL;
+			command1 &= ~SPI_CS_SW_VAL;
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
-- 
2.14.1
