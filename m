Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3B20FAAB
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=KBDuhmx8C2wxnz0U26OzEZtbMqBagv4EvTPoMCAYqCBPFcF9VCb5KPPMBNYjMK6Y4Czg0hAXUx/6BDxeFY++7/HICjgNzRMOJNB1eZ6O93VSVar/vhuoc0RXPsrPBKAIvkZ7ZSBVE+wm/Bbt2PVz6fTHv+1RbXE77jJmV4Qm09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=VYbNxLcS6kp4nY2TuLaEWedCLs2o9gH+xxnacqzQzyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txeyqyfRD2wpoun6a1VsZp1JAuF0x2ubU2kAtoLAWRPphLY2O14sPADyFOqUINh57ZhFrey0den1aiwA2wN03xfIexcHBnWJKjqhsb54V/sylsUNR+TxnZXFuF7f50G0C/2AaNR+miB0+JnDonWqoDwvnl8st9kX8boEXuPXXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Ry-5I; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVJ-2x;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 866985049C1;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:05 +0100
Subject: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=VYbNxLcS6kp4nY2TuLaEWedCLs2o9gH+xxnacqzQzyc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvBAwd6ZOl/CX0/ZH/rT918gl8zCzX/9st6Uneb+Y
 3tv93MV245SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMRP8Hw/+YlH/m9XLMc6+9
 8zo3sdZe811WOafn4e9hAue+yX1MyJnD8L92RnHI3Zo/mZNCW39b3Tqb/O9igp6H+EXepZ+bpC/
 a/GIGAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Instead of open coding mask and shift operations and to increase
readability use FIELD_PREP() to encode the FIFO Status register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e75b9acaa9e5..139d6573a013 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -78,6 +78,8 @@
 #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
+#define FCR_RXWATER	GENMASK(18, 16)
+#define FCR_TXWATER	GENMASK(2, 0)
 #define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
@@ -326,17 +328,18 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 
 static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 {
+	u8 watermark = fsl_lpspi->watermark >> 1;
 	u32 temp;
 
 	if (!fsl_lpspi->usedma)
-		temp = fsl_lpspi->watermark >> 1 |
-		       (fsl_lpspi->watermark >> 1) << 16;
+		temp = FIELD_PREP(FCR_TXWATER, watermark) |
+			FIELD_PREP(FCR_RXWATER, watermark);
 	else
-		temp = fsl_lpspi->watermark >> 1;
+		temp = FIELD_PREP(FCR_TXWATER, watermark);
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
 
-	dev_dbg(fsl_lpspi->dev, "FCR=0x%x\n", temp);
+	dev_dbg(fsl_lpspi->dev, "FCR=0x%08x\n", temp);
 }
 
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)

-- 
2.51.0

