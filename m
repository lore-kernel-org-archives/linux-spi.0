Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C853B27DD;
	Fri, 19 Jun 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882557; cv=fail; b=Y9RbofO6ApfpzU1c0tRNM29PzQrQqstADozQCNUYP9TKWUeIV8SUvDKDCG2SA1fbfa6rMnL28Ez1qX/bTaZPwj9c3ibxtmN099Qk/J0L1n+lNC+EratP7TaxgIEwfRPt6NzLu8XMu54Ul8KndN3BVG/sWDHO6OEiYOLgrCFVmGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882557; c=relaxed/simple;
	bh=Yv9xy67rAYxxAIt1TQU3VOn507VOY+2+EzbyFwRkNhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nP/yqmLj+qXGpdR7nmR0wPF5BrHiLqcgh72rOBl61ZSPhVpOtunCfFBvA2YfeNdnemtBvxJ2d5o8cJ3ONt6JGjrl7A2dZ+0KaSoERW0JnPgSJITpZtnhgtLpE4eFyEp8aJ+BrpmDP7kpZ1E2elo9LwFyTiTGb1xj3AZQe6kSWfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kel3iA9fj2dUqGrrbSrQnlyyo+oHn/9wjyPHGDPs/5ysrZWqmkKygM5kQ+LwvHdgi6FodcLyqZbYVMQhTGj/pDDWNGwPRJsxNl2FAPkzvYhQOiXgXBtkc4xd4vVBvbPM1SaHT0ANnE5utx6KuNyvfpW3fnL5Ep9gIASmY6NwC/CTNyzNkSWabwlXucN2wQJSY6wIjFImtUwIMn0DeZdVQRNacW/CEcECa0rB+vcIw793Rd9qVTBn4cGq8FpfvDkLUCh3LsoJ+b9yiWzivzuNIUNgCdhmsbd99Rm9Cc3zepRsjxrh+fpVR+sXA8/B9C1hM5Tp122CU9l+fasMb/tkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ojsfBjGjtTUR9/pYpSXYLGpGISzZC/TgjI493aFvzQ=;
 b=CKw07smPfCu180YDNgh9gIJvCdl6lSPy1+QjuBqCapJgMde6bLqLOutWmvuupMe3UpluHBJe5NuU0znoTEpqWNJxDYYvIPDqYFW9/ejWIFzbuhh8EKGIVq5YvKhO4MD7DUMnP0WVp5zueqRZ+WMu+FwZobPaR4o1k5UYU0rIAwy3ULlsrod+yjzuO1uHEyOsjAYelok+ZGy4XCzYudRtYe03AoRWAzl7g97l2mT1B6b/5yN6jDPYsNR2cfITJaS37RdxFALiZKrt/ZUEq4aVt5u08sK6JyrXTNgLmt2QLGaJtexmZ/9VMcxHl4vs6nQ47o93zZcfLdXjn/PRSxj/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1330.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 14:34:54 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.020; Fri, 19 Jun 2026 14:34:54 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-spi
Date: Fri, 19 Jun 2026 07:34:42 -0700
Message-Id: <20260619143443.22267-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619143443.22267-1-changhuang.liang@starfivetech.com>
References: <20260619143443.22267-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::22) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1330:EE_
X-MS-Office365-Filtering-Correlation-Id: a52b91c3-4776-449c-3484-08dece0fed91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|52116014|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	2lOt8F+sLnK5UNLkK7ORa0nVpj0DQKj92kA0mEeWmgjVCJ0pV2iJ3A08IyCA24+mIKbM+4qSLxaHv5OD+3+VnmcthydN4swVrSG1lLmQcnNIcFX8YqRmEhB9MEhTn4fS6/mHdBq7mdM5n+T9SKvQqWFxxXkcv3ANgwdx79gx6wowas9ArWnLeU+JDV1Wyd8izHSrcEV2maT102C3dKAaqDfxLBEQ5jsk/N1vcrbXDqmTRlil5AlhJZCEXp2c000j7+BqCOl+10M5cd6UmLN5yVb+y7b6zIWxtxtg51M+IBKKutnFWaO/5XeTz4KtzmzPKCo+/Szjullm5p3lGD0sy28WjaJCs+y9u9FBil+opfFB2Es5luJrzcG9gnOaatfnB6rPKfUW1lazZchCuf254xmKI4qWUZldBGvzn23Wb9JptaM6AsiXmabn+fkR++QvGzvmRLVX/CJBirqVrXehX5yFsnbI/kXMOUHvouet/9zYIvq5yAiAgWxB7+b2bda4n2MdHRX+b8hM/SpEvYaRRlAyJCEZkh/BGHbVYwbskfCXmTpKatrEULABH8QEjXXB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(52116014)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10+XmQnRgZ0mNwHKdyvY2KW6WgcQ18xPurZaadlL9xjd6wTZFkdEp7id5RNy?=
 =?us-ascii?Q?3/N88xuMETlVnSP0gKoIv4qSp2XG2s6OgL9sILLoKDBAChfh/GNq28Px7lS4?=
 =?us-ascii?Q?FMU25M5O7sG/LTllsfnh/lUVds5OMgZF6WiYi8Sj3V5jo/I0P07gkhRRvCwo?=
 =?us-ascii?Q?wfPjcInbHwftLE5RTSjXqL8TC4jdNygcOD2z8y2yUf+vltAKba5lXcfYNRqi?=
 =?us-ascii?Q?e9kneN7pc8cdh7Cy9cYLLizcRVH9muGCLlSv2miHn7Y8+5gG09yCSW9BEgqt?=
 =?us-ascii?Q?5OsRU1ElaPz4A5+km243Jn1AnGe3kqZKj0R7TDywOf7m+GP4WjHDa2vGrIRy?=
 =?us-ascii?Q?XNzOQJSZiUi+Ab6b5v+lJK8/JtkzFW/o/+jA4HxPINQUE4vBJEP2Kuuaj2UF?=
 =?us-ascii?Q?LO5Xz+4atSmmUeAWBtzkbgM4Ic4O3WdOs/2mEZiVrn4ipC3c5YljFejP+p4J?=
 =?us-ascii?Q?swq2/NygPyYURgyxi2aCQcoVxNiyXDJbK5GVWk/lqhsr1NXE200ksS8trXZp?=
 =?us-ascii?Q?pH9uiLOvoA1Q1d724KkQPxdvYx1rY7dEMc/8wnLNz+NW6pirWJOBLiRDugGZ?=
 =?us-ascii?Q?dK0lhWmT1zipdKPaHENrPma+Iu9o4AAVay/lUkvmmGZ9pQsKZc63kUQdND2j?=
 =?us-ascii?Q?FyVa18IG6Tcwk/NOxbG0CtI38Ai2IJ4Z0Fec5eN8gBDRy/7R5QL+hMz8DBaX?=
 =?us-ascii?Q?MmkEz8BV6ywwnPguRPRBrNm8vkxGmHJK5+7GQkqHudzcZSZAc45w8EnNNksG?=
 =?us-ascii?Q?yugZvwTDzVeC8Ugiad73yBVoCxOPd4jSViNlT0Hi6jrnExL6A2MDg5CRtXo1?=
 =?us-ascii?Q?foO8CZ7GnvI5iwGhDtJBPbpH3mUMU6VfOqJ54DUQ9TJxiErGAg2Sqqf4WQFR?=
 =?us-ascii?Q?/SqmXx52yeFPoT0+NcDFpRaI6PbMXEOnljSwgXD2WYYZ8uTvr5MawhWM7tsX?=
 =?us-ascii?Q?NkAMaQJ2uylPUl2/nRHYumi8G3hRB0awGyfcMYcDlijFuHjObc70VuPu/f4M?=
 =?us-ascii?Q?BuspQzZk0Ih+YVWty1CHL3M2GqFkHPrCqdZWKIbCkl+2Ce6rrJjhWH09AMrz?=
 =?us-ascii?Q?X0Nz0+7g6y/FPlo79enZ2PK3GMtlkW2INQ49pNqTbREEIWwCdckwCjMqkISp?=
 =?us-ascii?Q?xeorGpgrHMNTMlEGYVjClCcRm/pAYt2v130tzV1MNkXO4fUzcxXulrB2X/xK?=
 =?us-ascii?Q?3+qaVRHqGr6eZ8+5EeAJw7h23bRdbd9hNC7MagLvO9rk8SA9vWX19MquQBRn?=
 =?us-ascii?Q?Pr/lA1z5XkwdDEdGqmq7RbxK+LgxcFrSkXOtSOeInJ6gyt5zhrWhICRbsZi9?=
 =?us-ascii?Q?QvNGqELW/eZ8JJ0Ygq7FFTCtjjde+0bUeVS9CuU66onbypFLKD0ZegeQOyMo?=
 =?us-ascii?Q?s7tjAwZkQyxPotoqtad7kxQ+ByUacvrHKY0gYRDXqR7Y7sPiN5iwTQimBOhf?=
 =?us-ascii?Q?u94221HuV2pvXbNDvmXlvQCbbwq+UpVCTS6HAnB5kkNWYPVPPoyrmxJCOYYQ?=
 =?us-ascii?Q?Ct9/OzdvjKa+clakP+3VDGmzssJpn7ZpMPjSa5eBSvbbbnarBaLxbfVurZul?=
 =?us-ascii?Q?OVNR38QJNdz8h30+jYXjKAiHuHA3VvPrtKlLJkP4ReT0z67NW3yo1BVxfkQ4?=
 =?us-ascii?Q?8OeJAdVKr7xSOxOGQTel4arGceBuy0iJuklxalnwvXwHMN0ou4Wygfy/crcW?=
 =?us-ascii?Q?CMpr8tYP4RHo7wrNrNDVjksG1cVA80RJYeKkP493tTPwTk4uuDIQU9uwxD4i?=
 =?us-ascii?Q?mQrK/6yGO3+6OaBUD2TaET9HRiL55uVotPqp5BSrWmaBSPnvVA/V?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52b91c3-4776-449c-3484-08dece0fed91
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:34:53.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Or5jvnWXFUCx3T2oJHbeBEh/eBK3YaEKG9sElgoNpsDlxEMaHHiiBuLEQ2Bs78COGVG3CYMVg4pt8Zz3xxaXMFqtKlviUbc2DeJoPYeO39T2fBtUJ3JE9XtT05O8ufk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1330

Add a new compatible string "starfive,jhb100-spi" for the StarFive
JHB100 SPI, it based on the Synopsys DesignWare SSI version 2.00a,
uses snps,dwc-ssi-2.00a as the primary fallback and snps,dwc-ssi-1.01a
as the secondary fallback.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 8ebebcebca16..4458316326fc 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -54,6 +54,12 @@ properties:
               - sophgo,sg2042-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
+      - description: Vendor controllers which use snps,dwc-ssi-2.00a as fallback
+        items:
+          - enum:
+              - starfive,jhb100-spi
+          - const: snps,dwc-ssi-2.00a
+          - const: snps,dwc-ssi-1.01a
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
       - description: Intel Mount Evans Integrated Management Complex SPI Controller
-- 
2.25.1

