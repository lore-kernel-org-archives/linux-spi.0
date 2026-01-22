Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843793C23AC;
	Thu, 22 Jan 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098178; cv=none; b=he2AIIsjkMuF5atfhZhBFgtn6+prOsqU+vMpNh/XIPFgWdz2VKqd8IO7i6laluabi10o2NMTcNHbx45udf480uMp0JXnzhwa0JeVMtYRBvGDaALGjh/s+twTHhha30ed/uUB7f0+qnZNhzvTYpYelIfbvdlVeU3xCObTxWTAtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098178; c=relaxed/simple;
	bh=yH4W2h85AQfCKkKFk3jnF/6o/7JzF13wFKNIpnZ9+qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/IK8sIZjNbov596pnvz1O7P58m4asBvTLm9uP7OLAKZWpikzvSNkwOrQ1uL3fbCq4Ngs1H5tkDEC9OXTJDl0bSRdfk+2fBUqyMgGmqx7uEakleVUiyLy/h6mwSrIfIL8JRr6Gg+wU7hMwNekLynGxrxysGo/fkiD9rZce9H+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tatt81Og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tatt81Og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A29C116C6;
	Thu, 22 Jan 2026 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098177;
	bh=yH4W2h85AQfCKkKFk3jnF/6o/7JzF13wFKNIpnZ9+qQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tatt81OggSai5WUQUPvRodd+lDCzGAJtTtmBjEVvXkgXN1fhYq/Cbw+f6eE/7KLyg
	 sgLYcChwL7zs14Hshd9nlogVF8i8CfsfMekhE2Ymv4v0H1C+yF04qq439A1cRtpMsZ
	 qr48ksV0o+e1SE6b8RO2SYhCd8NZQRxvZsWD/cwV9ub65Rb1NaJv5GuYIVhA0gh7TP
	 Uxa69TO65fBZFgrWrX0guCnsIWtLa7DWwNnoFNFIM7Fh0i1MyTG23YjJKtdch9vLDX
	 k/+btm/JINkGuv38IRwtZFVmxxD35WsaMvrH/v2gjXsg5SCs2sgnAGqLqdDmAk5/pt
	 MMs5z28Q6G4QQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: cadence-xspi: support suspend/resume
Date: Thu, 22 Jan 2026 23:51:19 +0800
Message-ID: <20260122155119.12865-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system wide suspend and resume support, the suspend hook
implementation is straightforward, just call spi_controller_suspend()
While the resume hook implementation is a bit complex, we need to redo
something which is done during probe, such as enable the interrupts,
setup clk and config the phy for mrvl hw overlay.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 72384d90d113..895b4b3276a5 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -350,6 +350,7 @@ static const int cdns_mrvl_xspi_clk_div_list[] = {
 
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
+	struct spi_controller *host;
 	struct device *dev;
 
 	void __iomem *iobase;
@@ -1159,9 +1160,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 	host->bus_num = -1;
 
-	platform_set_drvdata(pdev, host);
+	platform_set_drvdata(pdev, cdns_xspi);
 
 	cdns_xspi->pdev = pdev;
+	cdns_xspi->host = host;
 	cdns_xspi->dev = &pdev->dev;
 	cdns_xspi->cur_cs = 0;
 
@@ -1250,6 +1252,30 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cdns_xspi_suspend(struct device *dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(cdns_xspi->host);
+}
+
+static int cdns_xspi_resume(struct device *dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = dev_get_drvdata(dev);
+
+	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
+		cdns_xspi_configure_phy(cdns_xspi);
+	}
+
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+
+	return spi_controller_resume(cdns_xspi->host);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cdns_xspi_pm_ops,
+				cdns_xspi_suspend, cdns_xspi_resume);
+
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
@@ -1268,6 +1294,7 @@ static struct platform_driver cdns_xspi_platform_driver = {
 	.driver = {
 		.name = CDNS_XSPI_NAME,
 		.of_match_table = cdns_xspi_of_match,
+		.pm = pm_sleep_ptr(&cdns_xspi_pm_ops),
 	},
 };
 
-- 
2.51.0

