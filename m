Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889C3CD8A6;
	Tue,  3 Mar 2026 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571772; cv=fail; b=GTGNGe3jd1rm/5ayFH4G6U9A4zKdEUXUNoQ+6ZH2LSa3KOA/YiTeLgJw+FH/jkG0gh84FdCPFb/+g0J0ToqQubSdJxs9Ck0wB3djhnmaJ8mAtdV7jeul8c0ICR8OCUuNYAbPrLzhZKvMwyAdHvINk8tyFxyhybULJICYoobUleI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571772; c=relaxed/simple;
	bh=L0Yzy7GpzDKYyAy2xEV5uMIDuB6RsyIxaIqZmrG6YLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByO4xKSD0Xd/fb20V20E2DNTciQYyj5Rr+YMVVN75BH2U8V2d0rge2dLFAyP+BcA1eda/hRRzvhbgKGNFjfRanHITUjg9VOVnMA/Wo+jRucrc20tbJxPkPDJ98zoSlKeJwWVILffMbo/JbWqa6zLupsnbLKFQbzbx+xiI5DYsUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GEETgBT4; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEETgBT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8JLsAs+pjoqIhDvOMGMUHvYl84X2vxuLV8eB8jze8tPiRp5/41TUQERDemRJl+yD2IgntIbq6MmYDW48gTRwBvvYrI6LpJTbkrhr1yLYXdmPIGJt+u4sVf2egL+SHPE+MSxPve5KjjuqGxEX3awC6wo+ixikJAwtma/fcgMTsIb/5HS2Pw9Ypaw+i7JHlYk14d4JTOyjxs1Kwmy17+YxNlUijzrMedd3FDVpIdwUkzpz2l2fQ8cNBaJy1wqdB0BKi46P9R3PE4aULyohIrljx88N8sZ2FvdIVwXALs1piJ2osfUdnLCIqqXnctzIco58vM/bVePrvqIX61AB7mxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzpOpfqWxq1sjBklZ4fn4D904gQyT5qoOso4ouqZHMI=;
 b=s+2WOgDLWxmoF+QpKRJmTMMbeWrdBgb0RLOtQf2LRFAsSrtA8/R7/3OQbGzxn65Wod61qA2godEN9XvrrQUSGUldLwfIC9/AdaRkANeWBLAbaFazZA5J5A5rFG1GvQ8vIodQHB5fawYEH3Rw1n7FJqvF0nhcGCpIZRXsCZd23NGMDv9tCx8+HbLo+g0V+8KuajhlQHCrraFX/23YCxCcNB6syYfmeq4QUCYv8F/0Iry0eTDd7a3/I+pYtvzICjQ6tyvjtDrq7egkMGIHvOkrVEMV60TiD/NB4fZyRy6/6MJTGyjHpPY8fUAxImYLsUMT7Enjh6z7DcSlEKWZMnZERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzpOpfqWxq1sjBklZ4fn4D904gQyT5qoOso4ouqZHMI=;
 b=GEETgBT4MuFneerJ5+Zw03EXDyUVdm3GDkgPFo4+Ku2480FoVB/dzS9wcuXfcqV1peyD6t0rS7FArVke7Vwht0Ddvxx1OeoiUv9K02pj3YN+G+bcqvVoPh68ZVExmUlz3giwomD3PCJpFMdgCY4gAyXPlMw/nEzImbVQq81ZhIzc0jFP3Zf3iLTXBGBKS7uMa28qtOzXnOqDTt0kZ1WkYyFLDwSOjtAlqf25cpc0ZGg/t8vCrPJYRkwyu0U1k4SPelvYxVy1B9vRixkG8jOzLY9GI6Lob2AU9ahxWI9yh36KCV1jF11aCS/lTLX7u9URkUBkmmm/WNcy74r5DtCs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 21:02:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated operations
Date: Tue,  3 Mar 2026 16:01:10 -0500
Message-ID: <20260303210131.2966214-15-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com>
References: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2cb1f1d-7ca7-45b8-7091-08de796838ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	jbCvaZcJpT2OQqgmR9cDBq75CGHLUbBNt7P/QRr9N7WkUqnmPYqeXu5Vcyuwpceeq27wFQMvjST9E5mRtykBd/fEDiK82UBwbx0RuRCIVTw6To2t6xnKYtVPp8UF2POtruacT6aNZui6znQfgLI3D6s9CPvYwSc6Vc7q35j91U/wYZLcxCoBZqd5eOSZyp/ViLv2zVw6964rfFK86IhPOEMeFgbk7lSZ0XasowD2EwfA4PD5NwtIbcwnqaPZ2EQluLkLOOhoMhP6yAoavlxluy6HtSNv9Qd6lOEMlM3mvR9myCaDNy8RI50q13WXQB+C+FDWwkm2ufVQWd6DHCS5y3tcEQIVHBIwOAO+Zq8FFtxWeLc4EVCt7FSeSZALl7k6Gfu8ckz7LtJ87krufeOYwNSxgU5OOHhqy90ywlzA9pyxNztT45uxvsoUYCQG924ybNgpgkcd8mdMzd/xzK7MJwggjpAZsC5gle5vlvUJ6PVuGS1+9tdjXKdOzsaCISj1m3fXs2ED1QgFGixSexj8dIoqoG7FTmAocXQ6+eUSHjuiUw7lm23vZFNXwemugHlqXltbkWhRoPC+R3eTuEeLqz5MYpqN1DW73MVusVVB4Vxt0QEyUXytOzKj3z9XByyTYpbg2yfGaCY/WzKeFXkniQGh5l9yJjlT3RIOQAwgWHHD529BVNVS1duCfE2dPH3JkEKGCZ1k9AbL0HGV5QaWbIiC5Zr+lOL+F42jEufsnfwffLApCkNTpsQJFUr669J6LhbXj1gP6sTxehKFatAJBxTxLgn5XTiBW6KOHmW+5xM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4H7ZRNJoMDnjUs2dnpkXBsU0tDl1MzGUkvTTMsWrVnEV7V1jh2ZDle1k4oi?=
 =?us-ascii?Q?H5/hIvSUXNVT6jyso4OhDh0d7e9jrzUiMqTDNgkvIblP7tVEft70xMkz87Ur?=
 =?us-ascii?Q?UxfY+vsrKxY4InIdkOFqZz6jcb/jUfgwQpcyHCIGEsZQpFGNN+bPYoxbIYJX?=
 =?us-ascii?Q?eXtxhissAhV4IykZvC8xdLyGhqimrdJOnaCFQjfBhGnc48y6n61STZL+JX45?=
 =?us-ascii?Q?qgdi3tM70/tI4mbqEvQCfDUJsYgyClluAdsjH5945U1kj1SSu6K9RohVycaw?=
 =?us-ascii?Q?h00wqERFYO0ZBddykDfnAdubSffXGlNR2u1gG5i+qCI8G2F7/URB6eKh+Y1m?=
 =?us-ascii?Q?8ABJo9GOySJpWhYLZqfUl8Jr0Sfw5UQcDeN5v44SgXO2eK1F7RLxYg+2IM6z?=
 =?us-ascii?Q?rCsJoF//BKXHwUx10UOCxlOBOviEWjFT5iQ3S196OXTWhiWfO1QOHYQanrEQ?=
 =?us-ascii?Q?BHX1yYaQroxTk+NKhg+jBIPy7UnrIUqXUjAsFgIVmOjUqgAnnNgxNXiId5pk?=
 =?us-ascii?Q?DoqNA7T6llmuiPYjDEYtAA0bYpxQQJuvyowyA7kFL/NOxAuyMvocUAjvsFT9?=
 =?us-ascii?Q?KfMJwnp+YzMpmy9eeIBBHfFWedosMN/vnvJdq6S6xQB3YmTJVuknKXwSlt7y?=
 =?us-ascii?Q?KSqwt93ou5T7AGlJn+mAWtqDLHKNo6uiqvS4PxDzxgUCogtGls7hu0gpES/5?=
 =?us-ascii?Q?cC6jJSZmsI6ZXjyz3IIu/DrRTFKXiHI4NxPgd2wJO5SDKjVGSnG7BEKdquHc?=
 =?us-ascii?Q?cNtvs2vcMFpXs8n8cZjnKqr/WhryDBRtYE66KnJM6JGRGbdMhDedPvbu+FJF?=
 =?us-ascii?Q?LLNekGO3NHcabWsDFZMmL6MXnOIsrni2eEX1B8/kS87zNrOLCCnsUpBjXU8i?=
 =?us-ascii?Q?ldHoktqmfI7JlTOhFP3NTWZd9MhcRx6fSH/2XQtofS6H5VnvencGDO23HSg1?=
 =?us-ascii?Q?/CD75zarVe3UipX1nUI/SUhs8Wn45LnPjzL9bALAXtlXjJX6m053cgulls1P?=
 =?us-ascii?Q?N2mMzb2xtkZPtyHBTEk4LYsLE+EjfI2dJz2wx+HwsolIpgYxh3PFsHpfJY1v?=
 =?us-ascii?Q?YrpFgRyit3gk8c7GJzI1h/LqaE3RjygxNLbZ/cMoyZ7z0ciWcAyDW0XFzuEL?=
 =?us-ascii?Q?kmNNg6a7kY625HyXNau7RDFTQr6McACkSJyU5/Leg2fO6VI/NjWf5UEf1X5R?=
 =?us-ascii?Q?Jhj5qkRxb/h9ibHY35OOGnONjNQARwmeUXKQTa9E7NvAlrl4NNY6j6PqYHY1?=
 =?us-ascii?Q?qX56p7Q2zyV6hMhE6Tb+2+3AmK2mcevk/MoL7Gy3K7OGdvEFULWOYU5G9dFc?=
 =?us-ascii?Q?vqH9HYYDttS4omX/4eFdXYpfku0CiqKn5fq33aMuxWvNkIcxCCi/Nygyk8Xc?=
 =?us-ascii?Q?CJJ063QIE33/Ls8NyQqQqOc9jTq29xUyxodm1KetsKdG/ZUxbVXo9LShYake?=
 =?us-ascii?Q?LL99tjvdnphQSxBlcDfdh+ysmVcJ610hC6sL3oy9UGXB904HXOFFbGwK+JHF?=
 =?us-ascii?Q?2Zx8wZlKn0rO6nPXhEopYC0Id0jVaP5VXKlDOE8noWo2gfBoMl5HJGVuRUgG?=
 =?us-ascii?Q?+RWVS3A0RTE+RxgFucWBUJMYgj4rGSUI8IBzjxSnCcrB20C4fOSnz4sA1a/P?=
 =?us-ascii?Q?ZQIeCTwfo59+z9iUMrmbANfcJzNZBr/sflIivIs/UGwhPe2OnqYedCGTBSin?=
 =?us-ascii?Q?INObetwt63ONVKfR7Ws5otFqsr9qhFizFR5FJ8ZTDuveoz24AmunrA0Wm24c?=
 =?us-ascii?Q?acgsBsqV6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cb1f1d-7ca7-45b8-7091-08de796838ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:47.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfnljHZr0mQjdGe6oEwOTCRBhYfAf6Xb/1kgB/2mJI5Yl1oXTvmvlV5ySPMizy71wzeR069SSdZf85FSMkyBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Subject: Re: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated
operations

> -	init_completion(&xspi->c);
> +	reinit_completion(&xspi->c);

Good catch. This is the correct pattern for repeated operations on the
same completion object.

> +	init_completion(&xspi->c);
> +
> 	ret = devm_request_irq(dev, irq,

Looks good. Initialization happens once at probe time, then
reinit_completion() resets the state for each operation.

One minor note: the blank line after init_completion() is unnecessary
per coding style. Consider removing it to keep the probe function
compact.

> Fixes: 29c8c00d9f9d ("spi: add driver for NXP XSPI controller")

Commit message has a typo: "perations" should be "operations". Please
fix before sending.

Overall the change is sound. Moving initialization to probe and using
reinit_completion() in the hot path is the recommended pattern.

AI bot review and may be useless.
