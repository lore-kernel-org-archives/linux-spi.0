From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/3] spi: fix use-after-free at controller deregistration
Date: Mon, 30 Oct 2017 11:35:25 +0100
Message-ID: <20171030103527.13535-1-johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Suniel Mahesh <sunil.m@techveda.org>,
        Karthik Tummala <karthik@techveda.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The controller is typically freed as part of device_unregister() so
store the bus id before deregistration to avoid use-after-free when the
id is later released.

Fixes: 9b61e302210e ("spi: Pick spi bus number from Linux idr or spi alias")
Cc: stable <stable@vger.kernel.org>     # 4.13
Cc: Suniel Mahesh <sunil.m@techveda.org>
Cc: Karthik Tummala <karthik@techveda.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e8b5a5e21b2e..3ff0ee88c467 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2245,11 +2245,12 @@ static int __unregister(struct device *dev, void *null)
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
 	struct spi_controller *found;
+	int id = ctlr->bus_num;
 	int dummy;
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
-	found = idr_find(&spi_master_idr, ctlr->bus_num);
+	found = idr_find(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 	if (found != ctlr) {
 		dev_dbg(&ctlr->dev,
@@ -2269,7 +2270,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, ctlr->bus_num);
+	idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
-- 
2.14.3
