Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCB248861;
	Fri, 13 Feb 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972682; cv=fail; b=tmnpnyRoQZwCyZNRvOJIWauX4QZwC2i+j61f6/8oUqghf3bNYhL+vAYZvYW4k9vR9P+B5Wj5CZk9DN5TxeWu9HBD+ZlFkK2wQTq5IAGKAx8qVV0cDTJKBkpKsdACUbEuF2rjikIfMLnOLkQxt5YxzSJxg9gQxdz+q4OTlj30lhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972682; c=relaxed/simple;
	bh=IWPCdpkC4qJDaPg2FXV33gjcZ56vMghi36I0Fn/Japw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JnLO4ywZXt3CHCiFjN9EEZ9nHVEm8V68XgDGqdJkJ7LYbj+fKu1qir5zeW2oy4B2hOLKarZB8dM5JGyV9Jp0MD7m+OoGTjJ4FlVw8w0LTcKTz3dYJ9gq1ib/7mKnufUKyPO1xAN87MtH9UjKpg1rX4i4g4d2AdZrT1+jk0CEhZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Owep6f+I; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Owep6f+I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhluVqJjLqK0xd65o8qXtaRlrzYamU0Y5M9bbus3iudwcrSh5hY2duHbmLvGdaejNK9QxkAq2OmKDhi4Ukr69wpX5hoam/mU+/LFg0lyZWeJYOFNK0Wyli6FdavD6sQcFTvPayHyY0zDS8kdWBnCMi0l8Dt9ATjc4+DfULUVvP+z4w/AqQYl30fZ28HdMna9JWbl+ygpXzZsVe9m4bCK9fLQ6r0eJP/OanBQJds1d9ItN2FvFgGazBbESQRtrgCjCGEShDYjKKijbfyJ+/UmObT5D3/+KVsnmcRadOr76TxyJ8X9mgGjGHM1H7YykT6V7VoRRDfRnZkj5ghKl2jIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eybolBtDa7Dv9XQ2STcHICb0xBy9OmKYEktQVXB9Oo=;
 b=qng1km9GBYTgES5yd2eH5Oqh5ZRoYCXEK59L2R4SclMHZSXnlXsiYbSaxgZNe8mSkhR3AGSSbRCLsCrbHHiQBMlwJqIsszpx8ndeGB5O+PrEpVwCghcWJpmh6kheTMKEFG9S68Ln2Kiy6B7vRMF/vQdAuwHFv6ahkPIkBp05rbI3Z27FuuFpnOuN4sIDWDKyPk/xhd1App1nL1pgYKQuXjYBccMGmCKn4KxiHxQS20nIBL6UB+xqC450cp84CA9OF/LAuoBSS7mzCB2UwgLZqjQGb8pg2KimFPPt+30flm/CC5g+agB/HpFdTIsJoVPxEx64z/JBXkdjtveAR5pTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eybolBtDa7Dv9XQ2STcHICb0xBy9OmKYEktQVXB9Oo=;
 b=Owep6f+IBTAV68K502K9qJaU6YwFutjqXAW7z0595HpCsMLIRFvCYyfAvjqT38vy0apUwznheQmNbgkWucztcCekvPzz/+TgISwZ79Be1Da5Y0sK4JCztFshXsTwnipVRVgSeiVUaH6Br3dKqzdvngjZosKmkoOMb1Es2Or/RmIN8WoAmTzNsfU6bJzptsaOMg9MlXUduYkomcUtfOrrPwg49pO32IuLsoQEunfKTkSvBX+RgII3gVsSDB5njaupReXEJeQ+I199fArXuHvinPY+bIMaa1l1zGLgKCpAoRTA3UUm8HfL/RToA3kcVOEwI/1ppvfwetqdkivHaw7hpw==
Received: from CWLP265CA0332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::32)
 by AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 08:51:16 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::dd) by CWLP265CA0332.outlook.office365.com
 (2603:10a6:401:57::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Fri,
 13 Feb 2026 08:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:51:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Feb
 2026 09:53:08 +0100
Received: from [10.252.8.180] (10.252.8.180) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Feb
 2026 09:51:14 +0100
Message-ID: <6eabd68f-9b12-4715-9e93-54f630e2e0b7@foss.st.com>
Date: Fri, 13 Feb 2026 09:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH] spi: stm32: fix rx DMA request error
 handling
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
References: <20260212-spi-stm32-fix-dma-rx-release-v1-1-53a37c31626b@foss.st.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260212-spi-stm32-fix-dma-rx-release-v1-1-53a37c31626b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AM7PR10MB3543:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c15178f-0ec8-494b-3930-08de6add0c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdJd3hQN3M3eEhZaWlMbUdPVUZidEhjWHozVVJBUHVsYU5YbFZVWkhCSHJH?=
 =?utf-8?B?Z1Rha2w4a0VFK0oyaEZMNHE0OCtQSHJjRHBTbGdhYTdpMHF3NlhOakc4RTlH?=
 =?utf-8?B?eXY1REpUYzMwTHgrTjUrSE1xOS80bWlSN0tJUVRFbG41anVPQ0pZcmdBdFQw?=
 =?utf-8?B?am1LQk5zbFRzU1NMRDFEdlNjZ0w3K0hQZUx4RHJmTzhFdGUwSHU3K05hRDQy?=
 =?utf-8?B?di83aS81VytpTmp1Y2hFT3pPaWdwQ3NCRk0xZXhwVm9GbUVueldSNGF5WEd2?=
 =?utf-8?B?ZWNLakFVV0Qrc3FEaVo3Lzk3N2h3d2JsZVZHajIzVDNWM3lpVlllZWV4UVhs?=
 =?utf-8?B?MnRGUDVvOGM0a1NicVppRDZkVG1RVmVXUTllS2N5aXVaNFFMMXV0ZFltNGF4?=
 =?utf-8?B?OThacVNUc3ZUbEFKQlRCL2RDQlNjQmY1cWptcGl4Y0ZyYXRPd1phSjZ4RXo4?=
 =?utf-8?B?Sm9KRUorRU1ybmg4djZDWUZOU3g5aEtJWTZINnRzd2tHbWI2VlZPT05DSHhC?=
 =?utf-8?B?N3RKRDZDMVNZZWFlY2lNc1N5bkw0WUhSd3ZnM1dGd3ZZTEtDWjlBTHlnclIx?=
 =?utf-8?B?NVBHS0VOSFQzYXo4Yy9KNndJbml4bWVTOTFPbHArUHMzRUtuL0YxWDVGOG94?=
 =?utf-8?B?T3JYZVI1Z0lqdlFoQU0wS1IraHlRcXV5TXBtWjl2WlpOMW5HNlgvbmk5eENV?=
 =?utf-8?B?Ymx4YTJGdzVVNDhGNXVUbTYrNkdvNm5IeU51aVRreU51TEZLRTJqYzVOZkV4?=
 =?utf-8?B?NVluMVY0eERjb2ZLUlVxTStkT2dvNXFWSktQUUVGOHFOcXNlbTVEeUw4dlBP?=
 =?utf-8?B?OXNCWHkxZUwrUEs3YlZQZktsaEU4RTNuODcyTGNZd2hDNzdjSktlbmR2VzA5?=
 =?utf-8?B?UllRQ3FPenZrOW5sc2ZXZ2VTVEkxRFd4b0w1U28xclRqTTB0aEZ4YmdvbVdU?=
 =?utf-8?B?RysxdGtra0R6SzJSbWdQNjM0aExjemtDRHNtVEdES2doTEM1Si95WjFDcTVp?=
 =?utf-8?B?Zno2cXg5WUt2alV1cllxQW1kZFg0cHNad3BlWXAxbGo1Y3RTclk5cEpDUGJt?=
 =?utf-8?B?RDU3M2ZUdDRPeUZyVGNSdmtRSFZiMWczdTFBWWpEUHhpQUlXSlZsQjZYSHkw?=
 =?utf-8?B?R3A3anZaLzJ1OXowcGpPSUVkMGZSUlNoNnpibE15dFZTQ0tSYzZpWVVpL2o1?=
 =?utf-8?B?dE0xbGM0MHFpWW0va042Z0FCd2kzdnlyZHFJcXc2OXhhNUdhMG5PeDUwZWJn?=
 =?utf-8?B?US9Pcjl6aUN5b1RSOVgyUDVva3dVbVc0R0tOc0VISjlxbUREeGV5VkNOUnJ1?=
 =?utf-8?B?ZVdQTW9QMzFrbExTZkRWU01KYjhVS3p5M1pmNDE2ZGtBL2RtVjdwNnRKd3V2?=
 =?utf-8?B?S1ZON3Yvc3dPbFR1djdQNkJ0aXowZkdHNkJ0OVRZbWI4elhhbFA2SldLTHhR?=
 =?utf-8?B?WkVlcUNTSnE1RC9GTE5RWXg3RUVBbExXMDd4N3JjZ0RDdkNvZW5kYkNSU2xa?=
 =?utf-8?B?VUlOdHJoUDNKVHA1UWlvUVc1OXhTOHB3N1NnUE4vTjBEdG5ucjNMYU5FZm5p?=
 =?utf-8?B?dXhJY0N0cVFzZTFxLytVVEdqRnhaVG1NazVSS0lRZVhKQmIrL3N4b2pzbG1i?=
 =?utf-8?B?S2MxYytvR1U2NlAvYXJlcENIRnlDWWhtcHExc1M1bTJjTk1qeGt5RmRRVFBG?=
 =?utf-8?B?RzRFSG9SRXZQNjdxR3hlRExTa21oeDZiZGFpVnJJczgwVy9GY2lYWVZva3k1?=
 =?utf-8?B?U2c2cHRZTVpmVUE4c2Q1T2hCN2MrSCtLU3pzbjBiRFh3aHhrK2paOEV3TVVC?=
 =?utf-8?B?Q3lXN3J2SEkvQ3R0UGl0Rk5jL3I1UW5nQkwwRFk3VUEvbTQwazZxdnNBV0FG?=
 =?utf-8?B?bnhlT3hKeUU4QkNUVjVJbFRlak5MYUZCb1dtZWNiOFRDaEdWQzMzMGNJSHZS?=
 =?utf-8?B?bmthb3VQR1RPd1h4SkJDdEthN0xYVVJVMXRCeU1QTEdiOFlKd0pBQzR0R1Uw?=
 =?utf-8?B?dzV0SHh1U0RmNGtINWlSQnpYWjZialRheGN1eVI5RzJZeGxqQ0h3aWRkSEtT?=
 =?utf-8?B?QjJsYjhNSFQ1T2VzLzJkZ1BvMHpGK21Ua0k5eEt4OFE0eXE1blBaSVdnMkN4?=
 =?utf-8?B?U0JRZVVsL3RKL2dKY0pOUTQxTlA3NS9VcEVJQU9tUlR1TlRFemFRSDEvTTFq?=
 =?utf-8?B?YTFJUUZCU0Z3VFV3VWJROTR2L3dWczJnME9HT2Z3SmRWdW9jQkdvVDVGTnlG?=
 =?utf-8?Q?3ZXM47Munhbozoev92aFAkU4+o9vwrXIISuYtoXwtA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bN03frI+lvDqSjrxs/1oQEJhChDGNgHGzSgbgSiN8zkCtqXfYvYn6N71HOm71wLeKJ2r43cwd2dbbh0ew+3RVy5psyE/jsJRegF8N98nwgEMU/q5iEUzePtfyxKDRM7gJonlN7SytUb2tOPIZ5SmlCzAKhCd8pBR9wdk3U0Y7+GsOIkn/KV3ibK4q/kuaanO0PpE7Mrksu1o/BBvx55V7EQwXJsKykePL5FBucdlcAcW0tBjPZtQfXjOWWyJQhofAW2p8FLURFZlSEKMWoYFd4jmYkQ5K1DIyh+Z2R760dJ805FrSHZeFVBN02VmmfuobCZyLsKex8DZx+7/zwfEO/cO8I/yYGtDm37n/EXShqDaNPvmOm4E3YZr2fyEheaYEMBKoc6UYMZQUZ8RyT+Ly1BUYD/tfoRNLXqCDwTLG7K0RiMnq/DcizbcnmNI+bgy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:51:15.7473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c15178f-0ec8-494b-3930-08de6add0c35
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3543


On 2/12/26 12:49, Alain Volmat wrote:
> Avoid trying to release the RX DMA channel when an error occurs
> during RX dma_request_chan() call. Instead, jump directly to
> release the TX channel, if applicable.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-spi/aYXvY6NH7OlZ-OAF@stanley.mountain/T/#u
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Thank you, Dan, for reporting the issue, and Alain for providing the patch.

Regards,
Amelie

> ---
>   drivers/spi/spi-stm32.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index b99de8c4cc99..c9442326782c 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -2502,7 +2502,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   			spi->dma_rx = NULL;
>   		} else {
>   			dev_err_probe(&pdev->dev, ret, "failed to request rx dma channel\n");
> -			goto err_dma_release;
> +			goto err_dma_tx_release;
>   		}
>   	} else {
>   		ctrl->dma_rx = spi->dma_rx;
> @@ -2571,11 +2571,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   	if (spi->sram_pool)
>   		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
>   			      spi->sram_rx_buf_size);
> -err_dma_release:
> -	if (spi->dma_tx)
> -		dma_release_channel(spi->dma_tx);
>   	if (spi->dma_rx)
>   		dma_release_channel(spi->dma_rx);
> +err_dma_tx_release:
> +	if (spi->dma_tx)
> +		dma_release_channel(spi->dma_tx);
>   err_clk_disable:
>   	clk_disable_unprepare(spi->clk);
>   
> 
> ---
> base-commit: f921571df917408594a9039ed450859f3bf9cc2e
> change-id: 20260211-spi-stm32-fix-dma-rx-release-4bbbfdece8ad
> 
> Best regards,

