Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1A43D4E0;
	Wed, 22 Jul 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757673; cv=fail; b=LcMmVPJpYJD7M28TK+ZYimY8DKRsk0PijpQk+W/OJ6zXuDUDd0QLgtuFBQgdCAFTzDW7J8MaUsSDspklIrepC4c81HVr97NllzyFNPe9ygBVBie9r0yOLw8KkjFzOMAf75NynI3hcKdL1k/zMaHIc9AsI5CQbA0my1+CwrUP7Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757673; c=relaxed/simple;
	bh=GOmQV/zRkSa2cPzgshrNEMlUr4EwlHkcbAjlRraJcRk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gM+QzXaET4mwkQSbWDc8B99uRtk86MDBWj0Haoue/BsJ4+00WWiR0UYLKQSNIYOiTA2x3xibsmkUcHWLv7Qm4Xsi3zG3STvooa/ocqWHNHiVN4PH1b24hcg5ZjVFX0ugton+x5jWPILpR1JKO8AQZkJ52XYjXJ1aT18QheXwUKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t6giOm44; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t6giOm44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0exvZnMPcpE6zmA5f5qAjYUcQ2XQO8WfDcgMoHrkmdeGwQyUSvRpKMedYy3etVBLEW9ofoXozXLBBAu1uSez7xPc7hrffgZ1HBktW24IPMg1kNQSOz0hfUtpoXr8H2+v9w01qFu4hw8KnyvFfrwds5OQVOljksv9PlzsF7wxLNX1HTt0FfxlU7TAKZZI75uz6TY9PJC3Tn+Lg8YP2CmfL0dm6sMSyqVD/XVdT9HzICettvmYwaaYOrljfa4ID9KkMz8lNQIH15PAAEI0pmzK3K5cqvXuN8L36gj5uebrKXWReXX8GQt0UZfHpELBiWUbIZfsU0M95jPPlY+UJb9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTNTuTI841mUK3zmBV4Zw/GMfGQammM31IOFBSPoiNA=;
 b=O8wfDep8tluuazTifbrGNg696KcWN7t4FUtui9F1ZeWLwUcY5tZKjBHV85XeCdMdNpORWCs/YLe7m/v2wQzCTtLnYOmzZ9g6eH3H8GKWmWwy0fDwff6mZQJdHPQoAlTDlgBZdrZfjft6h3MZwBWsuDd4JPdG1+4X6Q9720pXUeXz+YrWBreFiRJhKqfg+IgcWrhIiNYeOddrGz+p7D3SBKxnpygvnR3VjnZCHSy8IlgmxMf+aun16wNZ4eQCQwVpkpTK2rnGYEOPIcYL9LT0QzXKKm2eIiCWSBolSNo2pXr34jd9rG5xzmjatCZzsG3Ndx4n+66sroOyXn5HW8M0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTNTuTI841mUK3zmBV4Zw/GMfGQammM31IOFBSPoiNA=;
 b=t6giOm44j2nd/s4lYPe0VT2EEZzGjAYgG9nvIYRZQ9AnV7IXv9VsM06AZoUT07N4/IY9/qT9BVntFqBvKB+nfGPlJTcc1u30eLRaGCPDtUTKAtMoF9tUbVVQnJS4OljEOT3M6AhzIzMQubAuJSjfToIviU2Zvcbe9Y+VP+0AQ1rtYe4UBb6ldUv1GwSR6HxI7y8gu15W1Vr+csiJGYouFkfkRgDvKyzpwL/L5SrUMfUXYqgwhXBg/kzbGUjcSBEYrBGdZJ3tz4SvYeuY82d9pVb12M++5b+Q5zoq5m68iwu0I83eFVm60plz1T9Ksb5LhJ0xtlHyS7xDTWww4VchsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by AMBPR04MB11809.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:01:06 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:01:06 +0000
From: han.xu@oss.nxp.com
Date: Wed, 22 Jul 2026 17:00:43 -0500
Subject: [PATCH v3 2/3] spi: nxp-xspi: Improve AHB read performance with
 DMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-xspi_dma_upstream-v3-2-6b7ff50cae8e@nxp.com>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
In-Reply-To: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784757654; l=7240;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=1lxbCnQ0uzLQBru4HgkM8VP7ETtGFx9gI/cOm8PlJBw=;
 b=LifX4YPeKr1wj8jWx+4ClzlR99vjQW6c5ae73dhwcSMG7TPs2ssWAWR5n1Y/GkG2bt5pYLHNi
 XYs6UT9qSNICyol0H9RQc9Oi4/b7Fsk/PpUr6obkGIRafIiEn0mJ5Du
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|AMBPR04MB11809:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9cafeb-11df-443b-70c5-08dee83cbad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|7416014|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O73d1a8MsDmlYfbjSr4ZJM/qZmhjHwYbqWXjSe+pS5xTQuxu+Go3BOwpN8+Sh6G8ISXMikyfbet5B3Uz6nzC5iLdMJJUojycpn60vsN21yFfMfHukem6xj+tgs8OapVLJdLjlHkWhydmxE9LirXZWU0DTJpDZkA3v+VaPZTHArh2rVXL4B2zonelU5SFyX7aIvBc5iEL6MhtQxEROk30UDWEfcFrOZa3x4oiTpEhL//XS/GA1uERvC/Y77xEAtpdeTMw8toaNhFV64pK4HZVEgvdA2Wh3C60xU/UMSXd0dZdMepHZePOwmg1ItGEiyj38XaBV0wrQ0wSg/nGmSbGP+hRY/SkbDVqtnkY8zra8YatH+02oUg8Xf51RLPV7TAfELKuA3VoFxCKYSCtV12lqUQ43RKKooqW263hewjRTXuleyE7q5nt4NARzbvLcW2NzXo2QyN6+g9t85EtQNz2fiXsFfSqfvxgug9dfqr7s7IWXl1SdBC3cpAREzNRt4j7Bug9ix3s8KelwlFVB/5pZ6dchcXX5P/hJu8A975+YrxBn1HMH0O6pdfuRgzru7HO4WV5vhATLY7SkosjhZOmRkTiLfVm3UcRL6Mpf6JWePo6D4GnaTvwp29KwfGEEgga/4pLlnTyORJA/Roc21dB662AeoDfWvKWR+7tqhd5i9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(7416014)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpFKzJiMjhneFNmdVpqckhnbEZZWDZ5eW84SHEyNWtKdGp0V3hLTkJKaGgy?=
 =?utf-8?B?cU44OE9YVk9WTzRVcEpIc204RUJiRnFlYWV6TGFDRTBmU0hYQW5iQzZOb0JG?=
 =?utf-8?B?cVdnNlF6L0ZvdlMyNHFPbjRicjBGNEcwRkV5bHVmN0xsclErSUpBSmVvUVB0?=
 =?utf-8?B?eWxQUlRmR0FoVDQwME1kc213Y1o1NzNoeW5sUUlaQ2R6ak0zR004cDB2Q2ln?=
 =?utf-8?B?blBKbkVhRTFFeFQ4KzlrdktLcGNHK3VjRGV1WWR4WW5jSjZ5SmZiM21ucG1C?=
 =?utf-8?B?R2FuTmZwOGU4eEk5cmtTV3d1T2YvZFlINUJ0VjF0M0J1S28wSTA2QlFkMXc0?=
 =?utf-8?B?WXV5bFVvTm1Sd2xiTldBRFBqUDE3WFRYZTdUYlIyUGZ4S1lKUnoxRXR0ZDBw?=
 =?utf-8?B?YmQ5U0ZVWVhaNnVqelFBMVVwMHRoV2szZ3hGRWF2YzhCcE5xUGpIaFpVUENS?=
 =?utf-8?B?RWNtKys3ZUozOUN5MW9Xb3o4UmV3a2h0MDBnMzlCWEFCbSsyb21aalk0U3ZO?=
 =?utf-8?B?eEl6M2xOV2JRMVNxOGtwczhZN2oyeEpSSnNmSEQ4ZXB4N05uSGxDTHlsbnll?=
 =?utf-8?B?aFhLRFFCSk50eFhWMmgzMm1wZnVRUDBvZUU2UFNTSjEzVzI0VVJENTc2cmZi?=
 =?utf-8?B?TTJPKzJuWG1NRUVlVnBLQzdvSi9ldU5UUnFQaGo2dHlOb094RnMzb3Z5bkFX?=
 =?utf-8?B?QWJhRVdLOGdHbHUzTlpVditzUFcyOTdmdFliSERBWUxTcEZLL2prUnM0YUx6?=
 =?utf-8?B?SmJMWDJFNEJNTm1HSmUxOUhwRE92UDdLWnB6N256Rkk2NDlqNjZLdFdMSjR5?=
 =?utf-8?B?R29mcUo5dk5OTnp1UGQ5YmZPeHduMUdYak11UjhXTkxxWmVNNSsrQUdwSEZP?=
 =?utf-8?B?OFl2NEtlRXlPemJrRXpCYVdaQXhlcG1MZGhaL1N5SXVIQlg0empSQmR0SGFh?=
 =?utf-8?B?cHhDU044UVgyQU81ZENuWnd4OFpEcjJtcjhxMDRkTnJwU0xtdjR2UUw1WVlT?=
 =?utf-8?B?U1oxMkJPaFI5TW5kaWFEV0RQV2w2WHF0SVZsTzFpZnc2YWhDWnZtQzBTMERJ?=
 =?utf-8?B?ZDZyUUpGMXNDZUl4VDRyQ08wL1hvNkJDSzMxKzlEQ25ncTV1eXBqSWExN3Vi?=
 =?utf-8?B?Z3QvYU5tdVFZRHpuNno0dDBlOU1JeE9vMEZGUzdTYVFXUnZaeFhGVVRWK21E?=
 =?utf-8?B?U3NteHlUNmY5Ti9hUnNSY1QrN21EWUxRZ0NWQkR1c3UzWEdyN2xRQ25aWW54?=
 =?utf-8?B?ME1Ha0oraFk4Z28rOEhRZlBXUDVPNnNPcS9vMklUa0FxRkJGalp5T1U2WFlB?=
 =?utf-8?B?Y2pVWVpTc2pCREdrVFFWTzI1U1J5RDl5ajhrU0JNeUhIU04rMUNYM2txYU8z?=
 =?utf-8?B?RjVuUE1scVVMNmYzQ3hSNUR3dGY5cGw0S28wbFNuRjNEWnRaKzZnd2l3L3ZX?=
 =?utf-8?B?US8rejZueTBvaXZORVNvWitMZXZER0pRL2FCbVlscFN1d0h0Mm02N0J4Y3dE?=
 =?utf-8?B?TWNkZnVWelVRUGhTN3ZnVnNkMzM0U0hIZXhBQjV2Q2taNVBFakJQMEhKaDdK?=
 =?utf-8?B?V3d1QUo3dVY1STBsWXkzL0J5YldDak0rWnVkSVVxbFlmMVYyU2w4eWhmVzRa?=
 =?utf-8?B?VHJmazE2TGtiUnMzZUUwbHRocklsZWxicE8wSnFYbEZXb0VnaEFwL1VwR0tw?=
 =?utf-8?B?VGdGckR5SWE4cmxGWXRtd0FIMlgrdGJMdFhhNlRpT200NmVrQ0hsWmw2Mmpt?=
 =?utf-8?B?VzdUVWg4Z2crN2R5T2taS3REWnVON1FTcy9jZmtSMU96RTV6TGdyMUZMY2Zw?=
 =?utf-8?B?dzZBYWVSOWR1b2k4TWlFTFdZRGk3Ui9tZHQ4emN3L2RjejlUblU5b3BKa3ZO?=
 =?utf-8?B?MWlJSjhvN1M4WS8vSnBTTEpkYWZyNnlFWTk0Vms3bTAyV1N5clRoUy9aRTN0?=
 =?utf-8?B?SUo5UlBFYm9INi9neC9TZ1MxSW94Q1kxVlYrQmF3bGZFNHpWRHZDaVEza2h5?=
 =?utf-8?B?Si9XWXRUZWozRE1JL1VSVHFXVnJMZ3J5bjlhdGFpVzVDWVpWZnBJOUFFNGdO?=
 =?utf-8?B?UUk5cEFNaHR1TWJZc1FIS2pqRk54VUp0cjFKMXFzWTdaMlRwTGprY1ZaeXhh?=
 =?utf-8?B?RWVRZW80WDBMamFnU0M2bUNKMVNkWTVQc0NQSDB4d291bjAxeU0rWlE2SW91?=
 =?utf-8?B?emt1WjY1MG5wd1hhTzUxdkZhVVB2U3A2b1Q2NU1MQWZYeEYzRGZLcGRZZWVN?=
 =?utf-8?B?U21iSUVSdU5PakRqSVp6LzNBMGw1OVB1QUdGUFRJOFR2dEtvbUtrTllTck9Q?=
 =?utf-8?B?dlV3S083bHI4d2Q3ekx5Q2FVWmFIY29zNURWTFdhQUxBSWlyWjZLY3IyYWlu?=
 =?utf-8?Q?2vXrn+/IJG6nVfHk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9cafeb-11df-443b-70c5-08dee83cbad6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:01:06.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8PQN4g6Rp0VeWJwW/IsJlpgajV6tM3mhnKl0BEWohOdfx1uWAwMr3ahLnzbMCLmiquZeZcTFLk0C2EnJFlOfmIQs+NryNvfxGpRbfhYqjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11809

From: Han Xu <han.xu@nxp.com>

Use eDMA for XSPI AHB read to improve the performance.

Read with CPU
root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
1+0 records in
1+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.479719 s, 69.9 MB/s

Read with DMA
root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
1+0 records in
1+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.115788 s, 290 MB/s

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-xspi.c | 143 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 037eac24e6fd2..70cbc3ef658b6 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -35,6 +35,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -303,6 +305,12 @@
 	(opr)) << (((idx) % 2) * OPRND_SHIFT))
 
 #define NXP_XSPI_MIN_IOMAP	SZ_4M
+/*
+ * It takes 0.5s to access the entire area with DMA,
+ * leaving a 10x safety margin
+ */
+#define NXP_XSPI_DMA_TOUT_MS	5000
+#define NXP_XSPI_DMA_TOUT	msecs_to_jiffies(NXP_XSPI_DMA_TOUT_MS)
 #define NXP_XSPI_MAX_CHIPSELECT		2
 #define POLL_TOUT_US		5000
 
@@ -336,6 +344,9 @@ struct nxp_xspi {
 	/* mutex lock for each operation */
 	struct mutex lock;
 	int selected;
+	int dma_copy_align;
+	struct dma_chan *dma_rx;
+	struct completion dma_rx_c;
 #define XSPI_DTR_PROTO		BIT(0)
 	int flags;
 	/* Save the previous operation clock rate */
@@ -796,6 +807,95 @@ static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
 	return 0;
 }
 
+static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
+{
+	struct dma_chan *rx;
+
+	rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(rx)) {
+		int ret = PTR_ERR(rx);
+
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_dbg(dev, "NO DMA RX channel, falling back to CPU read\n");
+		xspi->dma_copy_align = 1;
+		return 0;
+	}
+
+	xspi->dma_rx = rx;
+	init_completion(&xspi->dma_rx_c);
+	xspi->dma_copy_align = 1 << rx->device->copy_align;
+
+	return 0;
+}
+
+static void nxp_xspi_dma_rx_callback(void *data)
+{
+	struct nxp_xspi *xspi = data;
+
+	complete(&xspi->dma_rx_c);
+}
+
+static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan = xspi->dma_rx;
+	unsigned long timeout;
+	dma_addr_t src_addr, dst_addr;
+	int ret = 0;
+
+	dst_addr = dma_map_single(chan->device->dev,
+				  op->data.buf.in, op->data.nbytes,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(chan->device->dev, dst_addr)) {
+		dev_err(xspi->dev, "failed to map DMA dst buffer\n");
+		return -ENOMEM;
+	}
+
+	src_addr = dma_map_resource(chan->device->dev,
+				    (phys_addr_t)xspi->memmap_phy + op->addr.val,
+				    op->data.nbytes,
+				    DMA_TO_DEVICE, 0);
+	if (dma_mapping_error(chan->device->dev, src_addr)) {
+		dev_err(xspi->dev, "failed to map DMA src resource\n");
+		ret = -ENOMEM;
+		goto err_unmap_dst;
+	}
+
+	desc = dmaengine_prep_dma_memcpy(chan, dst_addr, src_addr,
+					 op->data.nbytes,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(xspi->dev, "failed to prepare AHB RX DMA descriptor\n");
+		ret = -EIO;
+		goto err_unmap_src;
+	}
+
+	desc->callback = nxp_xspi_dma_rx_callback;
+	desc->callback_param = xspi;
+	reinit_completion(&xspi->dma_rx_c);
+	dmaengine_submit(desc);
+	dma_async_issue_pending(chan);
+
+	timeout = wait_for_completion_timeout(&xspi->dma_rx_c, NXP_XSPI_DMA_TOUT);
+	if (!timeout) {
+		dev_err(xspi->dev, "AHB RX DMA timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+	}
+
+err_unmap_src:
+	dma_unmap_resource(chan->device->dev, src_addr,
+		op->data.nbytes, DMA_TO_DEVICE, 0);
+
+err_unmap_dst:
+	dma_unmap_single(chan->device->dev, dst_addr,
+			 op->data.nbytes, DMA_FROM_DEVICE);
+
+	return ret;
+}
+
 static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
 				 const struct spi_mem_op *op)
 {
@@ -1016,10 +1116,21 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 *     all use IP write.
 	 */
 	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
-		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
-		err = nxp_xspi_ahb_read(xspi, op);
-	else
+		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size)) {
+		/* use DMA for transfers no less than ahb_buf_size, when DMA is available */
+		if (xspi->dma_rx && op->data.nbytes >= xspi->devtype_data->ahb_buf_size) {
+			err = nxp_xspi_ahb_dma_read(xspi, op);
+			if (err) {
+				dev_warn_ratelimited(xspi->dev,
+					"DMA read failed (%d), falling back to CPU read\n", err);
+				err = nxp_xspi_ahb_read(xspi, op);
+			}
+		} else {
+			err = nxp_xspi_ahb_read(xspi, op);
+		}
+	} else {
 		err = nxp_xspi_do_op(xspi, op);
+	}
 
 	nxp_xspi_sw_reset(xspi);
 
@@ -1029,6 +1140,7 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	int alignment = xspi->dma_copy_align;
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		if (op->data.nbytes > xspi->devtype_data->txfifo)
@@ -1042,6 +1154,22 @@ static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
 			&& ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
 			op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
+
+		/*
+		 * For AHB DMA read, align the transfer to the DMA alignment
+		 * boundaries. If the start address is unaligned, shorten this
+		 * transfer so the next one starts on an aligned boundary.
+		 * Otherwise, if the length is unaligned, round it down.
+		 */
+		if (xspi->dma_rx && !needs_ip_only(xspi) &&
+		    (op->data.nbytes >= xspi->devtype_data->ahb_buf_size)) {
+			if (op->addr.val & (alignment - 1))
+				op->data.nbytes =
+					ALIGN(op->addr.val, alignment) - op->addr.val;
+			else if (op->data.nbytes & (alignment - 1))
+				op->data.nbytes =
+					ALIGN_DOWN(op->data.nbytes, alignment);
+		}
 	}
 
 	return 0;
@@ -1203,6 +1331,10 @@ static void nxp_xspi_cleanup(void *data)
 
 	if (xspi->ahb_addr)
 		iounmap(xspi->ahb_addr);
+	if (xspi->dma_rx) {
+		dmaengine_terminate_sync(xspi->dma_rx);
+		dma_release_channel(xspi->dma_rx);
+	}
 }
 
 static int nxp_xspi_probe(struct platform_device *pdev)
@@ -1283,6 +1415,11 @@ static int nxp_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* DMA is optional, failure(other than -EPROBE_DEFER) falls back to CPU */
+	ret = nxp_xspi_dma_init(dev, xspi);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_xspi_mem_ops;

-- 
2.34.1

