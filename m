From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix double IDR allocation with DT aliases" to the spi tree
Date: Tue, 28 Aug 2018 21:58:56 +0100 (BST)
Message-ID: <20180828205856.D4A934400A1@finisterre.ee.mobilebroadband>
References: <20180821095303.27664-1-geert+renesas@glider.be>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix double IDR allocation with DT aliases

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

>From 04b2d03a75652bda989de1595048f0501dc0c0a0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 21 Aug 2018 11:53:03 +0200
Subject: [PATCH] spi: Fix double IDR allocation with DT aliases

If the SPI bus number is provided by a DT alias, idr_alloc() is called
twice, leading to:

    WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
    couldn't get idr

Fix this by moving the handling of fixed SPI bus numbers up, before the
DT handling code fills in ctlr->bus_num.

Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a00d006d4c3a..9da0bc5a036c 100644
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
2.18.0
