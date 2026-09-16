Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00C414402;
	Wed, 16 Sep 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586548; cv=fail; b=CtJP4M33f+al/D3e+GFwvbqWmN8RVLCWmElwA0TIncKFS6+7IFXFQnXYdD1we4ftV+CnqcU1DiauSvkofJRGnicrt6SlZin3LwyoXH+k966cIJNAvWdmg+ZrOYnvGTuskodD+7J0GeObzfRwU4wNp+j1IyuiXT0GtV0p73hytzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586548; c=relaxed/simple;
	bh=a25oqYfO0sJzNNk+USVcMlvTOSWSnj1VuU+3RP5BGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xrsr0+wnNlcbW/L3H9XRa4D9w/YGWRhe5P3Yv1jjhRuzcTleQsnY0iqfHhgJcqKVGm3g+JykBmFJo6ckA/vdxg0CD1/Yn7RFQzbPwTlhS/aLQrxLxl7UbUFuHyqhxbcdKx2jm7OS6PfrbZur5b8W6ocoJF7DQL4DbPtLoFnILhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UlYqAKzH; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UlYqAKzH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiBjcLSAv6bGNiRJ2A8ZB/B+Lvka7XTjkP6kiIPatLIOlBYk2Btkevxac30cJFAunl+MTX9SAajLHoNlY6u1tujh7bEdrGnJLFyLa4uJla40+aOpa4/OF4ZlHu6lTwzkbU+Ula5wQg2XmJ53mfDTSJw9oQCqpyRmiVVzO7o8/Afj+cQDnoEmILJl0nVPwNqyv7Pg4Vp2K6vpBJa5yc8+vh2QpaHRW5PbWek1wPYC14LC09e151JPkRlzYMaEoXCwt1kWELujpDZIGYqqF9cKAwqfnhtDFVDYMgpAn/Vby350bmCYqJ1fOYC2pMaJfjdzReq0buqikxvTX234GInWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG9L0/VrjCpz3nnFjXH1J8VKCcpBu9oi9KB87IbR/Mk=;
 b=Akr2Dh0iuQBry3KHitbM8+Fj2012xMJ5q1bmpQAEuJp39QbXkmg2h88h0I4YxTz20bG1HUi+1KleKd+zY1EmbtiI4ekH9zPgI8hnlwzRKb+lXS4BzMqA5G7O7AkP/ZRvNqkyYxnT7yqsO6qB1nGXsdnTVYSXwWb249a/TdnFj9cL7vD49L4k3/OBczY7iOawO1IuSxp97hF4psv/tc6LjXHeYoN5KG57pbS0AFz+9HepjHneFp3v03oPlfFk5HCJAgc80Gh7KXKm+i236c5K4VqhVH3pXyS8AzyGns804khVgxUxKm0b333fvNlQZnqkBEYnGKhj6yw8GOtlkaHCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG9L0/VrjCpz3nnFjXH1J8VKCcpBu9oi9KB87IbR/Mk=;
 b=UlYqAKzHhtFMWN5b0IL6XqOrRaNbOPg7Xni0X1w5biuoSLqithn6AmoKv/g9uJ/x6RO2/FvdpYVqeD3ibZJBp6VHey6pye7Jl/8w0MYHp8tWVL/b5UU9SqGHImmt3phgsBtMPDn3xD00mRRodigtn/7JLGPnLBCaJQiIn4JIht/RbZtfyRz+2lpCUy0VXJxr3h9YmGiXCh3k3pvLdVSyLQKPHKtlV6VcQV25m9iSVBdGAhHoGl2yYYR2JpfmVsHPii4dIyxR/FgIGdJ69kPeCyqKuXPJMOLWzdvn26p2TDn47OHAdI2uOJywpsB+YakIVefFDH5xI4574w9v9dG7cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 19:22:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:22:14 +0000
Date: Wed, 16 Sep 2026 14:22:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] spi: use dmaengine_get_dma_device() for DMA mapping
Message-ID: <aqrsXK2T4_9kL0Fd@SMW015318>
References: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
X-ClientProxiedBy: CY5PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:930:1c::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a02db2f-a24b-46e5-1f23-08df1427d015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IBTz8/KlYYSXgFNngd4onvR8rjksJQhVSDs+dT8VLegYC5a4kBSQNePYoHRa8SQhudGfo0r1Z34IpgY54gdiMhkhfGJMn41RgrEcSpHv7cv9o8gfgiM/CW+zgAkp3oCrwS1cWTiRSAySFfe7UZaJBlL43SlK9O83rT/ZhK+GmRmcDBrP4kcMqcpYrCKJziosS3nr9BCzG901PjM2eIjWPY8h9jpbRpyAbXZmi1Uciet7s+SGYxnfzSGsuSB6mTV0ltDdjPDUITYlusq73Kdg5Tm8xdomB1NMeBFKufYI+oILyP5B3tolp/jPonr3hPnBnD0Aw3s0HUR7cq5Q8qi1BP7M4g4MdLiAHLzeRhaXrAiYglGo7TakrLpmDSjgi617FHh6K5H68HblneWAn6eWZKcvChQQdSegdZXk7zwnVl/JUVMFEAL3YO6uHJQzhOkxibGQY3CsYjMAYyQOqnoAdXZszsO9Gmd11PL9xcfP8S4zqQJyL96Eno+38zIhHtVLdFHiYThiogsdRkYNd/f173I0GJ3BY0/VdUizwnccpPRilhiQFw3MRkxVM/EBoC35qwv2OT9QvF4+fZsOK8TKi1oPUNcPyosg6ygdct2LwH4/sDzOXsit0HqHAuI5Cj6HyRM8YmjqLZTU5OJ7I5kF/6k12Z5fF3gliAJkG5Bi+EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5a2KtG82SxjhGzt7r1wa6ZkmbJ4nlmCfjbHhtkUjan3fQDXI9zOorzJTBXZk?=
 =?us-ascii?Q?f1zWVushmJeZC3+LMugeTXxk+OsaN7G5N4CfWLYlw2Bf5uFLI6GWuZzd+836?=
 =?us-ascii?Q?YwnLLsv2hT85Rk/TGPaHr0a5jO38kXjfoUKBIMrFVGuhk0slrau+x/66gQBX?=
 =?us-ascii?Q?Hg5zCXiLNKyc8vFbIU2XzuPzrrdoLZF+5F62iG6evw6/P7Wd88Xvk2MGuZT0?=
 =?us-ascii?Q?n2CfhCY/V6TLfjUHIdnPzCl5HeAzyZFQDAEfjOork93B/YowPfi5ZIHSNBwd?=
 =?us-ascii?Q?ZmKw5jNxH4Q4Fq9rlwcdMjhZGOKiRMge38n4cSrOH5PUi0/IaT4Ktm/94Ytl?=
 =?us-ascii?Q?9IDtWg1jHEyT2ZTnJ8LgWyTTVZX0TxxuKtjyL10/1EMljayydGakg4dOghsA?=
 =?us-ascii?Q?5hPrMJyTQxl6IO9E8zIiFJGvjm+0S6B96VnARAmxsVzHsNKS9tDn/a9RixnS?=
 =?us-ascii?Q?4GsY6MZ9oDt2NG/HAeLf7KlrsxKy/u5OmSqLt1AMbY//G710BYX3X7xyn8Qz?=
 =?us-ascii?Q?afZbUlSHHL9uX00/AAx6PldPxGrF9a+AqE/b6cCP4Zpy84PjFQ3b/mR4NZ35?=
 =?us-ascii?Q?XkUjyXgUx+yegic9eBRXjtUyJVHtzkMaq5FFJKfuGe46CEFc4dQmLtG5unAm?=
 =?us-ascii?Q?nu2Ca4kOdFekZ70pxTEb4Gj02AiHnUGVqYB8Wan0Pv0Heh0qCr436v4AiGcR?=
 =?us-ascii?Q?IvZ53CyRK+OS4GSMB5qcCZaqB6XGDRZGfw7ZFqQ+iUQ3f5sYVq/EKE5cjkjL?=
 =?us-ascii?Q?yOeB92PxHKM6t/0yPgEAMkuzHI/BrcT0Y8paGkP0GLwRg3eUO6N8oOidoDmK?=
 =?us-ascii?Q?FaiiIh0OR5zo8crhzFHfzIB6WJmhKtSA7jdUMsyn+JcUcdTRvOuZIC+L2Bdx?=
 =?us-ascii?Q?V9G4YCWeHn5CNlDZWkJo2n0PgqODV7NVlupIg5GYlaLQgy9JCdSIWgjheK+U?=
 =?us-ascii?Q?zcCsWxF6YkVmPDmscLZ0NvKuovrzR5Cg/ba6vO8hCJXzvX9hWtkgm9z1fYIo?=
 =?us-ascii?Q?+tUNG5fpDq8gqClo3L3BTx+NgVoRq0qufEaA619w4a4j9pPLKpx3n/05UZBZ?=
 =?us-ascii?Q?tp7SdGu2FYceTZ7lvdFalpMfjVv7C9g0HvHmoVp+24ZZ3NdMg5ZFnTRT6XXW?=
 =?us-ascii?Q?32gLQbMmNsc13nOcWJrXxNszzN1/YqTGkH3SuskImYuiqNj+aQ0HgPtkzCx3?=
 =?us-ascii?Q?zFMtx6KZh09U3hD0na5ggKgU7uGfm8qDSqMQ5FIi8tXX7Mfm5nDzujIyNVEY?=
 =?us-ascii?Q?3RPWDkD+EJeFrIDCA9XMZt0aYp+GDsuNS29bhcxJmj/F9Et/LyiKAZ1j29Am?=
 =?us-ascii?Q?302uzecESStX1ywS1QcyiZardgFAAthU029uJC4Le78chP+ilazUe7cancRW?=
 =?us-ascii?Q?0vwWg9C9j706MqMM4Y8oaEQCmTkfOyfyEZ5nO96FJ4a1TAO2xxNfv2Aahe5w?=
 =?us-ascii?Q?3qKbyQ4xVGe2vcbeml/UXqwNjtH367YwWJPnDyR5pgJ0dHncukhfilQQp3Nd?=
 =?us-ascii?Q?e4G8HoEGP9DdE2gzeyGQ2R0TOV276xZBXPaTu1sYl+OX+Io0UaLmWRv8sh1w?=
 =?us-ascii?Q?2XD6wTrbN1/ih7vNadJmwcFboFjJVOLUYzdL1cRuqXsZlYES6t1kltZSnuqt?=
 =?us-ascii?Q?lsnOTsErXGONzctAsNESq/+VHz5CpWZSVKoG+yPywm1s04vHYQWdgGVO9MeP?=
 =?us-ascii?Q?cGQ7Cy/S8ywBuN34cCfUci5wwIBlWfhYf15TV/sf5qsNdjy+1bTHyk9Tef5k?=
 =?us-ascii?Q?nY1+g+OOD5DD5gJvHZq31GSfGsPnpmt2sBZuNX8xXSHXN702Ptxs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a02db2f-a24b-46e5-1f23-08df1427d015
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:22:14.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4eOITMOT3Xn9rpe+B7L3ZE5idBZ9gjCKzOVNfGE/OEFGEZ9CQx7Q+YhBSPVG4eW8KUkSG+CmyWR+QUpqPdxwrmkWAtarc/x1RH0EWOkR1o9zxtNIE5MLuwwDy42u4p5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291

On Wed, Sep 16, 2026 at 11:30:55PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace chan->device->dev with dmaengine_get_dma_device(chan) in the
> SPI core (spi.c) and SPI mem (spi-mem.c) DMA mapping helpers so that
> DMA mapping goes through the correct device when the DMA controller
> has per-channel IOMMU domains (chan_dma_dev=true).
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-mem.c | 8 ++++----
>  drivers/spi/spi.c     | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 94d122be1c930..b94680b60af95 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -46,9 +46,9 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>  		return -EINVAL;
>
>  	if (op->data.dir == SPI_MEM_DATA_OUT && ctlr->dma_tx)
> -		dmadev = ctlr->dma_tx->device->dev;
> +		dmadev = dmaengine_get_dma_device(ctlr->dma_tx);
>  	else if (op->data.dir == SPI_MEM_DATA_IN && ctlr->dma_rx)
> -		dmadev = ctlr->dma_rx->device->dev;
> +		dmadev = dmaengine_get_dma_device(ctlr->dma_rx);
>  	else
>  		dmadev = ctlr->dev.parent;
>
> @@ -92,9 +92,9 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  		return;
>
>  	if (op->data.dir == SPI_MEM_DATA_OUT && ctlr->dma_tx)
> -		dmadev = ctlr->dma_tx->device->dev;
> +		dmadev = dmaengine_get_dma_device(ctlr->dma_tx);
>  	else if (op->data.dir == SPI_MEM_DATA_IN && ctlr->dma_rx)
> -		dmadev = ctlr->dma_rx->device->dev;
> +		dmadev = dmaengine_get_dma_device(ctlr->dma_rx);
>  	else
>  		dmadev = ctlr->dev.parent;
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 172141650b648..4f9f34b798b66 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1456,14 +1456,14 @@ int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  		return 0;
>
>  	if (ctlr->dma_tx)
> -		tx_dev = ctlr->dma_tx->device->dev;
> +		tx_dev = dmaengine_get_dma_device(ctlr->dma_tx);
>  	else if (ctlr->dma_map_dev)
>  		tx_dev = ctlr->dma_map_dev;
>  	else
>  		tx_dev = ctlr->dev.parent;
>
>  	if (ctlr->dma_rx)
> -		rx_dev = ctlr->dma_rx->device->dev;
> +		rx_dev = dmaengine_get_dma_device(ctlr->dma_rx);
>  	else if (ctlr->dma_map_dev)
>  		rx_dev = ctlr->dma_map_dev;
>  	else
>
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-spi-dma-466d0a92bd28
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
>
