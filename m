Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FE35F16C
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443886; cv=none; b=ViHzEnlhYBanv3a+CW2yEi6HsbPVBXMEe06QIgWUMlxd6e316hGJed0JmR1TUu6R9K6Hw27jee7QuKI+rsFi0Uhap+zAxOT+eVznKg0ltv+udVzATjQZ+BYDWwH3Z5/+tJqLH7HWwmOCF25nVEWvPXwtmeMxSFWTGr7RmvcGQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443886; c=relaxed/simple;
	bh=ngAw18xIScEFM+It58VxjuaUlQbcZgx/Z/Iy/8x4uic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Regcfg9QzPBI42Dm2yNWV2YM7aGwp0OBMVxspZaXH+JrXxOQ9Q5tl5hueSZE/7DVKTqIou6NSMjInw7q/enX6UqUJlWId4Gn3mBoEoLcf1l90vpMEq+uaL+XPbkIUfEZfV/s5b/9w1mkEtsWPod+dvJqTJYwBhj6s+ayWFCnEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9poCuFr; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9poCuFr"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36643b96b99so6624901a91.0
        for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779443885; x=1780048685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzT000h1QTlmVrCMvUhZU+5EGxiL+DAZp9rDjkpmglg=;
        b=M9poCuFrQMlxxE5pa3moLCWj5I2B6eB8W4ruO6179EcU4az+fqiQS+G1adA8gbxGLg
         CAR+dg11p32Iwikp9R3zCbTH0OUn1Tq41u84FfRuOwiEeMNm5cArO0/xyyNWDY0n7Xax
         hk9TElKKZBdmQ8hv8KRgmMUThczYghB76xliz/QTgkqfzZPXH8mtjBp1piLjx7F4QMHQ
         dNJ0gUl9J0pKCHdcOeOnezwNkWop0GePhFQU6+mW8mGfBDODy82Z+tJ4rqdVd1c5kUms
         K8kQ+7LkBr6z1GpT94WaQ3J60D78V8NC1vknvNxzQykO16RUovaZjIRvLPc01vJFYQw0
         2HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443885; x=1780048685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzT000h1QTlmVrCMvUhZU+5EGxiL+DAZp9rDjkpmglg=;
        b=QfoGqW+BmeWhK8SJyoV2aRVuipGF2iUKULkkLixjxfN2WaKhouHslVwrxjs0uEcjWX
         3rKaVe8Jx+TUPXx8EnkLYIFW/okPKbJKxTz1y8E/McmmgzsjRq08uxRoTwtcyo5w2ey4
         JW5tBRcOCLrb0Xo+levpqkJSJk0nYR3z+1R5I2EvZffDs0AlcKqfc77OHGXpQtchGUFO
         SJ2xC3LT1aH9ogL6Ivd9ibLbaB+11ME0sW4B1Mz0MXft3VAL/H+gw5X4tv9zhrGDSZHI
         OmQ+kF0x3nzu50jojRvl4m3lI5m0Hx5GW5iBjVyk5hZ4vBgNpRFJzuk/dwVvRv4+fiCI
         PGQA==
X-Forwarded-Encrypted: i=1; AFNElJ+khbspcUUI+85durnhfiJY0cJoHgi0IYzqbWxjy7PsKEiW9lQXqNe0TqwAkSgfHFnex/ObxayDuFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkNe4RimSrmeqpTVbYtjj/LshWD7X6TI1eVnHmcERoUdClmX4
	evo52kchyyYsioBJY1QSSkVkqPrVwEd6NKYTWKXQdzucW/86PMOyi0hc
X-Gm-Gg: Acq92OFEp/C5GoDvVwZtWKVX88x4bIL2ZFqmW4uDnCmqS23F2NLhw6onmx1GKaSLav7
	Nqzd//0Dl9Gv7PQ94EH8YTp4tQXCcAQkEhsI0e09d3KdV8gD2vSpGoTnVCEi9NxkVtv/IJDVS/5
	avVKu2NNpF2ZI6PPd0jCbeh6GZVRYNVKLBrYYGQUFuHsMFPEVd4eGQNfrfHAFsN6bpuo4p5o5Fa
	MxUZkkYWMuXcy70MD4OxbpkU0dPxkP7zrsOQEUF+6wNgM9QUeAJOAIAzLhSN41aCigzw3IJuFkM
	rQbA0cKOlcvu5UUDQyeS4MjXR9kvppbXQx50Jbm0j1HCjv01iwOn5ILpqXu6brWJ5wQ+ovjITKH
	cQGfn/qpsyHwAx7KAUXj5EZVGxV2vP7J5NoAgrszCZexLL3VdvXC8c5+o2X8TkJR6vjk45mhAnz
	Kn4+063JP7nuawqm/+cA==
X-Received: by 2002:a17:90b:2586:b0:368:f0d0:1ce8 with SMTP id 98e67ed59e1d1-36a6770aa6bmr2941275a91.9.1779443884700;
        Fri, 22 May 2026 02:58:04 -0700 (PDT)
Received: from Dell-5540.. ([2001:926:3:e0:6695:664d:99d8:94e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a674b5f19sm1218777a91.0.2026.05.22.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:58:04 -0700 (PDT)
From: Peng Yang <pyangyyd@gmail.com>
X-Google-Original-From: Peng Yang <pyangyyd@amazon.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lansen@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pyangyyd@gmail.com,
	Peng Yang <pyangyyd@amazon.com>
Subject: [PATCH] spi: dw: fix race between transfer IRQ handler and timeout handler
Date: Fri, 22 May 2026 17:57:27 +0800
Message-ID: <20260522095727.18307-1-pyangyyd@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_spi_transfer_handler() can race with dw_spi_handle_err() on SMP.
When an IRQ-based transfer times out, the error path resets the chip
while the IRQ handler is still accessing the FIFO on another CPU.
This causes bus errors on platforms where empty FIFO access is illegal.

Fix by adding a spinlock around FIFO access and chip reset to make them
in serial.

Fixes: 0b6bfad4cee4 ("spi: spi-dw: Remove extraneous locking")
Signed-off-by: Peng Yang <pyangyyd@amazon.com>
---
 drivers/spi/spi-dw-core.c | 10 ++++++++++
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index b47637888..e2ae04410 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -213,6 +213,7 @@ EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, "SPI_DW_CORE");
 static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+	unsigned long flags;
 
 	if (dw_spi_check_status(dws, false)) {
 		spi_finalize_current_transfer(dws->ctlr);
@@ -226,7 +227,9 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	 * final stage of the transfer. By doing so we'll get the next IRQ
 	 * right when the leftover incoming data is received.
 	 */
+	spin_lock_irqsave(&dws->buf_lock, flags);
 	dw_reader(dws);
+	spin_unlock_irqrestore(&dws->buf_lock, flags);
 	if (!dws->rx_len) {
 		dw_spi_mask_intr(dws, 0xff);
 		spi_finalize_current_transfer(dws->ctlr);
@@ -240,7 +243,9 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	 * have the TXE IRQ flood at the final stage of the transfer.
 	 */
 	if (irq_status & DW_SPI_INT_TXEI) {
+		spin_lock_irqsave(&dws->buf_lock, flags);
 		dw_writer(dws);
+		spin_unlock_irqrestore(&dws->buf_lock, flags);
 		if (!dws->tx_len)
 			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
 	}
@@ -468,11 +473,14 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 static inline void dw_spi_abort(struct spi_controller *ctlr)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	unsigned long flags;
 
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
 
+	spin_lock_irqsave(&dws->buf_lock, flags);
 	dw_spi_reset_chip(dws);
+	spin_unlock_irqrestore(&dws->buf_lock, flags);
 }
 
 static void dw_spi_handle_err(struct spi_controller *ctlr,
@@ -939,6 +947,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	dws->ctlr = ctlr;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
+	spin_lock_init(&dws->buf_lock);
+
 	spi_controller_set_devdata(ctlr, dws);
 
 	/* Basic HW init */
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9cc79c566..4c0843e96 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -196,6 +196,7 @@ struct dw_spi {
 	const struct dw_spi_dma_ops *dma_ops;
 	struct completion	dma_completion;
 
+	spinlock_t		buf_lock; /* Serialize FIFO access vs chip reset */
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
-- 
2.50.1

