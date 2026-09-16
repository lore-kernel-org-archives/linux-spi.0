Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91425221E4;
	Wed, 16 Sep 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572412; cv=fail; b=YNtUucQDlZC7BgbYP9LwjP9Wk8+8U4SfwPiTXvim6SImN+H5M2fpPnUMIHGYofc8Q64HB8D8z0/+MJMp3Jc/wLwuAfiYvf7S1ridI4jzVHxyeBdPGSVW4cJsruT3wJ+G49HQ419BoqHwbScjDdJASG2DEqRn4tfABk8zgU7t5Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572412; c=relaxed/simple;
	bh=DzNlSPuISOtHP0yzUjVwhs7jJAVL04D1VM5X7uQNWJo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=O/nrXGIPuVrAcjLnaRAcUsHM6IgmZtyTh7/u5GbVubbFYOOsA49jF6zZmQbVRydDH+roAwLbj9AmC6FO08twU4oSQ+jftiqZH5dlVRGkam/IBfL4rKTBDObNjKgBiC1emyBJ26qESfDkMr13O2+VhHWKJ2lJvAy8DGo/qSucDj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JO2od5LV; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JO2od5LV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtvWVhJjuOfl30a7TlEhzvKiVjani1J7IWuzYkiLTSG13MoFS/Zx5Wx7NztXZBwP0RhBoidG4MTIVcUoSQ/ntu9mOnoXvYuyI9nrlPuJEeuE6sqtUyPzue9JL/ZfCeoxCptHL5w0lXBqYSGd9J07WeZ+tWFNqoRPksC8XS3OqKsOUpZS/Ak9Gr3kwF4SbZ5IbrJVYh6O78uRhNhmSz8y8VI6y5Zp25zN7aOBFUm5XUUtlvVsRLEyg6Vi7Op2gCFkCVJgWr0ECzSIKdDGuquYc3qCNQQ2gZGpQwGXKWINcUdJtMpQQeAgEyF1yAf8jSPcycVE+DjV4YuCavQ6q1cdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olLwf8xkIeeGlRdq+ApkvpZzajymoUlwdRB4YCiYuh4=;
 b=Zhqjs8q8hq3+wFRqLDwWBS1Cz7CPhuIBD441OvInmikkY7I9tQUocU3uJ7YdP4d8ox3i7AMUsxH2+PwztQBgvYOEmnyEgv2r/5Ly4zqpHw9x5/43U0we4K+08jtNTVRgUGu/kco5wf/rdfIDJM7BuJRjREZPUz9Ufssrd99iRAdXH6Q8rdZxdVbRNSMMUG8Z/9jqzoXmauoAo038IDepmDCGtT+qoCRGcz5VFhZWzL5atVH4xhhsntFqnx3Jt0HDJmUn0exlG56lFj9d2pzLe1qGehIun8NV9soRm6MfBwNIvf5xS/pUt4w39n4u3T0SwwejZbUJQgtv+d24La12Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olLwf8xkIeeGlRdq+ApkvpZzajymoUlwdRB4YCiYuh4=;
 b=JO2od5LV/xH8F3oJUZXclz2uiCFMRhKIJ2ZiIKJKTPGn8AqoPV6Ef4/iLruqIKhBfUn9P68UAxbMPzWva20Ei1V8LIheH9IyKrTfEUg02KcW5mFeo5vvHAyd/vcrdTj9XtURvb4s4dJVmfDKvpaWKv1nxlGD0jvgVJpY4H1SDxvK/TAMcs0f2AWev77/ogkEBzDh8bM+x1MeZ+LFzv63o0BArZbznea2eA0SqRC9by2j8ZaT5v1fvKmngKoWHRSVjxmvgO19h3MdHhXTHtnJzH6prImq5wD/CGnAiYQyBmo/RWlMktSrXwptAXKymN3TYOdYbzW0JlltSIGOkewZog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB12446.eurprd04.prod.outlook.com (2603:10a6:20b:762::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:26:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:26:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:30:55 +0800
Subject: [PATCH] spi: use dmaengine_get_dma_device() for DMA mapping
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
X-B4-Tracking: v=1; b=H4sIAC+2qmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Mz3eKCTN2U3ERdEzOzFINES6OkFCMLJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAAvMzhtrAAAA
X-Change-ID: 20260916-spi-dma-466d0a92bd28
To: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB12446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3a2892-4fa5-4fa7-1427-08df1406e820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pFwq/cBy4mWJNMABBkLt7EK7ZwMH9buvfcgeKgKfJrOfr0GzStd5ZBX1BL93HXk3k6InSh1kEtZIfjRbDIbNxJdDfdkt9Ux3z9NSjxWrap6yZS0USVyt0i+oOtpo1RLDk2pgBVsziNClxqeOJOF1nD9enVUIFfmiAxebs1XgluXhfEp1+2V4Rl6FIH1aTRKKm1H/hPyJr4z2wAo0XlR/c4WFi0y/TppfJamXnXIARb9HQ7zuipziP24rL6yeimi8UJWqyFdXec95g+NpA0/qWrvls4ya5nCmQzFRljHdbfEfUt4htm+81I41R+c3p9yo4f5lOIS8MXuU4COHo4WgnN8OLm7L/ElvxkuMyye5tVETf7j82WJO8+7yajdFqiAi2IDDL38+KG2sOQ6BxIBwkBw7wCTFGWPUqcBvhsYqeSx+f+ggJYFap9CdHA9ZCDR8NC0R/ehHjudGZ+oXbmcGDBVXeqqq8yNuVnGYiVvtnp0UuDLIuAV9Vs2j2546yauBctdVLe2mhSqcFb8RZaOWx9pC9jvDLqyPNl7rfcDD8d0T4LbMHRNOkyp+Nickr4Rvm8LdUFzcKu+5ii6ORiKPXlJZuuo5uuXPBDgV64ZTD5qOOetk8MYmRYHqNZKk4PcsP6UfCYc1ZocHF0jK5Kcush64+qtn6r7Z/VHv3HMps+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkNmZjd5WVdrUGttQkd6SEtaWjNsUXRaK2lkTlY0Q2U3ZUw3eEkrOFRvRnBl?=
 =?utf-8?B?MnRYY1FQRW9aaGJUNGYxMkFPdjF4VlJ6a05hOE1UemQ2VGo0VHJTeVZYZ3k2?=
 =?utf-8?B?eHhLWG1iek1Canp5VUtoLy81cjV5b0R3dmxCREpGSjZ2NXBmZ0hBVEtlUm9L?=
 =?utf-8?B?WEFjNHNVditnc0k3d0JuRlhmV2tGWStBaFpYcHlBYU9uNDRaUnlHZUtYQWxS?=
 =?utf-8?B?cmU5WnVERWRWSUZSU0g5WFBNM3FoYldtUVR3My9DL0RFckErTUlReDN0VTQy?=
 =?utf-8?B?bVFrZ29iem5rZnZ4UkZYajBMS1VsTkk1b1lBOHA3V21jUEhIZVhQdlMzZDFK?=
 =?utf-8?B?dWtLUGtORWl5SnNOUzJ6UEFhU092M29Bamk3dkdYdmhaL2Y0S2VPSGVuTEVS?=
 =?utf-8?B?ZHYvUU1mWmxGOG9zMHBwR0dZcEJBSmJFZFU1WWpRNXdua1RNOGpkS0hVaVcx?=
 =?utf-8?B?Q21qeE9UcWJ3MXhGb096SG5mNVY3UXJvbjZvN3YrSzE2M3JHOUZPdUxJTXVZ?=
 =?utf-8?B?aTVtTFVUNFYvTUFzbDZKR2MxRmNVeVFRSnV4ZW8yOG5QdzR2bENrR2gzWlJI?=
 =?utf-8?B?cDIyYTNOT2ZGSnJDRW5Hb0x4WUEzQk5GbHplNGpzYUROL3B3M0RGdGdreHFF?=
 =?utf-8?B?MkcyOEtxeE9kZUl0Um55VWlSbDQ2RzAwdldMRE1NakswNWNWZk41N2NhckZN?=
 =?utf-8?B?N2FkZ2U4NE10YlJqZVBoWDZ4MGJnSitnc3BBNkg0RE1BQTkwZEExclZOenBT?=
 =?utf-8?B?ekV1bG9XVkhsRUJDaFVNT24vMzFSV1lLMUQ2anR3NjZ6TEFGWDNYZ0hSVmEw?=
 =?utf-8?B?d3dNa0c1dEI1U1hTU0VYUUJnUyt1K0NRMzRTN3hmQmNiNllJV0tGNmRpaHdo?=
 =?utf-8?B?ckpMK3l0SnhlTXFXelkrR0hTUm91RnZMUC9WL1FHRzl0QXZ5VUJ5czd0M1BY?=
 =?utf-8?B?SWFzVFdkUi95dlFORkZxcEl2bGd6YlBYZnNPY2I1M3VNZ3Y4dFBwOVVGQ082?=
 =?utf-8?B?Zm1xVXUxVlFXeFViYXMwbzVVVnRyZ3BQQjRvT0VlTHFSK3ozbHphRUpYa3Uz?=
 =?utf-8?B?UjY5WjIxRXRHbnI0YTZGbVBSTENsbm9HYWltR1N1THhtYjB1b2RpNjBlSk9o?=
 =?utf-8?B?TmUzSms2QUU4Z0RhWkdaWkt0bTZ2djhIbUhuOWptYXpTOEl3aWxsQmJJVktV?=
 =?utf-8?B?SFdFNzJxTHZKTkY1UVd2QkYzTVhMVmkxaENTQ2tEMFY1N04xQ0dvSnYvN3A2?=
 =?utf-8?B?SldDdDJmVXhpbHJxQ1FILys1SWpzTERTZkF5VWw0dXcxSllCNlNuc1JSN0dm?=
 =?utf-8?B?RVpuaG91THJyWThaNDF4K1ZoY3J0cUgzSDhZN2FQdGxJRXZ3NTVHZmZOL25m?=
 =?utf-8?B?dWpsejhVUXV4ZkZDQ0pydGhEbW9yb0xPT2g4QVRvU0gvcWFzMmZzd21xcnU1?=
 =?utf-8?B?b3lGTmRMSkxHLzVvdVlBcldrMlA5UmRVNGlmRFFSWDV1eStlT2dmVmtJamox?=
 =?utf-8?B?SGJjZ0lEUys4bzIwQ3BGWmhJVTMzenMyY0Zta29ZUXJ6TmVFeGgyMTJMQjdM?=
 =?utf-8?B?UkovTDM0L0taS0J0d21OaDdJSkcwWktWVUh4YlcwRmpod0o0eENxeFRmLzRW?=
 =?utf-8?B?WGNleUdRdTJFYW5qNGZEU1FHSzQ5bkNlUmhwRzZuaFFrL3FEVGxXYkh2WVB2?=
 =?utf-8?B?KzNUYWpDek9NMnU4UUdodC9jSXRqaTBKTlptVXZHQkZIbXR6YjVWMFM4UEU2?=
 =?utf-8?B?Uzk5SkdEMHJhd3V2WHRpdW1WZE1BN2ozU3J1Vm0yRzUvNlFCNGorOTFGSWZj?=
 =?utf-8?B?RnBSOUY1QUsxcXE1N2ZUQ21YOWsxNC81dFVVbm9Qa0dHc0ZaVm45ZE05VEhG?=
 =?utf-8?B?QjVvU0xYNUwxNzc2Y0VhZkNKK0tQaFZLTDNUUXlDM01GZmt4SUJIMHZQM1pR?=
 =?utf-8?B?S1VNMzdLZ1FYUUplOTJDQng0Wkd4Sm5JZURhdzc0cXNqcWZndkRqUkZLSTB4?=
 =?utf-8?B?Wnl2cEkzNkdrbmNTVCtFZ1ZUcUpjL3dEczdZWitxS3FjdmJraTdSci9Bdklv?=
 =?utf-8?B?Tm9nWHZ3eStMVHNJREZORzhQUmViNjJlMFBjdEpCdjBMY1VpL3BQYzhxaUpw?=
 =?utf-8?B?UG9PVmFPTSswKytUK3U3MlRibEdyUnRFNDdPUjRVK1FsL3BHcGM5TzZWbUtR?=
 =?utf-8?B?WE1Ga0wwcURWWmpRc0ZsY1JJRXQxMkxrb0J6OWFCNWhrcjhnczc3SkpiL3p2?=
 =?utf-8?B?TlJvejNUWm1NQzlPTys0dzRKUEJxR3JXcEtIR1M0TEt5RFBZZW9SanVSa2ZH?=
 =?utf-8?B?US9GMXNjRUNkTXFveXI1aC9ZNUczWHpYMFlodEN2WUZqTVZOQ2w3UTBPWVEr?=
 =?utf-8?Q?qkJcCf4Z/DOKf94faAbvQw5AY2M0QpycGBa7w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3a2892-4fa5-4fa7-1427-08df1406e820
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:26:40.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZUvYuZN15a2W6KMRqIlueFdTgtgi0u5vHuenW4t/i+vfNiEdsnOe+BKZZ+X+hdGwbNwHiUWAbFFomSWpVonL4O0d765XV9SG5qN9DPByXR5TQCQRQ5BxPwtNhI7Ke9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12446

From: Peng Fan <peng.fan@nxp.com>

Replace chan->device->dev with dmaengine_get_dma_device(chan) in the
SPI core (spi.c) and SPI mem (spi-mem.c) DMA mapping helpers so that
DMA mapping goes through the correct device when the DMA controller
has per-channel IOMMU domains (chan_dma_dev=true).

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-mem.c | 8 ++++----
 drivers/spi/spi.c     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 94d122be1c930..b94680b60af95 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -46,9 +46,9 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 		return -EINVAL;
 
 	if (op->data.dir == SPI_MEM_DATA_OUT && ctlr->dma_tx)
-		dmadev = ctlr->dma_tx->device->dev;
+		dmadev = dmaengine_get_dma_device(ctlr->dma_tx);
 	else if (op->data.dir == SPI_MEM_DATA_IN && ctlr->dma_rx)
-		dmadev = ctlr->dma_rx->device->dev;
+		dmadev = dmaengine_get_dma_device(ctlr->dma_rx);
 	else
 		dmadev = ctlr->dev.parent;
 
@@ -92,9 +92,9 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 		return;
 
 	if (op->data.dir == SPI_MEM_DATA_OUT && ctlr->dma_tx)
-		dmadev = ctlr->dma_tx->device->dev;
+		dmadev = dmaengine_get_dma_device(ctlr->dma_tx);
 	else if (op->data.dir == SPI_MEM_DATA_IN && ctlr->dma_rx)
-		dmadev = ctlr->dma_rx->device->dev;
+		dmadev = dmaengine_get_dma_device(ctlr->dma_rx);
 	else
 		dmadev = ctlr->dev.parent;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 172141650b648..4f9f34b798b66 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1456,14 +1456,14 @@ int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 		return 0;
 
 	if (ctlr->dma_tx)
-		tx_dev = ctlr->dma_tx->device->dev;
+		tx_dev = dmaengine_get_dma_device(ctlr->dma_tx);
 	else if (ctlr->dma_map_dev)
 		tx_dev = ctlr->dma_map_dev;
 	else
 		tx_dev = ctlr->dev.parent;
 
 	if (ctlr->dma_rx)
-		rx_dev = ctlr->dma_rx->device->dev;
+		rx_dev = dmaengine_get_dma_device(ctlr->dma_rx);
 	else if (ctlr->dma_map_dev)
 		rx_dev = ctlr->dma_map_dev;
 	else

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-spi-dma-466d0a92bd28

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

