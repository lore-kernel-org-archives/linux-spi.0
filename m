Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775D4C650F;
	Mon, 12 Oct 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826646; cv=fail; b=PX8QKYdwQ3f62mest3L3hk4l65T8ch5wgo51bqKEHo/jgFr+np0VdHj8IhNweOVnLynihS/ljXCeShR4gcTbJWmXQGtGfHNaYtWdg/FZtG2fD6XwQz8BLHrUd+/e7Yb501l1VM25TBFG63sA+09345GtNnM80sFoKgzyfDjzuHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826646; c=relaxed/simple;
	bh=AiSaZ/C2OmjOGTRsPMFY72KacCvJ3c8WvmuQfRoNMK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hONWLoLshfcr1cxgV4cGao4T4wwYOU16whts9vaBrRtnkvRt606v1cRdOEWkgF5JKShcEn48wD+Lw9EK2Vf5hvExajzYdpEEw6W183OxcHRi8ZZAw5eHeEd2G93Pi7Y04cRCFv6r/w2DHiKPfb4FwZ5qTmCs2aPLGG1hNwEJcBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aEH6Me14; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aEH6Me14"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUD7tYEdWbpUApql1TXvOGUBXmu21AlYMdfBW9g0QWxLsAQTLtsX4fJyhLDjAFe4PnNog+bg5XL+8aaS5MV9xQsB2ZsYudUqCXs5kxA5ckJZ6/Wmq8y+wZbSQgQWsdx1CxJCj9wXWrPZjx0g5v+JNS7wR6xNOmCBew6/GBawJes5n8EhI4dRErKXIZLsVOJvBwoLNRw4H864YVXFbAagAKwvDEaTzO2zvhxGf8+4V47gG13i7fmLwRAGPZdAkwWflB4Jg7Pf6DropELK2XrSCgDG9dDKTZJ3jT0P1TZNDUqQX0evV2NnbbzeUpB/MW7uSn3sFvIxywl92l7+fVCJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzBUXhEpV5V9cVqnsUHC6ZmFrFbgQgpOxvenOvcRoxA=;
 b=JCSuzQMrG/b1GZVap8RfmHup85HIW6+KzU8CXxPA6qbwQe+vVqCP8U4iilezM5VmpcXQkS8SW4oRqSnYh7oIh8ztOb/RwLcy+Q3HYU1+0ohnk1GFq/uHVOR1JKUs6oRqWKjl60sJkmdB+yP5VwqOqUG/QXTfXLhDzzWgL6IDbIJcZrR27PpFzVzOHLFWhjy+lX89Ya/8879t9X002tzmDUcmZbv3+cNP1LGlmss2BBd6KKs7bF5wIUfeZ6dpmnFdeZVCBkW7djFuY6shIU2eSSFo1TUE0Rxi5QR5Q6t62Iccvhu9fXO9x3cHZgJ8qrMan0GOmYQqZacMOfxWIFtVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzBUXhEpV5V9cVqnsUHC6ZmFrFbgQgpOxvenOvcRoxA=;
 b=aEH6Me14vQeVQWKtbfB8XKhpGpnfTKbg8Y1oZa0kG3Xe28/Cc4UvVAguqc+uBLTOMvS57dzfYvKYqkbelhbwGSMGEXpqxNfLGuUHuE5UMEV4T436aKwW7igJxi5TID90hr69yK2h75RCEvrF45jZZgS/szp+Zb3YRHBKlX32EGriCsve/s2DYS1IezQ5E7l2sr9Fv4E7ENCB8X9AS6X7dUDa+7TQNXeI/uOhEgK5lgbwxuydezvUWNjP9b0iRV2S15eaFNxr9MDL6ck6fIri6GgmSjRziOv5EMNvmBSND/662xb9b1nxNDK5DQLTK2HOl94muOngwLrp5xPREHE6wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:37:20 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:37:20 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/11] spi: Add NVIDIA LSTP SPI driver
Date: Mon, 12 Oct 2026 20:36:07 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-9-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::8) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 68396378-36e4-4eb0-7db6-08df28877775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|5023799004|11063799006|56012099006|22082099003|18002099003|261009221227099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	81GknjKYc2YEHcJAe0Cf1CJtjp6M6xEy+Ihlnq1MbdAOyO+L+4gbaSY7bL5xl1sgJlGz0RBDNkChTWguV53ljnuVry12S1USt3yQihupfNXD12iXy0zqhF19T4stZoKjZyFT3bWd3BwME7aeahodsHDXtrLkHmKdHYuMGUUp1qyJXKULa7o6pEfNNXjqAxj+OYGhC9/waVJfaL7U5/22rPV+hjGnIpP+Hr7GvJeywpJcOICax3nJwnrbEovA/p6jA3BqLpwg/AjgaI/kc3jkvGylg0QAHdVaZMi2zp/VHbxtyHjETqBWE8oRaAuGhSmkfuuk21LfwV75Zq+8AcvOMDQrn0MM8hriSyiYeDj3+QzqMyIZcT5lV8/s/iqShsiqe8YErYkEiqtGmoiO0Z1HXfAOtQ0JD52tS0ZLcFw1Aep3yJ6783Tx1BGUq6THD+hZYiAb+cX88nt6tkq/b8vMUEbJFpggiAtfRHOBohF01K3lGFJyiTOI+V3P5DNLUr9OeoDeHnV96ouxSYdbxf4vaD8pOKkzvmWYLDG6xRkOd0vKTH97+cRNt1iLZzb35wZoiEVi8MFeSkChgZpvhDlvSUpFPjE0zfWp303QpctmuUWVMfP7KOTBmI9ptJOdts3Uv7rtS82fDQjHk1TYiUPB6sO8vD7IyZvAsGpCWDOMXm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXaYB1lE0nK6LpBhb/BJKZQPZDM+BECuKqHRxOVAm/9QLIwt5x3EpgXZDUa+?=
 =?us-ascii?Q?+t5Bx6eTKt8fGKy4IcUngFXLD1w+cW+v83ydCz3Wy2odIfv9vRsP86W1EVNS?=
 =?us-ascii?Q?lnIsnk51JjGvQ/2U2VmS6YnRSfNuUFN0WcZ3qjVZ8yMoUdCNWUf5s2SN9C32?=
 =?us-ascii?Q?jOVh+ONdeeVouQhDt25VCOdM7tyA58duZsVH+56Xe5W8N3JM7yILLK/P9V7D?=
 =?us-ascii?Q?OyZXW/m3PSLyxe4kvAL7Lnryv1/pV7FQJPWaod2OLXQqmRYtdQjj4CHrgJLZ?=
 =?us-ascii?Q?uNM14+VQXdaHG2RwhVCWmwu2iP2EdEqyRw1KJfisCPmvUTTnUhWjC+jOE2yP?=
 =?us-ascii?Q?d97bPKQgmuafumdGC1cuCOGCI5DH8MUX+9pLghll9+/aiUtQ75go2jyQhNci?=
 =?us-ascii?Q?8ucFd/FZNJJwNN9AEYSewzZH8vK7LLuicRrKSdmq7TpeKFaPNOzoWM3BPq++?=
 =?us-ascii?Q?5eiDTb9tW7ykvL4uZgCopmrCxqZcXTXd6cRlI7ZnEFmI7avcxKhT5AO1IrQ3?=
 =?us-ascii?Q?UmGKHfPJ3vIaGKlngNRlLt6TdyFkq6ZAHsWgUNVByTjPnyqUSh5JZLZ2O7rB?=
 =?us-ascii?Q?k2gVqoYGhD+vN5IHZSsqHoKLgC9gq+e73OC3dU/jXYgexfoov9SdTcBFjPcT?=
 =?us-ascii?Q?MUmqUIJE9JyMjHE7ogQobLYqJUB1KN9j6LMDy+gIC8Si1ontbR2dbRmXsGAZ?=
 =?us-ascii?Q?bymr/pthbhxacCdfKWHulpiPkAksaWbBTvHjix4QrZDf8nnmI7o/zRM3gN6k?=
 =?us-ascii?Q?r2KVSV8fgzd2++Bo0ubwdrlP1q2I4tpih+xejlD8d60221oKRAHKnjSvSZ5L?=
 =?us-ascii?Q?73wzjAgX5dvNEySnSHYn/9suYWznaCXKJe2c1Ht9xc5fqaonROYMwtoI/Z2D?=
 =?us-ascii?Q?ksAQmLaiGpHr1YL4ImVl3TMDPqRIhMfv7Uxs9WfBlA9EY4FQ4dKo5Tt4MYhq?=
 =?us-ascii?Q?juy7kEGaLctG8j/DupWl0qAJZIVwEd9bnKLvEBd7u0XCdS0znFdcuXR0PpLW?=
 =?us-ascii?Q?teCrhAyf3HUBFIy2VGQmskUvD1PVx0NB+JGxrN97Okmvf0p/x/Vw1qNCsx50?=
 =?us-ascii?Q?99ePkMw56adMhy6XQJXl4i1aC3y1hkuRP4OFlJ5TwvgkyoyIe105l26mSVRZ?=
 =?us-ascii?Q?tF/Cg/0fesQDi4RKFO3mYZ9kTj2GGhf6M2Cpr90sUtRkY2ooNnhWfYFjAJwT?=
 =?us-ascii?Q?wAIATqJlLuKQYgn9b+bpb3viIYQzYU9fo9zbBu+LE2PZG0DQbTDdJae7Ez8u?=
 =?us-ascii?Q?5E2pG+5xwCD8j8TERet3eC620BiCT5M0Fk/G0nHdMkYjg/As20SfcUw4GFbl?=
 =?us-ascii?Q?u2e0Mq3zp+labfAYvE4MWBLyoIax4GJR62MaVZdyOlAhNdaAFgTo9WekRdIY?=
 =?us-ascii?Q?70e8REqTCw/T0JhgS16ohdtlZwijHu29FOXPsONFv7u1VnFH0UjXIPnwO3CM?=
 =?us-ascii?Q?W+ELlSnLKgMHpUkFa0/PsdATCDuAGNKCo9UBUfnu11fw+XT18PAfJwqf62sv?=
 =?us-ascii?Q?94+47ehOuoE71JeYVAD5QNyTOGa/G0U0CLd1lC6uNw3qLFMCBNQspfv/Slgp?=
 =?us-ascii?Q?gjWFIyVJqWM2pbn4tkmz/pcdrdlnud/xmeCZ+q22Z4EGpRbEED23jcCpwCfs?=
 =?us-ascii?Q?42/8pKlgDJ6cutAFNxaQb8sq2GBUZVrAu52G2zeFw9QeV6OHfCV5Yl2CY3+E?=
 =?us-ascii?Q?JdIT2gHjIEMrfiqsNfgWcleKvvzd2joM9BQ61FYDjqEVitcadSFS1IWUGPpb?=
 =?us-ascii?Q?fFUwhQ37Rg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68396378-36e4-4eb0-7db6-08df28877775
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:37:20.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJvLYoje5WWr9iYfnt+ye1SKE/2Akw51RYe915eyHNgn7GqOIjtPWfMfmej+D70iBNwXn2/CRLRniggsv+xXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Add a driver for the SPI controller channels of NVIDIA LSTP USB
adapters. Each channel is registered as an SPI host controller; devices
behind it can be described by device tree or ACPI, or created from
userspace through the controller's new_device attribute. The firmware
reports the chip selects and the bus speed.

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 MAINTAINERS            |   1 +
 drivers/spi/Kconfig    |  13 ++
 drivers/spi/Makefile   |   1 +
 drivers/spi/spi-lstp.c | 316 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 drivers/spi/spi-lstp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 082c4b3a0eb6..081e3f32c840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19580,6 +19580,7 @@ F:	Documentation/firmware-guide/acpi/lstp.rst
 F:	drivers/gpio/gpio-lstp.c
 F:	drivers/i2c/busses/i2c-lstp.c
 F:	drivers/leds/leds-lstp.c
+F:	drivers/spi/spi-lstp.c
 F:	drivers/usb/misc/lstp.c
 F:	include/linux/usb/lstp.h
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a0f37e2df716..e76abaac825c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -694,6 +694,19 @@ config SPI_LJCA
 	  This driver can also be built as a module. If so, the module
 	  will be called spi-ljca.
 
+config SPI_LSTP
+	tristate "NVIDIA LSTP SPI support"
+	depends on USB_LSTP
+	default USB_LSTP
+	help
+	  Say Y or M here to support the SPI channels of NVIDIA LSTP USB
+	  adapters. Each channel is registered as an SPI host controller,
+	  and the devices behind it can be described by device tree, ACPI
+	  or created through spidev.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-lstp.
+
 config SPI_MA35D1_QSPI
 	tristate "Nuvoton MA35D1 QSPI controller"
 	depends on ARCH_MA35 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a18814fbde93..c0b1ea6491dd 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SPI_LOONGSON_CORE)		+= spi-loongson-core.o
 obj-$(CONFIG_SPI_LOONGSON_PCI)		+= spi-loongson-pci.o
 obj-$(CONFIG_SPI_LOONGSON_PLATFORM)	+= spi-loongson-plat.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
+obj-$(CONFIG_SPI_LSTP)			+= spi-lstp.o
 obj-$(CONFIG_SPI_MA35D1_QSPI)		+= spi-ma35d1-qspi.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
diff --git a/drivers/spi/spi-lstp.c b/drivers/spi/spi-lstp.c
new file mode 100644
index 000000000000..7aa908e6c398
--- /dev/null
+++ b/drivers/spi/spi-lstp.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI driver for LSTP USB interface.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+
+#include <linux/usb/lstp.h>
+
+enum lstp_spi_cmd {
+	LSTP_SPI_CMD_READ = 0x01,
+	LSTP_SPI_CMD_WRITE = 0x02,
+	LSTP_SPI_CMD_WRITE_READ = 0x03,
+	LSTP_SPI_CMD_POSTED_WRITE = 0x04
+};
+
+/* clang-format off */
+enum lstp_spi_cmd_cs_toggle {
+	LSTP_SPI_CMD_CS_ASSERT = 0x20,
+	LSTP_SPI_CMD_CS_DEASSERT = 0x10
+};
+
+enum lstp_spi_cmd_cs_sel {
+	LSTP_SPI_CMD_CS0 = 0x00,
+	LSTP_SPI_CMD_CS1 = 0x40
+};
+
+static const u8 lstp_spi_cs_map[] = {
+	LSTP_SPI_CMD_CS0,
+	LSTP_SPI_CMD_CS1
+}; /* clang-format on */
+
+struct lstp_spi_read_req {
+	__le32 len;
+} __packed;
+
+struct lstp_spi_config {
+	u8 num_devices;
+	__le32 speed_hz;
+} __packed;
+
+struct lstp_spi_priv {
+	struct spi_controller *ctrl;
+	u32 current_speed_hz;
+};
+
+/* A transfer without data still sends a zero-length WRITE when @cs_flags moves CS. */
+static int lstp_spi_do_transfer(struct lstp_channel *ch, struct spi_transfer *xfer, u8 cs_bits,
+				u8 cs_flags)
+{
+	struct lstp_spi_priv *priv = ch->priv;
+
+	if (xfer->word_delay.value)
+		dev_warn_once(ch->dev, "%s: ch_%d: word_delay not supported, ignoring\n", __func__,
+			      ch->ch_id);
+
+	xfer->error = SPI_TRANS_FAIL_NO_START;
+	xfer->effective_speed_hz = priv->current_speed_hz;
+
+	if (xfer->len && !xfer->tx_buf && !xfer->rx_buf) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Transfer of %u bytes has no buffer\n",
+				    __func__, ch->ch_id, xfer->len);
+		return -EINVAL;
+	}
+	if (xfer->tx_buf && xfer->len > ch->max_tx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: TX transfer length %u exceeds capacity %zu\n",
+				    __func__, ch->ch_id, xfer->len, ch->max_tx_payload);
+		return -EINVAL;
+	}
+	if (xfer->rx_buf && xfer->len > ch->max_rx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: RX transfer length %u exceeds capacity %zu\n",
+				    __func__, ch->ch_id, xfer->len, ch->max_rx_payload);
+		return -EINVAL;
+	}
+
+	int ret;
+
+	if (xfer->tx_buf && xfer->rx_buf) {
+		u8 cmd = LSTP_SPI_CMD_WRITE_READ | cs_bits | cs_flags;
+
+		ret = lstp_request(ch, cmd, xfer->tx_buf, xfer->len, xfer->rx_buf, xfer->len, NULL,
+				   NULL);
+	} else if (xfer->tx_buf) {
+		u8 cmd = LSTP_SPI_CMD_WRITE | cs_bits | cs_flags;
+
+		ret = lstp_request(ch, cmd, xfer->tx_buf, xfer->len, NULL, 0, NULL, NULL);
+	} else if (xfer->rx_buf) {
+		struct lstp_spi_read_req req = { .len = cpu_to_le32(xfer->len) };
+		u8 cmd = LSTP_SPI_CMD_READ | cs_bits | cs_flags;
+
+		ret = lstp_request(ch, cmd, &req, sizeof(req), xfer->rx_buf, xfer->len, NULL, NULL);
+	} else if (cs_flags) {
+		u8 cmd = LSTP_SPI_CMD_WRITE | cs_bits | cs_flags;
+
+		ret = lstp_request(ch, cmd, NULL, 0, NULL, 0, NULL, NULL);
+	} else {
+		/* No data and no CS change; only the caller's delay is left to do. */
+		ret = 0;
+	}
+
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err_ratelimited(ch->dev, "%s: ch_%d: Transfer failed (%pe)\n", __func__,
+					    ch->ch_id, ERR_PTR(ret));
+		xfer->error = SPI_TRANS_FAIL_IO;
+		return ret;
+	}
+
+	xfer->error = 0;
+	return 0;
+}
+
+/*
+ * CS edges ride in each transfer's command byte rather than in a set_cs callback, which would
+ * cost a USB round trip per edge.
+ */
+static int lstp_spi_transfer_one_message(struct spi_controller *ctrl, struct spi_message *mesg)
+{
+	struct lstp_channel *ch = spi_controller_get_devdata(ctrl);
+	struct spi_transfer *xfer;
+	u8 chip_select = spi_get_chipselect(mesg->spi, 0);
+	int ret = 0;
+	bool cs_active = false;
+
+	if (chip_select >= ctrl->num_chipselect) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Invalid chip select %u (max %u)\n",
+				    __func__, ch->ch_id, chip_select, ctrl->num_chipselect - 1);
+		ret = -EINVAL;
+		goto finalize;
+	}
+
+	u8 cs_bits = lstp_spi_cs_map[chip_select];
+
+	list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
+		u8 cs_flags = 0;
+		bool is_last = list_is_last(&xfer->transfer_list, &mesg->transfers);
+		bool no_data = !xfer->tx_buf && !xfer->rx_buf;
+
+		if (!cs_active) {
+			cs_flags |= LSTP_SPI_CMD_CS_ASSERT;
+			cs_active = true;
+		}
+
+		if ((is_last && !xfer->cs_change) || (!is_last && xfer->cs_change)) {
+			cs_flags |= LSTP_SPI_CMD_CS_DEASSERT;
+			cs_active = false;
+		}
+
+		/* A data transfer fuses delay and CS edge into one command; CS-only waits first. */
+		if (no_data)
+			spi_transfer_delay_exec(xfer);
+
+		ret = lstp_spi_do_transfer(ch, xfer, cs_bits, cs_flags);
+		if (ret)
+			break;
+
+		mesg->actual_length += xfer->len;
+
+		if (!is_last && xfer->cs_change)
+			spi_transfer_cs_change_delay_exec(mesg, xfer);
+
+		if (!no_data)
+			spi_transfer_delay_exec(xfer);
+	}
+
+finalize:
+	mesg->status = ret;
+	spi_finalize_current_message(ctrl);
+	return ret;
+}
+
+/* spi_setup() path: firmware owns CS, so cs_setup/cs_hold/cs_inactive are only warned about. */
+static int lstp_spi_set_cs_timing(struct spi_device *spi)
+{
+	struct lstp_channel *ch = spi_controller_get_devdata(spi->controller);
+
+	if (spi->cs_setup.value || spi->cs_hold.value || spi->cs_inactive.value)
+		dev_warn_ratelimited(ch->dev,
+				     "%s: ch_%d: CS timing delays not supported, ignoring\n",
+				     __func__, ch->ch_id);
+	return 0;
+}
+
+static size_t lstp_spi_max_xfer_size(struct spi_device *spi)
+{
+	struct lstp_channel *ch = spi_controller_get_devdata(spi->controller);
+
+	return min(ch->max_tx_payload, ch->max_rx_payload);
+}
+
+/*
+ * Device tree lists peripherals as children of the channel node, so an empty node is an
+ * incomplete description. ACPI resolves SpiSerialBus() resources from anywhere in the namespace,
+ * and the SPI core enumerates nothing from a software node.
+ */
+static void lstp_spi_enumerate(struct lstp_channel *ch, struct spi_controller *ctrl)
+{
+	if (is_of_node(ch->fwnode)) {
+		unsigned int child_count = 0;
+		struct fwnode_handle *child;
+
+		fwnode_for_each_available_child_node(ch->fwnode, child)
+			child_count++;
+
+		if (child_count == 0) {
+			dev_warn(ch->dev,
+				 "%s: ch_%d: Firmware node present but defines no SPI devices\n",
+				 __func__, ch->ch_id);
+		} else {
+			dev_info(ch->dev, "%s: ch_%d: Firmware node present with %u SPI devices\n",
+				 __func__, ch->ch_id, child_count);
+		}
+	} else if (is_acpi_node(ch->fwnode)) {
+		dev_info(ch->dev,
+			 "%s: ch_%d: ACPI describes this channel; its peripherals resolve from the namespace\n",
+			 __func__, ch->ch_id);
+	} else if (ch->fwnode) {
+		dev_warn(ch->dev,
+			 "%s: ch_%d: Software node describes this channel, so no SPI devices are enumerated for it\n",
+			 __func__, ch->ch_id);
+	}
+}
+
+static int lstp_spi_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct lstp_channel *ch = lstp_channel_from_auxdev(auxdev);
+	const struct lstp_channel_init_info *info = dev_get_platdata(&auxdev->dev);
+
+	if (!info)
+		return -ENODEV;
+
+	if (info->config_len < sizeof(struct lstp_spi_config)) {
+		dev_err(ch->dev, "%s: ch_%d: SPI config too short: %zu < %zu\n", __func__,
+			ch->ch_id, info->config_len, sizeof(struct lstp_spi_config));
+		return -EINVAL;
+	}
+
+	const struct lstp_spi_config *config = info->config;
+	struct lstp_spi_priv *priv = devm_kzalloc(ch->dev, sizeof(*priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	struct spi_controller *ctrl = devm_spi_alloc_host(ch->dev, 0);
+
+	if (!ctrl)
+		return -ENOMEM;
+
+	u8 num_devices = config->num_devices;
+	u32 speed_hz = le32_to_cpu(config->speed_hz);
+
+	if (num_devices == 0 || num_devices > ARRAY_SIZE(lstp_spi_cs_map)) {
+		dev_err(ch->dev, "%s: ch_%d: Invalid num_devices %u (max %zu)\n", __func__,
+			ch->ch_id, num_devices, ARRAY_SIZE(lstp_spi_cs_map));
+		return -EINVAL;
+	}
+
+	if (speed_hz == 0) {
+		dev_err(ch->dev, "%s: ch_%d: Device returned SPI speed of %u Hz\n", __func__,
+			ch->ch_id, speed_hz);
+		return -EINVAL;
+	}
+
+	spi_controller_set_devdata(ctrl, ch);
+	ctrl->bus_num = -1;
+	ctrl->num_chipselect = num_devices;
+	ctrl->transfer_one_message = lstp_spi_transfer_one_message;
+	ctrl->max_transfer_size = lstp_spi_max_xfer_size;
+	ctrl->set_cs_timing = lstp_spi_set_cs_timing;
+
+	device_set_node(&ctrl->dev, ch->fwnode);
+
+	priv->ctrl = ctrl;
+	priv->current_speed_hz = speed_hz;
+	/* Registration probes peripherals, which may transfer at once; transfers read @ch->priv. */
+	ch->priv = priv;
+
+	int ret = devm_spi_register_controller(ch->dev, ctrl);
+
+	if (ret) {
+		dev_err(ch->dev, "%s: ch_%d: Could not register SPI controller (%pe)\n", __func__,
+			ch->ch_id, ERR_PTR(ret));
+		return ret;
+	}
+
+	lstp_spi_enumerate(ch, ctrl);
+
+	dev_info(ch->dev, "%s: ch_%d: Started as %s (devices=%u, speed=%u Hz)\n", __func__,
+		 ch->ch_id, ch->display_name, ctrl->num_chipselect, priv->current_speed_hz);
+	return 0;
+}
+
+static const struct auxiliary_device_id lstp_spi_id_table[] = { { .name = "lstp.spi" }, {} };
+MODULE_DEVICE_TABLE(auxiliary, lstp_spi_id_table);
+
+static struct lstp_auxiliary_driver lstp_spi_drv = {
+	.adrv = {
+		.name = "spi",
+		.probe = lstp_spi_probe,
+		.id_table = lstp_spi_id_table,
+	},
+};
+module_lstp_auxiliary_driver(lstp_spi_drv);
+
+MODULE_IMPORT_NS("LSTP");
+MODULE_DESCRIPTION("LSTP SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

