Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA073B9D9D;
	Tue, 21 Jul 2026 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667711; cv=fail; b=hJZuH+gK8ythSb/InDM6OHhOy9rMO3hZkJmuX16/PloE0w1hJK5dv+SBLAte5wTmcUIzUOuXMrzhwGRK9SEiz9o+prbE9BfLe5CW7YKpI2UJB5VRIbW94P/TqhqdXRS4ZLq2fxY9Kd4QFQo6dybkDVeBriZcSGIAGitQwAu4sgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667711; c=relaxed/simple;
	bh=NVJaEe48ysCDH48WXj+FJDXRBCUBDeWMir7iShW5ol8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=onDYYSLkw6JupEe4OBOmKABsyi1rm5oDF5qT8oGCxCmY7vIYi38+4Hr3ySGFg8HV3sfPeeukGJyboiVm9S43oK2PWY2MYjIFdwu5FsKmyw9eMgLlYMnol57vExmp20LB8kwXYczPTGcUf/4IK7vr4Td/i/jte/msXu2D0m3IFak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BIk67D18; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BIk67D18"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4ZwkuZP4WVx4v6UCr8IQnBUKVrqvXLORlIWSzHlmVK4FKbQX8jy2oaD3B4WFDcduRN9ohgHP/ggNf7wRf8xSsZ2Z3pn9DalD172VVzz4+BSWu+1GJg8TurJuxj45KtJRwgG/Je+fDXLXCEDS0W8q0SZx4TmMRWB63vVPSnxR92S2mncvx4bDbriKCsBApd5FCyznAEYHqtxgkAmoghNNciqybFmG7CrvascAxtLOqvWklVpeDc9St2vlbliGrpV/3F9D3oEdbzr6S3AgWlLXCiOnK9KGbJlfKKo58R9aAd0xzMCBGs91XXeQZBoDff4ImkRX2iVoEAI61ILjIcrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQRWHHsDkefMliC0qLLn49ifFOyGGFEn0jEkwDqoSY=;
 b=x/FoxP4KaO1YZ2rGWOPykMTvppMS2R5Rj5Z0oeGVYSVv76ebiDIwf1ZvkDjgEjPrOuHQB1fuAh8gWAgX6rBSDs1KbcW1wcIaAZgEViV6iVRhuJDS3ua03FW6Po+TKGYUtgu3dVu9DGqxrm7RVjiWSdrEMfQmVpWRTy3JQmTVI+Mysa1Bsf2A0dj/E8GhjjOPDCHjSzDWP7HdR9tRjlvSiNaMK1r9V667DgabSjWnjgplktpQllokR0OjOgKVixpIekcQjHuSk+dGArokyPgiSocGhsv17B5HDTG45JtFuedUFKXC986HlowY17bIBrc3wHOLmkvRlX2oR5xZKoe2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQRWHHsDkefMliC0qLLn49ifFOyGGFEn0jEkwDqoSY=;
 b=BIk67D18lgaPI7IGsCgomZg8vmtzSMfYPMhI3VAFVQfnSFJQWsG+Q1k448iwMem3IVq67sO5cOn+5KuU2uBaQ+PayNaeri+Z5tKS8b9s//N1ucOULFhEAxAdWx3e6NDwVdj9O2Rvv1jxBNIymN3HyFabx4PUW3qbHGGt+qwK21FqJY56s6kzx8MTyNBNb89ky8zDfvkJt7c6GijXPnNqdUtnuIqsC2/4Yp2G9VQHSwIfz/R81/EzH3vo9XrrtQTUKImnL0oCgkAEeDYx61UNSzOlIix5jwZ/Sn3rP+WR5f/Ohk6kmaWwggt+zrX4AtpSuBEPkwlf65SytNWBxl+K9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 21:01:46 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:01:46 +0000
From: han.xu@oss.nxp.com
Subject: [PATCH v2 0/3] Add DMA support for i.MX94 and improve AHB read
 performance
Date: Tue, 21 Jul 2026 16:01:41 -0500
Message-Id: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXeX2oC/x3MQQqAIBBA0avErBN0CoOuEhGiU82iEqdCiO6et
 HyL/x8QSkwCffVAopuFj70A6wr86vaFFIdiQI1WWzQqS+QpbG66opyJ3KYabL3uQuuNsVC6mGj
 m/D+H8X0/rHvRL2MAAAA=
X-Change-ID: 20260621-xspi_dma_upstream-324c07d4c116
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667702; l=1412;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=NVJaEe48ysCDH48WXj+FJDXRBCUBDeWMir7iShW5ol8=;
 b=tyeC+k0eVzztBiFIDD7OvP610a8mLbUBFZUJtLuqUK5iFT1a5mTWi8ruq0fZeCO/EJAdI8Rr4
 riGVNvHWTimDMNHBiiDKtTW/w3fXQAq9AuwZfzH2BC2QGvh+cIiKXKg
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::19) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0bca49-4990-4986-7d54-08dee76b469a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P/E17JjBLtdl4ozT+FA0IL2z0eKq3i5DnneCarZtVBzR3X7h45w09PzFh0Oot5c4ZKh/Xs6gui6smlGg/krsm5eNWoGFQ0RkN0mw60QB88orqpmk0bOipsQXdM6c3OTX/7OPHl46dCkQQcpkHdEjZ/DSomJHrcCpmwnA+Ty9uMK3GYixnvVD5Ic7oXgAY6rb30RbjfJkUzr/wYrqEuxOMoGIhUmJEpOy4di0F8JZzP7Y0FJyhJFUO0DANaqPMNYabAIPRi5+kbXUAB4bvWtKaDoPAlIr7pWnWCs0IPrWIK219QVwVlcYB0RWTFOgp6At02X9P0EiJYMQpX84prm272XcDewYDWTxxoiWDtKMqOrpRkr8r6SdNtHgcZbXemJ9aS9WLfwsJrOI0d+vqCnk8G1bSLjGg6Dm3KFAqG3OPdc7qhLLZgzF9VPZTRNhMTJVwsXt52cg0JfroiptqyQP7UQybh6aeiA4XxWUS65NgCkZeGprkoMElb02uNsELmVz6PT4ZAgMwAXhrnAOmMkD77auSjZ0sAMCzDdTZFnSuZ4gK/pDUPqfemfRCrBS70t2L1zBlInhg6cL96TClm7HL3OV66Aovq044eOfiZPbqVC8FoReNd1TcGVnE/pOBj6xj5JL7qcjWo9GdIHBsZtF25W/d9GNy0BLX+NWp4Ob8gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUZvbHNFR0g3TERjSU9zUjRJT2lOcjZJSW8yM1hYYk1rNDVPMGVXOFZTUnR5?=
 =?utf-8?B?Z2dJd1h3VmlabVpYQlUvbTZqNFJKWHk5eFNnVFNOZ1k3WDJsYTZoT0NPQVRr?=
 =?utf-8?B?TUZRTGJmVno3N1VUa3JFZWUxbVJxRWdYeExCZVFiS3RucDErYTNHTldsS0c2?=
 =?utf-8?B?b3cyRjVaTWNHSFQwSDZ0VWRaWlJCTkRXcWdSSkt6ZkZTWHhCSHUzN0REekk5?=
 =?utf-8?B?bmYzMzcrVHNIVXFOV0tmSHNyb2E5QTFWUnRMQVRCckxPU0ZyWGRQRkZLU0Zh?=
 =?utf-8?B?Vk16T0N2M0QyRjJRRVlBT2dLai9aOTNFdUEzSDdPM3gwd0U2S3Uybk16eGVm?=
 =?utf-8?B?N29nQWJxaE5vRTNwUmprN0RWQjg3SU0yMWxrTzI0UStuZTloT1ZqS09pbThk?=
 =?utf-8?B?WHJ0cmxtbGF0UGxXa1hGQy9rcWEvTkhuOEk2MlAzYy80Qm9TZFNvZXo3QVMw?=
 =?utf-8?B?MkRJbWw3dG9aT1RjeW00ZVg2cUh3RjNwejZSVXhTdHBoK3Z4V3Nuajl6NVcx?=
 =?utf-8?B?azNCdyttbjF4SjQwNlY5R3k3OENFN21ldVdmbjRmVFNlSmZ2V1ZWQVZjTHcz?=
 =?utf-8?B?UmduMVZLbkpsUWZBUTd3ZW1RNURxVXExU0h4OFI3ckk2QmNOSFduc2k2aW5x?=
 =?utf-8?B?azB3ZEVRS3NjYnpJR0xmR3Z2RUl6Vy9rREwvZTlxYWN1cmEyN3ZYMVhGKzhI?=
 =?utf-8?B?c0ZIcnZGMW9ONUt1dk9aS0JBWStpeGdKLzYzNURmdWdXMXNHcXFnSHRPT1RP?=
 =?utf-8?B?cmtkcll5ZkhDaThVYmZLTGJtMDQyYmJaMVhEdENUb0ZSU3hmUllhNGxiZ2RW?=
 =?utf-8?B?L2tlSEwwdTdDcTVDZXBxYkFBZU1IZUY0ejZaNGROd01waFFwV0x4SHlOL0Rr?=
 =?utf-8?B?LytQU1dlUXVFTk9yYndINXF6MkhQRit6cnRCQ0RCcjVoTHVWcC9wSzJMMTlU?=
 =?utf-8?B?aGcwdk1kWDFPVExRUFFnNXI0UUhrd2tESFVjaXpXQ3hicm0zZkswbDZ4RkxS?=
 =?utf-8?B?cE9ScnNUZTRsRG5VU3dmb1RtTlY4L3phRGkzd2hYSCtKSnBrTDFJNXJOaHBH?=
 =?utf-8?B?QU5MV1gybnVjczI1KytCOTQrM0NBVGpBajVqWFhqbGROM25QWEJROUoweXRq?=
 =?utf-8?B?RWhIa0MxR2JKMnNZcGNhZ2lNTWx2a0REVFdnWFJ3dDlGckcraW56TzI1U0lj?=
 =?utf-8?B?MHErQmtvQjdncVJsNGk3YVI1N0gzbldOb0NZb0F3anVKYnRLR0hCYm9EZzRY?=
 =?utf-8?B?MUoyRmk5KzFud0N6ajZocHUyNzRyaGNQVTdCUUJOQTRCZzdLY0JGSS9kYTlL?=
 =?utf-8?B?cTBWck10aE5iZ1JJU1NrNU1RQlc3cURQVWw4S2N4c1FuQUVCTUdrVXUzMWlW?=
 =?utf-8?B?bU4yWFkwRjRlOTU3VnlCUlBzUnVmZEFOWG4rSzNOUG1WSWdTemNWZnV0cGEx?=
 =?utf-8?B?UVlOdGlNT1VPSVp2YVNDcXhCWGpQa3FnbUJVV08zdkJWSFo0RE9kTkNIT3NN?=
 =?utf-8?B?NFdwRUxUTzRkSXZoM3BNWGtkRDN1Sm9DMHQ4Sk9nbUVDeXYzdXRLSTZnUGUr?=
 =?utf-8?B?QTdUSXFRdlhMUFVQR3VWWnA0K1plOWhqYXlmMVFwTmtJU1ZSVGh0TkhzWVlX?=
 =?utf-8?B?L1RPL2ZlSHJKUXNrc3VxejdLRitieEo0bnNKWVdTeHpaSVJhMklVZ25FTEFL?=
 =?utf-8?B?SnQ5UVFNS1psVmZhZGMrMmNncmRuWEI2cyswS1BVY0JicGg4YVpVQWdMK1dk?=
 =?utf-8?B?WHV5TzdLZzhuMktrSVVXTC9LS1JMRzhwdVNiRmowcHc2ZzBmd3lnRjkzTU1a?=
 =?utf-8?B?VVo0bTdqU2U2ZGtKNFgyeC9sc1pPR0RXNHRrTVNWUXF1bCsyUTQyWlFocXhl?=
 =?utf-8?B?dnRkOHlvOS92cVdmR3hwMTFCOTZFWlIvNVNheWdzTlhXVDlrM2xjUjBTRUJh?=
 =?utf-8?B?b0d3TkFtSG5pNjNnaFFMeGQ5dXdMSGhvdnFvcGl3Z2NKbitKTkNHZ05wMUt5?=
 =?utf-8?B?KzNrcERuWmUrQ3pzaHB6L1ZhaW15NFZKWmdtb01Nd05qcUNMV0todjZjVjd3?=
 =?utf-8?B?c3RlRTRwQzZXTEgxNTlPd0FYSzdVWlJ5SWVRZzBEVUpzTm4xR2J5KzQwRnZ0?=
 =?utf-8?B?dkowaUd3Z0R6SHNFVEtrSGxNaUFjSHhlVGY4R0RqNXV3N1ZobDFYa2doOHhp?=
 =?utf-8?B?bUpNWi9JaWF2SkVMSlJQOFpLVnJFRS8rK2RxNUl1SmVxSGxUelVuT1l0SnVl?=
 =?utf-8?B?Nyt1dEdqV3Vva1d3bVA2YXZudXY3SWp0WEhqb1ZNZmNuNVlYR2JCT1FxTDkz?=
 =?utf-8?B?dkw1MVphMWgvOHlWNjZTcjBGd2x5K0szSmcxSTZHVmtlNjhGUG1GKyt4VXlp?=
 =?utf-8?Q?7VsGIKiXebHbo63/7T5uMhiVf/AhNfKnbkYnN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0bca49-4990-4986-7d54-08dee76b469a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:01:46.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G53DWD7c4IDvf1k/TD9LUVZyAG4C8j2h6XWMYkg/Jrrt+k3aI24fDpnn1nkvzLyxnTDGbtP8KKx0dekHbGElhw3P1cpgnLkCWxT0EsmLzF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368

This series adds DMA support to the NXP XSPI controller on i.MX94
and enables the use of DMA for AHB read operations to improve
performance.

On i.MX943 EVK, the measured read throughput improves 4x higher, from
approximately 70 MB/s to 290 MB/s when DMA is used.

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
 drivers/spi/spi-nxp-xspi.c                         | 130 ++++++++++++++++++++-
 3 files changed, 141 insertions(+), 3 deletions(-)
---
base-commit: 2c2900017f2486e7b46795e80d7c8f3f8fbe0236
change-id: 20260621-xspi_dma_upstream-324c07d4c116

Best regards,
--  
Han Xu <han.xu@nxp.com>

