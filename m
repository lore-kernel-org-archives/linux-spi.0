Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9019C54E;
	Tue,  4 Aug 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844504; cv=fail; b=smQuukIPKNsOrC43JET41jJ1GPppw8uPQsYHv/E0MJdvnZS6eN4ebz3ZROKm0bDjvTBKOcMlo/IxEtVGvgZH1Cxt1xnusXI9pdI/kVOc3uIxnubqJ4wTB/cM+Or8UN9lrzpyFl9cdtM5TQ9HkHgRQaOoBSL417GoaeH+tRJbOeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844504; c=relaxed/simple;
	bh=V38xEiBRYJ9lob+U4Q/VvB9sWP7S7iWpg4JL/mCeWE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE9ZkqlgxDM2vZ6L3XvmlOYYnSuQo7aSL/feVg/nPMvGTNxTmuiYR745/lZt3z2LvV5Vk30jeHsI2LzGwg1zDJyw6K+LQFRXxwIVegskVUz9it8SOF7PhpHSrMaFa3bqBrQ8LPlVqz8SRRJGbEDKRL3nvPnjH7AIqPPzKG9/1tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FtucDkNg; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FtucDkNg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6E+ecjpGEJ3tKYyHGZTWHs5wnsmrfD0ifXYz4FUcT43XZ57qteQNs7DpGdMZTTVlUCLRwMGjBq3+9UF7pL12GzMliFdhEFoRApkcN9QHSqmxeNyY8xYHAgrJUZkeeWybeLDo6q3LtuVHhY7DH/VYoArmSeHS1l3kCOYcDNRaMg+s35WCr4Zxgj2vtmGgXNoIThpBoqzZG4BhVllwNFXdSldA52f/PhLnN3QaU+RLWTmT3vltb2iOW89gpizkxfBVUKDgaPtCGg34yYZjMIZV1k8bQ3oBuAnq+4bgk7TLI/Pqyy5zGZjjbnYa1kkDFNKw41bL2YV6pTzGoNGzxbCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRdNmUhV3F1lfZU93i9g6Rv6PAZM3X4Uowb5y27aiec=;
 b=JBN/Ky+2e9yCFmQAeNnH6slcKT7Ap03nKgoEmz8tQbujQkSV2vomea0hWhWGvLFiau3ca9yDVMeFulxft/slQY5eSON3Uyc13eTk2LieUAl+saxbYCyz1rY1rGND4UCvC7tUti6nom84PRxg6mMwGZM4xaFmkJp81HleSjV8C7TJuhSrKeOAEfkYjvUrZzHDIBHHmSL6h/EKncTuJnJM1ZuJmntRW7ECxMLaa7dpllCmF91w0uwZIhwVU5LnU+m0V4UkUTGAa/p1jCZTSH7w1c0mQDgKDQLiB+ynxBtuHwQ3FMx01WFWZ2MSSZMMRkOlLFO36IrwAYKFJ+GssA0XzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRdNmUhV3F1lfZU93i9g6Rv6PAZM3X4Uowb5y27aiec=;
 b=FtucDkNguPqPJ/mKkSbhCye/VayV4BBDkYI4SjzixSFSxZOOcOABcuM8Bb4ElW5uqK8+pFh95U1m2dAFqIBR7F+7lAKSq0lNU7b4Te1lPLpjy5cgcmk9xDJDeA11uH0/R02LAnKHnzficWbieKh9llincJlUKxT2yaVJdhDteZY=
Received: from CH2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:52::19)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:54:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::2c) by CH2PR04CA0009.outlook.office365.com
 (2603:10b6:610:52::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 11:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:54:55 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:54:51 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <akshata.mukundshetty@amd.com>,
	<bleung@chromium.org>, <groeck@chromium.org>,
	<chrome-platform@lists.linux.dev>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [RFC PATCH 4/4] espi: amd: add AMD eSPI controller driver
Date: Tue, 4 Aug 2026 17:22:59 +0530
Message-ID: <20260804115259.4065638-5-krishnamoorthi.m@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: f4645671-a316-40c5-2f65-08def21f3373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	odWNKktP6g9s3vzsavGtJyKZR45frg3CWIZzn85rnyR2T6bFd66lE1IyXnmntcIVVHLyDLLJCHvjck9rVjs9j2vIbPpixIlQpow2obNo3wtDZXuaETOqdjWduEBC/ylIT7/c4LuddK8gnxwb8+N6dw76vZZKisKS5pOI7/EbPCVwRpE1kJim9QtrKacy/wNnPuFxuquUnQ7HgY3tYA0A94un8gJrDLUvNAgdj8NhKOzu2sgjeeBKCoujLAhuTyMU1lovibsUBULttVclF8WDpj0LFFSiRReFcxD6pW8pDlt+UdilZUvQbu+4yQyDA9QA/8COicp3WhcqWVKpJea1xczVEv+PvOL3+ADA0+37L4XS/OrWl7goMRsNN6o5Y9L9MkX1AS64ckd/iHBTI6u57zDgbZ+3xVmXwMVvsgnJmzDJTnekDCf6axyr2jSLiHZp/QLMqEIX55rt4b1s55ZLx85SBE65EZe7yN+DP7M7W6OVS6fbwaP8rKtGlfwREsJsUk723pEBllVDqDsUcPfYU8rBXAsAkQvTZy+wYXIw/BUEZoaGgMlXVqWUzFfS5JeuOEA96Njsuc1YZZ2sL2Frpfs4DWWPpI23GgCbf97S327T4VU4YX+TCa8+q6watyAiLcbE/ZvlL2G/VHaLR6eyZtIeB1IRZGD56XQfmCPN1o72AR85ZRrsT3GVrAkdJj89V4+46s4L2algNG7nOFhYIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3EcbE/2Hff//GWsrRsdG5ZICD6dJhl/Y/dLz/yZHRbOexm3qgopKGqwkuKS97tYgol1vaqJiTBd+Ew9C1UAdcGTxTixe0rfsAGOFgL4bjO2d8dM07xNQC/rIlJ7yh52GLUBmUvMbpP6ib0juKeZJmmyz84QAqIjXQm54ZKI/tveogEgmglg04uY2IDuXcHe+bRrndbSRAL4ZmjpTfmU8BFeiUiLy9YpbtjGJKboLkyy89tyP099A8/zW9EihepUTs4OjRfhd0+Itwo152zB/5xOQX5AjABYOG6pjwFJjjenK3EgT5cGZoHvvhOVYpsYr+zjH9xCNP3BBFuBJorIphJ1Y6YJ80m/7zcNtH3qQ0HbGCJWxJwDxBRIci6MilTk9wymj2lVc5/OHoULme0gvGmYd25BZWHH/QwT42Vwia+9DSfEfftLHWvGID3TP2eiT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:54:55.3653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4645671-a316-40c5-2f65-08def21f3373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

Add a controller driver for the AMD eSPI controller (ACPI HID AMDI0070).

This initial implementation supports the channel-independent link
management commands: GET_CONFIGURATION, SET_CONFIGURATION and In-Band
Reset. Command completion and errors are reported via the controller
interrupt-status register, which is polled.

When the link parameters are renegotiated via SET_CONFIGURATION, the
host-side register is updated to match so both ends agree on clock and
I/O mode. In-Band Reset is handled safely by lowering the bus clock
before issuing the reset and restoring the host configuration afterwards.

Channel ops (Peripheral, Virtual Wire, OOB, Flash) and alert handling
are deferred to follow-on patches.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 drivers/espi/Kconfig    |  19 ++
 drivers/espi/Makefile   |   1 +
 drivers/espi/espi-amd.c | 453 ++++++++++++++++++++++++++++++++++++++++
 drivers/espi/espi-amd.h | 126 +++++++++++
 4 files changed, 599 insertions(+)
 create mode 100644 drivers/espi/espi-amd.c
 create mode 100644 drivers/espi/espi-amd.h

diff --git a/drivers/espi/Kconfig b/drivers/espi/Kconfig
index 7e609004967e..a6f104003799 100644
--- a/drivers/espi/Kconfig
+++ b/drivers/espi/Kconfig
@@ -20,3 +20,22 @@ menuconfig ESPI
 	  chain for delivering hardware events to slave drivers.
 
 	  If unsure, say N.
+
+if ESPI
+comment "eSPI Controller Drivers"
+
+config ESPI_AMD
+	tristate "AMD eSPI Controller"
+	depends on X86 || COMPILE_TEST
+	help
+	  Enable support for the AMD eSPI controller found on AMD SoCs and
+	  APUs (ACPI HID: AMDI0070). This controller drives the Enhanced
+	  Serial Peripheral Interface link to an eSPI target such as a BMC
+	  and implements the channel-independent configuration commands
+	  (GET_CONFIGURATION, SET_CONFIGURATION and In-Band Reset) used to
+	  bring up and negotiate the link's I/O mode, clock and CRC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called espi-amd. If unsure, say N.
+
+endif # ESPI
diff --git a/drivers/espi/Makefile b/drivers/espi/Makefile
index 48c2a591132f..2f0a5cae2cb9 100644
--- a/drivers/espi/Makefile
+++ b/drivers/espi/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 obj-$(CONFIG_ESPI)		+= espi-core.o espi-slave.o
+obj-$(CONFIG_ESPI_AMD)		+= espi-amd.o
diff --git a/drivers/espi/espi-amd.c b/drivers/espi/espi-amd.c
new file mode 100644
index 000000000000..36e3c5bc937f
--- /dev/null
+++ b/drivers/espi/espi-amd.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD eSPI Controller Driver
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/espi/espi.h>
+
+#include "espi-amd.h"
+
+static void amd_espi_clear_status(struct amd_espi_data *priv)
+{
+	u32 status = readl(priv->base + AMD_ESPI_SLAVE0_INT_STS_REG);
+
+	if (status)
+		writel(status, priv->base + AMD_ESPI_SLAVE0_INT_STS_REG);
+}
+
+static int amd_espi_check_status(struct amd_espi_data *priv, u32 status)
+{
+	if (!(status & AMD_ESPI_DNCMD_INT)) {
+		dev_err(priv->dev, "downstream command did not complete\n");
+		return -EIO;
+	}
+	if (!(status & AMD_ESPI_ERR_INT_MASK))
+		return 0;
+
+	if (status & AMD_ESPI_WAIT_TIMEOUT_INT) {
+		dev_err(priv->dev, "wait-state timer timeout\n");
+		return -ETIMEDOUT;
+	}
+	if (status & AMD_ESPI_NO_RESP_INT) {
+		dev_err(priv->dev, "no response from target\n");
+		return -ENODEV;
+	}
+	if (status & AMD_ESPI_CRC_ERR_INT) {
+		dev_err(priv->dev, "CRC error\n");
+		return -EBADMSG;
+	}
+	dev_err(priv->dev, "command error, status=0x%08x\n", status);
+	return -EIO;
+}
+
+static int amd_espi_send_cmd(struct amd_espi_data *priv,
+			     u32 hdr0, u32 hdr1, u32 hdr2)
+{
+	u32 status;
+	int ret;
+
+	ret = readl_poll_timeout(priv->base + AMD_ESPI_DN_TXHDR_REG0, status,
+				 !(status & AMD_ESPI_TXHDR0_CMD_STATUS),
+				 AMD_ESPI_MSG_DELAY_MIN_US,
+				 AMD_ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(priv->dev, "controller not ready to accept command\n");
+		return -EBUSY;
+	}
+
+	amd_espi_clear_status(priv);
+
+	writel(hdr1, priv->base + AMD_ESPI_DN_TXHDR_REG1);
+	writel(hdr2, priv->base + AMD_ESPI_DN_TXHDR_REG2);
+	/*
+	 * Data port must be written before triggering to frame the packet.
+	 * Channel-independent commands carry no data payload, so zero suffices.
+	 */
+	writel(0, priv->base + AMD_ESPI_DN_TXDATA_REG0);
+
+	dev_dbg(priv->dev,
+		"TX before trigger: hdr0=0x%08x hdr1=0x%08x hdr2=0x%08x data=0x%08x\n",
+		hdr0, hdr1, hdr2, 0);
+
+	writel(hdr0, priv->base + AMD_ESPI_DN_TXHDR_REG0);
+
+	ret = readl_poll_timeout(priv->base + AMD_ESPI_DN_TXHDR_REG0, status,
+				 !(status & AMD_ESPI_TXHDR0_CMD_STATUS),
+				 AMD_ESPI_MSG_DELAY_MIN_US,
+				 AMD_ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(priv->dev, "timed out sending command\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = readl_poll_timeout(priv->base + AMD_ESPI_SLAVE0_INT_STS_REG,
+				 status,
+				 status & (AMD_ESPI_DNCMD_INT | AMD_ESPI_ERR_INT_MASK),
+				 AMD_ESPI_MSG_DELAY_MIN_US,
+				 AMD_ESPI_RESP_MAX_TIMEOUT_US);
+	if (ret) {
+		dev_err(priv->dev, "timed out waiting for completion\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = amd_espi_check_status(priv, status);
+	writel(AMD_ESPI_DNCMD_INT, priv->base + AMD_ESPI_SLAVE0_INT_STS_REG);
+	return ret;
+}
+
+static u32 amd_espi_cfg_hdr0(enum espi_cmd_type type, u32 addr)
+{
+	return FIELD_PREP(AMD_ESPI_TXHDR0_CMD_TYPE, type) |
+	       AMD_ESPI_TXHDR0_CMD_STATUS |
+	       FIELD_PREP(AMD_ESPI_TXHDR0_HDATA0, (addr >> 8) & 0xff) |
+	       FIELD_PREP(AMD_ESPI_TXHDR0_HDATA1, addr & 0xff);
+}
+
+static int amd_espi_get_configuration(struct espi_controller *ctrl,
+				      u32 slave_reg_addr, u32 *config)
+{
+	struct amd_espi_data *priv = espi_controller_get_devdata(ctrl);
+	u32 hdr0 = amd_espi_cfg_hdr0(ESPI_CMD_GET_CONFIGURATION, slave_reg_addr);
+	int ret;
+
+	ret = amd_espi_send_cmd(priv, hdr0, 0, 0);
+	if (ret)
+		return ret;
+
+	*config = readl(priv->base + AMD_ESPI_DN_TXHDR_REG1);
+	dev_dbg(priv->dev, "GET_CONFIGURATION addr=0x%04x config=0x%08x\n",
+		slave_reg_addr, *config);
+	return 0;
+}
+
+/* Translate: target and host use different bit positions and clock encoding. */
+static void amd_espi_sync_config(struct amd_espi_data *priv, u32 slave_cfg)
+{
+	u32 io_mode = FIELD_GET(ESPI_GENCFG_IO_MODE, slave_cfg);
+	u32 host_freq;
+	u32 reg;
+
+	switch (FIELD_GET(ESPI_GENCFG_OP_FREQ, slave_cfg)) {
+	case ESPI_GENCFG_FREQ_66MHZ:
+		host_freq = AMD_ESPI_SLAVE0_CLK_FREQ_66MHZ;
+		break;
+	case ESPI_GENCFG_FREQ_33MHZ:
+		host_freq = AMD_ESPI_SLAVE0_CLK_FREQ_33MHZ;
+		break;
+	default:
+		host_freq = AMD_ESPI_SLAVE0_CLK_FREQ_16MHZ;
+		break;
+	}
+
+	reg = readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+	reg &= ~(AMD_ESPI_SLAVE0_CFG_CLK_FREQ | AMD_ESPI_SLAVE0_CFG_IO_MODE |
+		 AMD_ESPI_SLAVE0_CFG_ALERT_MODE | AMD_ESPI_SLAVE0_CFG_CRC_EN);
+	reg |= FIELD_PREP(AMD_ESPI_SLAVE0_CFG_CLK_FREQ, host_freq);
+	reg |= FIELD_PREP(AMD_ESPI_SLAVE0_CFG_IO_MODE, io_mode);
+	if (slave_cfg & ESPI_GENCFG_ALERT_MODE)
+		reg |= AMD_ESPI_SLAVE0_CFG_ALERT_MODE;
+	if (slave_cfg & ESPI_GENCFG_CRC_EN)
+		reg |= AMD_ESPI_SLAVE0_CFG_CRC_EN;
+	writel(reg, priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	dev_dbg(priv->dev,
+		"host SLAVE0_CONFIG updated to 0x%08x (io=%u host_freq=%u)\n",
+		readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG), io_mode, host_freq);
+}
+
+static int amd_espi_set_configuration(struct espi_controller *ctrl,
+				      u32 slave_reg_addr, u32 config)
+{
+	struct amd_espi_data *priv = espi_controller_get_devdata(ctrl);
+	u32 hdr0 = amd_espi_cfg_hdr0(ESPI_CMD_SET_CONFIGURATION, slave_reg_addr);
+	int ret;
+
+	dev_dbg(priv->dev, "SET_CONFIGURATION addr=0x%04x config=0x%08x\n",
+		slave_reg_addr, config);
+	ret = amd_espi_send_cmd(priv, hdr0, config, 0);
+	if (ret)
+		return ret;
+
+	/* Sync host link parameters after a General Configuration change. */
+	if (slave_reg_addr == ESPI_SLAVE_REG_GENERAL_CFG)
+		amd_espi_sync_config(priv, config);
+
+	return 0;
+}
+
+/* Lower clock to 16.7 MHz for In-Band Reset; preserve I/O mode. */
+static void amd_espi_lower_clk(struct amd_espi_data *priv)
+{
+	u32 reg = readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	reg &= ~AMD_ESPI_SLAVE0_CFG_CLK_FREQ;
+	reg |= FIELD_PREP(AMD_ESPI_SLAVE0_CFG_CLK_FREQ,
+			  AMD_ESPI_SLAVE0_CLK_FREQ_16MHZ);
+	writel(reg, priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+}
+
+static const char *amd_espi_io_mode_str(u32 io_mode)
+{
+	switch (io_mode) {
+	case AMD_ESPI_SLAVE0_IO_MODE_SINGLE:
+		return "single";
+	case AMD_ESPI_SLAVE0_IO_MODE_DUAL:
+		return "dual";
+	case AMD_ESPI_SLAVE0_IO_MODE_QUAD:
+		return "quad";
+	default:
+		return "reserved";
+	}
+}
+
+static const char *amd_espi_clk_freq_str(u32 clk_freq)
+{
+	switch (clk_freq) {
+	case AMD_ESPI_SLAVE0_CLK_FREQ_16MHZ:
+		return "16 MHz";
+	case AMD_ESPI_SLAVE0_CLK_FREQ_33MHZ:
+		return "33 MHz";
+	case AMD_ESPI_SLAVE0_CLK_FREQ_66MHZ:
+		return "66 MHz";
+	default:
+		return "reserved";
+	}
+}
+
+static void amd_espi_log_link(struct amd_espi_data *priv, const char *when)
+{
+	u32 reg = readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	dev_dbg(priv->dev,
+		"%s: I/O mode=%s frequency=%s (SLAVE0_CONFIG=0x%08x)\n", when,
+		amd_espi_io_mode_str(FIELD_GET(AMD_ESPI_SLAVE0_CFG_IO_MODE, reg)),
+		amd_espi_clk_freq_str(FIELD_GET(AMD_ESPI_SLAVE0_CFG_CLK_FREQ, reg)),
+		reg);
+}
+
+static int amd_espi_inband_reset(struct espi_controller *ctrl)
+{
+	struct amd_espi_data *priv = espi_controller_get_devdata(ctrl);
+	u32 hdr0 = FIELD_PREP(AMD_ESPI_TXHDR0_CMD_TYPE, ESPI_CMD_IN_BAND_RESET) |
+		   AMD_ESPI_TXHDR0_CMD_STATUS;
+	u32 cfg_before;
+	u32 reg;
+	int ret;
+
+	cfg_before = readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+	dev_dbg(priv->dev, "IN_BAND_RESET: SLAVE0_CONFIG before = 0x%08x\n",
+		cfg_before);
+
+	amd_espi_lower_clk(priv);
+
+	ret = amd_espi_send_cmd(priv, hdr0, 0, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Restore CRC and Alert-mode bits after reset: the controller clears
+	 * SLAVE0_CONFIG but the target retains these across an In-Band Reset.
+	 */
+	reg = readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+	if (ctrl->caps.alert_mode)
+		reg |= AMD_ESPI_SLAVE0_CFG_ALERT_MODE;
+	if (ctrl->caps.crc_supported)
+		reg |= AMD_ESPI_SLAVE0_CFG_CRC_EN;
+	writel(reg, priv->base + AMD_ESPI_SLAVE0_CONFIG_REG);
+
+	dev_dbg(priv->dev,
+		"IN_BAND_RESET: SLAVE0_CONFIG after = 0x%08x (was 0x%08x)\n",
+		readl(priv->base + AMD_ESPI_SLAVE0_CONFIG_REG), cfg_before);
+
+	amd_espi_log_link(priv, "after in-band reset");
+	return 0;
+}
+
+static int amd_espi_setup(struct espi_controller *ctrl)
+{
+	struct amd_espi_data *priv = espi_controller_get_devdata(ctrl);
+	u32 reg;
+
+	amd_espi_log_link(priv, "firmware default");
+
+	writel(AMD_ESPI_INTR_MASK, priv->base + AMD_ESPI_SLAVE0_INT_STS_REG);
+
+	/* Controller-wide bring-up: must run before the first downstream command. */
+	reg = readl(priv->base + AMD_ESPI_SLAVE0_RX_VW_REG);
+	writel(reg | AMD_ESPI_SLAVE0_RX_VW_INIT_MASK,
+	       priv->base + AMD_ESPI_SLAVE0_RX_VW_REG);
+
+	reg = readl(priv->base + AMD_ESPI_GLOBAL_CNTRL_REG0);
+	reg |= AMD_ESPI_GLOBAL0_WDG_EN | AMD_ESPI_GLOBAL0_WAIT_CHK_EN;
+	reg &= ~AMD_ESPI_GLOBAL0_WAIT_STATE;
+	reg |= FIELD_PREP(AMD_ESPI_GLOBAL0_WAIT_STATE, AMD_ESPI_WAIT_STATE_CNT);
+	writel(reg, priv->base + AMD_ESPI_GLOBAL_CNTRL_REG0);
+
+	reg = readl(priv->base + AMD_ESPI_SLAVE0_INT_EN_REG);
+	writel(reg | AMD_ESPI_ALL_ERR_INT | AMD_ESPI_REG_CMD_INT,
+	       priv->base + AMD_ESPI_SLAVE0_INT_EN_REG);
+
+	reg = readl(priv->base + AMD_ESPI_GLOBAL_CNTRL_REG1);
+	reg &= ~(AMD_ESPI_ERR_INT_MAP | AMD_ESPI_RGCMD_INT_MAP);
+	reg |= FIELD_PREP(AMD_ESPI_ERR_INT_MAP, AMD_ESPI_INT_MAP_SMI);
+	reg |= FIELD_PREP(AMD_ESPI_RGCMD_INT_MAP, AMD_ESPI_INT_MAP_SMI);
+	reg |= AMD_ESPI_BUS_MASTER_EN | AMD_ESPI_VW_REQ_EN;
+	writel(reg, priv->base + AMD_ESPI_GLOBAL_CNTRL_REG1);
+
+	/*
+	 * Unmask the VW IRQ index window. Do not touch SLAVE0_CONFIG clock or
+	 * I/O mode: preserve the operating point firmware already negotiated.
+	 */
+	reg = readl(priv->base + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG);
+	reg &= ~GENMASK(31, 8);
+	writel(reg | GENMASK(3, 0),
+	       priv->base + AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG);
+
+	writel(AMD_ESPI_INTR_MASK, priv->base + AMD_ESPI_SLAVE0_INT_STS_REG);
+
+	amd_espi_log_link(priv, "after probe setup");
+	return 0;
+}
+
+/* .get_status omitted: AMD HW has no GET_STATUS wire command. */
+static const struct espi_controller_ops amd_espi_ops = {
+	.setup			= amd_espi_setup,
+	.get_configuration	= amd_espi_get_configuration,
+	.set_configuration	= amd_espi_set_configuration,
+	.inband_reset		= amd_espi_inband_reset,
+};
+
+static u32 amd_espi_read_caps(struct amd_espi_data *priv,
+			      struct espi_capabilities *caps)
+{
+	u32 cap = readl(priv->base + AMD_ESPI_MASTER_CAP_REG);
+
+	dev_dbg(priv->dev, "MASTER_CAP=0x%08x\n", cap);
+
+	caps->supported_channels = 0;
+	if (cap & AMD_ESPI_CAP_PR_SUPPORT)
+		caps->supported_channels |= ESPI_CHANNEL_PERIPH_SUPP;
+	if (cap & AMD_ESPI_CAP_VW_SUPPORT)
+		caps->supported_channels |= ESPI_CHANNEL_VWIRE_SUPP;
+	if (cap & AMD_ESPI_CAP_OOB_SUPPORT)
+		caps->supported_channels |= ESPI_CHANNEL_OOB_SUPP;
+	if (cap & AMD_ESPI_CAP_FLASH_SUPPORT)
+		caps->supported_channels |= ESPI_CHANNEL_FLASH_SUPP;
+
+	switch (FIELD_GET(AMD_ESPI_CAP_CLK_FREQ, cap)) {
+	case 0x3:
+		caps->max_freq_mhz = ESPI_FREQ_66MHZ;
+		break;
+	case 0x1:
+		caps->max_freq_mhz = ESPI_FREQ_33MHZ;
+		break;
+	default:
+		caps->max_freq_mhz = ESPI_FREQ_16MHZ;
+		break;
+	}
+	switch (FIELD_GET(AMD_ESPI_CAP_IO_MODE, cap)) {
+	case 0x2:
+		caps->io_mode = ESPI_IO_MODE_QUAD;
+		break;
+	case 0x1:
+		caps->io_mode = ESPI_IO_MODE_DUAL;
+		break;
+	default:
+		caps->io_mode = ESPI_IO_MODE_SINGLE;
+		break;
+	}
+
+	caps->alert_mode = !!(cap & AMD_ESPI_CAP_ALERT_MODE);
+	caps->crc_supported = !!(cap & AMD_ESPI_CAP_CRC_CHECK);
+	caps->periph_max_payload = FIELD_GET(AMD_ESPI_CAP_PR_MAX_SIZE, cap);
+	caps->vwire_max_count = FIELD_GET(AMD_ESPI_CAP_VW_MAX_SIZE, cap);
+	caps->oob_max_payload = FIELD_GET(AMD_ESPI_CAP_OOB_MAX_SIZE, cap);
+	caps->flash_max_payload = FIELD_GET(AMD_ESPI_CAP_FLASH_MAX_SIZE, cap);
+
+	return cap;
+}
+
+static u8 amd_espi_num_targets(u32 cap)
+{
+	/* CAP_SLAVE_NUM is 0-based: 0 means 1 target, 1 means 2, etc. */
+	return (u8)(FIELD_GET(AMD_ESPI_CAP_SLAVE_NUM, cap) + 1);
+}
+
+static int amd_espi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct espi_controller *ctrl;
+	struct amd_espi_data *priv;
+	int ret;
+	u32 cap;
+
+	ctrl = espi_controller_alloc(dev, sizeof(*priv));
+	if (IS_ERR(ctrl))
+		return dev_err_probe(dev, PTR_ERR(ctrl),
+				     "failed to allocate eSPI controller\n");
+
+	priv = espi_controller_get_devdata(ctrl);
+	priv->dev = dev;
+	priv->version = (enum amd_espi_versions)(uintptr_t)
+			device_get_match_data(dev);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->base),
+				    "failed to map registers\n");
+		goto err_put;
+	}
+
+	cap = amd_espi_read_caps(priv, &ctrl->caps);
+	ctrl->ops = &amd_espi_ops;
+	ctrl->max_targets = amd_espi_num_targets(cap);
+
+	ret = espi_controller_register(ctrl);
+	if (ret) {
+		ret = dev_err_probe(dev, ret,
+				    "failed to register eSPI controller\n");
+		goto err_put;
+	}
+
+	platform_set_drvdata(pdev, ctrl);
+	return 0;
+
+err_put:
+	espi_controller_put(ctrl);
+	return ret;
+}
+
+static void amd_espi_remove(struct platform_device *pdev)
+{
+	espi_controller_unregister(platform_get_drvdata(pdev));
+}
+
+static const struct acpi_device_id amd_espi_acpi_match[] = {
+	{ "AMDI0070", AMD_ESPI_V1 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_espi_acpi_match);
+
+static struct platform_driver amd_espi_driver = {
+	.driver = {
+		.name			= "amd-espi",
+		.acpi_match_table	= amd_espi_acpi_match,
+	},
+	.probe	= amd_espi_probe,
+	.remove	= amd_espi_remove,
+};
+module_platform_driver(amd_espi_driver);
+
+MODULE_AUTHOR("Krishnamoorthi M <krishnamoorthi.m@amd.com>");
+MODULE_AUTHOR("Akshata MukundShetty <akshata.mukundshetty@amd.com>");
+MODULE_DESCRIPTION("AMD eSPI Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/espi/espi-amd.h b/drivers/espi/espi-amd.h
new file mode 100644
index 000000000000..3c514e005aa2
--- /dev/null
+++ b/drivers/espi/espi-amd.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD eSPI Controller Driver - internal definitions
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ */
+#ifndef _ESPI_AMD_H_
+#define _ESPI_AMD_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define AMD_ESPI_DN_TXHDR_REG0			0x00
+#define AMD_ESPI_DN_TXHDR_REG1			0x04
+#define AMD_ESPI_DN_TXHDR_REG2			0x08
+#define AMD_ESPI_DN_TXDATA_REG0			0x0C
+#define AMD_ESPI_MASTER_CAP_REG			0x2C
+#define AMD_ESPI_GLOBAL_CNTRL_REG0		0x30
+#define AMD_ESPI_GLOBAL_CNTRL_REG1		0x34
+#define AMD_ESPI_SLAVE0_CONFIG_REG		0x68
+#define AMD_ESPI_SLAVE0_INT_EN_REG		0x6C
+#define AMD_ESPI_SLAVE0_INT_STS_REG		0x70
+#define AMD_ESPI_SLAVE0_RX_VW_REG		0x9C
+#define AMD_ESPI_SLAVE0_VW_MISC_CNTRL_REG	0xA8
+
+/*
+ * SLAVE0_CONFIG (0x68) host-side link fields. The negotiated bus clock and
+ * I/O mode use AMD's own encoding (clock 000=16.6/001=33/010=66 MHz).
+ */
+#define AMD_ESPI_SLAVE0_CFG_CLK_FREQ		GENMASK(27, 25)
+#define AMD_ESPI_SLAVE0_CFG_IO_MODE		GENMASK(29, 28)
+#define AMD_ESPI_SLAVE0_CFG_ALERT_MODE		BIT(30)
+#define AMD_ESPI_SLAVE0_CFG_CRC_EN		BIT(31)
+#define AMD_ESPI_SLAVE0_CLK_FREQ_16MHZ		0x0
+#define AMD_ESPI_SLAVE0_CLK_FREQ_33MHZ		0x1
+#define AMD_ESPI_SLAVE0_CLK_FREQ_66MHZ		0x2
+#define AMD_ESPI_SLAVE0_IO_MODE_SINGLE		0x0
+#define AMD_ESPI_SLAVE0_IO_MODE_DUAL		0x1
+#define AMD_ESPI_SLAVE0_IO_MODE_QUAD		0x2
+
+/* GLOBAL_CNTRL_REG0 (0x30) */
+#define AMD_ESPI_GLOBAL0_WDG_EN			BIT(0)
+#define AMD_ESPI_GLOBAL0_WAIT_CHK_EN		BIT(1)
+#define AMD_ESPI_GLOBAL0_WAIT_STATE		GENMASK(29, 23)
+#define AMD_ESPI_WAIT_STATE_CNT			0x3f
+
+/* GLOBAL_CNTRL_REG1 (0x34) */
+#define AMD_ESPI_ERR_INT_MAP			GENMASK(12, 8)
+#define AMD_ESPI_RGCMD_INT_MAP			GENMASK(17, 13)
+#define AMD_ESPI_INT_MAP_SMI			0x1f
+#define AMD_ESPI_BUS_MASTER_EN			BIT(1)
+#define AMD_ESPI_VW_REQ_EN			BIT(21)
+
+/* SLAVE0_INT_EN (0x6C): error [19:0] and register-command [31:24] enables */
+#define AMD_ESPI_ALL_ERR_INT			GENMASK(19, 0)
+#define AMD_ESPI_REG_CMD_INT			GENMASK(31, 24)
+
+/* SLAVE0_RX_VW_REG (0x9C): clears stale VW status [31:8], preserves IRQ [7:0]. */
+#define AMD_ESPI_SLAVE0_RX_VW_INIT_MASK		0xffff6f00
+
+/*
+ * DN_TXHDR_REG0 fields. The 16-bit target register address occupies
+ * [23:8]; the eSPI wire order places the address MSB first, so the high
+ * byte goes in HDATA0 [15:8] and the low byte in HDATA1 [23:16].
+ */
+#define AMD_ESPI_TXHDR0_CMD_TYPE		GENMASK(2, 0)
+#define AMD_ESPI_TXHDR0_CMD_STATUS		BIT(3)
+#define AMD_ESPI_TXHDR0_HDATA0			GENMASK(15, 8)
+#define AMD_ESPI_TXHDR0_HDATA1			GENMASK(23, 16)
+
+/* SLAVE0_INT_STS (0x70) status and interrupt bits */
+#define AMD_ESPI_BUS_ERR_INT			BIT(0)
+#define AMD_ESPI_WAIT_TIMEOUT_INT		BIT(1)
+#define AMD_ESPI_CRC_ERR_INT			BIT(2)
+#define AMD_ESPI_NO_RESP_INT			BIT(4)
+#define AMD_ESPI_FATAL_ERR_INT			BIT(5)
+#define AMD_ESPI_NON_FATAL_ERR_INT		BIT(6)
+#define AMD_ESPI_INVALID_RESP_CODE_INT		BIT(7)
+#define AMD_ESPI_INVALID_CYCLE_TYPE_INT		BIT(8)
+#define AMD_ESPI_UNSUCCESS_CPL_RECV_INT		BIT(9)
+#define AMD_ESPI_ILLEGAL_RESP_TAG_INT		BIT(10)
+#define AMD_ESPI_ILLEGAL_RESP_LEN_INT		BIT(11)
+#define AMD_ESPI_RX_OOB_OVERFLOW_INT		BIT(12)
+#define AMD_ESPI_RX_PC_MSG_OVERFLOW_INT		BIT(13)
+#define AMD_ESPI_RX_FLASH_MSG_OVERFLOW_INT	BIT(14)
+#define AMD_ESPI_PROTOCOL_ERR_INT		BIT(15)
+#define AMD_ESPI_DNCMD_INT			BIT(28)
+#define AMD_ESPI_INTR_MASK			GENMASK(31, 0)
+
+#define AMD_ESPI_ERR_INT_MASK	\
+	(AMD_ESPI_BUS_ERR_INT | AMD_ESPI_WAIT_TIMEOUT_INT | \
+	 AMD_ESPI_CRC_ERR_INT | AMD_ESPI_NO_RESP_INT | \
+	 AMD_ESPI_FATAL_ERR_INT | AMD_ESPI_NON_FATAL_ERR_INT | \
+	 AMD_ESPI_INVALID_RESP_CODE_INT | AMD_ESPI_INVALID_CYCLE_TYPE_INT | \
+	 AMD_ESPI_UNSUCCESS_CPL_RECV_INT | AMD_ESPI_ILLEGAL_RESP_TAG_INT | \
+	 AMD_ESPI_ILLEGAL_RESP_LEN_INT | AMD_ESPI_RX_OOB_OVERFLOW_INT | \
+	 AMD_ESPI_RX_PC_MSG_OVERFLOW_INT | AMD_ESPI_RX_FLASH_MSG_OVERFLOW_INT | \
+	 AMD_ESPI_PROTOCOL_ERR_INT)
+
+#define AMD_ESPI_MSG_DELAY_MIN_US		50
+#define AMD_ESPI_RESP_MAX_TIMEOUT_US		200000	/* 200 ms */
+
+#define AMD_ESPI_CAP_FLASH_SUPPORT		BIT(0)
+#define AMD_ESPI_CAP_OOB_SUPPORT		BIT(1)
+#define AMD_ESPI_CAP_VW_SUPPORT			BIT(2)
+#define AMD_ESPI_CAP_PR_SUPPORT			BIT(3)
+#define AMD_ESPI_CAP_FLASH_MAX_SIZE		GENMASK(9, 7)
+#define AMD_ESPI_CAP_OOB_MAX_SIZE		GENMASK(12, 10)
+#define AMD_ESPI_CAP_VW_MAX_SIZE		GENMASK(18, 13)
+#define AMD_ESPI_CAP_PR_MAX_SIZE		GENMASK(21, 19)
+#define AMD_ESPI_CAP_SLAVE_NUM			GENMASK(24, 22)
+#define AMD_ESPI_CAP_CLK_FREQ			GENMASK(27, 25)
+#define AMD_ESPI_CAP_IO_MODE			GENMASK(29, 28)
+#define AMD_ESPI_CAP_ALERT_MODE			BIT(30)
+#define AMD_ESPI_CAP_CRC_CHECK			BIT(31)
+
+enum amd_espi_versions {
+	AMD_ESPI_V1 = 1,
+};
+
+struct amd_espi_data {
+	void __iomem *base;
+	struct device *dev;
+	enum amd_espi_versions version;
+};
+
+#endif /* _ESPI_AMD_H_ */
-- 
2.34.1

