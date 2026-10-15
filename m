Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEC485513
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046584; cv=none; b=NVL0RS9SXw1SwbdLQ6kpRoUFkhjWxl9hQlQX4SA6f+Gzu7Vmm6RR+ZYHlwUoThpMmPM+hI5gaeyqo65VDbVavRTQM8x5TDk1QHDHXcrIJ+XIEh+CwWHdp8lOrhqyH8Je96ZZWWeI3oKp+B4Zz1uYJ9WGkBIkOvjlFEAw01CCCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046584; c=relaxed/simple;
	bh=U4iSlufMmS7TGP2lbnjcMnaBl3upu6Z/IBQZ204v/88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMjtol5xoM2z3UzpT1onl4RHp4zFzUe1wI27ozWN7jKlo4Q1O6tJRDIN/ZeXetKZQfuJJTwKTObRSkwUYcDbRZHxbdest4AsnxX9h17O6tiV7x5chMGX2Dw9qFh3twfRn+hSNg/MzxZ/Kt80wHYc0vD1GxkuA2OJcy62uGryXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6pHhSDw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6pHhSDw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1857587a12.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792046582; x=1792651382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jvbc5Kvef6D7WlRfV2yKnKGA6FOTagPB+dzxqGOh0mE=;
        b=I6pHhSDw5DQMxloj9H9KXk6UH9fzhFpBP2KIh0EKobkRr+D1aRnuB4SjCc4qRZ1K5/
         uXgREVtj4aaYdtO89oNLHXt0GcJYPmkwy27zqILJyLsrK2Vqjg0iQcOJ2OT5gMD6Oe8d
         6wbs6f7lAfcu8d5EWVZIYMsJl3clyfiiFYzYaw2Wgn26MreOgZiqa9fzCxwoE0U3Ryby
         Y5bS9CQOStBXlFG7svG+mYu5qnTKlEr9URQIJ6TRXxqLTwSbCskUiHCFcBYbh4Dhz7nm
         BNL8ySPsO6mN1GFom1D9Jw9UITtxqCIBrb5otX6Wj3fhF2n54xD4PNPC+UU9mEwndVYz
         hpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046582; x=1792651382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jvbc5Kvef6D7WlRfV2yKnKGA6FOTagPB+dzxqGOh0mE=;
        b=qSJUapwVqkH+5bnf1WJT4lSbgK9nHV5UonFKFBM9S6rG7xbs/pIQrQnGW5wFqERBSt
         359C+XRZLKAt4zAM/kwbZ20+x28Rc4f2nTtsNjCLQgUWoWxPjWWd2VARXv4SWQESlaKj
         DFhS5sy9408GTa9Yng7T0REfZEzUnTU6IWnhdqXOh+CVE0s0yAKyLSl4Xln9VuBlBTYR
         25GbB42f8DAKLUZVz3oF/AdTFqkThfvpzsYVyNAHRG0A1cf6PEWJeXZEblAbRJZBQ9YD
         ibj0BcrTqD2cVCNINHghNfxniV7gILXLKcpsZviXFabmaTK1JaENHFVNolWazbpzDCQR
         r7OA==
X-Gm-Message-State: AFq9FYLswLNc1L29LebOj1cE5rAClzJ1JVDGWnJr7J6vysRKuwRFtMWS
	A5RUwkIzKZoiq91wZSfbM25+OEQVnNq1x8cm0aDk4prVoXM69yxv1WHF
X-Gm-Gg: AYBFou2A1UAm/U1yN6dWGaWB0TkAWvcXiW2eWCOHZ0G49zFwFnD3Vz6X0FVNl/tpquO
	8YqwI3viPeNTV8yjpiwhdvQlqI4Tsc/0m0TVn866j/FJ7BsFuSTIN2fwbFC2/iaDV+l/pqNtuex
	GkeTMtlTeYg3GU8dFdPY3+ROW8+b0jlCneZjH/JnETYdf1eaWsR3DePlGp30JGJzmp39mPf1rVx
	s6jEhUUd+ctZbDy5xlLGq+xPgmq50jX6JVfCswIoWw13u/VXVqKlMmGk2Q36akrD03LwVx4tH68
	iAqz3hR1ZnTcP/0mQoc2K+esBQOJQshYa3EyckDqLJK6PwbUeNzdPrAaBVDCT3eFiXJZHOSJ8NW
	ywFwpKkgD/6cFrbDtrvoQ3Nx0JJR+PQtpRUTUqQgRm9Prm4kXhToaxM0V46nVWugFWUap62SkNj
	MK4mpKA/7Wp4DnmsPSPExIlh0M+qMTPdpoVgSyTje/1Bw7q1/fjg1KQtU9F7g+VizGAaz5SEl3m
	9ayYCm8//If86d6B/PsLybxjJjc6j9g8OQgjmYc
X-Received: by 2002:a17:90b:442d:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3aca203e3cdmr686391a91.11.1792046582182;
        Wed, 14 Oct 2026 23:43:02 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9307d287sm1685542a91.1.2026.10.14.23.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:43:01 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@armlinux.org.uk>,
	Sahaj Chaudhari <sahaj123.sc@gmail.com>
Subject: [PATCH v3] spi: omap2-mcspi: handle DMA setup failures
Date: Thu, 15 Oct 2026 12:13:41 +0530
Message-ID: <20261015064341.1100422-1-sahaj123.sc@gmail.com>
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
Changes in v3:
- Rebase onto spi for-7.4, v2 no longer applied.

Changes in v2:
- Disable the FIFO before falling back to PIO, as pointed out by
  Mark Brown. The FIFO is enabled before the DMA attempt and the PIO
  path does not expect FIFO mode.
- Expand the Tested paragraph.

v2: https://lore.kernel.org/r/20261014045617.2894886-1-sahaj123.sc@gmail.com
v1: https://lore.kernel.org/r/20261013142004.1729849-1-sahaj123.sc@gmail.com
 drivers/spi/spi-omap2-mcspi.c | 236 ++++++++++++++++++++++++----------
 1 file changed, 167 insertions(+), 69 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 49d9d9218471..e46b1d9c8cd0 100644
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
 	/* Restore defaults if they were overridden */
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

