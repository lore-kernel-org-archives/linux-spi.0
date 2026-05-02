Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F6221721;
	Sat,  2 May 2026 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697477; cv=fail; b=PfIy8d6vSD68UL+CjSC2Akw4Duu6i09nUmW7M+QqPsssDyVULtVhxo1GWK2QfpdxvxVRIjD32KOO8mgrgpzbib/dBqGT8OOTlbNdiz1tvpP8KebeA+kn/KZ0GUyg94WfJ0A86FVzmJJuTZ/KfZYLTgH9K0OLYpSTumOJjyeBu0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697477; c=relaxed/simple;
	bh=8b3p1JzHfwnqWOZL79J+k+G4MBpprdgJte7Yy1c5aKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZASaZSNxnyKKf7MLoZdJp9LZotugrC8J4mnNvf9hdelDxeBhZtdAuk8weGvWVYmsR9I+IGG2sE1SV52zZVlRrqMYFT9sMQDxWPS+CqwOrs/ujxSeXA3vcqbaIvvWuUXTyjzjodiLgciKLJOmLFdcf6KXGhRzfN5OfI6e0mTPY/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hi6b9b6i; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hi6b9b6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx8e/SWH28T/6KcVqu4TteceE8UOgWW3c3uUCTXlTMwD8KCZtUSYu3TJtuHy0V4kjbS8zc93s+2qIdbeFv5dHs9arttsslf5kDVeqAXm8R/0RUEC5SNmZsGvJPIFm7EusBKq2DOxUof2mioyliaGq011AXIQbs401mRutyvsEk3Dma41EAfmpG/YVoD5PXj/yHIcPIwYS0sxbupVzMFWoiJzwMD/7s6gW8OvuQ/VlrhPJJtJxVK+JLyFd9UhhgJeliKECFQvPCta6F9fFWNjtg8wMDi7L4wcMAiFxxQBw+d+u4q7/ees7JS4MVPWXeto/7zpfe9JukjrkVlkFBGsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6m8Fg2hEviq5jlxMolZrCBWOSQEVN0FAQwjR0hddLU=;
 b=hEV+mRiu+BstDXyaorAUpt39er98Wlz3BmeYELqXOepBz9iUZyTKv9jFhiQCis/4LKfflT7e4NDA5e5v0U1zUcaMTIAiwyOP14aQXiRSh7MDCogy3ctPMpjNi3Bq/wbqtbh5qsEZmxCRqq11dwLaDgbS800oqcnDcMj1dlxV6wo8RLLA6fI+P1qpg/yC6pNqFPxjeoaJKJFOLBgqCxXLBZMEAg54XjxIJZ5PKNqo60PybxIiTS4/rhvpaAKMI8SiDpaXXtyViMIRH9UmaTDm+3vwrZCOXYFgpsO/RSQgr24UaRjRmbzw7109Y5uW6hyqqzT1nrk8qAmxidqsqrXT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6m8Fg2hEviq5jlxMolZrCBWOSQEVN0FAQwjR0hddLU=;
 b=Hi6b9b6iHeDgBakRU0cVaKUvcwtWx+u6ud2uoHLtmsh76PddqPr5t/+H9lIJVoihNYeKDBu+ayzyO4+edWc7nOJFUpHpvXONL2tMNPVumtJ6caqA3kKiTGuj1wwAmFZLmgU/I2F1N2NwJFI4sq4EzCBxesAyL+Ghv26HvvQAU5twRvu4JvGsmcJIlbYl0LTySLD6eH4MpSkkBZvmQ3GwlSMGmfTf9qNRSRHFQ7fOuAXkklShsK++201N7MmrFa91u/L0JVYWdZEoe7ZZjGL76jgETKPtqBzJIPL7Cmzv+MrNUu+23gG7RLkMtfea+El9HmIgTz2u82VtDSthVMQywQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 04:51:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 04:51:13 +0000
Date: Sat, 2 May 2026 00:51:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: John Madieu <john.madieu@gmail.com>
Cc: broonie@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, carlos.song@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: imx: Propagate prepare_transfer() error from
 spi_imx_setupxfer()
Message-ID: <afWCu40UdOHlSvni@lizhi-Precision-Tower-5810>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
 <20260501135951.2416527-4-john.madieu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501135951.2416527-4-john.madieu@gmail.com>
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: 90918d38-9268-495d-9f5f-08dea8066ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	iDbNe6mr4BGBPBLCGIs+ChPmPNnZmi8qegESpPk/UJ6oZWq4Bni67Gv02bB29wdOnRu9U8nswzT5aHyYa9eNPyyMcoYCKP01QmKkqtPCOiZJS2E/Aer+XVoGXMglbCg/qLmIOd6DMhtzNaZ3laDodJhiHxL5QWhzYTPd58LkU4m0H4VhqSFnRzA7Z8mBXU+SKu/autfU9T3xO3fMmiVg40n7WER/cX7vg4TGZhpGYe/tozAnHehxJxugCo6sskQd1KA1ftJff8yc3I05kbP4rNj40LtF0cNJb0Qyh7Ek53rsYVeBZ5gK33yrs2c5z/6aFjYqXAXsHDaCkT/+VFzYJ9N4G3lw3okEboGYxB4mwoapTRDt4pQSdMzdfsZBCUmCAJCjMwT4VjvkEKAJhBTQTNgKd3n0tRN6v/AULrvGriAQOPcJfIMiryaPIXr2yi9w+jc8iD5wyfg7XQVfwkWP8cCDPArAzP8mO3f2+ne6PxczOuwUjoPsSMuWjVCWmQYVPFdP13l3KgCVRA2ds4RZ7illVn0QW5DRM1eoXbPaRM4hMfLsFszj3Sax632kqcz1z/N/P3gCjBitCxxZ+HrCI12a4BWF3OYwtN21JUXWdUadPAxBcwOemss6zOFvjWlDeYQn6fzpag0oKVeb/Ntxyw9kLf2i0eJMrPt/c1NortDLKQrguMbrmKIDhISXZZfqQ5nep59n1+70TXcEnGmcaZ42xH6g2FKzi8PzifkclZt69nSDfRUB4iHdWaVv1MSd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2rPqlu/hCtanR7OqDqfVU0b+c4cCYMLqDVsHls6xZWcfiLFEltMQkaKnG1p/?=
 =?us-ascii?Q?WXhaoBUmBvnRgt7eX1s8jxmOysFhWx5iFdb+CMVBFOjJPAOPqS3vaiGWeLeG?=
 =?us-ascii?Q?GlAYKiPnTg7CwscDwGQCJzRm3UMmGYDrUJBZk6jNvgHQdJGY/eXEfr/VGQDH?=
 =?us-ascii?Q?0faZc8fP3scr4MIpulkMxk2eibviY/7pIqyl8ACtnc/z5Bqh6cYb70T1hsdd?=
 =?us-ascii?Q?43ffgrvbKZZSSzOb/wzMdAd5ZuKgXJpGEj+OgA2I1Uamwr4GeFFPQrUZYWx0?=
 =?us-ascii?Q?QEMrMqNprIcm4FEJAZ6gtr2+OR+J4mFdYXjnibxOD+DeozlwBJaraxxYZ75f?=
 =?us-ascii?Q?Qq9bF9moSbKP8qFZX+J2bdfr8BTqCXKg3OfheIzg1r4aogzqZ8EHn7pUNRjp?=
 =?us-ascii?Q?ScQyHwzg2RjVVjNdz5YdFpIsS8EwMGM1bSUa8wfzWzotqbWr3R/N6Jf2ve/a?=
 =?us-ascii?Q?Z2goLEh14XuGddKWe16xipGheKCeecSUXiHUuWl7Pwz/tFDoGS/3TKqgjPA4?=
 =?us-ascii?Q?K2MKsTVEL2ro6UwFKXY9tfvra8xyM6hqOMO08PiHXvO9yIKzo46pVm+XSs5Y?=
 =?us-ascii?Q?GslwYg1zEIma83SkbbesQv+E/yBwRZ/ZH6EmVo7KrgSwx+Ze1FVOVJKj6/dn?=
 =?us-ascii?Q?/Pe65PcGnlzCukIUUPAof/5F1NKzE4VGAmIF3S7RZmM0bH3kOcXcL2o2jzY0?=
 =?us-ascii?Q?MKwq+ynGiiRwKfIiI9uhK4LShLSvjxaKrFWFL+q3Bf7RtaGcKLm+wjeAf22Y?=
 =?us-ascii?Q?eLkLmEtJR40qbvTNSlfOzs5b5wXkH5NDcugC4SJLbZ1pbQTTdmvsAFQKmPcS?=
 =?us-ascii?Q?aNRJqgbfoF6Pp4HxkHBsUvasCFWP2vji5ntEPmpJrpKqKWxaT1SxO0d3113N?=
 =?us-ascii?Q?iGTCpYPv+XaznZxHqrAQ1ozOod6kOYTswwrV4qdOUuI6LhkiEs/fWKVC90E0?=
 =?us-ascii?Q?Z/gjgsmj/HquaiHydjIl5kwICJjEyb4kyYamA8WNbcyLvtubBeuS94DiBlOV?=
 =?us-ascii?Q?ya3GSXg7WpSrO4WxEbU4TP9SXpNKxvqQBdXrxyjYYFpI8mX0kGx/KtjGWz9K?=
 =?us-ascii?Q?8/W/PHawSNuGH1xaqnUvmlYy7Xu+ddvc4cz0UgcJPf6zOszPJG2qUhLGDR5b?=
 =?us-ascii?Q?gl58G+qPofW+3xxzHtobJBBWInUjdx9mP+s8VYPQEdvV8C2e66MI318g4pN1?=
 =?us-ascii?Q?NbhxKOpmNKBHB+/1CzUrLfTG8hBqo3pyXzhTrljq2h3liAiktcOv5C/ZFsxq?=
 =?us-ascii?Q?+CovORoxdexKA0WJ5937gF/PjqVQw8Qrg19hI14VWFyWKuh5kew2PSs/oLgi?=
 =?us-ascii?Q?Bocx0Utvb8GQxBkOxWc57wxKGoPEcyUdrVAkWsr2T76xvoXrB6MEv1jVKYIq?=
 =?us-ascii?Q?yjk5C65e5Y+vjbJfiAApLrU67Jdzz66gIgjwcrs7lXz2qX4deM9X9NflalND?=
 =?us-ascii?Q?H7ZwWw109mfrwFMmpIskk1Hn4wuAYFs8XrKj2nFuiGAg4pAfwJONBQx5Dnk+?=
 =?us-ascii?Q?1tWYxoGRIHFL+njh5C7uOUESywFpFfHqU31GFZCXooXZaxdXSzbo9dTMXwPM?=
 =?us-ascii?Q?RLQT53UdGsUwjCV1KG2lQdU08SlMOL6Z1ywSWhLiT8IP+K1ofkIUSGrG/0IN?=
 =?us-ascii?Q?ytGEhI+Xr4/QtAWuFttUmeMq9c9KdNjAh4mnxt4N6YhuBL9XIyvzNhKQJnKr?=
 =?us-ascii?Q?lF9bjQBmHCbRVTiXCnIh8/0iB2TMlHJZEwTFGRtrsrwPpmKl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90918d38-9268-495d-9f5f-08dea8066ff7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 04:51:13.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J/CqBQzYQS/R720kHO/QO84AuPwMmehLtiQTGRoZml0fDm2FPCqVt++C/fL9E1heWftCABq4o3VRcy9Qn/YFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792

On Fri, May 01, 2026 at 01:59:51PM +0000, John Madieu wrote:
> spi_imx_setupxfer() calls the per-variant prepare_transfer()
> callback and returns 0 unconditionally:
>
> 	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
>
> 	return 0;
>
> mx51_ecspi_prepare_transfer() can return -EINVAL when the requested
> word_delay does not fit in MX51_ECSPI_PERIOD_MASK. The error is
> detected after a partial set of register writes (CTRL: BL, clkdiv,
> SMC), so the controller is left in a partially-configured state and
> the transfer is then submitted as if setup succeeded.
>
> Propagate the return value. The other variants' prepare_transfer
> callbacks all return 0, so this is a no-op for them.
>
> Signed-off-by: John Madieu <john.madieu@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4e3dbd01d619..480d1e8b281f 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1382,9 +1382,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  		spi_imx->target_burst = t->len;
>  	}
>
> -	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
> -
> -	return 0;
> +	return spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
>  }
>
>  static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
> --
> 2.25.1
>
