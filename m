From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap: Allocate bus number from spi framework" to the spi tree
Date: Fri, 18 Aug 2017 12:49:10 +0100
Message-ID: <E1difm2-00011V-L5@finisterre>
References: <1503035020-4347-1-git-send-email-sunil.m@techveda.org>
Cc: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503035020-4347-1-git-send-email-sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap: Allocate bus number from spi framework

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

>From b590782afe0a99fca84f451252ed7e2d64b2f155 Mon Sep 17 00:00:00 2001
From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Date: Fri, 18 Aug 2017 11:13:40 +0530
Subject: [PATCH] spi: omap: Allocate bus number from spi framework

spi framework should allocate bus number dynamically either
via Linux IDR or spi alias for master drivers. This patch deletes
code pertaining to manual allocation of spi bus number in spi omap2
master driver.

Signed-off-by: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Tested-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e048268d8ba2..9bf64e6eca9b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1338,7 +1338,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int			status = 0, i;
 	u32			regs_offset = 0;
-	static int		bus_num = 1;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 
@@ -1374,14 +1373,11 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
 		master->num_chipselect = num_cs;
-		master->bus_num = bus_num++;
 		if (of_get_property(node, "ti,pindir-d0-out-d1-in", NULL))
 			mcspi->pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
 	} else {
 		pdata = dev_get_platdata(&pdev->dev);
 		master->num_chipselect = pdata->num_cs;
-		if (pdev->id != -1)
-			master->bus_num = pdev->id;
 		mcspi->pin_dir = pdata->pin_dir;
 	}
 	regs_offset = pdata->regs_offset;
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
