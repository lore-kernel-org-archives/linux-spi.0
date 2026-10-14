Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1D39D3D0
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953742; cv=none; b=JqFdErd+3BDHlCMFKrIKbfYWwO5A7231eij1y5a/TwP/Bw7pQcTf7lCBaWge6/ZStTfjmJCiqR/gP16GjWmKsU3WwVl97+YUw+pbTpc9eL+KKUFGRy6z4wTJ7hUWHLUwRZeS8W3/x56lNFwTUR2LcIN5iR7PupB6jw68rIMDKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953742; c=relaxed/simple;
	bh=rQ56YFYgad1wOSJHsir4Wl1qWSsiQ+uz290it6r67wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsY8ZRCt7LrT+PhbWqnFcwiCC1wX6bwkq7WynjKM/yRVlRSwMrUC8QECHxzBM0CFB7mopotW2nM6FBTdQoFtS8II4r3LlZEpjNG4rh2yZwC3YMc8zrwRX3VQg5dELAPuU9Mrviof9yYnfyqi32ErIRU/WtaVmMnQnzfOJA4OQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUE/uyO5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUE/uyO5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-16079d54c17so4673087c88.0
        for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791953740; x=1792558540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AnpB0zS2EioB6l+BJL51P1LkP9oN85FC+JGkNepFsQ=;
        b=ZUE/uyO5U2oyQyhijKPnWtPeFxxDKBBbL9HGYn45ucTNNy1hh75RJRON5tzjSgERr+
         ubTPTvsp5yZmyY33UoorDu4vItB446WXzQ5YTn1RWmBH1mZ+h6tc+NXKUQFERA7KXdcp
         Gvw7cRKQa9NOsCp5XmfC9ZlMkiSqgxE045AHjWaXGDr06Sj63x7ryPMwT7YK57cSq5+U
         JTEjbahH4qQ5lX35NGwgp/mE88oP/3s4XOoBHnT7DVZS8xVVH38INDD+S2fhch6doySa
         RzvN+QXc/DE2oJXi70CwjkZ3sZiHg1TwOlMCExOyaHaIA49MQ2cExHQeQuGfjuuCMhTq
         OQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791953740; x=1792558540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AnpB0zS2EioB6l+BJL51P1LkP9oN85FC+JGkNepFsQ=;
        b=2ayZFqD3At80TpNrPWs59mqPyilaeTZQYE/NboDVqP84dEDkQc+vwCmofjXWIBQmZB
         LViVLRBJMAvwV5AUkXRmVccgOuKjEYXatqR8HdwSY/A9dV0RMEux7zwEGbQhpR6mpLn1
         XoiukxM+i1Xe8QO/5FyKT8fItIMTJioBfadki3bGYBk9zd3p+Cy0US4QnPpF1SX1azD8
         9Bl9YZAvWvXFGyawRQeI0Sl2S+bhlhrlDHl2F4BlrBfy/XW2tJEc2agiR7Sp8b6eA+va
         U/DlY0WAs7GqlFZemS3MjWl/tj5o/DsBDB/UXeHNxH5bposhajKN8lX9ZL3eio80hLU2
         V7aQ==
X-Gm-Message-State: AFq9FYL0vXIBfUFfzywAAGAdnuQi4WimhWZ/0WwonEaS9Lq8jRkacZYd
	qnACuR4NSc7tPug5HCJcNsbKYofzhYXtnumHWHZRtDslaAdOhm+SPOkg
X-Gm-Gg: AYBFou0WHwfxqByjmNA+heGGeknORhOqVkHiSY3SZjW44/g0W8DsWZ0Lw+ed1dCrjMS
	2kGr7mrNEHEboMKtseChaaxLDVTloUgPfymko0nJJ3B7xtHIB4k5YxqFIqlYgkcNTMNtty4ZE3E
	xE2v520qvp29CSGESjNWxFkMaY4Wak/G+FaYUcGAT421JeYXO8hunA92ha5QiQK/qoaqZnJ755l
	ECT+fs92DNwVmfk1K4uWJbc7KkWj6eWlWhFpsBn1WIpFN/wBvPaqjf0UW9SnNRWd2f7hxj17a4A
	xnw4i4udFrqJ7HVVQvk8dPiUVG2jMejxCcmiEJqT/wlw+O9ndm7MWDg51ZK3bd6RTQmX/LtlBYY
	z+oAn7iscsCbe/NvXvMeIESSjOpFCTAEstj3sagbfbmwri3MZasQ6o6zzBIWPxR1wtopWdxBFZ4
	1MS00NGaoow3VZjlRu0ZXXFhpoMq1Un21BaK4LCsukNrsjdH1A0VOSfAEiDgfu1tYLZJtURW8Mu
	zGdIcpTW9W0/9OGCOfygOqE33Y=
X-Received: by 2002:a05:7022:5f1b:b0:144:ee9f:74be with SMTP id a92af1059eb24-1794f295f02mr5794646c88.40.1791953739456;
        Tue, 13 Oct 2026 21:55:39 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm50630044c88.12.2026.10.13.21.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:55:38 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linusw@kernel.org>,
	Sahaj Chaudhari <sahaj123.sc@gmail.com>
Subject: [PATCH v2] spi: omap2-mcspi: handle DMA setup failures
Date: Wed, 14 Oct 2026 10:26:17 +0530
Message-ID: <20261014045617.2894886-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA paths ignore failures from dmaengine_slave_config(), descriptor
preparation and dmaengine_submit(), and carry FIXME comments about
falling back to PIO. A failed setup can leave a half-started transfer
or wait for a completion that never arrives.

Check each step and clean up with dmaengine_terminate_sync() on error.
Prepare both descriptors before issuing either channel. Fall back to
PIO only for host-mode transfers that have a TX buffer, when no DMA has
been started and cleanup succeeded. RX-only and target-mode transfers
return the error instead, since the bus may already be clocking.

The FIFO is enabled before the DMA attempt, but the PIO path polls
per-word TXS/RXS and does not expect FIFO mode. Disable the FIFO, with
the channel off while its bits change, before falling back.

Tested on an AM642 board with a TI 6.12.57 vendor kernel built with
this patch and booted from RAM. On a McSPI bus using DMA, 200
iterations of 4096-byte TX and 1024-byte RX spidev transfers completed
with no errors, timeouts or kernel warnings. With a temporary change
that fails every DMA-sized TX setup, 60 spidev writes fell back to PIO
with no errors or timeouts. That test used a bus with no device
attached and did not show a difference with and without the FIFO
disable, which is based on reading the code.

Fixes: 53741ed8f0a3 ("spi: omap2-mcspi: add DMA engine support")
Link: https://lore.kernel.org/r/20250914022132.319227-1-alex.t.tran@gmail.com
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
Changes in v2:
- Disable the FIFO before falling back to PIO, as pointed out by
  Mark Brown. The FIFO is enabled before the DMA attempt and the PIO
  path does not expect FIFO mode.
- Expand the Tested paragraph.

v1: https://lore.kernel.org/r/20261013142004.1729849-1-sahaj123.sc@gmail.com
 drivers/spi/spi-omap2-mcspi.c | 236 ++++++++++++++++++++++++----------
 1 file changed, 167 insertions(+), 69 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a3355147f5de..9b50ce1458ee 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -413,10 +413,11 @@ static void omap2_mcspi_tx_callback(void *data)
 	complete(&mcspi_dma->dma_tx_completion);
 }
 
-static void omap2_mcspi_tx_dma(struct spi_device *spi,
-				struct spi_transfer *xfer,
-				struct dma_slave_config cfg)
+static int omap2_mcspi_tx_dma(struct spi_device *spi,
+			      struct spi_transfer *xfer,
+			      struct dma_slave_config cfg)
 {
+	int ret;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	struct dma_async_tx_descriptor *tx;
@@ -424,31 +425,31 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	mcspi = spi_controller_get_devdata(spi->controller);
 	mcspi_dma = &mcspi->dma_channels[spi_get_chipselect(spi, 0)];
 
-	dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
+	ret = dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
+	if (ret)
+		return ret;
 
 	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
 				     xfer->tx_sg.nents,
 				     DMA_MEM_TO_DEV,
 				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (tx) {
-		tx->callback = omap2_mcspi_tx_callback;
-		tx->callback_param = spi;
-		dmaengine_submit(tx);
-	} else {
-		/* FIXME: fall back to PIO? */
-	}
-	dma_async_issue_pending(mcspi_dma->dma_tx);
-	omap2_mcspi_set_dma_req(spi, 0, 1);
+	if (!tx)
+		return -EIO;
+
+	tx->callback = omap2_mcspi_tx_callback;
+	tx->callback_param = spi;
+
+	return dma_submit_error(dmaengine_submit(tx));
 }
 
-static unsigned
+static int
 omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
-				struct dma_slave_config cfg,
-				unsigned es)
+		   struct dma_slave_config cfg, unsigned int es,
+		   unsigned int *count, bool *rx_submitted, bool *dma_started)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, transfer_reduction = 0;
+	unsigned int		transfer_reduction = 0;
 	struct scatterlist	*sg_out[2];
 	int			nb_sizes = 0, out_mapped_nents[2], ret, x;
 	size_t			sizes[2];
@@ -461,7 +462,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	mcspi = spi_controller_get_devdata(spi->controller);
 	mcspi_dma = &mcspi->dma_channels[spi_get_chipselect(spi, 0)];
-	count = xfer->len;
+	*count = xfer->len;
+	*rx_submitted = false;
 
 	/*
 	 *  In the "End-of-Transfer Procedure" section for DMA RX in OMAP35x TRM
@@ -475,14 +477,16 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	l = mcspi_cached_chconf0(spi);
 
 	if (word_len <= 8)
-		element_count = count;
+		element_count = *count;
 	else if (word_len <= 16)
-		element_count = count >> 1;
+		element_count = *count >> 1;
 	else /* word_len <= 32 */
-		element_count = count >> 2;
+		element_count = *count >> 2;
 
 
-	dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
+	ret = dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
+	if (ret)
+		return ret;
 
 	/*
 	 *  Reduce DMA transfer length by one more if McSPI is
@@ -493,7 +497,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	if (transfer_reduction) {
 		/* Split sgl into two. The second sgl won't be used. */
-		sizes[0] = count - transfer_reduction;
+		sizes[0] = *count - transfer_reduction;
 		sizes[1] = transfer_reduction;
 		nb_sizes = 2;
 	} else {
@@ -501,44 +505,56 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		 * Don't bother splitting the sgl. This essentially
 		 * clones the original sgl.
 		 */
-		sizes[0] = count;
+		sizes[0] = *count;
 		nb_sizes = 1;
 	}
 
 	ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents, 0, nb_sizes,
 		       sizes, sg_out, out_mapped_nents, GFP_KERNEL);
 
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&spi->dev, "sg_split failed\n");
-		return 0;
+		return ret;
 	}
 
 	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, sg_out[0],
 				     out_mapped_nents[0], DMA_DEV_TO_MEM,
 				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (tx) {
-		tx->callback = omap2_mcspi_rx_callback;
-		tx->callback_param = spi;
-		dmaengine_submit(tx);
-	} else {
-		/* FIXME: fall back to PIO? */
+	if (!tx) {
+		ret = -EIO;
+		goto out_free_sg;
 	}
 
+	tx->callback = omap2_mcspi_rx_callback;
+	tx->callback_param = spi;
+	ret = dma_submit_error(dmaengine_submit(tx));
+	if (ret)
+		goto out_free_sg;
+
+	*rx_submitted = true;
+	if (mcspi->target_aborted) {
+		ret = -EINTR;
+		goto out_free_sg;
+	}
+	*dma_started = true;
+	if (xfer->tx_buf) {
+		if (spi_controller_is_target(mcspi->ctlr))
+			mcspi_write_reg(mcspi->ctlr, OMAP2_MCSPI_IRQENABLE,
+					OMAP2_MCSPI_IRQSTATUS_EOW);
+		dma_async_issue_pending(mcspi_dma->dma_tx);
+		omap2_mcspi_set_dma_req(spi, 0, 1);
+	}
 	dma_async_issue_pending(mcspi_dma->dma_rx);
 	omap2_mcspi_set_dma_req(spi, 1, 1);
-
 	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
-	if (ret || mcspi->target_aborted) {
-		dmaengine_terminate_sync(mcspi_dma->dma_rx);
-		omap2_mcspi_set_dma_req(spi, 1, 0);
-		return 0;
-	}
+	if (ret || mcspi->target_aborted)
+		goto out_free_sg;
 
 	for (x = 0; x < nb_sizes; x++)
 		kfree(sg_out[x]);
 
 	if (mcspi->fifo_depth > 0)
-		return count;
+		return 0;
 
 	/*
 	 *  Due to the DMA transfer length reduction the missing bytes must
@@ -565,9 +581,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		} else {
 			int bytes_per_word = mcspi_bytes_per_word(word_len);
 			dev_err(&spi->dev, "DMA RX penultimate word empty\n");
-			count -= (bytes_per_word << 1);
+			*count -= (bytes_per_word << 1);
 			omap2_mcspi_set_enable(spi, 1);
-			return count;
+			return 0;
 		}
 	}
 	if (!mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS)) {
@@ -582,19 +598,27 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			((u32 *)xfer->rx_buf)[elements] = w;
 	} else {
 		dev_err(&spi->dev, "DMA RX last word empty\n");
-		count -= mcspi_bytes_per_word(word_len);
+		*count -= mcspi_bytes_per_word(word_len);
 	}
 	omap2_mcspi_set_enable(spi, 1);
-	return count;
+	return 0;
+
+out_free_sg:
+	if (!ret)
+		ret = -EINTR;
+	for (x = 0; x < nb_sizes; x++)
+		kfree(sg_out[x]);
+	return ret;
 }
 
-static unsigned
-omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
+static int omap2_mcspi_txrx_dma(struct spi_device *spi,
+				struct spi_transfer *xfer,
+				unsigned int *count,
+				bool *pio_fallback)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count;
 	u8			*rx;
 	const u8		*tx;
 	struct dma_slave_config	cfg;
@@ -602,10 +626,13 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	unsigned es;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
-	int			wait_res;
+	bool			tx_submitted = false, rx_submitted = false;
+	bool			dma_started = false, terminate_failed = false;
+	int			ret, wait_res;
 
 	mcspi = spi_controller_get_devdata(spi->controller);
 	mcspi_dma = &mcspi->dma_channels[spi_get_chipselect(spi, 0)];
+	*pio_fallback = false;
 
 	if (cs->word_len <= 8) {
 		width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -618,7 +645,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		es = 4;
 	}
 
-	count = xfer->len;
+	*count = xfer->len;
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
@@ -636,31 +663,39 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	reinit_completion(&mcspi_dma->dma_rx_completion);
 	reinit_completion(&mcspi->txdone);
 	if (tx) {
-		/* Enable EOW IRQ to know end of tx in target mode */
+		ret = omap2_mcspi_tx_dma(spi, xfer, cfg);
+		if (ret)
+			goto out;
+		tx_submitted = true;
+	}
+
+	if (rx) {
+		ret = omap2_mcspi_rx_dma(spi, xfer, cfg, es, count,
+					 &rx_submitted, &dma_started);
+		if (ret)
+			goto out;
+	} else if (tx) {
+		if (mcspi->target_aborted) {
+			ret = -EINTR;
+			goto out;
+		}
 		if (spi_controller_is_target(spi->controller))
-			mcspi_write_reg(spi->controller,
-					OMAP2_MCSPI_IRQENABLE,
+			mcspi_write_reg(spi->controller, OMAP2_MCSPI_IRQENABLE,
 					OMAP2_MCSPI_IRQSTATUS_EOW);
-		omap2_mcspi_tx_dma(spi, xfer, cfg);
+		dma_started = true;
+		dma_async_issue_pending(mcspi_dma->dma_tx);
+		omap2_mcspi_set_dma_req(spi, 0, 1);
 	}
 
-	if (rx != NULL)
-		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
-
-	if (tx != NULL) {
-		int ret;
-
+	if (tx) {
 		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
-		if (ret || mcspi->target_aborted) {
-			dmaengine_terminate_sync(mcspi_dma->dma_tx);
-			omap2_mcspi_set_dma_req(spi, 0, 0);
-			return 0;
-		}
+		if (ret || mcspi->target_aborted)
+			goto out;
 
 		if (spi_controller_is_target(mcspi->ctlr)) {
 			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
 			if (ret || mcspi->target_aborted)
-				return 0;
+				goto out;
 		}
 
 		if (mcspi->fifo_depth > 0) {
@@ -694,7 +729,43 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_err(&spi->dev, "EOT timed out\n");
 		}
 	}
-	return count;
+	return 0;
+
+out:
+	if (!ret)
+		ret = -EINTR;
+	if (rx_submitted) {
+		wait_res = dmaengine_terminate_sync(mcspi_dma->dma_rx);
+		if (wait_res) {
+			dev_err(&spi->dev, "failed to terminate RX DMA: %d\n",
+				wait_res);
+			terminate_failed = true;
+			ret = wait_res;
+		}
+		omap2_mcspi_set_dma_req(spi, 1, 0);
+	}
+	if (tx_submitted) {
+		wait_res = dmaengine_terminate_sync(mcspi_dma->dma_tx);
+		if (wait_res) {
+			dev_err(&spi->dev, "failed to terminate TX DMA: %d\n",
+				wait_res);
+			terminate_failed = true;
+			ret = wait_res;
+		}
+		omap2_mcspi_set_dma_req(spi, 0, 0);
+	}
+	if (spi_controller_is_target(mcspi->ctlr))
+		mcspi_write_reg(mcspi->ctlr, OMAP2_MCSPI_IRQENABLE, 0);
+
+	*pio_fallback = !dma_started && !terminate_failed;
+	return ret;
+}
+
+static bool omap2_mcspi_can_pio_fallback(bool cleanup_ok,
+					 const struct spi_transfer *xfer,
+					 bool is_target)
+{
+	return cleanup_ok && xfer->tx_buf && !is_target;
 }
 
 static unsigned
@@ -1214,6 +1285,8 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 
 	if (t->len) {
 		unsigned	count;
+		bool		pio_fallback;
+		int		ret;
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
 		    spi_xfer_is_dma_mapped(ctlr, spi, t))
@@ -1227,10 +1300,31 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 					+ OMAP2_MCSPI_TX0);
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    spi_xfer_is_dma_mapped(ctlr, spi, t))
-			count = omap2_mcspi_txrx_dma(spi, t);
-		else
+		    spi_xfer_is_dma_mapped(ctlr, spi, t)) {
+			ret = omap2_mcspi_txrx_dma(spi, t, &count,
+						   &pio_fallback);
+			if (ret) {
+				bool is_target = spi_controller_is_target(ctlr);
+				bool fallback;
+
+				fallback = omap2_mcspi_can_pio_fallback(pio_fallback, t,
+									is_target);
+				if (!fallback) {
+					status = ret;
+					goto out;
+				}
+
+				dev_warn(&spi->dev,
+					 "DMA setup failed, falling back to PIO\n");
+				/* PIO does not use the FIFO enabled for DMA */
+				omap2_mcspi_set_enable(spi, 0);
+				omap2_mcspi_set_fifo(spi, t, 0);
+				omap2_mcspi_set_enable(spi, 1);
+				count = omap2_mcspi_txrx_pio(spi, t);
+			}
+		} else {
 			count = omap2_mcspi_txrx_pio(spi, t);
+		}
 
 		if (count != t->len) {
 			status = -EIO;
@@ -1246,8 +1340,12 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 out:
 	/* Restore defaults if they were overriden */
 	if (par_override) {
+		int restore_status;
+
 		par_override = 0;
-		status = omap2_mcspi_setup_transfer(spi, NULL);
+		restore_status = omap2_mcspi_setup_transfer(spi, NULL);
+		if (!status)
+			status = restore_status;
 	}
 
 	omap2_mcspi_set_enable(spi, 0);
-- 
2.43.0

