Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BA2F8EAB;
	Mon, 15 Jun 2026 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499602; cv=none; b=XfupGg56GUcUBNimWLiCvHGWd9Ovy7SO9pF0H+OAA0ffqZoElWXxOuz4FCOKms1S1c34ZqfmakV1ZNIPbJvuKUtfzjx9Oml5JWQisOurVB5hwWGQNRwrr4IDFcAuUl/tvjmcO5+XRoXKKqTRsE5Ag1m9isnHyzU1Rxycq6QliMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499602; c=relaxed/simple;
	bh=X8GmXXO4h9ABadQKYFgrxxsQms+J/aXvS08E1HrwhLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+FvxhZu1+0QJtvWQCrOKsam42jxTal5xOY9inmMduqFgqUvHWJ5I7JPoGbS0ICanoz5FrZAhT9W7Q+j5s35Qr7X5zB/+Y+AJQPuUb96a7xvU7c8FhR0/VZiPc/O+klG0J7rTr+lns+vxjvrBcmidO1jdlHU1+q1K/MouyZHZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+PbmCQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+PbmCQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2B21F000E9;
	Mon, 15 Jun 2026 04:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499601;
	bh=jAKLOlPRI1hKYNwKSAltUs7c+bJLSyHAKonYpZZu5T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+PbmCQwZjuu15Yxe+eUq/oacjGLArSUM7FE/i2g4VGyK/MLfVpskhU2t6bQ+jY1R
	 x5vWcuv7kkxBoUQWfnosZGdaMwmuUFWiY1oRWVd6vxf3YTW4UWdyw6CCuEYRa9e2qv
	 CR/X4AFYcvjb4BFT75nUN0H+qED+Dtp4AWnf9N2hwvK6uLOcFdBVNiKM6Ovdo2o9Zw
	 Ofqr+h0MMCoyvgH+dO9A8OT+H79RjsTXRNGO62eiwfK9q5ltnQAbXPKiJTpRSnOpkB
	 S/LQRTlfqVXcTPkFYLvgUqAA+DzIUl3PNvkmw0qoHhBSeyvNXETeJobeLF+C74OMxA
	 cetVtqWgJspFw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
Date: Mon, 15 Jun 2026 12:40:38 +0800
Message-ID: <20260615044039.9750-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
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
 drivers/spi/spi-dw-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index aa2e51d0f959..feac17655847 100644
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
@@ -258,7 +258,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (!ctlr->cur_msg) {
-		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 		return IRQ_HANDLED;
 	}
 
@@ -445,7 +445,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 	dws->dma_mapped = spi_xfer_is_dma_mapped(ctlr, spi, transfer);
 
 	/* For poll mode just disable all interrupts */
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
 	if (dws->dma_mapped) {
 		ret = dws->dma_ops->dma_setup(dws, transfer);
@@ -704,7 +704,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
 	dw_spi_enable_chip(dws, 1);
 
-- 
2.53.0

