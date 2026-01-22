Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1C38947D
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094866; cv=none; b=BF4RLm7ZsFqxvQRVvMxKnJNy4XOLsP/bCwytOsh1BE334XcJQio2N3VQW7pAK11iEoaxz6VykiIUfEtCuhdBsp8wKUhFMIdu1wnYxtIOuFhvDCar0k2aoscrDN22q69JiAiPUNw6O4Gqksnyz4Zwlf/MMQx9z8Tm3Q2vEAsSfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094866; c=relaxed/simple;
	bh=dFUCWl21YbgvBCq8xPVkOI7yQqSUl80HaquGBhW8og0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QM/ySUMQGupVY8XKytzifz0MyDjC044/3wg1FFW9owFeCG8I88MlpbolyiALehANflTe3PA83ZrB0vv0H5Ts2YkSrPzcz8fX/xCF2bipbXi3r7OV1/+fGbvPAiLqd1zn2a2qGNO8kpKUMc1v0fYb2TO2WNznTen9yKwHyrs0SPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O7nk/K1a; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O7nk/K1a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CAD7CC21AA6;
	Thu, 22 Jan 2026 15:14:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F152A606B6;
	Thu, 22 Jan 2026 15:14:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8485119B82CA;
	Thu, 22 Jan 2026 16:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HV3WvR0v32aL9umhOvkyMORoTk5J59HmOATBu7qOfE8=;
	b=O7nk/K1aD43An8ypmicbRKMP6V3vrpJBh0te44LpnHf+3igHOqoxCNN0dk2C5rH3nCMMFq
	UQKI3GVzYqM+gCS9uIOfXRbSQvcF+SuvUgRuLmWM89jX2dgr0FQHnoW4PeUXwiKKzQl0OS
	D3BK/UUJLn/OoYzJy0D54HdGMH2wDZ4u9ktNt5qC5q3yB5k0oP98MD7aj19qJsNG/2Lpr/
	mHCwZ8tqRl/iwJkzg+wZFyC0Q+HjNSbSAgIazvq8rExdp2YzEw+EBX/FOUWEjy44GE1D/B
	Z4M90MhnFAvzuTmPKhM+bGjrccsIhsTsrtsZm3GeMUCH7Kqcl9S6LXt3MCOugQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:38 +0100
Subject: [PATCH v4 13/15] spi: cadence-qspi: Use a default value for
 cdns,fifo-width
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-13-f9c21419a3e6@bootlin.com>
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

Bindings expect 4 to be the default value for cdns,fifo-width. Said
otherwise, if the property (which is not mandatory) is not provided, the
OS, in order to comply with the bindings, should not error out and take
4 as default value.

Comply with the bindings. This would have slighlty simplyfied my testing
if it had been implemented correctly in the first place, but in practice
it should have no impact on the existing boards using this controller, as
they all set cdns,fifo-width to 4 explicitly in their upstream DTS.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e0e4423baed9..5f3a914e45f7 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1596,10 +1596,8 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 		cqspi->fifo_depth = 0;
 	}
 
-	if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_width)) {
-		dev_err(dev, "couldn't determine fifo-width\n");
-		return -ENXIO;
-	}
+	if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_width))
+		cqspi->fifo_width = 4;
 
 	if (of_property_read_u32(np, "cdns,trigger-address",
 				 &cqspi->trigger_address)) {

-- 
2.51.1

