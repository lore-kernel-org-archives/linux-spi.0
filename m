From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm53xx: Adjust devm usage" to the spi tree
Date: Wed, 16 Sep 2015 21:02:16 +0100
Message-ID: <E1ZcIuG-00085b-V2@finisterre>
References: <20150820175838.GA4895@localhost>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150820175838.GA4895@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm53xx: Adjust devm usage

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

>From 6774eea6d7a61616384743b218cf77f322e060d9 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 20 Aug 2015 23:28:38 +0530
Subject: [PATCH] spi: bcm53xx: Adjust devm usage

Remove use of spi_unregister_master in remove function as
devm_spi_register_master in probe function automatically
handles it. To be compatible with the change, use direct
return instead of goto and remove unnedded label out.

Also, remove bcm53xxspi_bcma_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm53xx.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index 1520554..cc3f938 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -247,28 +247,19 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 	if (err) {
 		spi_master_put(master);
 		bcma_set_drvdata(core, NULL);
-		goto out;
+		return err;
 	}
 
 	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only */
 	spi_new_device(master, &bcm53xx_info);
 
-out:
-	return err;
-}
-
-static void bcm53xxspi_bcma_remove(struct bcma_device *core)
-{
-	struct bcm53xxspi *b53spi = bcma_get_drvdata(core);
-
-	spi_unregister_master(b53spi->master);
+	return 0;
 }
 
 static struct bcma_driver bcm53xxspi_bcma_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= bcm53xxspi_bcma_tbl,
 	.probe		= bcm53xxspi_bcma_probe,
-	.remove		= bcm53xxspi_bcma_remove,
 };
 
 /**************************************************
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
