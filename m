Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194887;
	b=qMQBRwnZlB73/lJqMkDLQoIVo18tGu24SWfV5+HrzOG6Sm/bhj0UtC1UYklIHJ8pJkBL
	 Z2qJeBKap3IQayAJak4UXXmjn3IRwSYRBVCCgZGGgKMKBvU12VPWrWINgEkFrOkGybCxi
	 LTz/1Kn9Xn5VrHHwsD/NsfYTNtM1t2ouJdgR6Cq2EPe1GshoG6BBVIF3e2TNJlqsP2LXd
	 i70iT5o9gbxJvZiwM72ybe7S5jQD4rWcpvDPX7Tbz9RUuchCSq/2dQv1TweU0iUEGb20W
	 oX6OQgWhOarqnKVq1DaeAJ1z/tD2hX1Oe1R2Pf8qnYOgmuWwqI2A2VBZMTi1zD7W0WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194887;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=rl3Mk75xyW0zQ2gOEmhmXG4buQVCfu+lnbsiV7xtAg0=;
	b=IjKv2yDIEKWVcgXVXOvRmXpKxX5c4VlxcBzGzV8S0pNPEAHugUsTq30LOjnaVpn9w7Pe
	 cC3qtPYLls09eiU5P1jAEsvISBd5Unxre1k7okS42PArxUsd9HSQPAaPRa7MHUindyYsv
	 SVRXbQBpD6/48gDnNAkuVLEPdGakwZf9Kwv7RSoqEzVOd55VxQmHjzPq+i88rpxMKy/l4
	 60+heUN1w/pH0jEkjvuH06CovdkaGwnkQp1I9ExQ6pRY289YYFKlRQtcRYLDMwUwrzuXm
	 yOtIYn9YWpA5JcrvZ5wGR4rUuvrx1mfkrI+chsMj+zEta+EszWM5f3HUNygN0c9tXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rh7fHRoP;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EA60A2614
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63EA60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rh7fHRoP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 76D301A1756;
	Fri, 20 Nov 2026 17:14:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C996601B9;
	Fri, 20 Nov 2026 17:14:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 096CB11BC0500;
	Fri, 20 Nov 2026 18:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rl3Mk75xyW0zQ2gOEmhmXG4buQVCfu+lnbsiV7xtAg0=;
	b=rh7fHRoP9buRd36qCLgr0gj1TnnftXj5o1ezIclaqqwfDYqp72MJtSgpNVSKf5gV6W10t8
	DsO6tUqkikCDZvziUasD9xlj2fmvdbqMJOKw+Z79LLZZ6bMq2Xaw/HYBPUuzLgAoFBvtF8
	S+j+HQ2sq4NIKwM1ZYUi2DnGU2j8wO0ZWAWc0vsQDeEDwBtBavzMoysnTJFprdEfDgROlY
	lXwjqI63aitBiZb00klmjSt9bIaJzluxoXOtpLQTu8tZWcTcej+I7gC/Zhzs75cXjZ98zo
	KYzArbX5UX7lNfM4rGgkM3yDZ2yBlIzGrXjGgwg16qCI1MVNZF+6K8RRo4yTMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 20 Nov 2026 18:14:29 +0100
Subject: [PATCH v4 03/11] dt-bindings: spi: Document the spi-dqs-not-wired
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
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-3-8c21e1f71f41@bootlin.com>
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
index d730442e5255..fed6bf5ce72b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -138,6 +138,16 @@ properties:
       pattern. Used when the device cannot load the pattern dynamically during
       PHY tuning.
 
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

