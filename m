Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D681724;
	Thu,  5 Mar 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669617; cv=fail; b=U7AWbArpyR26ZdIkod9/5e5G7Q02G1U5jjqgtphiKFC1ryWhGu4rTaV9RuekW/n8Y3XhCEIpTcUuXqXuMXYa/TSD5QShdKjML4g7asm+7lnjMIZpA9xow63YeMT6Fr4mpXHBm9G7VQnqR0RreWGaTWrZ1tQgMTZqLUI4DFE92Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669617; c=relaxed/simple;
	bh=O0jOgOYfgV5+pr7sTWb7SiYcM/GpH7e6C2up7MbRW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ow4KVt9qITGPCu0GvOvQSgGOestJ7uTku2XdUDL45fzO37HW/qokkuXvSL9Zbzj/0ZmPt+/qmZqqkQqyCfN87I/2t/FQ3P2tBIorf/p9x4o6+CxWx0hKDmNv/+dalh6KgCq41pz4/npWEqLY7Y/Va21pIth8fm6t858gZ7e05e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qjk79vVg; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qjk79vVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrG1r2flQcnbfzt8mPyfq1WEYHp1rdufFuT3y2GBiWHf8EhjZwHLH9+bXDpJOtagxCAJ1kIS2frQQasZcNToqOnEcWGvn0mkFrpPxzzY7ME7Ix2GBOzoxfboTT2Ghc/LIxBE9WgJcx8Qo6CnA63NmptnmoFBmYUlN2kJEfwB93SgP5rzT1fBDU94N+gHtbULvJjw7ret8Ktd2hczOBJNmd01Rwq0xHuTOya88iNrLUlHlZUNVpc9SNxKfDcXDZOZdigDOA8Zuvv8KwU1VdwmzbDYsNJB/uCadPFMwalW8fU5B4xUSXtE8p00vc7aYDIQu7T49nZfqlH3rcsOacad6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3NNTUUJC+YU3zrT38m2zPMvb7AZzMF/QcK7WTvnEIQ=;
 b=QVOODwrKHpILtkOGzUc296Q/7fujiIiboCZSeIR4jxyPy8kFdSCIfOy1WynFfn0BV2bgA1IK0W04WgjOvWJ5cOuhQBNRxuZ8GKWJo8L8yeSZfUyuZIzHh2RatlVSh8M0qUAq2cu1kDTBWM9A8xyBgorCBjdUAfn2OZhYUkZp0VyvSHYPIN8TVWlloYj7Nx0o0Zk7V8Qb1HbwzBLvSZtN42ygyVXchgJZ2pqnqCfsDcIygC8xRmhW6VKIMB7U8IVa2szmu0FEaK4OUk52r4QJQj45JbLNrhhKBLve2nlv8ZgfTDwnbjvJcgXQjOhDAFhyAXnmhNfM1lCRk5xWGXA0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3NNTUUJC+YU3zrT38m2zPMvb7AZzMF/QcK7WTvnEIQ=;
 b=Qjk79vVgaP03ANq3PJw/vwXPsz30YPQ88fYHr2KMM4QjAL/GM77S/vktzLgPlMJyvvZwhNmWtee+4bBLRUOuC3ZDZhMU36WrSxN0Wulu/qh96slODJeRuZw+D3kRY1SIL5zFeby+21BqxPRxTStjwYM9Tmf6EEo3sdLG8sjFDLUsG8pMuJ6vBCdtXx1BL9bIG/QTBFA+iuIlKQh4W/8dKRWlYczwtEMzqCDq/jBK243gzinGzjkOae6MCPzbuKHsfRtpWM6FhqarD8PHsjfmP0ImqmZEfTFirwN8ajgYPndrAx6T2SRJ3G4LzhDBL9cvJd86PrgVvuD9sOoS5VmidQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB10637.eurprd04.prod.outlook.com (2603:10a6:800:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 00:13:32 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::7010:9f6:4361:43bf%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 00:13:32 +0000
Date: Wed, 4 Mar 2026 18:13:24 -0600
From: Han Xu <han.xu@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: nxp-xspi: Use reinit_completion() for
 repeated operations
Message-ID: <20260305001324.fcsae6gafij6gjit@cozumel>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
 <20260304-spi-nxp-v2-1-cd7d7726a27e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-spi-nxp-v2-1-cd7d7726a27e@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB10637:EE_
X-MS-Office365-Filtering-Correlation-Id: eab92fb1-67f4-45d0-47ee-08de7a4c0930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	xhxQ/2QxfyKDQmjZ+leIdl/xk4WNi/uae4MYwXuaHGQ2qan1+FibEZy2BwFOjalrA/EkwZ33c7c4rruUx2fucgDo2RsSE3O7p/3CvdEHP0Mr5o5PO/QIzD8ZRBPafq/EErtkuijtyoP9//ErAKgcYzU+qyy4VTwtf4X0bO9MTrzJrI1PHs0tLUo9aoW49YbJNnC1RdtZmWXVwqBBCNu2We6inL4hlWouEoBGAOOqAA8KjhYoLS9HAEfFd54nX5qi3zcjCsvNtW3KCdO5bcZAgPIUMVXcoClBXZj261/Z0G2nDU3G98rhmCbtWOmSfkZ1rWDLLU6YLphYm4+MZerQbtDp/8F2EN6qabZ5T4Z58qoeRJ8WGCsTZSL7qlV7mdtDu7kjOwBYqE5AlxlLDqxM81mrqW6wzl1o6XmAT1C7ugT0RyH9tiCZ6HM1/xXvCm6LK0ixN/X46c2h5y/9Dh1/4kfBLHCbGsPDsVdfHHc1tNPTaZNzp7pVXwrKqBmjhpZfZ3MYeGo/YNK7ZYG0qDc0VjjDKa93QNcFyLe+Vz12OLRurdI0u7iahUTY7nnY2uM48RbPqR5H/Uuw3DYOmZ7p63wJgY+rzzzBAAK+3sUHvq07L8TSNzOAHE1okwqGvlzefmyB3c2qxlCce5a+2x3QeKaylu5/g/rHFl94E+cirIvLMIacuj7ZgcPcujeMRZ2dhsZguE7X5zRH8H+wbD0rdS5hRgNE6bIH/uemwTPblAGqpzqc9IUU2O+9sQpunawUuxpx4pVU+SH5abzE2oydOIkufgCe13tg1XXsmLZz0no=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9Co7fluNJaNqpHajJVrueIDpBo8NoUwakIkvHNrJhek9Usc6bc7NmMfbwTo?=
 =?us-ascii?Q?d8R/PPzJcZMJJx194GMlGYUiEMIsDrnyiFUiF7c02N4pAQAIgZGFLQjuog7N?=
 =?us-ascii?Q?uB4Giwm3xR9aWCuXuow+EO83TVTBZpTxhYhswuvONn1MPk9uKjZmr7Hinzg1?=
 =?us-ascii?Q?Q20RIgkTF55xtTpNbc4ROCAAI8MEJDGjUgEvjM78ni06SBARyyZKxl3/pkky?=
 =?us-ascii?Q?kDuZO5q9vjcWw3Mg/b7/jpa0Sjt5LvGQJY1sDEimgObtHlnP0OyNJ2g4Wq7t?=
 =?us-ascii?Q?Yvzue/jEn6kpSC40xzUsuNP7VoOoalXByyaOteqhkQwBCp4XcZLnsuaMCfQG?=
 =?us-ascii?Q?KMEePR8WP2LzdfDy8NWpzSdMQK1cSOhmSsTAvK8FK75GGUV5hKk8r3/ExkjC?=
 =?us-ascii?Q?XI1oHyWSA5HuqMgGI/vAxmFxBY62MKwRsw6ftK6PxhYjqh5H6sJwjq0JTRy4?=
 =?us-ascii?Q?QrRRuK0YS9IKZ2ekNjJU1N3HzRjVFyRRDWBQ0EtbGznArL1O3CzXOWsQNUfx?=
 =?us-ascii?Q?PB6jX7XdEnwWTtf1fb1YgsQt7zdQjUh5ipVlg4gwpJTCB7GcFOgsIAekhjUI?=
 =?us-ascii?Q?CEQP+rCSdQpMC2myR24DDcaPt2K+PcLdcJ2HI5q2KRmhoo9x6elMEb18Xa8J?=
 =?us-ascii?Q?9OzhIJUYa/RL3aJa7vT9BOI7pzpyi3pVAZvVq8jqhVMzvwb+oOmewCSMIyoZ?=
 =?us-ascii?Q?TWP1YalKx0fiVBblb+xQTg7Y75KdHK7yTLv6zmy0rkQht2xCP3xF9e5JrE+J?=
 =?us-ascii?Q?v1fG3NcJn93aT82rR57b5kARtWhADPkPeAwPk4MSHIJh+xuhGkG4aCWU5yKX?=
 =?us-ascii?Q?Glst0/+HEg/d2avdF9QjGbXoC3HBLtQuGfM8CyWj8jzneCI32U70KL/x9Jl1?=
 =?us-ascii?Q?p7QctmXw2BlITbhyS7ug60MlMNUf8n5xY0+SNFii9oHQdk9HZWrpG+qNQIRc?=
 =?us-ascii?Q?RYL0KrVRfp8JVCwDie7JfPYNAzs1cJfJmymlo95apKTG0omzm4p/oV8ocNNA?=
 =?us-ascii?Q?EQUSfVvMvT0Cg3FpLRIhIMeLms7EMnr4xsfFL+QKOvPiuw+6a1rsZS+Cdorm?=
 =?us-ascii?Q?8BT5f3O76yoFiqMvZyw6EaLuVdnxJww9pGaReuARykDu6QW9f5Ticp3fONK3?=
 =?us-ascii?Q?fNZBpy+dkK8HNXmXbHgxLeqFbxA7v1tsGd8b5pWfAZ7dcPahSxsQ4LwFeKNv?=
 =?us-ascii?Q?jjkHt7KMkJWupiOq34o1Dnf/KNmpOFXmfj/penZHLXmY9FTS0GaUEpopaQP3?=
 =?us-ascii?Q?ukBv3/Lvr8D7ywLW0H4Vz1GFQQIYIU78zCeJdp2Y1recCMjnXlNFry3vN87Y?=
 =?us-ascii?Q?MBfWdPS1HRt8W8yTl0y/orJNPPGx67oOadCH8ucTkFw17r/Oe185WXXbI+3v?=
 =?us-ascii?Q?M6va93rgOVx6iWsG455CK/x9d9UqWS1wbq77bovU20n2kIdwkDgXl+yd5VJJ?=
 =?us-ascii?Q?H+rVwLytbU7QS0bnEIUZ/8gHme2Q8wWz0GzdTLxcA/mnGBjTsERwjqUMwGGO?=
 =?us-ascii?Q?NeFtBFvdN/Uwh1TPfxMAhR74wsY/4NgM4u42BUaXRtNLAA+XhJwmrtFebG4F?=
 =?us-ascii?Q?ubwD73DoG/bG8DuAJppebSNTSWfmooEgW5I9p7VmMJz+NGAQkuBSamTehprK?=
 =?us-ascii?Q?aigqxMed8Q7wAO74ZX2L2Iv/VxxiUCv9BOCjG/UPVkXXoCx7wTDjI9X7N53d?=
 =?us-ascii?Q?uQt1PmNCUo3qtE/UcLNhbB1zq2ClexX2lkQuL/oWESQbYpfu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab92fb1-67f4-45d0-47ee-08de7a4c0930
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 00:13:32.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihROL+z6duesHy/xHuw+LgQNAhmFOWi5XCKbQmqub9Ujmmb8k4KQsKhVoGAXxRaG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10637

On 26/03/04 08:47PM, Felix Gu wrote:
> 
> The driver currently calls init_completion() during every spi_mem_op.
> Tchnically it may work, but it's not the recommended pattern.

Typo, Technically.

> 
> According to the kernel documentation: Calling init_completion() on
> the same completion object twice is most likely a bug as it
> re-initializes the queue to an empty queue and enqueued tasks
> could get "lost" - use reinit_completion() in that case, but be
> aware of other races.
> 
> So moves the initial initialization to probe function and uses
> reinit_completion() for subsequent operations.
> 
> Fixes: 29c8c00d9f9d ("spi: add driver for NXP XSPI controller")
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/spi/spi-nxp-xspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 06fcdf22990b..385302a6e62f 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -958,7 +958,7 @@ static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
>                 writel(reg, base + XSPI_RBCT);
>         }
> 
> -       init_completion(&xspi->c);
> +       reinit_completion(&xspi->c);
> 
>         /* Config the data address */
>         writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
> @@ -1273,6 +1273,7 @@ static int nxp_xspi_probe(struct platform_device *pdev)
> 
>         nxp_xspi_default_setup(xspi);
> 
> +       init_completion(&xspi->c);
>         ret = devm_request_irq(dev, irq,
>                         nxp_xspi_irq_handler, 0, pdev->name, xspi);
>         if (ret)
> 
> --
> 2.43.0
> 
