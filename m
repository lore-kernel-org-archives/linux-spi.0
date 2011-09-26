From: Michael Thalmeier <michael.thalmeier-UFQbV3CfTj8@public.gmane.org>
Subject: [PATCH v2] spi: detect wrong transfer->len values
Date: Mon, 26 Sep 2011 10:55:18 +0200
Message-ID: <1317027318-4889-1-git-send-email-michael.thalmeier@hale.at>
References: <20110923233204.GJ24631@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110923233204.GJ24631-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Helmut Raiger <helmut.raiger-UFQbV3CfTj8@public.gmane.org>

Instead of returning an error, which could have unknown consequences for
different drivers, just use dev_WARN_ONCE to output a warning.

Signed-off-by: Michael Thalmeier <michael.thalmeier-UFQbV3CfTj8@public.gmane.org>
---
 drivers/spi/spi.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4d1b9f5..49f6666 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -760,6 +760,20 @@ EXPORT_SYMBOL_GPL(spi_setup);
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
+		dev_WARN_ONCE(&spi->dev,
+				((bpw == 16 && (xfer->len & 1)) ||
+				(bpw == 32 && (xfer->len & 3))),
+				"incorrect number of bytes detected: "
+				"bpw=%u xfer->len=%u", bpw, xfer->len);
+
+	}
 
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
@@ -768,7 +782,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
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


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
