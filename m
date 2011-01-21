From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] SPI: spi_sh_msiof: consolidate data in 8-bit mode into
 32-bit words
Date: Fri, 21 Jan 2011 16:56:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101211655270.18867@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Instead of sending data 8 bits at a time in 8-bit SPI mode, swap bytes
and send and receive them 32 bits at a time. Tested with an SD-card,
with which this patch reduced the number of interrupts by 50%, when
reading 5MiB of data (there are also small service packets, the number
of interrupts, produced by 512-byte sectors should, of course, drop by
75%), and improved throughput by more than 40%.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_sh_msiof.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 07b4ead..658bd05 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -267,6 +267,26 @@ static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
 		sh_msiof_write(p, TFDR, get_unaligned(&buf_32[k]) << fs);
 }
 
+static void sh_msiof_spi_write_fifo_s32(struct sh_msiof_spi_priv *p,
+					const void *tx_buf, int words, int fs)
+{
+	const u32 *buf_32 = tx_buf;
+	int k;
+
+	for (k = 0; k < words; k++)
+		sh_msiof_write(p, TFDR, swab32(buf_32[k] << fs));
+}
+
+static void sh_msiof_spi_write_fifo_s32u(struct sh_msiof_spi_priv *p,
+					 const void *tx_buf, int words, int fs)
+{
+	const u32 *buf_32 = tx_buf;
+	int k;
+
+	for (k = 0; k < words; k++)
+		sh_msiof_write(p, TFDR, swab32(get_unaligned(&buf_32[k]) << fs));
+}
+
 static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
 				     void *rx_buf, int words, int fs)
 {
@@ -317,6 +337,26 @@ static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
 		put_unaligned(sh_msiof_read(p, RFDR) >> fs, &buf_32[k]);
 }
 
+static void sh_msiof_spi_read_fifo_s32(struct sh_msiof_spi_priv *p,
+				       void *rx_buf, int words, int fs)
+{
+	u32 *buf_32 = rx_buf;
+	int k;
+
+	for (k = 0; k < words; k++)
+		buf_32[k] = swab32(sh_msiof_read(p, RFDR) >> fs);
+}
+
+static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
+				       void *rx_buf, int words, int fs)
+{
+	u32 *buf_32 = rx_buf;
+	int k;
+
+	for (k = 0; k < words; k++)
+		put_unaligned(swab32(sh_msiof_read(p, RFDR) >> fs), &buf_32[k]);
+}
+
 static int sh_msiof_spi_bits(struct spi_device *spi, struct spi_transfer *t)
 {
 	int bits;
@@ -468,9 +508,17 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 	int bytes_done;
 	int words;
 	int n;
+	bool swab;
 
 	bits = sh_msiof_spi_bits(spi, t);
 
+	if (bits <= 8 && t->len > 15 && !(t->len & 3)) {
+		bits = 32;
+		swab = true;
+	} else {
+		swab = false;
+	}
+
 	/* setup bytes per word and fifo read/write functions */
 	if (bits <= 8) {
 		bytes_per_word = 1;
@@ -487,6 +535,17 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 			rx_fifo = sh_msiof_spi_read_fifo_16u;
 		else
 			rx_fifo = sh_msiof_spi_read_fifo_16;
+	} else if (swab) {
+		bytes_per_word = 4;
+		if ((unsigned long)t->tx_buf & 0x03)
+			tx_fifo = sh_msiof_spi_write_fifo_s32u;
+		else
+			tx_fifo = sh_msiof_spi_write_fifo_s32;
+
+		if ((unsigned long)t->rx_buf & 0x03)
+			rx_fifo = sh_msiof_spi_read_fifo_s32u;
+		else
+			rx_fifo = sh_msiof_spi_read_fifo_s32;
 	} else {
 		bytes_per_word = 4;
 		if ((unsigned long)t->tx_buf & 0x03)
-- 
1.7.2.3

