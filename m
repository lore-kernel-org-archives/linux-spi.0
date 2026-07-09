Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6023AF665;
	Thu,  9 Jul 2026 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596209; cv=fail; b=ZsJBvHIKnv7Us01IhSEy9PIB5+ObUiOMa90vddAooiJCxC5q5z8hmIbkQTpOV9q5iMoSONfAbClES+bt8SmraNbciar2pzfnR8At89hyWTNfjA7Zs1qVNgZ11EoAdbHFxO6mDUVulYjb+YbgitXOUrfbPVZ4KFN5ouae63rTqus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596209; c=relaxed/simple;
	bh=/dwlo+HKG11bv57IM2NFTbD5nvIPlJ0FeqS9dwTrX0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czvAJmAj+O2C4xlAsJCpazS5ZkMcfgTxKiJZicVLREaFrfCXUgRtO2Arfowgnddi9bwodL9lMNHEKcMFqP6IDCgcEIl+eZ2zFi5P7bKBX4mDVYL32DRCN6GEbs2uPZxTCRpIvoF6uAbFRr068y+Tl1hywaHR+j0EG5PKk07WU2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek+8GpIf5T/asJyClM0ahPUCIiyjEOXuLr4VfvgxiXUAhzMdfbLc7CYws27y3NQsAteeeIcs0VlPlIypgAKv/Rj6+T4bFTwhgJCY67dvCSH1+Jl+yQYgDNcWxcrkMlr5lwQZaGB7MqDzYtjfRkSWseaFSaxdkAwuKmb07SKnaEDqCpxWFlNYVWpOp+wtoDDxlX52et+63OuKakV8hnned70NpkB6EAj4FQaowcIgO8gKcAlc0+EYTfTW0a9Kr3HOwFYjrqbFl+V8LumiKMsSE5r194nzSBV7yPNn+GokqOE+CrZ1TFAJhoyyWfUoAgL3fBgk8oIv8l6BKK8V7H+y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2OplIiNX6SWaCfDxn8hAcGzUnPJcCcOIQsmZHsvHZs=;
 b=ORQVLV7rtP+BxtN3onvrUlzoJOWGsY2tmVu211ZJTn/WauY5hZG9sytawmTynFM0w5XKDIA1B6TJOk3NOZDoziuHdDYbnI41oGTmuoTyxQy+BwPoNNKBnWJNvGcQpfiDfybYMBPEQ693/c2zDUTJusKmowOfjW6Z88oy2gdWcqpA9ntAw9m8XV8GMb7Eb8zX3CJOHORV5FDYKZuP18yKi3VEaeWmfFPVn+aL+R2CM5u7G5TnqHdeiJv+i1kUXtcwknR1eYFZFwp0LS7emj7FKuCgzPa5816mbR723J79gzAs/3eP8BdI2Y8El/2liJh+PJnvK6fC/q2rNVcRtPfMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:17 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:17 +0000
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
Subject: [PATCH v1 01/11] spi: dw: Introduce spi_frf and STD_SPI
Date: Wed,  8 Jul 2026 22:51:54 -0700
Message-Id: <20260709055204.138168-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: e635f7be-8a5e-4568-d07b-08dedd7e3bcc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jxkBepds9dRq/l2GH/bjb0OloG6uSgjvezBTGb6DZc5hk+1hMRK2PhmlEPi0cYVkPErhIr6PZ1xvILaBdb4aUq5ZgoaCp/3soJEWGR/2/hwU5I8zxZSqcdfrqZ51ChzHSGlR6We+z4MsFlHCd3griyTalZ4Wh8espM0wiFyiupHuwyvZHGwS125sxNxMLy1cU4CZ4kwD65Dpb9S8q2hMzRTtbRM2CG999B34vP5gArLZUwT2FCVjm6ApiMAu4WNN7ejalcJeFuOk4kwHo5GvPyGXfrzBwKCdUvjflPsE8MWGy/m/G7shBVhwQDtNKJ0NZEZLQwc4PvqXjOzSa7mM6uHz4cZpZUitJBf4efgsz8NewOO3w5yoFWsiKFWxh56y+WH43RcynnjWj2mwPWLGZ7g0DP1FcOdIvKjUlSIlKYcuVQp3WnKbeBH2QxwwhkQ558yWpEe2a7AamAGWHpwJps5azvEZJPmuQhbY0nJS9jPhzzolEjXpaTRP7VrU31lX4xAKGYwscUAXbmQYnslPfRXOs9s2YdgUQJAstisgqkYwqJ8us4jc6i3ugNPmyEZg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92A6/nl2Fsm51+EMZiDB4O1znkGpxTgSYMATyhmWDOBBaCS66U8kS3dFLDFS?=
 =?us-ascii?Q?2cpmqBVFh97wNzCJPXbyfFKo/35hx5V86f+z8q/18P1i+m/j4i1yQPoH1D2n?=
 =?us-ascii?Q?EC2GUiabNnLzn5SFdpoYXDcpEfao+QdOcC2d1YVTIJqDc6O4dP2isYQdXHvz?=
 =?us-ascii?Q?ywbKrZpxzN4Vm0PcoRwOlpSGd8GsbZvKLRxzSyrdAvVh36MsYtufp4Tv+0/3?=
 =?us-ascii?Q?nkmbofwqRelB1qdTi5ZM9GL8G0zOAcq2A5Xsd/Upn9rjadmWqGyKb9bS+YVJ?=
 =?us-ascii?Q?SVEhNjEXEYPVk5toUk0g5XMc0oNSV9TavKjqOVm+vO5w1nQejqj1UNBGSiK1?=
 =?us-ascii?Q?mJ5s0jyeku2Hpn/wpo568jXz/tVN8xxdywGB4+zRiQQgrRTM+Y9YmQMQyXEx?=
 =?us-ascii?Q?eMUIXBhiEW94u+JvD+rDkefsun+X2IEC8f+Zlps9P1ClGAH8qy9aFp2Cd/FL?=
 =?us-ascii?Q?WK5MmmgYWlQRoQ0GAyM3f71RIogIc++y9aDDOh8aFYoW0YaLSRguJmAFh/c4?=
 =?us-ascii?Q?68DX0dKfgbjLfBbyskdtwcvgu6rHZWYxrAlGvzlCA5azma0vC1p9lOE+8oln?=
 =?us-ascii?Q?nWxXvbcRfZlvpEP3JO0tqo8q4r+xRuiwglY2sovmE7mIZR2pmQnb1HQB8YdL?=
 =?us-ascii?Q?n80XAN5uviFpSM3JtDYMww/D4GCNSlZDTZevblyiAUcVFP1yBQf6PlEJ5d20?=
 =?us-ascii?Q?D3b1XHecBMzgE1la7EPDVy3/3B+loEJsXhxpxMCg1OVc6wVCiCo+RDDb6gsg?=
 =?us-ascii?Q?O/wW/gOdNKatWrLPqsOE6Kzkh8P9yobaGuuxbrQjUoY5TIUkbo442o4f8jzc?=
 =?us-ascii?Q?ggKGSxCvAc9wY6NMqiMwbL0R3fafuPtoFuYnlIIEhFDNT5vB0e9tE1DDMPSK?=
 =?us-ascii?Q?FwFPtp6S8H8YYbRCEjsS0Xi4PkkVpw+DoKikHy4Nim4o/+FhELQak876Cij4?=
 =?us-ascii?Q?tM5FRYB2bWN0/ZMXHw2i14I4I9ezfx2JcD8axDHJVXDbWCicFQFYI39xUKjB?=
 =?us-ascii?Q?rbvt3xJTApP8noyIQgere9wK+Nj/jzgRoxqIF9yTy+rhguC+YJhJr/UPbpHp?=
 =?us-ascii?Q?tDvU1w6/J2DevsPXxvu26f4yaU+lcck/gOQCjB0knuyLOK3Z4gDwH8gwpNKu?=
 =?us-ascii?Q?pe5RNBvbW2nr3+tuGWKKh56mM6lwM8R+t5QlxW+f9oPuSfLJvESqv/o3hsqe?=
 =?us-ascii?Q?aSZ/VXpWyRNRMBFyRE0NNtlQhZv4CW8IRIYUSTRYwOxD1EAqwGfG2rs9qZTm?=
 =?us-ascii?Q?tT0G7V9ozSvaeVKT350jAm1XaJdUnjlVvnRt5VscvSiC/bKOThLIOfuHFQYO?=
 =?us-ascii?Q?+m9JLPoRB3/MiB5VmlRS/0j6cXgbpoT3TwIoqo6A9ziRsg9OZysbUa+5BipY?=
 =?us-ascii?Q?bMKQbkf6yJ2ucXZmn7AXa7JuMJ2pIhBW+LZ2IjhOhn/TGzMGAIw28W87lLfo?=
 =?us-ascii?Q?ff0w6s1hMjN7SZJXUAOanSW5PDMsg04KmGgA2FxA8QMQuCemVW2pZDXgbhQb?=
 =?us-ascii?Q?iyQv61etGiFvYerS/keHFdGTRmUmMDLE1TNg9VrX/x0DvSvVSOUXvFXNG8Ys?=
 =?us-ascii?Q?80qiOVe6+hNxETepbUFWYI6WeoGJXSwVM/BcYgjIDAz7TwmT3igBFzMLgJW9?=
 =?us-ascii?Q?PkqFpggtdD4el8lZEGro31xae8y66OYaT4UW0XrYXI3B95bgjqFFgYzAD90V?=
 =?us-ascii?Q?lg16Kw+LuXMSAymz0Lk4J2tyj0SUaPi4u4H2n7s7a75GP2l6SEtws4UddJTX?=
 =?us-ascii?Q?9uGHIiA+KvJNi2DzVxQLkmPP0J5dpeF2IAJoIYKYSagEgw4osTHt?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e635f7be-8a5e-4568-d07b-08dedd7e3bcc
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:17.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEkvI4K/WHfSQA3U+GL2j1LcVnj3/ZLLFqBcM+veYmQEZ3/x40jXqtkdihrNy+L3p6sA52fmUf4Cpua2yLFSkTQltf0/n6yzHcZ5GmIYviZq6sbPCLFeV7M9OlXhZCE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

The DW APB SSI controllers of v4.x and newer and DW AHB SSI controllers
supports enhanced SPI modes which can be defined from SPI_FRF of
DW_SPI_CTRLR0 register. Without enhanced mode, these controllers will
work in the standard spi mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 13 ++++++++++++-
 drivers/spi/spi-dw.h      |  7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index eff08461c2f5..86e3e7487bc7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -330,6 +330,16 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		/* CTRLR0[11:10] Transfer Mode */
 		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 
+	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {
+		cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {
+		cr0 &= ~DW_PSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	}
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (spi_controller_is_target(dws->ctlr))
@@ -422,6 +432,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 		.tmode = DW_SPI_CTRLR0_TMOD_TR,
 		.dfs = transfer->bits_per_word,
 		.freq = transfer->speed_hz,
+		.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI,
 	};
 	int ret;
 
@@ -677,7 +688,7 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
-	struct dw_spi_cfg cfg;
+	struct dw_spi_cfg cfg = {0};
 	unsigned long flags;
 	int ret;
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..19cf1b1a5d4f 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -17,6 +17,9 @@
 
 /* Synopsys DW SSI component versions (FourCC sequence) */
 #define DW_HSSI_102A			0x3130322a
+#define DW_HSSI_103A			0x3130332a
+#define DW_HSSI_200A			0x3230302a
+#define DW_PSSI_400A			0x3430302a
 
 /* DW SSI IP-core ID and version check helpers */
 #define dw_spi_ip_is(_dws, _ip) \
@@ -94,6 +97,9 @@
 #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
 #define DW_HSSI_CTRLR0_SRL			BIT(13)
 #define DW_HSSI_CTRLR0_MST			BIT(31)
+#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
+#define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
+#define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
@@ -135,6 +141,7 @@ struct dw_spi_cfg {
 	u8 dfs;
 	u32 ndf;
 	u32 freq;
+	u8 spi_frf;
 };
 
 struct dw_spi;
-- 
2.25.1

