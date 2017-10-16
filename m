From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
Date: Mon, 16 Oct 2017 12:27:58 +0200
Message-ID: <20171016102758.22444-1-l.stach@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On systems where some controllers get a dynamic ID assigned and some have
a fixed number from DT, the current implemention might run into an IDR
collision if the dynamic controllers gets probed first and get an IDR number,
which is later requested by the controller with the fixed numbering. When
this happens the fixed controller will fail to register with the SPI core.

Fix this by skipping all known alias numbers when assigning the dynamic IDs.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
v2: fix regression when no aliases are present
---
 drivers/spi/spi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..e8b5a5e21b2e 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
