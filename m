Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A583B3C1C;
	Wed,  4 Mar 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636184; cv=fail; b=SvU/4Pxdlw10JfiaUchXcgQynNO+qwpvz6KLi6SyOaqZky8/xOSidLcyEfMMDfL1sebwLipRpK2M8EjY61pHe1QDpRkGiD2+3X8b21Bn7XBV6D2aIWgzaGrdGhCAzd37r+ztAasJI3qGLec92CfM78ynC4bQhVKd+sU31z5suDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636184; c=relaxed/simple;
	bh=bYMtLcakN1QgoYMy5Z5qFrNFVKMijl6S2Pd4o+05Hes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxsB5uN7cC4OcRPUgMgggoVC3LYAmuIbrNxIHD39Fj2rbkd/+D96eXWyfYfz7SSh7wqz1bgXbwbRP9trxLv0LwauTu7AWOn3q0DiYAtotficun7yp79d+Y81ldFxiIkbEZc/kMqRGLPzt4fcLnoGnZvPStxLBGbY9hO9bHeJarQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JSCGFcp4; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JSCGFcp4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIKH0UTFPTBoc1VBtfAAPjyhFN4Imn2iYshPe8/VjzY93x/bLBofzQ5wRF8+gTN9QwzT4Nmi3jnm8fUsyrDYcyZ/WmNh6645gvbGeNApc9NbGQBtMu81azigHRcB/b1SghSdef98hrkZYcjeHyNLEDkqGkoUUrqhEOKKbGyTWLfNqE7QQ5q/VhafZS7OaB2dGyb/S7qTfcvk8ATDfEIoxVO3VMRXUAm6AyxS6V0Jmy1guM2qW6eyyKjRoBTbk6YKvbKApPjH8Y9syYTDULLRhD9qSGorteCmt+x5MVtNslY1tSKsoZFr80vWDtFh21i/PvV0CZ0u7uLT6Nt02U93sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYMtLcakN1QgoYMy5Z5qFrNFVKMijl6S2Pd4o+05Hes=;
 b=l5/2MscAhqbLAM10knSiS2Srh95dqNi5usL0ASIdvwyMa3rAtVaQbIGmwVzLl5T73I+Mw7kEz00MAwywjwe1qB4uOD5WFqGKwAvNsWmuI+/njtybBD2XCtQmXCz4FMNG7HJTlyX9zyi7bHWJgvomgr5syPVd/teINOJDLvj6AnKXOTibrnhioN9cN2doYSetP4wUO25yx8wJ7xyWRWJiccUcM0jvZJicmz5LDpc+rB2JnUT5r3LfNegPjkmWDOxcBIi55CN68OAn06lFWaZuIXTJmHAECH9KQzj3k49FrwytRmY+vy5xV9o1kzo7hJH0/T30oPUpHx9UDqPdt4cpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYMtLcakN1QgoYMy5Z5qFrNFVKMijl6S2Pd4o+05Hes=;
 b=JSCGFcp4zR4eTxIrAY3N1J0j59e6OoSsmdH6LxPpputdu4mM1NJIp/LReX+LmfQv0YH1nL55yzlGB1klkv1CGWqyDDWu9a2h6PVUFhYbyaXsF+CRAP9qOta1yY66CMEEJckzaPA1Us1eKl7hLUlfD92LlscZYAUqts4nB37Z0I9B6naJ/O3RHIR9XcM4vNgaK2uJ/vE28LDlTMcpNISov2QQ/z6nIs1BXMItsx7clsTibTywPjJsLVNHGcnXblJFT9X87yKKPwncnkQuM9NAEdBPTBR+Ob9Ief2aR6ncN2NCOH3ndi0nCRwK7XFA/3Xyo2Zxw80lAgC4x1gYao6tag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 14:56:20 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 14:56:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frank Li <frank.li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v2 3/3] spi: fsl-qspi: Use reinit_completion() for repeated operations
Date: Wed,  4 Mar 2026 09:55:36 -0500
Message-ID: <20260304145540.3331304-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304-spi-nxp-v2-3-cd7d7726a27e@gmail.com>
References: <20260304-spi-nxp-v2-3-cd7d7726a27e@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bb3afc-d8ac-40c6-432e-08de79fe3201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	eqQgox9bTx/r0vnMbURCOsXmd831WWPN68qzIr1zHeQIATuPL70PPiY72vS1o03Uv9XMn54ewuL7YUnDT3H7czV4FqSmSyjgIhDrV7vUPevNP64yp1Z299upRCSUPkN96yH/sdbW7NvC21TxsO5s+EgObxXLB5CPLPjKbAa03LxlnhLGOiyrlcvVmz3F1Gg+kQLvHIyI7FPVRNaV4iIQoQiGK2grIWsOiMpGJuIGINzO5d/jS3/f8R1LK525lflIbTAotkelvX4BDKhFNH0pd34VrxpnrmkWRVlXi4A6m0rY1WY5chnPqgKYwBVUhYHGJVYGqMYMlDlYi8ENAx74f91Xbnb5CjpLgXcKpLfwuYI8rqnrnzjC44fcbId+3CHPxJQS/DKXdFmrlMksvbdD8FHBtymdxDUC03K0UN8J1xMkWKG1sSzKaQ71kJrCkyyF30ypoMqBq31h8d/l2Iaur5v9mKPId2+VgTY4DlqE0ebTEhXuKC/aOWWwUKyG8xPO33g2L7JRh21tvItjxwXWqy+nG6oWkyx0/cW4YsQRKyybc7Cgxwaz0q+G7zLMvMjsWFlEWD+COUTRhQF1aw5XG6golgD7R94GU/pldz+oGwnmTnlC9qHB208y25ZbE0KT1qilMPYeuwQXPbEQS5hItF/DufDitYRqK/NTJN1OvftqeQO7QWLRqnrCDny/7vRiuhsbiJSVHJSiNuuyOQ63oGmrxih1wV9Y4ipDPG3zZg2RtjStd3g7ORF5mNYb7a7v5ebtWm08WGJbMc3xxYwA4hyZBkhyfqoru4td6qsiI4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbqR35L82YJozgH3d8KtLqz0ZdXPsa2+n5uR8YC9ALSrLcP2KKpE4eLSsXKy?=
 =?us-ascii?Q?bpowquQfLpWR48nXajIBLj3bcSiq0x0iHEDAyOvGguST6SVGnA2FYPDA8npt?=
 =?us-ascii?Q?Q2z9dfosAAJMQftJ8Dw2Zdnu79Wt8CWwdyy/Ax1Yo/hVKKXpAOaoy5Djd0Jh?=
 =?us-ascii?Q?2nkh+hgJFJbd4equadEOtQaX+l0c1vFl2vh9npsBElLddwAWSO5EwcMWMOhP?=
 =?us-ascii?Q?aDY+or1DkHy1CRMMhzv1ywi3qqwmJ0IjTOY2t9EV8oerX5DUxuqEbCs6/xU/?=
 =?us-ascii?Q?TDiklnR78NPTZnmEEW9ru/mVM/TO4/7JEIrnRZKjhgpPYA6wdQeGKXn0xBel?=
 =?us-ascii?Q?+grQgGiiMM6hAxKAaAoLghgTVe3hN6/NaSkGFBumjbifPg/lv809HNRphGqR?=
 =?us-ascii?Q?iSeUUrRNuTlrBc0+1qsnvnFenJ80fXBmPaLz+eZ0GkA2RTWeSjaNaEjT6btR?=
 =?us-ascii?Q?yKMdGN2U+xaSW1nqBiTOmFnHgdT9wR16T1nt32KmVL8d97WcdCdeMmT/u7Zu?=
 =?us-ascii?Q?QdmapwPP5XiM+qRPdTzQY0agCzGJv35cCWKOudB6Gz/nVID0Lph+guvpI4ml?=
 =?us-ascii?Q?1c/Gp4fnw/c+8irE+gmA8H9HUeSKlrfWTqj5tEgC1hmr0u2xgpHpS4rTT/ES?=
 =?us-ascii?Q?4/jeNnZZV/IEoxZ/Drtwzm7/Aswn0LrPToSiHCoY0CcCot5gIbGyiiY4Wcxw?=
 =?us-ascii?Q?yRetXD4vOcIOe6FT0EI+eAwCXpK6lO8l7UIax0IZLFKDlDqp583iKEdlAZgm?=
 =?us-ascii?Q?pTULib2XZxGxNZC9xdBcJa86MKmpVRcG5nYyuQHXYgCbhz4ZXbNqlrC7Zq3t?=
 =?us-ascii?Q?JOdqewkiz5mkmA/Clx647siZXz3ti1GPMvDbtL6GtQwJDCjOkFJYU3t7aPIP?=
 =?us-ascii?Q?aWeWO3XtSaxuvyWYltOQ4eGUzvVU8W16OOdvzJxt0s5zk+M9zIfb5beuCGY4?=
 =?us-ascii?Q?qcmmEXJy3HvGFwwnwHQFL1BRNXw9KOz2p8Yo7BajHOv+O4gpn+xtdYdxBl5Q?=
 =?us-ascii?Q?er99gP48KukPTyaxcignBH12eWOJI4yjNBgZb5KSN1OXh+vM5xmsSG+NRkiO?=
 =?us-ascii?Q?ywtG6Rn7v8eG/M7O2I11PGo8FhveqyXuG3jYEkC6aANNc3zd0l5FsAfirgCM?=
 =?us-ascii?Q?apdGeo1NNrUP4rHPB5FjVvlAYhOPV9zTahb8jA4Hj1Sgcx9C+QlQOt2hbTPm?=
 =?us-ascii?Q?sgwEcRsgZc3okIPAvpUMSQagUH6nR2Kcnddh19t/yIqXrIxHfzNZX2cSHU0w?=
 =?us-ascii?Q?r32sVKgcvEAj1KmjbcklM05qOfErzSTVuwYlR5nFRYDjZ5SSCkZd4+PjhZBs?=
 =?us-ascii?Q?DkXhFhDGVupCc81SkejdPlR7shMkhmAQb/+kayY5H1XfqXHyDhhVeWDlPYhf?=
 =?us-ascii?Q?K3855i5jpjAOCUJ81vU5qoCxTaE2H5mekpMI3iT9kccnnse7S0+HqB/zp50C?=
 =?us-ascii?Q?4YdJh4J7T3+/CTViOHW6G463kS8a9UhbMswKUQET1H/P/c7I7czT8T5Fix2d?=
 =?us-ascii?Q?1emRG1jWROYrCTSb9Zp298T09yEEcrv4omCSd8clZDm/6ecfsFJX20dzfyGK?=
 =?us-ascii?Q?piaYy4k9Pgalx+9CxkfjMDY52cWUmWIo1FT8oxfl+qT7mwtosS9Xz78Avk4/?=
 =?us-ascii?Q?SpHFGXRBIZbTLxMsaHfQbqz5ijRMTCt/nB2JgC87EjUJKsAToWa5CYYhHjKM?=
 =?us-ascii?Q?8z6qlm4GpeU5fUfsP7FjCvgCPZqAyd98hP7Ve14o9Onsy3WJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bb3afc-d8ac-40c6-432e-08de79fe3201
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 14:56:20.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEbj+yaFxmq0Y31+1S4mFoE94+8jcm42RyRWouBX3LHI9d6TwYJkii3d/89nPnB0teA9VhxfKzXFO9Mv/qs/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Commit message has a typo:

> Tchnically it may work, but it's not the recommended pattern.

Should be "Technically".

Also, the placement of init_completion() in the probe function should come
before devm_request_irq(), since the IRQ handler may reference the
completion object. The current placement is correct, but consider adding a
comment explaining why the initialization must happen before IRQ
registration.

Otherwise the patch looks good.

AI bot review and may be useless.
