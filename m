Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989112;
	b=GDHpn2rbiJIDxvqvr1VVoVbXFraCprZZ+lSMp9CqeOXk+AeT4PBygRCHj2Zo0PxF+hV9
	 pEAg1XuPsE3d0qbAUA/33e2Z5RTP5PNiiur4ejk6nPkZ8cZkVGQr7UG5PRRd48R71wz0A
	 3K85XzHDup2UnqFeCqoDMP9XSU317qHXBeVsSQrFvAzbzugIs18mcKMFN1++IIg6S4fkb
	 nQ7IA1Q5wZ85VT7cu4FBgHz+o+QrFi9kop0vyswfMyFgQyOiaYVFFO9Ce6PvuKpIYJ+CR
	 AXjZbgKC0m5GOMlIGI/vzzertzVyDFCeDWOrtV+fYbFM/DcsKNbr7MMXBGXL/x+SPOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989112;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4qu676T13y6RrHMwRJER4rARZi5IpEx76wQQl48H/Lg=;
	b=5RVPb3F29qPb+437PISU5fZNrozxYM6huFvP/dNNVUiUc0uKuMA5goMSKfc1gZX6Sbow
	 75HPwnEJ0K54Wce3WimAwFxoSlgm5BvP2zFtj4Itja8rEOG7VfhqylJk0nWj5U0Gm4Rfh
	 3dS2J4Btj961CHTrEXL1B33l0Xby+4Sr1hdUgq/PnioxTttmBbj7KTi9dh+ZzP/tjq9x+
	 vU+773QbLKV+77pMi0OwB85u7YFhyDN5JQFVZDlZ5wEm1BhwATZ5Jt9bA21HInMMwjtSw
	 om+yyzDpre+Bcn/yYFoyDnEjeyt0feS2O7vV6aIjTXVo1GH33YUuzzjrkwgW9X8jHcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FA606A32E
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 18:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3FA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=4qu676T13y6RrHMwRJER4rARZi5IpEx76wQQl48H/Lg=; b=wOJ45EzPH4TKBuxbrG2SxMVfBZ
	HuraQyMYRtefiK+Y/kxaWLtSVhOtbYr070C4XU+gAK71isBez48dFuc3btrNQKR3S6SknVSetTthU
	DgLw4v0BzyD+JjnFtkyDRSrItWcYohw6wWnbYciZV7Qd35qc0Vvi0ZypFrE343PYZNDMTUp5Tf0fk
	O1TE3acBrA5K+pOzU8kJswcpEEYDGOgExjb1ZGLJF216LwKkDsMBB50L1JH342iOOx3wq1TRx2ksv
	OtQf0DgN8wpfmzWFkUH2wjVjrpb5fK14ILUVU4pH+0nB1XJF+dHkTacI5z6hWJS5LdOr1wQtIAZZz
	sCWbhAoQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] spi: Add infrastructure for atomic sync transfers
Date: Fri,  6 Nov 2026 19:18:22 +0100
Message-ID: <20261106181824.1361235-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106181824.1361235-1-heiko@sntech.de>
References: <20261106181824.1361235-1-heiko@sntech.de>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

There are cases where SPI transfers are needed during times without
interrupts like shutdown when a PMIC should turn off the system.

I2C already has atomic transfers for exactly that case, so introduce a
similar concept for SPI. Similar to I2C, this is and should stay a
corner-case, so is only allowed during the shutdown stages of the kernel,
when interrupts are already turned off.

So add a in-atomic check stolen from I2C and an optional transfer_atomic
callback drivers can implement to do immediate uninterrupted transfers
and let spi_sync() determine if the state is late enough to use it.

spi_async() does not require a sleeping context for itself, so while it
could in theory also be included, its called waiting for the completion
can sleep, so would still cause the splat about it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c       | 66 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi.h | 11 +++++++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..b85ac20e63f6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5016,6 +5016,49 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	return status;
 }
 
+static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_controller *ctlr = spi->controller;
+	unsigned long flags;
+	int status;
+
+	if (!ctlr->transfer_atomic) {
+		dev_err(&ctlr->dev, "No atomic transfer handler defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (__spi_check_suspended(ctlr)) {
+		dev_warn_once(&spi->dev, "Attempted to sync while suspend\n");
+		return -ESHUTDOWN;
+	}
+
+	status = spi_maybe_optimize_message(spi, message);
+	if (status)
+		return status;
+
+	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	status = ctlr->transfer_atomic(spi, message);
+	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
+
+	spi_maybe_unoptimize_message(message);
+
+	if (status == 0)
+		status = message->status;
+
+	return status;
+}
+
+/*
+ * We only allow atomic transfers for very late communication, e.g. to access a
+ * PMIC when powering down. Atomic transfers are a corner case and not for
+ * generic use!
+ */
+static inline bool spi_in_atomic_sync_mode(void)
+{
+	return system_state > SYSTEM_RUNNING &&
+	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled());
+}
+
 /**
  * spi_sync - blocking/synchronous SPI data transfers
  * @spi: device with which data will be exchanged
@@ -5026,6 +5069,10 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
  * is non-interruptible, and has no timeout.  Low-overhead controller
  * drivers may DMA directly into and out of the message buffers.
  *
+ * During the time when the system is being shutdown and a transfer_atomic
+ * function is set, this call may also be used from a context that does
+ * not allow sleeping, i.e. with disabled interrupts.
+ *
  * Note that the SPI device's chip select is active during the message,
  * and then is normally disabled between messages.  Drivers for some
  * frequently-used devices may want to minimize costs of selecting a chip,
@@ -5041,9 +5088,13 @@ int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
 	int ret;
 
-	mutex_lock(&spi->controller->bus_lock_mutex);
-	ret = __spi_sync(spi, message);
-	mutex_unlock(&spi->controller->bus_lock_mutex);
+	if (spi_in_atomic_sync_mode()) {
+		ret = __spi_sync_atomic(spi, message);
+	} else {
+		mutex_lock(&spi->controller->bus_lock_mutex);
+		ret = __spi_sync(spi, message);
+		mutex_unlock(&spi->controller->bus_lock_mutex);
+	}
 
 	return ret;
 }
@@ -5059,6 +5110,10 @@ EXPORT_SYMBOL_GPL(spi_sync);
  * is non-interruptible, and has no timeout.  Low-overhead controller
  * drivers may DMA directly into and out of the message buffers.
  *
+ * During the time when the system is being shutdown and a transfer_atomic
+ * function is set, this call may also be used from a context that does
+ * not allow sleeping, i.e. with disabled interrupts.
+ *
  * This call should be used by drivers that require exclusive access to the
  * SPI bus. It has to be preceded by a spi_bus_lock call. The SPI bus must
  * be released by a spi_bus_unlock call when the exclusive access is over.
@@ -5067,7 +5122,10 @@ EXPORT_SYMBOL_GPL(spi_sync);
  */
 int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 {
-	return __spi_sync(spi, message);
+	if (spi_in_atomic_sync_mode())
+		return __spi_sync_atomic(spi, message);
+	else
+		return __spi_sync(spi, message);
 }
 EXPORT_SYMBOL_GPL(spi_sync_locked);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fb4baa0d3398..2b179b5d598c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -459,6 +459,8 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * controller for configuring specific CS setup time, hold time and inactive
  * delay in terms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
+ * @transfer_atomic: transfer a message immediately from a late-stage
+ *	synchronous transfer
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
  * @dma_map_dev: device which can be used for DMA mapping
@@ -719,6 +721,15 @@ struct spi_controller {
 	int			(*transfer)(struct spi_device *spi,
 						struct spi_message *mesg);
 
+	/*
+	 * Bidirectional bulk atomic transfers
+	 *
+	 * Special function that allows transfers in contexts where
+	 * no interrupts nor DMA are available.
+	 */
+	int			(*transfer_atomic)(struct spi_device *spi,
+						   struct spi_message *mesg);
+
 	/* Called on deregistration to free memory provided by spi_controller */
 	void			(*cleanup)(struct spi_device *spi);
 
-- 
2.47.3

