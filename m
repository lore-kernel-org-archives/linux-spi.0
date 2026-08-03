Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061A40B0FE;
	Mon,  3 Aug 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760873; cv=fail; b=gQJp3En0PTFfwkRH6m52tR2QRAurSdgtAVIqXlTBBZs5vW9IvQaVTvvlQ1Vq3I5u63sMCvK+2trTGvFm6lFkyhtAeUeXsJZ6DgoNomC/r8YR5l5NEXNTKGGjSh9NsSaq3GZ+Tzxvsqd15kCqEM41PYEg4EyudI2Rh6a3ZJZ1hAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760873; c=relaxed/simple;
	bh=JE2j/Ha5zC5s6MNigi+KrHFpMojZgIBNun6F/x6H3hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1CzQHiZPsLzSU6G0zs0ekYTUJdzuTIoj7M3PK2XG5i77NCkHWP/XTbS1/Qe4I1O3TLlJUoqlvkJB2q6n+FI/wrCcnLikaYIaJDEOwLtxMUu42h5XveHAO+ylbshpKEvJDNtTSklv8lgRdKTlsNNt3c1apld0LaqkxDQ+T9i1VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDRAKSczQPfOplF63H6maG4MUAaDcX2dtHhHYo4kyxdpsr25g1wRziaE886VYM37o774IcILpMWQ5v+0WuhGYxCbU0PtVQwAHMioaYO9AIO6fGtpi3rxKtvLzGyo5wn2pqxzni6jg/6onjgf40u13pym7/kRXvD8UXJ/WvAu1QCSC6fX8ZtjLH/JRLdUWiLH8AhhPn0t+xit5fQ7Ve+tI/xvrNK34pCL6CVr6ObHFGri1b0HQPzFw7O5n5fzMYaFcJ4OWAkqUsS3Zi/mLxqFfPu75xErqUjTKtSRQ6Pw6qH93ZqIKApc71mR2qrsCnGMFS18wG+crB/yCxGsoJqBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzuze5fxKrXKGakFpgmBtxYB02MT0W6li+s0/FS+Uqo=;
 b=PdEUyzjaMkN2tkCSHDxNHQseRtlEwvPrnR2wwHmG2KPkO3X5W5UZoYCaFlcM0Rm7NthDf4cQDVO20HKr5rEJCAAJpFC5MkCzphvYiUCtSBd/AihE9cLhCOZgU+bIq5DUtDVeIkj763HlLemuAPIkj2g2at4CKLGXp8SmCxCTyOJfEvE7iSsj1AFlpM423WgwlLBBO3+DVG/Gafc7FmpaMujsPvZr/iqQa8sf7G4Z9FPZjkQkVEOkvUjxJklk+6ct6RtdUAe00DtcvpJqypByx6WW8C8WnpV0KAokvCYsZ/VqWEJkeqDIdOu30Km+abuZgd70LWSbASIvtFckqbmLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:40:55 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:40:55 +0000
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
Subject: [PATCH v2 04/11] spi: dw: adjust size of mem_op
Date: Mon,  3 Aug 2026 05:40:37 -0700
Message-Id: <20260803124044.156998-5-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 052ef2c0-0541-4a84-17e9-08def15c7618
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5UBZjrmoN5n+X3fXrb+4XHG4xgrwM+C9joXR5tIgcemYvvjaqIp4SGw2+WToHYdzBgjaztIMIcXtCYg0xPGlySg3dpd/hiIScVgsuzXBtr279w5V3RD/ZtE53CUAr1BAfBPoR27TBhmU7rU8LJhPo9AOQZTM1fTJMjE97w9fjiyEF5faDRmB5rnX+dRcWSjM7RrWTnsweOtmBK1I6bUklizdA7ofd7nq7X2R/ySB7S3RZ/3DkncDT10+S6kP3IF074MECyCPNhVOgoRX047xTaK1PR/u8Q7Gbxv4w0ToPtDdR9hGWW7DHe+KbOLraFaYvPSm3I06GvKWDfBI3H5VFOlBZWdruXN3p+ZRwZhNgfFZGZ++75HkA3cyPTqgXf1KGOps66/EvKvU3iqSG4mZu8R7C+/McdOxf/bx8iun3Wj+hCIeuWVQN4BUoM+3LzjXUMDXqXqA8GsCVX8KBuokNdu01W/SxKjWROG8yn8l7coNyEtCxt4V0qmdWpE7afScfn/GYcNz6aPEuwhLYBb69jdegcVTif/556pvd2Y+RnZOObvUTEcgUf+PVebD72bt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OCWmOMFHyp07L6O5EMuyXgKNejPpYvdv7+bXLXmFmGmf4Dt8Gq9wAU8zHvUN?=
 =?us-ascii?Q?86Gq+6UFbbNtcV5GuKIRuuCam62CCwZAfClnSNNhvzQk1yDvW67Zqb+fZgBT?=
 =?us-ascii?Q?OSyEWuVHP/Or/8pGwt6Arq6atgSgH/28llr4wE/rgBj4DJ3kxsdz+rYap89h?=
 =?us-ascii?Q?UUdNiOnZQZ490OZzMYYYjAQKg1LVWU895CLuGo7OIb8zj+e/sbBaERixRCgp?=
 =?us-ascii?Q?/fpIIw2Pztgg1rpYrtPdg4+MS6BUb82HmGSfxmDjfsUNsN/y5YA5GI+Sz/tI?=
 =?us-ascii?Q?RQa0hl7ZPIVLh3R4x5ZF6YhFlIVplhD6Vua+C4GjhyjUJ0+U+VFmwFhsRJEo?=
 =?us-ascii?Q?Nl2NBO6SkGHRbdkQPCcWsdID1owt6ATcIr67srqQ6o4XxpmUrZbNg0sAJ/Lu?=
 =?us-ascii?Q?ymKtSazdSfHi/Fys81qXLI8MKvJAJ+u/6BkrXpa93bQ6G1hgMXvu9qLIhUHd?=
 =?us-ascii?Q?zyzJ88who8KADzpyIiYzNYvxLM2KfMk0ciynB8Jf1RwrpbUVnwc7qj/VY37U?=
 =?us-ascii?Q?A6Y4RY0UQH26NeCJn2GYt1RD9/zb9GgTERbSgM9nYvlXBl2qOww1N8n142Nh?=
 =?us-ascii?Q?SsDBQUNPxiyi0EVQwRIxojGASbCsy1nSTR27PyQxbZAJuqRbpMT1k/QpXUqB?=
 =?us-ascii?Q?1geQyZaEBxO15vbwg1rM2Jpxos2VVHYc1lAtZmrjFgC7nqcG5AY3RUvAy/yK?=
 =?us-ascii?Q?IMPhLQ849/PqHNUCWtmeaZ2g/b+I2ZJmLzAZrNO85ZWqv1DJMG6bLAwVUY1V?=
 =?us-ascii?Q?zsEkPXSOp5hxsgOoD185wdBPShdxP4A3S9PKUhA9pyGNLmwh1Lbb0a/7ySo+?=
 =?us-ascii?Q?W0/Myfcpn5NEmbvi8UTF6ASr/EpscDCMR3RTIc9WEyTJwoLELfyAsWEFlwl3?=
 =?us-ascii?Q?2bLj1tED/KtPz/tG2g1CNomI40w9ri6vvB8r5rYYQw2BmGTi6/wCDDT0mnyF?=
 =?us-ascii?Q?C4C/q1Hg7nP2zfoQzNu50zGOO5wh9d5C1u7K1cFO++ik4omC6QmH3t4IE5Nq?=
 =?us-ascii?Q?LuGalwo+jZ2YDY5agwChzzgiIx0wrNVmeTj6olDyh2kZqnBp3JIX5/urZXZa?=
 =?us-ascii?Q?OyIi9UuvuIQhNqxhzhxEn6LqYVKCTyHZq3nvA5cTJFPeDlOxl7P/vNC99kuQ?=
 =?us-ascii?Q?ekruGG6IsmZDrh3Eg3Ab/7TpYBIms3WF83LsecUnsQSnWPF23Ao4KbwfdVys?=
 =?us-ascii?Q?Wrjf7vyAiUDROcRIAfJ6jZDMbwx4prmCZDpGJSqMQsoX18Vb0eJMhsNlqaTj?=
 =?us-ascii?Q?NzDBH7kWZQabblKfC64yyNEWf8cBzJP+kFUWV0z0pfAlI47hJxklWfY0FzQf?=
 =?us-ascii?Q?61LmLvNYgSZVgnVVWQZt7XqM1KjKnV9LXHOWvR1i2UPNDUnIBY1CBR/vMfcr?=
 =?us-ascii?Q?hY9jcIvmS+vZ5TQ2f/anJASICBGPtZ+tvqlN56wW15o4jNRh/cehMKG5UcFq?=
 =?us-ascii?Q?JZt9aCDF8fCA4DUyLB3XriuH+XKBYMP3cI7plGvqT2Y1LElPlGM5s9CuwYi0?=
 =?us-ascii?Q?+9qOOHtzANTA98jEWMZscw/sWKxlv//CVH4ZN2D8gQBJlx5CQn5W84YoYzJ/?=
 =?us-ascii?Q?6ITONYgaVAYlNU+lCo3t5U6PAhJQuMVd/pqPiCDup3sREE1PMW3S/Us95IiE?=
 =?us-ascii?Q?CS8EI4EKbjCbNFvSAojkxbmepZpOmvjpQasskKxomtD5T8GbVX6SGPyQOkL3?=
 =?us-ascii?Q?VQLqqEORaIbvq2WXEx5HfGT2lkw4W+jYaUcbanU5QuOvUw9vhdfuWk9/rzYw?=
 =?us-ascii?Q?Y1J59XdOFC3cAgC2xbE0btxZDBke4TqkwXEv732dM/DrEmo/V8nr?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052ef2c0-0541-4a84-17e9-08def15c7618
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:55.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5VX0hmJ0N25PSWL2syKZgPAor3y2SQNl/Ou/H5uWPDmHzlRHr0YHO+VZgGwx28S1QV/fzc5T8Rjqo3rP7uAlzRbYlk1xxaX6bsCrzF/D5wBMSLLC/U05KrKkNIO4gS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

In enhanced mode adjust the size of the data that can be sent or received
as this will then be used to set the NDF.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 7275b7a9945f..c7cd24337188 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -510,6 +510,16 @@ static int dw_spi_target_abort(struct spi_controller *ctlr)
 	return 0;
 }
 
+static int dw_spi_adjust_enh_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, DW_SPI_NDF_MASK + 1);
+	else
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, DW_SPI_NDF_MASK);
+
+	return 0;
+}
+
 static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -829,10 +839,14 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
-		if (dws->caps & DW_SPI_CAP_EMODE)
+		if (dws->caps & DW_SPI_CAP_EMODE) {
 			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
-		else
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_enh_mem_op_size;
+		} else {
 			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
+		}
+
 		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
-- 
2.25.1

