Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD493D5C1D;
	Tue, 28 Jul 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233728; cv=fail; b=GDWBEFBLtxp2vDvKnTYasts+GqUkxgZg6J3eKgVJkhF0ht6RgdJ4GoMs3GgHveD5wfRpgQO8UJSy9QID7kYqaisQwNa3I31InXH7WHpho5kboFxkNunbsCLul7S9YZ0FY+CSx6PfWRf0pjs8F5GYVLyWU4KRSrsQqGvHu3yOAMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233728; c=relaxed/simple;
	bh=QNZg+WMzH/SN8bkKuLYcB1LGiqXOCpFlr5630hcdn7Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=US1b6YmebCxvZNdQEf4mJeks2UNB9RYm0FcDtGSlEiSigu4aFVSnJzf1DytgQnyzcvb+xVa6ZywYNb39itAoHuxk5dV5JWhG62pbe97Da+xBz1ohnJRFN+uodtND7mpc/zkG+Gz2VUzJ4/4JCHJbiBjVWqG+B0OrBQp+oHpTAlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JXAjp6+3; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JXAjp6+3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDkpl6CItZJJ4nojqsNsPBRSK4RW92uO2feD/dkDfrM6Dbnne/xLlnHV18SVrgfaj8OZOOYFVQSRcH2Ecg16+01G/5wz6+77HQQSxeGaYj2XcqpfV0w1gi430Ikd1q1sTk9bNWwmTdc7dl1SZ+zoT/ikYGxYShO4VmoUtadMGP226zp8hicv5GZtwnUfVEDJBB8GRdaXc+pP2nPwfcMRFS0WvsRNJOJOret1VKaAH8r4TukQ9qP7l6WzqwoNyo2kmaXafRwCBZ796T5iWlqAtXyXVONaZABogPWj086Jr/DEjMpCP91uqqshn4P7eTnUADp9Y6NtxgjhzuMdYnpXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEMZkm+UGzsXGra9vqABQ2e2xKK/x3oAtaCNI6aAb9M=;
 b=h4QHCDhmbUs4oJ3rKztRr0q7W4jom/1vqpI6BmQkHeS6EM7gq3LEWt0WX6CgwMxE8hH/yo8ibZbOhcQLcNHWHGw5VJvjT5VJ/bKNyr1sRX6JxWhL0neK86i0Y5jSV9e2kP77FmPkIGu3Ha4ENE78GBW8XGR7eIYa2Sfv29boU/8VlkSQqMiOHKQmcIOXxNPkpv3RoIMq2gB6PVQDZRDa0qeqRQqby8N5nHiNgAeDSZOqo5j7JhX5s8h65RXMct+0/8IvNA3g0SGZqqvKDvqgDYOKI9FcMKKsrXSkuPtKEx8mADEi1MyyDOm+DrP4T2jwppZ1isfrfuQ22LmL7GZRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEMZkm+UGzsXGra9vqABQ2e2xKK/x3oAtaCNI6aAb9M=;
 b=JXAjp6+3g0y0x2qFDUeWxWgLCQ+PPRh+44JKDbWgnAzgF005MRYiuPqYb9LUG7VW1vVJwcu1NEkOkoa7h8Z+8okfADTVmOL9DUncczTmkaklfpuUzdROIPFcG1jKY+lW2ZJxV1L/7e3k5AeE7UpdRd1SInMsc99FojMW2PeMDDX+lg4OrQlkMPUH+teUAw1ou5Zlt0t89ndjjKGSsj5KEn8pEtnIPJ/jHfICDVAyuKy+0QzoOORS697aO8/7ucOq4bcEeCtn90ViKY/bIBSFWR0UEqK5fH9mIgdOWdEDaVYp1n2pitctJTn+khbFsZp3+k5O5q+4b5mz8ol165IUTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PR3PR04MB7483.eurprd04.prod.outlook.com
 (2603:10a6:102:86::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:15:20 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:15:20 +0000
From: haibo.chen@oss.nxp.com
Date: Tue, 28 Jul 2026 18:18:10 +0800
Subject: [PATCH v2 3/3] spi: spi-nxp-fspi: propagate clock reconfig
 failures in nxp_fspi_select_mem()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fspi-clock-v2-3-dbe786a4a6eb@nxp.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
In-Reply-To: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785233928; l=3506;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=yulh4J9o+WcWuK4wqy+DSxMzc4Ge3QUMc643PqPM8CQ=;
 b=NOWj8VDXidryhPFms5iYH/QCuBctFpEfetAh7M83+BAQ8kj0StNS4McRBGrxboHgN51meofoW
 5N99sHswM4xAIpr5tNmJq1njHQt3M1NGQ1HYoYzBlmpINYzAFczgSHz
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PR3PR04MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: d619f57b-f252-428a-22cc-08deec912153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|6133799003|22082099003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IPFT8tLxKMNpUkKnwJIPapS1UavXSTyLc0CLIPnP7JJMWBA2Riz6PQfmhUunxqwXLnbD+5PrcWay5PiBiTTRZAIvShkZ2fc8kCWe6sX5eKiw33oMfRn0TnjNPvRH3IxMrTBxqNaA1EZuCvrdFM0Tl459GNnApq72Lu4YcQVMGKE1hODP6kvgBXLvofJDFPrCHS7EcetlovQ32AK8zlbllQHVGmw3rP7Y/NfaAYsO45Y8JvL6CiaXMLtvFRCmGLHu/e/8OUFRQZRd3WrbVEsM2DeJGqPN+sqSUmENSozK+GgWFNv0kgPutj25r1fa9Ac66LXN94OmDnMlBCokGsj5DLeu5dCStdjLgmVLBki8oqiaiChnFwxD4Pjgs2iZJhR2IQVOrm0Lc08Ln2Aw/mV4/klJeFvAAO7HL/xer3NEnLWpoCeFm5tKhfZHTD64brS1DD2lP8rsSsKx8AywUfc3NjKMvDgTaS2qy6v1tF0oFXIUBBMFj1DclcNjb6ZVyRBC8AQsWdl15V3JCUt32xpHmrIqqeP9i2yReP13orsj0+oyqu/NISjxOUfcZqNL+PlB0ZNmTOWRGW5/zNOxccOFfCHPMMV2caDQmZlrUbyOoOQEY7gHDWXqQQ3IwBdXrwdWjLmd5ssGqvBbW+hZAEtVHlSEkvopp1SzbXNwsWMf77I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18092099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tOSlBXbXZzQWxQT2VuMDhxV0MrUjZoOFdzWGVBYWYycnovZkhmM3BmS0Uv?=
 =?utf-8?B?UWFGbE1oVFV2OUdBb0lrY0pZQWtaWUwzTWlTZVBxOXlOSVZlSUlHZG50em5D?=
 =?utf-8?B?Y3d5TFdrQ0gzb2pwSnN1dVoyL1ZaenZrSlJGS0dteUk0WGlRa1BYSDBjN045?=
 =?utf-8?B?U3RhbFdrdzJrT3kyM25mZDI2cDhMUldqdDhwbGtIVC8wL2IyV3VQK2R1ZGcx?=
 =?utf-8?B?YzFiV3Nsb25nZ205WU94R1gyTk8zR0F2YkNYbnNWUlgxeG15S0R6ZHhqa0tm?=
 =?utf-8?B?OUVUZDNOa2xOSm5VKzFSOThWRDFPSHFTVHh1M0tRdXdRTVNjRGRpL0VVaG1a?=
 =?utf-8?B?M1dDaXlUNzhDek1SVHpwOVN3WDRuKzVhUmY0NEh0WU00K3oreDRKWDR1M3Vn?=
 =?utf-8?B?MjRQY2NBZDJINlB4VURqVTJaRENGMXFMbktsQlZhczdHSkI5cmcvYTdGMklr?=
 =?utf-8?B?T0tReWhzWXh4UXJ3QnU0Zm9qMDBsSFJXUXJSZ0EyNGVSQzI1YTYxdzNIcnpF?=
 =?utf-8?B?SXRRd3NpRktodHFSQklrRjV0M2tOalhNS1R2YStCM3JGdVFOTUlKWE12OUF0?=
 =?utf-8?B?L1dQUzM3YkVCOGsrVjhyYm5ueWFTMVBJcmFZd2dmaWpKN2lZTGFDemo4ZHFp?=
 =?utf-8?B?aFVoS3hPL1pEYnRPeDY4QXJKWTFSY2JrY2FKNjZydTYwL2Z3VGovejRjNHhm?=
 =?utf-8?B?eWhlOVJtUDZNYXE0enRKZGx4elludUpORDd2UExqSnBrRFJKb3ZwK1RiSGRI?=
 =?utf-8?B?UHBRb0hnNVVRVnZnK2I2ZW5EVnAyQUdtamdGU2ZtUGpEUkRJRVVWMkM3M2w4?=
 =?utf-8?B?eGJCVUMzdlYvYU8zQ2lNcDdDb3kzYWFoVzZhNTJ2NUdMR3lFNzR2akRPUzNy?=
 =?utf-8?B?UlJFT2RtZHl5bUR3bkhuaWwwM3lJSVZHM3dmb3lzdVA3blh2RmFHUWk5U0VK?=
 =?utf-8?B?aTI1U3o3TUo3NFdDb0JvUUxFUGZKMjZHVlZKRVpocFd1SVZLVFdwWjZCbHdB?=
 =?utf-8?B?VnZESm94RC8wa3BoZVZQbHdNK1o3ZVhWQXNhMGVHVk9zZzZZRnFZdXNEZTVm?=
 =?utf-8?B?Q0ZzR2hBU25Pd0tKRm9HOGJCSnJ0bmtSR0IzdnhPUllmZ0tweEcvS0FLVTRC?=
 =?utf-8?B?TEJML0VYV0RER2ZRYVVWalk1NngwMHFOanBLYWhLU0VRS0xzNERiNDVjTS9K?=
 =?utf-8?B?eUN6SXhxRlFuU3VhTTQ2SkpkWHR1RVlaL29qTjFMdzRQY0lnUUR1cndyQXBY?=
 =?utf-8?B?VXJGRFJVdDNaTnlTSThUazBoNVpTUTJWdkl2TkRtRlZCSGRuN3pZOWRkU1NU?=
 =?utf-8?B?cUZKVno4dThwSmg4QUlCRTczdENhcCtQVnp1Y3RkbEtYMDlEamoyMVp5dUwy?=
 =?utf-8?B?NnBqdG1nZkZVVGtnWDMyS1dUbG5kQVpJMDQvbjhNYkV5cExHU0hicFFYR2ha?=
 =?utf-8?B?VklJZ3drSDMxQjdrWmp1aE5iNGxXc1dtb1NhWTdxNVN3ZFB5alh4bjBUVDhC?=
 =?utf-8?B?Q3BlS2M2VVQ5KzVMeVU0Mks0Q1RHZ0IxR1NodGJHNzViWVd3YnhhSy9jRWJ1?=
 =?utf-8?B?amk5M2d5aG1wa1NWZVNNRlZXaXdzR3lKOU9lNkIrL2UreWhBYnlyLzlhZkpt?=
 =?utf-8?B?OE1TYkFFbTRUK1d4WEx5RElHeXhvZmd0UjBpbUJEZCtoVWlRcEZiMGFlRVBW?=
 =?utf-8?B?bnR6ZTFweEd2eGF3bSsyY1JiV1RnMTRvMHN6UTcwQzlNUHU1WDdhTFhRYXRw?=
 =?utf-8?B?QW90MnZaSlVOaE1mb1dLQURYQmpJaHFpbEowSjdBR0NNdmRjaytZRzFLNkVk?=
 =?utf-8?B?Nk0zbFpLMzFVUThaNEsyaHYvdHFPZk1Ua09oZEhRMzVMSk1lTitYSG1DMVUy?=
 =?utf-8?B?N0tkR1k5NWM5ZEVLREFuNUhjbitpTE5mNWNMTFYvYnAwSzBVanBKclgyanBB?=
 =?utf-8?B?Zk05bTljcEhIaEQ4UC9sSFRhQ00yUUM3TkZwc2Vqb0x0azJYRDBoTUp4ZVJZ?=
 =?utf-8?B?eExLS2tZQ0R6VjFDYUk2Nnh1U2hJMEx0elQzR3dJQ2JZNG9MTnZkUHdqS2Nx?=
 =?utf-8?B?T3pCUHVhaXl4aTV4cHhHb2xFMWJ4eHUrQUFQODZxWkZIZDQ0UXV2eEQzekFr?=
 =?utf-8?B?elAyRHAyZytPWjNtMXdtbTgzbmdSSzVaRS9hb2I4ODU0bUlMSTVFQm01Y2s1?=
 =?utf-8?B?cE5udkluWXVJZDN0MG5wVkJ6ZDJMVHI1NURwdlRpYWFVbUNGVkpQMjJjanRQ?=
 =?utf-8?B?TktNRm44QlF5T0RsOFMrUTBUbzFJbDhydW9qbVhnWFBVNG9LT0Uwa1BobW40?=
 =?utf-8?B?NFJpaGNYTVVjOVVic3U0QmFkZTZzZ1JNM21iOTdpWUFEcEtVclFEUTFGNG9F?=
 =?utf-8?Q?IfGAkOVknaTI+OWh3aXHiHLAyR8AGtzsOO6hv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d619f57b-f252-428a-22cc-08deec912153
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:15:20.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvxRLxF0fe0uvpdec3kozNulwUWe95UpM5iJMIg1yhvsyQQx9SC/INM/S+gw2kUy8G4j/vcZf0ceV9N6rqZ7TiF9K5QXS9OqUx14TXy7nVgfTOiAMUoCVanItC7vmya7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7483

From: Haibo Chen <haibo.chen@nxp.com>

nxp_fspi_select_mem() disables the FlexSPI clocks before calling
clk_set_rate() and re-enabling them. If clk_set_rate() or the clock
re-enable fails, the function returned early (as void) leaving both the
serial root clock and the register interface clock disabled.

As the function returned void, nxp_fspi_exec_op() had no way to know
about the failure and continued to access FlexSPI registers (LUT setup,
data transfer, AHB buffer invalidation). Accessing the controller
registers while its clock is gated off results in a synchronous external
abort.

Make nxp_fspi_select_mem() return an error code and have
nxp_fspi_exec_op() bail out on failure before any further register
access, including nxp_fspi_invalid().

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a426b8d92193a4e303f411cd17c16cb31c3f3873..67d991dd249d283e5a7b777c3ef4a70a9af3f065 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -859,8 +859,8 @@ static void nxp_fspi_dll_override(struct nxp_fspi *f)
  * Value for rest of the CS FLSHxxCR0 register would be zero.
  *
  */
-static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
-				const struct spi_mem_op *op)
+static int nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
+			       const struct spi_mem_op *op)
 {
 	/* flexspi only support one DTR mode: 8D-8D-8D */
 	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
@@ -881,7 +881,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	if ((f->selected == spi_get_chipselect(spi, 0)) &&
 	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr) &&
 	    (f->pre_op_rate == op->max_freq))
-		return;
+		return 0;
 
 	/* Reset FLSHxxCR0 registers */
 	fspi_writel(f, 0, f->iobase + FSPI_FLSHA1CR0);
@@ -922,12 +922,19 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	nxp_fspi_clk_disable_unprep(f);
 
 	ret = clk_set_rate(f->clk, rate);
-	if (ret)
-		return;
+	if (ret) {
+		/*
+		 * clk_set_rate() failed with the clocks already disabled.
+		 * Re-enable them so the enable count matches what the caller's
+		 * pm_runtime_put() (runtime_suspend) will drop.
+		 */
+		nxp_fspi_clk_prep_enable(f);
+		return ret;
+	}
 
 	ret = nxp_fspi_clk_prep_enable(f);
 	if (ret)
-		return;
+		return ret;
 
 	/*
 	 * If clock rate > 100MHz, then switch from DLL override mode to
@@ -945,6 +952,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	f->pre_op_rate = op->max_freq;
 
 	f->selected = spi_get_chipselect(spi, 0);
+
+	return 0;
 }
 
 static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
@@ -1132,7 +1141,16 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
 	WARN_ON(err);
 
-	nxp_fspi_select_mem(f, mem->spi, op);
+	err = nxp_fspi_select_mem(f, mem->spi, op);
+	if (err) {
+		/*
+		 * On failure the FlexSPI clock may be left disabled, so avoid
+		 * any further register access (which would trigger a synchronous
+		 * external abort) and bail out.
+		 */
+		pm_runtime_put_autosuspend(f->dev);
+		return err;
+	}
 
 	nxp_fspi_prepare_lut(f, op);
 	/*

-- 
2.34.1

