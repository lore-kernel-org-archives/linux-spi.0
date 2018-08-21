From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Tue, 21 Aug 2018 11:53:03 +0200
Message-ID: <20180821095303.27664-1-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the SPI bus number is provided by a DT alias, idr_alloc() is called
twice, leading to:

    WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
    couldn't get idr

Fix this by moving the handling of fixed SPI bus numbers up, before the
DT handling code fills in ctlr->bus_num.

Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
---
 drivers/spi/spi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a00d006d4c3a1c5a..9da0bc5a036cfff6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2143,8 +2143,17 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	if (ctlr->num_chipselect == 0)
 		return -EINVAL;
-	/* allocate dynamic bus number using Linux idr */
-	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
+	if (ctlr->bus_num >= 0) {
+		/* devices with a fixed bus num must check-in with the num */
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+			ctlr->bus_num + 1, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id == -ENOSPC ? -EBUSY : id;
+		ctlr->bus_num = id;
+	} else if (ctlr->dev.of_node) {
+		/* allocate dynamic bus number using Linux idr */
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
 		if (id >= 0) {
 			ctlr->bus_num = id;
@@ -2170,15 +2179,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
-	} else {
-		/* devices with a fixed bus num must check-in with the num */
-		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-			ctlr->bus_num + 1, GFP_KERNEL);
-		mutex_unlock(&board_lock);
-		if (WARN(id < 0, "couldn't get idr"))
-			return id == -ENOSPC ? -EBUSY : id;
-		ctlr->bus_num = id;
 	}
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
-- 
2.17.1
