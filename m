From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 02/17] spi: Adjust checks for null pointers in two functions
Date: Fri, 13 Jan 2017 18:09:52 +0100
Message-ID: <1e19b52a-119a-d52c-3a54-0a533ac5b6db@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 13:23:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8c05f27bf642..d8d273545e54 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -816,7 +816,7 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		if (!master->can_dma(master, msg->spi, xfer))
 			continue;
 
-		if (xfer->tx_buf != NULL) {
+		if (xfer->tx_buf) {
 			ret = spi_map_buf(master, tx_dev, &xfer->tx_sg,
 					  (void *)xfer->tx_buf, xfer->len,
 					  DMA_TO_DEVICE);
@@ -824,7 +824,7 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 				return ret;
 		}
 
-		if (xfer->rx_buf != NULL) {
+		if (xfer->rx_buf) {
 			ret = spi_map_buf(master, rx_dev, &xfer->rx_sg,
 					  xfer->rx_buf, xfer->len,
 					  DMA_FROM_DEVICE);
@@ -3133,7 +3133,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 	switch (of_reconfig_get_state_change(action, arg)) {
 	case OF_RECONFIG_CHANGE_ADD:
 		master = of_find_spi_master_by_node(rd->dn->parent);
-		if (master == NULL)
+		if (!master)
 			return NOTIFY_OK;	/* not for us */
 
 		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
@@ -3159,7 +3159,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 
 		/* find our device by node */
 		spi = of_find_spi_device_by_node(rd->dn);
-		if (spi == NULL)
+		if (!spi)
 			return NOTIFY_OK;	/* no? not meant for us */
 
 		/* unregister takes one ref away */
-- 
2.11.0

