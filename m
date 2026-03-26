Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A241C2E1
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543653; cv=none; b=S9r2Ayibh/TWG/dgLRa8Ni/SeZYkM6K1n67XV7kKLlaBqGeCmu8pjjQOHSEsnGrOkhZsMtWFKTBbvQ+0LJGK7k6yyatXwd+zS5YmG3Lci/MJlo0uidURQaHc2dSgVVqhshXWqq7aCYvlFFCAnTKg5yW9HnZcRE+LRMyWZIGcixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543653; c=relaxed/simple;
	bh=e0+Gl4gvADKzV1vp87wo+NG3+6GmjvIUIY/wimvNd3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHjoFuNHZFXydR4DomXXgVAkAQhAiDDg162TXFSNLpKA5FPD1C9alGjcVo1t1jsu+N+LfejZdH60hAEoIfJrG1unMnbV9cOltKpTJWqJ8Cxa/Lw29FBgyC51a7lxMbufGoU9z5LNYfNH+/uPd1CycM7bL96wOwFdGsEYfJi9Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QVrOi4Jp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QVrOi4Jp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D9E414E42811;
	Thu, 26 Mar 2026 16:47:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB10D601FA;
	Thu, 26 Mar 2026 16:47:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6583D10450CCF;
	Thu, 26 Mar 2026 17:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774543649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ebNUwgP/GGdkmoEPbwrY9xjw3LbvdfCwLlwmJ4VgFuQ=;
	b=QVrOi4JpUMJpUVQsP16RBS+GBel4hrhhmq83cSzANaPfLpVokx7Ajcpdkmm22BjXx1NfTB
	iyXvmEYjNe69ORbDFwDNmEvJFddySbIRXqOXC1J8WvtkKi2zZBMm3qh14KBUwmWz7i3gq/
	v/Uiv7un6B8LYLWwmm2OdeBcJamEVosTmZBPN9/HVRkOfCsoYeQywSUXiHNQn12ggePS0e
	NfkEBDGF5wxPh86ARdsp3+QbU51s8mevxR6G3Mk0/43v0aMA0OP3Kzl9VtG/f0vxgo12hW
	znlmqC8czInGrHDlq6fE4VJe8df+qQYbByw6PqU+Ti+NjKLNM3g/fsLLdCMTbA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:47:15 +0100
Subject: [PATCH 1/4] spi: spi-mem: Add a no_cs_assertion capability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-1-0d626e1dfb2b@bootlin.com>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Steam Lin <STLin2@winbond.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Some controllers are 'smart', and that's a problem.

For instance, the Cadence quadspi controller is capable of deasserting
the CS automatically whenever a too long period of time without any data
to transfer elapses.

This 'feature' combined with a loaded interconnect with arbitration, a
"long" transfer may be split into smaller DMA transfers. In this case
the controller may allow itself to deassert the CS between chunks.

Deasserting the CS stops any ongoing continuous read. Reasserting it
later to continue the reading will only result in the host getting
garbage.

In this case, the host controller driver has no control over the CS
state, so we cannot reliably enable continuous reads. Flag this
limitation through a spi-mem controller capability.

The inversion in the flag name (starting with 'no_') is voluntary, in
order to avoid the need to set this flag in all controller drivers. Only
the broken controllers shall set this bit, the default being that the
controller masters its CS fully.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
I am open to suggestions regarding the naming of this flag.
---
 include/linux/spi/spi-mem.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index bd2a73d46980..de153719a08e 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -373,7 +373,10 @@ struct spi_controller_mem_ops {
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *	    Octal DTR
  * @per_op_freq: Supports per operation frequency switching
- * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
+ * @no_cs_assertion: The controller may automatically deassert the CS if there
+ *                   is a pause in the transfer (eg. internal bus contention or
+ *                   DMA arbitration on an interconnect). Features such as NAND
+ *                   continuous reads shall not be leveraged.
  */
 struct spi_controller_mem_caps {
 	bool dtr;
@@ -381,6 +384,7 @@ struct spi_controller_mem_caps {
 	bool swap16;
 	bool per_op_freq;
 	bool secondary_op_tmpl;
+	bool no_cs_assertion;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\

-- 
2.51.1

