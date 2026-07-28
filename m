Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF094570EB;
	Tue, 28 Jul 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251810; cv=fail; b=SkL2FmtkQqYrFDMw2OOkeNzYo4L68B2C5BYtAihGgTmV06Oh/Lym3dA4QvihKa8HzdNThjqSaISaxfKH0J10ovMD9/Z3jfp1rnM1uH4ZRTGTcdVGeNAaPcQDeQULdg6v/74bdfVDvCUp6Kx0PaewlX4xWb2/iPB1hp+jJBLWFtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251810; c=relaxed/simple;
	bh=XlZCX2orAG9A7CaHiGc+AadKeWMD7s3uC/dtTUezOIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LES7aFxisU7ozR6/GRvnU5slq3mE726lQAitGrVjK18I5ivEjoWexLuJL8/BKh/+OLFtA5nzQpM3hBo40oOeDzDIw5VFjNKXj2GE8H9eqDKBoo96qkIgHMjNeUwWBtSjPDNU6jqO0BmGFm7Nc2y9kEmwEU38TcZsWBK6H5FOFh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IqQYWl4E; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IqQYWl4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZK9ZsORIz6NJNmk/NqjfWuXo4N0Io5ndm7omnkok9aJma+ejc0PuLJerfVmZ4pIaLB3tDNLTfz9iauJSF0qPrUixAqRDNE6cnWfK+6opJe+9n7Ch7ve0UagMCH7Ls4f2c1kXmQCy3ivdmZBGdslbny+PDKO65w32lTi/MRY+cYsR6GdvA8RaU8jlkBstM0bdbCFTSl2rccsNdpLs1V9PiDUIkaVC2LQwI+QTupKUywJCl6aIh5rNqPwGk77UKno0EmM7KDdqAvTREYDtb9yr5r+P/RqjASk+TkmOs4nVyslRRrJ9N4H8JGoeU/Ps8DHWVU+AkqOLvSN7qm9rgzHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSIozhHv14vivHjD1Ub85YRscU3C72z2cLQQO7mk7Gc=;
 b=Es/dgtuj52nA6+TA2TfR5uh4mhwZVBOLlztTCR3v626FBsXd1SSLE8W6SElQZD2ygTw2A73yjJdaRi++/v495GYHRsoMHMSvc8VQiVhyQk9HUYW0QYPQtYo4I0uqWRE4zCHpeB5Y/YaWNAGtF7fDKa8ej80TBd4siipjn3gdDK5Vg/aK589PYor028ButzCe0+KUvXgzGkVmni6sWPAHw/wKFbSdrx9J/fKq4rcikSWcdvxbVH37SRN/dsEoU73rMaRfMN+Nyo/raiNU3PM5yZKHxxaaYIyGQ3frq81VR5cPK+CNDBS9y4hvKXWsafXNE6Ry805jnJDLwyRiP5nMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSIozhHv14vivHjD1Ub85YRscU3C72z2cLQQO7mk7Gc=;
 b=IqQYWl4EUjF4v/8Zoam7flBJaTQStisnAwhpSmg2HWK59JxdLnG4MHHVjcR/uqGCD2Y/wDWlM8b31uP+kzQertg79FDIx8zrC4AUXlnOL7qvv3bcEwE+jpmzunHW5FTpOmwN82VdzSUlSboBl0fIDzoEKvq0AQcceuoytbPsbekKtAV8nZwLcwPu7RpWCxI8wJqPRjl7fF5s1P3cyYwED/Rcvek1fmX3FAYkJtI5xoFhmOeT6v+05yTzwglXb2BychXc+BFTY1+YuUomvlPVNTkAjtk93ChTh52w2bgUjPQtAUq9XSIeUq6SGeHtj0wlN4aufur8N2aqpKXpkyrQmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 15:16:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:16:44 +0000
Date: Tue, 28 Jul 2026 10:16:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: haibo.chen@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Message-ID: <amjH1P7Q6tZkEuoL@SMW015318>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
 <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
X-ClientProxiedBy: PH7P220CA0060.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 29711807-8af4-43d3-effc-08deecbb3c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|6133799003|56012099006|11063799006|4143699003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EdngNG67Yrp2YphMYb3SJY6YVlJLC1THvd9vlaVp65JBLr3JpIvA1ZmEkwa9YnFynYmPBL8Q46xArdHoQ03Gj5atCEK+jTu4Ze3EeMMxcJtQhijqCEnonp+HwJz8mMuMMrodHlhPcE/LPPwoLD1jjp7ID+ML+H1VdKhDXSfdkgMC7Qo+KhmEsPh8bvDPc6CubjiuiK5vHIBCOS3ps4kl8SLBHwYDpACDfitdHwTJ1PKJ+1l0F06ng5TNtXdfUpvNAhTXqc+oCfol3fyeAxaY8/5PWmxCoLc4LSJ9+X3+XElb9g1Up9u6IHIFzaH6B43S/ZjkE36I5OfXveUIVH8dg9YD60WZ4MWX7WN5N3ABU3KqUGg5G6dHnkoL5KmYI3ZnNGOtA6TlxWfNZA70NVuhL6g35GEdcpvOpGBXV/o4DgoMcohK0jyf3Hb7z70Me3qZ1kX44OV8qP9j25TaSMB+Gzs2JFPiCHJ3Z36XBAz07eJmRIgGc3xvKTwxOM0bvUc55oxcGO76XE9Cqf3oq16N/zRYEDhXKN4FApfVjmuXYITppSSorkAnkpEWfAl2kYL5iXfp8tqZb3ddNUcPTEcTmHrg+wGrHcFcWKqnvDxdunXZAYZU3VrHc2ZG6icMvi2qDC/R0rTi2Uwfs2RK3URB8Psv/Y7+IVJTlf4QVLXpgWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/OY9O230XTz4/v4ldEWw/XJ3UczCE6+EbCR81Xtjnpu1FDenAMSZCBUSrNq?=
 =?us-ascii?Q?nioZyRLd78ftUKfVZWH/Zlyzn5Bgun/yXPGkY9njpI5srNWHdlMkRe5fhsgN?=
 =?us-ascii?Q?8tX3jCtEpmyOCcKB1DvWELT68+3F9cwVTnoPq8yAgoVQJdyklmgL+kt8a49/?=
 =?us-ascii?Q?b0qKuNWfskR8rg9D+3xd+FArW3jA4mDjSVaE+SEgbnURswDzE074digXTI4f?=
 =?us-ascii?Q?FL8Ij/Ek8nk5rFztVcOqHtCkhWGXoOtSKNW5FAdlnexPtShQTl0aHqJOrZef?=
 =?us-ascii?Q?YPXbSdnWrKQDkxm1hwFjY6YSbirmMT57Wa3ha3ldhUKjnpXL8DII1Y61V+cB?=
 =?us-ascii?Q?+4WrEQ0xY6qea4eSxH+4r3wb6PDzoM7bwyqc611XzsJqunfm+W676gHAWamH?=
 =?us-ascii?Q?rnVMBHxYcfyn4Lpscpm9fYG6hLpQ2yGguVrTWgItRO44NJx3qsUI75hSFvrj?=
 =?us-ascii?Q?SZkbDV9/iFJHY7xJCCuv5ml+ecdvSLRFRHEBrq+uXxvqUDxbmjvENpIedctN?=
 =?us-ascii?Q?ZDyoVD4P2OGyTSog0ICivEClQuGQdaaWkQj0IW0lHFv88AuoS1rDoOr55jU2?=
 =?us-ascii?Q?IDo8c7RlXZ0iBcCkTnN0TWd6GYz0GNPEKKhpaU+zROl5LK7oFHz208cBDCG4?=
 =?us-ascii?Q?8mUL6DMmhJUcX8fvx0OGbqME+KxoGAKxf9xLgBp7/yvWhqYjOCAolfd3Yar0?=
 =?us-ascii?Q?lgjVF73fvQqHr9rg6r5FHPnmyC9Vx4PgIqoJP14k8o/K2cy5UuJThvKseYRl?=
 =?us-ascii?Q?5R97vqNidPlzzgBvjzK17IcVjFoJ0cOcaIaKBkby9mSYBJ1ZsbL2ZCG/llk/?=
 =?us-ascii?Q?cyw7KkaV4wJiAxrr8/xpmzb+hSDeDeMET0K0fEFzvL6S0u3JjhpwfYd0rUP0?=
 =?us-ascii?Q?eDGz1CDiMRIP1bI++aU4r9Wko+i367iLU/QQ2IBdR+GjrW+OAtKd47H2o0+n?=
 =?us-ascii?Q?eiKEi9lIc4923FhgFFs3gE2ZRCYmT8+19X75aNxjC7Q3sn9cRHgO0LNgW6Z7?=
 =?us-ascii?Q?Tv6hSJsfxJrjMGKil3NjRzNRKBSNsvMOTsI+35AKWNeQoYiUO+yVYnfP7Khr?=
 =?us-ascii?Q?lC/b6Ol4aS+12AeC+2Aqc3v4WEz5+qSjj7ZyMzl+vAJInHKXFKgIrqgR5YF0?=
 =?us-ascii?Q?HU5KvjlY2kIn4q0Lj66zmC/UPqQy+afPZlMOlEs6ddKdGHRr/2vdlvgsZ2ZR?=
 =?us-ascii?Q?cvxT+9GaqmgaHo0CsGU/klMfeetLxlQ0zOJABzaB3MLcnmOCLu67X1myS1cD?=
 =?us-ascii?Q?R+JMyzUnXWayNpIXH5OC5dPV2kMfAknI5+DVHTtCJG4kyXz5n5qGwZGJ9eaL?=
 =?us-ascii?Q?hzUYQAaXxkQXeBdRygycywl5r1x65SMmTRwlQN8N3lqr+ZCPURxnnj6t6AwL?=
 =?us-ascii?Q?PQC8keFCF+2JWKbmpnvgIC/cyCeM9AjL+zx1oDzgmggcbbulM30HWuh2lVDc?=
 =?us-ascii?Q?LnP/1a5NyPRSp7V/WB6T/dINmRGAnrAT7QFkjbQswyrLUfNwn+Et8JqjPfLn?=
 =?us-ascii?Q?Hln1mH5IpLTj5KXXtUVkpJn9OdHXX9wgqWbDiZ15mDxZT0I64U6eYhDaN/dv?=
 =?us-ascii?Q?LbX5nqnHF9Z6zmjOIo99/RObZuTd0UrxPbItzJcnRx2aHom8TOULJF8q1/NF?=
 =?us-ascii?Q?sy/dEcnZQHi/lkaBekFbp/lYR7YCOaLPxIObeqdqmYsedrc9Qy0AUs7tJuZR?=
 =?us-ascii?Q?zaihm6LIoeYPROQbAXN3ykgnTORpU6Vyf8UZWDaB9+YoRMK0eRitWqwyZPu/?=
 =?us-ascii?Q?7FuEb+n4FK2TxlR1SWAwhTvMPoA5O7FiIp7i3iJG7saqBw9VCoVj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29711807-8af4-43d3-effc-08deecbb3c24
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:16:44.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR5Nw3wJSDWRLUHWkkO20yrJTQP4ypOyUkDZrQDqdOq2YFWB7r+IFEEnRu4fcTxCuOciKLuzMVmEZAcKa7HR/1gCP2zUM0r9DvSfBDBpXK2nPUDfNAXHhormCndEH5eR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

On Tue, Jul 28, 2026 at 06:18:09PM +0800, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> In nxp_fspi_select_mem() the RX sample clock source (MCR0[RXCLKSRC])
> and the DLL control registers (DLLxCR) are reconfigured while the
> FlexSPI module is still enabled. According to the FlexSPI reference
> manual initialization sequence, MCR0 and the DLL control registers
> should be programmed while the module is in stop mode, i.e. with
> MCR0[MDIS] set to 1, and the module re-enabled (MCR0[MDIS] = 0)
> afterwards.
>
> Wrap the RX sample clock source selection and the DLL calibration/
> override reconfiguration in a stop-mode window to align with the RM
> and avoid reconfiguring timing-critical registers while the module is
> active.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-fspi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 6de6d432cdcb2ee383a02d72f20000045903e176..a426b8d92193a4e303f411cd17c16cb31c3f3873 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -867,6 +867,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  	unsigned long rate = op->max_freq;
>  	int ret;
>  	uint64_t size_kb;
> +	u32 reg;
>
>  	/*
>  	 * Return when following condition all meet,
> @@ -896,6 +897,15 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>
>  	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
>
> +	/*
> +	 * Per the FlexSPI reference manual (initialization sequence), MCR0 and
> +	 * the DLL control registers should be configured while the module is in
> +	 * stop mode (MCR0[MDIS] = 1). Enter stop mode before reconfiguring the
> +	 * RX sample clock source and the DLL, then exit stop mode afterwards.
> +	 */
> +	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> +	fspi_writel(f, reg | FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> +
>  	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
>  	rate = min(f->max_rate, op->max_freq);
>
> @@ -928,6 +938,10 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  	else
>  		nxp_fspi_dll_override(f);
>
> +	/* Exit stop mode now that MCR0 and the DLL have been reconfigured. */
> +	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> +	fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> +
>  	f->pre_op_rate = op->max_freq;
>
>  	f->selected = spi_get_chipselect(spi, 0);
>
> --
> 2.34.1
>
>
