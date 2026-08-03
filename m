Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B641A4FF;
	Mon,  3 Aug 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767190; cv=none; b=Me9oTjA7dp5qGS4LUPCbGrZUk1teBJUprxzibCS05381uU0YGvhw7qNCmf3eNgStSocMRui2xrfqeT4Tp4MWPcSVzL2gGCbl60MaEx1I97jxbK7GavOUqrGPVTJ1q/h7UmiT3YgnfOh+T2+2M9kWuBD+ML9GVLYw2myE3P+4XCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767190; c=relaxed/simple;
	bh=TaWzQ+C8m9c3B9w8C5L4maNaHF+FzOHEdVHdPRRO5xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQQijZ3XpKc66I1misPbTVDbe+g1vCvAs/rV227itHXV6TQ5aPPnE22/Bj587Yy9+WTct5Q0t+Lj1O9Z0VE7h3HOg+vddJ5qK3c0ncbJXHlvSiy8GKk5Ncp8QDAYZCOJp25eFnSxOH+tg0AhX46YVsXyGIrFvfhRd6AwobQ1EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR8aHTjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR8aHTjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FE11F000E9;
	Mon,  3 Aug 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767189;
	bh=25aK0qc8XLYFRUzrFvXHg+k+o3Qzz1SwWKHbImHWyQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AR8aHTjNvTUfpQFmQLZKdmJV5GnAV5pj8FAtSdGCxjTWkYaYAjdXCRoZUaRGsbTav
	 aGHG4b6NybEb/Xh9OIfGXaCs67rIJFRTmea/Z6bi0twVXevSMmw79gASyqYSQ050E4
	 hQ9lhAcxhy5fTA/HvBlQokAbUl3/1tUNqQhfa07N9gtlJk/jj5bW8hxSrlWTmK4A+T
	 OzqIUb0jPx/jseE/y4Lfps5E4GEwEhQf2ff3ah8VeHl60MXdszRyYIHMTV5NUdlGnK
	 1afk8+dUMkFeM91xHt2BVCBSC0xaJJUZzsmuH4twHQEUGdE6q2gDq8izwB/ycOgr+Y
	 ywae4YwGjvCKA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
Date: Mon,  3 Aug 2026 22:06:48 +0800
Message-ID: <20260803140649.12718-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140649.12718-1-jszhang@kernel.org>
References: <20260803140649.12718-1-jszhang@kernel.org>
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
index f0d5528a0e8a..460e77b34ed9 100644
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
@@ -706,7 +706,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
-	dw_spi_mask_intr(dws, 0xff);
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
 	dw_spi_enable_chip(dws, 1);
 
-- 
2.53.0

