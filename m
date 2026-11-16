Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822863;
	b=eNrPGHZS/WwxZ6u4+gTJJdDuC3YaSADlskYHwA4FcpHiA02VOumVJFalkVvgDL15mhe/
	 ha6gdwtHiH7DrdF4WChhQuH+DuUiCgR+6iykfm27BVj9J/OeP0BQ6vBXcYqX22gYQBz13
	 CZWo5suVavugmyaMb28T3rMzqgTf5Wy2EyUD3mJvLw03Yf0yUKpu6A2ew812DP99gKXJo
	 jydwMdTToo1bOqvU2MBT4XciERh679X/GasQxvY3wvsZoaaHCCWevrgbIU5RrFaw75CVS
	 EhdtlQKkKVEwApb3h2b2e9hu1/NeM9b823DhQQQRkg/j6kYkJfLPjdRXyPw00iIn0tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822863;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MIEsz04HMukRNUYKBj+g59TS1FT0VEv2KoQXa5uhrKE=;
	b=RitrNkgJeBhEwbvmksmsBM0jdtuPxihCXPxh5j2BKJGcgT+HQcymZnZxHe47hRHhMlPY
	 oZZaFTRpwymIXxEffiQyMEE1NNITonHjLV9rzk7w3uovkKJyea+iclSY/UPaaWiX5i40r
	 O0HCWOs2Xay2KrDwozv3+EgiinlBjbM/eP718urfN3XqN8lhDfpgSNuECWx42JIHlF3/i
	 4E+6o6fOl/7679cX63zO7yzQLiAmFiak7legiLQ+wbQJVgzza1LduKUVSfaJMkMk/E8Gz
	 rQDxvwTQVETAiuASbv5dg8YdklYV+/e/iuT6BnVyJy5r0fsCKkh/STUdtpYARGJUqAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=O7Xwzy+0;
	arc=none smtp.remote-ip=115.124.28.170
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0326606A335;
	Mon, 16 Nov 2026 09:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0326606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=O7Xwzy+0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794822855; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MIEsz04HMukRNUYKBj+g59TS1FT0VEv2KoQXa5uhrKE=;
	b=O7Xwzy+09/5peDjnJyMgcXYDdtti9LbpgUBViK/Y9wWe8WQZf4CNfyk0POWmqb1aHe2cgH0LEmwDp2dUHElVpRlTqYPKgazyq/y0JASFU52SV4kaskAQNBub1CXhOi7gEqDhtcn1wt0soc8sylah8KYapfeKH2RRy/tbZy6oDRKlsvb4QMHzoyFIAp98OZXAMKtjEsoCq+JnpcO0AtkQcL7owXpvdOjgRUDvj3EFQD2zqsqD5zedAB5rjsWBN5IyverwB11+CjIibXN+ljDHPGEA11nGd1weTuJrhVHBT60wdbelSjOzioZBL3Z9SPvjMVLdFkTPYVLM0wAstZfopw==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.309506-0.00180094-0.688693;FP=3933085070037369330|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.k33mMOj_1794822854;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k33mMOj_1794822854 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 17:54:14 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH 2/2] spi: add spi_sync_atomic() for panic and oops
Date: Mon, 16 Nov 2026 17:49:15 +0800
Message-ID: <20261116094916.4039108-3-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116094916.4039108-1-chunyuzhiqiang@yinhe.ht>
References: <20261116094916.4039108-1-chunyuzhiqiang@yinhe.ht>
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
shutdown path added by Heiko Stuebner is gated on system_state being past
SYSTEM_RUNNING, but panic and oops run while the system is still running,
so they cannot use it.

spi_sync_atomic() reuses the controller's transfer_atomic() callback.  It
only accepts callers that are in panic or oops context with interrupts or
preemption disabled, takes the bus locks with trylock so a normal transfer
in progress on another CPU returns -EBUSY instead of deadlocking, and
validates the message without allocating or optimizing it.

The first user is pstore over an SPI FRAM, which needs to persist the
crash log before the next reset.  The controller must already be powered
and clocked; this path does not resume it.  fsl_lpspi implements the
callback in the previous patch.

This patch was prepared with AI assistance; the submitter must review it
before submission.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 drivers/spi/spi.c       | 72 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi.h |  1 +
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0b1e07d87..e24ad60e1 100644
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
@@ -1712,11 +1713,25 @@ static inline bool spi_in_atomic_mode(void)
 	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled());
 }
 
+/*
+ * Panic and oops happen while the system is still running, so the shutdown
+ * check above does not catch them.  This is only for crash logging and other
+ * very late communication; it must not be used for general atomic transfers.
+ */
+static inline bool spi_in_panic_mode(void)
+{
+	if (!panic_in_progress() && !oops_in_progress)
+		return false;
+
+	return IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled();
+}
+
 static void _spi_transfer_delay_ns(u32 ns)
 {
 	if (!ns)
 		return;
-	if (ns <= NSEC_PER_USEC || spi_in_atomic_mode()) {
+	if (ns <= NSEC_PER_USEC || spi_in_atomic_mode() ||
+	    spi_in_panic_mode()) {
 		ndelay(ns);
 	} else {
 		u32 us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
@@ -5027,7 +5042,8 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	return status;
 }
 
-static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message)
+static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message,
+			     bool trylock)
 {
 	struct spi_controller *ctlr = spi->controller;
 	unsigned long flags;
@@ -5048,7 +5064,12 @@ static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message
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
 
@@ -5090,7 +5111,7 @@ int spi_sync(struct spi_device *spi, struct spi_message *message)
 
 	/* Keep old behaviour for clients that tolerate the warnings */
 	if (spi_in_atomic_mode() && ctlr->transfer_atomic) {
-		ret = __spi_sync_atomic(spi, message);
+		ret = __spi_sync_atomic(spi, message, false);
 	} else {
 		mutex_lock(&spi->controller->bus_lock_mutex);
 		ret = __spi_sync(spi, message);
@@ -5126,12 +5147,53 @@ int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 	struct spi_controller *ctlr = spi->controller;
 
 	if (spi_in_atomic_mode() && ctlr->transfer_atomic)
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
index f62b21af5..b3fad85ec 100644
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

