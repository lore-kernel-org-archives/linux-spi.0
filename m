Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096706;
	b=xVrssiN1vducNP8Bd7762k043eHfRwbqSmVLKp2X3drWjSPFtmT7EIvGmnGK44woDFt/
	 ZCBr4tweZBgMkfDNUJpLJrB3e++EUDqaDdv1ZrlSHEn03Z0BN7Y7E58rDR6MfgL0NT+Py
	 gMjqXCMmN2TAFS8/48TTsn5Fkm9AzXIjePXxmpFQ6sf/BgqVYxvdMcoMhHe+8O85y4M1z
	 bR+nvXzGa95qaTOzUqnwRTI8aeYHrlsPRfMZchf8B6oi3l3MoVmjGL2Ot8agVchB9DFrj
	 RfXHCDbS42xc6w502WyC3sKLK8cirhVZx3yT3lcAuMV4qhAbwJeRZkKcwIazfTP/UJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096706;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R26qmzEd6p1E3qSds2/i4/loBhNjXQNm0755urC7HDI=;
	b=2n1IO38ON7sugeYxGSPvlF8PKNmU0aoRe6SWUXl0q9BmqYzyIOK9KhVamECWrsdY4ZTD
	 Riejo+NYcgiKXIV1q8AT+QjDWDnz1i/4G6/S5hfq0ZpylctEUPUn4XAIblUxfFiNxpOKR
	 IIY2CTgU67lMWIQ04woB3oVYaSMc5EWyRhEX/LNGIKZxRRXGe9NL/J28xBGKxqaebMkcf
	 JE1tIJItGqpOKEWy6008wygNeI8YuE/BTgboINAM73757FZAXRDjyVLx7MrBOtOPXykzs
	 7ZTIwSFw5l2fK6zb1S7mwzhxzwj4GTvp2j0y9ud1ZCVDImWf374HWltIU6CfdZrwqBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0vfJiQpn;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB5606A320
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44BB5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0vfJiQpn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=R26qmzEd6p1E3qSds2/i4/loBhNjXQNm0755urC7HDI=; b=0vfJiQpnJT00KWB8dY7BeGFaId
	I5XZTSAF7fnwGul2Vl52LtGB34gkfjgaF5yH5/iI+0fYbjOj8Bmdxc8SU+tl9UujPUTT3oLWACDyC
	PJC+IDFOX+INSpnm9ynHNjEeUbDD3mlpiCFa8pnuzBLL0tqpHVM41uZbphLvR05IkuwgyKWqalxXR
	MhPfg8m+6zqy9DqNuem7Hq6oVNJ/v+HPP7YdD53qZdjjM981JWZ7jqNAeQQe2YTRtKYZYJ9MG5G9r
	o871gUtOgZKfHgrmruYzjZpsZ0LAi138Ly+DfYhX0Bql8OnS03nfS4yJ7MPZoIH0uQeqPKyT8dunx
	arKLAKFg==;
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
Subject: [PATCH v4 4/6] spi: Add infrastructure for atomic sync transfers
Date: Thu, 19 Nov 2026 14:58:06 +0100
Message-ID: <20261119135808.2377849-5-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
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

So add an optional transfer_atomic callback, drivers can implement to do
immediate uninterrupted transfers and let spi_sync() determine if the
state is late enough to use it.

For drivers without a transfer_atomic callback defined, the previous
behaviour is kept for backwards compatibility and a helper
spi_in_atomic_sync_mode() makes sure to only ever use this atomic mode
during late system stages.

spi_async() does not require a sleeping context for itself, so while it
could in theory also be included, its caller waiting for the completion
can sleep, so would still cause the splat about it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c       | 68 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi.h | 11 +++++++
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0b0bc093e01f..0569f30785e9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5073,6 +5073,47 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	return status;
 }
 
+/*
+ * We only allow atomic transfers for very late communication, e.g. to access a
+ * PMIC when powering down. Atomic transfers are a corner case and not for
+ * generic use!
+ */
+static inline bool spi_in_atomic_sync_mode(void)
+{
+	return system_state > SYSTEM_RUNNING && spi_in_atomic();
+}
+
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
+	/* Not using spi_maybe_optimize_message, so just validate */
+	status = __spi_validate(spi, message);
+	if (status)
+		return status;
+
+	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	status = ctlr->transfer_atomic(spi, message);
+	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
+
+	if (status == 0)
+		status = message->status;
+
+	return status;
+}
+
 /**
  * spi_sync - blocking/synchronous SPI data transfers
  * @spi: device with which data will be exchanged
@@ -5083,6 +5124,10 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
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
@@ -5096,11 +5141,17 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
+	struct spi_controller *ctlr = spi->controller;
 	int ret;
 
-	mutex_lock(&spi->controller->bus_lock_mutex);
-	ret = __spi_sync(spi, message);
-	mutex_unlock(&spi->controller->bus_lock_mutex);
+	/* Keep old behaviour for clients that tolerate the warnings */
+	if (spi_in_atomic_sync_mode() && ctlr->transfer_atomic) {
+		ret = __spi_sync_atomic(spi, message);
+	} else {
+		mutex_lock(&spi->controller->bus_lock_mutex);
+		ret = __spi_sync(spi, message);
+		mutex_unlock(&spi->controller->bus_lock_mutex);
+	}
 
 	return ret;
 }
@@ -5116,6 +5167,10 @@ EXPORT_SYMBOL_GPL(spi_sync);
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
@@ -5124,7 +5179,12 @@ EXPORT_SYMBOL_GPL(spi_sync);
  */
 int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 {
-	return __spi_sync(spi, message);
+	struct spi_controller *ctlr = spi->controller;
+
+	if (spi_in_atomic_sync_mode() && ctlr->transfer_atomic)
+		return __spi_sync_atomic(spi, message);
+	else
+		return __spi_sync(spi, message);
 }
 EXPORT_SYMBOL_GPL(spi_sync_locked);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0bf31776c54c..f62b21af5d75 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -461,6 +461,8 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * controller for configuring specific CS setup time, hold time and inactive
  * delay in terms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
+ * @transfer_atomic: transfer a message immediately from a late-stage
+ *	synchronous transfer
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
  * @dma_map_dev: device which can be used for DMA mapping
@@ -721,6 +723,15 @@ struct spi_controller {
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
2.53.0

