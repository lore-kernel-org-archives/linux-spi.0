Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664797;
	b=ewlBNMpzGvYYxbdrWb6BzTBGefkUZG9A+9NiZpsT61FzbxzwJ0Cg4RkjgmfKpwZqRZAs
	 15P5ctAsgDHSAHfK1ij9x30HJBEP0SLVy5QJ4VrsSv0WAP3CG8cGV1RQZtYveXU4hiFlQ
	 /iVKuv5eZELqgdIBUSRCvTz/omGTH4jCagdRJzd5y+0KdXl237WjTQwEez2zmcIQuLw4s
	 UtB9SUkGEqW9TOaUjZiBhKRNC/0tGMKmDz2oQn6WctrDZuEoPyIIdLQR7Pow90kepgElX
	 nl0dEwluSHL1ESU7qwvri9BJwHyYHRK/gzh38yC8hBjTTlmrmawAHnfkKpycPbJ5dxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664797;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3J49+v+foITXU7z1dirzkE8eVtOF9ymrgjKBf/xzKrA=;
	b=MS1AlSp1yh41LCBGtpaO50u3M7DvjNZX1TT+4f85hGbPCSSCoN+QHFgIrKHZaoUlJGI8
	 Cv1o0bKfg7XOW10Uyd7WqK3oDZR1cHhfc9+TOC+nfo4Cwz7XMLdVW7J3KaHG3CivCxqgr
	 UAyvKVn6D0VOfRjoCDH9UVNnnAtjnSp7h8TcjZ30bEDTUGvT8Eo4l4k4831YWEgd0+uKf
	 X/pVhPPT0SLUmUy3Kmkmlc83fICAtf9SAzhPHJe6uf17+EWgiuiJyj2r9xk6QRfjn4DGw
	 RXPzA6BiAhQhIxSWjSQV938V8Apog1UGBXNc+eqPYERxXKPEPLltJDv1JEzn6lhU9Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.125
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7433606A321;
	Thu, 22 Oct 2026 10:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7433606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTef1w3J9reC8KdeqYkU1MciCNVE82VLozcVMosNPcN/4NzHHXktNTXHZeDv3KWzUHl+HI37LtJJ3uHh60S+zwEXta+v9C1WdIxTFW4yx1CHRODl0S3NFbb8vjFEQIxy7l2Z9ScjuabFHGloSkckfkafyyEJzC9us7fPAMnYUp9JTVi9UtggmmOaQoV24xKKXDGgIkh1nKwXiwFzO++zBg1BEJTKiVPgVNlLfYCCgj5CCKJZyrCJbCNx7JO0xAZxlTwrqOiLw3vYiLiA6pr/84VCVFNaWDe2d5UVJaLPzIRZJmUP2ZmMqOCa9boi+XmLEjzlWs+p73tD8zYNrsqaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J49+v+foITXU7z1dirzkE8eVtOF9ymrgjKBf/xzKrA=;
 b=SSkcwYynhCXozwLCAeWo4W8k8U25HwAZbwHbUJIy7g514E9vM45i7P0fmL217G2GvbGPFck8CvdGIsys+MM+YRUnzvq+2L6GWzc873yq6J7g+vp9dbP01onuWjGWGs7CfPz66FqmqL61K5TG896DWybtf5EQ2jbU9mZ1F8l6efiV2DkgqtDYF/l610EJL9jOrxmjvPCuFKG30cyKGe8JmPyohb7RMmND4YtMv8NadoXI6HDGoZuy0X/zYk97joACR6osmSTKTb1iDLbyqgraVxZWSiRCxuugx/bqNNtvPk4kh6oPJx7SEl9uLGTq9I3kgmicX93RIYRzrV9KBFbgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1329.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 10:26:25 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.016; Thu, 22 Oct 2026 10:26:25 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 4/4] mtd: spi-nor: macronix: Add 1-4-4 DTR read support for MX66L1G45G
Date: Thu, 22 Oct 2026 03:26:14 -0700
Message-Id: <20261022102614.75696-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::23) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1329:EE_
X-MS-Office365-Filtering-Correlation-Id: 84956f70-4cf0-401a-7910-08df3026ed05
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|7416014|376014|366016|6133799003|18002099003|22082099003|10067099003|261021123027099003|261009223027099003|261021121427099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	lKKPBKwLdrz5xeC8tvHEQqQjnAQez73gJ2SIbggnNGcQb1zdQL8jYYmEG1shFbOD/ScdOZK1SWnICBCtY1CVnOMOkMLnE9nirnU71fat9yqXWmrJTqSjGlRt3QoE8uzMzQChVKsr+X/R4L06sTwlPtDFUrPPQ+PJx26yWBk2AZBIzCtiaBDDBayqowreTITxHLL3gcEr2j1VOELoZdjFBDhbicePGeicTwBX7L6mO8pviFSj5nZO6gmCtlgoQrO3ObGjlYC4kyb5WPZTnP9lhL8Ha0+Vtou2oSlv1nRRcKfxFbokOpRxw9WDYq0YmWksQ/ECZbAIFJWIqG3d8MPua7kqUL9FnXATxcW9aHpjV3IyQ/X57LcRE6ZyaydeuXCHFmrBnSrNN1UvVAhfz3HLQq8jCgz5v4CDMvl6nh7GQ25aDz4nHfzEz8JXLzpUFO5bCu6HybwvRgmUCFQYCxRnJE9tlqlMzYZGMfoxqUadOjj0QWP0ggRVyi61MiaZmsCMuYnaub2c1RhBGDX8VTMWyzMddy4RL8erj3XA2UqEW8jY0pLvlal1bGQBQI2UHRwd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261021123027099003)(261009223027099003)(261021121427099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ur5Ru1uktvtTvpzk6s0uvvfj8R8k/sHk3TtUAsr0Wka2CXS1tUY6Mpa+pwlK?=
 =?us-ascii?Q?K3R/WUz92lw/S/em/fpOiSqDh6EQ5qjHcijfw2EJH2tSKJQKHuvj8xpkrN+e?=
 =?us-ascii?Q?UcCpVcGT2mfVqxO2WSVxHEXw3b3VNOPLVPA2ekYjxwKLwOjMPwybyrvkmYbl?=
 =?us-ascii?Q?QTA0JUTH7b9RGsGNTd9dIQlECp6nGl5DK3xfXWvbqM/HPgSjlKDj0sSf/XN7?=
 =?us-ascii?Q?evgdvCNra/G/iL7ffJO7fdzfWRU/5TeYnlFKDkGJ5bBNZI7MybOpq7CrvmKg?=
 =?us-ascii?Q?oS82KI6qZAe+jRv2NpbYDUkBExl6fNPVvYvhSAU6HnCdesIAlt8hd8WoGyoA?=
 =?us-ascii?Q?73GPhozjzmYAZlkAgWq0VKwxw2+Zc8TwEPRXMLWqL7lo8xcxuy+NiYjH3to8?=
 =?us-ascii?Q?nu3U/dnNbCKKI0yKIVxQTZreEydzBOeJqLkuKoAm+5ijmenUmcmNV0glEq+3?=
 =?us-ascii?Q?4nt2isDhI2o4URPtqg55DTQhkopL8Mt+Q6RRjf7xd5G8XhMpivZdk5OL3G+Q?=
 =?us-ascii?Q?0+4xBPaekIV6OVqlGvlyUwf6Be1rmMV3ZcyWVUGUreS1eu5gjVpuaAB5Ouqe?=
 =?us-ascii?Q?nsz7WZu96kllxMSc6n9NbwjnnJUaSbISMVtdy90ZvOM1hUNf69IMfv8odAaL?=
 =?us-ascii?Q?e0tLUcZRQS7wyA4OHZ559tmiUD2yM6IsO3HQj1mlD+5kF149TCbxs+Gtwq43?=
 =?us-ascii?Q?7Nbo54nr9O1fvKqSIjIkYGbnWdqmQGcJBqjEaMjADxZiHdmkb41DYDj9UhNy?=
 =?us-ascii?Q?eLv1YEFv2ccq1zT3/75jP5q9D70SWLO2Z7TcaEq6MHnFQSRf7pqjVPri3CLy?=
 =?us-ascii?Q?q7Dm8BhoJKpL7ZwI7BbU/IKC0JRy/z8tKtqoVls9nodpXq1hwm9CWg3NXX0d?=
 =?us-ascii?Q?JHeVGVGlP6k5gJB/R9OClJt8AWEqemOF5SU1N2zdaqAOZhWMm+X3EzkPwDyi?=
 =?us-ascii?Q?P383ptdB1kHoghfbaeTmGguqjmLx9N73ci39nrRKsqU4oCf0kVzHfZi/J+J5?=
 =?us-ascii?Q?a1guL5nA7wmBbFWN4XLVefLOI8g0P2TdBw531aFyXyqEmnPkGmO0+HXLl5Hp?=
 =?us-ascii?Q?v/8wsSB3VB7rmXN/biIojviIH0/d8BXWMZXzCjknPO1s+zhJH3s69ZNZblwC?=
 =?us-ascii?Q?sn7mNbYZ7cAGFjD+o3aODH4PkPWoBDyIIW5wW9m2xmaLhF1w/RvvupWY3X4Y?=
 =?us-ascii?Q?WaIFvmq6ddkxhBtH00t7tGLh5YgJcndaTwJzHi+M+ww0kNxpyIp3NYPd42ND?=
 =?us-ascii?Q?fNS762bPZsFmMTBolNU+hcTPoblACDi2kEju5hBmWEODaMrSSFG4QlrtWAwY?=
 =?us-ascii?Q?rYufNcsjzhILrPud1ffFrBYjaWSa2B5AJotStomYZovj2/CiOAORbJpbZB02?=
 =?us-ascii?Q?zx1RdGAos096PcmgOKhT5gt7r6uJ5vrJkm3gfA9eAPuRksses1qDq8jd9u9D?=
 =?us-ascii?Q?glTVF2yuHon9FfN76q6tez/nHcLtNIwzIbWfih3jGViAZ6IiXcWkgDZAUcML?=
 =?us-ascii?Q?y/byCfHgpIe6hhItXR2vblnqo3Q8WEjz6wE1vI4yArvFgK4U+6RlYimHk8Dm?=
 =?us-ascii?Q?KU6qVAtKc8/SvIlVzxPd8EdFJWghUIcHJvdLp3iTRwc2/F8Fb2J3h6uZZJ3B?=
 =?us-ascii?Q?Pk41ip8dGpL8KuL44I9JCT9N8t8RuZRZV2oqihFWxU6Imuwvk6j0yixgV0Sa?=
 =?us-ascii?Q?WmcFTz8AGDi8/+bcTJx1vV4r7LP2GpsITjsgDAKTcGdZEOM25dknloUlzRDj?=
 =?us-ascii?Q?6IkWW/2JkLDpYjczZZPqOzfEBGkgUk3mBniT9I1lHb8M8e5JcFM0?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84956f70-4cf0-401a-7910-08df3026ed05
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:26:25.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNYDT+OH7ETLwC9SYOfP5mu8pUKJAOgKlfoJwYzr/49ZWjiDIeM+gyT/IxesxTVD/wZ9V1oRhIypMfar3W3pJ21qaxxJVwff6h52PqZbSD5TIRridqVfakLcDMoXwrzs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1329

The MX66L1G45G supports the 1-4-4 DTR read mode. This flash uses 6
dummy cycles by default in 1-4-4 DTR mode, but the kernel's SFDP
parser does not derive any SNOR_HWCAPS_READ_1_4_4_DTR capability from
the BFPT table, and 4BAIT only filters already-known capabilities.
The exact number of dummy cycles is also not directly given in the
SFDP tables.

Therefore, implement late_init to initialize support for this opcode,
configuring the read settings with the default 6 dummy cycles. When a
4BAIT table is present, SFDP parsing has already converted all read
opcodes to their 4-byte variants and spi_nor_set_4byte_opcodes() is
skipped later on, so select the 4-byte opcode in that case.

The part also supports the 4-byte opcode set but its SFDP does not
expose a 4BAIT table, so set SPI_NOR_4B_OPCODES like MX66L51235F
(0xc2 0x20 0x1a) to let spi_nor_set_4byte_opcodes() pick the 4-byte
variants, including 0xEE for 1-4-4 DTR.

Add a dedicated fixup for the part (SNOR_ID 0xc2, 0x20, 0x1b) that
keeps the existing QPP 4-byte post-SFDP fixup and additionally
advertises the 1-4-4 DTR read capability in late_init.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mtd/spi-nor/macronix.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index b3fdb4b2fa1c..3401275f096b 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -103,6 +103,26 @@ mx25l12805d_4pp3b_post_sfdp_fixups(struct spi_nor *nor)
 	return 0;
 }
 
+static int mx66l1g45g_late_init_fixups(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+	u8 opcode = SPINOR_OP_READ_1_4_4_DTR;
+
+	/*
+	 * When a 4BAIT table is present, SFDP parsing already converted all
+	 * read opcodes to their 4-byte variants and spi_nor_set_4byte_opcodes()
+	 * is skipped later on, so select the 4-byte opcode here.
+	 */
+	if (params->flags & SNOR_F_HAS_4BAIT)
+		opcode = SPINOR_OP_READ_1_4_4_DTR_4B;
+
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_4_4_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_4_4_DTR],
+				  0, 6, opcode, SNOR_PROTO_1_4_4_DTR);
+
+	return 0;
+}
+
 static const struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
@@ -120,6 +140,11 @@ static const struct spi_nor_fixups mx25l12805d_4pp3b_fixups = {
 	.post_sfdp = mx25l12805d_4pp3b_post_sfdp_fixups,
 };
 
+static const struct spi_nor_fixups mx66l1g45g_fixups = {
+	.post_sfdp = macronix_qpp4b_post_sfdp_fixups,
+	.late_init = mx66l1g45g_late_init_fixups,
+};
+
 static const struct flash_info macronix_nor_parts[] = {
 	{
 		.id = SNOR_ID(0xc2, 0x20, 0x10),
@@ -355,7 +380,8 @@ static const struct spi_nor_fixup macronix_fixups[] = {
 	{ .id = SNOR_ID(0xc2, 0x20, 0x19), .fixups = &mx25l25635_fixups },
 	{ .id = SNOR_ID(0xc2, 0x20, 0x1a), .fixups = &macronix_qpp4b_fixups,
 	  .fixup_flags = SPI_NOR_4B_OPCODES },
-	{ .id = SNOR_ID(0xc2, 0x20, 0x1b), .fixups = &macronix_qpp4b_fixups },
+	{ .id = SNOR_ID(0xc2, 0x20, 0x1b), .fixups = &mx66l1g45g_fixups,
+	  .fixup_flags = SPI_NOR_4B_OPCODES },
 	{ .id = SNOR_ID(0xc2, 0x20, 0x1c), .fixups = &macronix_qpp4b_fixups },
 	{ .id = SNOR_ID(0xc2, 0x25, 0x3a), .fixups = &macronix_qpp4b_fixups },
 	{ .id = SNOR_ID(0xc2, 0x25, 0x3b), .fixups = &macronix_qpp4b_fixups },
-- 
2.25.1

