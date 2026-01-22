Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472A36C0C7;
	Thu, 22 Jan 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094843; cv=none; b=qqtqISDMvlVcNmUGsexic0K/sNXAu3fRlucEHc0mWXPofditCz44bIOw/LJT/LTPtHDbRDSEKsLIy/DvwI6iXGnksFR0biZx+aQcluyWAOjMXwKQPPJfZ7mOa7BY9bhd8cYz5o8fGNfydCXYGVpm//dUCRaqsBPiMS1UMPcLjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094843; c=relaxed/simple;
	bh=hVZFluRZ9aIsCPx5D6aaUpTyU1txgrMGDGVXFg02iu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CO2aEyGeLa2jdcm31ntIL7VtTdM0Scgr+sB69OqNl+4oz94fV9iFloxLKio0FyFwjkejaYx3yQr4qFhI+tWykztbW7T2FU6NC9nPOo0qpgg6Z2S68AOu2mnAQB/uFO10tFsgIZhrUXGSwmA5wMoUhXMLO25M3wsdyqyNi8Am/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hn29qmpa; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hn29qmpa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 32ABD1A2A60;
	Thu, 22 Jan 2026 15:14:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09000606B6;
	Thu, 22 Jan 2026 15:14:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 243B5119B82CA;
	Thu, 22 Jan 2026 16:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kXE2QNu4DkvbYU2g9MAcoHt1LXhYlHoQoJg0JPWeVww=;
	b=Hn29qmpa+xU4Qihj652rJWpMPl9+i9vQjgtAd80xBcwOoE2jDNzsuhhW+aHex/K+YUkG/I
	acP9qkin/bw5bA69IFg71F1rt7lkjmvQTe1OHJ01ExtWU+f2C1cdxS3sMEZPaoULIVr3uU
	nsaB+iPn6Pmmr+5KHOW9PP5OgJMesfH6X/qfEqfbtugxaH6rhjZAwpUDsMkcEMztpU3CaD
	b/PgjMrZIznXbat0+ypBD4zImmRuLn8fRgOO8iaq8yfx8/dAWjzH9pLAvvtOoRZz2QT5u5
	/zbjx40e8cx0oTngJ18aBzVaQWftmUFSNIA3+KGjpyc7vT0xbdR5EGjWx74BBw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:28 +0100
Subject: [PATCH v4 03/15] spi: cadence-qspi: Align definitions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-3-f9c21419a3e6@bootlin.com>
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

Fix alignment on the #defines.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b1cf182d6566..cc28da7fc686 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -40,7 +40,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM		BIT(4)
+#define CQSPI_SLOW_SRAM			BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
 #define CQSPI_DMA_SET_MASK		BIT(7)

-- 
2.51.1

