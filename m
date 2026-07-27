Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011C23C4F3;
	Mon, 27 Jul 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164395; cv=fail; b=aGb0Pz77sV7OpnzE5+g84d7gl939isLaZkr5CCVnC/qJHeISH0+dycBx3S0iMwsIn9L9UOQN0wS+d9pOhuLo25b5VnP1Wb7j1zWcA1PaQ6EgRAbJ8JKSAE1tQC79BLTIy0XsYdrzxstQ5KZ3samA7bcOAqtnPDLr86dqUkeHwiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164395; c=relaxed/simple;
	bh=qEXW7TW261nv5ClwcH52sbINAMsjZILumhIMgdbsMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GNJNgUvsPJ0iRpsjAbF8Uw+FhYQ6NdFCNCuxcg1z1S4ksaGwXEgFLfJZCrWC1G90ghi2VOfbY7+nI/G10kBTM0tR/5R3Fo2M0NwxVm1NID8WGKF+J/eSVWyOnxTnTMmg0qcxkhwuyteN5UMdxPTGzTB/A3/FCficcOiYs7hWzhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jNpo0MaI reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jNpo0MaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZoET0b5csgNtKGnTt3JFcHuds8maUNQ0k+hXfJiRq5pSAAjBxq80wfr8ad5DS7c7bNE7HQyB3/7GKbUUxClWWmQuAN41QoiekYlvV7kx7tLnqIYBsod/TjI0X10gtEqL5x2hO9ngQ6sQOxH7r/capGAoSrXnjwNr/ygYkhBr2YZX2xYQjupB7YbNLjatu7ndDLZTqsjpJ0nPQZtNDsUgeTIv00AB6q+5+tCSN1EmrOL7Ig5lj1B2IIiG4Cp8hbaRp8ju2ORnGqZmWoaCgZ1JRPS7tIa81XxO0ZKCQL1uunAuwmrOj2cIOHj4FV93bmsv6kIpnIQd39ioJKw0N/VsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nRXScR2K+kyU5p9Uut3Z5zHvlLKz1cmO3i06sddZzU=;
 b=L+tvhZumlFkTczi28OBF3fe1meBU2QOnBT0eGr8iNlE3CL/dwxPckC7ktP8QqW6pyftK6IdxApS/EaeDx9zj6+UYPfhHzYJYJWMhLt5bnUZfLlkNKdf8FvL3kbGV27phWMD7rieD6vPkhRhiLw+w9okFGbIKND7mEp1YdJa/sLcNP1+9ahgWZ0fmT/+A3SAuJaFxFJ1yyW+Hmf+A21zTVASx8zAX2PuoFyGCDBF4Hio7VJewFKSUUreyo6kZuxEyL/3CQVqHh/jhKBVdvgT/OtGiIdaRh3A9RradieTu4OlBzaFsDYJeRz8lTR1KDfvVs30FHwGsDO3UOtc14D2iYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nRXScR2K+kyU5p9Uut3Z5zHvlLKz1cmO3i06sddZzU=;
 b=jNpo0MaIG5HXJFeV51vlouJVYkuqxVQZUmGpJ3MW/ELTPvnQkEiPnyHy255R0VTPapl25VPW+x1uLfbpYwB4Qj3fywovdoJ17J8sF8aSu3vsKW5LTmyDATK4jPsukpwinXRhX/dYgBWbt1BgKjVneeuJTkWunt1IqgmfLpE0BSWreb+aZXGian95q6IgL/xibKvW/ZWsnxNNqpM5mCcNR364aTBgszKRUi7BymH6n5OIbiq50WHuwNYdMfMDTOk98BKXw35+F1dD5BT2lXWAB9PNUcfd9JnzsLgh1Sv+FDRtTZ6VoiuqJu+CVULwll9YFQOlw5QVPOehMS4jKTXmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11794.eurprd04.prod.outlook.com (2603:10a6:150:2e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:59:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:59:45 +0000
Date: Mon, 27 Jul 2026 09:59:38 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: haibo.chen@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits
 for all supported SoCs
Message-ID: <amdyWjUhT8HpHCCI@SMW015318>
References: <20260727-fspi-clock-v1-1-f4f3be6c366d@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-fspi-clock-v1-1-f4f3be6c366d@nxp.com>
X-ClientProxiedBy: SA0PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:d3::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11794:EE_
X-MS-Office365-Filtering-Correlation-Id: c57c3aed-6e45-4b8f-b7ab-08deebefb254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pYB8x3+72DNaTJLFgBYpJn6dS8P0WnUgar0Xk9aCKYhCC3sqeH0eOnt1QFjwwPqWWOOXWRYd08nUSrtGWpiWGaNnVDYRdGpZ4VoNFkfJQwgS2LpF9QX3wqnYEjRoFQlWmVY+X1LwTNWwIRJG92jTretT0Engz31O40KHwLD9JUqSijPqEMC8ahVUzpL/WoQP4Ge5uSe+YUzxK4rLAI/iRH7sw7LqIszpe9Nv2eiVN1QlAWWj8YZAbTPJyM4vWBGQwKfqj96aocsLQCr3b2GYmALyOj7rrgQF7zPlWLDWQ5AU6/s44oQRMRpBt9Rw9EZY5QLsrKZo/EH0a8FFpNiRhiJnAdjwBi9ygLRTTzZr9MNq6P/H3RN3iBowK0pghvf75QP/2vFsSNag7FcrqWcuA4pAZW66phlVGBkPkQTdFy8ed2zIZoUpQ5Tt1MQunwlor0VVh/qJRZz9ESONW5JqNS3dVibyFg7ggACdD50Umdda0vO1lG+3i4QgwPQw6cKQ0q9pvu/TjuSqZEb9UjLJHGYytCLrlmmSKAwOH98udkydIbUREEtFNZQrJA+/5tWoazM4XUMZCJmwsmdKKS5zsMiXLa+eN2Ckupabh9NDHc7PJWenVGFdGEHM4Kkd31r+jjbfwL12MjjP3kErvS8kjlzkU0jL4Mrez/Wz/9naV1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?E5CTco5p20Yk/ovMw+QOqv+aIfxjrwQpTNr2gjft1oI5DoFLypDuG2X6r/?=
 =?iso-8859-1?Q?pgLDWDkCEbUeGnwBPLsDl+IdndGqFexCa1caTJ8QqvsrsUsGEPhuumTZpj?=
 =?iso-8859-1?Q?zl9bm3zwiwtfz5NEB2EUzhBCsN9OAVGFaMaOTmcjo4blT0iYhPocTccIQP?=
 =?iso-8859-1?Q?M5037H3Vcgrybrz0kn6hzbUYJujG2XkbYCB01wu+cK1ihQEkm7A1vL5g6s?=
 =?iso-8859-1?Q?gcFUhtQY/wSszuYAGg4uv6w3bhIhEc+/UkXOomcVK0ZMNYwsG58VMVi5e6?=
 =?iso-8859-1?Q?BWzyzUcq7ZsuBF9QFxjModFHTY/dRRHiMeLdl57Sx3Y1+AU1dKAZIfDgnc?=
 =?iso-8859-1?Q?x3GM9674Ew/z+IYH20j2rG8+ihe7D1sQ1XRkjEX7FMreaDe+8zhYC9XiCJ?=
 =?iso-8859-1?Q?N18YyP6QDWL7buq51EdS1zaBromNm7KR5XPTxCaqf5yR9VikA9peilD3Sh?=
 =?iso-8859-1?Q?qSc3DFcEKF+WYiVHa8uSbu6nHzCEJohquvzsyeC77KRempSQ0zTxX1c4ac?=
 =?iso-8859-1?Q?yFkhFmlyn35v/p6tY+vNVIfGo+mEVIncA/dOw8xuKWCA9YFHBrzyyVEudb?=
 =?iso-8859-1?Q?qWJt+mq8NudpKy/CObNciD1mZcHhEkhuyh+2uOQ7PuWtz2GbLmkSVux5/p?=
 =?iso-8859-1?Q?7E5iVTOz8ra5EvD67Z1p/bHilXQ4po7r4ZAxc3ayVu+4PFB6RAov/iEksN?=
 =?iso-8859-1?Q?+QWzJn1Uwii8F0gpuNF4xz6Rd4LX9DETPVLWvM7hlby9Hb75eNgdphBtul?=
 =?iso-8859-1?Q?qBGo+XvdPktXgJ7T1ZtwrEbP+MLOMO4EgD7wekNsRu6ZaQTCLl/GMgsrgi?=
 =?iso-8859-1?Q?9DsZYZWLG1NdDfn2j56LxkMy1+fv7HIc0cUsQ849iPzyn/oC2Thz79aPGy?=
 =?iso-8859-1?Q?eLn0TK7fK2qLmlk2WiUjdlKCfKzBzLKnYsx5nZKQQcvHUP9T5Y20Wtbqtg?=
 =?iso-8859-1?Q?IEJOKZo0QNE3lxUnHuieEt3RefpDjOufRxx9L9rOQWFiumyByXsi6MCZsu?=
 =?iso-8859-1?Q?peAPLEtL6SlbrCuKmZFYetVzhq5mthToqiPlJHZIavXPMTibgZriAO75GD?=
 =?iso-8859-1?Q?ADUNtCOLkjwMyKdvzeZk9QC+g/FkKELsjV7ztg+0dz1ufKmCBk1Tq9EFeg?=
 =?iso-8859-1?Q?VTwXipZ+kAAMUHQ5sNN+L4PTgnmqj4efQ8vt7sU/3Nb+KArTEe0tYm9tBG?=
 =?iso-8859-1?Q?QOE3tHQdy4TXkhkiZyWRWK0oTY1xKO8Q2950wVvdPozlAm0RUd7fZ8MD9F?=
 =?iso-8859-1?Q?DOwvLUASuBBGvcC3AvHT9N/RSNgM2b01eagM/E0qNEh4EYqxPOjLTqgRyr?=
 =?iso-8859-1?Q?q3lv2HVjR8t4nD5nGRKdY7tYIij9WJOUhyXsDnHdl3Iho4fwsXozz5Wj9a?=
 =?iso-8859-1?Q?3F3Z4kDkNRS3oEw96wXx/inEs+9IaPGkjk0hsRzEovo++FQ6T8wtyz/mGK?=
 =?iso-8859-1?Q?lr+OVJDQRbv2i8nopv0/PHgPO+LqWTu/kGCajHaaWdqZeGGbM39bSMHQ/E?=
 =?iso-8859-1?Q?ITVJ6/EQl4ZGb/3s9iYced7SnfzjPnjEHmDUaeQCck0ZoMQThAyyTUYOU1?=
 =?iso-8859-1?Q?PPaxoSHDECVrWYyDmQpURc96HupbvRz8I9DfkXuqvdiyGon2qcwNgg/Pa6?=
 =?iso-8859-1?Q?KFH+LlKL7KDkFmm1AZuhIgINuFOVYnj+ByhQftcbmrYPcKmG86fj4LxTYv?=
 =?iso-8859-1?Q?O1OHi+UV3wdA8Q/8MeOWP1QErmG5liLRf6ZY0hqzX7oiFVKadpQSjhhga1?=
 =?iso-8859-1?Q?xCzxbk/8oWSuA4O2vMVc0N8ZpKK7xaYiVLgImrZTwoAgWH/DeXd7KsAoFf?=
 =?iso-8859-1?Q?673vU0lnZcWoanY0h0RKfNPIre45BF3+9SqVZT+9sWVLbk79ikj6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c3aed-6e45-4b8f-b7ab-08deebefb254
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:59:45.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhWKl1IM1oeTejp8iDgJHnw2u7yvbZjjTUR0a1RF5DIXA/A8DETpSVNPT1F45oWSAIkKAx/ivbXGABtpaqRPHL5RCecweRh5iAPpIDFVckE9qWJ1oNTctNmQmLIxP0gJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11794

On Mon, Jul 27, 2026 at 05:08:47PM +0800, haibo.chen@oss.nxp.com wrote:
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
> - Add max_sdr_rate and max_dtr_rate field to nxp_fspi_devtype_data
> - Use per-SoC max_sdr_rate in nxp_fspi_select_rx_sample_clk_source(),
>   falling back to 66MHz default when zero (preserves existing behavior
>   for any future SoC entries that omit the field)
> - Use per-SoC max_ddr_rate in nxp_fspi_select_rx_sample_clk_source(),
>   falling back to 166MHz default when zero (preserves existing behavior
>   for any future SoC entries that omit the field)
> - Add dedicated imx8mp_data (previously aliased to imx8mm_data) with
>   explicit frequency limits
> - Update imx8qxp_data, imx8dxl_data with correct 60/200MHz limits
> - Update imx8ulp_data with ND (Normal Drive, 1.0V) mode limits: 60/166MHz
> - Update lx2160a_data with correct SDR 100MHz limit
> - Update imx95_data with correct 66/200MHz limits

Update related platform data with correct speed limation according to
datasheet.

You already list frequency at above 1/2, needn't duplicate these informaiton
again.

> Note: i.MX8ULP limits are specified for Normal Drive (ND, 1.0V) mode
> as this is the standard operating condition. Overdrive (OD, 1.05V)
> allows up to 180MHz DTR but is not the default use case.

Move this to comments.

Frank
>
> Fixes: f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index d94a2a7b98d44db217ba96a8ce7df23e37a08ba4..1159f5fc8a3a69eb464f32fd92e283e84ebd67ab 100644
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
> @@ -385,6 +428,27 @@ static struct nxp_fspi_devtype_data imx8ulp_data = {
>  	.quirks = 0,
>  	.lut_num = 16,
>  	.little_endian = true,  /* little-endian    */
> +	/*
> +	 * IMX8ULPCEC §7.3.1, Normal Drive (ND, 1.0V) mode:
> +	 * SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 166MHz.
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
> @@ -691,10 +755,20 @@ static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
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
> @@ -1457,10 +1531,11 @@ static const struct dev_pm_ops nxp_fspi_pm_ops = {
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
> ---
> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
> change-id: 20260727-fspi-clock-adcae0c35283
>
> Best regards,
> --
> Haibo Chen <haibo.chen@nxp.com>
>
>
