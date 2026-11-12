Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493898;
	b=TnwLRWvYPxKNIzx5Ukk/C4x+lnnv0F89+1wRfQZS8cRJJEjytq+7gwKlTcXn5fISd5UY
	 Y8S526BWvWvXH86PjHhUbeT2hSOiPwwHzFrSd7gsuINtiDKnbmZfqhAqN5xeqL3vuPlH5
	 yJKcriy+PcUkJ+FDnngQZMK5YAqxCXB4Gk3PRQPL70XYTK4+iBl50y3GE+RyBCethR9nA
	 eoYqzn0rO8msrBNvnWCIbg374lzhDg+4D7H5oNbx8tf85ACWksXFy2Uir7NpXvVlfGKn6
	 ukmM8ukqT05PzzAjetJlVsfgBCiuApIodTS7DU6ihpzlccCUpUVOx/qDu3qYTzqcpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493898;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=WxYrZpJCR/Hkvdig2z8X5gfVd8P363OMZOehzA8K4RQ=;
	b=dv6Ll9yGfNySuBdU5DqWfPbOq5jFAKskbJxvldfhcERQJnfUkX7lsea2nqvDi3ypz3xC
	 opihD2JSPNdS+1kNxs9ZEhjV5PbPC65N6+BijG/0oirZCZJVwvJXyeQ1kFwpM51auB+FI
	 D0BCneuKxDGOeVJtuC3hx6e7kGxc9pU3rfrVfCKOb7qYBckE7H3V5zcL9Zzu4Ohj+rPfI
	 J1IlfRvfgBuyltU9OVSUL1yu2bCMTDcjcxEUqerk7FnyzIS5PmKuMuBIzmZvndtmS9bGm
	 p0Yg+LFRs5O72OPUEwwKMYqomteFAYUFxMZq1OsmII5Hp1ekk9eKwMkxh/fQaYPacHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b87n8Nqe;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F060A6F66
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 14:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127F060A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b87n8Nqe
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0F924E41594;
	Thu, 12 Nov 2026 14:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E3F6601D5;
	Thu, 12 Nov 2026 14:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3C6B11BC07CF;
	Thu, 12 Nov 2026 15:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794493895; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WxYrZpJCR/Hkvdig2z8X5gfVd8P363OMZOehzA8K4RQ=;
	b=b87n8Nqe/taxxXRVMp5Ts+pI0ZnnzcTnAvHAJ7zYo91PiO/L5MoahQAzQ8ZehUPjhdtA4E
	pB0B2xyjI8p8mYCJfbI8y+PuNjOtgs6y0CnS4s0ociuiv8Na0cnAToP0tMNLL6bXE9H9nj
	QkSSpWW5AgPpsxbz/u5PSxha5QiXzu2uDPoisAVjGImyqfN69TydQT9Tjf9PVlDMtvzmFZ
	ALoHoT66Xt7IFy3U+K5Ouenr6+tMFUmr5hDVIuDklvTxsLNhnMsQetZtMxkjHxwzA0aCvq
	vi/HDqHKJ6/rra8+Dx3sBeV2lHKgY7pN8jUoyiBnTPefH6g1zOCPquo3uplbgg==
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
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 6/6] spi: cadence-xspi: Add workaround for old Marvell firmwares
Date: Thu, 12 Nov 2026 15:30:50 +0100
Message-ID: <20261112143050.53347-7-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112143050.53347-1-paul.cercueil@bootlin.com>
References: <20261112143050.53347-1-paul.cercueil@bootlin.com>
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
---
 drivers/spi/spi-cadence-xspi.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 8fa58a0412e3..7b06b95af794 100644
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
@@ -1228,6 +1231,33 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
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
@@ -1249,6 +1279,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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

