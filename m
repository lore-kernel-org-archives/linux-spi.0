From: Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH] spi: Fix incomplete handling of SPI_MASTER_MUST_RX/_MUST_TX
Date: Mon, 1 Feb 2016 15:39:23 -0700
Message-ID: <1454366363-10564-1-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>,
	Joshua Henderson <joshua.henderson@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
To: <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Purna Chandra Mandal <purna.mandal@microchip.com>

There is a BUG in the way SPI_MASTER_MUST_RX/TX is implemented which can create
a kernel crash. To simplify design spi driver can specify *_MUST_RX during
registration. In these cases spi core do allocate & assign dummy RX buffer (of
right size) with the transfer if the transfer has NULL 'rx_buf'; at later point
the dummy buffer is free'd when the spi transfer (actually message containing
the transfer) is handled by respective master driver and no other spi messages
pending with the spi core.

This is where BUG is hiding!
(1) spi core assigns dummy_rx buffer to transfer.rx_buf member and
(2) passes it to lower layer for handling. and lower layer completed the
    transfer/message in due time.
(3) spi core deletes the buffer if no other requests pending, but
    'transfer.rx_buf' continues to hold *stale* dummy buffer pointer.
(4) If spi client driver (like mmc_spi) reuses the same transfer structure and
    don't touch .rx_buf to NULL

mmc_spi doesn't reset the ptr unless data transfer direction changes in future
transaction(s). spi core will skip assigning new dummy buffer and underlying
master driver will treat .rx_buf as legitimate ptr. This will result into memory
corruption due to usage of free'd ptr.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/spi/spi.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff80..deabd6f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -819,6 +819,15 @@ static int __spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	struct spi_transfer *xfer;
 	struct device *tx_dev, *rx_dev;
 
+	if (master->flags & (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX)) {
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			if (xfer->rx_buf == master->dummy_rx)
+				xfer->rx_buf = NULL;
+			if (xfer->tx_buf == master->dummy_tx)
+				xfer->tx_buf = NULL;
+		}
+	}
+
 	if (!master->cur_msg_mapped || !master->can_dma)
 		return 0;
 
@@ -1264,12 +1273,11 @@ void spi_finalize_current_message(struct spi_master *master)
 	unsigned long flags;
 	int ret;
 
+	spi_unmap_msg(master, master->cur_msg);
 	spin_lock_irqsave(&master->queue_lock, flags);
 	mesg = master->cur_msg;
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 
-	spi_unmap_msg(master, mesg);
-
 	if (master->cur_msg_prepared && master->unprepare_message) {
 		ret = master->unprepare_message(master, mesg);
 		if (ret) {
-- 
1.7.9.5
