Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454A402B95;
	Tue, 24 Mar 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364724; cv=fail; b=qTMLhqppglX5Pw+sKcsUMiuRXKa5zhFQ41zVfdUvG/4TqVuzwSzh9sKylfHqAYO2IZO9UDf4cd+CNg+/UMB8MAwqQ62hhPd/E9pQYFKhnSPGfBBYDHfcy7/KdfuH+Cz+SclkWYiwYQ7wOw6QaZDPQYJ23OfUtuSVvzIVQGlrLAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364724; c=relaxed/simple;
	bh=zsqn0u75XhPZRcWw9Gi2bNBA/crKxzYXiLr+fNkYsvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHPieO/ArdA5fFw45UBWrVq8y+mck2VnBupo/3S9GYysYpb+mJsOrW+8oAbQGB1cTBPBjlUjnJ0xeFWPOgqrizSNagQ7d38cbiCM+ql7RHouteipQYMMFJsqaI1NDfZLPMWdiX2LyfjhcmPBJ7aW8LPoLtipWQKPi2ab9ni7xsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IkVsjd7R; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IkVsjd7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igGFRlMmrT+gDbEWC82nk1JCJGQ8002YAkHhUBUFOzpYNcHhcv+HdmtgGLov83vy68pyZYzLzG/kd/Jw818/5jHfz0nLSVADRWvUTxqSomxDbjnMJ4oQofJ+HxeTnF1iqYqDUOMP00IpWASBP3WSbmGFJONWcokqrxiy9NQUdFDq6ZinNg96VWzkygPHQP4FI5FTP1GHWUpPGfVW4yF6EJdPdr/oToDacbFBlyhUR1Wa9P+1AP7dPy16Kls1VSlA+yivhZAxG+nscvhHqZ7lVcCHN1WtZk1rcv7Q9MoLElM5XSyfwUs4UUKySP8BYAPGu/ITgFYNKm3pdxsnvnNPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ismAlXcJCSsWC//Df30vQf/mQMEBKK0LsmAV5vvy/Mg=;
 b=bnwTfCqh7EY8rnJ+x5lN5DF3FoVhOyjdD0FQYuv4/+/InPne4GzZ/KF2eZ93k//+sARMsKunGxQvB3vreXFpLcWKgti0FZhQRRrjVCNaF0lhrSxvrdoDQNz6X/gmug9k62ilQf2DgnPilVhtivklTb2AA82PeR0Ju4EdNnWLEy8oYFLAsUdn4RLMqhiln42oHlZwo4fW+2ANRNApF9WdNVtslC+Phi0cLGkKtoKHguTVIjbPxiDZb6bAv+uFvWA4hss3MLpO7DSzBSf/CQ3vc0adElCUpYnUJ3dQgM5Q6oQGhPoPCmWwB55mHTIozh1aXdm6ZHc+dkEkEcPyPXZm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ismAlXcJCSsWC//Df30vQf/mQMEBKK0LsmAV5vvy/Mg=;
 b=IkVsjd7RFqRvJrvKSgrpFItTDhEw8Z/kIbORajPFnXldn50DGIHCIbC5TW7Jo/blnbIlCx9aO+Ewy0kSD5NEfdWl+RYXt/sFyV2U6h9IsNQc9o11JEarKEc7gN4y9KzZiaLeoOWhGdlb6rTa45wS41ZA34XJRHmUwYK2R2NsI+/KuC0EMsVVkl2sXvJJCFae7CsHHRTE9xt43SmakESUo299fW9D0imhbzso6zQHR8aIpJ8NUPZuhtcvGNc3CDXp15/Z5KmMlfa+bOX9x/yNNL4rr6LwpYXNzOdIB66ddIH2O/rtrODKSXLzJ94bm41FbkH+TzoaKSocGpDCe+f+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11423.eurprd04.prod.outlook.com (2603:10a6:150:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 15:04:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 15:05:09 +0000
Date: Tue, 24 Mar 2026 11:05:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <B38611@freescale.com>, kernel@pengutronix.de,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
Message-ID: <acKoJ3Ca_q40baDS@lizhi-Precision-Tower-5810>
References: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
X-ClientProxiedBy: SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11423:EE_
X-MS-Office365-Filtering-Correlation-Id: e2539006-7393-4104-4d47-08de89b6bd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	2FCgmUgaBoM3t4bMjRFbHsHN/SIDq/Rz3Hnf3d2YT7ZYDJnwKxMAZKb0q8CHMA1lNPKVs1U8+3cxjyPg+dwiMf/sqIZP4JBbmwW9iAodIZjNQFW1JBEzAS2yk7a8nmAOcHAyRcQhhVzuTgDTkAmnQajFw/dc0ONXZb3w1R1KCEpTuR5jWCfNbi/0ITrByqC3+8pigU3XTRS+ZebNYf/rXa3aBrhgz05c7uMhMqfgf6kSYAD1omfYv1k2RJHKWaevxEWOHnHBABrCnenEebId5CPRoeKCmT3MdMytnWNIa1/v1PzVaOyiBVzQcpCMF6ggTWURykFry21aYj+BS19I948LcMpvXzJjxf/nvFdqPkE9PM3N4H6ORtU56FaSPC6WeTvQavcfDGlzwCiaj5gQ67SX0T9fw3ZpONJQRTziKqZa6Q8Yd3iUKyKj87dzykOI8SmPyROIvCL8LR1WhfQeOD9rjILn9reAkpQDxAMWNeFXGuKF/nqXzUrbwd1oDhu1h+iay5i40q02HUaqtDSqUj09Wx+o5Z9gCm/jgwiI+NrsRCAjXIEsSBbf4hhvuCAlAju+xKgKd4r7YiT00z4/18r49REmZ1h7XQrbDaEtMhb/ThNtULE7mSlwsFReaaOWs6Upht5ggGVr1EeMY9aaRJ2j/1pKhsH3cVBiMdLNLLc2nW91kV0RhCyApfnklYYMlxsYuCncRJHBNIwSyhjXqsswc5k84atfA5ZQqjPAgMnKD/YiU9l72tkKHgh9eKdcPsFSGQFgMygoV0SPURhInuQ8St1CWMiMjrnp4DsgyfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ou9Wxn5Jky0wqM5xi9UR7vkKBUQoIBA9QcJjGgoWOeOufb2b1p1SAmpB7uc?=
 =?us-ascii?Q?NqQClc5QTY1lYBuSFUbYbeSXTLEzVGg7zScNC/nVzIikx2jfMFUfoiKlE1IT?=
 =?us-ascii?Q?F0YAYr+1KtlXFTvTjQJhkB1TvyJBSZ13Gz0LAuoOYvUqZlK84QzTLcC+8rRw?=
 =?us-ascii?Q?eREcSD9B53cKHtXPNrnT4Ltii0+frkiREM8uURyE6C+r6ycR6zzRwhJng4X9?=
 =?us-ascii?Q?l37BncSqrJAZUKRQ1j2wEtT1ECTRfZDvxiWjbXx5A3QZkKJdJIxuA6IBZQDU?=
 =?us-ascii?Q?N6LwhLMKuIEkR/O8pKB2TvG7wUT0Efm3lDLm9Bl8Y7VoH6N+gsMywUW8LawR?=
 =?us-ascii?Q?UYxbYCFxclAxebykIHtLCFGsNQqbgAOp2V2C/0Yut2Hc/vN/nZg8yLsO9GhF?=
 =?us-ascii?Q?gdmUO4EOYUtMk0G/xuWJYZxMv5/wTYSJeMKGHveSE1+yCMr9fFG4C804p8yw?=
 =?us-ascii?Q?D5Gqa+M2lP57bFbz5pnCsVvod8bu4jubPNZEqXS6EcNZGX0hSdgySc35Wnkk?=
 =?us-ascii?Q?SU036XGj3p7qf3Vkw01awtOgYazLyQOIKGT2X6UwD350sdvvVkY1q0WZ2GAn?=
 =?us-ascii?Q?iaRl0aIEQqqADzFIhvmiGomAMDc3qZcMVyq7p4kyJQQGfojbc0C+xp7IUPrG?=
 =?us-ascii?Q?J+CFh89sYuqHj0QVTCqcEgIj9BcolVJ4HkoDYFCs6+hRtRKQ1ogGSeaC3gxp?=
 =?us-ascii?Q?FKFPY20ilQavXg+NuBhZnjx8C04nHlds5M3TUAEHi1WcaQASg4OK0N4MxXpH?=
 =?us-ascii?Q?VXhdRsuifOgebBDt1IeLIFCBz1qvZu/fGqetfyUHoMv5ykuiJ/mf+/+UlySz?=
 =?us-ascii?Q?r+s7SjbsP9HBdC4kOsdhJjYrBlvqHUHpeKJcyf3/2mgIeh+Snyq5tkaVlQ8m?=
 =?us-ascii?Q?ibQhTeFFPaKd4fPA/1V+BWbdEOP6PyzZQrrAdLjSAiF1Ky+7ggQo7LB9pxTS?=
 =?us-ascii?Q?q7I+IM/I3gW2Qax74PN71uDEP7ezOkqVF7mlNklEe401ZkGx6v4uyw3diw9r?=
 =?us-ascii?Q?+ScXsmY3VdBmSXRx9mtpBxBOdD4sde/Nj30HxYgvhKAWhcJ2P/wB6ck3H5MP?=
 =?us-ascii?Q?KhLCII2SS0Cj9Z5CGWj37K++0XUnw6wqs3vmuMZgEPh/M4A0mI3BcAHSF/yc?=
 =?us-ascii?Q?QmQ1af5jVSiZh6aE9JnnetCWMygK9o8rtGNdfLbdh1DZhlQ+5FqNU3hY8Moj?=
 =?us-ascii?Q?AukES3lHZPqbvxYEQIKHgB86Ao3hnYZyzn8Be8l1qXEE6YFkZee3lMZyymMg?=
 =?us-ascii?Q?vYL0CM0VoVQD9RGoJzUVOwPYgM+NgPVNmQkEXTIbYiGjXVAp/iIsmnDkox2d?=
 =?us-ascii?Q?vg1qk178NQwjC0an2ZCtLRw+YK7dLHCx1FBxn9IOEhuwPzAlAPNoTKQ9IXBj?=
 =?us-ascii?Q?5Fz5PpxvC5Rs7WEOzXb/lufVszhIf+uYm9fC8F48DyviMGiWJzY/nL689Vni?=
 =?us-ascii?Q?GkSeBgG2AbvIdRe6f6BY8BdmQQilwDPtjN+8HyNbiy+FbKwJqM9rnZp/O6N9?=
 =?us-ascii?Q?9aoZwsDFg1wVJV3HQdpP0SvL+NJR1DsHSAWI1uK8klTAtlJ4G0Mc3qTxxPYU?=
 =?us-ascii?Q?zQPDC4m2UI7/9XHPh4y7+9Hx+SgsTI78QcyJehCbTMNvXM0XAL9QayZj17vC?=
 =?us-ascii?Q?XmjRXOsut86oRAJkGFV7fAawFQXFaUzuOg7RvkmsbP2Ff7oY94oya4F85unq?=
 =?us-ascii?Q?nHgk/18ChatvFJRJX5SG8UgSXxuMky//XzbjK2WXxBvdjcrX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2539006-7393-4104-4d47-08de89b6bd88
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:05:09.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y96VQu8rfABVjYPwNL4uW8KwqN4vHOwwFJyHdDW4olxQmxq+ovWkMlOZHGrEUIXOjtQDqKEGUxEeT2rG8ZMKKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11423

On Thu, Mar 19, 2026 at 07:38:12PM +0100, Marc Kleine-Budde wrote:
> There is a teardown order issue in the driver. The SPI controller is
> registered using devm_spi_register_controller(), which delays
> unregistration of the SPI controller until after the fsl_lpspi_remove()
> function returns.
>
> As the fsl_lpspi_remove() function synchronously tears down the DMA
> channels, a running SPI transfer triggers the following NULL pointer
> dereference due to use after free:
>
> | fsl_lpspi 42550000.spi: I/O Error in DMA RX
> | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [...]
> | Call trace:
> |  fsl_lpspi_dma_transfer+0x260/0x340 [spi_fsl_lpspi]
> |  fsl_lpspi_transfer_one+0x198/0x448 [spi_fsl_lpspi]
> |  spi_transfer_one_message+0x49c/0x7c8
> |  __spi_pump_transfer_message+0x120/0x420
> |  __spi_sync+0x2c4/0x520
> |  spi_sync+0x34/0x60
> |  spidev_message+0x20c/0x378 [spidev]
> |  spidev_ioctl+0x398/0x750 [spidev]
> [...]
>
> Switch from devm_spi_register_controller() to spi_register_controller() in
> fsl_lpspi_probe() and add the corresponding spi_unregister_controller() in
> fsl_lpspi_remove().

Feel like it is not correct's fix. devm_spi_register_controller() is quite
common, other SPI controller should have similar problem.

Frank
>
> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index b361c1bb3e43..45390e9b8cae 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -1009,7 +1009,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>  		enable_irq(irq);
>  	}
>
> -	ret = devm_spi_register_controller(&pdev->dev, controller);
> +	ret = spi_register_controller(controller);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret, "spi_register_controller error\n");
>  		goto free_dma;
> @@ -1035,6 +1035,7 @@ static void fsl_lpspi_remove(struct platform_device *pdev)
>  	struct fsl_lpspi_data *fsl_lpspi =
>  				spi_controller_get_devdata(controller);
>
> +	spi_unregister_controller(controller);
>  	fsl_lpspi_dma_exit(controller);
>
>  	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
>
> ---
> base-commit: 8c89a077ca796a2fe248c584e9d7e66cff0388c8
> change-id: 20260319-spi-fsl-lpspi-fixes-725c6653c745
>
> Best regards,
> --
> Marc Kleine-Budde <mkl@pengutronix.de>
>
