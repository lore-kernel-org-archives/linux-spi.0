Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BED37F326;
	Mon,  5 Oct 2026 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187953; cv=none; b=plxbf+OMylxB9Ka9Z8Osq4anU/lMZzqz60b3C3J2x87SEjsHmpSXpIRh2/Yp3u4X7BFaxulCoq9kYtcveIvk0bOnvitrNgOJ8DH0R4O2mk4P/mPxIsmhRQSKZ3vTpweOWsQsct1HL4YDWcvr5giQUoXPkclt2a3Ls5Piuve/FWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187953; c=relaxed/simple;
	bh=Jdmp5DqLNT7SBaPqEFhEwnF/DhdyEm5BpztSCVHvnVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLFSHwH/jvjtEXlH+sgfyYayne4L4/u2m3SswjbMpTcQsADymzGfJ1OZLlRB0OWj54mOdhnVqCHC+Dw/l/yYtqTGZiS2+9G1PRYh+xyzc3tLs5ubm1LLfyD8Or045PoLA+n6Wv6xCv0bK3RvGxSOtJn/E42ouv1KDsng4+NuKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lqstMYD9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lqstMYD9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E1B6C4E41190;
	Mon,  5 Oct 2026 08:12:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6EFA604FE;
	Mon,  5 Oct 2026 08:12:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0451103306F7;
	Mon,  5 Oct 2026 10:12:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791187948; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=U6QL65H8I16JQp4vzHrSCIrRwP4W1C0oM5+bneLh3Z4=;
	b=lqstMYD92u7sl4Xh+jVAF3OoD/iMp18+ubKQH8zw2DQ4+jsgtPHC4d77I0BCAXc60RVX9d
	4/LdXmwUpwYIHUYP3U+pFE2LxzdjOdDdvgPRdPY8wNUtMLLuXQ9pziSrlgldcZP9p0HLvt
	hQtlBQGlVMD4a1Uujfj+Bj7cfPBjVFn6eyfRz295QduhsCbqzTOsL9f26uxkHPxNsqFFDO
	7gBRbupdhItSxQowO1N7/xg8DcAs+PYqPxtRPwKTY8qwHlvUe9MqhYdTXypf5hWxEYgTzD
	Xy7MSWHqmHKiDXW5SXbpgImT9QhF7aTwqeTlkD0UF//l0ufCZuJLlPhWcsmm3g==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 3/5] spi: cadence-xspi: Add irq-less support
Date: Mon,  5 Oct 2026 10:11:38 +0200
Message-ID: <20261005081141.33688-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005081141.33688-1-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

Make the interrupt line optional. If not provided, the driver will
instead resort to polling registers.

This can be useful in itself, but will be used later to support write on
kernel panic.

Note the cdns_xspi_is_{sdma,stig}_ready() seem to have moved for no
reason; they were actually moved out of a conditional compilation block
(#ifdef CONFIG_64BIT), as they are needed in conf-independent paths now.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/spi/spi-cadence-xspi.c | 85 +++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 39c868a5b171..7cf52bcb05df 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -365,6 +365,30 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat,
+		((ctrl_stat & BIT(3)) == 0),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+		ctrl_stat,
+		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -562,16 +586,25 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
-		wait_for_completion(&cdns_xspi->sdma_complete);
-		if (cdns_xspi->sdma_error) {
-			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+		if (cdns_xspi->irq >= 0) {
+			wait_for_completion(&cdns_xspi->sdma_complete);
+			if (cdns_xspi->sdma_error) {
+				cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+				return -EIO;
+			}
+		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, true)) {
 			return -EIO;
 		}
+
 		cdns_xspi->sdma_handler(cdns_xspi);
 	}
 
-	wait_for_completion(&cdns_xspi->cmd_complete);
-	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+	if (cdns_xspi->irq >= 0) {
+		wait_for_completion(&cdns_xspi->cmd_complete);
+		cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, true)) {
+		return -EIO;
+	}
 
 	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
 	if (cmd_status)
@@ -1052,30 +1085,6 @@ static int cdns_xspi_prepare_transfer(int cs, int dir, int len, u32 *cmd_regs)
 	return 0;
 }
 
-static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
-{
-	u32 ctrl_stat;
-
-	return !readl_relaxed_poll_timeout
-		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
-		ctrl_stat,
-		((ctrl_stat & BIT(3)) == 0),
-		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
-}
-
-static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
-{
-	u32 ctrl_stat;
-
-	return !readl_relaxed_poll_timeout
-		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
-		ctrl_stat,
-		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
-		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
-}
-
 static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 					   struct spi_message *m)
 {
@@ -1268,15 +1277,17 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 #endif
 
-	cdns_xspi->irq = platform_get_irq(pdev, 0);
-	if (cdns_xspi->irq < 0)
-		return -ENXIO;
+	cdns_xspi->irq = platform_get_irq_optional(pdev, 0);
+	if (cdns_xspi->irq < 0 && cdns_xspi->irq != -ENXIO)
+		return cdns_xspi->irq;
 
-	ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
-			       IRQF_SHARED, pdev->name, cdns_xspi);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
-		return ret;
+	if (cdns_xspi->irq >= 0) {
+		ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
+				       IRQF_SHARED, pdev->name, cdns_xspi);
+		if (ret) {
+			dev_err(dev, "Failed to request IRQ: %d\n", cdns_xspi->irq);
+			return ret;
+		}
 	}
 
 #ifdef CONFIG_64BIT
-- 
2.47.3

