Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD534D390;
	Mon, 26 Jan 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449878; cv=none; b=NqtQJ0vmW5YLwMJ49eh8YJgdeWjgVn+FfnRjZ6nmBdhbCFJRzE1FBb1Jp8cdpHQNGvoW1xryqJTj202N/Vw16INvsfJeqk44HQ1FR1dWePaAHfDwSEsUjRBtTMqEXU0Fy7he563gNtfjI24FocsvT6KXQSIJzYef3tqFX+lkP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449878; c=relaxed/simple;
	bh=Q81YilWbPLWtEp7yxcbHsFIR2jpqUv0EOpT10c6Xuvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fkw4IYpI3DjuUECv+9Fvkj45nRtL7Qq9UYe6k8O1xeOvg4z2wt3R5iH4DSi2jyMT5cNNBbZDgOwG4L1NNYzNZOzHnHW0ENDTSrRk3S3rNjJuv6rsssZO93e/3sDaNDrG4zs7efWskR3uPxi3wnHvKV0C75l7xHUDXqRX3EKyD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bTTjio5d; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bTTjio5d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=enYJz9EqJNqwh5dKgF2h4XKb81SowoT5sujLs8RC+V0=; b=bTTjio5dME77OWNFHg6USruoPl
	JnexsRaW7BLdz3E78aYqKUgimrPvCMthau2UD406vU6FUV7H0EGLTemLBkNU+eyaoO9xforK/x5Y3
	d5MYy5+gWoonb7EsMlJxUZ+ZB2hT66eeGEbZNvFjhMfhJJvGMpp2VINlGNo2VZIWI38PlsX1CAvVX
	ejkk1JgY7I+XjxNl5OZ79TQ5Hj0z76CIkhGdS/11LQs54X741tNCV7McKHY9qUZf9NVdGHsI51+5b
	8rPJUtq5ZTu31HlF0En3vLcIbdT6Bz8sIcy+Xp9un7GIGcUdKTd3K/OOABwA0TI8VGwU+xQcRSBJJ
	GUpkgWXw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQk3-00GLaL-35; Mon, 26 Jan 2026 17:51:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:31 -0800
Subject: [PATCH v2 6/6] spi: tegra210-quad: Protect curr_xfer check in IRQ
 handler
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-6-6d2115e4f387@debian.org>
References: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
In-Reply-To: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, soto@nvidia.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q81YilWbPLWtEp7yxcbHsFIR2jpqUv0EOpT10c6Xuvw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lwjTHBL+FKmdyD8HH3w4do+kkthCCuRqavw
 s31q5DOPu2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepcAAKCRA1o5Of/Hh3
 bfhmD/9R5eTrEns8UylPi6v7RQAw26T2O58zpqjdgmQoLpXC0IZlJAqfRMDVUdWkQGmkWD/mLv9
 he2Mj2QpIiF7UAK2j5oYfEUFKvF/Iu4fxIo5gIP0ht0RoVWF40Dkg68YiOncy15BG0kVECuQQCo
 x/9TYuV9qx3NVaKRBRHKZiAamx49HxmTQnNtBBtVZ3fg6Jjw6g1oDFC36T/FVlmkXm1YTlTrpA8
 qFp3mxO6Kg8zp1o6dS0h8+a4zSPUxZqnutwzL1shGtOA4nOhRuBIFygW3Ta+ktJLX7uvZUHKtrc
 Ugxng45urOJoMg4ewHVDjcNAoi5EQ051+u0utqESzTv9Tl2zzQLsVabExEeBGVT5KYrOji/74ah
 /uL0IxWhZCjW0oVtDSlRa1kMmY8eRVlMB11JCA/U1mBZEiozXvK+sg9r3GDzOHi9MybZdonQ8cc
 pym2tFHq25TDPpf1XXqPmbdQccxmsO6pi4lFmfMNIRtIh0pf6ngdTZd0t3rJro366CFK5ZZimC+
 PCev7pzjnnS6b80tqer2f+OkNxiRhJLoSPGtqhrJ/yi8bbtMLuYytmgZJmVWdYgy0/jvSpGvmki
 N9PUYIYn1SxVK9z5tLu6gEqvcJnoBdbeojlCPbgPRKfcuLb4U+9S0S6DwqWHw2OuLZ8rxxrTiaZ
 0GkDpwwrrlSguvQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Now that all other accesses to curr_xfer are done under the lock,
protect the curr_xfer NULL check in tegra_qspi_isr_thread() with the
spinlock. Without this protection, the following race can occur:

  CPU0 (ISR thread)              CPU1 (timeout path)
  ----------------               -------------------
  if (!tqspi->curr_xfer)
    // sees non-NULL
                                 spin_lock()
                                 tqspi->curr_xfer = NULL
                                 spin_unlock()
  handle_*_xfer()
    spin_lock()
    t = tqspi->curr_xfer  // NULL!
    ... t->len ...        // NULL dereference!

With this patch, all curr_xfer accesses are now properly synchronized.

Although all accesses to curr_xfer are done under the lock, in
tegra_qspi_isr_thread() it checks for NULL, releases the lock and
reacquires it later in handle_cpu_based_xfer()/handle_dma_based_xfer().
There is a potential for an update in between, which could cause a NULL
pointer dereference.

To handle this, add a NULL check inside the handlers after acquiring
the lock. This ensures that if the timeout path has already cleared
curr_xfer, the handler will safely return without dereferencing the
NULL pointer.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 79aeb80aa4a70..f425d62e0c276 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1457,6 +1457,11 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	spin_lock_irqsave(&tqspi->lock, flags);
 	t = tqspi->curr_xfer;
 
+	if (!t) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		return IRQ_HANDLED;
+	}
+
 	if (tqspi->tx_status ||  tqspi->rx_status) {
 		tegra_qspi_handle_error(tqspi);
 		complete(&tqspi->xfer_completion);
@@ -1527,6 +1532,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	spin_lock_irqsave(&tqspi->lock, flags);
 	t = tqspi->curr_xfer;
 
+	if (!t) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		return IRQ_HANDLED;
+	}
+
 	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
 		tegra_qspi_handle_error(tqspi);
@@ -1565,6 +1575,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	unsigned long flags;
 	u32 status;
 
 	/*
@@ -1582,7 +1593,9 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 	 * If no transfer is in progress, check if this was a real interrupt
 	 * that the timeout handler already processed, or a spurious one.
 	 */
+	spin_lock_irqsave(&tqspi->lock, flags);
 	if (!tqspi->curr_xfer) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 		/* Spurious interrupt - transfer not ready */
 		if (!(status & QSPI_RDY))
 			return IRQ_NONE;
@@ -1599,7 +1612,14 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 		tqspi->rx_status = tqspi->status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
 
 	tegra_qspi_mask_clear_irq(tqspi);
+	spin_unlock_irqrestore(&tqspi->lock, flags);
 
+	/*
+	 * Lock is released here but handlers safely re-check curr_xfer under
+	 * lock before dereferencing.
+	 * DMA handler also needs to sleep in wait_for_completion_*(), which
+	 * cannot be done while holding spinlock.
+	 */
 	if (!tqspi->is_curr_dma_xfer)
 		return handle_cpu_based_xfer(tqspi);
 

-- 
2.47.3

