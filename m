Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0D200110;
	Tue, 28 Jul 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251698; cv=fail; b=BbOztr1bTXm674dIyinYkVLA97WNmRoWSEtJTb/J8HdRHmGT6qoIzfQXkbLrgTRtH+QUz1UvPRVm2FCEtsEKzTSp/oihp0fpagBEZqb0+7iZMRczrbTzAr6y4+amhb0Wd+/l+yNq4EL+bGYl/prHcwQn4L/+iyz/kWJY43Qk3Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251698; c=relaxed/simple;
	bh=HZzY0cD7f52M/YCgF10lqHG2MwHx2ON6vLeWby7LgB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjN18d7pkdNSBG+n+J3Lh15y9xcDUX9ZP2rZVAMBH2CwxApR0PFywqVAxtOamfxhJ+/SbM7JCxCEKBzBX58aL3HFfwloW88WvaJv4Fle8J6D0luXNqmmf14Nmh1oSxWTlxIC0kvwAWDcA6nGwX6QtfYt+dsQ9GknzoIsdwKeWUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YCNGP4EQ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YCNGP4EQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itzjAyUQaK5qdIj7luU+hNZvJwHH1s520pcF6t8QE0KD9WfII0U9QW2WNHcKIz3dKRtqEb03CAUM6MctNPqoxHJyWdDAgqFZVuxn+inpjR25xakc1Qz61azO1qBCffTjLPKDE/UTY83weXEOYIKcuUDL90PgUKldGlW9SS+rKX6U8j/XbKjEuFJ7YqAlB9krCjyZZt5TMgP9RLaUMAiFjhv82UGOxLcpP+SNu0z455GTKTCx5mi4MpsU7CaOV08PnD2AlBO4ow7yaIft5kQv+TXCWQlOLaRXVePmz/lVZ+4HT3gZroPYW527SsE40YBPf9mbFwdcMGoSwz7zAkTSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSIODw8IWvVGBG54A9O9IKhoH8a+2HHf+dFPiLHkLo8=;
 b=zVM6miRNHqm1CrKhjTMge/rrHEp+9Wor8qkVJ30B2U581Ogg7RJ1/zSpG4h7rTJO2k2evRM5MFVaW7zRB8X9yZV8SSTT3Hb1APQ+gPFePRo9D2pWgCIWFxPZ/Yxvx105+b5pfgdjFdV336bms8L5uURjG1ZFQHeGFK9CTv+rnuWOTS9FJAwu2Bza6L4GU51a7CPxHYR4YBfpnDHnJ6Ofb0KcAGaaFu4+BBICAdWG/YnivBYkx2J3ZkDpkvrpo0ICsG8gmgrn8P/b0fEVRJtvoxc1B5r9I/WB+GWerRBteeoHJzlbFsLsWHf//s+VoreWXVPHyLme2VEwyEomtErmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSIODw8IWvVGBG54A9O9IKhoH8a+2HHf+dFPiLHkLo8=;
 b=YCNGP4EQ9cKj8iQpYPHtgUNHSKx8uDq29r70NoARpP5/Zlwr6LW+zWqvc+EiqsddCoDWr0BG79mWOgPV4UGV5RNm2TbOXD79ey49b6mFpscmNas487rq8CB4Qw8ghVND3b3lcdqpP9Z7mps4tYlR5KfU2Bk4NFmz/NRgnBIgVLla2Mtyic6w2kP48vCFSuvAf45fqQMsANtJR9Xser6QnctPUqpizT61bwe5K2JF8oRKZherU1UHePeH47dft9HLNwfUcPpO5vjOIVigJEzE4d2OZJ0jdD0u0FlDExWqplwABCcFwV5cpPp3peyJ921qyIfqPqa/GTOI4O4sk3omXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10173.eurprd04.prod.outlook.com (2603:10a6:800:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 15:14:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:14:53 +0000
Date: Tue, 28 Jul 2026 10:14:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: haibo.chen@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 1/3] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate
 limits for all supported SoCs
Message-ID: <amjHZH2VdhueF7e0@SMW015318>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
 <20260728-fspi-clock-v2-1-dbe786a4a6eb@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728-fspi-clock-v2-1-dbe786a4a6eb@nxp.com>
X-ClientProxiedBy: PH7PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:510:323::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4a8a47-4067-4435-6c39-08deecbaf982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Uwvi1Lw8AVmhiGRm8nV6D+/Qmgre0WFfWWGh9afmkftiDnq6H1jAE2YRwQgLE9DD1nvZTpNjx2IRMqRhHNfOq83THAyDuKUFMDGMZpKbn4iyXbrdvz9B5/3O+kSP1Vq8jUV2Vnhhs6PQKX5A4u4K1fHQKtG4puICcQBluzBieyDHMyFGKjLr7l6Yq9axrVXmy5Fkd5Ab41qWjkzAwQNhnoT6LHb1p7T2WUvF0QigPfuzejw0ZVFmAHlnWkw63fxBZ3ghk0PDrg/qVB0DkSy1l1F+4UKsRYsG6SWA66y2GZTkbyQ7/DUMG2pu+Q9YZGPSUVu9aiggQhGKxywKDgbxdYwNFiVxqH5e3J/8UzzhX9KmdNXqbvDGkjrJRVvoWrfaeuFjS4+gS0r+LXnfEaP5cneax4SGPr355ChkOtAYajZJtqkibV93FJPJ6GwTfgDmAmfpMva44o+ekxz456rKaEr1v78tUmNQGueERuCdV05dmhlI/uz8S3/87Ep42jU6joHkppPG53UL5iG8ZrGJgfG4Rwn2n8Ma5O7w/c+iJVGr+V56vqXszLxBtBt26kVeD85vBPLfhNwqFAJYcZjJ4jQKeSpWZDubRGMLibREbSKMSOkjptJUv0o/QBUNej0P1E4GfEu8FTzwiKkajK6AUeajGt744GRTepFQh3nYQPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VpUnDW2bxBfcs5CB84RUBkfMm/TLf0PJhjANSg1wNOBlECquxDI0gyuppp?=
 =?iso-8859-1?Q?1HQ1Mlqb/kQcbnOlQgdo3mdJ9t1qc7fGyypzdNdKHkeYkI3Lzm/PE3eiTm?=
 =?iso-8859-1?Q?5Q5QjqupsPBd7bBVJtcInAX5wEd2xIIK/P6+F3sh9zP3v4EnDv4MlN2v9W?=
 =?iso-8859-1?Q?GC+VaM7Lag92oV6AS9RZ6jjp6siFKDepq/vc5yLyk5xKpNc1LuGpOM6kui?=
 =?iso-8859-1?Q?4GPRmlJVyTpwIh3oUceoPHnTHYxIfzmuD0HfZouH8tqu3W5OCtcc9JzlR8?=
 =?iso-8859-1?Q?WFRtBMObYszovC2VlRmZp7BExNvhU211Ht6glPx57EFyysjt0l4qYyT2ZV?=
 =?iso-8859-1?Q?6igjUpf8x/0zoBfAU8ntCK60yio7iqKf4huVGcBrpJD3+WESSyr9tTEbYl?=
 =?iso-8859-1?Q?tFXge6rqAPqFLfcMc1/l7VY/vpb+WpKPGx+NzB6RsMNore3+pDJ29tI0vG?=
 =?iso-8859-1?Q?iKWZwbZVwqAoXOJs+GN3u/s3i/zdSHLzMrOlwROVrEghxzlFThThpJVq8f?=
 =?iso-8859-1?Q?UpoYZhB48OX4P/nnoEwELy+q5wNyVu+J5ir27UzcVUIw8y8I5IKjnvlENw?=
 =?iso-8859-1?Q?GGvm3ksvqiOle4Q2CSxYv7KX3Fs0X73bMMLwLGEiNVKs89+27adWd2NPiH?=
 =?iso-8859-1?Q?SRpN1CRS04pojhAVrEHDkPXThcB5vAwjB5usfU56POdW5ViAuNGR3oPH3f?=
 =?iso-8859-1?Q?2JqiMlPdkokdM47gDyLZe0AZsfMN6x246mJfIW3MnmFRPYOVCJXHgPGeCd?=
 =?iso-8859-1?Q?3iMQMMuZ8M9IpWD5O1AyuY1tqMixm80B27RRFxSTjBpxPh2WZrGeFnzDA2?=
 =?iso-8859-1?Q?OpD2Xc+ktfLwLdU5DnBsRnbr+0Wn60YJ20iv8orw7zyiReZfOhOipnUnP7?=
 =?iso-8859-1?Q?MarmI1EsMht+LEJFBTKvg4+0rePHi8GvAx8+SeCK40MqJ8JW9nAau2A7JG?=
 =?iso-8859-1?Q?YRF7Ni2qhEinSPa3uDmALpXklJJu51W3nPObLSepe95wLFWa0yiDhxGShr?=
 =?iso-8859-1?Q?xDxLKGPstjbsutrOraO2AcIUCgClPph0AmD6UbNQiaE5eIaBprQcuqf+C9?=
 =?iso-8859-1?Q?JADqRUZPxAxKcPXnO/tOvFPtLOTuHjKX7cX1Xvlk0D+e/FERL8fT0ajl3j?=
 =?iso-8859-1?Q?C75r0AyuTJZVn3uN0sOG0eNcAAp3IJfc/mO0ufDm/nxdMJEqCUhEpGJw6R?=
 =?iso-8859-1?Q?LyzApgCBPVpnBAHySy/2ybf6kekHbeU7by9+mUw216znpER16tA2CTSCJz?=
 =?iso-8859-1?Q?kUnpXZ2TTZysjQxrLHY1N4XGo6pLVAF/SU3sWShWZUlkZ/GlVo6/buinaL?=
 =?iso-8859-1?Q?qjDayfNHM0mTWe20d3Bk1aIvlby4uIFsWVwOGOtnAGonUw+2Yz/+KBLccT?=
 =?iso-8859-1?Q?TrYyhX8SKWiGvkuHTDIKyUaGiid099GyxGaUZoHToeXNzb4nJeiq5yXuCG?=
 =?iso-8859-1?Q?oRihTh7IeacbIHRLqvrJrzb083hc+ogfiu9rClFgHjEPvUxy0hEsj78u/h?=
 =?iso-8859-1?Q?wi9fu4bTdmRWdMqcOgmFHiYBY0kyx0LBrT1NkZc/A3YnTlRE3Pu5HlSqaI?=
 =?iso-8859-1?Q?msL+RiDGyy6Y1fm89HgWxtMMQyoKgLlVbf7Gh0UuWu3/z/OoPKgivafv+F?=
 =?iso-8859-1?Q?oCS5vwIUiUbRZCBoapUUAg0Fw8KuvmheZAud/jIbUQptZtFvdM88GFErv2?=
 =?iso-8859-1?Q?zMW6FqX0zP8IZX+Ud16GDT/gqOWRdqsjMHzelCs59EA2cXE3eXwP2coiia?=
 =?iso-8859-1?Q?P/5+VfkzX3wEgU5zm796Tk9B+zWOSt3jXTCwborJ2U4dCgG9T6ctqaWkOF?=
 =?iso-8859-1?Q?N4+/jyPmVmbuQ3Ee7+Hn1RYpP6r+cY03z85UuGkNH9JRLW7AeXqQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a8a47-4067-4435-6c39-08deecbaf982
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:14:53.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukjuiGsNNScP73vNLgjO34zOihLKoPWFc2DKfV1AO5XEOSsaeU2xXGLGSVl2Djb0BTq3MNnB+nTSvqJV5YgFjTG8hZIX/CjiZlfnMd1WXh9NS47xeIKyKbTtAPHtTbmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10173

On Tue, Jul 28, 2026 at 06:18:08PM +0800, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The commit f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for
> different sample clock source selection") introduced a global 166MHz
> cap for DTR mode (RXCLKSRC=3), based on the i.MX8MN datasheet timing
> specification (Section 3.9.9, page 65).
>
> After reviewing the FlexSPI timing parameters in the datasheets for all
> supported SoCs, the following corrections and additions are needed:
>
> 1. SDR mode (RXCLKSRC=0) limits vary per SoC:
>    - i.MX8MN/MM/MP/95: 66MHz  (IMX8MNCEC §3.9.9, IMX8MMCEC §3.9.10,
>                                 IMX8MPCEC, IMX95CEC Rev.8 §4.11.7)
>    - i.MX8QXP/QM/DXL/ULP: 60MHz (IMX8QXPCEC, IMX8QMCEC, IMX8DXLCEC,
>                                    IMX8ULPCEC §7.3.1 ND mode)
>    - LX2160A: 100MHz            (LX2160ACEC FlexSPI timing parameters)
>
> 2. DTR mode (RXCLKSRC=3) limits vary per SoC:
>    - i.MX8MN/MM/MP/ULP: 166MHz
>    - i.MX8QXP/QM/DXL: 200MHz   (same FlexSPI IP across this family)
>    - i.MX95: 200MHz             (IMX95CEC §4.11.7.3.2.3 Table 106)
>    - LX2160A: DTR disabled      (FSPI_QUIRK_DISABLE_DTR)
>
> Update related platform data with correct speed limation according
> to datasheet.
>
> Fixes: f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-fspi.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index d94a2a7b98d44db217ba96a8ce7df23e37a08ba4..6de6d432cdcb2ee383a02d72f20000045903e176 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -340,6 +340,18 @@ struct nxp_fspi_devtype_data {
>  	unsigned int quirks;
>  	unsigned int lut_num;
>  	bool little_endian;
> +	/*
> +	 * The max clock rate (Hz) that FlexSPI can output to the device
> +	 * in SDR mode (RXCLKSRC=0). Defaults to 66MHz if zero.
> +	 * Some SoCs (e.g. LX2160A) support up to 100MHz in SDR mode.
> +	 */
> +	unsigned long max_sdr_rate;
> +	/*
> +	 * The max clock rate (Hz) that FlexSPI can output to the device
> +	 * in DTR mode (RXCLKSRC=3). Defaults to 166MHz if zero.
> +	 * Some SoCs (e.g. i.MX95, i.MX8QM, i.MX8DXL) support up to 200MHz.
> +	 */
> +	unsigned long max_dtr_rate;
>  };
>
>  static struct nxp_fspi_devtype_data lx2160a_data = {
> @@ -349,6 +361,10 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
>  	.quirks = FSPI_QUIRK_DISABLE_DTR,
>  	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * LX2160ACEC: SDR RXCLKSRC=0 max 100MHz, DTR disabled via quirk.
> +	 */
> +	.max_sdr_rate = 100000000,
>  };
>
>  static struct nxp_fspi_devtype_data imx8mm_data = {
> @@ -358,6 +374,21 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
>  	.quirks = 0,
>  	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
> +	/* IMX8MMCEC §3.9.10: SDR RXCLKSRC=0 max 66MHz, DDR RXCLKSRC=3 max 166MHz */
> +	.max_sdr_rate = 66000000,
> +	.max_dtr_rate = 166000000,
> +};
> +
> +static struct nxp_fspi_devtype_data imx8mp_data = {
> +	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
> +	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
> +	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> +	.quirks = 0,
> +	.lut_num = 32,
> +	.little_endian = true,  /* little-endian    */
> +	/* IMX8MPCEC: SDR RXCLKSRC=0 max 66MHz, DDR RXCLKSRC=3 max 166MHz */
> +	.max_sdr_rate = 66000000,
> +	.max_dtr_rate = 166000000,
>  };
>
>  static struct nxp_fspi_devtype_data imx8qxp_data = {
> @@ -367,6 +398,12 @@ static struct nxp_fspi_devtype_data imx8qxp_data = {
>  	.quirks = 0,
>  	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * IMX8QXPCEC: SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 200MHz.
> +	 * i.MX8QM and i.MX8DXL share the same FlexSPI IP and limits.
> +	 */
> +	.max_sdr_rate = 60000000,
> +	.max_dtr_rate = 200000000,
>  };
>
>  static struct nxp_fspi_devtype_data imx8dxl_data = {
> @@ -376,6 +413,12 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
>  	.quirks = FSPI_QUIRK_USE_IP_ONLY,
>  	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * IMX8DXLCEC (i.MX 8XLite): SDR RXCLKSRC=0 max 60MHz,
> +	 * DDR RXCLKSRC=3 max 200MHz.
> +	 */
> +	.max_sdr_rate = 60000000,
> +	.max_dtr_rate = 200000000,
>  };
>
>  static struct nxp_fspi_devtype_data imx8ulp_data = {
> @@ -385,6 +428,29 @@ static struct nxp_fspi_devtype_data imx8ulp_data = {
>  	.quirks = 0,
>  	.lut_num = 16,
>  	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * IMX8ULPCEC §7.3.1, Normal Drive (ND, 1.0V) mode:
> +	 * SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 166MHz.
> +	 * Note: Overdrive (OD, 1.05V) allows up to 180MHz DTR
> +	 * but is not the default use case.
> +	 */
> +	.max_sdr_rate = 60000000,
> +	.max_dtr_rate = 166000000,
> +};
> +
> +static struct nxp_fspi_devtype_data imx95_data = {
> +	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
> +	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
> +	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> +	.quirks = 0,
> +	.lut_num = 32,
> +	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * IMX95CEC Rev.8 §4.11.7: SDR RXCLKSRC=0 max 66MHz,
> +	 * DDR RXCLKSRC=3 max 200MHz (Nominal/Overdrive mode).
> +	 */
> +	.max_sdr_rate = 66000000,
> +	.max_dtr_rate = 200000000,
>  };
>
>  struct nxp_fspi {
> @@ -691,10 +757,20 @@ static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
>  	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
>  	if (op_is_dtr) {
>  		reg |= FSPI_MCR0_RXCLKSRC(3);
> -		f->max_rate = 166000000;
> +		/*
> +		 * Use the SoC-specific DTR max rate if provided, otherwise
> +		 * fall back to 166MHz (limit from IMX8MN datasheet §3.9.9).
> +		 */
> +		f->max_rate = f->devtype_data->max_dtr_rate ?
> +			      f->devtype_data->max_dtr_rate : 166000000;
>  	} else {	/*select mode 0 */
>  		reg &= ~FSPI_MCR0_RXCLKSRC(3);
> -		f->max_rate = 66000000;
> +		/*
> +		 * Use the SoC-specific SDR max rate if provided, otherwise
> +		 * fall back to 66MHz (limit from IMX8MN datasheet §3.9.9).
> +		 */
> +		f->max_rate = f->devtype_data->max_sdr_rate ?
> +			      f->devtype_data->max_sdr_rate : 66000000;
>  	}
>  	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
>  }
> @@ -1457,10 +1533,11 @@ static const struct dev_pm_ops nxp_fspi_pm_ops = {
>  static const struct of_device_id nxp_fspi_dt_ids[] = {
>  	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
>  	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
> -	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
> +	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mp_data, },
>  	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
>  	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
>  	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
> +	{ .compatible = "nxp,imx95-fspi",   .data = (void *)&imx95_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
>
> --
> 2.34.1
>
>
