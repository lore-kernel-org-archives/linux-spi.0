From: Rob Herring <robh@kernel.org>
Subject: [PATCH] SPI: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:41 -0600
Message-ID: <20181205195050.4759-25-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca59406b0b7..d27b6b0dee43 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1644,7 +1644,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 
 	if (spi_controller_is_slave(ctlr)) {
-		if (strcmp(nc->name, "slave")) {
+		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
 				nc);
 			return -EINVAL;
-- 
2.19.1
