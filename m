Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203C55D86E
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992674; cv=none; b=fkyQssi0jab18/mvcOqyb7J/M3XGh92dlY2doWFau3UTsC6G1MBRZTC6Vnn+PrfchfckAx9a+rQtPkpKJLT+l6GSSJZdqnhFMWXS5qHWimnZ/WzccIB+NPCR9Cez8gmyr2Kv23P466gmkEztIKxDvYbw/SHbW+BzsNxwUeF3KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992674; c=relaxed/simple;
	bh=2GD9iQ0q0Ryk0Y1hCEDYuwqq89P1KQU2qBZF2vslX5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFfCu0PVUHaxepoAW6pQHUBq/LKiwOiYx9rqdS63pVzCe2mpPrVz6GHILJw8fbhXnTHa6GmQejAU+Eh3/tddcRnf7+Na8Dvw0RK54ceQs8O9r56upkh27a7pL6G2SPuvuFs+knEq7pfq6R3+g7BcLXaQ4iFP/pH8xDcSFRyzlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uD8v375y; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uD8v375y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3D361A1230;
	Wed, 14 Oct 2026 15:44:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92FF060368;
	Wed, 14 Oct 2026 15:44:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53AA7103289BC;
	Wed, 14 Oct 2026 17:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992664; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=O3NL8fkErfRFwG+o5fUs2LgXhRTFrJyf5hL+wJ8c3N4=;
	b=uD8v375ySJi4m+wyAhOk0tJZFCAYruYKj/FsKzKi4F7ppiPZTV5dDp6qRjlrM/GLxBpD6i
	WKvEbv4Bl4ss6zp9zIGPq72ZZJbzbP422igRxDSa5BHI695w/pY6JnUIu0IeUnonGJYPi4
	joRr4S4AilFoYNQEtxPF65hAxkI+h1OBsYyNVT8JgTL8LwwW9+b8ROQCNLHdJdIRDxbJ2E
	QoAzocpf8kphIehTu6Rm+EQ5q9pfm2DWyTruE8tptwK6c9HWJbIeqA0ucqdd3kY1HORQs4
	b3QDYZ2VSqEEgBqllA+LjKX9DPjOxSQAdzQG7+UGoS1uKg6Y/n7zVs+oU9m/wQ==
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
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 5/7] spi: cadence-xspi: Add irq-less support
Date: Wed, 14 Oct 2026 17:42:59 +0200
Message-ID: <20261014154301.157755-6-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154301.157755-1-paul.cercueil@bootlin.com>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
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

Notes:
    v2: Make sure we only enable interrupts if not using polling mode
    
    v3: No change

 drivers/spi/spi-cadence-xspi.c | 104 ++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 095bf640b379..2a2a40bf0a4c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -365,6 +365,38 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
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
+	if (readl_relaxed_poll_timeout
+	    (cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+	     ctrl_stat,
+	     (ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+	     sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+	     sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0)) {
+		return false;
+	}
+
+	/* Clear the flag */
+	writel(CDNS_XSPI_SDMA_TRIGGER,
+	       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	return true;
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -532,7 +564,8 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
 	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
 
-	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
+	if (cdns_xspi->irq >= 0)
+		cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->sdma_error = false;
 
 	memset(cmd_regs, 0, sizeof(cmd_regs));
@@ -562,16 +595,25 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
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
@@ -1052,38 +1094,6 @@ static int cdns_xspi_prepare_transfer(int cs, int dir, int len, u32 *cmd_regs)
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
-	if (readl_relaxed_poll_timeout
-	    (cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
-	     ctrl_stat,
-	     (ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
-	     sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-	     sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0)) {
-		return false;
-	}
-
-	/* Clear the flag */
-	writel(CDNS_XSPI_SDMA_TRIGGER,
-	       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
-
-	return true;
-}
-
 static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 					   struct spi_message *m)
 {
@@ -1276,15 +1286,17 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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

