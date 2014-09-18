From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 07/10] spi: dw: fix style of code in few places
Date: Thu, 18 Sep 2014 20:08:57 +0300
Message-ID: <1411060140-2801-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411060140-2801-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make comments be surrounded by spaces and move part of code to one line where
it suits 80 characters.

There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 54e195b..11c7613 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -397,7 +397,7 @@ static void pump_transfers(unsigned long data)
 		goto early_exit;
 	}
 
-	/* Delay if requested at end of transfer*/
+	/* Delay if requested at end of transfer */
 	if (message->state == RUNNING_STATE) {
 		previous = list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
@@ -528,7 +528,7 @@ static int dw_spi_transfer_one_message(struct spi_master *master,
 	struct dw_spi *dws = spi_master_get_devdata(master);
 
 	dws->cur_msg = msg;
-	/* Initial message state*/
+	/* Initial message state */
 	dws->cur_msg->state = START_STATE;
 	dws->cur_transfer = list_entry(dws->cur_msg->transfers.next,
 						struct spi_transfer,
@@ -659,8 +659,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->prev_chip = NULL;
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
-	snprintf(dws->name, sizeof(dws->name), "dw_spi%d",
-			dws->bus_num);
+	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 
 	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
 			dws->name, dws);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
