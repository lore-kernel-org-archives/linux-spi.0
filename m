Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6540EB81;
	Mon,  3 Aug 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767225; cv=none; b=jWKOrRwymPOVHd9z+fM0YdQrloWYnidl4d8RRVbVvGFscdxiZ8BVl8qYoCPTi3CVZqK7A/KZKV0RAC7BvMoC+O6BEqVnKo3TPXRXvPXqhVD7RQDZcuMPJJEDRKUmm7W46YOSWtlS6ohdJYRhohd+64UM5DWUrMsntFGX8xQ9WNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767225; c=relaxed/simple;
	bh=zmozbLU9vs783oHkMqBPJmyCBekvkPbhBI7ZT3KWNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9B5eDUKX18z4N5M27Pqnsc/vspHXWyfVfeatNcocm0B2GzvWRzml4qRVFrkJizXqhbGJ2knQTo8Y7jGIq5PjlDL9CkC9kbWqKccw/XctGT9XJRYI0iybvkiwNAVBaUeEeSeuS5gpmbCYtkJqwaIFf0BQBYiLsrHgxXxFPCKVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdUY7Tj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdUY7Tj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6857F1F000E9;
	Mon,  3 Aug 2026 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767224;
	bh=aD53Id0kbNiB4q+flkg2JQiI1EYQKieMCph/8OEkBAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdUY7Tj2auR+XtJPKasMf0xIQCUM2lIDYnypPALrHx2gf6qEcEFw+5efd3Y7MQBpS
	 XWgsJClBP0jwniTkfE/NtsgMyWAI6+oFh4XfXu//qV0dmMSaUExxKZ0XbLyYPiO4h0
	 7lkVMYMRUXKXEjFcbZ8MiHJtL27P3lrD0GfF4nbBDPjBw3CqBCZcN8M/7JjUvflF6s
	 YcKxMSgy9OaLgkuipCkStHmaPpMDwJ6yGgpHzKhqqG934GuN7burUxYs4yWyxfpGim
	 CroMjaZnOUeBUjxyHnvGF6UwcXAWuoDHi8YzpGCpbNrw3QxagdKfvJsPWSdzEAdsDV
	 pktTBAr3OmrBQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] spi: cadence-xspi: put marvell support code under CONFIG_64BIT
Date: Mon,  3 Aug 2026 22:07:26 +0800
Message-ID: <20260803140728.12747-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140728.12747-1-jszhang@kernel.org>
References: <20260803140728.12747-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cadence-xspi depends on 64BIT. This dependency isn't from
cadence xspi controller itself, but from marvell support code and 64bit
slave dma interface performance optimization.

Put marvell support code under CONFIG_64BIT to remove one reason of
the 64BIT dependency.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 19429b27875a..784619f17b40 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -749,6 +749,7 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+#ifdef CONFIG_64BIT
 static struct cdns_xspi_driver_data marvell_driver_data = {
 	.mrvl_hw_overlay = true,
 	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
@@ -1170,6 +1171,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 
 	return 0;
 }
+#endif
 
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
@@ -1195,12 +1197,14 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	host->mem_ops = &cadence_xspi_mem_ops;
 	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
 	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
+#ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
 		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
 		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
 		cdns_xspi->set_interrupts_handler = &marvell_xspi_set_interrupts;
 	}
+#endif
 	host->bus_num = -1;
 
 	platform_set_drvdata(pdev, cdns_xspi);
@@ -1246,6 +1250,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
 		if (IS_ERR(cdns_xspi->xferbase)) {
@@ -1257,6 +1262,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 			}
 		}
 	}
+#endif
 
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
@@ -1269,10 +1275,12 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+#ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
 		cdns_xspi_configure_phy(cdns_xspi);
 	}
+#endif
 
 	cdns_xspi_print_phy_config(cdns_xspi);
 
@@ -1306,10 +1314,12 @@ static int cdns_xspi_resume(struct device *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev_get_drvdata(dev);
 
+#ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
 		cdns_xspi_configure_phy(cdns_xspi);
 	}
+#endif
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
@@ -1324,10 +1334,12 @@ static const struct of_device_id cdns_xspi_of_match[] = {
 		.compatible = "cdns,xspi-nor",
 		.data = &cdns_driver_data,
 	},
+#ifdef CONFIG_64BIT
 	{
 		.compatible = "marvell,cn10-xspi-nor",
 		.data = &marvell_driver_data,
 	},
+#endif
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
-- 
2.53.0

