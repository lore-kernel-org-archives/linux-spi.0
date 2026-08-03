Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D141D136;
	Mon,  3 Aug 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760880; cv=fail; b=rTfpRXrrpzlaYr0PGRf5nckCMBEGd8HoY8Gj992Z7Ehv34VYYTFvySoii2b38SUEjpnO7on+Iq5Ut1T1yshTDS8TKe00BCG5HTIl4tTAGMeY2SpQowljlbWo87t1DXqm60eHVY/aygPVVirPpjhBXlVMdkg8TOKxaVnW5TLG6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760880; c=relaxed/simple;
	bh=WIyS6N4kZ9J01IWaTN27B4z4H33W+Cv1avgaKr6C5vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDtLjGWA1vqfF5c5YqEmM/ADKtWCIACePpnm+RmL4JDppGzN2UXE3MWl/7qRJ9TeHU9w2pGPKoSOkHY6FO7E+MKQFlmG6qrSuWRwldxkJhhaMuB+RuZfBDipsC5wnlnCliidI4OHeSn8yd8cAHRovtuRSNEvgKYpQ/btxVT2Vzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB0/8NShepMXGVIdWhOEBcc8IeiQ06TjH2/PuPQ5ToDLR1wdo4RLV9wkde0Qs9QbZEjktRa6xYUAdyCOwt4pDVCaefQovxjomvVpr/cjyCbYIdBFjtod/OFtRkNoPGAZCdwzhLiCaYOOy/I4umAWVecQxIchQwcomF8NU+hu1Z9MAHTdWCBEMxFtpvqGjg5FWHmkk2S/qHuruGqKqvTE/wXZXhISYcaDuar0ci9lR4RYj+Mg5shlfAmlLRPrd3kEZ8Or2poPI5XD8dtr1OqEAjjRB6m82SVC+jZYbY+J67c+yzb2bCy861aJ9olZ5eHqBTmNmb0Mgz3HU1XeWdjZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=366m3Qd/ezN3ppXMtSo2MVy6dG7oOIcB5YQdKlBxGBA=;
 b=ID9sFZUfBMDeg07AbfH443m1JmBU19GaSsCHZLLiU+1GedlSbtKljeTvYexYVtl3ce9gDf4JPwFu2fUyl2IaZsnb9x6CBYYSBuiosHZnG66/xRcKJH5M99brEoG9IHdhcFxeDi06pTJEwN8jCrj3AOhHjXtwle+DTik6Qm/RcOU6FLkQdY67CziO25tuprECiR/6B2QWtTIwOstZ1FQ6+v5SwYpwYB8kof6aSCvzygrq745I4hAuSXeqDPDCgRzXyBzhPKRh0jwGwqmRsswv6gHwoynaodepq6v4MsuOjgisgPQ31BQ/I1E16AcacBCD7mGZYrws3qVuMd813EScfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:41:04 +0000
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
Subject: [PATCH v2 07/11] spi: dw: send cmd and addr to start the spi transfer
Date: Mon,  3 Aug 2026 05:40:40 -0700
Message-Id: <20260803124044.156998-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77aeb012-ac54-42d4-ef01-08def15c77ad
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2uNgIjyHxQ91/aSoKjjDp4YY3yZ/4a5YQLvRQaofWmBctav8/OQp5VyQywuXolHvKbKT8F/utGcRW9XrQzFpEJImyy3bWF4csoq1t+meteCHC4snVIkjwC6Hvywb28la7Vso6I4P8+RCsCkDEeUSeRTFtaZxWJv9tHt0Af6rJSQ3lL0cVUKeUb7hlFcIrryAM22UnqvhQjoK5LdnY2+2HcfkzxNy3jXmZYDgJD4/Zy91BsAGsZu49sxcl5hf2x/Fq/z8IG/ad9cWttGi6Ir2oB2G8vYxazYPmN1Mt1mlxCPgJTXwpMzVeREFNGliPcaGzkQKoCKKBam1U4r2YC88ROTSmnsJno/kwjYAs0akCO6hsFSTYU7YUloQzcSTyzUvz51u9w2m9E4qRXf24AwrAUS6QuYuz8rG2R0MZjGN+GbAzsJH+esMg+DUWtMW3/3rIxEQtNzndqmxb5HvmgwnOj16mmolevPAStFNPLZS398z3uVgoaryWhns4OJxsZvF7kB+Pv8bwp6oAKtf9eyObZ67oByhwg0a9kbN1hcPvaBVTGSNm1wELuxxkDhkCCgY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmQWnfE3SfQSZr9cdA1mJn1+Tz/TPFgfRim1KlSL15qw2F3+wEnX/XEkfele?=
 =?us-ascii?Q?wPN3zV6KdWRIETcVNiSIiw/qoor+PBapNAe4lJfWJGbnsUktkGQ4V78Jha/a?=
 =?us-ascii?Q?aX1IKqnhC6YK808ZfWTtVjAfN5FsIfopbAkNpj+dkZ9dj7o7YPruNs54jAno?=
 =?us-ascii?Q?/oD2QAJaQ2i+qGdNNzDdKmouI+Qr5EaHBChCSpxa0mWeBhRQFha8vm4JNtH4?=
 =?us-ascii?Q?w6wtUFSOrBU+jwxpeKqo/PHh+IJVmLW0g+OBJlF1JGv3gcLfJD4uZVfilbG4?=
 =?us-ascii?Q?NEVcAZU5PTHHqWeyR7vQ6FJSbs9p5K69zdQd6tCuBfmwbUz0NcoQ4pzSSQo+?=
 =?us-ascii?Q?YaVd7W1nuimvbfzXmY+pkOuJtAPjLdAfuMBdmwqeLSMbXw6XmaKhKp76cHCr?=
 =?us-ascii?Q?v82f3n1CwFkYIUw0UivtG4B4iIK+M9bcx8Qx/lzcqhX47I6r+yl6xFUdhXSg?=
 =?us-ascii?Q?/Lx1bxFK8/gkjqIFA9wt6qUEGDTaHYGqQtS85WdNtTim7ITDwC+Hu+gJ2gqP?=
 =?us-ascii?Q?49EHr2NrARqNMtDaaBLMsuQK46PKvxPVVSamARscT3MXi953aIfviXe3sp2U?=
 =?us-ascii?Q?Hvqi/toYArnJbmafBLSmug7xvHgpJDN+7xAtSqJMDDca69kH5UlSGDViTHX5?=
 =?us-ascii?Q?3jyzrcbQ8Cg71LdLFhRSsxw0tR/hjAz1AumokhyNG0QrhQQb5QNWmHvzfMf5?=
 =?us-ascii?Q?nraEoJoPc5NPR6GbcoVeK+eYwG4CBUt/KLgF4tqzdRkKxZjC2k4Bw4vnk7BG?=
 =?us-ascii?Q?aYi/0W3dfB6QDIKSd8poedo+w6rjCXhQQGGQHQDAfhXtjYgQ9zSxyCb0Qnmg?=
 =?us-ascii?Q?1nizmLhM2LLB4ZXZ2rz628E1edCaeOZ7l0qodGDMmEWlqe1xyKxYE/IMzC+m?=
 =?us-ascii?Q?sF2HGHccOAttxOsvs8DWnG+miop7+rAlc20ZuQD5GAB4/tU+f0qaKJIXpPY/?=
 =?us-ascii?Q?+QyhwKUWw8y+3l8txL9WH7Lvu1cNt57Jy4zVCtTzQHkQRizoAgpdkkSCOo0u?=
 =?us-ascii?Q?K/wW/05URDjotkU2IlwQEESCds92EOtaiQfiwYRinZ0k8kUE3fgZKy1NvO8o?=
 =?us-ascii?Q?OYO5kTIlujmoSQBgrue69Ine4lBob0lxNJCXNCPREhohDr7+FE6hpfGQQFHk?=
 =?us-ascii?Q?JtWyoQi4Z36+3D6gHiVnO7c5ebMHnl6VLYuNphmo5S0G8B+6YumiYcBQh3tQ?=
 =?us-ascii?Q?e2VwmyoNpBDR1Qsyv6W+D4Aj+VfTBQcArOf3ksO18gm91ON8DsJpDn6NSj9F?=
 =?us-ascii?Q?jCmGouf8xJW1y/U/XB0C8aS1ZN9OwuC7YwnPBujjhbiOroePz5ItxXxLrQmm?=
 =?us-ascii?Q?xf1HKCqPzrTIKSWwVuKeh6kUo4h7+0Bww/2ZenQVaImw9qqoGzCWOuZmHyjH?=
 =?us-ascii?Q?JbWYP1IliJyYyal2vcxjINhnNLmmOL498/Fur62rLake4rLJVgaOIMi/2HRx?=
 =?us-ascii?Q?UdT3RfoKKyJ9PpujgAQWTxmH2WJuAzUBUy/3oKW7h+CBXZo89rrt7x8uAGN1?=
 =?us-ascii?Q?ViG8uGcTZhBvDf7wlR5Dq+tnaikfl1VtPMnQu2bEa3HTbeHfr0evbWiEBWD4?=
 =?us-ascii?Q?4gwa2oAEwrtl9+eRjdzBWhBwsaa6Kf7SxBBvJImX5hI6jIlSJmNkJJy4jn29?=
 =?us-ascii?Q?4r3mb7sfUG9dt2+rKNqsXWQe++M/636KKHvKZBJGcjZ43Zrc28KQvYeVHqLB?=
 =?us-ascii?Q?LK+bhpxHB3+VK7ihOz7MoC0dt5PQALHsx1C3WrJzMpcWgiWr4Cwz8s6Xx80i?=
 =?us-ascii?Q?DHOWbvSvcbifG6+qLgTj4P0OIkwaxTdHjZPkc1VCEj3b0md9U0t7?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aeb012-ac54-42d4-ef01-08def15c77ad
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:58.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A+CGTQgpM33gLAq+9Z0j1XcaNSMRG+s8qkUvKMChmOcE61WKF+KR5tUoTlLzD06eWKE9dj7Mix/HyjkCbwObvzEqNvtYwe6Ve3wmyrx6QWuAHkwMulHKoyS+uVUrkBS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

In enhanced spi mode, read or write will start by sending the cmd
and address (if present).

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 7441e8db0ea7..2b3149ac64b3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -849,6 +849,19 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
 	}
 }
 
+static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	/* Send cmd as 32 bit value */
+	dw_write_io_reg(dws, DW_SPI_DR, op->cmd.opcode);
+	if (op->addr.nbytes) {
+		dw_write_io_reg(dws, DW_SPI_DR, lower_32_bits(op->addr.val));
+		if (op->addr.nbytes > 4) {
+			/* address more than 32bit */
+			dw_write_io_reg(dws, DW_SPI_DR, upper_32_bits(op->addr.val));
+		}
+	}
+}
+
 static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
@@ -909,6 +922,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_enable_chip(dws, 1);
 
+	dw_spi_enh_write_cmd_addr(dws, op);
+
 	return 0;
 }
 
-- 
2.25.1

