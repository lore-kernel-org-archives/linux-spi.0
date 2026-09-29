Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E2443C29;
	Tue, 29 Sep 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697305; cv=fail; b=IjZKPfz57L9jpiSqi3UFO14Bt+Jyzs+ZWxAn/+cb6qlTW7W8vlQ4vkQUPbmaq15CMP6PA0QHa6v4PksqwOp19/rYWaQq4akwd9eXpsdk9pjs9Plyr57g5qyS6rT5f0mWj3uaskQRfinG64WBHA9RannjQggoQqgqoMmMz1HtqE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697305; c=relaxed/simple;
	bh=0ATtlOSuOo7Q+uQdSndYk3pobc9pXYo70/v5R/+GyGI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sshB9XOBeG3ZtelGAMRjW2DLv7gkaq2+xrv+bUxCX5aaCse8CwfFcYrE6Ph09JEP2Rhr6rP7JqJDgQquJDp6onQ2Mn28AXvngXSVmqOl0+VkPgMOq9hg52BEis9UrQF1ObDMyVvOxcGiQJjEAJ8YhfUznUQ9jRE91rqt26XJ/Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XW6Y16i8; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XW6Y16i8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv5m5bMNexWQjQyuklgOc/9uVIZ3OUYBdcf+K7VRugZqsxbXpi/VuOoADHVLl+lb6PXV1EmOTyZs87Ag+Kv7Rh8c9XBesTqTMEdp9vCVbem9PajRPVMQwI7fZn3gyczwPYYZDGVVzYKakBrfB+Jnjjd8YA++QP7sfUUbuj6Y0toTmaiHzcNW7I595DWDN5lb8S3o4V/3tU4faC29bvwi/89m9iF5Inzj54+HFl090ME88P9wGIqRA8gCwu/sbpWH1iGDMW98P07x2ZpBjoOfKKg8t28OV8Q6J9izCpeMSlGZcUnx7XDmSe1THyh0zcHypA8WmUjNuERMFzpw1/34xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTT3ILIWzn282XYvYUEyJyf5K4O/KsJux2kCCJg5Z3U=;
 b=GowksWYzFrDYNKQr3ntqjqnst6MfmgxL7UVLiV6t3SzmcJWSdd4I8fhxjaXxUTtvP7F44cLd67wuC/QIuSWyQ3aheMyosaEzgFyUo311sBhVzzNSqSSaJND4QbYCGcb8U41AkcT7hFydfgzSp4J/PajymwmpAFqTuT8sb5HHwBVrzYIUYRtM0Uxviu0ZxNjSqn+mJix9hVxwsh7d0ryBXfsh0zqpZCE/V65fEadJy83SZs0wdIRFKv+6aNYtEWcZ9EJco1Ed8bRfzLMEXJez73rZZB4CzB+JoB+L9GzYbDHeflHYA6dWYBgyKM16Fyj4WdSpWNbAAykngPsOnr1XBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTT3ILIWzn282XYvYUEyJyf5K4O/KsJux2kCCJg5Z3U=;
 b=XW6Y16i8miOjQCnrkZfFC+xWmBiW/iJSXRsaqiHFAnL9CkB5WoCb3eILkf4RPwVrSZlHbwI1kQLfz7X+MLYuW492V+Fke3dmWQZpyFF1rhqfxt02QUR9Bu96d6lCd+T+9oarC44pHGU86K299w75ZaeraLsjmnkKJ/TGDBZipZ3CQhyZZyBsUvSyrXkIB4e4eFQccIsw8xF4j0ZrcZDysihmfysMZYYVIUuBC4iE7vCgqs+cB8W+uCR+Blv05Elva3qcFv+VQ5+PhqUv9EjClEgO2N+yuuerWxao9kviiFJ1IYrF83SYwyaT76azzqJ1MpDg+4LtCQ/376/1neo8yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:55:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 15:55:00 +0000
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
Subject: [PATCH 1/2] spi: use dmaengine public API instead of raw ops
Date: Tue, 29 Sep 2026 11:54:42 -0400
Message-ID: <20260929155445.3311133-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:510:174::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf718cb-f4f2-4364-bb58-08df1e42048d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	f69uZ+BAPKGRZ+HL48qM8X8nappJpjuvjAA2JrSoILdYUNM5/8gic7nsLUyvm1U3of5btIpcPK6OVtbFgLMSI2pTIVl8/wqvv86YHD87Vq1I1K0twAyqdfGdX4+qaVtNMjmaMtCdj8Ws6PD2efaQGHu/6ppUiIgGR3KNmrXyxrWfhVZgTHRktDed/q2ZEzj8xQQSgrITvau/5XsbQRHhc8Y8I0AWud5WPNV0Jpj0o3G9eeSJzjL5+/0Vbru5idHaIpC0T6y7kqYki4dFIXXY2x8LR6N7opIPfM5TF9EkxiJG1AXNXMsfyhBIg9z4j15I7CjdGvjn1EaFgH3zzr/NMsTSOzxKsYb9pReu9Kq4qywmeC0K5sBaifObgUDJXDIGRw30yaF9YwZBb/BnljZXPVSFS1QtwvxYfhMOXaG7i+7LOZ46raJsggGeFewkIGqxaxbUeaLS7pNI5mS4QLeIu/faLlVbTI6uydSrCx3qaMS1iRW7cdajWuttuDUcTkDYOK/HPhjREJklp7NBAasYme2KIqS7vgCIb2eEM0PFbF0KCDNm3kbWyky9u5kANnOFLtdOd/w01HOheoSep/kXoeKdfUi3FLXNNnvVQ4eGbc2x+QLQdqv3D25iriX7oQRtqhJ/R0hLTzEDEQ0fffxMo0bcajHP/TbXk+FLAA2zZsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvgc6h9zBdlEBMWYb+4iJCxwqmC04V8YxpiSTP9vQUK9RuunLRSj/9jGzf0q?=
 =?us-ascii?Q?UvRjASz7WLBQwaCV5f+7O3h5juX1sS6PxwcsKa3FLFSLDqwYsTtGYgOPLq7D?=
 =?us-ascii?Q?2BPOTW5c7cGThssc1bsjPePk4c+szucOcfCgXpcQhCXRMFbNvjWVkNcruzEd?=
 =?us-ascii?Q?jkvWbG9979OcWMXfwm93EEiZaj+SedCEJIKpST9hwTFFQBpTmRElQM/oPOwA?=
 =?us-ascii?Q?Ln6SAvSZMxRUyargZfrP8AugTnRmsxvBjdsP0FJv8CNKNT5Vw5rtK5MNZN+C?=
 =?us-ascii?Q?/847IIahtyykenm0hCS+goR8ICfLutl4hJc09DDZuNsaBYdEyN3SVDs/L5eG?=
 =?us-ascii?Q?dqIA6TFWCK4YsXDwFS6Qq+i+WNstlieFp+1Cm5Q5dI+lQQLt8zkxdPsc0de5?=
 =?us-ascii?Q?nX54CO/3C067vnETiyoA/2wI+4THe6oAIcPBrB+Btc/0NryNTha7jUxsBR2f?=
 =?us-ascii?Q?ccqwdfxhAZ4bAs0WWYB6cXHrmYRSCsfEytptLki6hFPqDvITpR4fEUN7nmlj?=
 =?us-ascii?Q?d1lsmqxNwpqwCAmrUPsQtnIWHjca1/zXP3Osn6eOBA4JwT4z+J5k3uYgljt9?=
 =?us-ascii?Q?ohWutNUvmJ4WcPbddtI5719/wvH35MHKYKU5rbkxXawzbamBxwl5iSo1Jp1B?=
 =?us-ascii?Q?0PcXNnvvZDsKNUWRa+QOmmblEeSaPEpvSmi6/zSsYjkn9/wjvBW0Hu0fu/c2?=
 =?us-ascii?Q?sAHEnyY2iaBGyWIfOR6u1hozPZ0lKE++6mmQYa9W64mytx02Z6W7kUuafvAc?=
 =?us-ascii?Q?ecPJkIOuwiOtKjmohdX4LjwlQ3yFFt9PknGEYfMIko6AcJRgXpFaOsDzFyTH?=
 =?us-ascii?Q?4JbtrgOrhivrpD0aHOkWaw4VeQC9kNwMzAARUbnobzalT+6A0og7BorS6zUs?=
 =?us-ascii?Q?JaWhR78MLi7TmEI4YuXZcdjk2Nlwb9sEIh4LM4AGq5jguot9K2+OlRspAO6k?=
 =?us-ascii?Q?e+57rD5sxpakoIcuR3PzHWDQY/lq0pCuZXPZePMOsQU6EH5TPl+cKx29l4xl?=
 =?us-ascii?Q?+hrgUwL4Q4GrLHvvCQwOlJnwjpK3Ze7eNPBejxAf5pVd+//H+oVDI/FVq00N?=
 =?us-ascii?Q?x43BGZa6m7PtNbAbA+c4a/2L/Jw+zSrWvptrVbMTFtnY/4r2ltzq/Lpge9cD?=
 =?us-ascii?Q?9DUotZTu8rsVKqoyMWQYVs2GETkyeAl8r4D2aB0lQdWf8wrdwuaIg55TEQ8z?=
 =?us-ascii?Q?x7DaRDeZ6JDHop8pWZkm9Hjzuzcd+25RHRwOwUdgzVuJ61DdfCP3iJs4zkCu?=
 =?us-ascii?Q?JEwHOALppa8eTd8oL5DQYvznxbIQPFTeo/oDu0GTro1NefqTD0gmpJEzTZO3?=
 =?us-ascii?Q?7a/K2vzMbBr5OxblwRwQPTa10TK8+0iCpgPgVVItm5tHLKGuOyI/cAgcDGed?=
 =?us-ascii?Q?FMfD+qN6NrfEnmpy12MhqlExRA83e4Zo+bC2bsl8N9qhFcdgzf7XWffwtVIc?=
 =?us-ascii?Q?ebxBd6pf9D5tMatWy9p46gW0cle0qRNtXo/YWJhnB47D93fEQhdmd85ipEPm?=
 =?us-ascii?Q?/CHpKYaJ3CmGokZNZ8vrG4HxV8XSZ3Sgq1jPxGI4dYD7EaPaSix3fW5oISNW?=
 =?us-ascii?Q?ACGlHQCBItXXgDqoDGW41J+wbdFkkMIB1KoZ6pw9PliUvY9Bjhk7F1NaBJAQ?=
 =?us-ascii?Q?6BzS/paD+yQ06jeCTpIJBe+/t9rn6lpmnRY2h24US3GlR2jfgpZaFW+E/vNW?=
 =?us-ascii?Q?8ykMfNpzIvbhZJEiuS3Nwls6nTxGumxw9OclWpjVMDvv6Zscw7eFHNFlZYRK?=
 =?us-ascii?Q?UrZpB21rASnR6h8EtdFRWWGFoNqAvqsnMV7X2+oZeh6pkoBae3og?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf718cb-f4f2-4364-bb58-08df1e42048d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:55:00.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE5MxgLKIntpldBtitcmSdIZPMSUfhDHkmC5cMfqksik0XAmpH6hBxfPDzTTh2EKslqqZOxGF3oXZ1VAMPhn4AjGyhk0NChwh02agOcozMMcL/iKJmCZC44VSBBzXs1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995

From: Frank Li <Frank.Li@nxp.com>

Replace direct calls to the internal DMA device ops
device->device_issue_pending() with the proper public DMA engine wrappers:
dma_async_issue_pending().

Drivers must not call device ops directly; the wrappers provide locking,
debug checks, and a stable interface that hides internal implementation
details of the DMA controller driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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

