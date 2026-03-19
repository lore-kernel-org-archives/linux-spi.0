Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956E3F0756
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939374; cv=none; b=PIfJi1S4HjnZnSc5brzICteVj+NMaJrB6Bgnu1lXrBtQHIKIXP60kl93J6UhVm8EnXCNLpp8KkGcSXBcmzcceas1YfyMG+XRoizt610TvwOx4dyQqTzWMfDMdxwKvb9AHvfDo7xdT60Jrlz4tIrm3J8LxFnzCrBxncaFnQKDeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939374; c=relaxed/simple;
	bh=PkC2yo5BI1aEo+Xf+NS4EiYcu8oB75ML9kN9GINNcjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shZ1HX8PROQ7VZx8mONwHUpj50P+tSNl/uBePrXLo0D0J9YvWPz8Knho6sK5LIy8HLEAMfOzK5rs026M+ZP9F8kvDhNZMiWqHGCzy6kWqVje5mDdqASVQxr2yMc6H3AVAwotz7VinU6POSwKgW0dbU8yCXGTbKzD/0Lkg+6ZzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054B-Kn; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iF-0Y;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A26A750877F;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:37 +0100
Subject: [PATCH spi-next v2 03/11] spi: spi-fsl-lpspi: fsl_lpspi_probe():
 use FIELD_GET to decode Parameter register and add size check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-3-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PkC2yo5BI1aEo+Xf+NS4EiYcu8oB75ML9kN9GINNcjo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9Vzq8Zo38MPH12+b+C2rssI2VFdKZ6R6ybrZ7R4r
 bT3JIkdHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIwRiGP1wzY4SNLlbPe+Sl
 cHLpRKbEr0lb1S2XZmpfaKnpf/BAayMjw6brS/YfmnNYvNonIS61/BPj1n6Bc4/r5z7JkmP4obj
 Ugh0A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

According to the i.MX93 datasheet both FIFO order fields are 8 bits wide.
Widen the PARAM_RXFIFO and PARAM_TXFIFO according to the datasheet.

A 8 bit wide FIFO order field can result in a max FIFO size of 2^255,
sanity check and limit the FIFO order against the width of the watermark
field.

Instead of open coding mask and shift operations and to increase
readability use FIELD_GET() to decode the Parameter register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index fdd14caf6659..75f4e0e9acee 100644
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
@@ -77,6 +80,8 @@
 #define CFGR1_HOST	BIT(0)
 #define FCR_RXWATER	GENMASK(18, 16)
 #define FCR_TXWATER	GENMASK(2, 0)
+#define RXFIFO_ORDER_MAX	(ilog2(FIELD_MAX(FCR_RXWATER) + 1))
+#define TXFIFO_ORDER_MAX	(ilog2(FIELD_MAX(FCR_TXWATER) + 1))
 #define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
@@ -906,6 +911,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
 	struct resource *res;
+	unsigned int txfifo_order, rxfifo_order;
 	int ret, irq;
 	u32 num_cs;
 	u32 temp;
@@ -981,12 +987,22 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
-	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+	txfifo_order = FIELD_GET(PARAM_TXFIFO, temp);
+	rxfifo_order = FIELD_GET(PARAM_RXFIFO, temp);
+	if (txfifo_order > TXFIFO_ORDER_MAX || rxfifo_order > RXFIFO_ORDER_MAX) {
+		dev_info(fsl_lpspi->dev,
+			 "TX-FIFO order (%u) or RX-FIFO order (%u) too high, limiting to %u\n",
+			 txfifo_order, rxfifo_order, TXFIFO_ORDER_MAX);
+
+		txfifo_order = min(TXFIFO_ORDER_MAX, txfifo_order);
+		rxfifo_order = min(RXFIFO_ORDER_MAX, rxfifo_order);
+	}
+	fsl_lpspi->txfifosize = 1 << txfifo_order;
+	fsl_lpspi->rxfifosize = 1 << rxfifo_order;
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
 				 &num_cs)) {
 		if (devtype_data->query_hw_for_num_cs)
-			num_cs = ((temp >> 16) & 0xf);
+			num_cs = FIELD_GET(PARAM_PCSNUM, temp);
 		else
 			num_cs = 1;
 	}

-- 
2.53.0

