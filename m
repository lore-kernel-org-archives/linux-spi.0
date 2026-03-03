Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486163D6CD0;
	Tue,  3 Mar 2026 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571773; cv=fail; b=N82ushO+g/Dv9Lgfq+AW5lhuGMpvWXzkZR9lmwAjMCMGK+gZJe++OJog5I3pcmKQwfYtZ0R02CsQE+V9UF+J50kUyFaEgqQGB+ZjrCSfDWZ0UP7BDjHpQZTEKXgbiJvHX6KnUkZQ89JILLPQzozKf9FdmB7o2rLV6qE9dP6c77g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571773; c=relaxed/simple;
	bh=BFpqmdjl4iebLktEOAlzs3m3kjTKApuYaJ3RbawmgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLViPCohAE1C3V0t49C6/m6RqeFbF90GggSaB5G6nDKnUnLdcpdDe1OfRAErvo1LoA5rz94HoLFknQFIdjmOWjb7jYm6o7eVbTD405q6I1zedGOrsVXwvZp52lt4LozB73jCE9hXXf+vu5KblzQ0RuoiLIQCO2opNv0ABbc3Hy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q10japWJ; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q10japWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iED+JOz3UgYd4YEusk6GDtFL1cIgOcaDlG3UCF5PaT9M/Jg1lQkR3EBSa1+yGCJUjP+GvzzfnoltyeC7Gn3czmAHxBVh0qZduQgdDs0UQg3iGlx6qIU4i9UnRHMZdCxQUVSjAr16uB37DXbbnl9el3Z3X0wZPyi6y2211j1gsjVvOeWcc1IY4O34DDweGHbHTfzOvRX4jR31tRnhlcJVQz8hn7VGkJ5Dt19JZzftJc8urFqCnKROkQoJCe+LvRSR9c0jERxo5jDfk4lWrngF6jgQmddbul43dRP76yefYVAQN+XLvnnHSQWYzhRiH11evUdfb0CloFCjVIpsYpuRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IiXMDnXAGMKpo3cHjZsQU4irxAJynZN7gz6Eff3Kyc=;
 b=bpvxpD+tcZafTzjuyhs+oK9YRcJJbPhP/8k3LqHp3ZQu69hYurZDriNku8V3C39UqVnX509DYDAgJeeOGqrmyI9pVlTo8YcnSMUlFa5iChbEZy4rLtVEArD7Hehed2qtwrrwFZ00NDH8hqiGO1i4u/NOPfvT0XD2bD1w/za8vhJOY3Di0Im8y8sE9BQXZyv+qTeKDR0yu2fwRhJ8Ll/gY7Y/BFvSNMN2SQhLt5oelTXaGL8L5CtC8NFXLfUuFBsSRw92rDmb9CanicA80KVBBMzuo4QIIil/jyOnqLJ358Yl4ceXvrR/+aqSKh4ihtsdxeXIslYoKTpMxnhs2HczLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IiXMDnXAGMKpo3cHjZsQU4irxAJynZN7gz6Eff3Kyc=;
 b=Q10japWJmfPxM7XKmYcpxKPXraeF4/7y3I/b9wjIlhCKyGFfyOhHhaAY1kQtJE8DE0A2kpmIjMgFApcN3QwzJKdmQwRYlwh9qPP54oUlDJs5EI3K/pYD76mrZsjJqKnZTp5Y/+3ESXtcNBtAJfjkygwjws3lzupLoNQi/sSR42w0np2O+zYTLSIyjOsEhyLgSHhwxjl3P90c3Mac5wx4UJRoxY4chhg6dxRA5aH/KtWus3qqcoiiXhEsFLGm6NN+hhtr7ZrpWGOZ63zCTczMBn+JUiOnrshOx8tFab1jjgenz68XwnvDgJR0kJCPe+AZyl2Yt2bcAnEb+JDRLsRarA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 21:02:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:50 +0000
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
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point() for each op
Date: Tue,  3 Mar 2026 16:01:11 -0500
Message-ID: <20260303210131.2966214-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
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
X-MS-Office365-Filtering-Correlation-Id: 60bd7dcc-5d2f-485b-a10f-08de79683acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	64OiowduvNsoU+bVOYo8zHzksBhN/NhpLMN/sXjOR/51rQ2Xkr5hFRZZqeqxuK/psIZ/fdkToOK3k2q6cwH6YrOjMbwnGAlVYXictQUmKjVG83ykzHEmJ7dDVp95W1qQB/UZ/P4ZDO7Fybb8wvEdCyMbIFtAyaa4cbD0CSbyJQfwGPfsqNDlel4vJhkc/1elqP3rcWR3nx6vHuuy8dBHbV12kdfHjXKU0OBb/9cZ1p0r22/P4mEqZCThu12VBRW5gVXlG9VfAdRFQ6+YxOT3Tw3DyoPMkA/xVponcuwAFvUb6NcRrHWDcV2wIV4PMGhgnBbgMkJpZRGOyyXlZryXDIQL1qOq3YuDve8dNDHngYDle7m9Y6kIjqTeKXdiDXqcVI4Qn/s+gzFsFOMs+u6kur03wqOVImVDpfWvGxvoN8NxIeMnZUrNgbFNAmlBpUlQakchSRF5Kpy7b9YrrTL8QgHM02j1PGLP05eB+h7kKwYDFpHz26YROqvV+z4w4V5rHvC04qLmY48kZBrziq/x+tz5J4DPVdDyCJKUN8S9KTd+ei07FhstsP3Euf2Eo2P347Utnoq/xrxGwedNmD8xFBEgxxh6StNxa8XF7z4BG6wE9QNZterRTNp9cL6FUWMBGWWMiceV+zrLnTUovZCvYKjIfX/oAKzrt1gG7n81hGrPSmI5PEJvw/rkMjaoSb4Jl8NGthHN1nLU5cL7ltEgOvJrGGh5mwsj9SXB9BgS3t8KrkGAnymzt7a8sueFM1RSSyc3CorC6gXeb8US8bD3kA11xz+C7ZNIi43kfQhB2Yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJ2o2vV3fBfwoKCcm2U5RrrXVsG2YcRp+b+qq87xCxRAHuceClVwW7bUkWvQ?=
 =?us-ascii?Q?SmdbU6JjVADCWW10d42Xd9xLx61vW6XanNjGI82KBz/mew+BgiO5F+N2AJM2?=
 =?us-ascii?Q?lESk+AvvIYWf6f9/YzLL8gEPKhjpQ4sl7YQwoI5nuHgX8y4tU5mFjNIuF4uW?=
 =?us-ascii?Q?qdNV/oDp8fihC5PhDWnJd88BdLp+W38WeulkxM6M+srwGaCDiULosus809r/?=
 =?us-ascii?Q?pYIHABz82x0g6uGZIj8lo9sxHhRyr8FSeKSOVqudoWrlj3QHPlwNrk/zjGsH?=
 =?us-ascii?Q?WmRoEHecyme463Fug8e6W7WoBjUsz+sOjzDCuuVWzvuG9pc+WuRgU2LaGuTr?=
 =?us-ascii?Q?CtkfNrRkIGAqv+5J33+PsQG4KHrljFQ4U9YGQzzzz4Hzs2aWpqYb+Rt2fbkO?=
 =?us-ascii?Q?ib9DUCn+hpz3tvMBqud44SB0Oo2Sb1PCQ5KsmpJwNopJC+j6O9gKKu5AdDvM?=
 =?us-ascii?Q?dGvm2o9Q02Mp5yBL2F0ipvfG6D+jp6qrnO6ufVITKgWczS+VX2rKfvMtVWZL?=
 =?us-ascii?Q?tUWchrd8Mp86KU6tPPG1DaVUPto8/M5mZ1bvPdNvgaIwlALv0aFT9Mz7jan0?=
 =?us-ascii?Q?v6n10/1HVBNTAxEeDXf/iutfhRJ6XliH6idZmHo++Yfi6lJ0h9G08qpNEmk9?=
 =?us-ascii?Q?AsMV30+FBa3Ixot8lpV0w/Z4OYkcMhYSSl4wQAGTuf4eiL7W12CN2woC948b?=
 =?us-ascii?Q?LUWInHD1I4C3h2ne9QXQZeRyjiLKxnX1CV7uln24w6abFVsPKGuTs/1t9NfE?=
 =?us-ascii?Q?z866/e59XQbkgucNXnmb2qtz6Q0tEOoVCzX2kNoqffOhJIXatQ5PvRc15UJX?=
 =?us-ascii?Q?3eEb54h7SrpgeVcCkccxhdPLp0oSTOU75zh3lJYG+LqMR0E+82PeK/sinBtt?=
 =?us-ascii?Q?6j6aa9hz0PTi5N/0tO61DOxKt959mDcg/Xf93e97YqEymzJ3CEmfbCQLRK+h?=
 =?us-ascii?Q?ZVzKoIr0mPD0CQb+Ei21rnOEhmC5cy2kicC3X9lQt5+2E6WNAbJgGcYqKsfu?=
 =?us-ascii?Q?NYNAmnjQ37q8FyoWB+W4E3ffgBqzdSBCPS11tmV8F9JBi/kkgJqS5XFcBTGr?=
 =?us-ascii?Q?NexOn2LQ+VP5VBdM9OrjY2Obmg5s1O88WrGxVDeQC2sS3yp3//yP8rjsXqFZ?=
 =?us-ascii?Q?7I9/84DGewCHOF+jM5s+/FpLAuXcYFbKjSDG8teOgNgTpUeDZSxCZYLbLicc?=
 =?us-ascii?Q?VvxZFk/s/Miq7GkpLgjiZ7ZvkPg2bjhI5NwIEbmhqM8mv8zVILtbNghGcULL?=
 =?us-ascii?Q?rBsZ7Gv19kC4F9ASaqnPPvvfCNovD3QZDfjl8oYoKDTH0o+T3s5F9a3nW/SN?=
 =?us-ascii?Q?3aJkQHPqA42gNYpHeqKoxTHgJ03OesMlMBkEAwjXvotd+fNxFfoHTRtLvWIS?=
 =?us-ascii?Q?JCEa4UehUvI7oooVDH31uSk7FD3cOU3zGhNFU/PmPjydepNG6w7ynFQUEfeF?=
 =?us-ascii?Q?qvqi5jisBEem67+8ob1ETKnG81YmvAb3jib57FlggdCVfKUm1tLgpLonIyX4?=
 =?us-ascii?Q?LUbTvlXnID3dROJOd35n3mN8HrxSPAJ7eDf/lxEK8l03yxbElA0Htle6wcWm?=
 =?us-ascii?Q?uNEK01NDJFshVHJVRmMl1KI1/dI+uWnDsvaT4P8hzbYUbcf6wgSbKt6Aw8fe?=
 =?us-ascii?Q?ekfM0QCr0X5MTr5fsY4i95yICokhPPLP8BaRkq95GusEurPfgrj8WGxYK72+?=
 =?us-ascii?Q?656zfx61kM26j+URWotULKVgrpSWWIHq9Cwy/jbq/oJoQ0oxXbaOCzqC+KB/?=
 =?us-ascii?Q?CF5YW1PKhw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bd7dcc-5d2f-485b-a10f-08de79683acc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:50.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +H2FSajHbTnm/MuIudhAtl3kq4e2xCQfnNPTBaQq0zaWquT6f0pzGFMOtj87rTAL9ueXiJrnPuEcSLE2Hq/JGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op

> +	op->max_freq = spi_set_rx_sampling_point(mem->spi, op->max_freq);

Does spi_set_rx_sampling_point() return an error code? If so, you need to
check for it. If it can fail, silently ignoring the return value may cause
timing violations. Suggest adding error handling or documenting why failure
is acceptable here.

Also, the blank line before this statement is unnecessary. Remove it to keep
the function compact.

---

AI bot review and may be useless.
