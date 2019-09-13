From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 10/15] spi: use new `spi_transfer_delay` helper where straightforward
Date: Fri, 13 Sep 2019 14:45:45 +0300
Message-ID: <20190913114550.956-11-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

For many places in the spi drivers, using the new `spi_transfer_delay`
helper is straightforward.
It's just replacing:
```
  if (t->delay_usecs)
     udelay(t->delay_usecs);
```
with `spi_transfer_delay(t)` which handles both `delay_usecs` and the new
`delay` field.

This change replaces in all places (in the spi drivers)  where this change
is simple.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-atmel.c          |  3 +--
 drivers/spi/spi-bcm63xx-hsspi.c  |  3 +--
 drivers/spi/spi-cavium.c         |  3 +--
 drivers/spi/spi-fsl-dspi.c       |  3 +--
 drivers/spi/spi-fsl-espi.c       |  3 +--
 drivers/spi/spi-fsl-spi.c        |  3 +--
 drivers/spi/spi-mpc512x-psc.c    |  3 +--
 drivers/spi/spi-mpc52xx-psc.c    |  3 +--
 drivers/spi/spi-omap-100k.c      |  3 +--
 drivers/spi/spi-pl022.c          | 25 +++++++++++--------------
 drivers/spi/spi-sc18is602.c      |  3 +--
 drivers/spi/spi-sh-hspi.c        |  3 +--
 drivers/spi/spi-tegra20-sflash.c |  2 +-
 drivers/spi/spi-topcliff-pch.c   |  7 +------
 drivers/spi/spi-txx9.c           |  3 +--
 drivers/spi/spi-xcomm.c          |  3 +--
 16 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 009bb4fb5e5f..f51af930c7a4 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1389,8 +1389,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay(xfer);
 
 	if (xfer->cs_change) {
 		if (list_is_last(&xfer->transfer_list,
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9a06ffdb73b8..d9f5c241e2aa 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -291,8 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (t->cs_change)
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index 5aaf21582cb5..db7f5f94c525 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -119,8 +119,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 			*rx_buf++ = (u8)v;
 		}
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay(xfer);
 
 	return xfer->len;
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..0b761352c16a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -752,8 +752,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			dspi->waitflags = 0;
 		}
 
-		if (transfer->delay_usecs)
-			udelay(transfer->delay_usecs);
+		spi_transfer_delay(transfer);
 	}
 
 out:
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f20326714b9d..a3af12127c40 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -427,8 +427,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	ret = fsl_espi_bufs(spi, trans);
 
-	if (trans->delay_usecs)
-		udelay(trans->delay_usecs);
+	spi_transfer_delay(trans);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1d9b33aa1a3b..9352b127d5b8 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -417,8 +417,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index a337b842ae8c..329bbdd1f15f 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -311,8 +311,7 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 			break;
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change)
 			mpc512x_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index c7e478b9b586..dd79d7fd3687 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -234,8 +234,7 @@ static void mpc52xx_psc_spi_work(struct work_struct *work)
 				break;
 			m->actual_length += t->len;
 
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+			spi_transfer_delay(t);
 
 			if (cs_change)
 				mpc52xx_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index b955ca8796d2..eb5b51bd5126 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -321,8 +321,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			}
 		}
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		/* ignore the "leave it on after last xfer" hint */
 
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 7fedea67159c..42cf800073e4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -485,12 +485,11 @@ static void giveback(struct pl022 *pl022)
 					struct spi_transfer, transfer_list);
 
 	/* Delay if requested before any change in chip select */
-	if (last_transfer->delay_usecs)
-		/*
-		 * FIXME: This runs in interrupt context.
-		 * Is this really smart?
-		 */
-		udelay(last_transfer->delay_usecs);
+	/*
+	 * FIXME: This runs in interrupt context.
+	 * Is this really smart?
+	 */
+	spi_transfer_delay(last_transfer);
 
 	if (!last_transfer->cs_change) {
 		struct spi_message *next_msg;
@@ -1401,12 +1400,11 @@ static void pump_transfers(unsigned long data)
 		previous = list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
 					transfer_list);
-		if (previous->delay_usecs)
-			/*
-			 * FIXME: This runs in interrupt context.
-			 * Is this really smart?
-			 */
-			udelay(previous->delay_usecs);
+		/*
+		 * FIXME: This runs in interrupt context.
+		 * Is this really smart?
+		 */
+		spi_transfer_delay(previous);
 
 		/* Reselect chip select only if cs_change was requested */
 		if (previous->cs_change)
@@ -1520,8 +1518,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 			previous =
 			    list_entry(transfer->transfer_list.prev,
 				       struct spi_transfer, transfer_list);
-			if (previous->delay_usecs)
-				udelay(previous->delay_usecs);
+			spi_transfer_delay(previous);
 			if (previous->cs_change)
 				pl022_cs_control(pl022, SSP_CHIP_SELECT);
 		} else {
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 11acddc83304..13cb992df712 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -211,8 +211,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 	}
 	m->status = status;
 	spi_finalize_current_message(master);
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 7f73f91d412a..4edad22c222e 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -190,8 +190,7 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cd714a4f52c6..00593096cfed 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -344,7 +344,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 		if (xfer->cs_change && xfer->delay_usecs) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay(xfer);
 		}
 	}
 	ret = 0;
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index f88cbb94ce12..645b086eece8 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1229,12 +1229,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 			"%s:data->current_msg->actual_length=%d\n",
 			__func__, data->current_msg->actual_length);
 
-		/* check for delay */
-		if (data->cur_trans->delay_usecs) {
-			dev_dbg(&data->master->dev, "%s:delay in usec=%d\n",
-				__func__, data->cur_trans->delay_usecs);
-			udelay(data->cur_trans->delay_usecs);
-		}
+		spi_transfer_delay(data->cur_trans);
 
 		spin_lock(&data->lock);
 
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 51759d3fd45f..65aa736783ae 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -248,8 +248,7 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 			len -= count * wsize;
 		}
 		m->actual_length += t->len;
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		if (!cs_change)
 			continue;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index a3496c46cc1b..3aaae32b0384 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -188,8 +188,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay(t);
 
 		is_first = false;
 	}
-- 
2.20.1
