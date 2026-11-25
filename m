Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629126;
	b=M1GvjCZSezawg/98wP1WwIJqDXKLStfEldVBWjieOKb4w+JiLzhhZAS5H/34qQidfSva
	 suDAMEs/dMk2VLM488oaptSl+PRpZH1SXWhOHw/UB3iOcer6G1nYDiupeRaQhVb2tsSN3
	 o0ShWmBTLgGAESkHMWVT+qX4bQItU5BV9YAG6sqXeHwOwNryiFHJH0GJYTSENl7J3+EhF
	 3E8bTyK1ACxAE9hZlyf/ItBa1XBD5KXENboNGBuHQjLSa99YSldVFkV7iMMzO1LjuBcmf
	 VnSkue+JgJFvE/oFoY1VYATf9+cGa3cHH9DPblkLbH3qv88qP+bqlPGrQOP4+/ckezA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629126;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=iZxx/bv8sERrldyegt+0p8ETCEh3QBNaziABehRhDAk=;
	b=x0IzM1wq3bLR4SVqNAkmcVgPBGgxheOSKyUQV6Q4GrzRIQISBle+ZoZ1vkO+6cFvv6My
	 B8q0yRsadX93cmmMbP8gw0lojndbVfou23L7qfo4uLMVvHRwREb3FfRKzwsLBBodgd6Jo
	 lP5dmBbdYXnfrXqRslkjBORZlb5gCdxdB+MfXm5Yt3+FV8l4pY6TyWbJPJjSChZFalBop
	 FRfNgfMY89vtS3Crg5C4WBhB/4dlG6w47r8Cj5fnkuci3etqmxLAUZisj8bL62HTdMcJ+
	 wvB/3zjkktFeM3MNRj9IMgBFXD76lmPC/n82scr8VQWT+yE0f0XZFMkvPN2NeClwaQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yL6AMJxn;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD935606A331
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD935606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yL6AMJxn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8CDBE4E41785;
	Wed, 25 Nov 2026 17:52:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6114960480;
	Wed, 25 Nov 2026 17:52:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6417311E6B0D4;
	Wed, 25 Nov 2026 18:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iZxx/bv8sERrldyegt+0p8ETCEh3QBNaziABehRhDAk=;
	b=yL6AMJxnVUerS+qMBN95vJA+Y7K3/dhFouRAcBhWhxAyGTqONCU8kzEjNSe7yny1XlTZ2B
	1eY+gEOS/9vAcE39SthkjtppvaT8ilNd0zgyRGfqcGEG6Afe9IrA7IgFgscjHhhp+KOQAP
	DL9AYhtRwBa9ZCQ5d4wJ0Vr7b5xq4Y6tYOcOWHTIiZ7GLPmkjl3RWdSMGGwynH37OOzvFh
	Ys/b/Q+BEna2T4nbn6uw8wqQSGRDQHFArZ+7lM5OjjkH1sLshzEUsT9VZN05oAzllz9F7n
	KMKsqdpUq/KO3jvXSrm3Z5EtgyPlyDsfqTSmXRpva+TWp12wUjblVK1kCBET3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:18 +0100
Subject: [PATCH RFC 04/16] spi: amlogic-spifc-a1: Consume dummy cycles
 directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-4-fd036402fd37@bootlin.com>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The spi-mem layer is now capable of providing the dummy phase in cycle
units rather than bytes, provided that drivers advertize the dummy_cycle
capability. Since this controller is consuming cycles and currently
converts bytes into cycles, flag it capable to consume cycles directly
and drop the extra conversions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 388bd2472dc0..282647cd6b56 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -90,7 +90,7 @@
 #define SPIFC_A1_USER_DUMMY(op) ( \
 	SPIFC_A1_USER_DUMMY_ENABLE | \
 	FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
-	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.ncycles))
 
 #define SPIFC_A1_TSLCH_VAL	FIELD_PREP(SPIFC_A1_TSLCH, 1)
 #define SPIFC_A1_TCLSH_VAL	FIELD_PREP(SPIFC_A1_TCLSH, 1)
@@ -269,7 +269,7 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 		amlogic_spifc_a1_set_addr(spifc, op->addr.val,
 					  SPIFC_A1_USER_ADDR(op));
 
-	if (op->dummy.nbytes)
+	if (op->dummy.ncycles)
 		amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
 
 	if (data_size) {
@@ -321,6 +321,7 @@ static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
 
 static const struct spi_controller_mem_caps amlogic_spifc_a1_mem_caps = {
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static int amlogic_spifc_a1_probe(struct platform_device *pdev)

-- 
2.56.0

