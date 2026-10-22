Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664799;
	b=t9ogMIpi9VnWkWYQU+JqKoWsshIVxrTKLlmR21zMp1Vh+ZYb3WoCl3NPNFnG/rszZgL6
	 FJlqDkXeMseRnuCww/lM1DRdrWpjouCF7UGeD5EHny0HVJJETh/Vqzyujw03+1XEERx2V
	 9xY81IOx2nFdoz+93A1n3fCWR+Y2aRrouZzuls7MinZgfE/9YdHhbksWrCQDKt1dOOqkZ
	 yPiOY9t5KfzwWMnT874eA7U2Xc8xZrnIN6hlOzeh/uAYRsa35PKt/W5KoqhanxaCzFzi7
	 r746XAj26SJ0KKyJNE3HXGrkXKjCAn6fHO2I7JxomhmH8gnD/VkMEsw3+YwQZgTx8Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664799;
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
	bh=WoQvftIAcM10sQkTifo5UoiGV9FGutHD9FWKEAXIGYI=;
	b=1R7ETmOo2boo0K7J1RdU29JGMnOreVt/d7MM6SfRu8TF2FEgl2UzgmU1lBKmHQNUdyEt
	 9ptQmnzq8/R5ATfmWnd/OCWadSZ3j+ImtDH4NxMO6HIwmZ9cKsAaX15C9DkQKiETMvXms
	 OTZrgvXHRMjhsNxHcEcZceYp53S4Pss8g07wO3cz3CGZfKkSQNnpxODFd4pB/j5qRMxAH
	 sv7zJfbQ4mqLpl4hoiRaNP3xmfIzN21myiU/KM3NndV479s8YkRnmFVg2Dx37rvLb9n7m
	 3te5/5qshG2gDPvVXDkitX3wAGTioIhat+xUv6zwFKlX+PRb3yi9rWmoTivrbFzRLTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.122
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDE606A324;
	Thu, 22 Oct 2026 10:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34DDE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrJTvbKceTaU32YfS9Fdlht9FEK4pwGY1pbNz0Xa3gpOnKrdpnTC+DNZiYr1XuN1FWvGG+5TlIQoM3gZ77aVV5SwFodtGsBTX3GW7bIGJWxVgJKCpd0jLZ4sCEX2d4/8dwAuE1Ys+QQyJOpC2Nan7kZg3XoInPi2ZKH2DifK+syiokk83PGEHa25MxowUXAUKYcVGkHhckJokmePw+3ppeOJQ07jPFDWsSLXDoRtJkeVnh7F4HdiF/nTF8dXSBWWnOk80gJrOJ9HYngi0UfodZXlao4BTS3pn29rNqwpEaVREDUeH9WIWURS3vM/A5dFh+OG30q78ftO1JHV7+dkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoQvftIAcM10sQkTifo5UoiGV9FGutHD9FWKEAXIGYI=;
 b=SV7Zutl0pR239CE8by1/ySZO34n23hDzxgSihLMwynn72N1jvlZnRczhc/2PlfixygIZz+7FyoXmqUJqcoNm7MQBPJWeAhjBe+BrwqEpWMjctgJJ8QayKdCBjfJZZjIamuAA60ce/2LtdntZa6X5OnKuLUaf8rsItRX9evSY4+f3uklfny30U6zsH0EqtZgAljWquQPl0bS41N8b0a6cizW7wck6SzTJMYNiHRY7nHeZEmwaJNutn8Iu8JHC4/bP0/4uFdgyKCWM0aA9Y8whIKujfLOr1WHTFIyKdR3uybio5FoNAqedHcy9dzxcrlOI8/jmNfeEYHjFRC+smF40QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn (10.2.3.102) by
 ZQ4PR01MB1298.CHNPR01.prod.partner.outlook.cn (10.2.3.110) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Thu, 22 Oct 2026 10:26:23 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.016; Thu, 22 Oct 2026 10:26:23 +0000
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
Subject: [PATCH v1 2/4] mtd: spi-nor: Support mixed 1S-xD-xD DTR protocols in spi_nor_spimem_setup_op()
Date: Thu, 22 Oct 2026 03:26:12 -0700
Message-Id: <20261022102614.75696-3-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1298:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e6eb09-1a85-4d91-778f-08df3026ec00
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|52116014|1800799024|22082099003|18002099003|3023799007|38350700014|261009223027099003|10067099003|261021123027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	s0ThZ/9pCBjAvi3sN0NFA8ESC6T38yRApCwGwa267efdsrtfDJwEwQZjnh5CsiK0RBl3KyUS2LmpvOYHW+zqZDihGm2+CWavSpWZFWuh7nb8NbFFkLLI5jrIcUFuCfJiSLP+2o0+6k2SCi5b0K3fBgJnGU0a2m6vYL/dWjCVyfKYRemQ/iXCwCO85bLJJ9DrnCOFkHyLrx+5R8iQRoMCvIsKuEUOXx1UVplWDgpHv0OrkNB6BAmhxE6bcV6ZMFX1ao4Tfkd79oCsrqSJt0icBMoI7XJNCGyeT9b2GF27zW/6svzoQ3tM/Nsppf1q/NeUiWg9c0nb36WKrD87QTTcnjHYhOYQYsME7xIN3emM8WogwWIG25gcieQMU5QBbxS5e7jAEnwIbOs+OEE1921UleVgl9gJ0mehkcjrAbnQ1li3BhTGsDiL3fUYlzfsCDj15eKD+FQrKeqDeVgN/UqXBxQTM2UAn8AHnQvYJMoDv+toAYm1UZUIeHDvPacPDyWYe8l1LnNeAe5wJ1Qz800xCaFjbEqILWb1BcHl7taPKYmrhfMUbRtbSDW0atXITu1+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(52116014)(1800799024)(22082099003)(18002099003)(3023799007)(38350700014)(261009223027099003)(10067099003)(261021123027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7a7ga4skYN90P6lfZD/yePITKiyJdm6PJYCK7pgLTUFgWHE2Lh3NOR9ioL5p?=
 =?us-ascii?Q?wiQyyZj7WnPpnexEvjrxG/rowsVXuUdOxaTfDTFpqGli6DnvNthI7oQlCcf5?=
 =?us-ascii?Q?K/EHL1dmhzi+e6x62QjBLQe/PVgPXK2OWwFkx2cR6dH9RE5M3p+GTRhIfW9Q?=
 =?us-ascii?Q?dybA2KsMBCnpzG6EOwaWlzzmSauIulNWJA2cgMY14qV/0Qu/306KB1LU5PQp?=
 =?us-ascii?Q?3ZgV4TtHYmSaMsBK01DtbI7HuIy6j9BBKm82gCbn6DK0hZP5DKYDD6i2Jx6K?=
 =?us-ascii?Q?yiHvDvWH7FnBULrU8okJI8yQnETw/8lznO5gNIeRVzi4p+MPe85tQ2ee2jCr?=
 =?us-ascii?Q?US4mN4aftoNsgj/Pq9EfUvmVl+mV7k1Q9niNV5l8kL4Orx+/LSn3NjZjDjK3?=
 =?us-ascii?Q?sv7ba3NqqMa5DTgiSNuSoEKP9rNRe+BtDeJ8xwTGgK0PnH75pAEtmJTquOIa?=
 =?us-ascii?Q?Od+U8fB+sTjQSotkDOIbQzz5kQfNZJ9dlKUQmZo6sKwduWEh4hlLlmZcih4u?=
 =?us-ascii?Q?NK+SFP12hbq6XJ0HlJDwFBNq8PUPu9e4XnS0DC5ut4xHFFNl7Bl/fdxM6AWO?=
 =?us-ascii?Q?fzQMoVDQKSyMeQi+a+1dra9CrxRpZO9dp5R89lFpQZJ19p1b0nGMVkiZAEiB?=
 =?us-ascii?Q?wNW0zCJ8Y7RgO/KKbAQ2H9KIv6hP+uwBKz+awVD2+Z1epp7oSzdaUOaiJcxJ?=
 =?us-ascii?Q?pGl7RqR4vzeSlt5jBYvsJZPpbFuA0P9Gq5guTBlIk7K9KtckgMPNvsI1/9ym?=
 =?us-ascii?Q?2Hg4BtDgltR1RGw1NYbxV4Om/U4cOTx+i6XAn8QlKYqqr78IDWOVvVR3Kmfs?=
 =?us-ascii?Q?Mj1yawNXWkWaezY8M2BGyfVkruZt1Wjhz9tLS+tUrwZk/5t6BJDLgDm8ZMV8?=
 =?us-ascii?Q?1FQx4xnDEivtFIQX5PjkTYV6dzIb/1eXEvNl2iWyiJZIs968sbO3RZqxi8qR?=
 =?us-ascii?Q?jjWd0P1qx6CsDt5HsV0O5YEBA5z2HpP582zprtaAC+1olXNB1WSJg+Xujjub?=
 =?us-ascii?Q?zFDrpJInxd5NuoNuOIN0CLWCtog9PR46UFNWfB6fYerkebCNEWrYtDehClRi?=
 =?us-ascii?Q?8yMR7TeA6ekYHq43YwEzzvMsaWcLaFHYVS6mfhMBl3Com3UpuytINZ74nidV?=
 =?us-ascii?Q?2KnLD5bDy8bfWLX+8cIlHdylR0DKCmq8PVoGlEsINSXKCG5lEX+7BvxhyPjF?=
 =?us-ascii?Q?IpwNSNuXffUvrhqU54B8f9yqKgWs0WPkh7zRacMNm17jghjqEuebHavZeQuq?=
 =?us-ascii?Q?m38ayFkrn/H6PiXVFgN8t8glps3QAz4R88uWH67jiGKc2RvdGAlJFle/kgz0?=
 =?us-ascii?Q?4wGpVv3b/DfGACJ7ELxIRl/tbpx/B4dF7iL9JA3wYVXrynugr3iZ/IBZbuyJ?=
 =?us-ascii?Q?7ZppPIdunZSz0obrV6myhWMJqrMHtUAUq0C47Asp5vis+7YnahuhWu8dJCua?=
 =?us-ascii?Q?v/is+jqiW7lyZOHApTNC26PAPZR3I560gf9NZCbfgsAFh0fmfFDDsr4RK+r7?=
 =?us-ascii?Q?o5g8grLEeRQf+Y9QqfC5jHPhrMnJXE+/0F/6kqrMWg9V9Q+TNuuxcQvNcHfD?=
 =?us-ascii?Q?+6H6FrtlGPXe3DwBR73DEnuYwqnGr1f2ZYYqV7n0pRBceS9jH2WBxmIDlyEG?=
 =?us-ascii?Q?kO3eXys91NXOMNza1rXWmr4AjzZMJc4o8n2Fo81+3NNnWPauYYuTr1HkosxO?=
 =?us-ascii?Q?juneQICdnrHOX71is0wHyJJSpvghVxiKJjG0KxxWHyjTLuqGmKGZ8MlhHrzu?=
 =?us-ascii?Q?/zVU2X3x2nnKjmVYUbc3MFLvdnMzTTlC4qwvcoalsE4fmB1vPgQn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6eb09-1a85-4d91-778f-08df3026ec00
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:26:23.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u+3BZnEaBmy9+3KrsI/wjgd+IJV7KyzVIiBOwAZJd82niEW49RM4fbx99BERRX13UO9GiJ63hk5Obp6k7e4NXdruW2P6rMaTLyo13epThjUNW+1Lbx/83siIMGWhRWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1298

Currently spi_nor_spimem_setup_op() sets all four phases (cmd, addr,
dummy, data) to DTR whenever spi_nor_protocol_is_dtr(proto) is true.
This is too coarse: the 1S-xD-xD DTR protocols (1_1_1_DTR, 1_2_2_DTR,
1_4_4_DTR, 1_8_8_DTR) send the command phase in STR on a single line,
and only the address, dummy and data phases in DTR. SPIMEM supports
such mixed DTR modes.

Split the handling:

  - For SNOR_PROTO_8_8_8_DTR, keep the existing behavior: set all
    phases to DTR and use a 2-byte opcode (opcode + extension).

  - For the other DTR protocols, set the command phase to STR and only
    the address, dummy and data phases to DTR. Double op->dummy.nbytes
    since DTR transfers 2 bytes per clock cycle, matching how the dummy
    cycle count is specified for these protocols.

No in-tree flash currently declares SNOR_HWCAPS_READ_1_x_x_DTR, so
this is not a bug fix but preparation for enabling these protocols.
A follow-up patch will enable 1S-4D-4D for the MX66L1G45G. The
8D-8D-8D path is unchanged.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mtd/spi-nor/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 90524c58602e..43e506e728ab 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -97,13 +97,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
-	if (spi_nor_protocol_is_dtr(proto)) {
-		/*
-		 * SPIMEM supports mixed DTR modes, but right now we can only
-		 * have all phases either DTR or STR. IOW, SPIMEM can have
-		 * something like 4S-4D-4D, but SPI NOR can't. So, set all 4
-		 * phases to either DTR or STR.
-		 */
+	if (proto == SNOR_PROTO_8_8_8_DTR) {
 		op->cmd.dtr = true;
 		op->addr.dtr = true;
 		op->dummy.dtr = true;
@@ -115,6 +109,19 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		ext = spi_nor_get_cmd_ext(nor, op);
 		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
 		op->cmd.nbytes = 2;
+	} else if (spi_nor_protocol_is_dtr(proto)) {
+		/*
+		 * 1S-xD-xD protocols: the opcode is sent in STR on a single
+		 * line, only the address, dummy and data phases are DTR. The
+		 * opcode stays 1 byte (no command extension).
+		 */
+		op->cmd.dtr = false;
+		op->addr.dtr = true;
+		op->dummy.dtr = true;
+		op->data.dtr = true;
+
+		/* 2 bytes per clock cycle in DTR mode. */
+		op->dummy.nbytes *= 2;
 	}
 
 	if (proto == SNOR_PROTO_8_8_8_DTR && params->flags & SNOR_F_SWAP16)
-- 
2.25.1

