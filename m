From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: [PATCH 4/5] spi-topcliff-pch: Add recovery processing in case FIFO
	overrun error occurs
Date: Tue,  6 Sep 2011 16:58:33 +0900
Message-ID: <1315295914-6862-4-git-send-email-tomoya-linux@dsn.okisemi.com>
References: <1315295914-6862-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>,
	toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1315295914-6862-1-git-send-email-tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add recovery processing in case FIFO overrun error occurs with DMA transfer mode.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index c4d6fb9..5be1142 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -355,15 +355,25 @@ static irqreturn_t pch_spi_handler(int irq, void *dev_id)
 			"%s returning due to suspend\n", __func__);
 		return IRQ_NONE;
 	}
-	if (data->use_dma)
-		return IRQ_NONE;
 
 	io_remap_addr = data->io_remap_addr;
 	spsr = io_remap_addr + PCH_SPSR;

 	reg_spsr_val = ioread32(spsr);
 
-	if (reg_spsr_val & SPSR_ORF_BIT)
-		dev_err(&board_dat->pdev->dev, "%s Over run error", __func__);
+	if (reg_spsr_val & SPSR_ORF_BIT) {
+		dev_err(&board_dat->pdev->dev, "%s Over run error\n", __func__);
+		if (data->current_msg->complete != 0) {
+			data->transfer_complete = true;
+			data->current_msg->status = -EIO;
+			data->current_msg->complete(data->current_msg->context);
+			data->bcurrent_msg_processing = false;
+			data->current_msg = NULL;
+			data->cur_trans = NULL;
+		}
+	}
+
+	if (data->use_dma)
+		return IRQ_NONE;
 
 	/* Check if the interrupt is for SPI device */
 	if (reg_spsr_val & (SPSR_FI_BIT | SPSR_RFI_BIT)) {
@@ -817,10 +827,11 @@ static void pch_spi_copy_rx_data_for_dma(struct pch_spi_data *data, int bpw)
 	}
 }
 
-static void pch_spi_start_transfer(struct pch_spi_data *data)
+static int pch_spi_start_transfer(struct pch_spi_data *data)
 {
 	struct pch_spi_dma_ctrl *dma;
 	unsigned long flags;
+	int rtn;
 
 	dma = &data->dma;
 
@@ -835,7 +846,9 @@ static void pch_spi_start_transfer(struct pch_spi_data *data)
 				 initiating the transfer. */
 	dev_dbg(&data->master->dev,
 		"%s:waiting for transfer to get over\n", __func__);
-	wait_event_interruptible(data->wait, data->transfer_complete);
+	rtn = wait_event_interruptible_timeout(data->wait,
+					       data->transfer_complete,
+					       msecs_to_jiffies(2 * HZ));
 
 	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_rx_p, dma->nent,
 			    DMA_FROM_DEVICE);
@@ -862,6 +875,8 @@ static void pch_spi_start_transfer(struct pch_spi_data *data)
 	pch_spi_clear_fifo(data->master);
 
 	spin_unlock_irqrestore(&data->lock, flags);
+
+	return rtn;
 }
 
 static void pch_dma_rx_complete(void *arg)
@@ -1182,7 +1197,8 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 
 		if (data->use_dma) {
 			pch_spi_handle_dma(data, &bpw);
-			pch_spi_start_transfer(data);
+			if (!pch_spi_start_transfer(data))
+				goto out;
 			pch_spi_copy_rx_data_for_dma(data, bpw);
 		} else {
 			pch_spi_set_tx(data, &bpw);
@@ -1218,6 +1234,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 
 	} while (data->cur_trans != NULL);
 
+out:
 	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_HIGH);
 	if (data->use_dma)
 		pch_spi_release_dma(data);
-- 
1.7.4.4


------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
