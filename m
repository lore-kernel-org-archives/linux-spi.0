Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8348BD39
	for <linux-spi@vger.kernel.org>; Wed, 21 Jan 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015120; cv=none; b=KAvIt3F0lylyBoSaHS4ePHPB5qRRh9KTkE58dkCfgm2KSSOn5gg/j6fHuZjcMUHmXXjdNqejS6OcY8H9tBdrYMB8+r7ZVZ7VUe8MKfSGDVQPodxUMZjmXWskYJjm1dwOkSmzG35aR/S8QsPS7IenHaizsosqZo+r9Nz7IKVa/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015120; c=relaxed/simple;
	bh=bWZrmSiM6YWTx+i5vVQsu6mdes0U+efV52esmGFE7UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOiT7ot3PxmmKs3SkWDCULGMoU0zTJq6HPDmJ7EYeD1jpn9KLbOKoq4ZXGwTgw1YzhHAG1J6qJKPc2MGzxfhzyXOGq3JpMoxMGvktp7vz4aaTw5IPSsX43TFGZ6FoblopHVBb8nBvdBCTKPk8zKqWRhAr5Kn40vfmpBtbQClJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mjSpX5z/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mjSpX5z/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6488B1A298C;
	Wed, 21 Jan 2026 17:05:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39FF16070A;
	Wed, 21 Jan 2026 17:05:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1389119B1881;
	Wed, 21 Jan 2026 18:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EGJbdGn0SD0aoabG2saaXwDhMHD4aEi0DEPAXPkHNUE=;
	b=mjSpX5z/wEIGdhf70w6GO7ghYg1Rd7bJ+R/Ngq/OBCQxSSuuNibsdryr2sWg4463F6ZQy7
	rdAkjKKvS2LZ1U7d0TUhfZcyBME8w5yQYCLY8AU4kB4E7PU5mtXTkVwAC62J1aB4BG4/6V
	MZ8FdOH+uNTpOF3NoYNILsKSBeKTc4ubc1UMuvbkQmprA5NwXNe+Lxx6QjrVZ9dOnSn5ym
	oRrWP8CY3pwEbyQSqYmSlj4j4DgW2Pbg2Ems/RDAziI1raCFo997VQLcDO1v0FPWkzWeNl
	xoEe4k2AvD9+vml5GEz4gJ4TUpFaL+hiNzCtpvDXvfmi3y8TEqoCe5syfitv7A==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:04:58 +0100
Subject: [PATCH v3 02/17] spi: dt-bindings: cdns,qspi-nor: Drop label in
 example
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-2-43e70fab4444@bootlin.com>
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The label is useless here. Plus, if there are several examples with the
same label, we'll get very useless yet annoying warnings.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index b85dba351822..123caef8f61e 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -165,7 +165,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    qspi: spi@ff705000 {
+    spi@ff705000 {
         compatible = "intel,socfpga-qspi", "cdns,qspi-nor";
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.51.1

