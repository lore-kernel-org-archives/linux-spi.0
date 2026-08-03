Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F041A4E7;
	Mon,  3 Aug 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760871; cv=fail; b=tvKPrPGKdfqynWAGFI6k3JkCYh/atA4L/fuGIQy9Hwmi9NNIK3lM9exR6AN2Uu3BZSJzwbyFwttbmeH/frVhmK42vaa210Mko4WuGgT9+OlmbOcmFt6Qg3Ib4WUkqwPNExM+rI8/Dq1IRvUwayI5bkxaMVoYPWH2a2qEIYvFd34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760871; c=relaxed/simple;
	bh=x8bOY7B/r9n4+ZArqs6SOcqk7MvPqLBuk0k1Gz0/hrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwGdwv6L1YQLjS9rsVkBHHnCzo5gONHwaRjkAQjm39QcVa2JG4WWeAVdFedkk4ABZFBeIob/RhADMOFSDkEvAFsC8CPOsSRwvYPNFpoq+MPsGswcPTvDch2+bg2J1Sm7kGXYcbq2tpKkDrP59SOW6SGCQkPBk5fAZzLSSPCEiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZQltensakqEH3dABziASRaIodXwkHEEO3XT4/6Ev6ieBSgvqBuDvqe/ogRCmycoygZ8VS0uE+koT1QPX7IebQI5UdM282Naza1VrOmlRfybVMQ4TONt4WGyo/oSOCmhH+2kKbZwzpfJEX65Q5aUPjt+TmAnOobEJ0J/OCeMuj4NnB2dL/Mx3YrK5ynw98HEwpGRF1w3MYQIO7O8jDsL25B1bYMQ/8E5Ve1m6oaSIYsWAAjvLTAo8nEwvcLbS3rOehZFWOUPiYDyU/zeYqKLsihrBt534D/ZwHameM/WtlmbYDgjoj7j8bYHVpXsrz0bqPID+RdQUjajqrhXORALbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTyS+EFu07iONfpbFsR138tEe31ooOx5os0vHylDYMU=;
 b=RVI32GvapD3K86iqPG25O8+PeDV369clAiCUF5Xj64phnXMsiGAvRaQjwx3Lr7lsNlDPOVR6eyxwZqjNLNcE7X/CXZ1vphyKlUK2A8LEmRY4yhChoAclo73bqqhHw8WcPohVaQJVzMtpRLe91ZkQVjr1SSh6hLpzh/6b1e561j3Ce63J5tEy22EFLbPp9wFll/4QwB8gJx1OpQWHG/1X/5Ed5unevQnZINInA/ThJgNu/uqBjvaHFNwq7FLx/nCF+kOAJu5bUUcF7dFWS32DfMe/brGIjfBCsj8J0cg7O+EhcWYZ3cn+XWLh1wVG8x9EmrcwkzeU8WU2Oz1mfedPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:40:54 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:40:54 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 03/11] spi: dw: add check for support of enhanced spi
Date: Mon,  3 Aug 2026 05:40:36 -0700
Message-Id: <20260803124044.156998-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
References: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::32) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a19ada-5003-452a-aec2-08def15c758b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cmTokfzyGqagx/JGK54oj288F8odkLw9hFIoKqj0ylPcnj6r/EXdUgTzHWHJVD2wxP0TmHP/pm35GQO3/G4VhLxVHtWNWEiMUXkmAg3/3XvXfm2PPADs9dD+04CZjOhtzEoaYa1siFJbJ7D7DPiBDeBTixFZQYGYHJHYCM7Agt1eyBxF7arft4X2vfdOv+cJI0VOOtfn51iq1b2n1lluCVLiKKdk5IuKLgVTBBsBebVutn8cD0FVDrwMyugzwy1TUhPFNbGEd3UNf/To5s9ZcXUQtB5VHi7nFW4Zv6abUPoPN3NQc81RUAHSsPLSNdL00nyCqFBTlaS7YqZ2/Zx7zfTKFavMdP1U359ZgvZcN1fbqLJo3JaGcOwo7gdzUWP/M0GRhrMoq6sBObaLdc6+zhTUHMRDmjgyurqOwpNbODJcHOUW/xKUL11bDgdyISR9dA4lgMRV2l5IxTPz6keH2vCl/51ibiwSjE7/UgXloDfJ8biMLEJohiAhAFBQJg3jn4K1jZMd5exvSKzXkPUmp5H1Wm8KKhtMrFxzmwOPMqNAnsj0+Ba9nYr6EnV38ulL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hvdaa+jgPij7Ink+B/rFFZ6/SiYiVVWx839CbWdLKqC3ooJQCyaWX9BTUJE7?=
 =?us-ascii?Q?Lo8VHGo2DMON31YMrsvTvzQ0SpubEAFoX/MaoHzeL6n47v4wgWB7eKka6/Y+?=
 =?us-ascii?Q?jRzOKrz3XJzUKIjcTve5TmbjiQMl9qkLYqZ+DO3MCU1MON5bnMX7qWKXalkh?=
 =?us-ascii?Q?PZZu99aLcbuQByKJECEF14MAg0zz53/MNKTrK9SJAeCPVvZbcrdxPMENUFSl?=
 =?us-ascii?Q?m0MuJGSAL1lz5IC5UPuEiOX7rX3gw8tZpH9smfDUg2MK1bdcM+MTfhUpbjgM?=
 =?us-ascii?Q?b4RSuhDb5f6BmSCU+thUR8ZO9VoM2U+j8zvEkvQJUQ3sj/IUgPMMkM1P+62w?=
 =?us-ascii?Q?LOqPqKdO1/YuNiHbKDEkGAbv4RhE4N2xBj1bsc1189Zb/iN/yx3rn5n98YD2?=
 =?us-ascii?Q?aFypFYAN9Qcs/6X3Q8qAaP67tY22QV39Az7WKVTcKU17j8+JiwxEmaL7NbP/?=
 =?us-ascii?Q?BHvn/NsgAVvXcv9TZqnuia/HufF/vu5gUE/gAWEU7mDDc2KGxZnkaYpJX1j/?=
 =?us-ascii?Q?N94nfwsq9bCed5FW3tcwtZBDaoynT872tcPKLEOSGRkOn8Tj74rQcdEZoqMY?=
 =?us-ascii?Q?0MbUaHH5o4LOc0iBdLMS0VxkByycgFYt8Xb2wOv+rVLmbpcah2VuHulH4WVu?=
 =?us-ascii?Q?7PLUy4NBrVzjsvykOBSOvto5gPJu4uBQKcAxV70UUa1BKwLdVbN5LrLXxuvV?=
 =?us-ascii?Q?QtXbeBKGgOxVGWMcLfq2ioyOBD76GoLaJ726N6nuSVedx+YrhXfBMsDwnK06?=
 =?us-ascii?Q?b2mE220Iv/oXuG3Dubnz02noJ2XozChdH7jWcdRIua1uLYiPBFJUesQavjvT?=
 =?us-ascii?Q?z76V44ZXTVo8WDDYww1GbPlYabcE7LWN1oNy7r3z7WITuHbBGNq66h0iuSZp?=
 =?us-ascii?Q?RsPgY2aicjLcwqE8DbCnDcaQm2aYMWpIeVE4pjmzCIBZ0dwdMpUsgMSFc3xC?=
 =?us-ascii?Q?xpyyyOZvV11IXYk4JyYV94vrQ/jvhjglNCZx2qEsmbSUjMbwHuloPQzgom9t?=
 =?us-ascii?Q?C9fuvocpr4uNu3vfNEKGhlIghRxkje7JbDBfH9TeZlSUKBywQwzBMNBQTsni?=
 =?us-ascii?Q?HRoDTyLtaehsSd/TrdpCcNem/MrAYDiQo4nuHy+eGQOkOkIPUiY1GEIC93qJ?=
 =?us-ascii?Q?CHPuC+lTcC5Z4esiGUQ341IoXLvX3ASJ+4htbYU6p4l2Ma4cHbmx7GnQcBer?=
 =?us-ascii?Q?rUKf5pTZVJCSwU7yw/tGZ/WPYylHlpqruT/5TjdvT2dxXkrqMHITz2MdoVbF?=
 =?us-ascii?Q?Bjw5d0UbI3Y1YAVKDb63K4v/23sK37t1zv5Ci6OV+XPv2RumS+7+WPL98dvz?=
 =?us-ascii?Q?qKH5bF4E1P4hVmCU24N+MlfbrK64k+6in2Mxk1qJGDkPPBgv41oVpg1Zp3rN?=
 =?us-ascii?Q?3MzY9yRiuqfVkUnrQ7t+0SK5VhrROOZmRAQnzEjmYXfrjOkDxlwVpTV7ctuz?=
 =?us-ascii?Q?sOMWGcSu2t+UkcmL8CIHKW9Y/gZOOPsaGHzzApUsVCgb9p8f0VkNpyDPCc0u?=
 =?us-ascii?Q?U8UzHO4giCCVTiiG0AgkAIuPgtKHTwiS2CY4UuwiodxvGq9npPEHjF0Pk7AG?=
 =?us-ascii?Q?Mz6r0Di7xE9gVkyZkcqgHjDysYh7UQYRwYVJ85OW9K36iCoJz7Vo9PwTWE9A?=
 =?us-ascii?Q?Fkvtan12los2SsQV7BgQHbPMEOKcm2YOLG44cKORe1yX9kI0jLgf7uAE8M4U?=
 =?us-ascii?Q?sdQNg+qr5T9bcJT6vPGaLAVJEMvNew5sak1JR7CXZSW0QvDhUKspyIDmFUno?=
 =?us-ascii?Q?GpiTXRMvArlcFpc3Lko8XcgH6K15+Czp4Hup/qgHLDscXlzZbOjV?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a19ada-5003-452a-aec2-08def15c758b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:54.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OyJLoLgqB3SIuFIkABL/yvekhsP720HkS3RO5v+7qkJPQ3YWKaNk5I88W6HOPwBVgjcDHwdbLGcWxa2Dl6bsKvg2eKMUPDWsj7hbkHurGtx8+H8j662DTBS1T9CrS9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

Before doing the mem op, spi controller will be queried about the
buswidths it supports. Add the single/dual/quad/octal if the controller
has the DW_SPI_CAP_EMODE capability.
The DW_SPI_CAP_EMODE capability will be enabled in a later patch.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 7601a53d6f34..7275b7a9945f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -518,6 +518,35 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	return 0;
 }
 
+static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
+				       const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 0 && op->addr.buswidth != 1 &&
+	    op->addr.buswidth != op->data.buswidth)
+		return false;
+
+	if (op->addr.nbytes >= 8)
+		return false;
+
+	if (op->cmd.buswidth != 1 && op->cmd.buswidth != op->addr.buswidth &&
+	    op->cmd.buswidth != op->data.buswidth)
+		return false;
+
+	if (op->dummy.nbytes && !op->dummy.buswidth)
+		return false;
+
+	if (op->dummy.nbytes != 0 && op->data.dir == SPI_MEM_DATA_OUT)
+		return false;
+
+	/* WAIT_CYCLES is a 5-bit field in SPI_CTRLR0 */
+	if (op->dummy.nbytes != 0 &&
+	    op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
+	    FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static bool dw_spi_supports_mem_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
@@ -800,7 +829,10 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
-		dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+		if (dws->caps & DW_SPI_CAP_EMODE)
+			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
+		else
+			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
 		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 16a8c7ab7364..81a433ab759b 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -35,6 +35,7 @@
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_DFS32		BIT(1)
+#define DW_SPI_CAP_EMODE		BIT(2)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
-- 
2.25.1

