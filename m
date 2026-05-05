Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78E495528;
	Tue,  5 May 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995608; cv=fail; b=goO7etHIogR+K6eVtLW/BxS1dZCuYQJE3oIaaEZonwhX6rR+YhM6ZRs5K+BXiZu7DU7/04xazvUyQEVV60FVKeoprM3Bm2G1hWgMlChdctgg8ClDEAXQ7+htoiK0P/G/lOYik/t23Bp03OXZBZzrmWLeQ439gywf+VDUQjokeKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995608; c=relaxed/simple;
	bh=y72en8TxfoUY8EvTuNqQtdzvWG6NZn+MSObVohYGIN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EVdyQ0FoY1naK8EduIPklPVrOdA1y5IMqto3UxmrIgvYn/E0wRhfVvyQ3tI+V3V9CscVCjzL+m+XRbFKtQ+1ZlJvHwSFBf3NrgbBicWAMrzrKaYFwGCrJ04gi1XIcZQ3jSFk+ApauTni6VIo/Dwqaq/flCppJbVltK7rpkw3ndY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oBpxsb5d; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oBpxsb5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wam5s7lqYHD76PxqKlAQtGi4NhJhZYowsO8huoYK2w8pl2a75U2RjgaWtJBE4pQ4r/a7QqNZvLN/ij35WF//VNPBCTnwS+AZol4CcOrYwgwri+rUTkScSBjD5qAoldWohzCNKYbzQ8I5btqT2B5DxmxaJUMqcjtmuytJa9zMozmKEHQX6BehrooqEEv7BCyI/gi+GcVp+xAMm9qQoQ1ysjEr/PxAq+Bd+lt0bqOXLSY9amZHwvSpJbsIgtjJKO/d42Daq/ESRKzd9kopS5huV2tBfalQuqjljNkt73BBWRyKB3cXGlrMoRSPEoGiWAdHSaygTg4hbnsNsFeVuo0BjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IE/CrCxj5AIf4hfnkjgG0AIJbFdqjG49akaTCAKyUI=;
 b=mluJC14B7TP31/5eL1qF0svAIv0A/hAJiLVCZr17lq3zqiwHB6yGJN+bbvzJt1ltOfGLnwjVtAYobWeCQDaiZUp2sYW57Ell8i0HgZs6Nqh/v8rDGJGGodPQB6fR/ySXxtNPjRc4W+8rTxY3xOHTsSfdD1JU1DtFldMv4pG6r9+1wSywm8THGXLs5vQc0QCae+AdmhCifIn9/qzUBYKAbPGI10ERhlM5PgzV1IYRUZ+CvzkHcMU5V7BlVEjg/Q/R/qXoG7z4MUEPLDP/u4TpwpxF71pdwmAinmfm27yrryNuRRNb8D0qjtkjPXKF6DQK0/p1HFHMFBK2Qa6irkibpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IE/CrCxj5AIf4hfnkjgG0AIJbFdqjG49akaTCAKyUI=;
 b=oBpxsb5d0/Yloa/qRh+W4VYBKDAPKfBUTNAiiaiugWe21DPUP6+53fChbnHFP5ver1Q3YltKTCecsnTiRZERh+zQbZpFfJrsjcVyhpW599FGvfBMuPSlDbtxXT+M1AR0k1qK8nmP6OTspDe0DOabihB4R9PRy6wcrTztvYxvUmMDlrllqGnIsF8zlyTwkEtxfbPIusiECKcXQaaLtR/d6Hyuhq099zhks2P/AoJCw11x/z4mi5/DaOXwkr+f6vxqfxXjMaXyYJftbTqzIciJEWHU8/y4LJaIPr8J0ZlSZBh4r+czCx0G7EeXqVLLvh9irj2W5t8oWzEz9QMpOn54SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7026.eurprd04.prod.outlook.com (2603:10a6:208:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:40:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:40:00 +0000
Date: Tue, 5 May 2026 11:39:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: broonie@kernel.org, sunny.luo@amlogic.com, xianwei.zhao@amlogic.com,
	neil.armstrong@linaro.org, khilman@baylibre.com, han.xu@nxp.com,
	haibo.chen@nxp.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, lhjeff911@gmail.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 05/10] spi: nxp-xspi: Use FIELD_MODIFY()
Message-ID: <afoPSF5g3WVHJk0L@lizhi-Precision-Tower-5810>
References: <20260430155456.36998-1-18255117159@163.com>
 <20260430155456.36998-6-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430155456.36998-6-18255117159@163.com>
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4789953b-0c6f-4b53-d264-08deaabc919b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|52116014|376014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6zTvDhTXKR6DFj2e1/ZZ+YKDzKDPv2X56hSgQMQpkDnxPcUDNsyeFxJwdn7wKwF/PxSonefd7JPVt6Qk0rS+tUmXw866nAGLejysAnwKPvLs2vwMVhWMptJZ1zDv4F3kFUfouChPhohhvD0nRTR75zCcihE6d0YjaGM7xG6SV3VXoNqTYSg6+LABGM6hld7Nhumtf/AgR9NJeIJZWbodiCwv3Fj1/vjzY1VJ8hL7HnQZ4vICmiDegDtYG1z9RI6DFh9wa5TnKswOAcoKy8ejt4rfvYL8p8SHWVM0WcIV2ezGcnqFjQYVm3WmOfgPs6b4mELU+SoDjcK4OzIznd88jK3+TE6wHz+nMxUTPtTHyLIqun03q7Vfyud2SBnIMmXLytk+F01KIr2/BPLrbvCBCTFRt0BaA6Pg6ID+BaM2wm7UbfuvjZapTtQEvS8JHBVRdXW5Orjf7hmx8U85RHfm15hoVZx/R+oXqNT1y8glnZuDUmv7T1uqjplBFwqHJRcZ8Q3pdx4bkHr+7zXCGV17x6KWhqVD+HkLO0etByoh/MWwEeENpmxkV/WNrKLY2j43HJN1/VDd9TAPooju1uMHiVWgoS/c7tOiOwArqk9PNlcB2FvgWYzjczROiemwIMJgwdMeStpeRaZ1ZAG8t98B2Y5yftrDV84BCHx7N+B2MHjspYIcWGfbkPmi0IpKeIwEtXP9ihUFqjPzEGA/AH6p6LnOyNZjjAemSM8kDCUuQVa/iLCuxT46/GbbydNkofaz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(52116014)(376014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6dmm7vUvyJIyS3nf56hzYhitL6ZDpMByXzO2MBl0FMD2ErJ34SXqRb3TPDP?=
 =?us-ascii?Q?4XNmaIQ0QqwtyR08eWdVxQYn3Bm5k0T50jft2CrRifxekpCbbec+O78lCXkX?=
 =?us-ascii?Q?TREa5uj6xAkpmVYVcf0ZCoPkbPCmtybq2WLVU9lZ2JiNilYilUznhWYhnFig?=
 =?us-ascii?Q?n47j0F/9sA4OzDN0jsS6dUERWo5dwRVJ5JqsPjj/9PNkh3gmVKEfTEzOBDtc?=
 =?us-ascii?Q?UfF1TmhvtJ4591Z7eRqbduE6HVg+IMkzLpOX0j1ytf1nwvkzIU/7JO3gOcxC?=
 =?us-ascii?Q?yxf4IW81kp03b/qMnf048G/AAD9vYmMtEIrwKrrztG1SrBhNIIaQwUZxH1Ph?=
 =?us-ascii?Q?1mRVrYSr1T6l7FKxYH/b0jz6+X+8BnZ1pOYLDA+IntsnYHfQ/imwdE/LLzGZ?=
 =?us-ascii?Q?jgFRCCtDVsHHXb1uM4ylySHADWjJezne8Sm22YU20iM6odSTBKEz7Y8cAwXG?=
 =?us-ascii?Q?fKhbYOZXhd747x5gMA6BGUPv38RklFCPs4Adjv0+Wa5BoG1ksp6B6YaVmnp3?=
 =?us-ascii?Q?mgLdfm03b+tbOhvdz7nWJkRQhTxZPutNUHMH30CwWHskxgcpFFe5h4oOC1w3?=
 =?us-ascii?Q?P7dg8uxxEZ4vLRJ1E+JVjlNIk9Jq1fr0sijKtgckY4hR38U83g2y6tE13Bye?=
 =?us-ascii?Q?1MfeU2T9gykmPt5iIdtE6uxCC1l1weVXMpshFcrxWi5I0GSaC6FOajAvhKXc?=
 =?us-ascii?Q?7PyplOmrQJr7qYU2W3+iI3g0LsPzSBpsKmgx5P9MHUo56Cjmp44w1ZVSR2fG?=
 =?us-ascii?Q?o/OUKF95v5/BVg5oPkqyxxGCpEPFwzwSYxhxKyCujkCMTOeLKT/DiUTEG0tZ?=
 =?us-ascii?Q?ON+mSiHiS2rUWGmkfSttkmn/OFjQH4ef5bXjlBh9eNBISASHmFFNQtgj9zcN?=
 =?us-ascii?Q?Paeg8NIfngkjz64FLRs0cXpF3i/chYmsnjIB6SS1bFTui7/oNu967wNlYO34?=
 =?us-ascii?Q?4eGPMK5npO0TWPk+//ArgAbI3qXs1B84FQaA4VbqbADJB92NLF71fXa4ODGZ?=
 =?us-ascii?Q?pciiKpbTFO8x/blDXyEchNKsamhULV+OGDDsmari0sgzTcWG72SIyHKArovP?=
 =?us-ascii?Q?IT1jTJGz17MOa5eFXVUoFBrWv7ok+FJbZUgGH4v+9AhKwL7vYk2JONW/RJrw?=
 =?us-ascii?Q?wwEYIewiwctU7kxJ0Vo8Vgra1wZBApFh5Y9QedkCHKDP+uCCrvS6mhKpuydQ?=
 =?us-ascii?Q?cGmvK1za0IwmUial4+kd26M5i53JZfhab8GvX3dfIqfIliXzCjzh3LUto2Nc?=
 =?us-ascii?Q?VC30sVCvwcIxkd680mMJyr44i/gqwJM+IV/B/H4i6hwp8qY9IioKLxm9TbJP?=
 =?us-ascii?Q?b4SHsj1T5r4WBPlsEHWUjcjuuJnrxbbj4hge4y+wGgHh4FO4dKC1k4X5pqQA?=
 =?us-ascii?Q?FfZtsNjexcvHr7dLmyKI0I2uSJvW43XhgF/GbIBWs4djW0uqpr/MMSdPExCj?=
 =?us-ascii?Q?/2jV9uFu40eChYbrO10UjBIoDznbuV0XYTOk3SGXX4zSqbjFSfTjlviW8/ps?=
 =?us-ascii?Q?UePz5jVG/R3LZfB5AV2ECOWOE+yU0DWs7h2qcKlMSp0wvaZhB8V/PECGIArJ?=
 =?us-ascii?Q?4cGilqTxwsn8Excg5Z+uwrBP216htqhYQV4wG4Z8PJ+nmEC0htWaV1azVqO3?=
 =?us-ascii?Q?u4AIQjYcHxEgNEn4SdVkUt8GhFM8ZdX4TM3QhumIo3ap5fEK1P5nPmYmegUs?=
 =?us-ascii?Q?y+lKltz9S7ga6xiORYLX57yrwdtXe0HiH6rdHEPcQsvJWEWkqkIoCG+WEZvP?=
 =?us-ascii?Q?Cg8YOBV/Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4789953b-0c6f-4b53-d264-08deaabc919b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:40:00.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsHaNS20+x6Yj/x/Psw73/Kznz0dZGuXRzfYok5cbUka8lPp+Jb+l/MF6SPWqki3OfCuijz2C8p9xPzcKaPgtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7026

On Thu, Apr 30, 2026 at 11:54:51PM +0800, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-xspi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 385302a6e62f..037eac24e6fd 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -493,9 +493,8 @@ static void nxp_xspi_disable_ddr(struct nxp_xspi *xspi)
>  	writel(reg, base + XSPI_MCR);
>
>  	reg &= ~XSPI_MCR_DDR_EN;
> -	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
>  	/* Use dummy pad loopback mode to sample data */
> -	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x01);
> +	FIELD_MODIFY(XSPI_MCR_DQS_FA_SEL_MASK, &reg, 0x01);
>  	writel(reg, base + XSPI_MCR);
>  	xspi->support_max_rate = 133000000;
>
> @@ -524,15 +523,13 @@ static void nxp_xspi_enable_ddr(struct nxp_xspi *xspi)
>  	writel(reg, base + XSPI_MCR);
>
>  	reg |= XSPI_MCR_DDR_EN;
> -	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
>  	/* Use external dqs to sample data */
> -	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x03);
> +	FIELD_MODIFY(XSPI_MCR_DQS_FA_SEL_MASK, &reg, 0x03);
>  	writel(reg, base + XSPI_MCR);
>  	xspi->support_max_rate = 200000000;
>
>  	reg = readl(base + XSPI_FLSHCR);
> -	reg &= ~XSPI_FLSHCR_TDH_MASK;
> -	reg |= FIELD_PREP(XSPI_FLSHCR_TDH_MASK, 0x01);
> +	FIELD_MODIFY(XSPI_FLSHCR_TDH_MASK, &reg, 0x01);
>  	writel(reg, base + XSPI_FLSHCR);
>
>  	reg = FIELD_PREP(XSPI_SMPR_DLLFSMPFA_MASK, 0x04);
> @@ -1096,8 +1093,7 @@ static int nxp_xspi_default_setup(struct nxp_xspi *xspi)
>
>  	/* Give read/write access right to EENV0 */
>  	reg = readl(base + XSPI_FRAD0_WORD2);
> -	reg &= ~XSPI_FRAD0_WORD2_MD0ACP_MASK;
> -	reg |= FIELD_PREP(XSPI_FRAD0_WORD2_MD0ACP_MASK, 0x03);
> +	FIELD_MODIFY(XSPI_FRAD0_WORD2_MD0ACP_MASK, &reg, 0x03);
>  	writel(reg, base + XSPI_FRAD0_WORD2);
>
>  	/* Enable the FRAD check for EENV0 */
> --
> 2.34.1
>
