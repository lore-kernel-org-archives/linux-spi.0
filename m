From: Jiwei Sun <jiwei.sun@windriver.com>
Subject: [PATCH]spi: pl022: add a message state STATE_TIMEOUT for timeout transfer
Date: Fri, 18 Jan 2019 11:32:29 +0800
Message-ID: <20190118033229.22553-1-jiwei.sun@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
To: <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When transfer timeout, give -EAGAIN to the message's status, and it can
make the spi device driver choose repeated transimation or not. And if
transfer timeout, output some useful information for tracing the issue.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
 drivers/spi/spi-pl022.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c793e31d60f..26684178786f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -253,6 +253,7 @@
 #define STATE_RUNNING			((void *) 1)
 #define STATE_DONE			((void *) 2)
 #define STATE_ERROR			((void *) -1)
+#define STATE_TIMEOUT			((void *) -2)
 
 /*
  * SSP State - Whether Enabled or Disabled
@@ -1484,6 +1485,30 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
 }
 
+static void print_current_status(struct pl022 *pl022)
+{
+	u32 read_cr0;
+	u16 read_cr1, read_dmacr, read_sr;
+
+	if (pl022->vendor->extended_cr)
+		read_cr0 = readl(SSP_CR0(pl022->virtbase));
+	else
+		read_cr0 = readw(SSP_CR0(pl022->virtbase));
+	read_cr1 = readw(SSP_CR1(pl022->virtbase));
+	read_dmacr = readw(SSP_DMACR(pl022->virtbase));
+	read_sr = readw(SSP_SR(pl022->virtbase));
+
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR0: %x\n", read_cr0);
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR1: %x\n", read_cr1);
+	dev_warn(&pl022->adev->dev, "spi-pl022 DMACR: %x\n", read_dmacr);
+	dev_warn(&pl022->adev->dev, "spi-pl022 SR: %x\n", read_sr);
+	dev_warn(&pl022->adev->dev,
+			"spi-pl022 exp_fifo_level/fifodepth: %u/%d\n",
+			pl022->exp_fifo_level,
+			pl022->vendor->fifodepth);
+
+}
+
 static void do_polling_transfer(struct pl022 *pl022)
 {
 	struct spi_message *message = NULL;
@@ -1535,7 +1560,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 			if (time_after(time, timeout)) {
 				dev_warn(&pl022->adev->dev,
 				"%s: timeout!\n", __func__);
-				message->state = STATE_ERROR;
+				message->state = STATE_TIMEOUT;
+				print_current_status(pl022);
 				goto out;
 			}
 			cpu_relax();
@@ -1553,6 +1579,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 	/* Handle end of message */
 	if (message->state == STATE_DONE)
 		message->status = 0;
+	else if (message->state == STATE_TIMEOUT)
+		message->status = -EAGAIN;
 	else
 		message->status = -EIO;
 
-- 
2.20.1
