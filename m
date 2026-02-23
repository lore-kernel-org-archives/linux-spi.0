Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9635B621
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841250; cv=fail; b=OU8RhJ7eW85NrGSj/0WROZRNjKXhx3BRqvzZQIRULW/+7hcGXxW97ymXTWOIVU0rW82LKgH3gbn5JfMtBjURMVGg0JMCBpCMBKR8g7MWFiDCccIw1gJzQsd/7bjINB9rftL27iNnPhTipST0zFpjsrD/ybNLBbvOdzRU9kJzihc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841250; c=relaxed/simple;
	bh=OrBLW5Ge0BpsObSgcTifwBwHEjcckiaCqf2naWcz0A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECUjxJf+a7zWQH6YrpMM+qB/48f/Vyc2VESqgrK/10QoVoqdNZ/F2emn1vcEt4mYoNnLsNLjT6C87B+WK94HKgGkV0kWgGkkoAd5dx1wRJVvNuFfqvVgmFPFS2ddnkig2bdLlqfkSotcGmTvVoGXAH1fiHM8iXAZF49FUe1ntfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZBwCAoXK; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=wV4zuJSu; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZBwCAoXK";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="wV4zuJSu"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4f4X1980569;
	Mon, 23 Feb 2026 04:07:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=fnn+qqv+hvIbNPuC
	FG9YsVnXjGdgThq7Qa+TqAksrvk=; b=ZBwCAoXK0w/elSW9mQIKiaSIUL6wV7uE
	y63DZxSpvPM0E7VRe7fgQF3yL2b28G5beBBNciNDqxO2pJaXBZVztqFFg/D2wl84
	tCZFeLVkGT8mMJj42r8aKLiq+ABhncYtYqh4rAPSr64gcZP8z6tkV+leVrj2b3SF
	AaRNfnRrskTNaAU9Goc06Ywt6MO0U/YVEQK1zdr7niKb+LZkhM5ZnQhbkGBWD+Ry
	u9iYpd25KWYNxHa2hyPvbbOANSOfKugRNoIWv22iAmPdjJ0gPQvcFWXEiVytVj4F
	w+Mm6yO++yjUWdgRc4iAhMNP2KFOPG2IJrXncbOl2eyRnhmPfVNUdQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020135.outbound.protection.outlook.com [52.101.56.135])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cfb019bxr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 04:07:26 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh2UGBEkGmKOUW+ORCha4yptnJdSI0xr4RAjPRnpfN9plAgXzwL3v6WtsWcsQ2TRxWPXJz9KUm+G5WOQXl5kDvuy/ZmSP8/Kj30DUAYougOVfdReL5aLLZSZcGEOVUR9bwldHmwG5t9e+Ht6Q5DxJ/I36d00hAskPEkik3EaIUpxX+SEtSQwh7PFoPERqQ7wzBBOM1uZ/iH4AqGmo/s517EIjmi9UkYJC3f19ALrW4n29aQ2mq/ZsXiIwVJV9lbe34gc+59ouIvoxDJWyCzPbOLev8ceHfu4oirtKg2KMBITKZArAAIJLgWW3EU3BqPBGiZvFAZ0kr5zX5x/sEAjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnn+qqv+hvIbNPuCFG9YsVnXjGdgThq7Qa+TqAksrvk=;
 b=aayIoqlz/wY66YjXVKyj36Ut71wj+W+KhcTo8VIzIfE+7eOJD8F9+o4HmUHKiRexXq/NY/KsewmieiZNqkRMOi4uZSeL06xnlAcu9ejITC7FFBdW+9BhvzZ60V9rWQsWo+lNs3TNk76fi3O+kxe++BfXBg0//VLBoPXpEkUmVAtl/pQ5Zlct+kaht+xKpWzU3A2//MAsaP5uaXpeQ3mak/Sv3kcr1TCGCkgpUE5BbQqV74RtUsElKRlv3DN0zRtFEJIOfK5YcrLz+WfImneeyj6dgX2Nj8CIA0TVloZrfXPQKz8kB9mPBJm0BS73hsMHGagAy3IPD+hSrFCrOPQ+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnn+qqv+hvIbNPuCFG9YsVnXjGdgThq7Qa+TqAksrvk=;
 b=wV4zuJSuYWrN7RZ71NikjuespPTZADfb3UE8N3rRxmgST6XU0CevCtP1HlZ+jE/GU0asrm58HcD19qH6XcWODOS2G3Eas/6x27hl6crid6sxVf+Oxcmq74Hh3E/yUoVdfCt+zuS2zdCnR/MDndP5FK1NyorfPr+54/rzsbBsWHg=
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by CYXPR19MB8485.namprd19.prod.outlook.com (2603:10b6:930:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 23 Feb
 2026 10:07:22 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::3c) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 10:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 10:07:21 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 49AF8406541;
	Mon, 23 Feb 2026 10:07:20 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3A90382024B;
	Mon, 23 Feb 2026 10:07:20 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH RESEND] spi: cs42l43: Don't support sidecar properties on device tree systems
Date: Mon, 23 Feb 2026 10:07:17 +0000
Message-ID: <20260223100717.4011114-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CYXPR19MB8485:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 84438158-2986-4202-1a49-08de72c35605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VseelGjYDmzReRpH1E0KdvYvMVFvUpULcv6e7wa+XyiD2o9xt28ZjJ3BZIUQ?=
 =?us-ascii?Q?DM/Aicd+VaGnRzUNrtytecx/3SX3DZcv+nUSw1EWOxacPOGqnP60nyrA+f/S?=
 =?us-ascii?Q?8DTr7cuoK2dSR8TwXybgw/nsoc5iiq6HLnj+gZ9Xs0aV7BcqntHndQysDuoe?=
 =?us-ascii?Q?I4hY5txxzQ+jlRQn0d6VSzKdtDaCAO8+0l/hKJBdLR9WdP0A5kRQKlHoDCbm?=
 =?us-ascii?Q?pHdPcLIUGqPI8Dezs85NKrLOMIlpj6N6fS34ZymhSsL5SOIcHyEquem9a6UQ?=
 =?us-ascii?Q?aKG6LqyF24vBnCCdVM8v8WUrDxVo0ER5L8CYpmrdsGOHiEBD40+wBOo7TKrY?=
 =?us-ascii?Q?9Ut75AAdBCvNeEOoaiYxahP0M5dzG+My3F7/5LG+BOBFt/pq5ehZj//KcqNd?=
 =?us-ascii?Q?cm+7EhCuHiooWjBtEXLLHqffuHDWmGx82mZaifvtGVh4ITwioDakkuDFqtNX?=
 =?us-ascii?Q?qDdYZXqHGTpmddLJGD/bRPo3FLeRBN4K+wOKhLlI62zozdAjbs1W8jUwGjP3?=
 =?us-ascii?Q?Kf+y6pp/O3uTnU7ir0owt9x5W8ertJ3y6nMx5gemAQwykEgS18KxQzlZRfYF?=
 =?us-ascii?Q?FjtdDCfx+A2QNCEDZ9qgMc5YQjBFRLziIu0IKoEPSp+xfCEu/lk7j/MC6OmS?=
 =?us-ascii?Q?iqoGpZ4zZLm9A/hweyfJvqm1Vle/PK2rnAm2aJEjAnisO92zA3ldES70ZZrk?=
 =?us-ascii?Q?+wjbVlWGlS3wiOGRF08wlUgWVHS83zYt0DBfhsqzGqfG4im+TeEqia5mWNR9?=
 =?us-ascii?Q?7jblzeVcWFEGeleb9Ml6ttiUCoyd2MmSu3ERB1Zf7qxfXJYKZIoeyd5WuSlO?=
 =?us-ascii?Q?199ZfdMt/LMu26I3ZkxkLsXPwe+gZYtit1AECZR00kSPk49rnfMceKUJVMHf?=
 =?us-ascii?Q?lTC0kt2bfgifmZzin7CSM1hIJkBUcY69vCRuRfKeVt/G2TPJQkIzhNgsKcdo?=
 =?us-ascii?Q?SfSm3R/X/86wLBfyEi+unr6AVexqVuQESvFwfDZhlq3Y+pSwKcfX+wY8ObCp?=
 =?us-ascii?Q?b/RtjNEJ4kpW6gKD2DL7a/AoPuekZ9rTOE7IX42cWF9uG8pDaY+8/kaih3EH?=
 =?us-ascii?Q?Ft/yuHPN3P53rusDuvrXSYHP15HBHZuvzhJ4Mja49v27cufU8xL7NryZjDzE?=
 =?us-ascii?Q?MX7A1cuYDQ+1uY0VGxKCOvybGokqyixK0q7xApJEU17+pNcUEdl99zutpriD?=
 =?us-ascii?Q?UwABEkffubEgIPllST9JahVu0KI6cob/v2CrwCJGVCR043YBYubxZdOa6Q9Y?=
 =?us-ascii?Q?GXGg33Eo8E1ecHU1UgjEYieXjtgl5s/kN2qFIY0PmlZ9la3zXfhzGjvaQAyp?=
 =?us-ascii?Q?QB8qZL7mTeCjIp1jQq2+MLgm1QtOZ1xdaeG4q94LwNcaeULoxYGWo4+3z9ef?=
 =?us-ascii?Q?eHXgFVaYcN7sJhi7DF8+FvgHK8GE4FyPWIM7E1gt3rnSQI494KDLcW8Ogd2A?=
 =?us-ascii?Q?OuXRz+zL8Mgd1bm0QYbvIx1f2ifQ9mSWuvIIncP1+FMKQyobxcAokbakdB70?=
 =?us-ascii?Q?IJjWZHAcOPP7GVDu4sx2+GEFKtuuOxps7BjgUjuQYez4oEWx+dGfYoOmwNb0?=
 =?us-ascii?Q?HozK0QpWekg3iApGNl6HclFta4L6yrRk1XkErfkuHDA74zsqjyeYb2cLkstb?=
 =?us-ascii?Q?8XeKGMhgj7B8dIeibyMXniLM+7tCj6RCboJsHgFoxLJNEaOWenrNQ7SzQrJE?=
 =?us-ascii?Q?Rwoi4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HPEC45KNmxHxfCSVA8ejCSOM8PINLNC039QpP7GoY+JHx65B3uK6LoXPsQy3K2hFPjWtcO2I3L0OtM99RuzPc1VoxLNSlGtQyyJ+C0bJ+fpVyctai8k5E5rd6r2EispUiFkKtyW3WqLUoDoG0D3JyhEZAwfbFOQIzZsTzKWTP3mCABFHOeDvpr2DEUoAnS7BIEmnSTY56AkrwQZKXffrjpQazfOPUMP7ySQpsUWvfakhSNSF/57oygdmDZ3V+mD7VPnF8ZENYdKzlgpzBBOsnJAGCFEyRVR4SN7n9LQlUfQ5X5aATQeTEjMVNRFtgv78aa9jFZeOzxj3Adhrr5pGjYm/6U5a14NODZqs2bNIHzPTD2TK6mCOVG3WiJ7Y/tTmwlHAyrqe9bAGX6CZqaW6GidSgVcyhlt8uFgprH+DFtto+ZsIMjoO0IIAOytfiRM5
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 10:07:21.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84438158-2986-4202-1a49-08de72c35605
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR19MB8485
X-Proofpoint-ORIG-GUID: V6LWOMGne1A1GU5BysczJyMn1-nd4NtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4NiBTYWx0ZWRfX3KfLmJORG6RW
 0JcaR278YuBrscX8WJ+7Q0NARY/GtiHmFqFH97BTl9jZgs2jZCCEslBwgrJETOHh8DcJULcrKxH
 tS1Lfgwo49i6XA+9DwOwCY3Gb3K5ShhkdCMPND/mJAcBpMZQ3hFgwPHjhSibz7CFunfm3h/hLYV
 mKdNTJfQIINLWenQxHkrfY9YjW1qQ2co7WT+ZIkpaQE7NLXWRjilbc5N+n/kIJwVhgaK4KQBVhr
 1ws3QtY8a5nqYbHcyMq2G0+r0HkAcRwWyR2uUBLsFdAaYevlcAnBLlKnrA7iw8vge7etbYsUi4O
 XgJEPU9+dCfF8tZJi1jrFQ0jXw8cOq2R7Vt3xQT1SiNds0gD0N0g4y5y2YGnGLqiZlLp/TNwhpL
 QVxe98qIsrGZErnsPvDVC2UBaw/LOhOOOMn/HEreV3PH3udJ7R/oVoxB4J1iHU3ZTobRCJH9Q3e
 3INNGBxpFLYnwOk449A==
X-Authority-Analysis: v=2.4 cv=V99wEOni c=1 sm=1 tr=0 ts=699c26de cx=c_pps
 a=7RdxWpphQ0FXUQ9+5PcytA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=T9bqrr72WB-eOfrobEAA:9
X-Proofpoint-GUID: V6LWOMGne1A1GU5BysczJyMn1-nd4NtS
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
index a4a650c8d7405..68f208ef1e01f 100644
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
 	/*
 	 * Depending on the value of nsidecars we either create a software node
 	 * or assign an fwnode. We don't want software node to be attached to
-- 
2.47.3

