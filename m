Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023114.outbound.protection.outlook.com [40.107.159.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A52D24B7;
	Tue, 10 Mar 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152355; cv=fail; b=hFhQH2G6IQTIVjhRNURlj+QO9c52qiQa7In0i+oVX05+jEdF5H9jq3cLDlrzAvsvx63FS8alkRheeOra3U9N2B4clz+Pm6pCEjrwpWRLxAdgzPzRAqYGgm0hdnJpcpoa2I0HXQdF7gWIJP63MJVp2jOnJqAeypVWa/aasbCxMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152355; c=relaxed/simple;
	bh=jV+Bkhl7xXNbbbpUnn97vVct6sVzjeh6D/qImP0wHno=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUUXPTBhfhkmprV0SRrhKJN2gLSXALGOtcRY/kmkLn3LOkqprw00Iudf48Jwm9deHoeWWuOUWjNpGsvF94s4sVT2Zk2DbwmMWJPkdUEaAM3RQzUdYYOgQ1g0OwFeHVOZYTeMKsNYYWsSQU/ocSf0wGS8YTVOdlw/dv60knr6gD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=LQV2j3aQ; arc=fail smtp.client-ip=40.107.159.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="LQV2j3aQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+egTDGyRmNyfCI/dJyhHnk71IIROOQHk+cMvY+hLtIQkz8wYxk/zYOrGEyVb2j8V/lW9oNReZh/PJDCi2rJLomqEbvKqSQ4Tn8HUx7ZnBtZ209fVLUAWwcghErxfeV6lftVHZm0CoHsKr/H1vRD1yT4NlPCINhLTowpzI1MaqIC/ccYXKZqlz3Xlog6iVtvJWHzl6SqkILx+Ju5CXDo9DEkkfBMffGW3Y3kvkBIkmjyP8uT4Hk4BEMynD2kYF3S5XGOqRl5NEFESv+9LqJP8y2nFEmn58A+qgwAIghB554eaeFBRABP4+6LbhVmOrqOyXGcXIpST27iUc/2cOINTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhPorSgA7mm5DXB0eVmQwJ7f5aBM/lrnQUTrTzpORAs=;
 b=tYn0UW5+rMy2tOVtwinrT2IfctT7/K3hsGojONInohP3yGSUc1dn4IYtR4UPxBSgTwEBmfGmxdQMJuX5sZiHBpPcFBM0oT6STRN5v9dpozaZZuwsebqams0b/ctXLMFKhVINaAxSluZIi+X8kJ09RR4Wdi20oWIqWmYgJkQOXQGGBzMLmaMZD1W+NuugFZAwl+FXivztG7ovwIxTxOU3O3FMshjANq8k74l9Ymse/MmtXW39gGsMb9pQwIAlb6APc02Zh+kZ533xsOLUxFF/NdpXn7AhKTFp5E7ewxJ6aYOab7dZKgghqzjgkpZPZId0036fG112LbfANpgniW7xLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhPorSgA7mm5DXB0eVmQwJ7f5aBM/lrnQUTrTzpORAs=;
 b=LQV2j3aQvdny7+vDt1jxK1gkitiZrpYp0qW+C7MN+OnyGIyUM4uoBFi9nKaPJnBAs7vzvcwI9ZgZzLdjh0x+6L0paMhSPYBTETAjWi3uQo0g9Mow1PfBTZuefw2GdHCjJNR2ZOAUTpCa4M+5EZ5+fYv/SicHL5/Zcvan00o7p6Yd9Rom/Z5btuRNxdVk3juavPi2Qqqdt/kjJq+OIx+kuDCs+TM9paDiuc1hpB/h08pkrib6YeBjrK8StIyfw4+9AZKIabfJNifxv2yPr69cfAoGOAEhzBMg6ZEM6QTAPNfhIc7Z+lPV+T41R1A2ld7UAmtnEv3nyR3j8vflizcf6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB8040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 14:19:08 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 14:19:08 +0000
Message-ID: <670be8d2-2705-40e2-a788-aae9e4f0cc2b@kontron.de>
Date: Tue, 10 Mar 2026 15:19:07 +0100
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH RFC 5/7] spi: Add RX sampling point adjustment
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Frieder Schrempf <frieder@fris.de>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Han Xu <han.xu@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, imx@lists.linux.dev,
 Santhosh Kumar K <s-k6@ti.com>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
 <20260303-fsl-qspi-rx-sampling-delay-v1-5-9326bbc492d6@kontron.de>
 <87fr69nhxs.fsf@bootlin.com>
Content-Language: en-US, de-DE
In-Reply-To: <87fr69nhxs.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 32992277-df58-4031-c51a-08de7eaffe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2XXnFxV12u9ivTa6ybwBOFTk01OLMXIQLSzJSXCGPVzv7DbFKJ+EqixMkTw6hSN6dx9GFIvSwFkDBbSTBZ8maOdalAr3QgoVm2/i5NIwEy2DQWH4xQBYdX1SRpSreJ8ObWU1ePMvHMUaeitMvnPgCcwQNWnVaQSKQihAWRABN2OybCk7gL9NiThWTqJgJTl62pUsV2dv+xln6p6TkOVbtbNbFFKQrxi/Omc2K80zsgrj/X4nnfh2PhDYqvYG8TQoe0vJ6zV6Uxj7iE7BwjBJxSm94zO8Qt0Ovue8Kga08WNSe7M1/+Wzf7k3TesqmTWXyo/FFR+9IkhEWjwbPyxx+/VgGi77fpUcCXFgJiK3zn32Tr1aTsaRWUKdiVS8Q5p0sD9owiq+rXL3X91BuAFqf6AqrSPWTGiG43bJ9LIKVIBWcJwPUo74X70tQD+RAd9EbHCz5j7Y0AwjjanB32/UCWH5/I56hMfM3PJD4vpnOGEhWioF+acyp2iCVfB0uyqyuzKC/qLW0da4iIFCV29Wm5wucBHSllBbj3HJPsAsKZXbJm4RyUeZovRUTmOmXU3l9+H6VMfvrVexlorJrHSA9+/oUhN36dUFdh914NxmoOUaNrOxK/QzUaHe+IbUAOEU4OlpxAWUxNN3bh7MNqT4o0oEXWgM39hjT23VX5KT/KucYIHDPji0BoRF/bG0cAXi6e7obkhW8lExC/p63Z0Qlc58K+hMxA7I4XyZj57wDuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU91a3ZwTVZjUGF3ditmazJ2a0lLT00vYUFXTlk4cjY5Rk51YTJkK1JyM3BV?=
 =?utf-8?B?T2ZHR3paV25zV3pmbjdQSWsxemlyU0NXOCtxUFdWNHJJWkNXVUVtL3N2TTZr?=
 =?utf-8?B?ekZlOWUySnBadVVKdll2ck1oOTJDSzh0bDNESllmMjFYTUVPUDhXOVJOWDl6?=
 =?utf-8?B?ZFlaOGpkck53cElFMTZVcWJwQXc2SlJxUkNSN002Tzh4M0RGUFJENDdhaGRQ?=
 =?utf-8?B?YkljbE8xVUQyRFJ3ZnBFT29FVmFZUTNEMmlYbVZFbVRnUzVSckNPdTR2NHBE?=
 =?utf-8?B?Y3NlWm92YVE2NkRKS01NL2VVV05NQVFlZmhpUWFNeHBlYSttcy9lRE9RTFY1?=
 =?utf-8?B?eWozOFdlQ0RLZkZWOEk5eGd2V21qNFVvY0k4Y0ZqS2JESU1WVFkvWTNyQTI0?=
 =?utf-8?B?SmtFQU1adXpIaDdrQ0E4NFJwZnVYc1BYb1RCUUpabHhJclh6R1RRSDVHSEU5?=
 =?utf-8?B?R0NwbjUvV21UeVNuR3FyVWJpVDZ0dGV4MjgrR3VIbVNUS0NMdDgwSXVKZGh2?=
 =?utf-8?B?bTZkTGpQbmdPcXl4amdqNm1LTUlzZTRkVFdaNHNsTVdIdGhjcHA5Q01YeDly?=
 =?utf-8?B?OHBVLzVmNlo2ME5ZeFZmUWcxNFNHMmI4WGNCNXVXaVphWVNxUDRTT2dVNE5h?=
 =?utf-8?B?OGludXB1d3E4WTVPMGhtT1owbHVwQ3BoYVNET0JFeVVSU0tSOVlLenpnYnh4?=
 =?utf-8?B?SGwxZWR1OEdOYUhVVVhzV3RPcVNaeC9pdlhEb2dHSG40TDcvMUxXcjl1dVln?=
 =?utf-8?B?VWgxYkdPaFIrWEZSTVRtV2d4V2hXcWdHN2M3Mk5aQ08xMmp4N3hJeVQ5Qnpr?=
 =?utf-8?B?Z0lwSFlHWTd4bUxXVGZmaG9wenZQTGdGV1BYWVZZUHkwK3RJZFhvcTlCV0ZG?=
 =?utf-8?B?eFV6a2Q5LzFicnZmVnBaaTBONFZBTm13VVREbUtKT3Zxc0ZGUExHTnl0Q1ZQ?=
 =?utf-8?B?UU5qSkdsZ1FDbFlaaktETnI2M3hlZjR2WnU4aW9vc0pIVFJBZ2o5VE4ySTlU?=
 =?utf-8?B?aGs3b2U4SmZpVjhleWRqeHZVRi9jM3Z3TUJIeWJ5Zk83LzNpMUgvQ2N2bXVH?=
 =?utf-8?B?SEVsL0xQVHUrSlcrYTR3encwY2NtRFJ5eXAyWlAyZy9KRTloS0RESmVmRXpa?=
 =?utf-8?B?QUNwUE1OS3d4YXJhbGtkUHB0VEREU3lUdGc2YnpMNmlSZkhIRnRRSFdpMVBr?=
 =?utf-8?B?MTRMaDIrT1pDdCtrRDc5amV4aVVwQ2pvdHRaRlk0RURFNjBQYTNES3dyazZm?=
 =?utf-8?B?MSszSGNvUGZFcFJGbTl6ZWZHK0ZjMkhKVjdRUSt6QlJDeW9EUjZma2RUSllP?=
 =?utf-8?B?RFd6QU5YeXY0T3ltSGFqVjY0NHZWWDg5Q3FyNGJUL0MyZUhxNzNFRlRWY2RE?=
 =?utf-8?B?THJNNGtDMy9SRWJERDUzYVNVNHo3THNYYlVRR1Nqc09CajhmYWNodmxONjdH?=
 =?utf-8?B?cFZhemFOem55SGlOcGxJdC9JUFRuRmx4SGhCY1ZHYVdNU3N6dkRKTUVYaWk0?=
 =?utf-8?B?Z2xwNG1NMFhtR25vMm5vQmUrNDhGWVlzUUlKRUlSK0xqTUkzaWlNUXJzWVQz?=
 =?utf-8?B?WlgwUkZYdkFTSkwyOHhUNythZ0NrL2RVTzR6NFhGSUg2dFlqdENYbWtrVm1n?=
 =?utf-8?B?dC9qNVI4TFlXOEhQSGRkMVVZQWEycTdnbWd5VUJUbUJuejFqbEIzR2lkU05R?=
 =?utf-8?B?S2lqVDNTSEtFTDh5VXZFWnhGV2ZmeFhjRThvK09rN0N4bXNQRStENG5QVmt5?=
 =?utf-8?B?OXBZYldlRnlzVXNudTlWazVkQzAwT3NxUzRXcmVsTy80NnR3OG1DVm5Kei9z?=
 =?utf-8?B?czhaVk8wMzhwSCtZVVJvL21oSzlSY3M0VjYvZnBQb2Y2aWdoY3FaSkRMaTdO?=
 =?utf-8?B?bUZMMlRJLzZ6SklyWmhuL2NuT2o1eXJsdEw3bkN4TnR4dXErU0ppNVZ5RmZa?=
 =?utf-8?B?NE9Yd2F6TG51SlBWNm9ieDg4Tk5PUWhvK3ZxcDkxNjlEWXZMUC9mL2x5d0lQ?=
 =?utf-8?B?M0Z4L05uVFJaOGROWjhrUXF3Zm5vNlM1YWJhQUY2YkJEWlpmbkt0MDk4eFZj?=
 =?utf-8?B?QkJ5VTZJREQzWlB0cWw5U3VRTk9wYTFTSnpERG0xUkgzZnlGQWRTdTc5a0pl?=
 =?utf-8?B?dnl3aVE1WWtoNTMrYjgyRkVjUEpzcDVPTnBNSHJYMTkzU1puRkhkRnlwdXB5?=
 =?utf-8?B?NXpLa2dsOXRZSnRvWEx2SmxhQzNDSWU5NzliYjJTeU4zVzFsVGFkMnVQOTFr?=
 =?utf-8?B?L1R5VmprYkd2QnRUSHRIektvSFZ1bzUydkoxaFh1VWlFREFsMTI0NkV6SHVa?=
 =?utf-8?B?dVJKM1lWUXppSkRUQzlwSC9ERFJoaDZSREhZMW5nYitwUmVCa3dRMktmZTdu?=
 =?utf-8?Q?xwPkIiiaxS7XY0XY=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 32992277-df58-4031-c51a-08de7eaffe47
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:19:08.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+lQ5oKc35gHsSdiZToJ7SwjhBNnfUVvzhCMm/FOp0+3NAh16M2e2mQMaxIM81mo6F2f9WbBsplhwoXj31yaAIwuCShyCVkHg1lg9c/9x/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8040

On 09.03.26 16:25, Miquel Raynal wrote:
> Hello,
> 
> + Santhosh
> 
> On 03/03/2026 at 17:29:26 +01, Frieder Schrempf <frieder@fris.de> wrote:
> 
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Some SPI devices such as SPI NAND chips specify a clock-to-RX-sampling
>> delay constraint, which means that for the data read from the device
>> at a certain clock rate, we need to make sure that the point at
>> which the data is sampled is correct.
>>
>> The default is to assume that the data can be sampled one half clock
>> cycle after the triggering clock edge. For high clock rates, this
>> can be too early.
>>
>> To check this we introduce a new core function spi_set_rx_sampling_point()
>> and a handler set_rx_sampling_point() in the SPI controller.
>>
>> Controllers implementing set_rx_sampling_point() can calculate the
>> sampling point delay using the helper spi_calc_rx_sampling_point()
>> and store the value to set the appropriate registers during transfer.
>>
>> In case the controller capabilities are not sufficient to compensate
>> the RX delay, spi_set_rx_sampling_point() returns a reduced clock
>> rate value that is safe to use.
>>
>> This commit does not introduce generic logic for controllers that
>> don't implement set_rx_sampling_point() in order to reduce the clock
>> rate if the RX sampling delay requirement can not be met.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  drivers/spi/spi.c       | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi.h |  8 ++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 61f7bde8c7fbb..b039007ed430f 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -3988,6 +3988,77 @@ static int spi_set_cs_timing(struct spi_device *spi)
>>  	return status;
>>  }
>>  
>> +/**
>> + * spi_calc_rx_sampling_point - calculate RX sampling delay cycles
>> + * @spi: the device that requires specific a RX sampling delay
>> + * @freq: pointer to the clock frequency setpoint for the calculation. This gets
>> + *        altered to a reduced value if required.
>> + * @max_delay_cycles: the upper limit of supported delay cycles
>> + * @delay_cycles_per_clock_cycle: the ratio between delay cycles and
>> + *				  master clock cycles
>> + *
>> + * This function takes in the rx_sampling_delay_ns value from the SPI device
>> + * and the given clock frequency setpoint and calculates the required sampling
>> + * delay cycles to meet the device's spec. It uses the given controller
>> + * constraints and if those are exceeded, it adjusts the clock frequency
>> + * setpoint to a lower value that is safe to be used.
>> + *
>> + * Return: calculated number of delay cycles
>> + */
>> +unsigned int spi_calc_rx_sampling_point(struct spi_device *spi, unsigned int *freq,
>> +					u16 max_delay_cycles,
>> +					u16 delay_cycles_per_clock_cycle)
>> +{
>> +	unsigned long long temp;
>> +	u16 delay_cycles;
>> +
>> +	/* if sampling delay is zero, we assume the default sampling point can be used */
>> +	if (!spi->rx_sampling_delay_ns)
>> +		return 0;
>> +
>> +	temp = *freq * delay_cycles_per_clock_cycle * spi->rx_sampling_delay_ns;
>> +	do_div(temp, 1000000000UL);
>> +	delay_cycles = temp;
>> +
>> +	if (delay_cycles > max_delay_cycles) {
>> +		/*
>> +		 * Reduce the clock to the point where the sampling delay requirement
>> +		 * can be met.
>> +		 */
>> +		delay_cycles = max_delay_cycles;
>> +		temp = (1000000000UL * delay_cycles);
>> +		do_div(temp, spi->rx_sampling_delay_ns * delay_cycles_per_clock_cycle);
>> +		*freq = temp;
> 
> This is silently modifying the spi_device structure, I don't like this much.

Right, I agree. I think we will likely need some struct type to hold the
frequency and sampling delay values anyway. So maybe this function could
then return a value of such type.

> 
>> +	}
>> +
>> +	dev_dbg(&spi->controller->dev, "calculated RX sampling point delay: %u cycle(s) at %lu KHz", delay_cycles, *freq / 1000);
>> +
>> +	return delay_cycles;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_calc_rx_sampling_point);
>> +
>> +/**
>> + * spi_set_rx_sampling_point - set the RX sampling delay in the controller driver
>> + * @spi: the device that requires specific a RX sampling delay
>> + * @freq: the clock frequency setpoint for the RX sampling delay calculation
>> + *
>> + * This function calls the set_rx_sampling_point() handle in the controller
>> + * driver it is available. This makes sure that the controller uses the proper
>> + * RX sampling point adjustment. This function should be called whenever
>> + * the devices rx_sampling_delay_ns or the currently used clock frequency
>> + * changes.
>> + *
>> + * Return: adjusted clock frequency
>> + */
>> +unsigned int spi_set_rx_sampling_point(struct spi_device *spi, unsigned int freq)
>> +{
>> +	if (spi->controller->set_rx_sampling_point)
>> +		return spi->controller->set_rx_sampling_point(spi, spi->max_speed_hz);
>> +
>> +	return freq;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_set_rx_sampling_point);
>> +
>>  /**
>>   * spi_setup - setup SPI mode and clock rate
>>   * @spi: the device whose settings are being modified
>> @@ -4090,6 +4161,8 @@ int spi_setup(struct spi_device *spi)
>>  		}
>>  	}
>>  
>> +	spi->max_speed_hz = spi_set_rx_sampling_point(spi, spi->max_speed_hz);
> 
> I believe we need a clearer yet stronger logic around the setting of
> max_speed_hz.
> 
> The "maximum speed" parameter is reaching its limit. This is clearly
> what needs to be discussed with Santhosh. The SPI tuning series is
> playing with this value as well.

I agree. I'm still missing parts of the bigger picture here, so I'm
currently not really sure how this might look like. But I'm open to any
discussions and suggestions.
