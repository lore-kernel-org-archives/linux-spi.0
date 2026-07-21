Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D64582C9;
	Tue, 21 Jul 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667722; cv=fail; b=tdh80q3ncqmpQxIoOQ83ZPfa9DrELEaV1I3I5tqGmIqedvlH59Hts5XiBSiKmM/3LvRGCzT21ndZq38acs9y55R+RPPtdgEJ6/1m1sLYoShzkjkZX8NfkuZ2zyKk+Bk+LiXQOHgRtv+CTbI8kYMdg04Fal2ysugQhXVo6uQetl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667722; c=relaxed/simple;
	bh=DdVlN2VMncadnMRQA5E1EpH3MYYJtpaUwv9o4SzCCI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AxmdYEG9rpTxaGYYGE+CWAx9CjPJXJGlWhS/KCepppYI0fxamn5J2g8zZ+Gi5eH2HaHlg6w2ot+HzT4SIY/GkUUfrlrltoaNdXxdMkhqhL+KfWNdvNksUrq91tz54ZDhX83FfedComtW3kBZx9M9aqdq8y8hKrjVqL8icQ9FaVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UNYesfby; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UNYesfby"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWqPPairldk69F/2aPlBwk7+D22tXvNf4uSJqH2Q52y4cC4mHLOjU1km7kJ4BNeV2GuZf0QJi0hjyiyA4OhYeF+yhDwjJehyXq5JQ85KpIiiYpfJUuivMnrw668OMC1gnGb26/odqFt5VHcs7UZYEM3YPmMgmGzxvKLG3fYLJZZs20BhtBPseCCSS9gWRPVkwekaMPXqIMxcgTqVQFnKznUIuCKZMqg03Kb9FgZwiCRBpfQp7/o45B7evbzv+9SKYFGYpsaaWUTiwp1TVJzFgOL+ZfVW/SNHmN7a79i0m+ghd+sSr3BC2sIaeOOFLcJ+ClsmGGVFlyF4pi7FVUmpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZs/gwrEJ6BBCNRwI7CX6l2tXqEk32+8WegHi3dVYzE=;
 b=FPPZmzlGH25g74w4xvrh6II5wQ9MmrbpVPS3VpXDmQzACurjQUFKhVHKqfRlymBR9F4ljO20oddDEkQ8vTeiMJb+VMyoH81OmiiTN2XTzRMgqdhyAfao+LzwoDom3eByZ3q2uKjnon8h4E2crgEPbDx1mLlYdaMlXXw6b6cKLbNcTGZLLCvegoBX4TfXsi/MJ23gFcXN7BbbQ4fopR/FfmrtJ2HYQLH9Fqqq4sNFIov+yAaEpLrj+TS9Dh9BUYMGJEUrIXVdZ3iGrXoPXHU5bkvRQZRyeskaqNUs6X1qqWbaEyO76rGQVk0bbDqLoc8eGczzfAQOFsHhhZAEFuvnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZs/gwrEJ6BBCNRwI7CX6l2tXqEk32+8WegHi3dVYzE=;
 b=UNYesfby6LiKZvLckA1KR9rxMmJfnUDjPP0KdJYkruwH94TjQ8Tsnhs3COlTygH6ujGPjXr+TBYpvoilDBOPmcEAfPdwFVOrsIUk2pBX/1gjHt7wFqtKt9dvR97GFwzBESmtfOpGl0dnET/iThFc7iVy0CoXRW5au0lU52wnl/cqBfHhPvKxFqO8R15TTOlgtGaA28L8Zz0zxph9lCEq0Dd7I2gU4XPPe1CjtvbHV0+0jiAGi6WEwKvBwA9uU0nsl/HJkLeBaqF8U0o61P6F8cRcnRW3pl3KI81IhVVFxIN5WqfGnQA0V4mWXxLFEf4UY6rR16BKmy5A8NWwAx2E2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 21:01:54 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:01:54 +0000
From: han.xu@oss.nxp.com
Date: Tue, 21 Jul 2026 16:01:43 -0500
Subject: [PATCH v2 2/3] spi: nxp-xspi: Improve AHB read performance with
 DMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-xspi_dma_upstream-v2-2-9e19d80e7762@nxp.com>
References: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
In-Reply-To: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667702; l=6887;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=M9NvnMh+wN/uUpzx44dr3yuA0BtGcPPTtoj8Tm2qqoU=;
 b=va/rM4D9k3YmKBpWXHOlDt/KruLn1rwyevykpeADcp+AuQvYQB9409HUhPd7WOQ8yoYHj851n
 jB7UlqmJkpMBqlhTerdv0bIHS9gGbul+7iPAQd4I1rrVqZVR8KwQYFE
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adb199b-c0db-407e-9f1e-08dee76b4b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dqQzyw13U7gkwtlK53MIb8epeoL/5hqDvenLCyIx2qrCa25VeIzyakFhoyToBOiX1ydfMUD3Nzalu3FZp9YM9oIFaw7pYDhD6C3ihyIztAMpUvia9ns5es/6V9QeIDnvjcCEI4msxLj/zRf2nTDI8fdMeNsiIjbc56pLRIDAGNs3byDN/+IjG88G1ntQ6rzsfqoQ4ks41iYztt1U7D9+uiE/K6vOBDprTaQxRiF+pwBTGIioka2Gnar5vH3a7n2sxVdRO7JgO9Bjj1wrrAffx18+cAxQ9a+f4QFPhkZjpe15fXWGe/ZO6zV63XWCy8w2+fVxuiJzuYrUCrp1ytt1bStz7RrSrpmnTYA0YX3rG6cigu4XsfNftp87aAsLCpqFkhIgNVwYbE6jvHWAcE4AbDr34FJRiuxbO0FHgrAPW8ne4d+qArIUWTBHj6tBO8x9kuqwGYZx4AC7roJjYV4JyFmpiacYxcgnemFjeOgZH5ZHazJ5JhxeinNq1twBGvt7N1x5K93vgSct8R/W68WwjSfSqWvJH9aIlVpC40Ad0lbN/AmMR7Q6eaEaYdFkJWL5ATaVrd/xOLiBIBlgHb6O3oUiMLtqn91wFXZP+P1Hcq1uCNrLqqATplBlqSpyl6iuwWYSFyFD7li1itk7QZkthhMnKjIl9VEH/sHTJSwczdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1B4VDFSS3Y5Q0VKSDJwaENHU3hTV3dSMW10M2ZmbDhFVU5qWWxDTTRBcGFD?=
 =?utf-8?B?SXpVcWczcnlJQll6Y1VQbXhRRE1XeEYrWVdYM2pXUm43SHBDOVZyZ0h1M3Zq?=
 =?utf-8?B?VFVMenpQL2FjTGJjdlhKVm5SZzJ1aWdkenhDUFp6NHFtVFRxQ1ZHbEFzVU8r?=
 =?utf-8?B?NTJhTHpXYWhGQWlDSVZ6NlM2Q2ZIaGxDNER0bjBGeFJiVHp1ejg1dkNyZlVI?=
 =?utf-8?B?K0k3bXRleVg3ejU2Y3V3VFc0aEVEWVZXY0lQYkpOMlJ5VTlleDlkZVdQL1ll?=
 =?utf-8?B?OUZLTUFQQ3BTMjE0QlRFT3pORUVIVGNVTXY0dGE0Tmg1S0V3RFNGTlpCQ0lS?=
 =?utf-8?B?dDlaakNhS0RXTGQ3MlowdXFyV0Y3L2FBandTY04ySHhvNnZyRGtTU0t6N2w0?=
 =?utf-8?B?dmx3SmtXeG9CNkp1bml3NjRsVlF5aUdtYU9tVEJiVzdsbkd3SkRwOXRVZjgr?=
 =?utf-8?B?Q2F0b210TmFqWHdMVkhZZnNnVFVJdWNtZjV0dzZEUDBmVGFUUDBJOHVwMHYr?=
 =?utf-8?B?anRwV2ZmN0NRZ0thdXBzUUdNZWR6MitGUkRmSWVGd3ZWRnRtOHNSNTlLeEFm?=
 =?utf-8?B?YjJPRElZZHRMWkI5UlQzZWxlTE9QVVRVc2RqWWFEZ1NhY21CaHY2YVY4L2Rn?=
 =?utf-8?B?VjR0TStjNjZvRmlZcW90N0kvckpyVEJYUjFteGZ1MVdvdHJkTldPN0ZkTjFN?=
 =?utf-8?B?S2szU0d3dFRhUC9KNjFVRmYzeWRPbmFKTTRMNTRBZlY3RkM5U2FQQ2M4ckt3?=
 =?utf-8?B?SE1wY1FOK3d2cEdycmprWFE4c0lzam16M1d0OXZIWW5TWkJ4aUd5UEd2TFRJ?=
 =?utf-8?B?bmkyZTNxUWp5QUVLZnF6TGZxRU1QSmJJQm14SXFxNUkxUUFiNGViTG9pdXNC?=
 =?utf-8?B?aVorbHZiSDRvVkZlek1WUlZ2bGdiNFJQTmRCb2tiWVMveXpLcWdGYUFZTGxI?=
 =?utf-8?B?aFVqdGxlOTJPOWVZQ1FnRjI4MUdrSkcrQjVycTdKV21wb2w5cENUVDJIc2t2?=
 =?utf-8?B?NnJhMElVMTdXS1FLUVNsZWtxSnVibGgvTkR0Z2o3TU5WOXBQYWYvSEk2Y0Iv?=
 =?utf-8?B?RkpDN29kempKL3phTWNFQzFtbW5vMDk4Sks3aGhJUjJ0dm81eGEyZkNqOExr?=
 =?utf-8?B?K2YzeXNxd2N6eWZBaHVVQWtMRFRPaTZsdk9SS2VrTEJKVzBuUHVERkZ1Z0tV?=
 =?utf-8?B?VmhyTWs3RHJPRlJrQndTSGplWHllOElkYXhLR2I4dXZBS1ZWSTJpb1R2UnV2?=
 =?utf-8?B?ajRFRmxpSlA3Q3J1bG5UNFV6T3VJWjJsVm9RTnFGS0cxY1hrT2Q4M2lDdVJt?=
 =?utf-8?B?NGEvR0FVeTZTaXFVZkJpcXNuWUxTR3BXS1Z6UUR6cGJHZG14WUhJRHVaWVVR?=
 =?utf-8?B?VHZBd2d4dy9VUGlQM0UyTEM4Mnp5VEwveVBkWDcwbHd3ZDNKbS8rVFAwRkho?=
 =?utf-8?B?WDhNcEp4UXVDY1BLUmN0aUN0SjFLMTdKTklXMit4UmtHcGtrZ0lLZHVWVnFy?=
 =?utf-8?B?NlFzZzBHMGxSMjdrM3hUNDdlV3FRaWlWZ0Z1RkVURjhXR3laSm5UU0EzNDFH?=
 =?utf-8?B?cXVrN3hUM2NLZFBrU2pqTDNFU2FRRG5FNE52SWl4SEw1blNaZEtaZHI0aHI3?=
 =?utf-8?B?d0R1SkloMFJKcVBpdXh3T1ZSeU5lZjl0Yytad2ozdzN0RE51bGVVU2ZUaEZS?=
 =?utf-8?B?a1pvcUF4R1ZScmREY2NTNXNlR2JhVTM5ckxJVkx5NlN0VWdKZzFOM1RzZHMy?=
 =?utf-8?B?Rm1VQXBNQ2VuYlpPSHVkMkRBOTNOYzdodERGdVNGWVZTRUdxUGdqNGpybEJX?=
 =?utf-8?B?R3Q3c3JvSExFK3IwRFoyVVUxaU8zTDM0SDNzK3RvR0xRc0puK0lUUG4vZ0hZ?=
 =?utf-8?B?VlU5MTFVMUE3RVJTSXVORHN1R2RCZnZ6Y2o3R05lUEQ2Zm5ESkVZY0NhYndy?=
 =?utf-8?B?b2tUUElyRVh2OE1JMVBCSnUvd3ljZDVlY1U4R3BXODQwMUo3alpjSXE5UFA5?=
 =?utf-8?B?UmUyejFCdkZBdXNid3ZQYkRBZjJPektBWUd0NkV5MVhiTmZiZ1BuekVMeXJJ?=
 =?utf-8?B?eDNOVEkzOXBVVnNrZTI0alFYL2plY1hHYTlBK2ZkS1Zkb29LSFdaakRSczBV?=
 =?utf-8?B?SUZSQjBkTG05N0lMK1oxbmVsRWdqSFFBdGxvcWpoaktXRk9KRkdZSjZOLzNR?=
 =?utf-8?B?VnBGOXQyZnpWMEhxbzJrWXpIaU1URnpHMTBrSEdtWUhrZ3VHT2h0cUYyZFQ5?=
 =?utf-8?B?TGdWOWtUUlVDYiszNFVQSVY3aHMxcjJNL2ZhVHZzaytaYUhWZmtBaTBxN3By?=
 =?utf-8?B?b3dhQjQvVVdCTVljbmlHK3pPL3Zsc3VEYXlHSmNNVmRTenFVVWxsMktvSGNK?=
 =?utf-8?Q?61094A0qN+GzWXeqbxF4xrrPXwV4KOFXiv7eW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adb199b-c0db-407e-9f1e-08dee76b4b71
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:01:54.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxkGMZEnIXZq3sC5hA33rS0a+Hcpe/0Yw5nwuiEVMxoU3u4jzCnI1/g9YW8SQsIWQNDibAWsZ4rN8KeKiX0shr1BFOhTEWjBq+6KkXa4sfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368

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
 drivers/spi/spi-nxp-xspi.c | 130 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 037eac24e6fd2..0658c0557ff17 100644
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
@@ -796,6 +807,82 @@ static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
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
+	dma_addr_t dma_addr;
+	int ret = 0;
+
+	dma_addr = dma_map_single(chan->device->dev,
+				  op->data.buf.in, op->data.nbytes,
+				  DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+		dev_err(xspi->dev, "failed to map DMA buffer for AHB read\n");
+		return -ENOMEM;
+	}
+
+	desc = dmaengine_prep_dma_memcpy(chan, dma_addr,
+					 xspi->memmap_phy + op->addr.val,
+					 op->data.nbytes,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(xspi->dev, "failed to prepare AHB RX DMA descriptor\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
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
+err_unmap:
+	dma_unmap_single(chan->device->dev, dma_addr,
+			 op->data.nbytes, DMA_FROM_DEVICE);
+
+	return ret;
+}
+
 static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
 				 const struct spi_mem_op *op)
 {
@@ -1016,10 +1103,21 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
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
 
@@ -1029,6 +1127,7 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	int alignment = xspi->dma_copy_align;
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		if (op->data.nbytes > xspi->devtype_data->txfifo)
@@ -1042,6 +1141,22 @@ static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
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
+			if (op->addr.val % alignment)
+				op->data.nbytes =
+					ALIGN(op->addr.val, alignment) - op->addr.val;
+			else if (op->data.nbytes % alignment)
+				op->data.nbytes =
+					ALIGN_DOWN(op->data.nbytes, alignment);
+		}
 	}
 
 	return 0;
@@ -1203,6 +1318,10 @@ static void nxp_xspi_cleanup(void *data)
 
 	if (xspi->ahb_addr)
 		iounmap(xspi->ahb_addr);
+	if (xspi->dma_rx) {
+		dmaengine_terminate_sync(xspi->dma_rx);
+		dma_release_channel(xspi->dma_rx);
+	}
 }
 
 static int nxp_xspi_probe(struct platform_device *pdev)
@@ -1252,6 +1371,11 @@ static int nxp_xspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq,  "Failed to get irq source");
 
+	/* DMA is optional, failure(other than -EPROBE_DEFER) falls back to CPU */
+	ret = nxp_xspi_dma_init(dev, xspi);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
 	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);

-- 
2.34.1

