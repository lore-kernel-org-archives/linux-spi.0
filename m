From: sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org
Subject: [PATCH] drivers: spi: Allocate bus number from spi framework
Date: Fri, 18 Aug 2017 11:13:40 +0530
Message-ID: <1503035020-4347-1-git-send-email-sunil.m@techveda.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org, Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>

spi framework should allocate bus number dynamically either
via Linux IDR or spi alias for master drivers. This patch deletes
code pertaining to manual allocation of spi bus number in spi omap2
master driver.

Signed-off-by: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Tested-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on next-20170817.
- Patch was hardware tested on AM335x (McSPI controller) with
  spi flash chips.
- Added spi aliases in aliases node, device tree and tested.
- No build/run-time issues reported.
- The commit:
"spi: Pick spi bus number from Linux idr or spi alias"
(SHA1:9b61e302210eba55768962f2f11e96bb508c2408)
has introduced bus numbering which happens dynamically either
via Linux IDR or spi alias for master drivers.
---
 drivers/spi/spi-omap2-mcspi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e048268..9bf64e6 100644
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
