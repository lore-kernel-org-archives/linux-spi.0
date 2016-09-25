From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: simplify of_fsl_espi_probe" to the spi tree
Date: Sat, 24 Sep 2016 22:59:26 -0700
Message-ID: <E1bo2TG-0003H0-Kq@finisterre>
References: <5bfd3921-5bb6-b9c3-dc64-3882491bba13@web.de>
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5bfd3921-5bb6-b9c3-dc64-3882491bba13-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: simplify of_fsl_espi_probe

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

>From acf692190f972ee2ed6578f30278f21c244d6148 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>
Date: Sat, 17 Sep 2016 15:43:00 +0200
Subject: [PATCH] spi: fsl-espi: simplify of_fsl_espi_probe

Simplify of_fsl_espi_probe.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4f9d9ec6880a..dee3f822cea8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -685,7 +685,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	struct spi_master *master;
 	struct resource mem;
 	unsigned int irq;
-	int ret = -ENOMEM;
+	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -693,28 +693,21 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 
 	ret = of_fsl_espi_get_chipselects(dev);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!irq)
+		return -EINVAL;
 
 	master = fsl_espi_probe(dev, &mem, irq);
-	if (IS_ERR(master)) {
-		ret = PTR_ERR(master);
-		goto err;
-	}
+	if (IS_ERR(master))
+		return PTR_ERR(master);
 
 	return 0;
-
-err:
-	return ret;
 }
 
 static int of_fsl_espi_remove(struct platform_device *dev)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
