Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959D2D8376
	for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786523; cv=fail; b=g6XC1liJ5T0048is8j7O/PIKJcQ6UobOOM3gp6DMNApsU8ArJkGIvd9R3PGu82DhVOD6r1RfSHTfThBZtZ4mqaAm1xPB8Masi+dH3kDLsrGqUREVQMKUrbAJUxhkwJAci84srZZEgeoCK6dPrIJD3QmFeIFPgatqHnGKkkvCyJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786523; c=relaxed/simple;
	bh=X4vzg9UZBjJa/DszkYDkcEBLUYHQPQgRcaF89OiK7Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qiLRWoCJUSfQT7hENU5yaKZ8YT1hMTi279zc8Ir0remayHr3kwiPLwnP2+4m6ntPLadke5UdYKRIVc5JAcDEvpbyp9lbYRg66M/Xss2bZdM1KTWaETf/GwTaussq2Rdn6n7wTld1xahilEoeTH8VBJ4hTNrfJmwMuWb4Gy7O59c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JZJ1ZPVa; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=IY9FIntO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JZJ1ZPVa";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="IY9FIntO"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U7QMRl3276726;
	Fri, 30 Jan 2026 09:21:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=xtz/uJYcQEnZYVwy
	0fPWf1R6WAaEnYHFTa+kDM4yCgQ=; b=JZJ1ZPVacg9nH5mCh1OkZPXPA72vSXtE
	4RLY0MvgELuIKRRUvtyEn57TgwD+gBLD7sU8mC/IG9ia/WLOXqZDNhCsYCbDbstx
	cNoT9WNpZcgLsq1cWDQDB9nJWa3Z2vLsUtYmQClJL36/X1+0BFdRJ/VUjCiIrYuI
	OBiaJ8H4iR0DGV5WlnXdSUGvXfIS/AZndUa3mqkIJd7q8DAgQh2TN83dMlFVFvyw
	NPypBcOw7EOWVj6/sliUGT+RJq0IaJZ1/1OpQkB9FRsEgLiGxOkBqzVp7XfkPzDO
	EzL4fG0ctmFyJrXZe44mH3I8XPR8NHy9JtlEgQZGfNQTNk46/kJ2Uw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021097.outbound.protection.outlook.com [52.101.52.97])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4bvvc06vyk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 09:21:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsETlAijY7KBkHwVWC/VK5p8xtYVq31VfAEKcvMUsTNNjWrDI5VZPO1VFrQCy9xW1O1ZYjBqdhEnGsfSqJKsPWKEQ2CuXCMR43sd/vPRptjLnnBqO7hCBPolRI+m7ABMq9QEYhc9FruwihKPmXQPlzR/zNStI72YAj4nAb+zoso/R6SbU69g/szmzAp1WVA3OKFv9zQBDbFdlexbIOpFWg7Jc4nf/jMsrloLEiKwImg/xkroDt454dQ3BUKVpNFbPWAmBWIEake4Rk6gQo3EU4e6O0lSvriI3ZG4MAC10tizzKJZEhwGixtCl87qXVsVzY96XdLUeCMCKDanMSjMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtz/uJYcQEnZYVwy0fPWf1R6WAaEnYHFTa+kDM4yCgQ=;
 b=JSS45v20YuS9cGniQRXxhSClNGr3Q7eREw9TdBXbyKJQtNroOEiGS67bdUf51M3brSeb0DllKovpgOsPsrNKrpTbA3oqtXLkz5b2GjFoxMiMFESRluS1+J3sIou1urIKjFshQJbWA3DKOw/cIfkCJoTfABQ1Y1nnaKii6h1eALoPy023UMLyTlI0665bW0AYVSSGF53EI2XA9Yy8LU8CQYSNoJOzLmCIHzFwbDQItSEU3X78PkIov9d2s5ypLR97JOwHcaEPPLVz0uinmRP/B/uBvwF0oQK8f0Imo9ZxCwuT8Z1YClLKB4Nxkefi856TX6rqiwewKP/gNQjdP8sWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtz/uJYcQEnZYVwy0fPWf1R6WAaEnYHFTa+kDM4yCgQ=;
 b=IY9FIntO6jZPDtmd6BXNS8ANbs/Ohzstw2XkNn4x06V0cHAClxOj7N7GHTFYb1Jg993M6NuX9yJxUK27cFPuQRfkwAjYLPXy4neTWAXOGKBPUE4ZwE/JvtHHLvuDKWhrdVsHVxmJIeD39xrPZm7mYWlb9pT/X2NE3P7tdqu5svc=
Received: from DS2PEPF00004559.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::512) by SA1PR19MB4944.namprd19.prod.outlook.com
 (2603:10b6:806:1a2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 30 Jan
 2026 15:21:55 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1000:0:a) by DS2PEPF00004559.outlook.office365.com
 (2603:10b6:f:fc00::512) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 15:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 30 Jan 2026 15:21:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E8086406542;
	Fri, 30 Jan 2026 15:21:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DBFD4820259;
	Fri, 30 Jan 2026 15:21:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] spi: cs42l43: Don't support sidecar properties on device tree systems
Date: Fri, 30 Jan 2026 15:21:49 +0000
Message-ID: <20260130152149.3086658-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SA1PR19MB4944:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27e2bcc0-9ee6-4d79-bffa-08de60134d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|82310400026|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5LjaF7+9oL+Qpl02HUw7nWfQ8Eogj6BBxC3gOyhopTC70VfarEYpK9cLMYm?=
 =?us-ascii?Q?hbHTToMFegefwNmOA7TqUkSlE4a3HHsbnKoHG1WBQIwXR2j3EB44ceSfAwpe?=
 =?us-ascii?Q?5GdxFwmACUAwuI3aLL7ygEn2n6B3SmcgZnc9H38OmpFNTzNKqMCMcKFKnt1k?=
 =?us-ascii?Q?yxeq7NDyQMbIAmzZKJsXhh9elJEk0IWoFwcRadpaa74cS+ell9mjqVmqrcSZ?=
 =?us-ascii?Q?e74ygGiJrjmBjOx4un3VyO7d/dsMWXv9BBb1ALZ4iJRFXsfuBLIMZ/iiW8A6?=
 =?us-ascii?Q?hr1NzjDESvHEF6CkZw0TsRlCva33Cl5Nd8Ii0/3t3jvQtOZwt512TrokJQ+C?=
 =?us-ascii?Q?DgTy8Tb7+XwWsa5b5YEbcFq/bHObyeKnBPzF1eQ0gnLgg8r78oWulIYxO05Y?=
 =?us-ascii?Q?d2U1oHI/Z4opWnu9PhL962NTp4dxqrqwhVyAYWNQZ2IBqDoFIow/RVEeYroJ?=
 =?us-ascii?Q?tl9snh6PCzbcKsxiQDiYPtkKxZR9s7p1HiCXjLyG4dE6V90wtu3neBd2dbNH?=
 =?us-ascii?Q?pHlSjXtUVTZpTBRSacPkQPBf2Lbf/1ug+RbUI2OKfX/05Ys/Cnp2Mqe0Samd?=
 =?us-ascii?Q?8egL9vL1QeQ5b2dZ+ginEOQMIrp1ZWQVHIGMGNNcA8Nh35tklx180xdWnkYY?=
 =?us-ascii?Q?RKHTyEycaor/xdIxCZXpawEFddXXkGj0xlB0HIEiqAgKsuve1BQEpuiaCnS+?=
 =?us-ascii?Q?+KxKpB3S+LYc3cQqJPePbZ5gYY3Q30pXdc3B4uMCmk9BAufDaUByPplhMWPM?=
 =?us-ascii?Q?7yG2uRSUH7m5w/9P7HwEYsj/dDxicK+mOdqrNo3S0gIIRxPuD3pm2tUcOKRK?=
 =?us-ascii?Q?YjVrsGuA0ZbIYimOSmzRPIkzHWZfEeNdHolQYsHrVz0fej1db6nf50Sk0D6Q?=
 =?us-ascii?Q?Csz96B2vqqi16NbUw3QMhaUblx3vDjBdujHvrkYAdwLOSBlnTufMGpwjPtYl?=
 =?us-ascii?Q?41iW22HYzhe0fm3klfUUTvb4DuS3l7xHCQkOslpC3FVlikLgDq7OgY8Z/mqn?=
 =?us-ascii?Q?MMQjPcXpHUsQLgicgfbhp+UEoN9gHg37MZWygBghaoIWOUI8sx3Z+qyUbh8o?=
 =?us-ascii?Q?gKbI0oATjdkLMR6nmPl1Qaim2VUu7Ih4lkdlZ8GSnFaLEHH/lWFLV3msKYLO?=
 =?us-ascii?Q?GErkL59xIFd2ln2c79wHiB/ah6usWE3Az6Xj1cmhpbo5X4ealQbEqJN5nDZ0?=
 =?us-ascii?Q?QYD1ySGU2L//MKEWL4SgU+BbSmgHDtRHCd+J92eY7mMmZP5OUPv3OjTD9p14?=
 =?us-ascii?Q?cVENHTeXTJhMOmXvJksf3EAB0TORQyd83IrNnzug8ARD710TwIpuifJRmusq?=
 =?us-ascii?Q?mYtCXyoAF+1bY8rN7BStJGU/PmEqOfWMrK889zlhEVCXw1iCfsDQgRE5KaCh?=
 =?us-ascii?Q?0o935gGyLoNTlUNmet7PEWewJwqxjq4qanhcFwdiT+qG8d78KAZOarmJBw/x?=
 =?us-ascii?Q?d9vMca0hd7U3GgzJ/qnjlzSw96kEbfsHYJZTpUbChQfVD0pwC7m+ZiMoZrE1?=
 =?us-ascii?Q?B+WjbVUPOH2BZBub/fd2k3oyO+8Oc9xhkytV3Mt04wb4FNjZAR2RcSIq0ooa?=
 =?us-ascii?Q?PBh4s+b29pAGhS7yXpqxQ6yupyqXpeiUOaW0vv2SJeeIZaoD1w3ODCmEoRzo?=
 =?us-ascii?Q?kCK+RgewLabmASBjdZFfn+IsKghvhRXUqNaHIqFHXOZkvtrwo1V8gBUhHWjL?=
 =?us-ascii?Q?RBPxQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(82310400026)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QjecYz+bLVYMrlcYjS6ubsThDxBIYOUGOl7t2217C0Yn2uJfIhwXC9xjPg/F8gTex0hunoB8ml6tIgWtoq6ofrbnlMQEwJBznOwSHu1v8HiobdvHl2Zzi9KXKXl4knJuwK5pylWrTbfEnlygQGZjkBqWxaZpZoKIB7LOyIj+BnuoQTmgBHFEx1r02+WGSwxm9OMsv115wmPKg4vnt/poFRgFlZO+tvzPzicFT3j10ib1sCoIwJkJ5j7sQP2w+eBNU5ZSvDWK1eiUq7FUKukNZTw2F0xxlMM2crU3NubgRjM7KRX9VncyCFtPEoaWzqk+pD9TyfWkMOowzsjOMXa2QBz6L38LULCzrQEk+Q5qW2YuC3xM2ANsqQ8jGXLOME7+cyHsk/ZLmVd/1JnQNErqabtcMQjithfbCHTrEuAkVnIXaRwSZaox7r3L1rgOVhwJ
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:21:55.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e2bcc0-9ee6-4d79-bffa-08de60134d6e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4944
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNiBTYWx0ZWRfXy92jxkY8GtJq
 iWFr1qDzbuoPXZi/ZIqAPqyskVRdTno+aRxeweEOmjX3cIEnyGbu0piJgxPjclVP3pLaNQUpZUj
 BVnvP6k3TBIxy+XUjMfgGDfsEzVejA6M3v0E7veSWNhKMCA98Onpw0G3HzwRMfMC3MDJJRl4XLj
 oCkL09+pR8oFJFTZ+2BceNPnzeSD+lAHxGLVi+TP3oxAMrJZhVZIKSoM5gaow7H0JGwnK/oChtM
 60SQhaUb7FtwvKj8ko1gC5db57whmykfSsOQEko1OWj8dKYoooPU/aEqGfuKPn3ngoTyJem3Sru
 VJqDCnlY8OKJf6zpC9rgFfUpYjtrFvaoCyOA6EcyqVk7OuvSyfAcXQru1hzWuKUJaE+5RdSmaDq
 ALx6vJMKKQFRPBddWMV9V/DI/3FroaYRmyQdBzuSNVZaeCVBNgyo6XLhHxrjR42Ur5iOyfr+xgI
 3wfFkU8Mavu1oJWR2gQ==
X-Proofpoint-GUID: 1TQuAXx_pyOYa2cx-ALXVsTFOR1hPYLR
X-Authority-Analysis: v=2.4 cv=KvBAGGWN c=1 sm=1 tr=0 ts=697ccc97 cx=c_pps
 a=is7RXpa33aREoC4jGqxG7A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=T9bqrr72WB-eOfrobEAA:9
X-Proofpoint-ORIG-GUID: 1TQuAXx_pyOYa2cx-ALXVsTFOR1hPYLR
X-Proofpoint-Spam-Reason: safe

On some systems the cs42l43 has amplifiers attached to its
SPI controller that are not properly defined in ACPI. However,
this exists to provide compatibility with existing Windows ACPI.

On device tree systems this functionality should never be used,
there is no reason not to specify the amplifiers properly through
device tree.  Make this more clear by only allowing the "sidecar"
functionality to be used on non-DT systems.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 4b6b65f450a86..b3a55c3ed1b68 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -367,10 +367,10 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_of_node, fwnode);
 		if (ret)
 			return ret;
+	} else {
+		fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 	}
 
-	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
-
 	if (nsidecars) {
 		struct software_node_ref_args args[] = {
 			SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
-- 
2.47.3

