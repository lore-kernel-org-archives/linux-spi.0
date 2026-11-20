Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176022;
	b=PeQ3It9JN7kfvCVnUUfmFX5ZyXvFIIqnbej1VAXiSGVkYCGf6ojI4R6BDjzVuFfjtp50
	 Gk1yJKmzAFGENZ0pCZkXgR826/uHLQGFaUJZCmlFw99TPzHXD+WxgGT5T9S98UDQohIEs
	 Oq9kk4pxpmDqiQyYNZoybcMh8gyvfxyZ8CtVXXr6QmbTB/7J91tCfDXsVwfCNlu07+zHr
	 J8kb8iifEU903jajI+07uP8TKdkrfxRo2rc2f9rZNKQGj/Wm201dHIUriom2V5cTxvTKc
	 KwfQp3ayN3u5oAg12Jc3e+urM0xfRVRQVK+JXM/B5ybxB8D8H3kZl7M6ZRm3rTNFmWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176022;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=j/vFTo/WzWtYBe57jLj39Uo2vtxrhyN5lkikj6A7mWo=;
	b=oq83JzuvUBAwPwinIwBhxPgELwVcs1CbciTb+7HutzH87G1xcO4RUV+lZIphknc6jFk+
	 9uu4D1Cq2cfTGjOMegZ3j2BqEo2bQkDqbKyrslk2AjfyeoTReD8H4VifdMPKB5+vSWIvt
	 OJ5QBrLqGtWSA68tXfak6Mao2w5/UUQ3W6/mC5f31ThjFD9J2jkTAzWocP43w52jwQ2oN
	 IW/soN6uwQ4puLJ+SlpNLHlTJxJcELoJJmTjZYNnTO2ajgPYb+S9binA06jR+O3zinOuR
	 5yBGK7Ekb2ktsjoR3Dc9702Lyfpo3eJ0SsMHawI5aKOJ19mENskZmCFLWI3l+5q+V/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Z7lcuDRD;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F8606A336;
	Fri, 20 Nov 2026 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C4F8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Z7lcuDRD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CD171A174A;
	Fri, 20 Nov 2026 12:00:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D64116017D;
	Fri, 20 Nov 2026 12:00:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB90B11BC00EC;
	Fri, 20 Nov 2026 13:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795176013; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=j/vFTo/WzWtYBe57jLj39Uo2vtxrhyN5lkikj6A7mWo=;
	b=Z7lcuDRDT26WhEVfIigM/Tt2PRBGllC4vsT0C/q+pa/9VcQE5w2c57H8WfmjxmRbyUiHVD
	evZDuwAD4gL8oIXWguTxZhuhzdYBKZ4x4hDf1/0UDmZJQDw14F69gLfBCUDWzETxzQ2ntM
	t+dAA5VnFFZi+tGQRHD281SkK9uk2gcuaUEXa1PqfIxTC0T24E19vGOFsU5O1uDbhpZZ/N
	UPwhzbC90m800/GSqfjsIG2JqU7GJQtxq1ut1GapGH34yU5yqGEBWKZQFk6wP04iM6bQpW
	e3MufqEaQfTRfOEFRdd0Q85YXiHkxlYWAo0D8nJM/dnqPhWMB9XUJczt/b7fLw==
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
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 7/7] spi: cadence-xspi: Add workaround for old Marvell firmwares
Date: Fri, 20 Nov 2026 12:59:25 +0100
Message-ID: <20261120115925.173568-8-paul.cercueil@bootlin.com>
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

Older firmwares from Marvell used the cdns,xspi-nor compatible string
for the Marvell-specific xSPI IP, which is incompatible.

Add a workaround to support this case, checking for a Marvell board in
the DTB or the ACPI tables.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: Replace the workaround based on the presence of the "xfer" resource
    with a mechanism that identifies a Marvell SoC based on the board's
    compatible string on DTB, and the DSDT table on ACPI.

v3: Wrap ACPI specific code with CONFIG_ACPI guards, as some of the
    functions and structs aren't defined without CONFIG_ACPI.

v4-v5: No change
---
 drivers/spi/spi-cadence-xspi.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index dbfb07e6751f..4dea1a68fe8d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -13,11 +14,13 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/string.h>
 #include <linux/bitfield.h>
 #include <linux/limits.h>
 #include <linux/log2.h>
@@ -906,7 +909,6 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
-#ifdef CONFIG_64BIT
 static struct cdns_xspi_driver_data marvell_driver_data = {
 	.mrvl_hw_overlay = true,
 	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
@@ -919,6 +921,7 @@ static struct cdns_xspi_driver_data marvell_driver_data = {
 	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
 };
 
+#ifdef CONFIG_64BIT
 static const int cdns_mrvl_xspi_clk_div_list[] = {
 	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
 	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
@@ -1367,6 +1370,33 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 }
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_platform_list mrvl_platform_list[] = {
+	{
+		.oem_id = "MRVL  ",
+		.oem_table_id = "CN10K",
+		.table = ACPI_SIG_DSDT,
+		.pred = all_versions,
+	},
+	{ }
+};
+#endif
+
+static inline bool cdns_is_marvell(struct device *dev)
+{
+	const char *compatible;
+
+#ifdef CONFIG_ACPI
+	if (has_acpi_companion(dev))
+		return acpi_match_platform_list(mrvl_platform_list) >= 0;
+#endif
+
+	if (of_machine_read_compatible(&compatible, 0) < 0)
+		return false; /* shouldn't actually happen */
+
+	return strstarts(compatible, "marvell,");
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1388,6 +1418,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (!cdns_xspi->driver_data)
 		return -ENODEV;
 
+	if (IS_ENABLED(CONFIG_64BIT) &&
+	    !cdns_xspi->driver_data->mrvl_hw_overlay &&
+	    cdns_is_marvell(dev)) {
+		/* Some old firmwares use the base compatible string... */
+
+		dev_warn(dev, "Using the cdns,xspi-nor compatible string on a Marvell SoC. Please fix firmware!\n");
+		cdns_xspi->driver_data = &marvell_driver_data;
+	}
+
 	host->mem_ops = &cadence_xspi_mem_ops;
 	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
 	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
-- 
2.47.3

