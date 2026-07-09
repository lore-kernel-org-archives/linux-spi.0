Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97593AFD0B;
	Thu,  9 Jul 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578351; cv=fail; b=D9Twh402rcQSYPxMryuXHjBKWv0SMTwe0g4a1rSHKYC4I+EhasuYs8e1v1yrNzSQTWYzVdI5cNjFe1yBaKUObQG2iYZ3RTHwDrejzODdsPIn+8G4Fi7H5HaZngqXtBrK+G6Ir1TQ2hk7pD3eL5rSDikvDWULsbyrDJJwYwrOzSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578351; c=relaxed/simple;
	bh=8SLQNhRgzLInK6DBaLKI64+yZ8JUZaElxtUtY52xNR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeQ42M3R+ko2R2JQkJhcdZcdCcLUCM7cPrjziBck0/dgBPqyD/YzOloq2bmI/FcF/wq2tFewgkKnVxvrTGaeODg+D7WW0XKcaklRiYmK203akRbgDE/Gz9f7l2lGppFd262uHtEIS0Rpsmsd8odSoi1EF8keXiShCC/DtzZBZrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmJelNwoy3+Njy8SJuhVpNJA3EBBNM7OOYlwDnjQ6KmgpJot3hFPQWYDtfMuWz8i+RJ7tI7wr5jc3SkxCnjA4yiQjBgD6Lz6/y+E7f7qdF41VBQ8mzPh2svv0MhzBlmzc6YBzVnt3jx1vwqxSERrhKvzmNKTe6pmClWXhmLlxH+Z3l33+AvQYb4EVHYlHeH1ShOE2vpR55s1Fie7YXNWXfeJ4iIIGM5hxn4x/Vl4ztfZmiTeE6PE4Hx7tymFLEuIGHKR4N179wgVJqY1MtENm1Hi+cr8a0DVpwMBUgxVoG3yXW22y2fRPOkmnvh9t/NiKf2CBgSPeUT024S4XitN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqLxh08+YPbb76YzobAQAVo3+BU/Brm7nBs6kqcH964=;
 b=cRPA6H1irBI+iFtLnLfvCukJ2ifnZZ9Z9h2U4xWbuy4TGpB1Weu2d6aSI8EipPiVhtd0rG625CgyJyvNB/UXot+VyxPyAKuAh2K3cCJ7dxJA9plwnIzFbC8+q97bhpImq2CWSEvaGT+Ose1NRl7jVMr4Oy8ugKN/to/Jasbl34fQneDrRRK6L+5BLsC1e2H1N7q4Ad5oJ9qgPpXSFalOHLeU8K6Wn+3gJ83Br/3C1IrdMTQXGAN/PCQEZ0JB2dJqzJXH7tx/XtzUTcBr/EDp+1ujCfP3UVwg7mDk1UWR7YGoVAMT/vKBoP+rT9e+y13uOgPK+4GhGmoX9Hshs376nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:20 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:20 +0000
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
Subject: [PATCH v1 04/11] spi: dw: add check for support of enhanced spi
Date: Wed,  8 Jul 2026 22:51:57 -0700
Message-Id: <20260709055204.138168-5-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 900349a7-28f4-4881-5506-08dedd7e3db1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jfR57A0NxhNh4LtiQWVlYvSh4WwH1VI7STtUYbvaKbMPakqnI/BrFf/UFx8CW75RbUzBPrAjjmguSG4M0GyB4bJwEqFMJ2rsAYjgVImqnacQkfwkYXwLvuMtNUSTzlcK/litfQTRGvAWEF1fSgk9MNnnPPTTa8H43qtkGY84UB8AuNvOR/J8dLWH9cIBPjo+o1uDouZLtv4u4rhxNjiojQarkjt2HD2vkLH96aEzbQxNZCJN2Kmbj7AyuNFCSMCB3ISBqgC+fF5rd2qDkXFzqVYBLfL2WItWUEMyub0sYOSGlSwnAZu5E/dO1VzKAZjbxSQEkm77Q1oLmaHZqOaNzJfPpmNnh4Tj9KoiEOBf3U0A67K/J/ch0DCC7mmAfUIkMfQiizXIK+0o6MH6nG+rwVsa7me2hqwn0A6jgUztE6ZxYzXE46+5yRKl/HSzzg6HmwEpAyWfgE7ww/DMcXmH9Nohl7huHVyVzRHrTTAVM4GaBxxM6BjGun8a1TKfeOGEBmGEmoYcLjEKb1i2vXcdZfbxsxN2Y1sb8D/iOcMICZLr7UrFGJ6POpz+le5ZUI8r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gbfFoZL2iRZANE9+vJqdrOm9gbcxQLlI9z8Rqj4fhoREFzES1qJi7V2sngTm?=
 =?us-ascii?Q?k2H6zZsUi3yJgWU232GVFeghqtMudzNtR+jatnpULimX14ou8vJFUN87Dhfw?=
 =?us-ascii?Q?u0FLs03oAli76IiX9zPcXF0Lmd4AT1RhL0lEtwoFuYUxxVaKqCzsfm5LRLJ1?=
 =?us-ascii?Q?yqtc9285jV0Si/SgRJrTgvtf3GpYnEoBQMVgQhpbgFbv+2WEaPAczec0GScS?=
 =?us-ascii?Q?LuzI711xzDtxOeuyrImEc8awE5wpZdIRimuNu04XCuacjEe+bzN293CLI3ew?=
 =?us-ascii?Q?jlst1W08iwI3ZUtnH9haOiag3L0sjxywca3lSm9gxCGmP8mHaRJBduO+OIgY?=
 =?us-ascii?Q?qlOm2JUmm9/6X+6suRex7Ufn79zL2m39kcerlKPE+J3oXUzSz5GXjTyz8yYp?=
 =?us-ascii?Q?zbvVGDnqsmI2WERK1LEOp8/FmAnLvhSguohbFC34m9Qzq6wr3OsLstQHFEaM?=
 =?us-ascii?Q?aJ0MniMT0LcZta+HYmuAg0HxadSRgilcVuiUcOi25KfsmtbKf8ZNCNjlDceG?=
 =?us-ascii?Q?k6udiba/iJCe+AI69a99bSh4og0fC6Kl/XKNIm88BD94iR0q7uKXR3i6y7Hq?=
 =?us-ascii?Q?pW2oSjbcMV24NyD8MHx7Ow50rJDbjdynFAxbVekaxYphMiN71CY9f800+LoB?=
 =?us-ascii?Q?0OzVf3js3HMszeqL6h7dq6XZZq4TjlcLnz65AszLA3PH9ENLM1YhtXSEJd3i?=
 =?us-ascii?Q?bhUwGJHmgKcDTlwMPxiBvvyiddilHKnoKpdWIhAjJ8gsx87VQwQKXk+8Jt6C?=
 =?us-ascii?Q?7HJdEoK+n6QL5uwnh4KhhIZgnXVHFEvILpt119reXQfstTwefxJJGBYvarPd?=
 =?us-ascii?Q?u2PqwkNsDcmyo3gX8InzGdHNI9W40mX5eO0OG/wL7VjQTMmbSFZqKLyl+Xnz?=
 =?us-ascii?Q?3l9V3iZ5Zh/U7vrnCkSkAZEj5Hbn61283yf3AfbjXAVH2vavq0Xn/jAWtlUY?=
 =?us-ascii?Q?dk8028DxD+2BkpzlWxOkou0BdB4h71TQO3gZE/eblLCi7SXQ3C0kSvkERb9K?=
 =?us-ascii?Q?4mhAtW+TiP4YlbjDNu+G53OFJqhjCIciAUJK4LEX+gGBHusLk48xksVj0hPx?=
 =?us-ascii?Q?WveTkqWrHa/wvVk0oiKMcweUR2YGyG17uIxBI2xdq2fnNqk0QTE0TEgJP5jD?=
 =?us-ascii?Q?O7n2gC+Yf+zHc2Pz6fQNYQTt0GGtJhW7gmUjfZCtgAtdcNmUh1v94jNJV57L?=
 =?us-ascii?Q?Buvs1XB/rFdu0EwBMTRPS53LR9+cmnM/JUlHgBHlkILTtQf2TSdCLkhB1P0i?=
 =?us-ascii?Q?MV9f2lm6k16K0g48SlGvGFjyBpVHOYTqIRjEKYpUbAlcOi/eNOdoYrrBh0Mw?=
 =?us-ascii?Q?mR/jCJ5QvH+DbsLNfFRGWH7YfjdvxXF4Xy9nepOCw8WohDW3dpQ5MYWnvk6y?=
 =?us-ascii?Q?Jsl34G7mEz4k09Nbujzwr9rgnI0HYkvFCgtZAJU98z10u3oiI1cQoFCnMAhN?=
 =?us-ascii?Q?njdcGkpDJGEgv27GPJHxzsJ5rkAco+dRshVtUI9//vJIi+gM65pVHbhGw1jT?=
 =?us-ascii?Q?inz0p8xqe8RpQfP58aPb8B+guphDOOU97LX2+0gojCGucxyy+QIFIrZvsxlj?=
 =?us-ascii?Q?2dgK45GCUyEdvjA5DNTjHTJ2zqabbHwe+YPaJiTBW+TW5IdG8WCruvvSL/Rh?=
 =?us-ascii?Q?7z3eNnpZZ4EyrDPvA49xDk2waoBQkPm8pJLvIY0qyV3hDv7IQiYTTkb30+Oc?=
 =?us-ascii?Q?FC97oKJjZrgZFIp33rSI1e+/lPoy9ZW6UJ8i1Whi4wbx1S1XUpKlkJWijAaT?=
 =?us-ascii?Q?QQB3K8FgQbu9YwP+2lATgaSNseES3kqro2Gz41qpLRJnFMG0RTOW?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900349a7-28f4-4881-5506-08dedd7e3db1
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:20.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apSyCRjibRyz+zJrD6pJrGNMyMU1BUEb/Ene2PF4Y4Jx1y46nkocYpzeAI6d1N3R/V/iw92egKji7KeshjzeqjalQGro4fFhhycWhPA79uELWSE3S4KeRXcLB1LCkW1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

Before doing the mem op, spi controller will be queried about the
buswidths it supports. Add the dual/quad/octal if the controller
has the DW_SPI_CAP_EMODE capability.
The DW_SPI_CAP_EMODE capability will be enabled in a later patch.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 31 ++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index fabfdf4ef604..0d7c88d2c74d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -521,6 +521,32 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
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
+	if (op->dummy.nbytes != 0 && op->dummy.nbytes / op->dummy.buswidth > 4)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static bool dw_spi_supports_mem_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
@@ -803,7 +829,10 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
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

