Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6737F8DD;
	Mon,  5 Oct 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187958; cv=none; b=cq+kafHg2OTPtV4qbW+TaP6YWtuCSWB3hmtuK5tW/9NOMXQmF7HRSQ5D0j3/pfAdPr0+xLT1fetja5CKe3q9segIJsjBt5OZozF6UJXqACZSmqI3xUXIZsvrN+QfUnCid60JEHs5wQ9xv0uyCwmLjk4950OT7BKZNGqB1v4saPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187958; c=relaxed/simple;
	bh=bGoWWB1m4GLd76G/zJ/i0N//Nq17g8U/eKchH+Mk7LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I66hRvAe0cWZorixy1IWJnxL9sHm3RpOusJ601ER0nTmCXWMrJoceqmi26/nru8OsisCaRE1vGTNCd6f1HvYv3h785G34wYsSXa+LSNFrhc9mdBxSNRO+5X6DPtgNaYPNoeQGdx1cEmK4sN87N6JB6iiavnKJVxluFXRPGkoLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HGEizBrE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HGEizBrE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5E89B1A10DE;
	Mon,  5 Oct 2026 08:12:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 330CF604FE;
	Mon,  5 Oct 2026 08:12:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C26941033035E;
	Mon,  5 Oct 2026 10:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791187954; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sm8NrG3331Q3i20n1AV/qj3RZO+XGxtCkeWuoL9e0SA=;
	b=HGEizBrEZBr9NY/XsdxTWsC8ldpGn0/P2qPpP18O0QCrxFmEo7Qh3Ve9vuSxREuB9kF1X9
	GeKDRZ5lHq3UHEZNd0jyzzgc/JSEFwo1bMdJ57u5nzXDuum5+g5awHO8rkU0gKLPOetpLY
	kxGwnQNN08mcfFCwawN/R0QD2GdZZh3cLGyXxAzkhuAZt0rKbHAQQcf02XTNL29fQTg8iT
	RNbyE8NaEjE7EYB6WkYzAc9TfE54DxvXECWpnI7TjGTWNkVvFzZv/i3tTdgfZVlY8qpfOj
	f7SoDCkMFN3GVpbZHEtjxnLwOhLJoUetk706164AY6DbfBQcyrBgHUI9XhkZxQ==
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
Subject: [PATCH 5/5] spi: cadence-xspi: Add support for panic writes
Date: Mon,  5 Oct 2026 10:11:40 +0200
Message-ID: <20261005081141.33688-6-paul.cercueil@bootlin.com>
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

Advertise support for panic writes. When a memory op is received with
the 'panic' flag set, the driver will then work without relying on
interrupts and without sleeping.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/spi/spi-cadence-xspi.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 09ed2afbd4af..0b7162740940 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -350,10 +350,11 @@ struct cdns_xspi_dev {
 	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool enabled);
 
 	bool xfer_in_progress;
+	bool panic_write;
 	int current_xfer_qword;
 };
 
-static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi, bool sleep)
 {
 	u32 ctrl_stat;
 
@@ -362,7 +363,7 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  ctrl_stat,
 					  ((ctrl_stat &
 					    CDNS_XSPI_CTRL_BUSY) == 0),
-					  100, 1000);
+					  sleep ? 100 : 0, 1000);
 }
 
 static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
@@ -549,7 +550,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	int ret;
 	int dummybytes = op->dummy.nbytes;
 
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi, !op->panic_write);
 	if (ret < 0)
 		return -EIO;
 
@@ -586,23 +587,23 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
-		if (cdns_xspi->irq >= 0) {
+		if (cdns_xspi->irq >= 0 && !op->panic_write) {
 			wait_for_completion(&cdns_xspi->sdma_complete);
 			if (cdns_xspi->sdma_error) {
 				cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 				return -EIO;
 			}
-		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, true)) {
+		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, !op->panic_write)) {
 			return -EIO;
 		}
 
 		cdns_xspi->sdma_handler(cdns_xspi);
 	}
 
-	if (cdns_xspi->irq >= 0) {
+	if (cdns_xspi->irq >= 0 && !op->panic_write) {
 		wait_for_completion(&cdns_xspi->cmd_complete);
 		cdns_xspi->set_interrupts_handler(cdns_xspi, false);
-	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, true)) {
+	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, !op->panic_write)) {
 		return -EIO;
 	}
 
@@ -622,6 +623,8 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	cdns_xspi->panic_write = op->panic_write;
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -831,9 +834,11 @@ static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 dll_lock;
 
+	/* Busy-wait in case we wake up the PHY from suspend to do a panic write */
 	return !readl_relaxed_poll_timeout(cdns_xspi->iobase +
 		CDNS_XSPI_INTR_STATUS_REG,
-		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
+		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1),
+		cdns_xspi->panic_write ? 0 : 10, 10000);
 }
 
 /* Static configuration of PHY */
@@ -1186,6 +1191,10 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 }
 #endif
 
+static const struct spi_controller_mem_caps cdns_xspi_mem_caps = {
+	.panic_write = true,
+};
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1306,6 +1315,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 
 	host->num_chipselect = 1 << cdns_xspi->hw_num_banks;
+	host->mem_caps = &cdns_xspi_mem_caps;
 
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
-- 
2.47.3

