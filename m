Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D53C5546;
	Wed, 20 May 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270072; cv=fail; b=DnNSjSC7oHIxifsGjuBY8+5vBeCmHLRYvaw+kVO+HyzXjR3WY1nO0Yprp/G8N7u59uxHF0wc79/YBSNIDORbZPiyr/0wZGeDSS5ixSAxA7cKdfdg0g4AvZ5C359xFPJE8HqwiPP1uNVpIn3AmbUjbeYMs3W1HdchYsw2khtYG8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270072; c=relaxed/simple;
	bh=hJe9gB8cMPzSKYZPPZUlDHF5XxvQjJ51/7Cnal4Q5B4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eYDllmPm7dsRsQcukw8Gjz/vrDRHQfXwgX3+xXQaNLQvKqrVKDVMrH0E1J3BFmJ4AKv7l51v2HlRkEh/oXUeplPO/9kaftGOJoNiDv7kSnq0jGCbqd002qqeEbQ4QN9DVpjTrMa2uKaELEMxOeGRChGKKWC1SA9b7ck5JLodPWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=diu0ACQb; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="diu0ACQb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW9wmx0OZ/NdgEMUop4mEBGTfraHbY+d+ThlMDloUt3jeMNfdmnzEc7gUtKz49hkbgDm16eK3gr0YUQ8jn/eNWxVw8AnqfrEeN3QXka7venrhre3EIsYtW1tyW/+duicI/oS0is/PVCxRVFg0yTaSGRxdGYyacBpg7MxbOyYaWZ5pSU/PziVgIpkIRezU69FCwd88AELAajjoiySRUvVwRPiE//LYDXaK7df98oZPtcGquQI9pHGV67OIP3oW+XZeIEX+/W96UvSdsDH2t8cbNoqfam2eaUyCs7880vjAEZi5xOfqdRP5+b0L9WorE64QLfTfxK2qYxhnVfbiJIKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2sOiakOKfYdTG3KX02ekI7S6/7JSkyHPbfOtg4N8Wc=;
 b=UBjX2uvIE0iYylDLixgqwu8ixhtEVzzyKi3vJ2a+OU4gxi0DYKYX23e6iL0C4cIdyWjfhhOHArC9+7Fr810tXFLJuDio1vlO0lUwJk5lAWVtm01GcuopgAfyOZ/HDBFtmq0LHB4ON5fXTRicywWrb1r3unn4cj+n3+GvpnHR9kMa2gYrkDsL3M+yUAZ3dIhiyCZajMemCYa6LDUbKMeojE2ofux88qxePWlur2C2ulUtgjgqhgAsll52qKJo3lx3Ty28jGB0vapHRShKIxqPJQE9Q711Q5n/zAEH764n8S3+NjgPJsdi4mkt4SSvdz1R20ev0583+lUkSEKwUrXXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2sOiakOKfYdTG3KX02ekI7S6/7JSkyHPbfOtg4N8Wc=;
 b=diu0ACQbAXCInNNsE+045WEJElx5ddWC+02iHQxmi+5lnDA3Os6fN0RbOfBL/B7Hj7gsXgX5imrBYxc03xn3QU8C4dMdx3aEmwNUkwcNR/oqYUFf5Z4uZmCRPjAqGRsBkdvHaMJAhR+GB/dmNLT217wufwLhE0IzrfjmVgzCSPF5ASZ+qLElxYo1ddB6a+Dl7UulwXG1xoPoxocNBzg0xz+hcIFbtXYACokBZUN/RSOPuH4HW01vFNxm38PQF03qrXGLyuL0rWmOhlq2ftlkXFeVHXK3vMPJtWcfFtJOJjr7Bv2j28ideG81znoDn0y5uNbEa0qvBoMWxoMGh++uVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:41:05 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:41:05 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com,
	Fugang.duan@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v2 0/2] spi: fsl-lpspi: fix DMA termination issues
Date: Wed, 20 May 2026 17:43:06 +0800
Message-ID: <20260520094308.2882892-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS8PR04MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e88a01-a0ab-4557-9703-08deb653e9d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	e3dXiGUQX//8gJO2IBpb0RI3HmJO9dl/XmLTR4Z6c2otpLFTgZ5KJ7AXJ3V7WxJoSYJjbmgFYVGgxdIS+Nhfb6smPzcF/h3Pk+DU6EfONCJ+Rgn0YT7wXw6vXeanVsaGgN4IPRmduAF0S0HncCLFNg1lT5eFZBUQVR95hML9sNYviU70LHibKqzgEcrQa8/1mrzLAuBPGaZFE6NcTog4qTp7v28swrtnRJxFp4+NRIOdLwLiTatvJXupke95oJ/zrhvbEXeSseMRtoVXP64dASphMk0lyOFxBwO6IDeHk9HwXLcb2K+Efl5BTQJOi1jJ8LDIBjSRBO9DrWAl6h6zm/yQTH/2/VQk/WVkSX0NkOg9lqqZnyA4QGNdyiFsx9dIHfkoKP0DT/BhkPmeBxEtTeih5JK3mUkCaMvOrpk4P4XRZsVEWX4+sOA6y16cOMKln7n/htIvKTKH2OSe0hOcQYzGbMktlewEgiKieQgd1ZXuBBzu5l5BZnnq82K3ewO+prgPM1mzkGiuawx38XfRCchyk8WzUWPSD6a7kQkukqHmOmeAwV2tZW1TheHZFnfRAHsrq15Y0dATijTGpvyADL+HwNR1TT/OrYx3qtaZYpr5BEod7QcmI3Yvwj45Jk/vMEssfqPcyDWxiII88RAS8ijhVOb3g4+X+DSSAE6HY4Q4pDXswo2rrNdzvDFUrwQJvEHTvDZhmu6/hjrajpBS+6oBpebH/GO7RdYKSDNh8HSc1ohiOAF/X0cB9unAggfT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhEYr8wBAMJmBJcAf4buUn8ymoGpiJvkpn8dzUy452KAdc6s1FJ2yfyT0IoL?=
 =?us-ascii?Q?l5qyjYLoeW82moTg1U6IH3D4DTwwizAGm3nOL2Gj5PTtrAG5nbS28+qMcBdF?=
 =?us-ascii?Q?RL8hT+b2QsE/CKMmCQxHppmzIlYVHHrVPkFE3iDT0AMJDbl0WlncPIp/7Z+c?=
 =?us-ascii?Q?vNwPE08qo5GYQT00SczYj621a4Fc+jcMw+u5fNIj5S07cmbwx1ueOliFP+/i?=
 =?us-ascii?Q?LmIIquptUCMoPBzdhbEYfuT2pxTST7r9L3fVPFWyvTpRSoWWRtlowsHKQvu8?=
 =?us-ascii?Q?HuDjDWF6zMY5Gfz7gI4UF3Pfya8iriLyHGiKjqR1xW4DhcBoe9G+sgYqR3Z4?=
 =?us-ascii?Q?0awH87wfuP49uuWeYZg7NnEPMlVGm59VoWnWQ5sq6kBkTAwg5I25E2cvlgGS?=
 =?us-ascii?Q?eZEfuHg7C4U5mIIjvknhq0JBCmK4qkAuwBsZOYf0QVWuZzEOR2Khwd8DuVvc?=
 =?us-ascii?Q?kbbApP//ARgKqRg6Z+estAoiVSjNPM3j4zsI9OL2GCk6d620Rp3T/R9AqPph?=
 =?us-ascii?Q?mYutwzWam/bZh4bQi0YYVWTgbHmnB5NibvMLkNe85Bt5ZfoznZFQwPbOT6LV?=
 =?us-ascii?Q?hHzltxlAsa+km6KzvJ2AAygC9ltFTM8pDbhNSLm46SAUtsKj5X3iS4G+aK8X?=
 =?us-ascii?Q?dHtf1XSjBfO4xNyv1BhEZWuKNsvUkUuInxsMkizudFXU09QwedVGkDNcUpPg?=
 =?us-ascii?Q?c7wD77Ofxp/TgPWY5tosunxsgcVND3bODmp2TB9tsUU+tyUx1n76DsRFHHo0?=
 =?us-ascii?Q?tHEQYtllEcOs7+wEBeAoWl9SZnphXXpmocXcm3+e7TAb5lA2JYAhDouM3JVp?=
 =?us-ascii?Q?4DM2h5qFFAQViv/dbYbD0VXCDOJfwBjRv+HBEvbVvPAc86EtpkBGCxUTNIHn?=
 =?us-ascii?Q?WY3MpOWJrs8yHgB5jp8nkTzbl89ZUuyK3Y7OgaVyiorGsLx/4voVpDgfGDEz?=
 =?us-ascii?Q?0Fu7XYvLr+EEqwbjkvMSrbGFygFq38XkFQbhW6HzA0BR0irQKpULpgZIexrH?=
 =?us-ascii?Q?TRTspARTTRyUGXj41mUrMcRRCk7TR8jKQrFG7ysdti2/2H/ZmDAuQj6X3+KS?=
 =?us-ascii?Q?VxzAvnF5mqolhDP4Fm4t0ETM/4xEfSU+blAsSaxgQU+LzrFHkaBWzgHhQh/C?=
 =?us-ascii?Q?zSGI5PTusPnTmoBmlcHWgjBSJUBfwALTY44HTqzOuwlHjSApkU79H/DLv7sd?=
 =?us-ascii?Q?ALcmZNmng5qhpdi70I9IzS/PPzki/VFuiSQnKDCNaCsfaXpVWJ8NnnQ8CJ7g?=
 =?us-ascii?Q?d3f2SouowcHw9Rqo+IHZZJTHOOz+eH4/iNSuW1sqfVlnbi18oKY5Reb19DFj?=
 =?us-ascii?Q?Y7IKX+o7HHK2UudsShZi2Y17BosuVpiOR0c/pvesJTxm0Z6eslMi8/pbZuDI?=
 =?us-ascii?Q?9CzOpiGNnZQ6PnLGp8PMNohoMXYIRyiZFLGolw9ox5RrabRn8kvYoxUbcHe6?=
 =?us-ascii?Q?V8lRuBqZb/a2rc27C2/9+RCZovr/rjYWrtrAUJPppibXiSsvY4qVyLrkIj/d?=
 =?us-ascii?Q?wm7NUtgPcufQLE4LbvVhCzsUCPN/4DD8/0b/O2/26u9LYZlsnjdiZvf0BVH6?=
 =?us-ascii?Q?sbfxhsxD80kmSOMQs0SmAa3wf3xhrD8QI7DMX4EiMn26R8iPHSK4fmPmyy65?=
 =?us-ascii?Q?OtCU5fOS0wmWQEuZM8Q14YtK26zRtDavEZLwelvCpx4AQeR6PKm6gIdaENuR?=
 =?us-ascii?Q?6cE6Fpl6GT68voNjg0xkPLDjtmnI3Svij2+qnu/3chol9I0yx/IRRscC3aB4?=
 =?us-ascii?Q?gXVfgNrVAQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e88a01-a0ab-4557-9703-08deb653e9d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:41:05.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0krAW2yHszieYOUXFBOD/kqV0DiQCVQCkGutpROhsVHPLZsbIYnphdEVhNyT4DjdtjfSFxsSAprIigRSnxWKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531

From: Carlos Song <carlos.song@nxp.com>

This series fixes two issues in the fsl-lpspi DMA transfer error paths.

Patch 1 replaces the deprecated dmaengine_terminate_all() with
dmaengine_terminate_sync() across all error paths in
fsl_lpspi_dma_transfer().

Patch 2 fixes a missing RX DMA channel termination when TX descriptor
preparation fails. Since the RX channel is already submitted and issued
before the TX descriptor is prepared, returning -EINVAL without
terminating the RX channel leaves it running against buffers that the
SPI core will unmap, potentially causing memory corruption.

Carlos Song (2):
  spi: fsl-lpspi: replace dmaengine_terminate_all with
    dmaengine_terminate_sync
  spi: fsl-lpspi: fix missing RX DMA termination on TX prepare failure

 drivers/spi/spi-fsl-lpspi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.43.0

