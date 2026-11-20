Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194881;
	b=aNnTHHKvpSwyTjrIbbwadmdM65m0WPsH0j/U8is2a37KodNkl7y/2f5Px451dW/xj3lc
	 XGhMMITz+SXltpqEhQbh6hU2fvYiGJVwG4RUjI71Z/ZkjyaW+z1z8JDQaqp7ZxozPXuA5
	 urAbkXgWavocxG1Bi460kMn1NW2ziKnf3vjvphUgNzw8+oQy8azG/PAOQ3srOcBVXYISB
	 bKPExwGeuA0EDK420De+1AWIkDnVIIdLJMhrlQsQQBFa+j57YoVNc4RCBEqg0QpQZgbnq
	 o1Kod/ZfULGS99ms7ACUOpHERqhRjgZlwcqL43lfLsYhMkDWqRloq5lJfCK4uoMAOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194881;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=P3hD6i6FmHxjhbYulZUhRwAmsKH4wKmtldQ3QjAxjxM=;
	b=hHePuOtTuufAUAjUqT9vQ1fENIGKLdR63Dtk4zpeGx6X/7VVe5XBxat/TdKvztInF8cM
	 6Hlk5ZJpUMgCf4QyOywy0bzApLC95QZAdkCX0kESeo59eeG7kgMsKqVHdch4gOBq5oTzX
	 mT8zc7GqR+WxZSAT/myUMCqwk9IBRukpVolWIQwX3NBDtgrTWDs3ypd+fFG1a6295xhdL
	 sFJiGOW4zfuQNBA4F6mxqLJln3JJhccXRLdLzaJjym821LEuFat94YFNPYMr8+xuQs+AR
	 fV/cWDHnhwUEhiU6HJ/pSdleRrzRPz2Cz2VspXJULs6YffmBOE5ckuBEG/E/rU7+iSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ykLe3nRj;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726C60A260C
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2726C60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ykLe3nRj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B13154E4168C;
	Fri, 20 Nov 2026 17:14:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D81E601B9;
	Fri, 20 Nov 2026 17:14:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0DE111BC04A2;
	Fri, 20 Nov 2026 18:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P3hD6i6FmHxjhbYulZUhRwAmsKH4wKmtldQ3QjAxjxM=;
	b=ykLe3nRjZqOHOxvwu13ykk8zaeqY4YdR12e+9sqrVJ6vpzJKfsNk/p/AwdCGgBPxMuw2aY
	f2YXoIHByiv5LizTM99x1xW+LYhzEdHpcpJ2/FvEsrofuJFmiCfMX0d3nWMjJa9fVVgbPe
	F5F0eolM+6iND5kTu2qwlFUc15Jg/Z3+5Ymp4IxIF43PRkYh51x7U+7D5VdU/V7Vpp7oVu
	Brfj3e96PwL3rU4dh3TcOb56rBBwiSjlC9vQUyNsxxWIejtpU/ecq0g3oKMZuWmbNRUBki
	leR/URQEcDwCN5gyFjHCKu8rAIImQeMO2L7f56CgRb6LsSSKnWtJJO0J3Z/63g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 20 Nov 2026 18:14:27 +0100
Subject: [PATCH v4 01/11] spi: spi-mem: Rename the DQS setter and pin field
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-1-8c21e1f71f41@bootlin.com>
References: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
In-Reply-To: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The current approach was a bit too simple. Using the DQS feature
requires:
1- the chip to feature a DQS pin
2- proper wiring between the host and the chip
3- the controller capability to use it

Rename the helper and the field to reflect that we are talking here
about (1) the chip capability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 10 +++++-----
 include/linux/spi/spi-mem.h |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index baf6e430e563..1bea52c6f8a3 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -547,7 +547,7 @@ const char *spi_mem_get_name(struct spi_mem *mem)
 EXPORT_SYMBOL_GPL(spi_mem_get_name);
 
 /**
- * spi_mem_set_dqs() - Mark DQS as being available
+ * spi_mem_set_dqs_pin_available() - Mark DQS as being available
  * @mem: the SPI memory
  *
  * When reading at high frequencies (> 100MHz), especially when DTR is enabled,
@@ -560,11 +560,11 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
  * Set the DQS boolean if the feature is available and configured at the chip
  * level. Controllers may query this value.
  */
-void spi_mem_set_dqs(struct spi_mem *mem)
+void spi_mem_set_dqs_pin_available(struct spi_mem *mem)
 {
-	mem->dqs = true;
+	mem->dqs_pin = true;
 }
-EXPORT_SYMBOL_GPL(spi_mem_set_dqs);
+EXPORT_SYMBOL_GPL(spi_mem_set_dqs_pin_available);
 
 /**
  * spi_mem_has_dqs() - Query whether the DQS is available or not
@@ -574,7 +574,7 @@ EXPORT_SYMBOL_GPL(spi_mem_set_dqs);
  */
 bool spi_mem_has_dqs(struct spi_mem *mem)
 {
-	return mem->dqs;
+	return mem->dqs_pin;
 }
 EXPORT_SYMBOL_GPL(spi_mem_has_dqs);
 
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index b69f671c40e7..e3c0016be768 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -275,7 +275,7 @@ struct spi_mem_dirmap_desc {
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
- * @dqs: extra data trobe pin available for high frequency read operations
+ * @dqs_pin: the memory provides a DQS pin
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -287,7 +287,7 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
-	bool dqs;
+	bool dqs_pin;
 };
 
 /**
@@ -474,7 +474,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 }
 #endif /* CONFIG_SPI_MEM */
 
-void spi_mem_set_dqs(struct spi_mem *mem);
+void spi_mem_set_dqs_pin_available(struct spi_mem *mem);
 bool spi_mem_has_dqs(struct spi_mem *mem);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);

-- 
2.56.0

