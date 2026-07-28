Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416842125E;
	Tue, 28 Jul 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233720; cv=fail; b=VprIGV2SHTfE9hpeI4G+BFFju7JWMezNtwvHLU8NE7X8UrfRjMf2VvDiitVP/eYcoC2gY0PhhWQ9L6cgOMQSc+Xeq4jJGkqxKlVivNqv+I2EZblD0Htz9udhdg46Fb8u5aPZQGoDNXD/mxtxFQ7+PISX8tnQ6jZeRpztuXSXHvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233720; c=relaxed/simple;
	bh=Pb48OvdPEoEBEAIEuOyTvpnDoDVlfbQTJav3OFbCQ8w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TNZI0r6j0XVcRHMQCTWnt410MuNBbiPb5RQ8eH21NIImjY+zissRGQE6zg59a8SM0TcirQHzj/bmiYW3dHrpVnFR0buf9FeqEUEWdmh0KPh04NyEOsFbbFCpJrJIejpc8iNc761WLGrymwh/656KQ1ShGb7OEnHY1SWKDCSGI70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TneboMmN; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TneboMmN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHhPP4BlltjOpIT0eRlonIGrYKywrLAaKkuT5FuV4g2917I4FpVviJnD1NmSqUnWqWGV8LNxLlbhSqEVBriAohlhGY7C4bWn0ftQLXvx7AdCJaLMiOmkwc4Dv+JBS9fvQDXiCe6K4AuVLjPZlgt+uRj3ClmCW08WXXcEC8Cq3kBDveTQy/sD7a4DA9jwHAhv1eTIlGkj24thLFsu4aBzIWXINiFSPU0d/9sSCw2PyFSC+ycRAEuhbtg2u4y2vU/SZzrt/LOQGtJIymPUvMoxs0q5GNzUPGAz4F96G08/IwrJuLtK5cWQKuMqtLe7CLcA73B7mNB0OM4Qt9X/C5sLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IeBMf/U5pWCOfVFTXc047LgZJda9/xiVK+47pEdE5U=;
 b=cgiaIA5f3jPZD5efM0HZHBO1NyEjxmQG3Qq8kCfSEzcd0ItBuSbzmsGBKYU+EAkvHPQshIqJsJcISDE1Zp8CH4eRY9vZOvSAXT+P9z6CORL5j6fGrp5GIz4s4G4NAHWKJQXeMCJelzUvWtZfIbJsInZxkfIDJFKTaK3o1BJm6zlUPgswH6iVaEf3QvGkCIZqqBa83VTo4USU4+aS64gNAizxOOGvKbZq2ASIAsuG3qJ9g35RKBIko3mPSqo8c5nIKVfRL1XUzHXOo/+5iY/MisvgmUds8PImYg0ZawAIl0WTyoYiiRw0ilnwLRojpUmuXByppp6cesbXzOJFM3ZdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IeBMf/U5pWCOfVFTXc047LgZJda9/xiVK+47pEdE5U=;
 b=TneboMmNrjpUGYeTCEv9DxETZNXh7MdC/A67fErhSCX8hN+l7ouFprH+0+ntL3AlycQ4Z8R7kgUL+8hgX8wuxAD3I9zIXIeB0ZIARDBshDirAWk8z6VPzCnzgL9eyR3JsVFeyhBzzm2LANwRu3SfVQraohrtRSL17aHL64XG/9yHaKqYwax/Nm7rXyfdpqSZ0BFW5x9o5+LtuBJdONC3AkZA5ODIQdkoXx/Uo4CFeCILP04eTMhafY79lCoUbBcsJtiX8DcYtWHK2ggkINbqAdl+jyKg1o6XHq7uDRyn2X3v4Uetn5/cy0KpaT6ExoSZ69gBioRLiM6BZRLSnC0Shw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:15:15 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:15:15 +0000
From: haibo.chen@oss.nxp.com
Date: Tue, 28 Jul 2026 18:18:09 +0800
Subject: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
In-Reply-To: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785233928; l=2390;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=QQlfrBYKbnvKMVz/QSkjbtxmhutEwKfX4vHYgCRxoks=;
 b=t6N8U2ZgXAtwaFaeEDHcM377fBUpL6nfR2hTrRp9Bzr0lE7uiuy2Ir3+iyQg+otXpBJ6Ehh7F
 VN4E6j8rwyxD9CurdmHAacXhghIyHtLa3GMeR1ZwO+8qVuLmC8v0m1A
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c56312-2967-4089-b005-08deec911de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|56012099006|10067099003|6133799003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ValdVlHmgswKxL6fFEo5JvuXuE3DRwJ1Gr+MJAXQ/MVXz+tYdQi4et7c5LqSO1bWiO5vepiJOFlH8HOUjRiLuUxe3czX3ziZdjRoszkhxjljsGc2w7x7H3LYm9vNlTh41b7mKHwmUXBFNiuIRsV7N0XXg4NV+d+IxWv6YqytGUQEv/wEe3UJa72ZO7NLzRmYQKSG2PreAT7EXi/SOV/JEhu9fnlTlURcM+ezqD4xbJAG8VFBGmYqEStanaT8xVEgaYNa0sZ2PAMJWSpuFJEIflKBEQUJVcmWqVa+6JgEaCwyecBsCTaXnK06iiyfD+dbDLeht5fUkiGd/M7nUoyRVGsmdvceDcLCTH8CPHXBRm5gI1kebGo+oQ/7zLXstd3NOseMnR+BXQ1yZtKg2/MfWLoc3+CWDx8/MrXZn+5+8zg3ypzQlfi4rxTcSdfBA93ybTtDZJizztMeXCUHJdmmXw4PaY8eWwJjZMjldFykaF5q0JPuwDuwmtYt26fTe//uikUiuDUVB03k0N6oexFCzDtHOULgX9zAJ4tkggHXN9OANChH90DidtyszbyTz5vx4U1YOqwTD5rNnC2AAnT7NRoPyVq/WezojOREqTWlFAb74Cs0PPLexvCCnPujIFGkFITuygHqLJXhlYnCr4jGi25yotJpJjHxrrCy9zm/62k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(10067099003)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5rT2Flc1RpcEdKdU5SRGlZV0lxZlhaNVU3S3FsaC9GUS9xSmhKMllrMTdr?=
 =?utf-8?B?cmNsbnc5UjdaZUM5UHpUMmp4ZjV0eHNGcTBvdVlnQXBQOTJ6L0g5a3c0RWhS?=
 =?utf-8?B?ejBkWXI0YmVoeHgvbTV3NWsxR0tudXBzc0lxQzRHd2h0LzVKL211Ykp2QmE3?=
 =?utf-8?B?SnpaTnVUVUNEUCtGeWdLbHFHVlNVREtoYnFoMmszN2lyckx2YS9uMVpvbHpu?=
 =?utf-8?B?N3hwdFZOYlZudTViVzdtYW94V0xtUzI1cURIdnhoOCthRmp5Q0lJR2lvZGpC?=
 =?utf-8?B?YldEV3N2ZzlFckpCOFpsTHdwTnlidHhrcHRhOEwxQXdSNEdhQWpxblJhU2Z4?=
 =?utf-8?B?N1g5Vy9uRzdBZ3U0bnY1RGZHblA4NFlZandDZ054ajlwd2hUekxEMU0yU3Jy?=
 =?utf-8?B?OHBBdFR0ekVJYmxGUU9VcmpJYUo1QmFaUWdSaEVyN1BzMkcvaWorSUp1M1Ez?=
 =?utf-8?B?Z0ozS29WbU9CL01OY09sWUdrOUEzSnN0YlpHSFljL3ZaMWxIclo1MzdtRXg5?=
 =?utf-8?B?V0RQYnpXemU0cE9vcXpqRDFNV3c2ZWlkQXVWVXo4NkNvcDRERWN3cE90TDh2?=
 =?utf-8?B?L0hpa2tkT25vTCt0MUs5V1h1WTZqM0pSYlJsYjNYRGNza0gyT1JwSk42bDhq?=
 =?utf-8?B?QzF1cW0xUXE1L2ZYcnZQR2tUQXFleXUvK09XVk9jU0tVS3pQRW8rWUEzbnFy?=
 =?utf-8?B?d3FvTlp2Y2ZzVzk2bC85SE8valkzNmpacks3RE56c3d6Z1d2N3JtTFRjWW55?=
 =?utf-8?B?dklWNktXcERFMEdMMXRSazFyVk0rK3hwMVBLbmpJR0tVb0FzdHlnUVVjMWUv?=
 =?utf-8?B?S3NrUmtDbFpHbllxVDVIbDRaUndmdnlzWlpHdEhBWENlaGdSa045U2I2ZHlH?=
 =?utf-8?B?ZlgzbTE5MVdCZzk2dTJralZXUDZTdEtON3NEUWJpYUk4cTB4UUtQVDVVZk9i?=
 =?utf-8?B?WHFBcUc0T0RIZWxBNkZTUlVLZjJyMnA3SVl1b0RMUERpSHhVclZvZkFkMGM0?=
 =?utf-8?B?RmwwdU1IZ1VRMnczaHZ4ZlVKcTRCQWVpTkVwTkxhWHFaYXhWRmVYMUhkdEw5?=
 =?utf-8?B?cFJ3bVJHOFExMHdGbGtrdFdzWnM3WjByaVp6cU90czliVXJ2MVhYaTJNbzE0?=
 =?utf-8?B?RzBkaU9sZTdpd3FWWWdrOVRwcTlvT2NJK1dQK24xb2Y4SVFLdlJsQWhubzha?=
 =?utf-8?B?NHloamRMTkUzeXE3R1M2L2gybGMxdCt6S1U1ejIrLzBpM2VGYnViUGxmdW0z?=
 =?utf-8?B?WVFIWU5maStBRkFSNUliSWdRdU1CbDJhVFQ2NUhTZlRBcnd0K3M4ZEp5Rjh4?=
 =?utf-8?B?ZWFqZVBpbWZPSjNHNmh3RHlRWlliWjNPdVBQQkR5OThPeWc4QU8xSE5XbFJr?=
 =?utf-8?B?VE53QVZUTk5XTUZJd0xOOEQ0MjAxRzFjUXFyQ1k4WWNzakRRa1IydTBEc0hQ?=
 =?utf-8?B?R1BuMkp0WHR5MWd2TThHN1IvWXpFenVtNmdDQXZtUXZtWEN5czdrN25yUmVD?=
 =?utf-8?B?U2htZGhNL0tMR0duQ0pycE9jRjlmdXdnVjVUUTVIdk5iY2VvNUVnaDlKMlZX?=
 =?utf-8?B?YkFiSUNNeG9BTWlaVDFRTVpLUGpXcitXZ0lpQ1hPQnkwTXBVajdISFlGM09z?=
 =?utf-8?B?TFQ5b0hRcllNZG5FdUZMVWZKejVFRGVadjkza0x4RjdnT3JuTkppK1kvbWU4?=
 =?utf-8?B?OFBqcWQ1TXhmTEFGNVhXZDdoamcvWTFUZUd6S0o5aUNTeHB3TGFOMkJGMzJ6?=
 =?utf-8?B?RzEvZXNUeksveWM1TTlabU9sci9TZGFmekNZQ3RqbHVUMUdiM0xQZUVYUFFF?=
 =?utf-8?B?TUNtS3U5ZlJWME9ySml0R1N6NTE4WlFieGxXTnFqcS9nN1RxamdYcDNQejFM?=
 =?utf-8?B?bWMxNGUxOG1KMDhJRno4MzRuOVQ3cGtqUWFWMnBqM1B2b1BQOXA2WDZLc0pG?=
 =?utf-8?B?M0xvNUlyN214eE4rbXNTcUNsbGQ3OXc1d3FjclExanNiT0NhWWFvYXdzWklv?=
 =?utf-8?B?TjkyYmN1RnorK1UwZkVEdnRSS1ZOS01oSFVEdU44aHN4R2xtZ2kxaXpwYjNq?=
 =?utf-8?B?ZWFpbWVzRUxNWCtCTUY2dU4wVEtzekswSFRIaStvVzBxdmhXU2x1enNsbXhK?=
 =?utf-8?B?ZmFmR24rMEpiWkh0dnRrcGpueWx5MkcvaldmemMxcy9oRG9rMEZueHBEM0pC?=
 =?utf-8?B?NCtIR2xyc2ZUcld5MlVLa0dxWlNVV0Y3ckxucE1BNVQwdkRPREo5dFNnUElM?=
 =?utf-8?B?TG9FVjZXblpoRlBjaWNocFg4cXI0anhxaFBUSzNaeE9GcVBLekVMSVkxWTRO?=
 =?utf-8?B?NUpFM3NZSjRCL3k2QlpvZWZxa3BkeXNUSE9paVEzR25rUk1WVlNNTVpIMWdX?=
 =?utf-8?Q?nnXmV4Kimookd8TQasPbEEkJ2/c+j15wDXwkr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c56312-2967-4089-b005-08deec911de7
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:15:15.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDltiVECjf0C91hDGttit9uYTcgHtdRlYb6ZuRCTP9JqkEai5dmoqZiRVV7oLpCFxHzINyjQ8bxBv7ERjUQsMs6tCMOj1seK0s7uBA1TFwKIUipa64YUml2CEF7LTXzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

From: Haibo Chen <haibo.chen@nxp.com>

In nxp_fspi_select_mem() the RX sample clock source (MCR0[RXCLKSRC])
and the DLL control registers (DLLxCR) are reconfigured while the
FlexSPI module is still enabled. According to the FlexSPI reference
manual initialization sequence, MCR0 and the DLL control registers
should be programmed while the module is in stop mode, i.e. with
MCR0[MDIS] set to 1, and the module re-enabled (MCR0[MDIS] = 0)
afterwards.

Wrap the RX sample clock source selection and the DLL calibration/
override reconfiguration in a stop-mode window to align with the RM
and avoid reconfiguring timing-critical registers while the module is
active.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6de6d432cdcb2ee383a02d72f20000045903e176..a426b8d92193a4e303f411cd17c16cb31c3f3873 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -867,6 +867,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	unsigned long rate = op->max_freq;
 	int ret;
 	uint64_t size_kb;
+	u32 reg;
 
 	/*
 	 * Return when following condition all meet,
@@ -896,6 +897,15 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
+	/*
+	 * Per the FlexSPI reference manual (initialization sequence), MCR0 and
+	 * the DLL control registers should be configured while the module is in
+	 * stop mode (MCR0[MDIS] = 1). Enter stop mode before reconfiguring the
+	 * RX sample clock source and the DLL, then exit stop mode afterwards.
+	 */
+	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+	fspi_writel(f, reg | FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
 	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
 	rate = min(f->max_rate, op->max_freq);
 
@@ -928,6 +938,10 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	else
 		nxp_fspi_dll_override(f);
 
+	/* Exit stop mode now that MCR0 and the DLL have been reconfigured. */
+	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+	fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
 	f->pre_op_rate = op->max_freq;
 
 	f->selected = spi_get_chipselect(spi, 0);

-- 
2.34.1

