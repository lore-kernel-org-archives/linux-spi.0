From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 02/09] spi: fsl-espi: fix and improve writing to TX FIFO
Date: Thu, 27 Oct 2016 21:25:58 +0200
Message-ID: <28a574e1-934c-d064-4176-5a823d02416b@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This change addresses two issues:
- If the TX FIFO is full the ISR polls until there's free space again.
  An ISR should never wait for something.
- Currently the number of bytes to transfer is rounded up to the next
  multiple of 4. For most transfers therefore few bytes remain in the
  TX FIFO after end of transfer.
  This would cause the next transfer to fail and as a workaround the
  ESPI block is disabled / re-enabled in fsl_espi_change_mode.
  This seems to clear the FIFO's (although it's not mentioned in the
  spec).

With this change the TX FIFO is filled as much as possible initially
and whenever the ISR is called. Also the exact number of bytes is
transferred.
The spinlock protects against a potential race if the first interrupt
occurs whilst the TX FIFO is still being initially filled.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 68 ++++++++++++++++++++++++++++------------------
 drivers/spi/spi-fsl-lib.h  |  2 ++
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f04c246..95c1fbf 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -54,6 +54,8 @@
 #define CSMODE_AFT(x)		((x) << 8)
 #define CSMODE_CG(x)		((x) << 3)
 
+#define FSL_ESPI_FIFO_SIZE	32
+
 /* Default mode/csmode for eSPI controller */
 #define SPMODE_INIT_VAL (SPMODE_TXTHR(4) | SPMODE_RXTHR(3))
 #define CSMODE_INIT_VAL (CSMODE_POL_1 | CSMODE_BEF(0) \
@@ -200,6 +202,27 @@ static int fsl_espi_check_message(struct spi_message *m)
 	return 0;
 }
 
+static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
+{
+	u32 tx_fifo_avail;
+
+	/* if events is zero transfer has not started and tx fifo is empty */
+	tx_fifo_avail = events ? SPIE_TXCNT(events) :  FSL_ESPI_FIFO_SIZE;
+
+	while (tx_fifo_avail >= min(4U, mspi->tx_len) && mspi->tx_len)
+		if (mspi->tx_len >= 4) {
+			fsl_espi_write_reg(mspi, ESPI_SPITF, *(u32 *)mspi->tx);
+			mspi->tx += 4;
+			mspi->tx_len -= 4;
+			tx_fifo_avail -= 4;
+		} else {
+			fsl_espi_write_reg8(mspi, ESPI_SPITF, *(u8 *)mspi->tx);
+			mspi->tx += 1;
+			mspi->tx_len -= 1;
+			tx_fifo_avail -= 1;
+		}
+}
+
 static void fsl_espi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
@@ -262,7 +285,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	int ret;
 
 	mpc8xxx_spi->len = t->len;
-	mpc8xxx_spi->count = roundup(t->len, 4) / 4;
+	mpc8xxx_spi->tx_len = t->len;
 
 	mpc8xxx_spi->tx = t->tx_buf;
 	mpc8xxx_spi->rx = t->rx_buf;
@@ -276,21 +299,22 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* enable rx ints */
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_RNE);
 
-	/* transmit word */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPITF, *(u32 *)mpc8xxx_spi->tx);
-	mpc8xxx_spi->tx += 4;
+	/* Prevent filling the fifo from getting interrupted */
+	spin_lock_irq(&mpc8xxx_spi->lock);
+	fsl_espi_fill_tx_fifo(mpc8xxx_spi, 0);
+	spin_unlock_irq(&mpc8xxx_spi->lock);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
 	if (ret == 0)
 		dev_err(mpc8xxx_spi->dev,
-			"Transaction hanging up (left %d bytes)\n",
-			mpc8xxx_spi->count);
+			"Transaction hanging up (left %u bytes)\n",
+			mpc8xxx_spi->tx_len);
 
 	/* disable rx ints */
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
 
-	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
+	return mpc8xxx_spi->tx_len > 0 ? -EMSGSIZE : 0;
 }
 
 static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
@@ -461,26 +485,11 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		}
 	}
 
-	if (!(events & SPIE_TNF)) {
-		int ret;
-
-		/* spin until TX is done */
-		ret = spin_event_timeout(((events = fsl_espi_read_reg(
-				mspi, ESPI_SPIE)) & SPIE_TNF), 1000, 0);
-		if (!ret) {
-			dev_err(mspi->dev, "tired waiting for SPIE_TNF\n");
-			complete(&mspi->done);
-			return;
-		}
-	}
+	if (mspi->tx_len)
+		fsl_espi_fill_tx_fifo(mspi, events);
 
-	mspi->count -= 1;
-	if (mspi->count) {
-		fsl_espi_write_reg(mspi, ESPI_SPITF, *(u32 *)mspi->tx);
-		mspi->tx += 4;
-	} else {
+	if (!mspi->tx_len && !mspi->len)
 		complete(&mspi->done);
-	}
 }
 
 static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
@@ -488,10 +497,14 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	struct mpc8xxx_spi *mspi = context_data;
 	u32 events;
 
+	spin_lock(&mspi->lock);
+
 	/* Get interrupt events(tx/rx) */
 	events = fsl_espi_read_reg(mspi, ESPI_SPIE);
-	if (!events)
+	if (!events) {
+		spin_unlock_irq(&mspi->lock);
 		return IRQ_NONE;
+	}
 
 	dev_vdbg(mspi->dev, "%s: events %x\n", __func__, events);
 
@@ -500,6 +513,8 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	/* Clear the events */
 	fsl_espi_write_reg(mspi, ESPI_SPIE, events);
 
+	spin_unlock(&mspi->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -562,6 +577,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	master->max_message_size = fsl_espi_max_message_size;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
+	spin_lock_init(&mpc8xxx_spi->lock);
 
 	mpc8xxx_spi->local_buf =
 		devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 2925c80..24d8bc8 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -30,7 +30,9 @@ struct mpc8xxx_spi {
 	void *rx;
 #if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
 	int len;
+	unsigned int tx_len;
 	u8 *local_buf;
+	spinlock_t lock;
 #endif
 
 	int subblock;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
