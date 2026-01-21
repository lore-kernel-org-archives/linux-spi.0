Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9704D2EF8
	for <linux-spi@vger.kernel.org>; Wed, 21 Jan 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015128; cv=none; b=eWVH395YlZGzUjFKrIun7TzXulNC9xtvsptDUJaGelVlDykcM14TphDeVMwQWxMQrx3Ebaz4gsYzahRjiPSUdu4Ey8hX+t9ymNfLYwg00fAqILKGvr7MmZbdYSBpBEpVc5OtYncdXTLcb+2+Q087sP3Uwvo21a9z922aDjyAP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015128; c=relaxed/simple;
	bh=UBxp+mVMENkbjzOOwcVuVl5Ky0LH3WVdPATL+cPvJLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0Igya37UVW+tfTmt2Hc9UsHbPy1FbcMC63gOR93iv7CSEN8jBD9vLsQ55SFmg+zfLukNDaPnHtANov3c0K0rw7AXFN32/l2SH6OcDugxGIzGluNxLgvqat3T7+2UxB5dcfYKor9RlefeciqgwrnGImerlBDT+RSBQa4kjdKjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4IzLQLo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4IzLQLo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D36DAC21A90;
	Wed, 21 Jan 2026 17:04:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13CCF6070A;
	Wed, 21 Jan 2026 17:05:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 690C4119B189F;
	Wed, 21 Jan 2026 18:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fO0SkS9+T7rGUtUKsShIOFxIB6cpqmbBl3frX7gVrxI=;
	b=Q4IzLQLoRHUKeOoPctDHrTAobYppyWxnB7QetEmeIvYtio6xj+zlrU/VjDm+bsN/JmvITz
	z/+62aqN6iFcpEEKlH4Kh+2Clzm6fAT+svz6B4gMwEFUPDtOTZPwMCc2Dxjy8q3xvtrYtv
	L/Zaz7VIVFF0kFQJd19bk63YzQJPX9Do+vklg/2fT4ZvtQsmfr6Zkdr9HKI6Pe6PNPPRW6
	0oWWnYZnOVE2qY4pxdmXM6SOLwe51MMk/gzg6KPC1URxfbflXNrRRhkFz7DIxShjRn4rqc
	UXvB75qN7CdhBEr5aKgcWhQ09oUdpSFfSzUmJ3+IR53u/N/iczkWJkp/awqerQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:05:03 +0100
Subject: [PATCH v3 07/17] spi: cadence-qspi: Fix ORing style and alignments
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-7-43e70fab4444@bootlin.com>
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

These definitions do not follow the standard patterns. Alignments are
incoherent and the logical OR symbols '|' are misplaced. Reorganize
these definitions.

There is no functional change.

Acked-by: Pratyush Yadav <pratyush@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c0a507953c58..8eb80b4b76eb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2130,26 +2130,23 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 };
 
 static const struct cqspi_driver_platdata socfpga_qspi = {
-	.quirks = CQSPI_DISABLE_DAC_MODE
-			| CQSPI_NO_SUPPORT_WR_COMPLETION
-			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE
-			| CQSPI_DISABLE_RUNTIME_PM,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+		  CQSPI_SLOW_SRAM | CQSPI_DISABLE_STIG_MODE |
+		  CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
-			| CQSPI_DMA_SET_MASK,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
+		  CQSPI_DMA_SET_MASK,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
 static const struct cqspi_driver_platdata versal2_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
-			| CQSPI_DMA_SET_MASK
-			| CQSPI_SUPPORT_DEVICE_RESET,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
+		  CQSPI_DMA_SET_MASK | CQSPI_SUPPORT_DEVICE_RESET,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
@@ -2166,7 +2163,7 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
-			CQSPI_RD_NO_IRQ,
+		  CQSPI_RD_NO_IRQ,
 };
 
 static const struct of_device_id cqspi_dt_ids[] = {

-- 
2.51.1

