Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA141B352;
	Wed, 29 Apr 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485478; cv=none; b=WDzpnBOZ+7kiIxcph09DEqgrx4mYSLnf2bAF9tXwTWoYyUq2H2zR0Q91zRdDtc7J1jBkYyZHtiblO5J8Y1uodYv/1wY1FqoeESRx6KH0K27ixzzBiZstm8EVtGjmxd4KBhKIqmoYRmEqq5MZ8tFEBWJSGZcwy4BeQ/avk1inwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485478; c=relaxed/simple;
	bh=phTwVY58SZL7fjULrgc3nFQZ0M51jPXq2NYti7BkbNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BN/erFx9aCw4BuKC5c18IOI6UQ3In7c18UWY29T5ZpEcEqoXVXl3Qjiwk40On5GIVXtlKbABT2nXZQR84hbqG+IAc/l9Ns2QvrLd1QTzQx1J9EVH+AjCDoH5QQ7fS+qEyoIc/my2iwtY55D67fus/zPS8IM3Pd7LLGArteQvtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K0amzfyc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K0amzfyc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2B37A1A3453;
	Wed, 29 Apr 2026 17:57:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F35B55FD43;
	Wed, 29 Apr 2026 17:57:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FF5A1072B173;
	Wed, 29 Apr 2026 19:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ChgtJK72vZUlsiBaKPcyKbWrS3ajSynsgsTRx3iHXAU=;
	b=K0amzfycc9kXe6uiG4uUt/UiAhIdiGMzKOl7+OtAUig03P9w5Oi4pi71lfOK4VzCWadfpc
	nS5TLgH8UeOpLv9oqplFB7SfTVmfJbMNIhuGL5isL94d1zok7pU+S8QA5DWBkSbgh28SJz
	DZearlJ5Cu/VO0kJdyM9+tAQscMA0+OXCO9beDN4ZJPGNWzVEq1MJI7sPFDuRqVpC63fLQ
	Pic34fN8lxySr8+En0zBofRfLA+dt1XFD2tD6zmSWls95oUd8rvbzJXRh5bZmIbqP8kUKa
	E5JC9PYLpexMp71IOMLC7TSlwz1RJMfwhawHgZ7crGtjiqwa80VGQE5DnFcuTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:42 +0200
Subject: [PATCH v3 05/11] spi: spi-mem: Create a secondary read operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-5-0f38b3c229ad@bootlin.com>
References: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
In-Reply-To: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In some situations, direct mappings may need to use different
operation templates.

For instance, when enabling continuous reads, Winbond SPI NANDs no
longer expect address cycles because they would be ignoring them
otherwise. Hence, right after the command opcode, they start counting
dummy cycles, followed by the data cycles as usual.

This breaks the assumptions of "reads from cache" always being done
identically once the best variant has been picked up, across the
lifetime of the system.

In order to support this feature, we must give direct mapping more than
a single operation template to use, in order to switch to using
secondary operations upon request by the upper layer.

Create the concept of optional secondary operation template, which may
or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
underlying SPI controller does not leverage any kind of direct mapping
acceleration, the feature has no impact and can be freely
used. Otherwise, the controller driver needs to opt-in for using this
feature, if supported.

The condition checked to know whether a secondary operation has been
provided or not is to look for a non zero opcode to limit the creation
of extra variables. In practice, the opcode 0x00 exist, but is not
related to any cache related operation.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
The choice of defining two variables named primary and secondary instead
of using an array of templates is on purpose, to simplify the reading. I
find less obvious the use of an array here but this is personal taste.
---
 drivers/spi/spi-mem.c       | 17 +++++++++++++++++
 include/linux/spi/spi-mem.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e2eaa1ba4ff6..f64eda9bbd9f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -713,6 +713,23 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
+	/* Apply similar constraints to the secondary template */
+	if (info->secondary_op_tmpl.cmd.opcode) {
+		if (!info->secondary_op_tmpl.addr.nbytes ||
+		    info->secondary_op_tmpl.addr.nbytes > 8)
+			return ERR_PTR(-EINVAL);
+
+		if (info->secondary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
+			return ERR_PTR(-EINVAL);
+
+		if (!spi_mem_supports_op(mem, &info->secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+
+		if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create &&
+		    !spi_mem_controller_is_capable(ctlr, secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	desc = kzalloc_obj(*desc);
 	if (!desc)
 		return ERR_PTR(-ENOMEM);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 9a96ddace3eb..2012a3b2ef91 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -227,6 +227,8 @@ struct spi_mem_op {
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
  *	     the memory device is accessed
+ * @secondary_op_tmpl: secondary template, may be used as an alternative to the
+ *                     primary template (decided by the upper layer)
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
@@ -239,6 +241,7 @@ struct spi_mem_op {
 struct spi_mem_dirmap_info {
 	struct spi_mem_op *op_tmpl;
 	struct spi_mem_op primary_op_tmpl;
+	struct spi_mem_op secondary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
@@ -382,12 +385,14 @@ struct spi_controller_mem_ops {
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *	    Octal DTR
  * @per_op_freq: Supports per operation frequency switching
+ * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
 	bool swap16;
 	bool per_op_freq;
+	bool secondary_op_tmpl;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\

-- 
2.53.0

