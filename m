Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E530C164;
	Wed, 22 Jul 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757662; cv=fail; b=beRCvMNGYN3NdRGTE/eROOKJdSoVI0623XXMYpXKQNz8SD3hdPSAqPx6tJZ2tkjB7bjuCSd/LOeb4mhTIrR+DJ9Da/l9KLbVN2yfscRGUtIaEn9WtGf3Hwg7krPdh6/j+YWmbUsp5pmzoctwQgw1ix/lOqPHHlpb7YoI/U/g8VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757662; c=relaxed/simple;
	bh=7etQG759ePgtTITefq+GNiXp30Z1rxO+X4yKCeAiHYY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bRvJjhsaCJMagxt7oN1FCeIYOR2dsykOKQK+kSQmORx8I9bvYpYMgT2pTXwceFqHHV8y/pKbcWlVwmv3OJ3/gS5HsBh5ms2N2QzT8uSDDZb+1ul+e0/1EUpGsVkQL+x4I5j4x7WYRJlRm7K4r/C1F7WkJzeU054ue/pQvSOoPC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jqXm30wr; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jqXm30wr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqstPal/3B48kxFCTLJ18v9po+wbxKhZYLfFj26sgN2HyredoFsVJszCIMMwN1V8+eyn95uKCSsWbcqHQ5F1kEd7adR+NgBflSX/3l4ESnHcpEb0WWX64KILXvqepfft6JQropM2s54oRCI7Cton4IVOVtj+RDEvUzmdN6AWj6EleiifOxaIbp/zhu9oi/Au2q3BHSH8w2sH+XgP7ZMtmlaN0qJRbjVkbQ6DCtph5rAs6+XV+b+zDbP6NzAcVxrwIuioCq8NhfVPVhttLtx5UcAXehh9ZupqNaCt7jS4gROIRQ1W+5ffyIiimhTXarSZXsqb9oP3lAOQfADs/XjI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzh+u8g2oTrGk15zbCCaLlZ2ss9LOmUi0TBJdDVVgsY=;
 b=dTEp+IUdJrO0p8KEqAkhWlkwgSXpEyLAkRfinQhDcKF6Y+IR2hyzJMYcj60/jIAcqt2rfRZjepIgzKb5Ctq39yX//Mw/kmus2AhZfKmGIVoTchVT7VFKci1xQ9lVBe6YdQyQTWGJW4dlW+pDSsXaONgtW8bOJxQjJ+fIjhaohlrA5T3dBe62shgPEi7Q/3JC8G1cI7puYklKMv+A7FsQlC4xvA0RQTcMrEEUmpzqZpmhyItELdKp80Ewn3nVHtAMJT/kD6mpaV9pGLTuK82Nd5Ms0vBwHCHGc8r13sPyc9OscwoCtn1toA1XxceqvwwVU3g8ryIYJYGxmsFEmQqZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzh+u8g2oTrGk15zbCCaLlZ2ss9LOmUi0TBJdDVVgsY=;
 b=jqXm30wr4CE7odO8o2SiW6lt/ml/h0Pc3OEBTqrmxG8nmp6zfWRxMI61Gldg6N5UQSmWx2M9ZwzSoVwAsrhWrTdILBrWbUToVN8vw2DfC0RpqliNvaNAVdbvzEoyKXMvIHdX5+p39/70ZQ7oEwWI0nZ7TxeR3P/Y6MKrJvinim2LLVPyHcWVGQ5lRV4C+qVQxuzTwdPn0IYDZBoj5e0yRtyhKocMPEQUeMIXyGTSOYHQFUKdhZzzEmAbkyLkLz4Y5/Bdw73gK9WO8jNmJnJYSkJkkRFPecB2nj1M6dE7LQIIHA664PoIvfuTykIDx/KuNrdDW1ZdowXJAsWwgnVZCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by AMBPR04MB11809.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:00:58 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:00:58 +0000
From: han.xu@oss.nxp.com
Subject: [PATCH v3 0/3] Add DMA support for i.MX94 and improve AHB read
 performance
Date: Wed, 22 Jul 2026 17:00:41 -0500
Message-Id: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIk9YWoC/22NQQ6CMBBFr0JmbU07kFZceQ9DCGlHmQXQtEhqS
 O9uxa3L95L//g6RAlOEa7VDoI0jL3OB+lSBHYf5SYJdYUCJWmpUIkXPvZuG/uXjGmiYRI2NlcY
 1VikNZecDPTgdzXtXeOS4LuF9XGz4tb+a+VvbUEjRkmrdRZIxGm9z8me7TNDlnD/Y8pkdsAAAA
 A==
X-Change-ID: 20260621-xspi_dma_upstream-324c07d4c116
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784757654; l=1853;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=7etQG759ePgtTITefq+GNiXp30Z1rxO+X4yKCeAiHYY=;
 b=nfTuNzLzLKv/nT4BKoDCsit3qfidoAjnwVs+mQd3BFOx9YRwN5+OJoIf8xN0i4avxYk50V+ij
 xUaluCVWufqDkuCtWSeRqjUkwxkF3reshyV0diGKat/Dnbye8ITj5Fc
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SA1PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::28) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|AMBPR04MB11809:EE_
X-MS-Office365-Filtering-Correlation-Id: 95475767-9a2b-4004-de2c-08dee83cb5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|7416014|11063799006|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nWZDuoc3GrMu6bIkQ4M9+wK+//mdU74VOK5aoX3kJR6bsl0MWrLlpmy7VRjM7VUX9uECjhQK8llqPR/gDXhI2yYOu5aswXFx93blfoNr3B9Qi4q7C8A1ccZ1cSucslBR9URbgTvS1q0gttpHNEA2z65Ykl+p29o9qtuZZJhTzm+hDAsjovegLyNNyF10zrvA8lDfITjdMcmw5bzsKU17JFJVRPHd4LIeHY2F0ethBS3YbYjdt+Ux9xbO/9gsvapsS2Yf9iWYSQs8ILWOX8h2OxeFbTcWB975coTozPRgV0Xv/uN/9HRR5DbtuuOTqZdlYRPNuPn5VxVb6GfM5r3+PsURvbU1IhUCeO4akHu6nZNGDzhmZUp9C9FcV922K9FB/Av5MytGTZ/YYJUJ6zgHCInp1IhWwlFcCnG/z3knqyiabihrzwD+owI1ReVEg4Hk09mqFNZfScYUxczqilf4tTe+MxFodDg69TMm79jphtQFDn5ZQ3t9QPttFIEPs0wyJ+xIQ9oMbqL16nxhLBULTWlGo4LKfPcdt7Du4eGZHxtr0HOHlfD/iH2rYkyKzvMmCq31atnXJgAaXfH2jx6w4P99yqzFB58akK89+PpwWzyUfEaU35pUVLl/hJjxWTJhFu0Uy3iqdS/CJla1Mv5Blgko/RPS4N5la9S2HdmNRFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(7416014)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFwK3BUSFhTb1NlVDAzc2p2VzR4Uzd3OUx4djI4ZzdJbmNNb29XSFpEOUJ6?=
 =?utf-8?B?bVFHc0dyMXBXZVRrZ2RtWnlTR0dWdHVQeGZlZ1hHMGtEenBnc1hWb0pWeFRW?=
 =?utf-8?B?cFI1azgzbktpSlh2ZXEwRTd6WS8yaHBTSHVzaytVTVZLRi9ocTUzNWV3YVhZ?=
 =?utf-8?B?TXBXdlA3VFI3dDRFYVdLSFNxRkFwN3FJOGNvd0ZhM3RzSDlyditnaThIQ3NS?=
 =?utf-8?B?cXZpN3IxQ3Vnc0p0WHcwVUJOU0tYQSs0SzZtOW1ROTQ1em1lUGNHTlpPdFJQ?=
 =?utf-8?B?ZlBSWWtiQnpqc2JHVGorbEladzRUbHZkVmFWTzFuT0RoYVBQM2lDeE1EZUhm?=
 =?utf-8?B?U1p4cEJMKzJacjVlRmtqYUJXTnVxVW9UVG92aUN2S0RTYk5FOWYzL3p5eHJE?=
 =?utf-8?B?Z25jM21PU2lwZVpHSk85ckllNGpiOERkbzBJMFNMZkNSL2k2aW1rb3hNaUdR?=
 =?utf-8?B?WHI3OEpJQXNrZWRnemhzejYxd3pPTHgvTE5kUVR0enhqZU1zWnRDQ1ZwU2Fk?=
 =?utf-8?B?WTBpbXB6Vnh3eTFRSjd2Z2NYMjBPa2dUYTEyOW55WEVIY0Y4ZXd5c1BDMmRO?=
 =?utf-8?B?UlpmT0FiS2YyNnlTcEEybGhoQWlyZlNlblZhV0lyWTJLRGNXN0tBNkY3WW4w?=
 =?utf-8?B?UEhrcTZTNnhkdTVtbjhlK2dXbzBCcko3aE0zWkhCd0t2dW5LbHNLa0lHdzQ4?=
 =?utf-8?B?M2NXV1VKTmlreG8wdDZhS1pvYjNVRjZGcnVkbmhLRDRLWEtZQ3YvRmtudUxa?=
 =?utf-8?B?d1VvTTQxTGpTdmZYTXdSQ1pjVHIvM2NjNEZaUVE2dmZkblBmM1JrblBWejNL?=
 =?utf-8?B?UEl4QVppRnRud2dmWHVBT3NGbmNldlZxREl5UklkeVRUcmtrcWl6N2pmM2VL?=
 =?utf-8?B?UUI1YmRTY3hPQ3lhZHZGeEw1a29URUk4blY2eGtYS0Z3aTR6aWNPKzkyOUk4?=
 =?utf-8?B?WUxLWlRmUjRGVVowVVRONmY5VFJxdmRxWENHSVAyZDNMZFgxSTRKckVLZzFF?=
 =?utf-8?B?ZGdmMFhxb09xeEo4TFloTWF1Q2dZTCtkQmF0VGNQdlN3amlQKzhqSjNzTmpG?=
 =?utf-8?B?b2RGdmdVK0tsajdCZWFxKzBpWTVuQVp4cHB4VExHb29hS3F6SzNOdDhDaTg2?=
 =?utf-8?B?MTNLTUp5OVE5UkxqeEN6dlZWTG5QZVBsM2dZUFhOSldHMlQyNDNHY2t5dCs1?=
 =?utf-8?B?YmwwbmZzUUpIa3M2bGJqR0Z6b0VNNllqcHo4dmtHelJHRGhUdW8wOTlTTXVR?=
 =?utf-8?B?VDRVYjRPYmdGd3o2dXI4UzYxWm9kNGN4UWVVbGEzY3RXaWRrSVdZY2lNS25r?=
 =?utf-8?B?MVEzd0kxa2F0MzhsbWd4d1A1WDZJM1hGdVlXVXJPNm9rT3psSVd6dFdjQVVs?=
 =?utf-8?B?SE4vMnNveHNON0RFR1lVU0ZaRGUvRnFEY1VURkYvUW9nSm9QVHU4QlpOK3RQ?=
 =?utf-8?B?NmlXRlJsMnlqaEI2RzQ3TGl3WkUvQitKQmFBTTA5dmN2dHo1Nkw2bkF3QXRw?=
 =?utf-8?B?RGdvVmhhakp5RUJMY3RUYlRFRWk3ODlSeThnYm55V2pPL3J3Y1JXZkhyUHp2?=
 =?utf-8?B?KzZhY2d4WjNYZ2dvbGNwZTNPWGpFeTdRcW1ucGEwODlZMXF4WmIyODJzWDBi?=
 =?utf-8?B?THZETDd1eXFoeVNmdnROUkQyV0RmSXZ5aWJHTC9QUHZCRWsvSmN6b01QMDZS?=
 =?utf-8?B?Q1Q1VTEvQkhVWTY5UGdpcUZLa3pXb2JuVGt2Z0wyaDVzcjdXYnROS1FqM1gr?=
 =?utf-8?B?UER2dzMzd05WWC9FZzFoNmtlYWduWk9sZ0FrVE9LN3V4bXNnSUVZWk1pZWtn?=
 =?utf-8?B?NUZxMmxvV3hpTk56QXdDVXdWVXVJNFNzTkQ2a0ZtbTdXK0g0dlppaklNNU1Z?=
 =?utf-8?B?ZGVyQ2J3d255YWR2NHQ1Mnd3aUExKzJQVjR1NUUrdVVWaGJldmdXMlJOS0d4?=
 =?utf-8?B?ajhiQU40ZmZQOVlsYURSekFHc2FiSjdyRnFkRWVyM2tsMFplS2d3ZWlzSXRK?=
 =?utf-8?B?THk3NFR5bzQwVjJ2UHE4aWxFUVVQRGRWNlkwWXVETWdmT1FrSFFydmpKd0NI?=
 =?utf-8?B?em1XQ1FHWExBODlkQm5oUHNTYmdoOEM5U1hxTTJXYlA4blJ3RDgzV3QrcXJC?=
 =?utf-8?B?NUQ3UURqeUp0V1AwYXJLUlRtSC9zR2ZTVXVON1N6SlYrRk5zQmNvSFFRTUtY?=
 =?utf-8?B?bzNqQ2gyM2lnSjVTVmNWMlBOL1FIV1REQmVvc3MzZzFQamJLclgzUERKMitM?=
 =?utf-8?B?d0pjQUc0VDVybFplZnVrTm9KYTl4endHTllDQkpZZWRRdTNXZVBhQ1BiUllV?=
 =?utf-8?B?VGdvSFZyTnVnZ1BkL2NDSksyK1pIaHBkMGJZTjdWTW1KNU9RTEVRTVJhUUpQ?=
 =?utf-8?Q?KgimXlnyFesinyviWSZmmIA1Fwlc/1P3NEdAy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95475767-9a2b-4004-de2c-08dee83cb5c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:00:58.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8YcWubGr+Z3M1ymsPWZlWqvYXqvBDqhQz2tHFxgXTVEx0h3cN0rEiW1qOJGZmaRMK9IDdvRd9kf7yd2VHynDr0b0zYVd1vXzxWBftO+hlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11809

This series adds DMA support to the NXP XSPI controller on i.MX94
and enables the use of DMA for AHB read operations to improve
performance.

On i.MX943 EVK, the measured read throughput improves 4x higher, from
approximately 70 MB/s to 290 MB/s when DMA is used.

Changes in v3:
- Addressed feedback from Sashiko review on the v2 patch set for Patch 2:
- Map AHB MMIO source via dma_map_resource() to ensure correct IOMMU translation.
- Cast memmap_phy to phys_addr_t to prevent address truncation.
- Replace u64 modulo with bitmask to avoid 64-bit division link errors on 32-bit architectures.
- Move nxp_xspi_dma_init() after devm_add_action_or_reset() to fix DMA channel leak on probe failure.

Changes in v2:
- Reorder the patch series.
- Adjust DT binding patch subject lines to match SPI subsystem conventions.
- Update commit message to include ~4x AHB read performance improvement.
- Rename DMA timeout macro to indicate time unit and document timeout selection.
- Simplify DMA channel initialization flow.
- Add CPU fallback path when DMA read fails.
- Clarify/fix DMA alignment handling based on DMA engine requirements.
- Drop unrelated formatting change in probe().

Signed-off-by: Han Xu <han.xu@nxp.com>
---
Han Xu (3):
      spi: dt-bindings: nxp,imx94-xspi: add DMA properties
      spi: nxp-xspi: Improve AHB read performance with DMA
      arm64: dts: imx94-xspi: add the DMA channels

 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |  10 ++
 arch/arm64/boot/dts/freescale/imx94.dtsi           |   4 +
 drivers/spi/spi-nxp-xspi.c                         | 143 ++++++++++++++++++++-
 3 files changed, 154 insertions(+), 3 deletions(-)
---
base-commit: 6815fea1fdef000a5718bc1ec8968020d98528a6
change-id: 20260621-xspi_dma_upstream-324c07d4c116

Best regards,
--  
Han Xu <han.xu@nxp.com>

