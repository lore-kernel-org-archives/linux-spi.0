From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: improve check for SPI_QE_CPU_MODE" to the spi tree
Date: Fri, 28 Oct 2016 19:53:52 +0100
Message-ID: <E1c0CHo-0006BA-M0@finisterre>
References: <0b5e7849-88d6-2af5-a428-eeb0de0f2af2@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b5e7849-88d6-2af5-a428-eeb0de0f2af2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: improve check for SPI_QE_CPU_MODE

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

>From e9e128a69af2b5fd2a4e01a59cc7e479ce9b8813 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 27 Oct 2016 21:24:01 +0200
Subject: [PATCH] spi: fsl-espi: improve check for SPI_QE_CPU_MODE

SPI_QE_CPU_MODE doesn't exist for ESPI and is set by of_mpc8xxx_spi_probe
based on DT property "mode". This property is not defined for ESPI,
see Documentation/devicetree/bindings/spi/fsl-spi.txt.
So print an error message and bail out if SPI_QE_CPU_MODE is set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4e8a99d0cb63..f04c2464e854 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -583,8 +583,9 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 		goto err_probe;
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-		mpc8xxx_spi->rx_shift = 16;
-		mpc8xxx_spi->tx_shift = 24;
+		dev_err(dev, "SPI_QE_CPU_MODE is not supported on ESPI!\n");
+		ret = -EINVAL;
+		goto err_probe;
 	}
 
 	/* SPI controller initializations */
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
