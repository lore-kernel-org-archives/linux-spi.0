Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99D369D6E;
	Tue, 19 May 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187508; cv=fail; b=Ln8SKO+h2eb5+iWzZZj7neWhCA5LKAhK9yptl23y8bAxq2GYZA4zdo/FA9Q6XHSmC6go0UuFmhU5Xtq6nqjtdagJUNXsOLEV5MwZO+QvQ27D9x1hxeJpEwbY/I+VGevIB3G+koCcfm7ZXD2QC46KHhbB+Z6A8WC3tZxhH7JBg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187508; c=relaxed/simple;
	bh=DRe7PrXvX/OvyvzPQaUF7B3hdZYFYs/Oy70uEzzzRe0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KxfVrqa+wKvV8V68D71h5oLmvYG46W0XcqSmQnySyAwZPiobjrBx1Acj5SRfZKB57kq7ZP22VLC5VXoS9lw7PNv3aY8yMmC4xeRWMZyVgMAZ+vOfBiUkCDCmIODr7F/y0ewJdWCvl2Fh7sSaKzrV+Pz1fE9tfi/kRD8FmXUC6eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PDYuMZk9; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PDYuMZk9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLMYByaoGG+4YyISMjWU9m5vdUeYVmic6Fj5PiC31cW8NJ9UHvMgHjVVcR+MQN/r1QByi8rwnf1LYeGeEeDYn7fPnnyx700oiCJqF0iUvR1Sez6g/Gb87PiUjzQrJnEAHVajWoD3szP8vo2DEGsIfhumo+ugyCd+u9EfdJq0nQX38FU/7vEv1pSA3GjzNbbs0NNijJYhEurpaCdLrH5LF/x4X5TotDMgTj9qUH52EpOpdo0A5wa18lzZxwdN4XamSqTvi+X0mCgx2cxzTH3n49au7hcljyXd8duk7pkmaZBplhF3yj6wdYHEPjyErwnaGzsHGpvt1PmIoRCLS7cVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NI4i3qAOmXz6TF+2j/KV7Gkq890skuu+xgreT/5Zbo=;
 b=H1SyZPhwoOWWu3Ewjg4kAb0Q2zuo1yD6wSTbqJcBoAKbZoGs6vaoia27JVVH3jqDCP7jeVp/Pzzyee0wul4U1LAc4JdN30RdsE1gqe8tLbD/7jv9Y0qtHkWnoAzO0hsg7SxmZPmHXVIEAj/ZRcSvy7JBRjSTAB7pQFzupc8SP7w2QfA2061/gFlgRxK1eKuEXJfe8EL0CjEyeowIjAJFAtgoXUkKiUdQT3tdTQqWL5luFe9zPfyUcxVQ2h2LAiTwuq1JzM03pZmpZCjPMW5lQ7lDyEaMymDwOKrIHsUlqoqwXRz1fCdH76EQ8kqt/SQVDXQ9MdOOmq2w0HpoImyK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NI4i3qAOmXz6TF+2j/KV7Gkq890skuu+xgreT/5Zbo=;
 b=PDYuMZk9GqKkNOibQXazD+h3tbqrLDeBdlQrTxeyu3vV40QGk6yO7vjqTtozRLqgstqvZxsPD3n0nmzuij5/kVgC7uqi7OWLToFR6P4/zuT5Frsfj0saCJl7H5p0VHLbu4rV5P24K6K9P3fTiVXvA2XF0U7agwdFIpIST21iwy07mMmzcnnCGSeIDssCjrhrZoSrDMOdwZ5MgPRpB+qTZ6BVTCNtkYsGMn0+sJ74NtHTBIA9QeaiwcnNop+ACDLyaHdr5E/QNpvC3eJKNRczOxX43go8nDCS0YepG+phpPzPOZSDl7eofpGYymtnCg1BpUKkDSWAVqWaygip0T4ayA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 10:44:58 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:44:58 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: broonie@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: replace dmaengine_terminate_all with dmaengine_terminate_sync
Date: Tue, 19 May 2026 18:46:59 +0800
Message-ID: <20260519104659.2794476-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0127.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::24) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|MRWPR04MB12330:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dc53ca-4dde-42fd-e536-08deb593abbe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	yMMP2zR8eCCEZyb6ptYlSbIHmPsl8+CAwCe4R6T45upAl2xNLHgZ3Zb0bi4YfPKCRMD+TzLm1VRdTe0zrsIFErhZs8i53Fxbe9z79D/RAbbT5gPU/adHX+ZQuq2lkB1tFfDQFFx2rBD9e3W+vijzfBdRdX6fzV6dxNCr41dxv/gi1+de7U49yCli0ugZ5FZ2eyrhQW/2VQob4rwuyWLw6AU1Z023zxewlNC+EoRG6+e245B3u1j7D35P2EYn/jRJ+lBU/1Bcpl0uwXUjk+cwxHf5I5uqlqWBYJKKMNew+DsCjNveb5CIGFcMpZSn4OdRVoqrSyvZF53H76C4mNunKEx75WAQHKdauWp0W6kOelIwZgYZtEBaLK802cyHSw1lISZUKixfmyZlfoTGa+xz/vyuNBOhIa5ECHXO/LGKUDDzRaIriRpw0WJeCeSGcmedUB0RGWSjLUYATE9A5fh/1LPIA53HJZ6OUaaF8EAo5fZnmIk2XOMJm8CrzoKZXnaKnKunK4OEKe0ATiAmv5zjwsgMaQdimMOQeJHtTSwr53PlPH3hMzrce6pfl9OD+7CwgLO9FlmES00EIVc18OH41s25mmh4iWCO4W2T2hITcN2jGIhaHap3Ol85NEbIJAKud7C/mrY5WhE3kOCDNXCpDY2zVy6UDU17l0McIECYTK0CPHtrJMj3KE0tzUOhZCU7n8/igqbnVB0u2pwPhLvWFG7hH/TllfGwGQJklH0xM7Ro/ZkmaudKTQKIR9jKLTQL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yh/QzfaA97d57RX9Iv4jKQsaah5jnJqt9m7Qx/Cn8lwYiUBqAJ5gkIfQ1kK?=
 =?us-ascii?Q?b0D6pBAUOYvH6zLtoe+1KwfewhrIYhmEgnWaq1FD+O+6Q21LkDnn7SX+/Xna?=
 =?us-ascii?Q?68MDsSLO/v9hsuKx+nZmlioFwuwJOb8oYXyc6BpXXnkpHjHNjUqmZjnBYWTc?=
 =?us-ascii?Q?HnxQt1YbUa12CrcQz7FE0M6RWbW3483OU5YtAy4gsBMgVJ52w1e7SW+RUQEQ?=
 =?us-ascii?Q?mdek/vBfGZlLlgFrasGxq/AnhNRQ+oehJcBI9mM3xifOQo88c98PNXLKAIe0?=
 =?us-ascii?Q?V54uLLXWmTrHM7jg8y6S58KL32ultGRHfq7Zd6275iGDZEkCKsUwOTiKCSjm?=
 =?us-ascii?Q?Hy7ZkvRsK7+naZec0JefdsMjGy6Iq29G9JVzxXhLogyb07piNGZ8MpiEIaoQ?=
 =?us-ascii?Q?dfvDM6F5Xuc3DGAp9HVGgqUkWBVnyj7I7rFVOVez0giGecLAPf7TLSH9rEH/?=
 =?us-ascii?Q?ywcQ73Rb9jVsryTGK9zxErvbKK3vggGCJNWef2Hx23gplg3a1vnVN32y/Yqr?=
 =?us-ascii?Q?ffYC8J6E40s3zuunpB9DFKdO0Muq0PNr+9ivNCcuACsu49MTeF/ZKlxy7IG6?=
 =?us-ascii?Q?v1U2Z+6RSuyq71mMnR9kvlov/jVSoW5UKtleqZDRztcruuYHjswAiFtWo3/v?=
 =?us-ascii?Q?CpqParrqnQBacOCtoGHv2Kmv/At/UnCq+TkV83qt5JGAwg0o5Tn7vNpMsXDL?=
 =?us-ascii?Q?+7E/F3pVbv3mKtKMoqwrHzWwpRxXaICFnPPhCJmHVfMZigxo7U2q7nFI0Mw4?=
 =?us-ascii?Q?AusxRg1tLidREwbylnQxNQKG9sCfffj6zD2dcaZBG705QE2qQySnWDwkjv5M?=
 =?us-ascii?Q?FCLc9gsw9K8qpWWgCX9VqdGHwjfJOo2Bb8q3EEQnd23PrAEqr5ys3rdke2Wy?=
 =?us-ascii?Q?8JFxNNIzkigSuL9p0Jl9t7x081t8KAENGLWtvAilCB6/m8Ipxwl27jlbiPPd?=
 =?us-ascii?Q?onicfPD9Sp9XDKC5eyuyT9IpTglHYeZtTC8OcIHHxYarfBNYl8xQtrDC7qMq?=
 =?us-ascii?Q?3j6R3SIG/IcssPGLHW/g1dapkY4ScbT4jmBY05STqBcIZebSTZjqriusbM9c?=
 =?us-ascii?Q?1GjS857B3dNwb5FbVJYNJnMvRoYYQ8fYuVQfIFaVmLLUdsi8BrWjNUVXFMKO?=
 =?us-ascii?Q?Lf0JqY+8+jPB/+sUAOzdyebwQmk9grDIM5QLWjdqMJqqRGEQ3m5/qwv8twdw?=
 =?us-ascii?Q?K7gzUEyyMB4EY391p9I8hQeqoLJQdDkhzj0mGM1ICcYto/Zg9u2g3nc/jdVT?=
 =?us-ascii?Q?sOlJ9yRzzzsix1dPWSsxAtZSQVE2SOKE57quVRgTYKUK53Fe/P3+DM/OSCj7?=
 =?us-ascii?Q?XMq4iNa0Q6hhyfPg81QKxdbNFD/i9gLyT5XHQo0zNAOaR1maRaM+flXydJtu?=
 =?us-ascii?Q?O0Tr+ftC8bbbhAokhGnjeVvTXhoo25TezgZBi+zO44nBnMryQzb96iLK+yct?=
 =?us-ascii?Q?Y4kfyAHY/+USLvUbpZFarKRI85aAj2BwROYDhr6x01ok/ZIqFCqs4Um+8n+0?=
 =?us-ascii?Q?eSxywfQxO7vrzV7jO4G5oGxlEGLaQfUK2cHS6G4UzHV8jOG5bqNUBraUH+ev?=
 =?us-ascii?Q?Z6aTL5+SEtk1EvHlR/HLs++PAhOhARQgZ8CI7lECjbNoLx6WkJi0yp7m90Le?=
 =?us-ascii?Q?9PHmY6C8VTITEKu4DAJJl1oP7Z83xqNfP4BFliI36cJHci+P2LIp9NLoBcQc?=
 =?us-ascii?Q?xAnwrSbohKcqc8+OZpOZ19nVLusBgmwjB7EllsQEOUJwXiIlP2nGbuP6VbVe?=
 =?us-ascii?Q?RIohv8dOiw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc53ca-4dde-42fd-e536-08deb593abbe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:44:58.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWVoJ5fGOZ9CBSxRelqHl7XDXtVDgzRasRqM9aglYHqwSjQoMDj6PKqr9BYH3Q09fFaGeket0IfAqdKTEJHD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12330

From: Carlos Song <carlos.song@nxp.com>

The terminate API dmaengine_terminate_all() has been deprecated, improve
driver with dmaengine_terminate_sync().

Fixes: ba9b28652c75 ("spi: imx: enable DMA mode for target operation")
Fixes: a450c8b77f92 ("spi: imx: handle DMA submission errors with dma_submit_error()")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 480d1e8b281f..ae9912905c67 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1774,8 +1774,8 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 							transfer_timeout);
 		if (!time_left) {
 			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			return -ETIMEDOUT;
 		}
 
@@ -1784,7 +1784,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 		if (!time_left) {
 			dev_err(&controller->dev, "I/O Error in DMA RX\n");
 			spi_imx->devtype_data->reset(spi_imx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -1793,15 +1793,15 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
 		    READ_ONCE(spi_imx->target_aborted)) {
 			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			return -EINTR;
 		}
 
 		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
 		    READ_ONCE(spi_imx->target_aborted)) {
 			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			return -EINTR;
 		}
 
@@ -1818,9 +1818,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	return 0;
 
 dmaengine_terminate_tx:
-	dmaengine_terminate_all(controller->dma_tx);
+	dmaengine_terminate_sync(controller->dma_tx);
 dmaengine_terminate_rx:
-	dmaengine_terminate_all(controller->dma_rx);
+	dmaengine_terminate_sync(controller->dma_rx);
 
 	return -EINVAL;
 }
-- 
2.43.0

