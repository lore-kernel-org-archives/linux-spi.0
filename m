From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/1] drivers: spi: ti-qspi: wait for busy bit clear before data write/read
Date: Wed, 18 Feb 2015 00:33:51 +0530
Message-ID: <1424199831-5518-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Data corruption is seen while reading/writing large data from/to qspi
device because the data register is over written or read before data
is ready which is denoted by busy bit in status register. SO adding
a busy bit check before writing/reading data to/from qspi device.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 884a716..5c06168 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -101,6 +101,7 @@ struct ti_qspi {
 #define QSPI_FLEN(n)			((n - 1) << 0)
 
 /* STATUS REGISTER */
+#define BUSY				0x01
 #define WC				0x02
 
 /* INTERRUPT REGISTER */
@@ -199,6 +200,21 @@ static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 	ti_qspi_write(qspi, ctx_reg->clkctrl, QSPI_SPI_CLOCK_CNTRL_REG);
 }
 
+static inline u32 qspi_is_busy(struct ti_qspi *qspi)
+{
+	u32 stat;
+	unsigned long timeout = jiffies + QSPI_COMPLETION_TIMEOUT;
+
+	stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
+	while ((stat & BUSY) && time_after(timeout, jiffies)) {
+		cpu_relax();
+		stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
+	}
+
+	WARN(stat & BUSY, "qspi busy\n");
+	return stat & BUSY;
+}
+
 static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	int wlen, count;
@@ -211,6 +227,9 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
+		if (qspi_is_busy(qspi))
+			return -EBUSY;
+
 		switch (wlen) {
 		case 1:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
@@ -266,6 +285,9 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
+		if (qspi_is_busy(qspi))
+			return -EBUSY;
+
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 		if (!wait_for_completion_timeout(&qspi->transfer_complete,
 						 QSPI_COMPLETION_TIMEOUT)) {
-- 
2.2.1.62.g3f15098

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
