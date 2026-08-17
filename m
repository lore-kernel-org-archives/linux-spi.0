Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5E4418FF;
	Mon, 17 Aug 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980831; cv=none; b=e4psv2TlV2V1Lge6J3tDcSG52pAYwa9EDvb7LhgGlgHdOwA83pOx2vu7cHO8roQjt6sWi5km7X32qpHeb9snyKps7T5+Y5WN66YMPRxrBTv4QW0751Kw0C11iQtO7OjTdpWt5zenCh+5NR4DZMvJeEXzvG+O6LNuMlCsHBvHY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980831; c=relaxed/simple;
	bh=DHNcDhvML/LBf1WRctBcBdL6grMJ2wnCE1hr1Rt1M5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0DtM1kHXMf4/hchLX31acwzXFcoLHCnkL7xkhYuxD9tMguLA0vdHVv3gpkGLeyvn+rg0seTQes4gzhDaRRBzwuS8yM+0/xbOs481YoozezFGsF+Fn4B7peWlgwNdC/c5c1ckbgwDoQnB0oy1/odUpe0Ky0nenmNeOKklcRLfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7Eioy/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7Eioy/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86651F000E9;
	Mon, 17 Aug 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980830;
	bh=VHcFqzwnzlp1DvyKWzM0AgMtWpApqYgQgqhZUvCjGgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7Eioy/yfEJZhccnOthTBck7wd3V7BgK/kiNMaLT024aBwiqqG5e+elpvvXR2PTdX
	 LT4X//GHqALLrYf2IVqqT3fdZNnCXU5GVrT3gDhdY1iNPGk3HsysfbJ6LoTYlARVHu
	 Zi53aw67SUKXDzEF4UEk0MWqVzhX5QrJWTP4N7NrPPBskI+Q3beghqEGdIcLsSE5hw
	 irIbLt9oFY0SROSfBN3VxKUqpXMJI1P8hxMEOEY2PgGjAq11hvpIKTcSg2ObmKsJdS
	 Fy7ltyJjGcNnwn+7CyAsy+Ifp/7ey6HAToS+7pft9ajzjuac73TdQYMO9bGXg0DcI8
	 WS3Ajy4HVj9pA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
Date: Mon, 17 Aug 2026 23:14:04 +0800
Message-ID: <20260817151404.28324-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817151404.28324-1-jszhang@kernel.org>
References: <20260817151404.28324-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Interrupt Mask Register valid bits is bit[5:0] which is well
defined with DW_SPI_INT_MASK, use it instead of the incorrect(but no
harm) and hardcoded 0xff.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 299474507663..75d3f5fd79a3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -228,7 +228,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	 */
 	dw_reader(dws);
 	if (!dws->rx_len) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		spi_finalize_current_transfer(dws->ctlr);
 	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
 		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
@@ -264,7 +264,7 @@ static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
 	if (!dws->tx_len && dws->rx_len) {
 		dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
 	} else if (!dws->rx_len && !dws->tx_len) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		spi_finalize_current_transfer(dws->ctlr);
 	}
 
@@ -282,12 +282,13 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 
 	if (!dws->transfer_handler ||
 	    (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler)) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		return IRQ_HANDLED;
 	}
+
 	if (dws->transfer_handler == dw_spi_enh_handler &&
 	    !dws->rx_len && !dws->tx_len) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		spi_finalize_current_transfer(ctlr);
 		return IRQ_HANDLED;
 	}
@@ -525,7 +526,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 	dws->dma_mapped = spi_xfer_is_dma_mapped(ctlr, spi, transfer);
 
 	/* For poll mode just disable all interrupts */
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
 	if (dws->dma_mapped) {
 		ret = dws->dma_ops->dma_setup(dws, transfer);
@@ -831,7 +832,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dw_spi_update_config(dws, mem->spi, &cfg, NULL);
 
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
 	dw_spi_enable_chip(dws, 1);
 
@@ -999,7 +1000,7 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_update_config(dws, mem->spi, &cfg, &enh_cfg);
 
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 	reinit_completion(&ctlr->xfer_completion);
 
 	if (op->addr.nbytes && dws->set_addr_nbyte) {
@@ -1038,7 +1039,7 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
 					 msecs_to_jiffies(ms));
 	if (ms == 0) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		synchronize_irq(dws->irq);
 		dws->rx = NULL;
 		dws->tx = NULL;
-- 
2.53.0

