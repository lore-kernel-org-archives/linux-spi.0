Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E123822AD
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650398; cv=none; b=I58hx+apfoXE/eW1NGUOjVqzVMKYkP+xt+PN2rNEzK/j+8Gma6wDYCQNh7uBEhl6ahgmZp8lWwgs+uBCT2YDevW5lHJ5fFhHzU7uomHeYyU6l9p8viEvs0R3BfPMnvi4TuMkSq970T8WScmtDA3ebXN4pHuA10/O4PM0gYvODIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650398; c=relaxed/simple;
	bh=67IqHHUgq2tLs1hEake5YuaFz+dRmTGCUQrSSZoEZbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6IaqsUjr02Y3bKeVAIJTwml7Vms64mSl2gW52+qNc9QlHzR/ToITCEKbjjmmbVeCE0XicjyIRoAmX6Ez2z/D8Omusi1hNGt+OxG3IDfQZEzhrkOAcVtdSFprFTwDHSzvMzm7LxuFBpp0eofV/B83vUmdIN5zvkuFag9CZrHnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Rw-24; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVF-2Z;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 71CFC5049BF;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:03 +0100
Subject: [PATCH spi-next 02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe(): use
 FIELD_GET to decode Parameter register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-2-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=67IqHHUgq2tLs1hEake5YuaFz+dRmTGCUQrSSZoEZbM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfnCfufxBPacPU91eVu/7Irz21oPJM7J5b4hmv/9yw
 ChP8PPpvx2lLAxiXAyyYoosS3+cUBQIdCjtfZkwCWYOKxPIEAYuTgGYyNZWhv8xKV1G/w4xzvsZ
 U6FWa2EfcH4Xh6sK8+XNNZEd5Xk1XrsZGTZHChzNMQo9HbxMyiUjbus9Q4WED9MdeMLlNctnPVz
 mzAAA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Instead of open coding mask and shift operations and to o increase
readability use FIELD_GET() to decode the Parameter register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 989d0ffddc25..4c550f740d85 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -55,6 +55,9 @@
 #define IMX7ULP_RDR	0x74
 
 /* General control register field define */
+#define PARAM_PCSNUM	GENMASK(23, 16)
+#define PARAM_RXFIFO	GENMASK(15, 8)
+#define PARAM_TXFIFO	GENMASK(7, 0)
 #define CR_RRF		BIT(9)
 #define CR_RTF		BIT(8)
 #define CR_RST		BIT(1)
@@ -978,12 +981,12 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
-	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+	fsl_lpspi->txfifosize = 1 << FIELD_GET(PARAM_TXFIFO, temp);
+	fsl_lpspi->rxfifosize = 1 << FIELD_GET(PARAM_RXFIFO, temp);
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
 				 &num_cs)) {
 		if (devtype_data->query_hw_for_num_cs)
-			num_cs = ((temp >> 16) & 0xf);
+			num_cs = FIELD_GET(PARAM_PCSNUM, temp);
 		else
 			num_cs = 1;
 	}

-- 
2.51.0

