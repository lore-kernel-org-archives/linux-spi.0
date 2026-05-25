Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDA397E9D;
	Mon, 25 May 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690121; cv=fail; b=acz8Z9KqK1drakUD8xfKsjqIqtRCV7lbYuAJbqLG06gbm/JFhcPJDlyFiZikcxPufgkwX5zZUf6UPqA9vDEbRxWarXhWk5Xg4BbOD4mdE/gNrtRkZPxvqtqIslM5CBFVPkyLdE0nRD5XhYB3GQLNtZ5vc20UItsVuUhPDXgTUjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690121; c=relaxed/simple;
	bh=2RM4NEdtSZdMPKoiUWf6++2MJVg+ybFwB+WqZz2h/aU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qXfzEctSXzrGkRqogG+GdW8nMC3mRDD1ohV8ISzy+mG57C3k+TqUjqunkyCmAtE1D79Gb+s/jxK4NXrGWY+7YEFGiMRHrYjH4YKvPbaZFf3BlOJKkZ8DFZENJR6PJnI+RCsMZh68JvSXKOfSQWykcHV4OzcMd+UGtVp25bOM1YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mH3I+YW0; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mH3I+YW0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQkuF/nZBjBXPhRVyNnDWd8Zb04gAADTlfY4dWAzeyw4EKFO7vZkx9c5zt+6kGvPJK6dSLs4GZk5jZLQ351hOG/2SUVU2CHbidUUACWS2Hdyif9KI7RchJAg64vSZs7LXgNaaj0LmvFWq08ZSv6Txd9AbYTWUy0tANln6oFIKbWBmZKJEAeW9MGv2z6CykmqqJdzPAAaINnOiBA4ZK4iQd9CtNnpk+I9H492Z9w6WpNvazhUXTABSOWZxnXjxKADw5rdsrdBx+OGeVdnI6/H1H2kERTWceWCCjUvU4P8YjltKx1q2CYs8Q7LKaCLFS68CbN80w7FG/qoUjN4Q0Hp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY+DzanBD2CRQzIQlcNwj1Sr/S/Vdq86oXMKprGIk10=;
 b=E0C5Al2WXz1/exnrzhmaiIqgoWny3/uDQ6Y3gqqRnhtecWkzwOZFoDjHrF2XEw3I5j09z7ErYLwkbQZV4uptUIC0eo50sRdG2OmhmQTct4bkVRuNn5mYGxzvZuP1aWsTEa93eBtCkF9Y0KETbDM7bK/B/O6SG7Kqj4vWZvYPRIjdJqNr/9lRYhsrTuaRsajzdnYSpBsAsnryXn4z5TjPZQgAsMryWNvzE2vxYHB67wVvwiOtpdNBcxU4vjPJ3+MOA8oklFpS5f7Smq6K9vGlBz1iPT1JsOK2FbTAs+JsGgvpwvxxcS/RJRH7IoJs/5+/Bs6GN74iC1V/4JjxJ9HdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY+DzanBD2CRQzIQlcNwj1Sr/S/Vdq86oXMKprGIk10=;
 b=mH3I+YW0Ca/MrcASSqRzEi3BjtB90gGlSzWwcJLPDHvcRjl/C/i/eXYxCRrE6R0s9mivXZ8Fz2O1QTLNhS+EeIbmBdFk/qIfidVO69FYf2UQfPs6o3j1PN8r0s8VNWLGJp3u7YsmO0YfaKLx1P5rGCGq1jpxgAS7ekFI9KraexzxPqjWacdxKtD8weM64sB6VXoO/uo4UjSGj91+ZRvrsKwplLscFumQTTMXwMxokG9+qbo25a3SNttIByu8HKpeObIVlLxnpDyGBJgem0dLwPjd6akIWoTYAwku7KZRjC19h7NcrxzgHXFySSCnK+QAtj251x3w4AE+P90aaniG9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM0PR04MB11930.eurprd04.prod.outlook.com (2603:10a6:20b:700::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:21:54 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:21:54 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	xiaoning.wang@nxp.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v3 0/2] spi: fsl-lpspi: fix DMA termination issues
Date: Mon, 25 May 2026 14:23:55 +0800
Message-ID: <20260525062357.3191349-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P309CA0019.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::29) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AM0PR04MB11930:EE_
X-MS-Office365-Filtering-Correlation-Id: f89c81c2-9c74-4f6d-6b0e-08deba25ea05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	0a8jqsO+vGaqo7/7oxZClWCD9Jjn4Z2C1+zm56WaccnGXQwYkXAguboH7VrGeeLD9j+4DU6PaP5dGVcSi6C9zuGnXcJCVpCNYBbDuKd8pYzzU7aizT8pxWDvg+n0V/EV3QjZLEUtPFMO0aQHQgxYM7RTP2a2Yxom1fzSu+ddMrHJ0astLad5ZYWjgemkpF+YYxqbwELFL7G1uKLlwz/LCcC20gWu17AVHCMfQNubGy0BInDnGaJ/Ku9Z7cpbwsxrXojG/YAy2IYh6MU4jYHgGPguds/PrYY+gRfTXy8rSjCY8s2aIfICox3ABVWArsyMZ4BEPMVq/HgdAR/gJyHj6woD6DpAbBdDDrclp1YvW78tPzfxesPY9aipk/bAc827uQh7RT88S+usVZUSoSzJA0rMXFFS4f0i0iHGc9GIbH9BI+Q7Ddl8azJtw2qKYMKwJqSazZzInOtH+JJ39hqNUNAJMPb9GghVCSkL7Hlink5t0lYHJj4ZhtzyQ13DY7DT1V3UKP4WSTSekCwEXeLoFllfzP8Vx1UF6Ero7mCae2AMt2Q5XQ55qDsAtaNL8yjsds7qjzv8/1Q9t14pUzoFdbpbv3Gc5ftrTwJaWQN1X50INXljxQO/tuzJcD9pET91bGIO/Ol7DuQSMFagTZYlRNp6cAwcCzSLjbM2D1/xaTeqB4rgtZVWyyd54Pyw9s0htitsd7qCgA2ZCwexsw/d5PKniCfhc6ko4hVnC6rjq990X/a+T/48XjmxaxFU5l0g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(18002099003)(56012099003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UjTRvOgPhZsCXCXR3sdqQyyAYAfo0KWd3cMvFK1FbJ73W4rujfPeactBe4Qd?=
 =?us-ascii?Q?rIR3JUBGlqzfsjUEPkzb33VwF0bMcq7i2qdkSSTJtbO7JsjixYpl14EfxoYU?=
 =?us-ascii?Q?7MzlWh+JQKV0QwhtR56oMq+Wt8oOQybn2pTHRdbzQrdGngm+HLEQ4lUIrR9G?=
 =?us-ascii?Q?YKDr1DxAM20OevEJ51IYPcRwsJe+91m4kdVPHwtJx57wKbi/aI9Y/4GxXnZt?=
 =?us-ascii?Q?RDoR3ljXwakusnASvPiGSn1fkx0LNYYmMP+cjNGZI71Bm+WxOanbIRZLv7zD?=
 =?us-ascii?Q?0ec/W6s3rXnprgptVjwzYfGl/mIhIIyEQWAxDN6DePiaP37UbsZwRLZytOb0?=
 =?us-ascii?Q?9V+X77ZqpAFbjGLx5bnoSjiSwmPDkFGqwr3LIViWCS1i/rwvY95buJ/dkBGo?=
 =?us-ascii?Q?OeaivtkWQjZPfEk+SKPagch/nISIjpfG/T7+32PlLMOFDmknXBauDnoGP3pY?=
 =?us-ascii?Q?73NPZEO5oNttV6mNHekpzIOhw7Ob5ZrDkIsXOBB0Qp+2b5kHotQjTlKzxFPS?=
 =?us-ascii?Q?58yZ6bnafPUhfshdO/omlSu8Glh2HJydDDZ7QxSFnAnh5hHacROrmMPSnNPp?=
 =?us-ascii?Q?V8zfmFTFZL0Ur3Nlc28uw6nCHKAsRAJDJipLmSOI9znFcAQGFNHQzImMxbN9?=
 =?us-ascii?Q?3tjFlwrQanM5Psvt96PrywvVlj+ZZjn1LWQnrpCBhndFePdBJJ/q6Ps8TKNQ?=
 =?us-ascii?Q?t3yHTia+pxLlDIT9s3QdyA9wybygemNPdnBpytpjbqklc6qOUbQ8ZsWwCrTq?=
 =?us-ascii?Q?Gl3H2yTDzQcdhelnksIyiek0Ja/VKGodUD2hpgIZpwrsPk8Nv/5oI2Vq8i9U?=
 =?us-ascii?Q?vUWnjDi2brXEpZhn48l1jou1RqC+n5aqkNZMjg5ZwqTmTbvR3Y7Fgmkg4bJ1?=
 =?us-ascii?Q?shnGfEcKer3xOuh12ZuBlVH6W50JUTCQyJu36W5I+8kWmAxJJS3zNJcBkvdf?=
 =?us-ascii?Q?UvKNSsXqfNsJCUAJeWQSfMi2+lPrIJYXv+nt089N4rR5EYLiqTGFtlI5wRTb?=
 =?us-ascii?Q?9qJWzAgszmswGGYAA1HP44+ENei7oGbz+R2DzdNd97Zbl3iiBjeWW7R3/HiT?=
 =?us-ascii?Q?xeSkYrQCvYm5vPkHsdAgSP3VPI9GtqNCC4PDa/H1+VmHHXXeMnpj1lStFfhK?=
 =?us-ascii?Q?AzVo0rMb8vdsEd1OIZI72hpAyi/IeT+mCfkbiLkyfccN9hK21PGDD13RyiTM?=
 =?us-ascii?Q?459MvT9oDVKO/dM0A2ENli5YE5tVwDjW8LdrPxAKVb2M+4PYSbFdAJD8UzMx?=
 =?us-ascii?Q?oIwEgMkCzGVDRNzHCb4ZZZFG5j07tVCITIcj4gsxPjM+0wXy1q+e3TcD1BPZ?=
 =?us-ascii?Q?A0g1vhRGvOlHR/TM8IVbNo7awc1SnAs8+kGlpupKE5tbmuGIA/42uG+ViqNb?=
 =?us-ascii?Q?C16s12SYEuaN6n/FqyTpabDCEGWl+Uw7HIf33ET6wOXB4pW3zW381f5xgvXn?=
 =?us-ascii?Q?NsHXfOzwpY1ct+1LGCY/NlYmZQuEtCue4yevdzAbi+FMBdfRriY4MwqQCJxa?=
 =?us-ascii?Q?Z8/DRdvO1h/+phMeSTCp+PjqmGUl01ncSEitsIIpe14sVPptdztMQF4RjSU4?=
 =?us-ascii?Q?BlNY6yDt86PfLKmR/3hA+bGAyDm9hYLKuESuwtgHrkc+Ozfu6SOhqEDLTTjL?=
 =?us-ascii?Q?MZVqR3odcMXwmv6c5fPhXoL7NiHlJ7OMU9QgcmUTwoGd8vawmMQbONPGP3Ql?=
 =?us-ascii?Q?rjAvkB6YNSMVbh6EGlhCVNSYU2H55PPesc70QdEXg1Eud5KV7ThUSeE7DQCF?=
 =?us-ascii?Q?VUW+gIRznA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89c81c2-9c74-4f6d-6b0e-08deba25ea05
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:21:53.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TKDrFd+RzBUA3yL8BL74l6mvnawiQaBEL8f0aP+1W7sscj8SCA3FdQnC0PMLUUp9JU1dsPxudFXfJnBwIQtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11930

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
  spi: fsl-lpspi: replace dmaengine_terminate_all() with
    dmaengine_terminate_sync()
  spi: fsl-lpspi: terminate the RX channel on TX prepare failure path

 drivers/spi/spi-fsl-lpspi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0

