Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B986492E27;
	Wed, 30 Sep 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777006; cv=fail; b=I2JpDFq5Q+oFHejNHM3vdnuWkZcWVa5GKcwBS76vEHDgKMN3JRwAoxIhuX6GoClvcGtpkCNvyfxM4SXtEqZ895SbOid8+3M5reagE0sK7swP9JJBlZu1lzrSlW8M53idNwAlRmBvHqisc/xZ1yjq9/c99JPTEkoNZvMpjsjulhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777006; c=relaxed/simple;
	bh=sp+9kYVvvPZXWp+MUp78lROE43PFnlHnIboADn/KbO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k1eBwifc5ngw79kB10oj0OgSfnA4Cn8NT1DfPSMsD/kNJhNXrKKIDFlc+1d/MZn9EaQ1gEJ1Dd6/B2NwJnHnDC2bUsx+c77cNJEMJLe7+44d5yMT1aMaOZ8rgTMywsoXuJ1bmEegd2TU/6K+wCzZu2MXgBu4BN9J8d7u3Ve7ji4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jhcfHjrq; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jhcfHjrq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voBE4/8hkoa+jiaO+HM5GMwVVT4pdm5wrJgxEvTGpuA7QNYu5QvMQI+SPkxWYCIlJkOP4RQrvFD7rSusnPUgIDaFYjCvQpRKwftd2ctcOBjKH2MlDpk9M5/ZaMG1OGUeYYfGXBPa0fWBI7AXRq2pcxwt09H0VXshoGuuk2Ehu/GKAXjK03v72x+uPBWO3agnWu2j7l+5Vk94v6LImp82qlxVzqIb9xmaR0syNoqcNr8PChz6CH/1KSPgkn0dF8dk3XOoZ3Ce+/h9oITtyUfF1ZvRMHCYaj3ClDOjqKCByrAYqlZ6vgeHjg1y1yrDoMLYX42nFa0Cyo6lkkuZEjnSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tqabshKn/2TTUfeeKFoMhEj238tIJRTeMERGIypjpo=;
 b=TBoqXYTaJxjJr1m+7QXb/j5KRvBd6IfyHMsD8RR2Oi2IJeBERW14p1eJr3tyAPGc0tlUXDUEmPIC8fWuMzZasbbM+v+G6BOC2uSYzR4e0mgJPOZPCwhFF7Q9HbKrGLIgY/tS88X3P3rAB34a1CDCcU8ez2krPYOpynYuNMsNM2kGy+pgg+84F018fvq8k4YeXJ3lnUL7d7vg/jMze8wsjUj8kfsyDVshj8Mg9WvBEbqYgCVOaOo7tkj+wQ0fNr1plMo/ga4GaExyr5bhO0dGHmabXY8Ns0MqdYY5FvYKIod7M5Ye+Cy6giq0FFKxqb6CEjbLdu8MuuNV3AF1mGvzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tqabshKn/2TTUfeeKFoMhEj238tIJRTeMERGIypjpo=;
 b=jhcfHjrq2tqKw0glAdIAdTzZB/1s+M5+pL8jXxOUp3uFIvmkk1/zBzVgqdjyzFlCIvEnvzvLv2T0Uk62DnwliMA6jLQ4mmuyfNo63+F0Mha1TCSDZWjh5chVhi+ZTPlOM4mmlYet4facz9bRCT1xnDGjlBPpRDgTZh9G1o+BmZnX7eRGS3pN/SEC1dtYarzkfs79Wn2x5JMQQe1jA74ePYmwvYoTwVWh2nIjseAgDpfl/gmZzFdKRNimQVb9JZSSEF5D4gZgrU3PtsdHxNx9fo9UCsBnaD6N0WNn2JDocqXKZ4L5q9dhbwrh+KKIcxvtEKtNXJI86FIPk54VEEC5Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MMZPR04MB319484.eurprd04.prod.outlook.com (2603:10a6:190:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:03:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:03:04 +0000
From: Frank.Li@oss.nxp.com
To: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-spi@vger.kernel.org (open list:MICROCHIP AT91 USART SPI DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/2] spi: use dmaengine public API instead of raw ops
Date: Wed, 30 Sep 2026 10:02:54 -0400
Message-ID: <20260930140257.490019-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:510:4::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MMZPR04MB319484:EE_
X-MS-Office365-Filtering-Correlation-Id: e775f8ea-9ee4-43b9-c1d9-08df1efb8bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9JVjECCsO+w2hppAZB9nhLPfW04HdJEM3pPeFMDi8N8Y+TZ0Fi2fgCVN9hGH23b6+Sduw/GivymUx1Ym59IvfD4asTaXa0Lpc68zjMSljDbVBFQaVkfOmyc9q6DfYhSx0mZYIAA7zyTvQGjTiCjZ8F+ZOEpBqNkmQE24Vi8k3xi+0z6pGnDU4DO6oqYMbgjDfGYvd1Q5r4YLhBXHOJvbS2hpsnjicgxn65YPf1q6YMWC/BSVf72eGdGCLRBLL1aq8E+QaLgElXAw1wvZk71vf3beME34qmDDIIfQoe74k3Hzeobv9fWG2qe/9SleMP3NopPwFi0o2720iAnadzIOKn6TNSr62vUccRgfcvDCwDZoir5Zh02Uoc8pbkiYSq3OkvlFx4EENSa0wadbg+c3DNatkqtuS+H3IJaqo2fAkv2yJ+qgBaxGpspg3mXnhNX1edYIPwpIutAM5VIp9GtRhYbt4YUcoyp7O3k1j3g5lcqqaA3JkpZt0PDWCMgiE29hR+Pu5Ckrt9e5DcLZchrM6/upVpkVCjraomF8Mf0AjsW9Qcw4kPevZx3odzD9XQ0T/kO3h7WJUDc/Gg54JDZ/dYunV0ZDjxcA6NOcmLv+S9nkzRHn8/1V+g4Kp53G5xkHOWPU+kX5fQ/Sq7qm38b1pEYA0ahtioELixg6xTQ0K28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bz/EvKesdqV/cNhWWKuL71NsR18nWfSf7enCWnSMZA2A/goHBIt1luvQry8/?=
 =?us-ascii?Q?rj3kW5XMhVrtgw37FNJyrlx58HEQSnPQx6a7Jzvo3wzCglECFNJJTY4Ws914?=
 =?us-ascii?Q?ySmJWFdPW3HUC1oBHuSjyM5hyocABpD1+ma4smJgcmGg8eBP6QE4RnI1pDom?=
 =?us-ascii?Q?hFTSy2XoKexy1dzMYG2Enha8CLgYoYR3o14MPEuIyf5oi6NKfNS3y3hbf2aw?=
 =?us-ascii?Q?8F0y/ijYewQS6MlEVRyIjUrClmGztPu15uYbbUyO6KBIJT3dG5QttTbyxsix?=
 =?us-ascii?Q?Ps4ihM2B4avBl6UYMQuxpcZSjfo44BptW5vLQGCQ0Y2f5C2C1TA3CgZedIc7?=
 =?us-ascii?Q?KJJ4HWAgoKd2CuhKJY3mjxUyhx0f1ZF1tpybh3w4b23UQHHr4x7OJ3GPzAuh?=
 =?us-ascii?Q?7Dz8NWjvp7kom8/5f0JdUd0wQeY2KXdpwTJU1hhkMa3WPX7ZhmE078awtfKc?=
 =?us-ascii?Q?9Y6PJXjKn0RC6raT7D+cPlFi7ps33Gz8/vOq6Kpa04iJou/qBePPIvrHkR7K?=
 =?us-ascii?Q?0ZiEww4DHmaH2KMHfaDdz+TPKA74bB2ruU2MjoxDgwmbYqMPryJQBzoON4ZK?=
 =?us-ascii?Q?HEF9sx9DaK+v//AcJU80yKrw0RTblE872OT08qwkH8NDQdnsVjnJw17RGHkv?=
 =?us-ascii?Q?mPyc3NvvLZRPOJo3NYlE8kXwOEbsTGJtBAfpB7Je91hn51Oxud+dShpkH1mQ?=
 =?us-ascii?Q?bwyJ3RSyq4TDsSevAplQ3cKO3ynIGFMWOPQgNhTBdOZdQktim7DGGJJT/otV?=
 =?us-ascii?Q?VKFQ1+HDI8HKa7Vdc8cCle27QY4cgPmI45W7c4AszXdGz0sQ6pyjWT8ojKoA?=
 =?us-ascii?Q?IwQh8cOCFN/cIGmk+LnNrCZT8HWtip0qpbBjZzaDsUZf5l+zN4Hm+5gZRW72?=
 =?us-ascii?Q?HKu7zaJ49rODGheShEaWJIrh9EMMdQInyuotgTBqo4g2yHy/TbYSlJJ5cAcn?=
 =?us-ascii?Q?szdVX4Yo5Q9aVJb7bdB2OJoBuZcqt8u9Qm0iN1tyhPpupHu6LuQzAf14RIpY?=
 =?us-ascii?Q?BUG4pXEphh1YiuZNFBzF57DpFmrFDybcpC4ce8hbot5loZFs4Sld8BmaHxeA?=
 =?us-ascii?Q?sWr7z8HQgGS9btHrhaofcnOJYHZUZIsP0qkNXktJoyF+Sp1G01gO7iGnB0AG?=
 =?us-ascii?Q?6pDP5N6MT8ueIGokAVE4Ss3MQzeQLU3uNJxFPX8CZIbgQATRvgA+svlhl312?=
 =?us-ascii?Q?HNnTYTnNg/r01K+anuiO9wRVqpxEUWpIK8nPZ342vOEA3XBJQlFlJxCON4/w?=
 =?us-ascii?Q?r0p8nfreuwV4Ka+PsKUozZF/ZF2+J6fY1SjbvXJLMM94vT2dsWeV/PJ7PS7Y?=
 =?us-ascii?Q?R05//HK+LgnuTVQqNWmBqSkVYxAhTexelGWNYnsG/ldg/H2BSHa5cCVCfco4?=
 =?us-ascii?Q?UJQ9uDOZ/vWwMxmLO4P8KN3TlwZUNmv2+EVGiz0koyY8jw66i9PnyUZtm0n2?=
 =?us-ascii?Q?VN2K1YrT338TFMW8YQ/fZ8FCEv0+6ADN1ihzalKb4PUFezfbTxtYmwh9xc7a?=
 =?us-ascii?Q?42k8QowTg0xNJuDLcDhJc2RzBRZiDQHjDvZ+gjpkAQJPVKIFLmSr2gaVYwbH?=
 =?us-ascii?Q?hwdO6cgjO4ueH25ELnO10qZ9HaPEsyGDASInhsssoWAF3Q+TII+Fd1sXrh4A?=
 =?us-ascii?Q?tBs68jqfBmBXhqsLd6nx5c9VG6R83rtpws6643qgbXlvak+TAFl2J/Vh/9VU?=
 =?us-ascii?Q?rai/QaHxEDixCHIjGsGLv1z0dl2wRUVjlMGnDCQmKPIqGuI1b4x5Ark5pzX4?=
 =?us-ascii?Q?WEQjzRlp2SWTgAfrNDGoRMvzoP1HVMU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e775f8ea-9ee4-43b9-c1d9-08df1efb8bec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:03:04.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENrJ38R4lq8bNV/yMxzDaSO15BAKqlEUtgf0QZeeO74yBlOdkm4z5w/Vyzw47dWPOA08N6oXUSePHtDpQ4saBSU8LWKt7zFXYh+D5B73HU3KH4He1ACVZqPcwUdYfhYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB319484

From: Frank Li <Frank.Li@nxp.com>

Replace direct calls to the internal DMA device ops
device->device_issue_pending() with the proper public DMA engine wrappers:
dma_async_issue_pending().

Drivers must not call device ops directly; the wrappers provide locking,
debug checks, and a stable interface that hides internal implementation
details of the DMA controller driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- none
---
 drivers/spi/spi-at91-usart.c | 4 ++--
 drivers/spi/spi-atmel.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 804f6194c830f..cdc771350db93 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -239,8 +239,8 @@ static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
 	if (dma_submit_error(cookie))
 		goto at91_usart_spi_err_dma;
 
-	rxchan->device->device_issue_pending(rxchan);
-	txchan->device->device_issue_pending(txchan);
+	dma_async_issue_pending(rxchan);
+	dma_async_issue_pending(txchan);
 
 	return 0;
 
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c8012c82c3a78..c04113ce17f70 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -877,8 +877,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_controller *host,
 	cookie = txdesc->tx_submit(txdesc);
 	if (dma_submit_error(cookie))
 		goto err_dma;
-	rxchan->device->device_issue_pending(rxchan);
-	txchan->device->device_issue_pending(txchan);
+	dma_async_issue_pending(rxchan);
+	dma_async_issue_pending(txchan);
 
 	return 0;
 
-- 
2.43.0

