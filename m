Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146E408611
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374676; cv=none; b=CN3zmis1R/CzMp2isqNDF2emuNjzcwJMXJfDo9310kGoR6UyPlg1IxM3JUrLxJNLa0yfp8VAc6evUG3t28g3B2m3R4cvGwDUjsp9Q4S/0G8Yz3e0Zg7W4JzxltEWb6/nt6VWpzsoA5/jfMKUYuVSjsFVgpGpsnwLAXuj4X6aAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374676; c=relaxed/simple;
	bh=i/G1An0VHWTu6Kk1L/fgdDQndh5AbgnUyrA5Wx6vERE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k42fHINJ5zfFx1TvYS1u40EAROTckscoVtFPdJeOO3Rfv3ONCQxww/TB4eHamyvreRhCVbdXj5KOTH/SGO9eYUhtYfbH68/CYfmp0TX43FJjdilB4KGYFzDWUxFS4MfvhzP7Jn3vMIAHo83VfANVRIStRlCXBx9J1i1C7Wgnb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v+uGeFwD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v+uGeFwD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2FAA64E41193;
	Mon, 10 Aug 2026 15:11:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 052136033B;
	Mon, 10 Aug 2026 15:11:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2228A11C4A9F4;
	Mon, 10 Aug 2026 17:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786374666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dPbz9BIgZZPw7WZpzE8qr59XBu7j/hRKKLXb1kSnc50=;
	b=v+uGeFwDr2kTSpl5iGYfde2p2uhZAztahPlzAOUcV/fERhFSO4pB5rkqoTXk3oanJrC3rJ
	tiW+ws2aufZyo1XnCP44yVa8NKwWTAA45VPPug8WpziMHonhrYGFLIzYuSJK7t51dtmQgX
	enkZtKR0O5pO4ktjLzrKaRo+ZklEvao1c2iEzX3bq2vpvZvageZ2EdBsCtR4wjuJVHQBeR
	lTzQ5ZnwW5QK2uYVqyIaPmYL9EhkLxP8sQrIQBK0/4TO5QZL7eszONVEx90yikl6emE9iO
	aaPW+XDj1ICQ28Bz7y7kuUOP270iDaHghIbR5YFHGbMjyGHQsmR7zK2+COIbzw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 10 Aug 2026 17:10:42 +0200
Subject: [PATCH v3 1/3] spi: spi-mem: Flag DQS capability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-winbond-nand-next-phy-tuning-v3-1-a97c3a61e675@bootlin.com>
References: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
In-Reply-To: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

DQS is a typical SPI memory signal used to help with reading the data on
the bus at high speeds (especially in DTR mode) by avoiding clock
skews. The chip generates a clock signal synchronized with its data
output fronts, also called data strobe.

SPI NOR and SPI NAND cores must set this flag in order to indicate to
other layers that DQS is available.

Create a getter and a setter to reach this capability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a88b9f038356..5f973ebfb8b6 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -541,6 +541,38 @@ const char *spi_mem_get_name(struct spi_mem *mem)
 }
 EXPORT_SYMBOL_GPL(spi_mem_get_name);
 
+/**
+ * spi_mem_set_dqs() - Mark DQS as being available
+ * @mem: the SPI memory
+ *
+ * When reading at high frequencies (> 100MHz), especially when DTR is enabled,
+ * transfer speed is limited due to clock skews. In particular, the controller
+ * does not know the board propagation delay nor the memory chip internal delay
+ * (clock in to data out) and thus cannot optimize its sampling points.
+ * Mitigating this limitation is possible with the addition of a data strobe
+ * signal, commonly named DQS.
+ *
+ * Set the DQS boolean if the feature is available and configured at the chip
+ * level. Controllers may query this value.
+ */
+void spi_mem_set_dqs(struct spi_mem *mem)
+{
+	mem->dqs = true;
+}
+EXPORT_SYMBOL_GPL(spi_mem_set_dqs);
+
+/**
+ * spi_mem_has_dqs() - Query whether the DQS is available or not
+ * @mem: the SPI memory
+ *
+ * Return: a boolean indicating whether the DQS signal is available or not.
+ */
+bool spi_mem_has_dqs(struct spi_mem *mem)
+{
+	return mem->dqs;
+}
+EXPORT_SYMBOL_GPL(spi_mem_has_dqs);
+
 /**
  * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
  *			      match controller limitations
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f660bb2e9f85..0cce6b57242a 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -275,6 +275,7 @@ struct spi_mem_dirmap_desc {
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
+ * @dqs: extra data trobe pin available for high frequency read operations
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -286,6 +287,7 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
+	bool dqs;
 };
 
 /**
@@ -461,6 +463,8 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 }
 #endif /* CONFIG_SPI_MEM */
 
+void spi_mem_set_dqs(struct spi_mem *mem);
+bool spi_mem_has_dqs(struct spi_mem *mem);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);

-- 
2.54.0

