Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873F405AC9
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542377; cv=none; b=ZoBh6eqbg3FiZiPaBan/mX3wbSA6UsGlTetfPTlXaB16ZAPvnufQPLWmhN8jopSLfVHb2Hiz0Wv9wGQImlxMjwroWwQOQ3Aj0Ft2XRSbl1IxxVX2Q3x+PDZkHUuESfYugVeWdD+0F6I9iCSp41vav0olHtqTHP7NL80Nw7kV9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542377; c=relaxed/simple;
	bh=bt9cNy4PTjGQSzX5sD2HfXzmDUDdOzPGF/Gog5lLLy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeWEC86XgV7PYXmXPFF8svjDTTuALGYd3GzUMhXU3hRTLEoReiGmc9vOEbItJRQNIk0IQtvbcLpEmTA+RXFJ3W2cTzj4mYFlMMDcw7wiP4mjKj4disqlvwpHoV69dhF/oFuHUxKOO0oNcajCdBsncsxvdg6XF9/sADHzxw9O4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I/QLYXw9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I/QLYXw9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3AF6D4E42811;
	Thu, 26 Mar 2026 16:26:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10BD2601FA;
	Thu, 26 Mar 2026 16:26:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6784310450C96;
	Thu, 26 Mar 2026 17:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AP5EDvNSDOA4mcH2wjjTrtd89tS9FG178G3LqqbkZ1Y=;
	b=I/QLYXw94NxpfiQ3i07ghpBYmjFR65mBcb2bSgGRkLT8NmTV4awILLREQcVwzt1PZVMrvV
	TZj3wCkZDcxfM8knSa2UFLliOx2/o6ZrUWutvLmuhCYXqNvqnz/6x64c1XqqxERRPfbCQB
	NWJOpus8tSl+l2eLgSo17ryVhAB2uk2BUN/Zx7NhXNjqxAVMxIayo8Lnn8x5IJVuFJPF0Z
	jvdHlB1Z95tZGwifXAeZ056R6XXtp3m/s4K+9QPgSglP2Qr5tAeUMx2J60aSPETUoT6oFY
	fb4ZFmbjYW/WqLCa/MjXPGtaAWaCrA6UQBAStC5plHZ0Fg/OpiqgZ2Ts+EOTzw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:52 +0100
Subject: [PATCH v2 05/11] spi: spi-mem: Create a secondary read operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-5-643de97a68a3@bootlin.com>
References: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
In-Reply-To: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
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
index 3cba7fe4bed5..bd2a73d46980 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -215,6 +215,8 @@ struct spi_mem_op {
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
  *	     the memory device is accessed
+ * @secondary_op_tmpl: secondary template, may be used as an alternative to the
+ *                     primary template (decided by the upper layer)
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
@@ -227,6 +229,7 @@ struct spi_mem_op {
 struct spi_mem_dirmap_info {
 	struct spi_mem_op *op_tmpl;
 	struct spi_mem_op primary_op_tmpl;
+	struct spi_mem_op secondary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
@@ -370,12 +373,14 @@ struct spi_controller_mem_ops {
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
2.51.1

