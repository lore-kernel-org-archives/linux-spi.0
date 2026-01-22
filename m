Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB237FF65
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094850; cv=none; b=rr/wX049WEkJwBWc5z/KX6qzU4Grq/iO9xje+xT5glyrQYgkD8z0vX+jDvjc86kstQo3guYPYGOmLECh416Z8hsjLv3ppjTlUQsKz1Wlw8npJu8RaDRFlHOiEAr6fsvysbnQMYGJEal54QvX5Xb6KKekDwCFZYvXTXK15RYJTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094850; c=relaxed/simple;
	bh=559NB4IOTgnH1uJ0ZdWt70Ud/UBZ6oL2OyETCCjV31k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8/K3c4Xvg1zRvFus10EMEZK1fUAWjdV8ewUFuu7yM0dnZbNfv6p5cv4mLrbYgY2grBAXO0L5vE2S32MmLmUsoZdegNJgmE7vrJr9zVDUsPgrjFN/mYr11GELtHHxA/wAvnpM19hdAaUuZ3/35ygqED2poBOQ5s/eOThR34sUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0QcqZ5dz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0QcqZ5dz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7CFDAC21AA7;
	Thu, 22 Jan 2026 15:14:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4618606B6;
	Thu, 22 Jan 2026 15:14:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8383A119B82E5;
	Thu, 22 Jan 2026 16:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=viq42YFuPmM9zMZsx8Z+unGAElfNEyain450dehUnTs=;
	b=0QcqZ5dzFfmF7ICkXT82ncgUK2pIMkgCwKNtDkyyUYnFOO2gKRT7FnKVuD/709su5t864O
	Afy6xjF2ir3bayda8dtgy1D7k+H0dQ4RPXL1tGSSehBZJ+tOASDO4Aks/+cn8ZLuZeqfGa
	Z7yZ6pPiNAag+oy5xHT5HSnNAlL3opJhNyYUKMFGct+Vhokybkts/mGCpaPzO6Lkk8E2zH
	ZEPZiwTSnaS3T5rTtiyFpw60FKGpkTFwPApS0XpMX1VDohQkQ8wTBo3oDzq/gMAqQ0YIPU
	Sy1YSABsRh/00Swp08GyAdnp+/PagqpkYx+iUHxpSUDeCrqYed+x/xOgCoZyiA==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:31 +0100
Subject: [PATCH v4 06/15] spi: cadence-qspi: Remove an useless operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-6-f9c21419a3e6@bootlin.com>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
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

Right above writing the register value back based on 'div' value, there
is the following check:

    if (div > CQSPI_REG_CONFIG_BAUD_MASK)
            div = CQSPI_REG_CONFIG_BAUD_MASK;

which means div does not need to be AND'ed against the bitfield mask.

Remove this redundant operation.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8eb80b4b76eb..06f6c5979229 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1258,7 +1258,7 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
 	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
-	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
+	reg |= div << CQSPI_REG_CONFIG_BAUD_LSB;
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 

-- 
2.51.1

