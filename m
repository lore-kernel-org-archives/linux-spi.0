Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5F39657D;
	Wed, 20 May 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269352; cv=fail; b=pRtX9rlNJAJ/IPeSU5dm/bHUYZ9ENW0BJUIx4M59CfQ+Z9wC97ZE0daJLySbgC68Ja4fUIHWELRca+dsrEDbXTQm4EccLOiGf49w2WqLhJv71jbo0ZqUQzDNcKT64Zkx8hqCApL49u0SugvU6tf3WcraS8AiKqNwM09yq9gwPQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269352; c=relaxed/simple;
	bh=ynpfiyZBlo4Eb2ViW6tZRosG5nBSLXAryaC2LPA9M/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5HV3BHvIEF3D0+gcNr0nnEfHpWS0sfJWjG1TZ82itZgSaW2e89dLa9qMLHce7zsGkaiy1IA4FOpyauAPvYc/HWSGc/WMHvvy5AZB6B503mEUZLl9a4WjsnC2jh2FFLGePB+ThV2/6HjkokwENusVskQxqGDMYT8PlN8pmjluqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lWkZzyOY; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lWkZzyOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjZu1mYgKMQlfF1wm+noizMK4oQYZbOaCYJHLOoQkLKeTYVISkwnTzO88zjSg+vPSWkd/F7Cr0a3NEA84EK3UENhwGRU4Xd1YDnFUyPBdjwUf4zo2V81sIpNyctJ4/50FwHVU2PSLYJp3/k+y/blwj4JnW5ltqJzipRnGR0+BKc9aEmbev/+b7O+hqObfCLYDKzE+F1FOYddkz1i1gi6h67+2nmDsspRcc48ezKjBQPzBwbtlEpRR0udhHxg5DAWRb1cUHW/tFkKrgkb0fM0DG67QKYIudQkGTQtk1CH7GUxIS+cnbrXeMDi+OBV8mfwxDR4SaxzIOZtwp7pH/qqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAa1zzgrsKBtJ4Ofa6MkTDuliOZjiKs0sa8KdPM8f/U=;
 b=jBcrxs/SvxjBuUjL+v1K6qwMirQ4eaRX7+RmgIMwYedLOkypP5f+CqaaQKjj8VRpmgIqTBd5KIVf+dvxfqfQX8SuR/3rs3YeBkx2Aocz8szAjKPhS5lS0kVYoRIFw0E2Lg8/erhWSZ5rnHpl5wLeVVwX0L+fqjA/WgLYwaihLZEcDL1IFpt/AZZHfEbx3YgXdbjVr03WWBNNRN3uGkbwnOn5ugKsBaipu0ukLK2l8IXll6gF9TYt80g6xkUjRmsSpO4Yiy7m1u1uNUJN5TVNcurB2fqafHdnnNgU8oG0EFCwQ5ZleKOg5V9Tm9cg8f72+YoMNQo/yCDSIuIwOxazPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAa1zzgrsKBtJ4Ofa6MkTDuliOZjiKs0sa8KdPM8f/U=;
 b=lWkZzyOYcfxtDSqE93691VoYWmOYPCTwDTBBW6MGqvOcgi+l5ZjoUXvjLee5fjGMfHPEgyYlCtOke8V5aiGEyQ0BOke0dT9zvNJzFu4x7tQHfrtgP0lLhbdMoucab0UYS3nwvWyhafizGCHL5xdUkqau8dp2xJZc+9wYWDoEhXh/sa1dX3jdgeXDNgSg6Pj1smac1zsibMeLx406eAhiplOOeuSRv1WX9z3nTH9lNPTx4A4FRF6ZLnoWiQYcZfyn5aYR2ekQR1d7cvAM+MKtzU64Jbo6OIgkutogMQ+pKU51D9lBcdR7zMwihKeuFvsKjS3FUtpCTh5Ukp2sZtsMgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Wed, 20 May
 2026 09:29:06 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:29:06 +0000
Message-ID: <3f41c23d-8e1c-4729-9332-c83330564fa2@nvidia.com>
Date: Wed, 20 May 2026 10:29:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for
 timeout handler
To: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519155108.4092518-1-va@nvidia.com>
 <20260519155108.4092518-3-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260519155108.4092518-3-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: eab50b82-24c8-4942-ad88-08deb6523d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	WCYswc7bo0zdFRKOyR/o8LeH35mzvZuhd1gzUS8fq6jDTDaTpzMLS079dOYS7Ftkz/oH2lfDSSVze18SKjIJfXqchxB92ncvsPceAEoaXMxQAAQaTuPa9pwOWfLlQC/YyNWoozyNomvqfT/cibScwMHy3MAH8MfQIWt2TgVBrxytOJFzzZ40slLU96kN7CcCi9RlEtz9AcuNE40d4/k6NX9DcByxfGl5P4/2CAAT4e7SU8l9tTL/84oBm7gr2DgglvSdcdIlKQCcv3arEg6bc49cZ/DroEViU6b/uamZLw2OHxxXsWmjP5ria5FJ75sCNXBIdMSDAsxWkbG4Xphy84rMa9d6V+3KwyTgIq+Y5JEg6dR/2d6VzAfE0KQgWxPoh1Bls04Nj/ymYi/9p1kOIEtexcJejGoVffjevbETzx6rsh4YOsuvehRIqWqpwqJP3LlUiy3TuSv/5mOoOs1pJvjH/I+bp/L/IVRP8/sTenCN2FH4IOxP0kWbb+nEp4GxkSANCotwHgauRS+qEk0oLHN3gTGkiv5invYWbS6DOwl3+63IALxU/lLtyQDy2ndE+CKfcRngCjSEdeHW39faNP3kgwUO12o8D9cNJGcFVUyRMOPYdq+QgfsM+M3PMycu26JRjOVaxLfrFy1rfm7RuOjebNOJAFtR6N/ufILDuhORNuREYycrLPMWLJWfj8vK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGdDY3dVbzR3Ny94Q1pBWUkxbVhGb0JFZkc1bUxCMTJyb1dpVkp4bVpvbkRF?=
 =?utf-8?B?ZUlZZmZoeVlORi9oVUE3K0FqUkJ4U0pjNExPcTJFblZscTlQSmJXTnNmMGhL?=
 =?utf-8?B?L0tZME5haXBOeE15VkV5T2dKNFY4Z3JTNEUwSzFUMDFPeWNYQ0N5VE5VQWlh?=
 =?utf-8?B?dFNzSXJTWkRLWUYxTU5acy9mZmJWeGVRYzVwcWJzQ3ZJdzBtbmIvRTlOVWdh?=
 =?utf-8?B?WWFUYVE5YUJnMjRKVlB0V3k1SldNVE9QcWFYVldoSTJTVXlnNWVKbWpYUjU3?=
 =?utf-8?B?Y0I2OTJ5UDgySmhFcDNyZ055dEprQ3BQT096cktGRnFTVm1OTnhvSmhDQ2Y4?=
 =?utf-8?B?MjI2NmJPamJyczZuWVhzVWt0cnZ0Q0JKM2Y4Q2hnUVUrRTFjMnlQTU1JczFt?=
 =?utf-8?B?OG5FQ2pBUGVKZlZNUnIzSmloS3lIdEkyZlR3VWU4T2UrQjUzdkhqWEFxK2xH?=
 =?utf-8?B?Y3MzYzVWMFF4VllDVjZvSEgvM3hBU0Z4T3VWN1M4aDM1NFBSWHJnY3ZBQXIz?=
 =?utf-8?B?eVU0Y2EwY21EZlQ5RlRCV0RUUEo0OHBzbXo3UnFWa09LeHdnOTI5S3lsbzRv?=
 =?utf-8?B?QUpjL1R3MXFKN1k1bnJxUkk0SWNnTGRIVW82YUVBdFg5WTZqK1hkd2pVNGxy?=
 =?utf-8?B?VmMrN3M5VjNDWGFuZktHQkZSaWYvM21URk9Tb2ZyOVY2YnBPTS84cUhBdUVP?=
 =?utf-8?B?dVBhZElvVkVhK21lQVgwMTJHZm5mNHkxcFcvNFBBaHFaRFZtOVVRSFIyYTh5?=
 =?utf-8?B?czhzS1hoOEpPQWk0L3hvcXpoRHloa0RwbkhucURPWWJqTjVqS3ZLMEQ5Rmkz?=
 =?utf-8?B?MVZwMjB2WEZKV3FHL1hYMFF5akUxbFcwTzh5K1JCYTZsUFBQR3FGbTdBb3N6?=
 =?utf-8?B?WkZMQUY0MGg4blBpWFk4c1FTWXV1TDVLZDJBQjF4K012UzZUdmtxT2wvdWJP?=
 =?utf-8?B?WmFlNk90T2FDZzAyaEl4WUFORTFodXkxRGJBQmIzZVZRdnlkalBHb0tBQ3No?=
 =?utf-8?B?Z0p3N2doL0FJK0tvOWsyTXJBaXVvRjZKaERseENiVytkVHNOS3pTLzlDVVFk?=
 =?utf-8?B?MXNGRzc3dzU5aEFqUlhkT2pvVGxTWnRUYUMvcGQ5aHVuRWFIYUJEcmZ1NlhB?=
 =?utf-8?B?YzFnZFNLc01zV25LN2FzejRMa2hHVXFZdjlnSnVOWkhleU9pWXUzVUMyY1Ns?=
 =?utf-8?B?WjNsN2l2ZnNUcGdRTmVOakZaVlhqcVBTNXpTSHVGdWU2L2VxUnpmeWJORHlP?=
 =?utf-8?B?RmE5UTByYjdKS1RRYktRN1BLdXV4MGxzdm11RFF5MDJtbDFKdWtrSVN2eHlZ?=
 =?utf-8?B?Znh5cjhMRFc4OTlaNlIzOE52clhLT2Z2ZEljSmdqQTVvREpiR3NDSWZKU0Rx?=
 =?utf-8?B?NzFZMkdDQllheERWRUFXbzNDTFIvdisrT3dOWlJWNmFsUHBvd0p1OEV6Yk94?=
 =?utf-8?B?VDhQeGhtQVdSaitJM0psNXZPdFFEWHRkMndwdk1KN0pNRkFkSzJEZmYrN3Zi?=
 =?utf-8?B?ZEhZWm9rbTJFMlM5TURsNStaaW9RWVIwQmhQL2lUMzVoa2wvWnBkNkJKZ0RG?=
 =?utf-8?B?czA0allzcHV2RVJCTHZQMTBWSnE1ejlrQzRBcVFQUFNzaFM1TzFuQUl0MHFk?=
 =?utf-8?B?Tm4wSVd5aFF2aFVIcjVYakF0N3ZNMm5hcWF4cVFCaXBXc2h0c3FrdUwxWnpz?=
 =?utf-8?B?WmhDSXlBMGVSeTMvamdjaTdSakk1ZzRhckdBQ2FpcCtpYlNoMkV2S21GOUNq?=
 =?utf-8?B?ZDVqbnkrQWlmSE9mS0ZoT0VkWmJiOW53cmdiL3paTnpvVHdrZ0FnNmdRY0c0?=
 =?utf-8?B?THZqMXhwYXNhUHNOQjZxa1BhY21wZCtva1NMZ0NpU0tCZVd1aThJbThlVldT?=
 =?utf-8?B?Z0dNOUZ6dW4yeHF6OTFONHU3STRpOVdIbWpaU2VSLys1N2hIN05KMFVlbi9E?=
 =?utf-8?B?eXAvNDU1UVRzb3NaN1p1N1VZckt4VThWMDNDd0pnU2FVZEZFeHp0dm1MUi9G?=
 =?utf-8?B?MzB1dnc2a1FBMFEzQ3o4RTNGdnFUV0w3ZFdtUEt6eG9oaDF2MTVpd2sxT3Ra?=
 =?utf-8?B?ak1FWXlhMjhsZHlyYVUxbjNud1NGVFJPNkV1aGZlL3JrbEhWOWR2SEdMSVJD?=
 =?utf-8?B?cjZBV3lCb0RwQXNOSnhyMzl4cklhOEZJQVJKYmxTd01naGpWRUt2eWZ5NkNQ?=
 =?utf-8?B?ajV4RmZuZHBCcmdaOU1aM0VnWUZyS05QQTFBdGVsY3FaQUVVaE51bXNtNUwx?=
 =?utf-8?B?VEttdXVLZUZYc0tyazJaTk96NWxnRlpUbkFrelFzUDkrVjJVU1dSVy9QZng5?=
 =?utf-8?B?QkNvdG1TTXpYWmJIUGdRcXIxR3YrazlZSFU5dlVtWVN4M2czdmFrNy9yUk1r?=
 =?utf-8?Q?83EJPC8GkvBzvpglK7/EB3CA+eEeaVkBHvMM8LxUgvU6K?=
X-MS-Exchange-AntiSpam-MessageData-1: z2CgvSozgArz+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab50b82-24c8-4942-ad88-08deb6523d48
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:29:06.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLdUSmn3xuxFqmg/pUPdxNxxp6uMgQ1iebAVApfMpFM/JW5L4N1Dui2UIaUrKErxG2aLbhluFSHVtkM1JUrdGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145


On 19/05/2026 16:51, Vishwaroop A wrote:
> The threaded IRQ handler reads QSPI_TRANS_STATUS to check for transfer

There is no threaded IRQ handler now.

> completion, but on heavily loaded systems, the thread can be delayed
> long enough for wait_for_completion_timeout() to expire first. When
> the timeout handler then reads TRANS_STATUS directly from hardware,
> it may see a completed transfer but race with the (now-running) IRQ
> thread, leading to double completion or use-after-free on curr_xfer.
> 
> With the conversion to hard IRQ + workqueue in the previous patch,

Why not just explain this with regard to the workqueue that is now in 
place? If this issue is independent of having a threaded IRQ or 
workqueue, just explain the issue independently of either a threaded IRQ 
or workqueue.

> this race still exists: the workqueue bottom-half can be delayed
> past the timeout, and the timeout handler reading hardware directly
> has no synchronization with the ISR's cached state.
> 
> Cache QSPI_TRANS_STATUS in the ISR before clearing it, allowing the
> timeout handler to check the cached value under spinlock. Also guard
> against curr_xfer being NULLed by a concurrent workqueue completion.

s/NULLed/cleared/

> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 17d0b511af1d..72f66f2c6dab 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -214,6 +214,7 @@ struct tegra_qspi {
>   	u32					tx_status;
>   	u32					rx_status;
>   	u32					status_reg;
> +	u32					trans_status;
>   	bool					is_packed;
>   	bool					use_dma;
>   
> @@ -854,6 +855,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
>   	tqspi->cur_rx_pos = 0;
>   	tqspi->cur_tx_pos = 0;
>   	tqspi->curr_xfer = t;
> +	tqspi->trans_status = 0;
>   	spin_unlock_irqrestore(&tqspi->lock, flags);
>   
>   	if (is_first_of_msg) {
> @@ -1068,26 +1070,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
>    */
>   static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
>   {
> +	unsigned long flags;
>   	irqreturn_t ret;
> -	u32 status;
>   
> -	/* Check if hardware actually completed the transfer */
> -	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> -	if (!(status & QSPI_RDY))
> +	spin_lock_irqsave(&tqspi->lock, flags);
> +
> +	if (!(tqspi->trans_status & QSPI_RDY)) {
> +		spin_unlock_irqrestore(&tqspi->lock, flags);
>   		return -ETIMEDOUT;
> +	}
>   
>   	/*
> -	 * Hardware completed but interrupt was lost/delayed. Manually
> -	 * process the completion by calling the appropriate handler.
> +	 * ISR or workqueue may have already completed the transfer
> +	 * and NULLed curr_xfer between the completion timeout and now.
>   	 */
> +	if (!tqspi->curr_xfer) {
> +		spin_unlock_irqrestore(&tqspi->lock, flags);
> +		return 0;
> +	}
> +
> +	spin_unlock_irqrestore(&tqspi->lock, flags);
> +
>   	dev_warn_ratelimited(tqspi->dev,
>   			     "QSPI interrupt timeout, but transfer complete\n");
>   
> -	/* Clear the transfer status */
> -	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> -	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
> -
> -	/* Manually trigger completion handler */
>   	if (!tqspi->is_curr_dma_xfer)
>   		ret = handle_cpu_based_xfer(tqspi);
>   	else
> @@ -1642,6 +1648,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
>   	if (!(status & QSPI_RDY))
>   		return IRQ_NONE;
>   
> +	tqspi->trans_status = status;
> +
>   	spin_lock(&tqspi->lock);
>   	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>   	tegra_qspi_mask_clear_irq(tqspi);

-- 
nvpublic

