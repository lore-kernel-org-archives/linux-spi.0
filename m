From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers" to the spi tree
Date: Fri,  3 Nov 2017 11:47:39 +0000 (GMT)
Message-ID: <20171103114739.1F1E344005B@finisterre.ee.mobilebroadband>
References: <20171016102758.22444-1-l.stach@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171016102758.22444-1-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

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

>From 42bdd7061a6e24d7b21d3d21973615fecef544ef Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Mon, 16 Oct 2017 12:27:58 +0200
Subject: [PATCH] spi: fix IDR collision on systems with both fixed and dynamic
 SPI bus numbers

On systems where some controllers get a dynamic ID assigned and some have
a fixed number from DT, the current implemention might run into an IDR
collision if the dynamic controllers gets probed first and get an IDR number,
which is later requested by the controller with the fixed numbering. When
this happens the fixed controller will fail to register with the SPI core.

Fix this by skipping all known alias numbers when assigning the dynamic IDs.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 759c9725495a..3ff0ee88c467 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -45,7 +45,6 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
-#define SPI_DYN_FIRST_BUS_NUM 0
 
 static DEFINE_IDR(spi_master_idr);
 
@@ -2086,7 +2085,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	struct device		*dev = ctlr->dev.parent;
 	struct boardinfo	*bi;
 	int			status = -ENODEV;
-	int			id;
+	int			id, first_dynamic;
 
 	if (!dev)
 		return -ENODEV;
@@ -2116,9 +2115,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 	if (ctlr->bus_num < 0) {
+		first_dynamic = of_alias_get_highest_id("spi");
+		if (first_dynamic < 0)
+			first_dynamic = 0;
+		else
+			first_dynamic++;
+
 		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, SPI_DYN_FIRST_BUS_NUM, 0,
-			       GFP_KERNEL);
+		id = idr_alloc(&spi_master_idr, ctlr, first_dynamic,
+			       0, GFP_KERNEL);
 		mutex_unlock(&board_lock);
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
