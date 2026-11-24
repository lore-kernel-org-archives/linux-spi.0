Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531420;
	b=xJFGeW+GJK7A7iLvV5A70VOxMIhJinUwrrxUPE3fkcgIWdrpWqFo6XUdHMXkAGZjVWX5
	 qtFLZbb9XlnueREPSPjTw3JmNLpF0FIv3I1wmPiF0MH35rNX6m6Mo1KLGw1NoSDBSuqOt
	 r40oWugEN8bzIslcZs9Z7ElKTNlXqc0ncxfATW+ZtcGBVsg2R6LOdq38EVZ2GqdMGL8vu
	 H8P2BNQzlwPhBJO3EQ1SSSb8MRuGuRznNevtFtuqRa1/VBqRW/Acd3tuFie85yEPvQkOm
	 Sq6o5WLCYDW4q4JpxtWCSvl1Vs5cnOHVlVzkftvbysycjCRubQTEeRfERIv84hnKGeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531420;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ux1V2IaGVa66tGtBClvFUbeAyk5NI0EViYfPGeuBQzY=;
	b=f037IHbDNeZwfah8vPDfqZyYBNXP2KAXesIJm9iJyqivcTQUCiUY+fpCYTCkoeDjoaKT
	 dj5oqIQV/DLZq2AFHvFVffOPapltI9c//sj6LY3yO4wzE1SBDsw5WNzCA8IoQXeE5Orqy
	 zODGpP2PzpHc8UYdzw15P1oE4CGiMRCUoa/dfsWChU0Cp9FU626xHKSLE3xaP9/c0w/AD
	 fNBRIPzf+YEvDJekY0pSSdBnzpuYLStLK1FivqVeuNYk9UQrvgo7Qh3q8kwgxdR/ikC1f
	 M9Y8vTJUFFuUBlDxZlN4KzGR3Gt6TU5Y85z2bCv0XP7HnCchB1BbaTruHNs7pJR0/qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0n8A9sq8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EC606A321
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 14:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0n8A9sq8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 445354E41762;
	Tue, 24 Nov 2026 14:43:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19AC4601E1;
	Tue, 24 Nov 2026 14:43:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AB2611E6936F;
	Tue, 24 Nov 2026 15:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795531417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ux1V2IaGVa66tGtBClvFUbeAyk5NI0EViYfPGeuBQzY=;
	b=0n8A9sq8oJtr0qqCbcicgPAjmtHo+gS2EarzQHQrG4FZS3PZ+WeCbithVF84aGScgUqPX4
	WO8wjDkQph7atQRVHlnYDmZmm/Ii8frG22X2tkJCVYMLFJg53gwMb5Xx3Atd+0ldEdjUSy
	te+MYICaT2cCMItzvDoewSfkfBgS7ASEdrMqEPbxps8RICcxIE9sp1tZcFHqiX/mjP0p4L
	N+CKw+vQNodv9TM/JFqp96USo+RHJNFLMJaNRDByP1q/0egEnBzDiV0OU/6r7d7o5sbK2E
	UVaon/v7jtiyE/9V9sVph/8V5L+w3whdL7JhLGLOcFZ3f9PS0m3kp7lc1yHSCA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Nov 2026 15:43:04 +0100
Subject: [PATCH v5 3/6] dt-bindings: spi: Document the spi-dqs-not-wired
 property
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
Message-Id: <20261124-winbond-nand-next-phy-tuning-v5-3-261e0e712857@bootlin.com>
References: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
In-Reply-To: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
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

The DQS line is a data strobe line that is typically driven by flash
memories (NOR and NAND) when the data flows from the peripheral to the
host controller when running at high frequencies in order for the data
bits to be sampled by the host at the right moment. The SPI bus already
features a clock but this clock is driven by the host, which means it is
not accounting for any chip internal delay.

Hardware engineers, if they do not expect the frequency to be configured
above the usual limits (dozens of MHz), may not route the DQS line
between the SPI controller and the peripheral.

Describe this possibility with a new optional property so that the DQS
output can be left disabled on designs where this would be
wasteful. Keeping DQS enabled while it is not routed mostly costs
spectral business and extra power consumption. Hence my proposal to keep
"wired" as a safe default.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8f4b4b202e1d..8a6288e6b20b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -125,6 +125,16 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-dqs-not-wired:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The DQS (data strobe) line of the peripheral is not routed to the
+      controller. This is only meaningful for peripherals that have a DQS
+      pin, typically octal DDR SPI memories. Not routing this line is a
+      possible board design choice, for example to save a pin when the
+      memory is used at lower frequencies. If this property is absent,
+      the DQS line, if relevant, is assumed to be wired.
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip

-- 
2.56.0

