From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] spi: detect wrong transfer->len values
Date: Fri, 23 Sep 2011 13:59:18 +0200
Message-ID: <1316779158-12578-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Helmut Raiger <helmut.raiger@hale.at>


Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/spi/spi.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4d1b9f5..70adac3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -760,6 +760,17 @@ EXPORT_SYMBOL_GPL(spi_setup);
 static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
+	struct spi_transfer *xfer;
+
+	/* check if number of bytes relates to bits per word mode */
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		u8 bpw = xfer->bits_per_word ?
+				xfer->bits_per_word : spi->bits_per_word;
+
+		if ((bpw == 16 && (xfer->len & 1)) ||
+			(bpw == 32 && (xfer->len & 3)))
+			return -EINVAL;
+	}
 
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
@@ -768,7 +779,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	 */
 	if ((master->flags & SPI_MASTER_HALF_DUPLEX)
 			|| (spi->mode & SPI_3WIRE)) {
-		struct spi_transfer *xfer;
 		unsigned flags = master->flags;
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list) {
-- 
1.7.6.2



--
Scanned by MailScanner.
