Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765494;
	b=b+g1fRP8s4bHMoRB0atwR6hQZ1ttUJNZD5XrtfpYbnntv7bnkB2mAOryrrX5ySx47d7a
	 F9gEqMKvL0NBCtwLPOBVwqkkmu8z/mh7ObyOy8qxQWredpHea5M+jLJ69phJNV6lMtwFa
	 zewcdmN92ZfdtS9rfIT+5r9UkvCeZ8aNMjb49PtG80nLam07jdBQAvDWLCPeJyd30Gv7G
	 vYVaHXZzaR5mvlV6dcJMgYtxwe8O/P3QE3HUVAnWfgBIFO4hMziM3mpIVhLWAZLuqq8hd
	 E9IvY+3SFm1cf7JFuWTj1VmaBV1w1qI2bit0Ci+ADx+J/wwDzhG6vi7IuqZNt6nNPkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765494;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0p6hMGE+//poeEx8hRkp6hB6G3QJQeHYF5xU78jVTnQ=;
	b=SNIsTpfNAnVMZq2PKzpZ+1mO9zQHlC2l+okEwoPiZbEQbqTu1XHprSwEfvGPZmFqbgUs
	 dxe6nljBTJg9OioKghVtLlf2mn6FnSyCw1vuqT1BiG3EkeFxZt98HEK3ruU4lPw6kOvfT
	 qBgFmKs0BM4eXo70QnJsvUWIhp7Pjlbh6i2/c0Ag4ytlmtu6jYu84S5WyvW/sOiV6IDEG
	 JuONMzJvpRub0YQitWDer8xe/AXlQ0x+3slCf4Ktyht+kL3vwP/b9IkMuBZJEw8rHvMav
	 XPjHU+88jW/MaAIHYjEpPOxVmKqHypcDKy7f5kD/isFwsKjfbEScQBgo8bLB5VXZ5YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Nw3w+57p;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD88606A321;
	Fri, 27 Nov 2026 07:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD88606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Nw3w+57p
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795765484; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0p6hMGE+//poeEx8hRkp6hB6G3QJQeHYF5xU78jVTnQ=;
	b=Nw3w+57pg1NNimK6JJlsNHl8po6hRR+yEFtUAhdz+ZaK0Fba4IYjr8Y18ltBu2T1CiKUQia2e0B5z83mhmFhBt1LUEYcNFe3gon4jP0nA96nkeFByToVVf9C36O8he7rqLW/14on7G1i6+FKAjXtLtaNZPrQmzAHSZD89v3O7Ywf9BHPoxTtL4snEb5HRRhoHkxYfC9EZe/+tAEvR/TiPzWBw5nZYUuWr21dUXpXCikZ7meE803JGBIysi4hB0IAsCtOdlFwA5VLen/EO4H0E8jIayOEospbZJ2vJItBcvhUNsSHDnsOXRyaFbJablbPQRKlq9szRfzkezj1Ip+DvQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.309506-0.00180094-0.688693;FP=4518566215731003898|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.kBFoylV_1795765483;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBFoylV_1795765483 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:44:43 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] spi: add spi_sync_atomic() for panic and oops
Date: Fri, 27 Nov 2026 15:39:10 +0800
Message-ID: <20261127073913.353407-2-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
References: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
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

Add an explicit atomic transfer entry point for crash logging.  The
shutdown path is gated on system_state being past SYSTEM_RUNNING, but
panic and oops run while the system is still running, so they cannot use
it.

spi_sync_atomic() reuses the controller's transfer_atomic() callback.  It
only accepts callers that are in panic or oops context with interrupts or
preemption disabled, takes the bus locks with trylock so a normal transfer
in progress on another CPU returns -EBUSY instead of deadlocking, and
validates the message without allocating or optimizing it.

The first user is pstore over an SPI FRAM, which needs to persist the
crash log before the next reset.  The controller must already be powered
and clocked; this path does not resume it.  fsl_lpspi implements the
callback in the previous series.

This patch was prepared with AI assistance; the submitter must review it
before submission.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 drivers/spi/spi.c       | 69 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi.h |  1 +
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0569f30785e9f..857080d7f0b60 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/panic.h>
 #include <linux/percpu.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_domain.h>
@@ -5083,7 +5084,21 @@ static inline bool spi_in_atomic_sync_mode(void)
 	return system_state > SYSTEM_RUNNING && spi_in_atomic();
 }
 
-static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message)
+/*
+ * Panic and oops run while the system is still running, so the shutdown
+ * check above does not catch them.  This is only for crash logging and
+ * must not be used for general atomic transfers.
+ */
+static inline bool spi_in_panic_mode(void)
+{
+	if (!panic_in_progress() && !oops_in_progress)
+		return false;
+
+	return spi_in_atomic();
+}
+
+static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message,
+			     bool trylock)
 {
 	struct spi_controller *ctlr = spi->controller;
 	unsigned long flags;
@@ -5104,7 +5119,12 @@ static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message
 	if (status)
 		return status;
 
-	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	if (trylock) {
+		if (!spin_trylock_irqsave(&ctlr->bus_lock_spinlock, flags))
+			return -EBUSY;
+	} else {
+		spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	}
 	status = ctlr->transfer_atomic(spi, message);
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
@@ -5146,7 +5166,7 @@ int spi_sync(struct spi_device *spi, struct spi_message *message)
 
 	/* Keep old behaviour for clients that tolerate the warnings */
 	if (spi_in_atomic_sync_mode() && ctlr->transfer_atomic) {
-		ret = __spi_sync_atomic(spi, message);
+		ret = __spi_sync_atomic(spi, message, false);
 	} else {
 		mutex_lock(&spi->controller->bus_lock_mutex);
 		ret = __spi_sync(spi, message);
@@ -5182,12 +5202,53 @@ int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 	struct spi_controller *ctlr = spi->controller;
 
 	if (spi_in_atomic_sync_mode() && ctlr->transfer_atomic)
-		return __spi_sync_atomic(spi, message);
+		return __spi_sync_atomic(spi, message, false);
 	else
 		return __spi_sync(spi, message);
 }
 EXPORT_SYMBOL_GPL(spi_sync_locked);
 
+/**
+ * spi_sync_atomic - transfer a message during panic or oops
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * Context: panic or oops, with interrupts or preemption disabled.
+ *
+ * This is the panic-time counterpart of spi_sync().  It is only for crash
+ * logging and other very late communication; it must not be used from
+ * ordinary interrupt context.  The controller's transfer_atomic() callback
+ * must perform the whole message without sleeping, allocating, using DMA or
+ * waiting for interrupts or completions.
+ *
+ * The bus locks are taken with trylock(): if a normal transfer is still in
+ * progress on another CPU, this function returns -EBUSY instead of
+ * deadlocking.  The controller must already be powered and clocked; this
+ * function does not resume it.
+ *
+ * Return: zero on success, -EOPNOTSUPP if the controller does not support
+ * atomic transfers, -EPERM if not called from panic/oops context, -EBUSY if
+ * the bus is busy, -ESHUTDOWN if the controller is suspended, or another
+ * negative error from the controller.
+ */
+int spi_sync_atomic(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_controller *ctlr = spi->controller;
+	int ret;
+
+	if (!spi_in_panic_mode())
+		return -EPERM;
+
+	if (!mutex_trylock(&ctlr->bus_lock_mutex))
+		return -EBUSY;
+
+	ret = __spi_sync_atomic(spi, message, true);
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_sync_atomic);
+
 /**
  * spi_bus_lock - obtain a lock for exclusive SPI bus usage
  * @ctlr: SPI bus controller that should be locked for exclusive bus access
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f62b21af5d752..b3fad85ecbbab 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1512,6 +1512,7 @@ extern int spi_split_transfers_maxwords(struct spi_controller *ctlr,
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
 extern int spi_sync_locked(struct spi_device *spi, struct spi_message *message);
+int spi_sync_atomic(struct spi_device *spi, struct spi_message *message);
 extern int spi_bus_lock(struct spi_controller *ctlr);
 extern int spi_bus_unlock(struct spi_controller *ctlr);
 
-- 
2.47.3

