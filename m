Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD19382290
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=BIOmAVD11XR+bw3AOOVjZyGqbpCj9lzpmR1DANSJqNd29cFjERoYAJm+XT3I6X1E//VHk46mMYhlt9INoz+rF/IoPLJ/MTIkUTDnibXLIx8XONH0vYyJNMfL+RdJ6gk/EPk92lRu6rjvLQUhN0CDdC6ydGCme92eTNt9Q3mRs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=MK4eF3o6uDhZXPb+u+HVrV4eAVAALjASvbFdaQvBpE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIqFJzbQUcrOHAEr9N7YtCYKc4uVsG+MtkqWRTGqcsg0nAT/ZXgV5rgQkm3PlYhouXNbAju8W8C1vXYxn4CBRqAIwGVrr2kvNc0LIUUHDbajdRg2lxd66oSNFMFZqK0e42b7Jw2P47xzMIutmw+0GLC4qJcOQ3OcXBhlsg2S7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Rx-5B; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVG-2j;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7D7415049C0;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:04 +0100
Subject: [PATCH spi-next 03/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 use FIELD_PREP to encode Transmit Command register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-3-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=MK4eF3o6uDhZXPb+u+HVrV4eAVAALjASvbFdaQvBpE4=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfnD/EY2bVQ52c+988Hfm578gvKL/bNEKTZUbzmXLH
 d531iqt6ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEot0Z/ooZ8J7Zw3H+8+r3
 9gp/hddyMd4U86088m4Ht1hLyfnpjTwM/z3bhJzbvmTVT61gZJpVr7JQu4uh4OBa2SRHi8X5Hi8
 beAA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Instead of open coding mask and shift operations and to increase
readability use FIELD_GET() to decode the Transmit Command register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4c550f740d85..e75b9acaa9e5 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -82,10 +82,14 @@
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
+#define TCR_MODE	GENMASK(31, 30)
+#define TCR_PRESCALE	GENMASK(29, 27)
+#define TCR_PCS		GENMASK(25, 24)
 #define TCR_CONT	BIT(21)
 #define TCR_CONTC	BIT(20)
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
+#define TCR_FRAMESZ	GENMASK(11, 0)
 
 #define SR_CLEAR_MASK	GENMASK(13, 8)
 
@@ -290,11 +294,11 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 {
 	u32 temp = 0;
 
-	temp |= fsl_lpspi->config.bpw - 1;
-	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
-	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
+	temp |= FIELD_PREP(TCR_FRAMESZ, fsl_lpspi->config.bpw - 1);
+	temp |= FIELD_PREP(TCR_MODE, fsl_lpspi->config.mode);
+	temp |= FIELD_PREP(TCR_PCS, fsl_lpspi->config.chip_select);
 	if (!fsl_lpspi->is_target) {
-		temp |= fsl_lpspi->config.prescale << 27;
+		temp |= FIELD_PREP(TCR_PRESCALE, fsl_lpspi->config.prescale);
 		/*
 		 * Set TCR_CONT will keep SS asserted after current transfer.
 		 * For the first transfer, clear TCR_CONTC to assert SS.

-- 
2.51.0

