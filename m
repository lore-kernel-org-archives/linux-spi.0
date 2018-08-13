From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Subject: [PATCH] spi:fix IDR collision on systems with both fixed and dynamic SPI bus numbers
Date: Mon, 13 Aug 2018 19:48:10 +0300
Message-ID: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
Cc: Kirill Kapranov <kirill.kapranov@compulab.co.il>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, l.stach@pengutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On systems where some controllers get a dynamic ID assigned and some have
a fixed number (e.g. from ACPI tables), the current implementation might
run into an IDR collision: in case of a fixed bus number is gotten by a
driver (but not marked busy in IDR tree) and a driver with dynamic bus
number gets the same ID and predictably fails.

Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
at the moment of the controller registration.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)

Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..97e303185d5b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2170,6 +2170,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
+	} else {
+	/* devices with a fixed bus num must check-in with the num */
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+			ctlr->bus_num + 1, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id == -ENOSPC ? -EBUSY : id;
+		ctlr->bus_num = id;
 	}
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
-- 
2.11.0
