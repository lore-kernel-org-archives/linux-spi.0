From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] spi: mpc512x_psc_spi.c: Fix build failures
Date: Mon, 31 May 2010 18:34:54 +0200
Message-ID: <1275323694-15614-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Anatolij Gustschin <agust@denx.de>,
	Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fixes build errors caused by the:
 - OF device_node pointer being moved into struct device
 - removal of the match_table field from struct of_platform_driver

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/mpc512x_psc_spi.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
index 28a126d..2534b1e 100644
--- a/drivers/spi/mpc512x_psc_spi.c
+++ b/drivers/spi/mpc512x_psc_spi.c
@@ -512,29 +512,29 @@ static int __init mpc512x_psc_spi_of_probe(struct of_device *op,
 	u64 regaddr64, size64;
 	s16 id = -1;
 
-	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
+	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
 	if (!regaddr_p) {
 		dev_err(&op->dev, "Invalid PSC address\n");
 		return -EINVAL;
 	}
-	regaddr64 = of_translate_address(op->node, regaddr_p);
+	regaddr64 = of_translate_address(op->dev.of_node, regaddr_p);
 
 	/* get PSC id (0..11, used by port_config) */
 	if (op->dev.platform_data == NULL) {
 		const u32 *psc_nump;
 
-		psc_nump = of_get_property(op->node, "cell-index", NULL);
+		psc_nump = of_get_property(op->dev.of_node, "cell-index", NULL);
 		if (!psc_nump || *psc_nump > 11) {
 			dev_err(&op->dev, "mpc512x_psc_spi: Device node %s "
 				"has invalid cell-index property\n",
-				op->node->full_name);
+				op->dev.of_node->full_name);
 			return -EINVAL;
 		}
 		id = *psc_nump;
 	}
 
 	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
-					irq_of_parse_and_map(op->node, 0), id);
+				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
 static int __exit mpc512x_psc_spi_of_remove(struct of_device *op)
@@ -550,12 +550,12 @@ static struct of_device_id mpc512x_psc_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
 
 static struct of_platform_driver mpc512x_psc_spi_of_driver = {
-	.match_table = mpc512x_psc_spi_of_match,
 	.probe = mpc512x_psc_spi_of_probe,
 	.remove = __exit_p(mpc512x_psc_spi_of_remove),
 	.driver = {
 		.name = "mpc512x-psc-spi",
 		.owner = THIS_MODULE,
+		.of_match_table = mpc512x_psc_spi_of_match,
 	},
 };
 
-- 
1.7.0.4
