Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176001;
	b=l0DePKHGCZoUaYurGFhK3Mjuj1v3REAzbJNiwME+Mk6mTLxpji6xycNt/0PHhp/CfLXI
	 8quX96vtTiAUyBnm4RVVIrk/5JrcT7dzGXeijt138EUfJYFu6ZzhrKfZUxrScnIjM0jFo
	 QjMJm+dxyMtLFmkIaLlDD0khnRkePnVDnwomTk+itY1pSPIEXdWpK0ryWgGretd/4Ziud
	 DKyNua6mrEJxXOw4KZRP1Pp4sWMyeF2Kpdn4+U/mu+DNpC/rNHofMsp0oHQ5M8F2NUBD+
	 3g7F4W4FRQWJuRgH88NQTS7GyWGItjxJqH3/P54AZHjE7vnaWQvSmfKul5n9fYrkngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176001;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=dFIJuOZdH76Nf92N5ng2aEbsEPZBdjWSWwqT1A+7fcE=;
	b=qXXMUt2tFZ7U9rL+MysuMbiKeKzKLqrfhLb+a5da+u7orMaqLqlsKBSDzj9NgdJCu81e
	 jNjuVyFXWqQ54Kp2xCK9mn71PtufFYzEkqvXxWXXfG+Kg30zP+gw1eEQIF+4QcXd/SbQU
	 VtGiznqlzNjnfGU6zdxiV672GTYbFS8WeRmQcrcrOUuiVexrupbuFOQ4tXvnPLh9JX/O4
	 K+PrNw5ND+Cgki+TlaBeWKSQPvHm1jkGrVLCTguS7p/7nNjqL+lit9Cg4okJSqo1K3SI+
	 GOMf1+qMpuLZY9er/mHrKfbjQts/rzjHD2Xe/Ge4gM84aPq3eAgF8WGKfb7NlsNksuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bZlWtuF4;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F513606A332;
	Fri, 20 Nov 2026 12:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F513606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bZlWtuF4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 459974E4162B;
	Fri, 20 Nov 2026 11:59:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A9EB6017D;
	Fri, 20 Nov 2026 11:59:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 629CA11BC0070;
	Fri, 20 Nov 2026 12:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795175994; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dFIJuOZdH76Nf92N5ng2aEbsEPZBdjWSWwqT1A+7fcE=;
	b=bZlWtuF4J7oG5YdHA9510oIA3Aipaoy/XkbcbXNI62KBmIckOD4xSR52SRBONhnfqYCEXs
	n2/jP8Uq+N0syb/oKh0v2pb7Ge6YQrbe4y9+3ldydNf5D4bCRQyXvPeJ5nN/CSiCaCxs/Y
	ALYFf5n8ZMXJr6g8Cb/lsxH6y7ukfy2OVg1iIGkR8kY4vZ3/HcDkzaDbWQx7gXHttyGHKz
	RRL7y2CHjVw5eUavsW/DQv2AvK4JSk63cfBV7Ztjpba4JS88ih81jocg6B7MdJIj9xphyd
	uvdB8bSt4zXQAG7jfpRdp/GTPtsNIUA5nMkWDOsYcZeB8BawXArRZJvilxGKbg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
Date: Fri, 20 Nov 2026 12:59:20 +0100
Message-ID: <20261120115925.173568-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120115925.173568-1-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The .transfer_one_message() function uses the STIG mode, therefore the
xSPI needs to be configured to STIG mode before starting any transfer.

Without this, .transfer_one_message() simply won't work, at least on the
CN10K SoC.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: Adapt the code slightly to work on top of [1/6]

v3-v5: No change
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index e2d5d464bd30..48a6db290408 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -491,6 +491,20 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static int cdns_xspi_set_stig_mode(struct cdns_xspi_dev *cdns_xspi)
+{
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	return 0;
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -665,12 +679,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	int ret;
 	int dummybytes = op->dummy.nbytes;
 
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
-	if (ret < 0)
-		return -EIO;
-
-	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
-	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		return ret;
 
 	reinit_completion(&cdns_xspi->cmd_complete);
 	reinit_completion(&cdns_xspi->sdma_complete);
@@ -1243,7 +1254,13 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
-	int ret = -EIO;
+	int ret;
+
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		goto out;
+
+	ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
-- 
2.47.3

