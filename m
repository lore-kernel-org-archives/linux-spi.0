Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284813C13F1;
	Wed, 20 May 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268986; cv=fail; b=VwElmKEhBMbPrbVHPolcA8k9IaPY59r1k4PpbgbIsNC6t4vGZnwN0ZrAv7tadF5/jH9ZPu6+MphFs66ZCIVqBv6bO0V6kLvZ+oQEQgVAN2741gMjpRTbed5OhyJAxNbWhYieXkf5Nd4he7x6Pl4Jzs0PMwxtdi3V8O5JOS06r2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268986; c=relaxed/simple;
	bh=+zpI9qByPtNcpxYohHwvAhE04TjxEtV+fN88yqLczGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p72EyGWwgKDkKPs5DY2DHn7w55lp7NiJacvikyp4lG2gCwtiLQPHIncGSv9pkztXJcc7N1tQrFdJwO4AbeIFV+mR0VlyK5r91C6b/8v2dPPf10mFsOntKzxuLkM1aQv8Msvhn0hnOIUXY/PkEW92c9mjGDhDL3ojPrCpdKo1Gi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bR7z+dip; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bR7z+dip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5bz8EiatepjiwvuGFUoG+tt9GCDchoY+0LpCWKoL+rU73+8jHhZFLggH96K4YQEJB8IT8nt00q/4XFHjXk3KhKtqbvEEekRUKWSusVaylZvHFMA73jYQpLxwp4MupPFF3EID/HHwifOuwbnKFy1RdK1sOBpfggqPrz0TxSedE3tKeLhWMtA5W9F4UgBgVOFkZytJNkQw6NMbP48ZIIbQcUZ5KjIwAKm92OW025ST4kUmRHoC77o7VpKtoJHbrY/lIcCIeDwbi3U8Ko38bTVwzTg6C8ofm1QnWYscTZgSHa4O8vyuHjA+joKsRoMwoN4obU6BOI13YWrwRiSfaLLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7xYjykNr88bw8JHoKylC86/lpbKGT2/hWvemHCoq0c=;
 b=YiBnHZHhg0wr9uagkXIK1h1CGx0z8lyRtTOOEbRuIaRyQpdDUBlW6zLghIuipYO4OpsEB0Z7pA6C9sJhsizTwd9eBY4rM1FNhf/5/aqCQvNIvM8ZwlYsWr76PiwqpRA0Fa8oydW9nLjVmvYDNBxSmlwzHXUoHarqJTpBxaKhn0jOaR291ZfNESQZHEJj6yJ2BYqlWosV4dkMrZjSOwHz8uRRmvt0Y713nwwAXKJCZLaMdoc2jIoQV6Vi2j0nkQDhMH8kYBxdMXlZUCMFBVOkxAhaM0Lulla3EYcYnBOSp5e8qrIofn0qebs69mE5gUl/5wQw0nVezgmJ9cQb0bQvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7xYjykNr88bw8JHoKylC86/lpbKGT2/hWvemHCoq0c=;
 b=bR7z+dipn8IktIJvMibaamv9UNOc4jyB68sW7Rz+49rKGeZDzbj8yatSagLI/Ucd90Hw+jfll3fsAzqdodl/5dFW37aOFk/4HgvNMjdnTowB2moGUV7kfnixx8MkT8MEYuql0lyK9+tq1CT+0TUALGvhwSS5j+bzt9I1HfbZHrGVGiyC/dnnF3+LBmiH0Yy1NeRGZAXyb0KxpZNm/7wYCZTaGWpag8K2WtFCt0SxDpADoU8Fda6Kv9sV/StyAHS7jJeiCW4Jd0M1sffmoLxUnCJ46PSjpJkeNZEdC6n5aO5A9M0XSNFau7aI6wJrjeMg37j1+TDEThkadfvbS1MFew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:22:57 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:22:57 +0000
Message-ID: <ad327285-aaa9-47b0-9d88-401c2f9509f7@nvidia.com>
Date: Wed, 20 May 2026 10:22:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
To: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519155108.4092518-1-va@nvidia.com>
 <20260519155108.4092518-2-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260519155108.4092518-2-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f67e95-ee80-467f-12eb-08deb6516163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QZ0GG43HanG4uE6uQybJk8wj/rI7PTrUWn+VAv+oPUF83l3YkV0cNr7e+JMECNxZtJRfbe1HRuQcgIKDjbTCDKleNeTuHfJKBnB9gdVytY/+CnM6IBMOB0g/e9ldZypsgw/X2cAidqbEODeQyraa8k5myUbcoILWC9UG0AUfI4WiYjAOHmIXLehKLLC8CvQI1hZk6jkIoKk8vBchA6M+NDgb4bPYiHYcHhsQ4eDan/x2jbRb7s+x9crTZ6My3rrxp1n2MEP6h9O9cYDbBM+1Q/IvVblj+/keYUkGht0smfAMN9JlLXW9rbrqXAZIBdpjXHOkV6a2V8fCpAkxJ142XCQNoVHxsp6k5ZfnZ+q7eTCVfs0aZvYuIOvMi1pzxvfVSQcEZy1m3OPB47D7n4esx2ELhKXewlOG8yFaJkDTGyJKv8fSRQwCv7i7ZrjrOGv2c7JD1inK+xa9N6systlt6kPDRQ2cUCZaVhONossL4C393TJwIep+d4nXGPCCLgPNr1VaJ4wx38FcqJIzh3TsZGaIZfwDaSYCTGaur0mn8zOPijhGMLhaNNmpW71FFuZNK3dGm70BEwiw4fcQJ2PLeNeT4uacBrDl/RG+6S5CgBdNHYRL03/xiInbDMlgpxQiQPypjQtQWStPI6F6nErcpMUZcIR8OvoPdlaT4xP0LZ59fqrW0i+nuSVzmSAIN7vj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aldyMXlvbUdDV2s4ZUFlN3ZhcnpDNk1aa2JmaFlvWWU2d01BSWhFclgydUY4?=
 =?utf-8?B?dHkzSnV5OEhPQmhFNUg1bTRvTlB6WHJiN0MxKzhDN1FEaTVBb3FHVGNVMkFQ?=
 =?utf-8?B?OHNlZ1Zxd25mY2VvNGJuSEV5R2NZUFZrV0V1Z3FnSTJXSWFSejBsYzYxQUFi?=
 =?utf-8?B?K1gwaGxWdkx1Q3NZcHY5aVNXcWljemxkdjVZeHdZYzNCK3gwWWh2RThRdUdo?=
 =?utf-8?B?cGZPaGE3cDNpTExZbG5XaktESjRoSXBSakVYOWNMTmVoUmJTcWdZWnExL1N2?=
 =?utf-8?B?emRodUVuNlV4M3EyUmExMmN2enpRalJlRzIxR3pDSnIvdDJXQytNL1ExQnc1?=
 =?utf-8?B?RTdGTEZydFplYU4xa1JuajZYRW1PZ3hncmI5SUd2bk1FU0owZnlWYjJqOEhN?=
 =?utf-8?B?cU5lUklQZVR5aVVkaS9rTjU1czVCWU8zbGpUblNBSUxiM0dzeHNhS1liSis2?=
 =?utf-8?B?ZmJNWDl2TTd6SkdFdGdlRmNadDVJOXN4alQ5WkZPL3ozazVlaUlYdlMvVldr?=
 =?utf-8?B?S09LS1NBMVZuSUFSZlFnWS9yWGF3Q0xjejliME96VGRoc21RclhMZDhubXp6?=
 =?utf-8?B?aDRJTmQ2K3p3SFZlVkdBSjRTMmh6ZWNsaFJxVzN5aWwrMTFXbTRDUXFsUVJ6?=
 =?utf-8?B?K2o1UkdnMlN4UmJIV2hvWjA1OS9WUGpSenoyUUdtSEtsWjR4OFdnM3lhSW9W?=
 =?utf-8?B?WkVObEtab2RHbTQrcXFkWEp1bU8veEJDdEhxVXVWVUFOMDNXcjRsMXp5YUpk?=
 =?utf-8?B?U00wdnEvMHN4RUIxMFlFNFluV3A3V3pnZlNrNmIxN3Fzc2xVNUJXMTI4dDk4?=
 =?utf-8?B?VVUwOFB2S05peU1EOGI1V2FIOU1kM3BQdktNSzJ2dFdKZ29OdjJqczY2N3RQ?=
 =?utf-8?B?SVpXTWhLQStHSy85elo5R1pDbndSMkJmRG1JSktGVHVEQVp6VXR1K2tTOXVD?=
 =?utf-8?B?MmZwV210bnI5dyswTmJmdjhmUjdPejUzTm05S2tEYWxIWVZReGZqSGtOSExi?=
 =?utf-8?B?V0h6VEsyamJsVXU2bVlldW5taWJMaW5wYyswNzNrU1lWT1paUURzOGhCK2gv?=
 =?utf-8?B?TXdaYnlUcHpCZ1lPTEdpbVdUUzBzVnpwYkhUUW9UUzRBK3hPMDRsbzduR2hr?=
 =?utf-8?B?WTRqVjZaR1pEWnZ0UUJVMG95R3k1akQ4cDJIMGt4RGZRODZEdFI3eHk3alNI?=
 =?utf-8?B?cUxHSjEvNGdqdWVvc0U3WkFCKytweFc1RDc5ZjVwcWFLcjcvczN2Qk02SEJp?=
 =?utf-8?B?QU1Sbk5XY0Z1YkdIWUdyMTdudU9GOU90NXRCdmpnZVc0Y0hEemxNTStVL1BU?=
 =?utf-8?B?NGJ1dmRBS09aSHJHOHRKaStaWkxPN0RwK1BaU2JXN2hoTnVVV0tCT1RVaFU3?=
 =?utf-8?B?QWIrUXJvWDhPdVcxaG1mT1grcjh0YVB5M0xhM0lSdENMYW9GTVIrRkNFQytI?=
 =?utf-8?B?NnJaVFRCUlBMZERvREw1WW1xRThLVnV0RC9sL1h6a0lFQ3RZUkhWZll3R2pt?=
 =?utf-8?B?cmZINnpQWHVYaVRTUXdrdHcwd2h6bG5pQlJIdng0ZnNaQUhxSWJhMU1pMThX?=
 =?utf-8?B?YnZGMjRXTEdqS1QvbFZ4TFRQR3Qrbk5QK3Q3bTlFZk9WZnErbm0wTytRVlJF?=
 =?utf-8?B?UWNWNFRaR1NpUTYvM0NnOXVHTlVxcDJQa0RwREo2YnJNYmo4QzRQYzBoSHBv?=
 =?utf-8?B?ZlVMd2RHang4SUNWQURna2xnMGQ1ODZheXR5MWxUbW14UVcxV0xRQ0hRaXVm?=
 =?utf-8?B?MWw4SlNHQlE0NGFMT2c5RmpLZldxb2gyaFVPSXVxRFJ6aTNFMzlGbDM2TUhH?=
 =?utf-8?B?RWY3bFUxMnlCbE9nQUkzclFnQWR1K0NQenNmY0lTMC9XUGdtakUwNUZWV1dX?=
 =?utf-8?B?bW5vUkZVUE1wNGtHNUtnN3dZUWRNcWNJT01lZ2xoOCtMWGxZQnpyb042WFZ4?=
 =?utf-8?B?QytZalJVV1dTL0ptYXAzQTBQVURtRmU0eHk5Z1BPWDRtUkZ3Q3k5d0VzdEh3?=
 =?utf-8?B?aU1vWHQxY0RaenlIUmJiMmFtcXgxenlycW1IcFFnYkVWb0xISHpTRTNtbUs2?=
 =?utf-8?B?Vk12eWdPbGY3LzRlbTgvV3FQRTNDaEY1QTNiWGp6eWdOWUN3RDFzR0FEbzhs?=
 =?utf-8?B?UkNWMitIcWFoZXZ3eXpTSmVHSEN1LzhPRHY4SWhvTTRKYXZNZS81bjcxWGlo?=
 =?utf-8?B?S09CaVZ4aWtzajE1L0I3QnZJaERzN3FsZ0hUZXFad2RuUWttSElYbVdQb2xN?=
 =?utf-8?B?SkVHZFo1NGNDTlBkNUNqaVV2TUUzdG1rbEs2WWdGTDFCM0pqVlVRcmpReHFN?=
 =?utf-8?B?R0hiN1Y5ZGRGeHlnOEp3eGVzRzYvN2o0ekVXamhrQXpXUWM5SUtmSzVKV21j?=
 =?utf-8?Q?VYKNv0MpGVAWFFJ72aFABdDtCG8tGQcDI6SkHuYsBBr18?=
X-MS-Exchange-AntiSpam-MessageData-1: U9qqXT+lhF2Wgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f67e95-ee80-467f-12eb-08deb6516163
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:22:57.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiG85x5DSCG9UOXjPGw2l+AagbUUv+jLgvMjmcYNKn9IioJToM4wLTFBFGHuA+jiodonP2vkCdpGrqGsuVGXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213



On 19/05/2026 16:51, Vishwaroop A wrote:
> Threaded IRQ handlers suffer from scheduler latency on heavily loaded
> systems, causing false transfer timeouts. Convert to hard IRQ handler
> that schedules work on a high-priority unbound workqueue.
> 
> The hard IRQ handler verifies the interrupt, caches FIFO status,
> clears and masks interrupts, then schedules bottom-half processing.
> The workqueue handler runs in process context (can sleep for DMA)
> and can execute on any CPU, avoiding CPU0 bottlenecks.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 128 +++++++++++++++++++++-----------
>   1 file changed, 84 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index db28dd556484..17d0b511af1d 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -191,6 +191,8 @@ struct tegra_qspi {
>   	void __iomem				*base;
>   	phys_addr_t				phys;
>   	unsigned int				irq;
> +	struct work_struct			irq_work;
> +	struct workqueue_struct			*wq;
>   
>   	u32					cur_speed;
>   	unsigned int				cur_pos;
> @@ -1225,9 +1227,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   
>   			if (ret == 0) {
>   				/*
> -				 * Check if hardware completed the transfer
> -				 * even though interrupt was lost or delayed.
> -				 * If so, process the completion and continue.
> +				 * Check if hardware completed the transfer even though
> +				 * workqueue was delayed. If so, process completion and
> +				 * continue.
>   				 */
>   				ret = tegra_qspi_handle_timeout(tqspi);
>   				if (ret < 0) {
> @@ -1344,8 +1346,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   		if (ret == 0) {
>   			/*
>   			 * Check if hardware completed the transfer even though
> -			 * interrupt was lost or delayed. If so, process the
> -			 * completion and continue.
> +			 * workqueue was delayed. If so, process completion and
> +			 * continue.
>   			 */
>   			ret = tegra_qspi_handle_timeout(tqspi);
>   			if (ret < 0) {
> @@ -1574,46 +1576,40 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   	return IRQ_HANDLED;
>   }
>   
> -static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
> +/**
> + * tegra_qspi_work_handler - Workqueue handler for interrupt bottom-half
> + * @work: work_struct embedded in tegra_qspi
> + *
> + * Runs in process context and can sleep (needed for DMA completion waits).
> + * Can run on any available CPU, avoiding CPU0 bottleneck that occurs with
> + * threaded IRQ handlers which are pinned to the IRQ's CPU.
> + *
> + * The hard IRQ handler has already:
> + * - Verified this is our interrupt (QSPI_RDY was set)
> + * - Cached FIFO status in tqspi->status_reg
> + * - Parsed tx_status / rx_status from FIFO status
> + * - Masked further interrupts
> + */
> +static void tegra_qspi_work_handler(struct work_struct *work)
>   {
> -	struct tegra_qspi *tqspi = context_data;
> +	struct tegra_qspi *tqspi = container_of(work, struct tegra_qspi, irq_work);
>   	unsigned long flags;
> -	u32 status;
>   
> -	/*
> -	 * Read transfer status to check if interrupt was triggered by transfer
> -	 * completion
> -	 */
> -	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> +	spin_lock_irqsave(&tqspi->lock, flags);
>   
>   	/*
> -	 * Occasionally the IRQ thread takes a long time to wake up (usually
> -	 * when the CPU that it's running on is excessively busy) and we have
> -	 * already reached the timeout before and cleaned up the timed out
> -	 * transfer. Avoid any processing in that case and bail out early.
> -	 *
> -	 * If no transfer is in progress, check if this was a real interrupt
> -	 * that the timeout handler already processed, or a spurious one.
> +	 * Check if timeout handler already processed this transfer.
> +	 * Can happen if work was delayed and timeout fired first. If
> +	 * so, we must unmask interrupts before returning, otherwise
> +	 * they remain masked from the hard IRQ handler and the next
> +	 * transfer will timeout.
>   	 */
> -	spin_lock_irqsave(&tqspi->lock, flags);
>   	if (!tqspi->curr_xfer) {
>   		spin_unlock_irqrestore(&tqspi->lock, flags);
> -		/* Spurious interrupt - transfer not ready */
> -		if (!(status & QSPI_RDY))
> -			return IRQ_NONE;
> -		/* Real interrupt, already handled by timeout path */
> -		return IRQ_HANDLED;
> +		tegra_qspi_unmask_irq(tqspi);
> +		return;
>   	}
>   
> -	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> -
> -	if (tqspi->cur_direction & DATA_DIR_TX)
> -		tqspi->tx_status = tqspi->status_reg & (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
> -
> -	if (tqspi->cur_direction & DATA_DIR_RX)
> -		tqspi->rx_status = tqspi->status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
> -
> -	tegra_qspi_mask_clear_irq(tqspi);
>   	spin_unlock_irqrestore(&tqspi->lock, flags);
>   
>   	/*
> @@ -1623,9 +1619,46 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
>   	 * cannot be done while holding spinlock.
>   	 */
>   	if (!tqspi->is_curr_dma_xfer)
> -		return handle_cpu_based_xfer(tqspi);
> +		handle_cpu_based_xfer(tqspi);
> +	else
> +		handle_dma_based_xfer(tqspi);
> +}
> +
> +/**
> + * tegra_qspi_isr - Hard IRQ handler
> + * @irq: IRQ number
> + * @context_data: QSPI controller instance
> + *
> + * Runs in hard IRQ context with minimal latency. Cannot sleep.
> + *
> + * Return: IRQ_NONE if not our interrupt, IRQ_HANDLED if handled
> + */
> +static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
> +{
> +	struct tegra_qspi *tqspi = context_data;
> +	u32 status;
> +
> +	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> +	if (!(status & QSPI_RDY))
> +		return IRQ_NONE;
> +
> +	spin_lock(&tqspi->lock);
> +	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
> +	tegra_qspi_mask_clear_irq(tqspi);
>   
> -	return handle_dma_based_xfer(tqspi);
> +	if (tqspi->cur_direction & DATA_DIR_TX)
> +		tqspi->tx_status = tqspi->status_reg &
> +				    (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
> +
> +	if (tqspi->cur_direction & DATA_DIR_RX)
> +		tqspi->rx_status = tqspi->status_reg &
> +				    (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
> +
> +	spin_unlock(&tqspi->lock);
> +
> +	queue_work(tqspi->wq, &tqspi->irq_work);
> +
> +	return IRQ_HANDLED;
>   }
>   
>   static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
> @@ -1793,9 +1826,19 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   
>   	pm_runtime_put_autosuspend(&pdev->dev);
>   
> -	ret = request_threaded_irq(tqspi->irq, NULL,
> -				   tegra_qspi_isr_thread, IRQF_ONESHOT,
> -				   dev_name(&pdev->dev), tqspi);
> +	tqspi->wq = devm_alloc_workqueue(&pdev->dev, "%s",
> +					 WQ_HIGHPRI | WQ_UNBOUND, 0,
> +					 dev_name(&pdev->dev));
> +	if (!tqspi->wq) {
> +		dev_err(&pdev->dev, "failed to allocate workqueue\n");
> +		ret = -ENOMEM;
> +		goto exit_pm_disable;
> +	}
> +
> +	INIT_WORK(&tqspi->irq_work, tegra_qspi_work_handler);
> +
> +	ret = devm_request_irq(&pdev->dev, tqspi->irq, tegra_qspi_isr,
> +			       IRQF_SHARED, dev_name(&pdev->dev), tqspi);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
>   		goto exit_pm_disable;
> @@ -1804,13 +1847,11 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   	ret = spi_register_controller(host);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to register host: %d\n", ret);
> -		goto exit_free_irq;
> +		goto exit_pm_disable;
>   	}
>   
>   	return 0;
>   
> -exit_free_irq:
> -	free_irq(qspi_irq, tqspi);
>   exit_pm_disable:
>   	pm_runtime_dont_use_autosuspend(&pdev->dev);
>   	pm_runtime_force_suspend(&pdev->dev);
> @@ -1824,7 +1865,6 @@ static void tegra_qspi_remove(struct platform_device *pdev)
>   	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
>   
>   	spi_unregister_controller(host);
> -	free_irq(tqspi->irq, tqspi);
>   	pm_runtime_dont_use_autosuspend(&pdev->dev);
>   	pm_runtime_force_suspend(&pdev->dev);
>   	tegra_qspi_deinit_dma(tqspi);

Looks like you dropped the ...

	flush_workqueue(tqspi->wq);

Don't we still need this?

Jon

-- 
nvpublic

