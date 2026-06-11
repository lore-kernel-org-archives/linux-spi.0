Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423782BDC2A
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165589; cv=fail; b=DvY7nvJNxGHo0et/hOOukAhLNNpeaB8VeCBwVooHd0gtKvC7P94lY4ctMnHqREm3jAhcViOa5vwXz6iArIaM4ciXdp8NfJ6pqOB+XLjaPXPAVmBQZYyqAE+eGGWqs+oGuJPIhBkj50uR+aXVZJUKUUTnFp861R3NV/aEuobFdV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165589; c=relaxed/simple;
	bh=xv+PYdbzOP/uyasJlckl38TfILXjNJysGvXi6MpJCcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hz7cPRqjfN3DFlsPXiBJrHrfU4d2S8md7p/oriA/lptQ5Ugbrumcb+66pMFrd1YKWLqYzPpABINKIgbCeFXEd86T8/3QoPBwpvvBh3wAkAaX98/El4B8t0kMs3UTs72SPrWR8xFwwMScbW11LMjfqQNxBYmMnAe1O6jsmXDTjqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vcrr9Xz9; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vcrr9Xz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNURuU4LDEOpw6icaK9Jeyz4XW2ZKVUbSbPwiBGv9XvYIU6pinfS4ZfTLLPLAgWwp3SHfNr1w+FIT60hDUIQK2LuLWdaL7AkpMn8YqzVBpaal817Xf6iXzZ2qrXmDuy086y93afMiWlOPW+i9jgceLgjo0RpVRr0SGg9n6BVprUvMCvgWndeJXL7bBjhAQSpQUmZgYgyA5sDPuiPb6Df1HChOOAQJSzVjKsA5mfuCJn8YdhaV91o0hTtilMw/vsQ/q989tMGTTMDS0ARvF6LAhbPUHFp9Ct6Ob6veVFejJ1StO8gPs6I0yzUSaUFQ9rZsaUL6pWwJOc0W4hIv1tJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykHZ90FOrOsCt5JeWFCpdzCM4GqH2iqe5//ZGheHZE8=;
 b=uc5jktLkS/CGU4QHM5YwBfRDw20TEG8uc0mhL/wIvwdtMksojgrJOXEcR/FeJ3LKpj5h7PcmBg/gVK0fS1EpYuzUh1DbUPHldHdyi4N8kpVIUWR4ivspGV3D1DxqIdcmzcMvQisYX0TuWWWNPxk4QTYWKpy0pvq4euZ4WwGNaqHeh5B2ckttNNEGqG78IgB43VGStsRaLHiN6cK0YED0h4d0um3wzZOjcvCfbPbrKteZ6RGPP0RHigFHBLU/5csleFTL+n7GcTfFxWDPCXeDG25tp0heq8yipi4b8HCQ6OGhzxV3y8+TyDfEpqpGigMUx9fFJR1mkqFv8JbNEVL8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykHZ90FOrOsCt5JeWFCpdzCM4GqH2iqe5//ZGheHZE8=;
 b=Vcrr9Xz9uLua2HVu6Ez+5wRp8v4QaG2hTnGgrs0GyuDwJo8/d6xKCMKx2gTFIlW16V/s4arMBRsekY3LNcEPP5Z2sbAeKMfSDf2CZGFPu9EB2ZrN9zltaXTI/CfM4nyJPGRrc1LVlUteRzF0qrKa8vbnHk/8g7PPeaP3CxXIFZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:13:06 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 08:13:06 +0000
Message-ID: <c9f512c7-8d4b-46ec-a70b-792198eca94c@amd.com>
Date: Thu, 11 Jun 2026 10:13:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx: let transfers timeout in case of no IRQ
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
References: <20260610222843.782337-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260610222843.782337-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e99ad8-3c1d-40f5-4582-08dec7914453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zcYX89V4xszEtXxb0WVhNL+Kd5n4Ugqisxp19MuCNKlbdjafCXotD1i1SMaCR2V0sCHlp47mkbL/2sfd4s4n6QKK0JJYQIxmXmNiopJ1dAIbfnAStHwfk0YSMgswRBn1izkKKsKVk+I5OzgrhhLxC2K4stSDMwdFTmqLngxgC65A2gZC2ahn14crfh2VF8L8AC0hpGuRyoUr+xfGJicCtyqFopEfwSBtMoEK7zsbJzFH2/J130ZkuhLYDE2SalxNGVw+Z4g0X0DONb9jMyoWQiPTnLxYZjSjwUbEgUvZLqEU3RuBsVZtKszcjXJ3IWKgff2M5W0/cp5o97h50fYN6OxmmfytdjXpT1bRPQsfI8363ugm38jdgzqSzyal5xfSqxDm/OTuT2ms1eF6DWgGl9uwWb/PcOEsvXyQ0d6lWtyPVIphSTU0CjNnc8UAkoeqD+S4w/YPcrjm/GwN9nWZOryv8GHqAC6fTzAoKzPa62II/9ZrN/oSR4P9gz7rbzvD9D39ELrMw1bhFjhwci70rU+VVI5R4zwQBFg07PPFQZ6YmLyrls/gX69BJzBd6mEsdiLzs74ucu4s9e4yZL3PNcJzRwKikXkMZ7UBTUc3JZL9Fs3YQIHM8uF5L7e7viJrV766OcJHZ8CAyz40P78ng4hhhBT/vs4Nbdvdz1xT6GrR7agkwkz1vv+ejuAIsrB9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q25RZThRVUZ2VG5rOTZOVG9EVVYrZDA5KzNsQkZxOFVQWGVpQ0VoQ1BDWklB?=
 =?utf-8?B?cEdMTDZqbjBnQXJubUg1QjU3d0xQWVVubHdxaURnZWlteUw1dklSOWo5Zzhj?=
 =?utf-8?B?NXhuVERnVTluSFVNWkRmRTZtcWVZZ1NvbExLallrLzJxN3J0WkVXT0ltZW1y?=
 =?utf-8?B?SjFGS3J2cEFtWENpTk94TXY0aytFL05ldUhndG00NVIvb0RVSmg5L3dHelJT?=
 =?utf-8?B?VEFESW1VcFI5d1dkRFd6TXdxVko0cXJuem1qSEE2NFoycU14ZnoydXVZdlg2?=
 =?utf-8?B?dUErNTNNaDhZNFBjZG14N3dCN2RnOTF4RGtZU2huRnI2cG55a1J5UUdnMmRP?=
 =?utf-8?B?WG1XdHFHbDhwTFdpM0o1am40SkZyTFRCU0NqVno3NjRldlNReFpxd3U4QnJE?=
 =?utf-8?B?TXBCQ0RNN1A1ZW0vVE1zbkRncEpFN3VyTHRUQjc4bnAzNXdVYUdRY1JhbVRX?=
 =?utf-8?B?N2Y2QkZEL2szWmRBUzBSaUpFZjVwcmRQY2VEKzdFMXhIM0FUWDRyVGpYR1B0?=
 =?utf-8?B?MlBuUDFDem9kS1lVWFpBUHNGY2FtdGI3SDRnYXdkT1VFR0oyVkpFZFdGYzNi?=
 =?utf-8?B?V1djZFhxY2V3VXhnWC9JTHFlV2NtVWNXaTZyVzZobDlYVjFwSGhESndnTE9Z?=
 =?utf-8?B?aEx6a2ZycndxajJvaTEyeFBDSVkyaFFuOE5NdkFsVUlTb2lYS1YraEduM1VS?=
 =?utf-8?B?OWFIZnd2WnQxSHVtTzBiSHhSSDdTZWNHNk4rSEM0VnoycXpvTGhrcHFibU40?=
 =?utf-8?B?cW8vbGZ2NEFNd2RpNjlwS1FjTXFjYy96d0lvYy9xclZmL1BEZWN6cjhnV0Vx?=
 =?utf-8?B?Y0wzR2U2YVJKRmxySC9lSnQvenNGbTBDMUE5Rk9ZOE5VNGUzd09xUHZLQm51?=
 =?utf-8?B?ek83TzFjd1I2aEpSOG9XZkI4LzhDTGY0K2RSOXZ3WGZ3a3N1WkxjcVplUjNR?=
 =?utf-8?B?dllhMnBOcHIzbDk0V1FLdmc4UnRRVkQ0WGVYTDNJZ3d0ejErQ01aYUtCR3NU?=
 =?utf-8?B?dU50ZGFHYzIyZVM1ckg0c1F6K1pnd3ZZOHB3dlJQVkRrWlZkMHluRVFLbHFo?=
 =?utf-8?B?My9HdUtOa203MjhBVHJ5S2k1ZVh4K1M0THh5S0RXVlh3b0RKd003VkthQnVW?=
 =?utf-8?B?K2tFanBzWGRvZVFLdU81UVdpOUpFa0p6eHVQQ0hnUmhBMUcrcmdLTTN4dWIr?=
 =?utf-8?B?OTlJU0xwU1JmNTNaQzVLTjQwcnhxTURvdnNKeGloekUxaHJwdXpWaGQzNlh4?=
 =?utf-8?B?Qm0vbzc5UG43UzdvRXJYSmtGL2ZwVk11UFdPdFA2Zit0SGNTMWV6QVJ4UlZX?=
 =?utf-8?B?RGQ3M1dqVE9uSk4vUElNQjV1M2xlTjY4U0cxZSszQmd2T1pyaFJsZHZPV0VQ?=
 =?utf-8?B?bkJ3RmZWQlU5amhPT1A3blpPK1YyU1VaUmVvMUpMTXFhRHdZVmxMb1lJVzB1?=
 =?utf-8?B?L1psYVpQbllYT0ZFZEwzQWFWRmtTaWhweDUxaSswbkhqczhZMllESUpqVnJ0?=
 =?utf-8?B?NFcveFZtb1lqZGVvK09rODNzK3RPblM0NkJQUzR3K0ZNcUNHV3Exa2Fac3cy?=
 =?utf-8?B?bzBEZEZKZnl6RUpEVVd6cnloVEFCTnViTTBMRzR3OW1FNkpVMWtWZ241WXBY?=
 =?utf-8?B?Zjc4THc4a1p2YnhZTnMzdm1rV3dzNk9pR1M4blJ5L0k0bjI3MUlzTlE5NEJM?=
 =?utf-8?B?MnZyc2lXb1Baa0UwS2g3NmVDc2ZqcmZLMGxTd3lOSzNybkw5UVlGQ0hOVkYx?=
 =?utf-8?B?VWJVdGRWYVZ6MC9OdUN5U2dISWZldXRnQ2lCZWF1bk9XVFBGd1NKUUNta2s2?=
 =?utf-8?B?U3ZMK2IvRG1QQlRWQyt6ei82Z2toVnJ1ODl0cWhWVWZVeVBvTHE5bTBLY1FD?=
 =?utf-8?B?eER3NDlSbVdxS2x2K042dWp2TndIZ0NIRVJMc0NCVE8waFVSOCt3T25hYTVU?=
 =?utf-8?B?dW9yZFRmbXlxRFYyblAraW1aN3dwWFBwN0t6YkorN2xRcWlRWi9ldXRjRTla?=
 =?utf-8?B?U0IvSzd5RXFDOGZZNnlYUWZ5NXRZZFZVYmJSU3hSYXYraHUxMDd4MVdiVXpH?=
 =?utf-8?B?MWxpMmd1SnhKTndOdDM1YWk2VXF4Ni9xa3AzOXNFQStDUzJ4Qmt3MUFjUkty?=
 =?utf-8?B?Q3A3S1RjREJ1ZWRna0FidXhnRm9oUmc1dEZNbjhNbUloNjdzMXVuYWJsbHNZ?=
 =?utf-8?B?WjlZRytlKzIrS0s5M2RCY2phNi9HVUVaaDBYUmM1UjJxMXRjZyszblh4cEY5?=
 =?utf-8?B?RUpBUmNPMjZ0ck5xZWtkalFCZFY5VTdodU55M3lCTnQ3Yk50dUJyMGdtRGty?=
 =?utf-8?B?enZJSHhNUGJOVk9uWEVrTTdodnI4Y0VvSU0vTDV3cDdEd0k4WG1rdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e99ad8-3c1d-40f5-4582-08dec7914453
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:13:06.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vj1CFy4XhCNzJbqRH5q/w5P5/Itv+mSzTyZMHw/lMfaVG1hK5XZ/mObLqZEYO2I3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840



On 6/11/26 00:28, Vadim Fedorenko wrote:
> In case of failed HW the driver may not see an interrupt and will stuck

will be stuck/will get stuck

> in waiting forever. We can avoid such situation by timing out of

Imperative mood please.

> transfers if the interrupt is not seen in a reasonable time.
> 
> This problem can be found on unload of ptp_ocp driver for TimeCard which
> uses Xilinx SPI AXI and SPI-NOR flash memory. During tear-down process
> spi-nor drivers send soft reset command which is not triggering an
> interrupt stalling the unload process completely.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   drivers/spi/spi-xilinx.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 9f065d4e27d1..471936a7bb75 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -285,7 +285,11 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>   
>   		if (use_irq) {
>   			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
> -			wait_for_completion(&xspi->done);
> +			if (!wait_for_completion_timeout(&xspi->done, secs_to_jiffies(1))) {
> +				dev_err(&spi->dev, "SPI transfer timed out\n");
> +				xspi_init_hw(xspi);
> +				return -ETIMEDOUT;
> +			}
>   			/* A transmit has just completed. Process received data
>   			 * and check for more data to transmit. Always inhibit
>   			 * the transmitter while the Isr refills the transmit

With changes in commit message feel free to add my
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
