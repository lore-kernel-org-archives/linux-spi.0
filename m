Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44349A3C9;
	Wed, 16 Sep 2026 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585890; cv=fail; b=K0qguF4IR0U9pUMePHJjiWUNxOSJBvkMnQrN+N5KxoFa122Zj5Ptpt4pvKgWdqYqJa42BhOP5ncgxrCzJqt3jCFbzmJdz5QoAImRM9Sr53VwIhOKeaIvxc3kMH/LwvFda2XcW6ROZjZ6Yu/1sgSaSykOd3LNkzTsIUfvJzD1Mvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585890; c=relaxed/simple;
	bh=URMlqFBfzSKDbJGy9+usOIKSdYb8SdVJoG6/ZNbFd0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VY0cBfvGYeQSBt+iitNHY3BOydN12QYCu9ZFat+emjrE3n+8iKmN41gvIotFk+KWfijj7kzrgrDwSqN9BRAzKprgzBd2kuECYJe8xH2Sy/ZA89RrByTNccgG/sV9Frn47JgU2w94x4dPrkNVOEHQn0UCauXuoGOD3Qkjpu/pnAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DzLh+S/T; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DzLh+S/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL9t6sQZdS6N0FkgLyeUE+babStioY4nNhnuvD2qPfDNc4mj/h90zNAh3r6JdmzRJg7K7LiE3nh8l+GLpTjZPH7WAlxqQmDycQbra4qS+QQ0KBORTWVcZuYIViUKXihoDJFCcgX3fYkD7ndI1440AdnjvplQ9hkrc0LWHYSeGO7gG0i3LB/xFGi3EQ3Ju/zFzNNKAGYq820zte1D1x3uvf5Mi4UzvJzc0mzoNrbakHBOpyDLBzUvdGuw4a5VyBfKY24QghCkPOOi8y3M406jZ1SguJzH+n2PUQZpcuEHrw/P4XPahZozg3JP557vtpYuvPl4izCTld0f1qetVhG3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZzNVORegfoTQNiZ6tV62nnGNjItRm/isMEENl6kfOI=;
 b=uQk1cNFfTXWdcDZZsc6S+lkayMk8d6fC9n4uOellcqCBelgvJxHIWG5YdGUz6kZwqSR1Of5lQQWbPVQNLFX+jQsk/UIqKKLYTjPd/gr7+43daAdhEzeQc67QyrHxjWeI+cia5n3Kc98VdmGE3HoV3ntOyOL3lu6D8VDWRU301CR/vBwcs+9ry/Cv7VOnP58eElNEbowp/UmV7gPv0FKzlp+umzI9BVBAbGSDionmxNlXwQHpU4EnGfEowLasRt48mgrmlyqLkXGdjNtP6ePg9q/17tOarIa40QJ9WfD5IIe3cDrUdDj4GWs+KkIy6aEmRMBXV5knAkgkZWkFFUO8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZzNVORegfoTQNiZ6tV62nnGNjItRm/isMEENl6kfOI=;
 b=DzLh+S/T+Or7A9BaLGTyeXdsjEVbDPBTXStiTs70xeTnLJFG48wqRbUA8Wd+23Abs++KDVxD+3ICL/okDAHuMPf9Ot6P+ZlF8YpDbFMTO/XBX7Zhc+Z6lQ97SLmhHPIh8hpQ78piQsP73NPNt4AIk6Bth7PDvF9bAp7GB+9m9i0n1wloBm5JE0LS+r2UobtkaIwInIKQrmLJ63QA5xLIccx6zR3DxKWTC9I9tG4bppLGfZS58ARlObJYjj4noycA8LF5kTCPL/BgcqXLZ4dG6pw05oo/+WwD3ZVfZ+qFgnVBCQv31GV1p5BRW3ZQ7q64vJqhHfxsHxsFersh0dfacQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10046.eurprd04.prod.outlook.com (2603:10a6:150:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 19:11:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:11:03 +0000
Date: Wed, 16 Sep 2026 14:10:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] spi: use dmaengine_get_dma_device() for DMA mapping
Message-ID: <aqrpvh7gu9OZAKD6@SMW015318>
References: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
X-ClientProxiedBy: PH8P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e863774-209c-4984-6108-08df1426408f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0G8Q7+qaz48R7YZQZHHADwSaGNFQKT/lqZGJtC5uy1NjUptVjTXyahj01Em2RjR+L9cTMQDoN8fnhqobPfXJX27w0VfZm5s7G7JBGrS7LWhCNLvnoo9yiwv6bqD9jXVN9tXO18fhs36I1Vw+CEIFgqWZE6djz7svW9nha71KXm3rmr71XfYayPpo49Exc5V3nSzOfLdHhaFHK8EkorjejN1Zk5+gWjHqgoucFr4qrMcKjl4Wsk6AvyN0z5QUVDJuHNL9QCqIfYqHCqGSF2qkGp4lbLLF9vCPhfaKHSxeUYT4T5ovm0PHjtYX3mUcnmlipdDy1lZoM2aVvmdYhX64qGmabAI0AQw06WDnB4jtfsMVPvAkrRwCOs52omdtRMLv126qIcMQcI+sgIEx3NpR9HbBGcOizuHesKbvNXE4by7mPQxwRQafqZxnym0x7/hDDM4H/G2GqggXwlej3o5P3mh5bNIDRCbCcCp/tBWrUsQKCtCHQmZbupOvmRAxPGhcjDBwELzpv62m+VLJBO0eyWoIJ6jtiWTfGcMgMqQphOOQrm36lOGveYrtj+XKGydyV1Vhk1C7i3F0E13Te0nQAfr3FJIFKVnAy+Dxu77PKpU0BXqg/A8YCC4Echqxv2Ur/d6FqxqRLnpeLzhwIBXmlO7FAXp0oiGEWe1fH4jrG5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7wiQnK5Rao3meqLOkl8mxYOVzAtN77G/XN+yuM1izWKe3/WtHgFpGWWye51F?=
 =?us-ascii?Q?6lBIjpv8PpUAKgd+OinsO+PRMr82au4BfUKmzH7Eu1saKz7wQrCooxnlWuF3?=
 =?us-ascii?Q?PNI0ZkOOZieC52inH4dXhxDi3EfB0NqfrtnjwUS4D2zgxpIwpgaBHa2K6cQD?=
 =?us-ascii?Q?Z9YDDL36t51kNAzdrWMimWy9kYu/c7cGspK0dNi1WtENbIJthbqxqG/9D8P1?=
 =?us-ascii?Q?m+Qz1w+I6iOYB6S2PMHq+fkaEtBobb3fQjchdGYoANSh0fEF5T3sC5Qrmaps?=
 =?us-ascii?Q?Z/ZytkzTGHlcfQkGZ3TSMfv2StuFA43vqz7FyoQOkwN+DDnQ+WCEz/x9n+I7?=
 =?us-ascii?Q?u5SkYg7nsXVLIfVKT/e3hEB4LrCdGSYzrVUamCEB6hLAChIEBLzqUtdFbQf+?=
 =?us-ascii?Q?wB4poISO9qxKMZwSPhluxAgU8m2uLXCKzCMzeJlT51vA0moJrFO/FyhCBpVn?=
 =?us-ascii?Q?XyDa0HI4pQq5Ooy+U8E6mTGALdRbDbfiUeAfA9nJz8HEBr/O+9WeSoz9He6P?=
 =?us-ascii?Q?/rBLd0WMikmOH7cYJqSAA0DW996FYWy8wbh7ai8jk3o5EQkc1UvMPmiBhz5F?=
 =?us-ascii?Q?BMWDQtyRsrlc6d6TMEim451MQg3A2t9pFvq6F2JPSZBz50l0ct9N+iGngUL6?=
 =?us-ascii?Q?0EapDaKJps7hjzKd2my83q5Jt9CKlSUxdtKKp7/BnauHLDmPY6hf4qWTvhB8?=
 =?us-ascii?Q?h6EQNzai22TEfqe4kUViqQr+EcdPiNXfNFl3HqCtY9+5kPhxOnJeDhQ0Tbv4?=
 =?us-ascii?Q?yADmhVmGIWvU6JfTmUpN4KIFBOPUF7mjODO8r+1klV8mQc2GVNvLaHbSZakX?=
 =?us-ascii?Q?cth0rVbjLdwtKKkeM4bbvT7+l2qAlA+dwb69C1bMnAvujbyypxcY0cw6/+sD?=
 =?us-ascii?Q?rUq8nW98C32aeu4HS3zYUm4w1KbGDZJ9ZGx1RUMIEg04Ow6RUqosxhzLZAKq?=
 =?us-ascii?Q?nr9z9Biaf1Fafkkn5ciEDIi/16+MWNmMe4GsAs/5aJi1fUZsCcWLavT+Xs34?=
 =?us-ascii?Q?/VfUXtFbjav0YpdVenXwtSwthqWOdno/4BcvoPFqb8yeQNlxnDKC73ngbHc3?=
 =?us-ascii?Q?8HeCnmmTW0R5QfM6wxfXqngDN+EH7DQ1B9A9Oyp4o51dUzr4K8IuF3qRMhSt?=
 =?us-ascii?Q?4HHcz2u9iXnx3YjtdjoyMQj9TO00Nuzd32qBMVM2h3KaPklZbDbnEW0jFxR0?=
 =?us-ascii?Q?Z35DwuWOXHrgIgO+i8wnaaqbWZYwWRVkBD3XHJ+7xBHX4HSiMLSIxvPiD5U8?=
 =?us-ascii?Q?WGH0Sf9zBMGg3lrgxXbnyiqOxNPJfnYleU7Y0ZiciuIFldh5s2MCYlM9UE6k?=
 =?us-ascii?Q?nwb/LYobhR1qmbrWoWTEZM47yVFWaJyr5sF2PeMjbJjU8L7LrxWzeU36sPHa?=
 =?us-ascii?Q?YAxejrWKtQbMpiyWzysjCwda3Ht1FMt0zjUuamfmvS3BfDvEDN3d9/65FbSC?=
 =?us-ascii?Q?3am4mhl/uDQOFoEuVJI3gxTRVQBhCFki7zJ5gR87QrTcQ3VkWAyiBNNXYui1?=
 =?us-ascii?Q?atVTonT/ul9gZyJPL46MDKaPvzShgY0iUV/LCANy8DYkt2IBO1RKQ4OY8Uez?=
 =?us-ascii?Q?S8Kxfi1nV4r+KZhHfrEMCxdCxkPmcvp+ijwank122DjlVeh6OLna6625ZaKn?=
 =?us-ascii?Q?nUfuXoGv1O8IO/KpQxWTw2suIr7AA4B4g/nlbYTZqHspZl7vYeGYjaw7Mhs1?=
 =?us-ascii?Q?9l+ovAnrsclzmlG8wdkiIxMo8LwGCAA+EYBGvwzw5GSe7JJKFkYOIf7yjDm1?=
 =?us-ascii?Q?PE1XxyWXohRYx8uNkn69qlGXp5BnkVojGny02vUceEaDF6CBtdyu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e863774-209c-4984-6108-08df1426408f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:11:03.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeY2dpaSgzz+TINypes4PVzmw7IWvKygy0fUhe1MWHlJaUg1UBFsjHgAL1pzqach6O7MtEuQScsu7rv+q4uW66PZxLnpgALLsPablOTP8l+kE3GXlmDfu4aDx6FnK3Nf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10046

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

Thank you for these, it is on my todo list.

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
