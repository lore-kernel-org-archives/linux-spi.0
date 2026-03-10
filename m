Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021094.outbound.protection.outlook.com [52.101.70.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AD2BE02C;
	Tue, 10 Mar 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152218; cv=fail; b=mv2Qf95EuLSzOc5nyhyBuT7+fEcdGmrYLZ7Szg13PCo9JNvzYDXgQPx0rnf7xpIk9YdC3+YaWduaGATAphqYuVqZq3sq1fzEDFaL4+It/IsOPNowMSHXUfDttoOsaTYb4i3SDqOzseXvvhOKG3h4VMHyBN7i7xyPqRxXWHNWlRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152218; c=relaxed/simple;
	bh=c1NhxycJfyruEF4Cw/xs12GqWpUZS7b0uEEWczULE0Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ+ktWSyRltTruLhObhfF2caMwxBl+wbO8AfM1IYML2bH3bzvD/FmcUe1h3hQuJ+9UM8Lh01UNmz2Pxx2j3K4lKb20sRStnPYhezFtIrIE6digAFvqK6qDSYtxcybXI4ZECFeUhgRymdM5PLBAv9SedbjVuwEUvkckpxi/khb78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=w2bx0ErC; arc=fail smtp.client-ip=52.101.70.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="w2bx0ErC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwPMi07BycAdHy6TOHDBflD8375zVMGBiGOoPJDdhechvPLJ5rI/Jcl17PeL3Sx4ptUTBC3DNeA9DsuaOg9V5XIxYEYlp/G9c6wTgjBt+QwbznmaSJmcmNy3me8aJeIjDXcLuWi+c9WYKsPt/Gjr8ZGlp9yOXENjykbS3vdhIzo2tSGjtI7Rrwvd1kgB/NjLFAAIjyTJmS5qgiUfRZoFdxyWiIuZ+iozGP03+wf5TLyUVeS/5AlQJ+EPonFfYdjqpP7ukQFdJWqh5eefYoi/4kPtK5Dc4efxRtJunTguRbVwosL26SEWEkq7jYJ58zCxAbBH9g9RCvUDTs9jx95s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVWSpAXWmJtLYUl0/pEluaJ6wCh87uXNtYS7wRaHb4g=;
 b=JnW5LZXHmdCKif2I7IIx50C6g4RR2UOoSd5O8hhLEap5Uskg66KrQlHrJxhfGeWHkl+ToMKpCzWg6Qwq9aGOmQKC2IpkW6NNM92Qy+GpRHbXyFnIa5SaGsUL1UF/JIj846afMFW2tXy4ppUzPqAPeIVegL9zI7gwzXK10vegb8VCxvXrsd7WpRzgBHqEHwezQJxCqL9Gd6VJdg4tkp0NE5GbE7ODl/jJ0AYBCez16n67lcdooIb9ZLcVFVO5l1IrA1vc1LfZTABBbmTX5eix7gh/dkve7Hacd5r7bJFqz5brOOZ3oxs1bC9hYryUEjfj/rl2hh1Yl24lQJFEsjh34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVWSpAXWmJtLYUl0/pEluaJ6wCh87uXNtYS7wRaHb4g=;
 b=w2bx0ErCZ1uvf+LZjwllH+qPCo1nGcIOLwdsasCkoJaGGYVtteREN4Erf9sWHi+VK332MF3a1xSVE1LwOI8gakZQq1LfRL8JDHHEcZCfFgFNKmIfEsTMCsY7j+MfDc9Da6ItL1sE8J7CvVNTYRzRj0GXsXx/cNXRMpqsygbcDOpX2YLuiESuLBLFAaCC06u8kTOk7gDZo2hWvvpD01o39JnRgmM1dJ6ybqbfvKzBR+6RhMv0fXX/4TiexENEK2W19aPXzfZOHxzgueyCgY03tTZ3A4lj4UMhr9chwBop3bZaBdyTEzVYXyfCuxnVP+OJ6LVO8Q+N8H/tbekII+HTDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB8040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 14:16:49 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 14:16:49 +0000
Message-ID: <a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
Date: Tue, 10 Mar 2026 15:16:47 +0100
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Frieder Schrempf <frieder@fris.de>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Han Xu <han.xu@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, imx@lists.linux.dev
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
 <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
 <87wlzlnioh.fsf@bootlin.com>
Content-Language: en-US, de-DE
In-Reply-To: <87wlzlnioh.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::15) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2940355d-ac74-4cd7-807b-08de7eafab11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yX4/Gxj+s7ESZqudz4XbPyYz+5eoaaj/cQBAcW/1kCw4xan04b9Eebo88ixzAfB6PoZuAOZQlv6j3TZKj4NJp3ZnGEy04v6jDGuTURskQ0qONkeMJpEb4uJfA+2itUf4Ly0U+G8VZJwg5SbaMBhAg1LF7WqIoPT8YmYxfs0LvU23vPlQ4sWpyubWftfP0ZwvYj0Rp3PdPUINeuxWfaxNTJjIZQ6Gq8fSrd9mNiMDxdCJ/Cx4OCagxNL0bMA1jsX2qRSZyT9fHRq/vKYvCwaYTxyJM7QfNnMJzF2G7UZjpNOSzFM3suaA2p69+QwWF/eSr16P+YXXa5VMGfIYpYYY4+tvT+m58ViYmWXxbtkWuFYoRn/AIzWBtiGn2k9poAwq7Ftw81nc19KJs4+zhAXUdDcKkhv5EGcYsgNoZd9GyGWK/5KMvnmzOgj4NJ1PIGz7yF/hgkG/6qjHBIr/soSsyz+ZlJq07uBj5ZqoSdt8tITL2ubsQsvdHHar97xXTJTwGI9bdLoHk/ylX5Nna+zvRQ/6DDQh17S6U5fJpf6PkbuKQrQBjFyGGtkEj4f0Lx6CDvMJmqLxuR1i5904QS/p+eL2z7PBXw4QhDPMMZ1ONM18VI1mLYQ6q8hKmKiRcvv9BMIELN80I1X+axrHifSz4eRMmCDvNNpgY0yX5L7yJw7AVg/8XMDVlR+RAo7whh33mmWO/Qtrka6iaOeEcTxQBw4r11UzEP4hazR+QCA3QWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0l5YjdYQnBJS0tMMzVFRklvWDZvS1JmSjdxeWtqOUtacnhiL1RtbnBPVzhj?=
 =?utf-8?B?aFd3bTBSalkwVEpSeStPWE1uTU9zVElsNkNhVnhITGJ6QWhxZVhDZzF3OHpt?=
 =?utf-8?B?QVUrVjNlL3AvU2l5dU0ya1EvU0Juc2I5c0p6WGFoVkJ3ZHZVTWhyVTYzcWxE?=
 =?utf-8?B?U2oreHlEUUVUckVwb0NLcE5PU3o5WXlXV0lzSk9GYlVueC90Z0U3ODF2bVpo?=
 =?utf-8?B?SUhCUlZzb2JyMkFWTXJpZ3JJWHp4cnJKNFk2YWpLRXpFSjM5YTJXWjRqTGJy?=
 =?utf-8?B?Tkk2Z0VNd09Pd1BOLzI5VDlWa25JUkN4L2lKYzlMT29lR01zb21EcnAwL0Qr?=
 =?utf-8?B?OTNmVUNoY3I1bkxCbHcrSSswUk1GdFovOUVUQXFNUjRQdmZPRG5WV2ZIREl4?=
 =?utf-8?B?bUQ1WWNXTC9lVXZ3ZXY1K0MydUVCdDM4RTBCTjU0YzYvT1U2UG5YZC81R2tt?=
 =?utf-8?B?aURmdk1yN3VMbjBWMWZMbUd2YnRONGZFdmZEZ2VjK3FTRzV3cWFGaFJHY0FG?=
 =?utf-8?B?V0FBcml0ZG9BSzZhSG05ZmZJRG1GNkQ4VUhJc1VwRUlKdlhtOVdQVC9Ib1cv?=
 =?utf-8?B?STJ1bitNR1JrTFdKVkx0eXR4ZW1JZU5rZVIrbjd0Z3QzRnpVUnNmT3pqQlEr?=
 =?utf-8?B?dEhpR2V5RlduNlRtSjYxZHZCWVR2bUlvMEJmdkhxUE5CZDhtdnNFUEszcE80?=
 =?utf-8?B?MjJydzRuajNLeVJyN1pSbjBmUTV0anJBVmlTbm83V2tHN1hUQ1psL2luR2Ft?=
 =?utf-8?B?UUxwTVF3bVNrSVR3d1NRYURDakFBL0NEeVpRM2hFQUV4dEJrYTdWL2hDREJV?=
 =?utf-8?B?L1dTemVTdEpZQlF2MVFCZ2UvNFQvQWdBNTgyUEJCc1Zuc3YxYjV6SmtBTTlG?=
 =?utf-8?B?MDcwOWhHYmw2QmNYK2VBUGpSU0twR2kySFRreXJLVmJGV0plbnhiNzdnRUdj?=
 =?utf-8?B?QitJc2VLamNHenZvaUo1ZElFYkNOaGNLME0zODdXc1JzLzRsOVRnZURHbnNT?=
 =?utf-8?B?WEdCNFFCcEc2T1hKUjNaZlM2S3U0a3pwaWRMQnJpeW5HdWlaYlZYQzErSnBR?=
 =?utf-8?B?VENFa2YvQkUwc1ZZLzVuOEtXNXBxNUUwTGxXZUJQTEJvNnRBT2o2b09QZFJ2?=
 =?utf-8?B?ZTdwTGtjL3VYTVgyTGtsYlpsa1NOWmFwQVc1S3hEUnRCVVBrNFZPeGJWMnF5?=
 =?utf-8?B?V1ZzWmFaOGFmekdFdzhhczBxQ0JZa2pkY0lleW5LSlBIeURRT0RQZW1XM3dC?=
 =?utf-8?B?MEg2c25ySWd5Y1F1TjdGUC9tbnZIK0RUb2Q3Z2F6VVdDYkppOXNHVzFGL05L?=
 =?utf-8?B?UENwbi9xeS9TdG1iVTc3SzN2NUw2L2FiYXZ4UDdUOUZjZDlLOFBtR0x2azB4?=
 =?utf-8?B?bzQrN1hWQVlqaEJuZ1o1L3pYWk9QNTcvVVB1NlFvVTBwYk9hbk1iaTZlSE9G?=
 =?utf-8?B?a3ZHMHJBbExOVmpKaWkwWnkzNFYvRHNGSU50c2tacGdtUzVKZktDU1M2clY2?=
 =?utf-8?B?Ui9iaFY4R3ozeGQxcFVkZ0NMVWVVck5wWFJzczcxRU9NT1pvRlMvUHU0MHVS?=
 =?utf-8?B?U0sxbXlUZUREbjhpK3pGVnFLOFNMbWVzeGozK2tCS3JxSWY2OEVadmJUK0hY?=
 =?utf-8?B?dndlSUhSRG5wQmZTV2owWWlzRjEzVXg0K2habDkyY2xVSzN0K00rSzM3U1Mr?=
 =?utf-8?B?VTZzS1F0WmJvVEZpR2RHSzQ4cDZQN2tQVWpBRTBXZWtlMEtPbXlXbjExL0hk?=
 =?utf-8?B?eURvQ2MzNVdPYVBEcXRDVWs2NWUxVTYyYlRuK3owMGE3NE1oby95VVZlbEh0?=
 =?utf-8?B?Qkl5WXRGR21qeEdzbk5wdTBWQTJtb3pwa2Fhc2U0cnc1VVFLV3FkWkI5VHJB?=
 =?utf-8?B?aWZTTldWaFBCcEwzbnVIN0lnaG1ERGlFamxNYmdMY3MyOEU1bi9Xc3JkdzRo?=
 =?utf-8?B?MjRQRzlPb0g4aGpWSTY4aUtYaVhoSUtIRzA1RVcyN2NhcmxtOFlJYXBaVFl6?=
 =?utf-8?B?REFsVEtrVmtyWUI4Nk9NUFVPRERRd3VrZmtwUkw0OHhWT0FMUDB6VHVoN2hF?=
 =?utf-8?B?VU9VcE1zVjJmbHV1bmdHRlFQc1RXK1VMdW9BczRwTGMxc2JtbThNNzRKdzl0?=
 =?utf-8?B?WUgzdGZuRWpRbFpGeDBINDBpNWJPSUtvZTM4Y2Q3anErZm1rdzhjSzlDR1BU?=
 =?utf-8?B?a1FxbFNwRTU3d2RWM0xDcVJVdndGQVJjU2owSzZvK3ZIT200V290VURrU2Jt?=
 =?utf-8?B?bmZqY3FYSk1zbHlkUEIweXk0Mzl4VUJCY21DOFBSd0YrcTFKZGcyZlREUkZZ?=
 =?utf-8?B?dCtUbUVYeHVrcS9zdm1Lam1Hd1hia04zS29TbVJhbGQwbVZWWmpUMWkzSm9M?=
 =?utf-8?Q?ny170BaJPIcWY600=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2940355d-ac74-4cd7-807b-08de7eafab11
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:16:48.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iM4cQkoXj7Qia5eyQ1CbNFi+2bXaUvSQsQT+J/hsUZbS61BK1Q9aTBGsAYhOg+fEIwT/OGALIovtf8S0aSBLE6QoPrHKz293quCfqwFp55M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8040

Hi Miquèl,

On 09.03.26 16:09, Miquel Raynal wrote:
> Hi Frieder,
> 
> First, thanks for the series! I believe it will conflict with the SPI
> tuning series as you mentioned, but we should be able to make them live
> side by side.

Ok, good! Thanks for your feedback!

> 
> On 03/03/2026 at 17:29:27 +01, Frieder Schrempf <frieder@fris.de> wrote:
> 
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> With clock rates changing on a per-op basis, we need to make sure
>> that we meet the RX sampling point delay constraint of the underlying
>> SPI chip.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  drivers/spi/spi-mem.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index a09371a075d2e..6b8bee7d6f5e3 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -589,6 +589,8 @@ void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
>>  {
>>  	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>  		op->max_freq = mem->spi->max_speed_hz;
>> +
>> +	op->max_freq = spi_set_rx_sampling_point(mem->spi,
>> op->max_freq);
> 
> How can this work with the above 2 lines? Maybe there will be the need
> to use a "min of the max" frequencies?

The sampling point delay is coupled to the clock frequency. So if the
clock changes per-op, we also need to change the sampling delay per-op.

In general, if we want to avoid switching the parameters back and forth
in cases of alternating ops with different max frequencies, we should
maybe do some "min of the max" calculation and use the resulting
frequency for all ops.

Is that what you mean?

We could even set a threshold to decide between using a common "min of
the max" frequency or do the switching per-op.

One other possibility would be to somehow cache the per-op frequencies
and calculated sampling delay values so they can be reused when
switching without much overhead.

There is one more issue that is not yet covered by this series: Before
spinand_id_detect() we don't know yet what RX sampling delay value the
chip requires, but we already use read-status and read-id operations at
maximum chip clock.

For example on Winbond W25N04KV this leads to detection failures. So we
should maybe introduce some kind of reduced clock setpoint for the
initial detection, that is safe to be used without RX sampling delay
compensation.

Thanks
Frieder
