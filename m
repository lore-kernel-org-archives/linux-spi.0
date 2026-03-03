Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2583CD8A6;
	Tue,  3 Mar 2026 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571777; cv=fail; b=FGjmvKWMkPqTLv2kQQ+GF5gKK6TRsWmjVdGYGlp0RQ9X5KuO/UljqCfrdcpJdQTk+OA4L0lRl04y1OlwEp6NJk8ga1wr7Re1ymbB7MCMws39jutMXIjaSm9D3J5DF31r6ORRd8roov5Ea6EYGHFZn4NS2VC7KZDCWkEmejfbEvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571777; c=relaxed/simple;
	bh=q9M+y8ql07TdbnEOgjbD1Fc1DZIaV1MyFIY1YfnOqH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4q5thGcqhBe1uYMyYnOcdG/WvHvnmRSSqhv+DODqU9TcDIRUwXmEkcuRfCJOKKn3eHH+6tF3sYU1EtEPVpIVCt5DE4jjrJzekqdevsJ7qa5sgcLBR0vv/0ziOOeUoN1zWFp+1wmkKIKpifyV+9RHa2KKE+WTIIUF47y/07kmg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WPQHrZ2O; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WPQHrZ2O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORQMozZB9MQb6r3jVzi6xm2OaziGO/hB7UjNNScOEknNvoIznyAnbYaTpntlQivxaOtTaLsxmi7X4HcFVNqFkXoeZaSgCVa6kueKFyU/p+RQvCOqTD/IynSlgDnTDf51azVEf/0UuKgPxIt9qn0Qpw/JFI/+bq0N8DWS0eU/yUuEPk+vxylLJSlhkmFNXMBtMvAH6QwtrbIgHa7hYEXka3mB4FkcSr4rkgcEwsDUhjmhIxHEmeYlPjRvbmk72BV4GJtr9xQTV0VIxYTBdyrPy2F6nfUrNLHNCsoDsnIGcl/6mGRvfXs5VX/bqq6pGsFSSMHE9jZckMczPkhX3aRf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcUBM89CfcafqPNUduLz+fPs2+MPmwpMJfq9Gtl8p2U=;
 b=bk3rirolRaiSM7gasCMSNS+/6FwE8M276WQ8HQ/oES7RDGUTaD6kwD1Zth5CsOiCFOPZvDt4x+0byCGSNDdBT54MWYA8kWTkm5HE1o+/DfVRrpP0ARr0LcDn3gQhLVpruJc7jVgMF2T1/ynYjD3J1903iXBZz0/ZmzeDMYiWFapWVyZI4nkVauL76N1OaGjWk+H6CEaxfzu9y9ZNUplMw949kHgLD4JYK6iyp0sOQnwiI65jbC8QEGK3o9fatUUYk3gZyjMNQDZXGoagPlgw6hz0C+8Jd2mghxcktjOX1SPOIn1arGIzEUs4bJ7CR4zAS6FnNx2OhTziialY+5Ub4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcUBM89CfcafqPNUduLz+fPs2+MPmwpMJfq9Gtl8p2U=;
 b=WPQHrZ2ODCIGvg29ljOWYwLAGABcpDYcAAEEDYxebUi8xzyReU5UzokoeN8J46H7hmboHcSmsdwZw26lECHYQCLIDzwnW97uT9apkc7VWN3/XbbvDGtjv2TiWuDQ45QMY8AFp+amv41NeJEwalv8IbZNiRblDomBvAi82Cf1jZQwhBh78sRWPcphBlyfaroW3EeWMYXRyZCmk6KPZqchtqLqZnKDk2j829oKlHm3A174hmENowZSFkwbTHASzUeBZvCB3gDUVoAqYJM+lUO+OMaN65SjkH8it8yoeNmW+lmULySxp68o0V/Y/TprRYZhFgD9K5sx8a1MMXIY27cx7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 21:02:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Han Xu <han.xu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH RFC 7/7] spi: spi-fsl-qspi: Add support for RX data sampling point adjustment
Date: Tue,  3 Mar 2026 16:01:12 -0500
Message-ID: <20260303210131.2966214-17-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-7-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-7-9326bbc492d6@kontron.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5729fdb1-0741-4b68-46c2-08de79683c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	hhzGwX3dDUlIlm8nshnUxRjs915q4zhe9YWlkKe1TUHmcUt7+lJaDFMlgEk3QYSFkGFEH/7Sj6OhgL8xwDeIWyHfZBXElsXw2B+y3r36zFyKInA8XnP1JgdIitJAWvHR2p5TCn1QejOKA+Nc9R0u0f3pVSEFl6lrG5VrS9bZ9f4fP5xb2OjgQ8EXgvuHUdZggvs3GJLdsXzUhhs2bUw0JR6Zf1QazrUCW3QnEbh41jaOMFwb19aAbQenRYgDaahn8itTz1ph5VqKoj/TyYq7avvmnmBj8/M90N3m78eDhTZmqAOq5jXyrjzCeNEZW1Py+NWC55sgSMD3w3bW4HxEA3d+UT3WcTbR6CZW6kNveaoRKXovrScsVJht5/E7kkCNdoCJx7zOGR757y+3vG9cxUkVlTxoT+QbCdsw7AZKc+dsQqQqafitYLQEWVI6fKYHM//o5mf62C0UrNU87F823Nrg5jCV4Cwn7AQVVLxYTnzKXu9oO110oErTEujrN3OimQnFoaJAiY61Ff2t08anEcCqKo/WaY0PBylFBq+OEIL7UeZqXp3/rEHF9MYiQLIfZTvoVozodXspp6/cJauLRHs3lt1FoeYZFU3njRKcnHYs9zDlTm48uH7B2buktgmT8Olz9ZAvGRkG1fsOyBPtBbRQs/AYc2jXsxmfTxdfcg5BP8joN+cytHMHIX9MpesmTh4VHD7ibhHVzMvqfgHnR8xhn7t/rfi2uIxtJTWfeJKo5Bb6v8jdk5zLGB3zti+PqnWBCYbnCMNK8yGKqzhF1r00GJJxfWZeRDjDS62CTqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6b3xoES5p659rcOcTs29Hj3f017moEUw8ezkUst66B+cnf0iHHmTL56ZWYc?=
 =?us-ascii?Q?P/FCdaNxy49XvTeCz1/yqoC9hK4VapPFRA8crWvezx22oA0PVVMA2Mjx+8Rv?=
 =?us-ascii?Q?w/kScY/aWYRRpZ3MYMzAn0bMY5gMZ7Q5beA9nKY/HuY13z3U0PRp66wKmRY/?=
 =?us-ascii?Q?mDMT3A1uYP00BKAUtQJnTgG9csHTmLt82zLqtUHX7WLcMqaoTHAnhrCcYRk1?=
 =?us-ascii?Q?9TK3FkJoY6GA5oSUb3dkm3yMo0vpRqWD55WowQ6IYVAlmy5ooGXgkHV15WRk?=
 =?us-ascii?Q?ntDGGnKwzs8VnKGeYI/xGaBZ+YQOUG27X3TR5rbyRmng1D830aE4IPwq7ja5?=
 =?us-ascii?Q?RHLxCPFIu15kdPrka+V3pvXSi7W0vR5awTTNLcga6TK9ICxb58nv7cnbITPN?=
 =?us-ascii?Q?GdpJPVZd4I67vQ3SF139/auYylCi9dJE1IbhU5y2hUGwJSLKj2br6qOXjHKA?=
 =?us-ascii?Q?rBXCQfMSpFnMHcf6xuqm2L4mXYXpaSQshxlDIMeZbaTf5lA3GZlOF0bRoxVU?=
 =?us-ascii?Q?QSg/XfSYWiYbMaNbPjUVVTzrccTE8EFElNDDpPdunG95pvCKgWj5eHG3yALt?=
 =?us-ascii?Q?mUPomtLK08moobH64377U78NS+OVSNx8eS4y1zRhojvQ2eLjIM/cZ5Wrug+4?=
 =?us-ascii?Q?bbdhn1+BDyhm9CbbcZUHGT6xn26fkLo+7EBDO7NqrHGxQwFhLE+k/BeXU0tZ?=
 =?us-ascii?Q?mu+PDDp3H9isDQrlY26npzhoKhSdlv8k9WWPgv0zcu/2QNbzLZwBsZ23woRE?=
 =?us-ascii?Q?lzbjfIjwDH4/PJxkVQK/WI6VLIbB3+rzso7JaWVSmazRZYU9OULoyRMmDkXV?=
 =?us-ascii?Q?fQF50jTPvQVkIgLC2zT0rSVc9gG+cBVgZZmbyP7I63MUcyF2GLI8/DFA79Qb?=
 =?us-ascii?Q?YBNjwD0oeLzjsrRgsgzDJhUQ0Tj1/fiCrPZtPPpmP/zOH2gNxNQcx0ur4XH3?=
 =?us-ascii?Q?x1fKGy1NbQLqM2xXa/7JoD0S36j90hnV3ZuApR7JRKNShgONIGbvTyTMRjlr?=
 =?us-ascii?Q?MwK1FR/YsT8+UjCyhvs7cgXMyBcfRDfJo+7NM56b5SHWbRQsTqzPoVQVCJhQ?=
 =?us-ascii?Q?ZxNoSOloNgNUBRHRoORRP6w9zgejeC5SYuB+fT0i+NPbGs54Cf3ndxfoUzXF?=
 =?us-ascii?Q?zyRG5kDuXWONkmV4flaQjPqVtJ4rfCtUgDB1pSMEUqqjo3L/JTWbzoqve1hG?=
 =?us-ascii?Q?O4MxdwwmQs7DIAx196sQ3eW/FbjzMgg+bpMJ08JupQ5aqq1TYn3G0SkZxIsj?=
 =?us-ascii?Q?0sOVUA5VqeEHlILRHDdpWdA6gt2pn/QVlD1dQhpfR/IR4T4LS1nrsQO7NtxH?=
 =?us-ascii?Q?rHqgmESUghJQzMjPK9WPII909U51SFQ81eivXgSJv22KS7rlY323kF1PsJGN?=
 =?us-ascii?Q?e0dhrhGdr+mHixMOZnYT7UL/ftdvgRSFqDJtwmqdYMfn8vKkXVHpSs20Z5UV?=
 =?us-ascii?Q?XzI4Eh5Yr+9XWsgIC8P1POwN5crJm5zPa/KesiG0SQQsbpthSBgZJe8RP8aV?=
 =?us-ascii?Q?/NuBaZNjfJxTLeGmbFpFHLAyaqRWnThP1Bt3yo9X6xTYtEidcI//wxLPMseD?=
 =?us-ascii?Q?DCk4e1OJZZ7x/Y9JnFP1H1qQ+biL9N/GATdt4UcsIP9prKI99QHscB1BLpse?=
 =?us-ascii?Q?m/4h+7ihKwx0aW4M2S/JELrtlscrzUF+D5lmVVzsvaj+pTSL6BOA1YN+ckwg?=
 =?us-ascii?Q?7wi2mWluo4hs4X7dVYy+m5S2rbNJfiRpturDu6orh0Lxk25ynw4PIC66gmpy?=
 =?us-ascii?Q?HkxL7TCD0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5729fdb1-0741-4b68-46c2-08de79683c77
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:53.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBIiHEA+Ujut2ZHFciUY+2QdDNQ9QK/bTv5Gxy4fppcMxd0Ml3pmgTsgRBZ0m5AeS+o8uXiLaMb5LQpSd0fYuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

From: Frank Li (AI-BOT) <frank.li@nxp.com>

AI bot review and may be useless.

> +#define QUADSPI_SMPR_SDRSMP(x)		((x) << 5)

Macro argument 'x' should be parenthesized: ((x) << 5) is fine, but
consider ((x) << 5) for consistency with kernel style.

> +struct fsl_qspi_chip_data {
> +	u8 sdrsmp;
> +	u32 rx_sampling_delay_ns;
> +	unsigned int rate;
> +};

Consider documenting struct members with kernel-doc comments explaining
the purpose of each field.

> +static void fsl_qspi_update_rx_sampling_delay(struct fsl_qspi *q, u32 sdrsmp)
> +{
> +	void __iomem *base = q->iobase;
> +	u32 mcr, smpr = QUADSPI_SMPR_SDRSMP(sdrsmp);
> +
> +	/* skip if requested value matches cached value */
> +	if (q->smpr == smpr)
> +		return;
> +
> +	/* Disable the module */
> +	mcr = qspi_readl(q, base + QUADSPI_MCR);
> +	qspi_writel(q, mcr | QUADSPI_MCR_MDIS_MASK, base + QUADSPI_MCR);
> +
> +	qspi_writel(q, smpr, base + QUADSPI_SMPR);
> +
> +	/* Enable the module */
> +	qspi_writel(q, mcr & ~QUADSPI_MCR_MDIS_MASK, base + QUADSPI_MCR);
> +
> +	q->smpr = smpr;
> +}

Missing synchronization: if fsl_qspi_exec_op() calls this concurrently
from multiple threads, q->smpr cache may become inconsistent. Consider
protecting with q->lock (already used elsewhere in driver).

> +	struct fsl_qspi_chip_data *chip = spi_get_ctldata(mem->spi);
> +	void __iomem *base = q->iobase;
> +	u32 addr_offset = 0;
> +	int err = 0;
> @@ -679,6 +712,8 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> 	fsl_qspi_readl_poll_tout(q, base + QUADSPI_SR, (QUADSPI_SR_IP_ACC_MASK |
> 				 QUADSPI_SR_AHB_ACC_MASK), 10, 1000);
> 
> +	fsl_qspi_update_rx_sampling_delay(q, chip->sdrsmp);

Potential NULL dereference: if fsl_qspi_setup_device() was never called
or failed silently, 'chip' is NULL. Add NULL check or ensure setup is
always called before exec_op.

> +static int fsl_qspi_setup_device(struct spi_device *spi)
> +{
> +	struct fsl_qspi_chip_data *chip = spi_get_ctldata(spi);
> +
> +	if (!chip) {
> +		chip = kzalloc_obj(*chip, GFP_KERNEL);

kzalloc_obj() is non-standard. Use kzalloc(sizeof(*chip), GFP_KERNEL)
or verify kzalloc_obj() is defined in kernel headers.

> +		if (!chip)
> +			return -ENOMEM;
> +		spi_set_ctldata(spi, chip);
> +	}
> +
> +	return 0;
> +}

setup_device() allows re-entry without freeing old chip. If called
