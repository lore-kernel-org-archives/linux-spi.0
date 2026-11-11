Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393366;
	b=YoJfuaMHld4JQMg1Fzf58bA0jHcYdZ5qIIiylaOmTYq2TniPgHtCGsQfG+sW6d/n4pP5
	 HX0+DNtWl2oNGvVd8zxWgevsB5YbM0LP28Im2k29TRvWVHQzZiqe/GcjEFElRQfh/IhNJ
	 bFDApqvpEJRBapCiQUPDlD1uCGgxliBgUe1E7ZtLxS4xz+DYUuDElhDlmj6uKkUF9NqVr
	 ewV2qTNvZZ8S5hIRT2GzpgZ2mq/tvGKkaniYbOQBkZU1yG241JaSs/hwqNAKIitBadfd9
	 utQ2+WLKjzV0Qj/MZYmrTarfmXCjSPxkJGuWVoIwRpuA/SoDyO7xmEZPxE8Y0sp5cng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393366;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=EA+oBgLckQ5lkvyuDUdFmCOOtrZFZAX+kfOrzKh17NA=;
	b=pUOgNHhAGDYGWd23td0yI9fjnd5h+248TXRbDM9IMeKq5vHWB88oOse3LUcnRcP1NYqj
	 ApNuq5zCRRlUuXtEzb4ZuMp9QE/mMp7AqrgJNip1Mbmncyvebxdj+M6wxGV6SNLdH6hZp
	 9A2O12SAnTv1WygOl0CHLBrzTjbv3WlN1evLHRsaR6d9GUeMMhkAJ52kGb1X9RVQpNR5J
	 v+TDQjqIElcOkx1JM67aOI9YfkNvzel7+NYoA+/iXf0YV/qUnSrMaNzcmxOLCKb8L5dpv
	 UqQ9GWQ9Q0eHkSsVhEAsYF0Y+vpNlmSSZCXy/HW4nNM+Uf23BzvHiWIAYeojL0NjY4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FcC3bNSQ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CC606A8AA
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B72CC606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FcC3bNSQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5FD87C79A90;
	Wed, 11 Nov 2026 10:36:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A65D06017E;
	Wed, 11 Nov 2026 10:36:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E623E11BC1D77;
	Wed, 11 Nov 2026 11:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794393364; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EA+oBgLckQ5lkvyuDUdFmCOOtrZFZAX+kfOrzKh17NA=;
	b=FcC3bNSQEIn1B8QILeWvw+0hLTmqvaMvR/t2lj71SGTiZYuG6gUGWQnoPkGBv/x0vrGhia
	eSYUkgsPOOA8R6rwvB6Si1+zT6L1yE072ILEXZUaFg90gNnwTbiafYaXy8iLWLsISSpUT3
	Q3m8I8Z1npmEpGzqxvOkvQ55TUw7aSgYYr2HlVoEXLqFJ++l9v1wnVhi4pkYXJGE8mfKbw
	Y9FQKHqr/4Y/pk3lB7tKkm0f3WiXTwq7P3aOZRMbkO8ZuaPj9XGIJA+3IWqmMI8zuhX818
	lMzc6S8Iz0vRQpc2uOfFlGGnUcDhd6MsXENcTyvER/KTDzIdZf6uIDigjCcb6g==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old Marvell firmwares
Date: Wed, 11 Nov 2026 11:35:41 +0100
Message-ID: <20261111103541.100848-7-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111103541.100848-1-paul.cercueil@bootlin.com>
References: <20261111103541.100848-1-paul.cercueil@bootlin.com>
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
---
 drivers/spi/spi-cadence-xspi.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 8fa58a0412e3..ecb78fcc6228 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -11,11 +12,13 @@
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
@@ -775,7 +778,6 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
-#ifdef CONFIG_64BIT
 static struct cdns_xspi_driver_data marvell_driver_data = {
 	.mrvl_hw_overlay = true,
 	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
@@ -788,6 +790,7 @@ static struct cdns_xspi_driver_data marvell_driver_data = {
 	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
 };
 
+#ifdef CONFIG_64BIT
 static const int cdns_mrvl_xspi_clk_div_list[] = {
 	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
 	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
@@ -1228,6 +1231,29 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 }
 #endif
 
+static const struct acpi_platform_list mrvl_platform_list[] = {
+	{
+		.oem_id = "MRVL  ",
+		.oem_table_id = "CN10K",
+		.table = ACPI_SIG_DSDT,
+		.pred = all_versions,
+	},
+	{ }
+};
+
+static inline bool cdns_is_marvell(struct device *dev)
+{
+	const char *compatible;
+
+	if (has_acpi_companion(dev))
+		return acpi_match_platform_list(mrvl_platform_list) >= 0;
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
@@ -1249,6 +1275,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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

