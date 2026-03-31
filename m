Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020143.outbound.protection.outlook.com [52.101.69.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7D1448D5;
	Tue, 31 Mar 2026 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979851; cv=fail; b=fh8cq23oWnXkTJCtASdfvPgvtezleetoSW0oIibYRvqk5mtMzPzrig46kvNiPBZo46CpNV1HOLvG2kMZJ0R8nkrgNLW/Fu8vkuKGnIjQkhj9nnbqRJhxgf/uizA5i5pJkTYcYGEIihXHx0Fl7DxvxuFz+qljHoiaNTr3ksAxMRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979851; c=relaxed/simple;
	bh=MsidmJothS4tNKM+gk8qWvxQtwIgI8MOUfS54osPzBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nCVxURULafhunhoj0cC6PuT1cFkDddIjZc0mR2uG8M3gJm+lQ8aaMlW+RAQwkvaYR/hOQPfVf2EwYJjSRePmveIURGnYpT/uQfmoXNosdQjA0Hvxbm1mq4hg1qO516u5HQQzPhKWvMOdTIp7UgkeG7n3b99JxWY6FOWOEc0af2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=LfoBJKuI; arc=fail smtp.client-ip=52.101.69.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="LfoBJKuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9je6g8GoxETSGI7CKGAwR/IbUjxH7AYZ9r6nN5PE+wROsdX2gA7jYusmwJJ62ILvflxFHzHVbdFoVkC2iKVpKnljOx83vYaQKFOFenUVLPZtBbmBR9NZEDiuk+iSTW5/6KFs70uUj4T9FTuitx0hO4Jj2cj5UWHF69D4qaR4mioRDjQs01qQlubimaBNU1gZ6JTX8f+I9vh2nIOCgMz1OyyVxcXdMLoRdiHhw+w+t8GFzrRIX84csFRvliK6qlPsIEmHZwUP6i82yWV+lbFjrZE/0ZyI5io+ZjZF6EzQ9lU2Lz3uk55fvnhTyK/FDFcCEwPfGKwABethq+hX4I/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDmTS2HujVrtxvqoW6ZILds/GooKIs6dgoLcnxm2mdA=;
 b=LnzrPWPBfAJ2knmFzzY8NlrUwOe4tCr948QW3ciHlIb3taZCCTivKfI/XcSCW+7f1cBRYyrlzyqsCMMswmk2GjHQPNUekvanrOu9ZcFqItrkpv6My3+6d38zmmC9D4MlpTB1mehxdChkG+9pVlieYrtg6resnZWBkv6DBk63DXdOrAReIChdT4w0f1JoreaFgdbxGZy7hyYqLtx7vfs3C6Q7csQWTMt0VsiI3LsIt8lbrad9+7OE3Yj2wIdqL4YZMHH81ylVY2Gi2CoYbwFPUsOygBShvJR+a3XanetTE8SqI2fW0xU2yGDFqQ4mw2yJg64MfsgcfEm0vLL68EX4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDmTS2HujVrtxvqoW6ZILds/GooKIs6dgoLcnxm2mdA=;
 b=LfoBJKuIW7/KdGp+Roc5co9kR0T8ecruD4DlwhoyLGsVzvidx/dJOvJIlb1WBNCgqJdLaFCwRhNqv77owzwRVc9y7cCJADstXYEVciEjDiBvz7ctVPWXhYX9sYtM1/KQzRajFap2VrkIFDD1PkVsgTNcBW2hALoVrhtCv408Oh1EWb00TrH9fib/cKMVoTSqddJMGFseyQgsCousDxPDlpcndJPMuwq2l/DbX2+Rv2qBHsMZGzVzwti53lJsgXu+bpabyLV+WcvlBvqZ8apfvpi/b1cfs/nNvwRN7IbBGYE2X+2fi0fnkw2TDmpTxv0IJc6qWY+6GTEk23tXcV7xQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB6983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 17:57:22 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 17:57:22 +0000
Message-ID: <fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de>
Date: Tue, 31 Mar 2026 19:57:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Frieder Schrempf <frieder@fris.de>, Mark Brown <broonie@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Han Xu <han.xu@nxp.com>, Eberhard Stoll <eberhard.stoll@kontron.de>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, imx@lists.linux.dev,
 Santhosh Kumar K <s-k6@ti.com>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
 <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
 <87wlzlnioh.fsf@bootlin.com>
 <a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
 <87ecl09wtv.fsf@bootlin.com>
 <633fee13-a397-410f-a595-db95e04b8110@kontron.de>
 <87ldf881gr.fsf@bootlin.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <87ldf881gr.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b02d60f-e011-4d82-f596-08de8f4ef57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ILtsNZwKnEcDvKALbHwUwuaB3GFdyBavYb7qd8XSU+MmTFYfL6NPWysiZhJh+ksWNwzxMrwPbu5usxc9KOmWWgr6DdS6NWS5bt3i/w5BtbquNUuQddfX9DV5FuwXNFPwTWdTf5SlgGUpDUBVJQEOjOEZlqgLSnCU9sG68gel22ONZzgXGbMZ5SyET93RvA0Kgnx2mwZrKz9SNborOAjwWgdHwB6SuKgy8f7NvuQ1B42ifoBxLjssWF7/HtSahSSuehewJKzUbvHfWIvharoVIo5WUb5Ei9niiunyYr4+XKahEt8laiHI1o6w4g/J15Ax3b4sMjNb2YNOTVw8VDwaGvq/uaVhfcMMME/qPE3V0RSy5MXc8rktgmgEgd73KV8bl5J40tWcstf9Gh56rePGsq0CnxMPvG5svPDb2BGlqEUh8bFHUkdsHvKZhGOAGwQMn9Vd16dU0xRVVVSbZIbhrAKCKuTt60fxM+4E4EftZx/9jHk9q9HP270M5Jw83xCCMMtSGaW81Igga47WbU/KNbswEcQdbXbnLmvqTR9cd/euWmi0XvIRp8XzFGZeky7kGqo7wVjpDXOUPEi6J94jTcD5DWk01fKxf9OSY3hD0dNdloj4TrdH+LsTX5YPfWaNRaAkY2OrCgpxUWmwZmrBtS36Oe3S6btlTk60dFD3O1899IN6yyaBr3cP/VNVI/nfoVrhcwpZQiHBkslKbN851uMfRgoLV6RkagP0tVB3zjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0tWbjAxNlF0bVZOejZzM0FIVDhCaVJDTlg2T3NvaFk0alF4N0U4d3dvaFJP?=
 =?utf-8?B?UVFLWkNIbEYwa1Z5aFFoRlozMnl1THdyc21WN2F2TSt2azdrclJCRUowMlZV?=
 =?utf-8?B?MVgzQ0hZb3h6aFd0WCtsbnJ4LzBLMlBWZGZiUzlaYzUxaTh6RVRaaDBIV1Jh?=
 =?utf-8?B?L0w1NHoyK0JnTGRoZ0pnaHFtRW1OMWFkNUhRbHRSZFRkMUdPQVZ4MTJlRkpC?=
 =?utf-8?B?K0J5ZnRya25tSUl3dXFrN3VvSXpMVExVZzBuNVFkdlZvQUtXaXBPbkRkL2Yx?=
 =?utf-8?B?WmkvVnlTVmF3UkNTeG5NL0hULzRpY3AyanRKK2hFZnFhKzVIYndIekpRY0ZJ?=
 =?utf-8?B?dHFueEd4aGFvVkl0YUlpZzNBaXlEVEpyU1BObVRodFdraEo1VWR6YnVRQmNE?=
 =?utf-8?B?Q3F5d3ZIdk1zeEsxSlBwZzZ3OXZKaWhpeEd4QmowN1NHV1FtOU8xUS9PQzlW?=
 =?utf-8?B?THlYV05iWThrcjdOS3NUZmFpd3VzU1pZWEt1UVlFbzFReEVWSEJya0ZMNHVT?=
 =?utf-8?B?aEJ4bTVNTTFtZ29EU2p0OUVFNzRTYmxIK3hLS1pEbXgxVzBLVm11N21oQXQw?=
 =?utf-8?B?TFlUUU53cWtKZC9hZDBlRnFRL2Z1ME4xLzJmM0pyNkZQdThZeTArRWtVQWFk?=
 =?utf-8?B?VzhyR0lTQUlhK1BxTFRkK0Zkcm5CeUJScDJHdk1BeDhTYlJhMWJNWjNYUU9T?=
 =?utf-8?B?dzFQVDd3TXkxMXpSNFdOejJJV3VSWk50U01NL1JXTmE3SnJhcFZ6R2FSdURS?=
 =?utf-8?B?Mzd0UUU3S2NmV1lOZFF1dHErWWg0b1RkR3BGOHNUelNuVFI5NXNSbW5aK1Bj?=
 =?utf-8?B?aXRaRGt4RnFWZkhHaW9ON1VYaFNWLzVtcEkvbHk3aXRoTHlaNFlJeUpXYmhM?=
 =?utf-8?B?TmN4dlpxMkhuQzNuY2lMaW9hdU5nUWxEWHlwdFo2R1FZa1RacnVyN3NHb3Uz?=
 =?utf-8?B?UE84dWFZZm5tRXdWbFZUeG85dHFwQnFick9kMGJRYlNTNTZpS2tab3RpY2dN?=
 =?utf-8?B?ais4MGMvbS9jVGxPdTNyRlNZanFBQkNobExPMmgwN0ROcmduYVB3QmwrRWhq?=
 =?utf-8?B?TFRQanIrYmgwNzg4VExwOWU2Njh1d1NzTExRb2Iwb0tLVEFNOTMrS0JIUWxO?=
 =?utf-8?B?TzNiZ3hNdWdrQ3ZxcXAvTHZOQ25sR0paUWlBR016RnJJN3UvRUFjQko1MlIy?=
 =?utf-8?B?WEtKTG0yQkhRckFMVG5kalZSYkZ3WGpQY2w0b2liMEVTcXhJUzJtMDBCQ2to?=
 =?utf-8?B?TklrT3JNam5ZckFPdko2amwyVHBGdXBoWC9sYXp2MEQrQ2ZEeVhORkVoMzZM?=
 =?utf-8?B?bjZJK0pNWFdmcmRCS3EwVGdxQnRub2I5M0pwbm1rR2htK1BrNmFJNTB6YVpz?=
 =?utf-8?B?T2tLREFtMWdmK0piZGd1KzRKR0IraXZMcnlwUWdKY1A5eEhBdm5FMk13SHdF?=
 =?utf-8?B?UitrK1hTNkRnVmpEbXVkakVYMmNHVWpvbEtoVGljVXVUTTNrQ3p2V2FxeTk0?=
 =?utf-8?B?Um9sdlFQT3lpR2t3R2ZOeUZkZjBaU25xTUFOdUpQdFZmTHZMNGlHZzYyZFk2?=
 =?utf-8?B?Tm9PNStGRERUZVh1eTN0MVQxQXFXeTNQRFExVW95bzhIcExEazdjdk1OUkxR?=
 =?utf-8?B?cVQ0bVFTQm1IQlJKTndKZzhicjE0UHAydm9VMFVYcnRHTjdWR1N4M1VWZUZx?=
 =?utf-8?B?SEZqRkJERjE4Ulc3R0p5S0ExVWE1SGQ0Ym90d3FSTjlnMHNDckhyQXBBVWRm?=
 =?utf-8?B?OUxxay9ZN0pYQkM1aWFtSWsrWVBvZDczbzJSZXc3M05IQS9yQkVzaTZUL05Q?=
 =?utf-8?B?ZUZyRUFxbHNUS2hLNGs0OElBREtoUXBnTW50bjhwbzNXUE45cnVoQ200cmIr?=
 =?utf-8?B?VzVzVUZGL0Y5dWNSNXpnK2VhZkV1SDZybHdQVXVtUW1maGdCVEJLTFowV2Jm?=
 =?utf-8?B?L0pvNWFyazFma29lbkt1QWZhUUxuU3RFU0ZNN0JCOHZpbHlOQ2JtczhzY1I2?=
 =?utf-8?B?QTNINE9ZNUJJVU9HTUJibjBQdDEwbElXa29oOWJQaURqemN3bGRRaGJ6YWpk?=
 =?utf-8?B?VlRaZEhuamR6cnRaTW93RXQyTlQyb0lBakdBWklaZlBBNjRaT0JzbnNSbkRo?=
 =?utf-8?B?N1RMenFBeVk5NUtrOVoxSTBpRkIvcjI2bkd2cGppTTdWMFhXWHhiMjd4Rytu?=
 =?utf-8?B?OUlPWHNLV1N5SFpSZFR3eGdmdFIrbXhQM3RuZnVUVGRodFFIWVMwZy96RlBN?=
 =?utf-8?B?aWVMN3dkTTZ5SzFUaTA0S01wMzJ0OVJzLzJ6dEc5UCtvSEp0VUlyUWNkUlpB?=
 =?utf-8?B?MW5UVC9iTnp2YVU3RmxYYm5wakhFSW5Zemc2Z3VQclZ2R3JsaFJFaWw0V2ZR?=
 =?utf-8?Q?KrJSBB3AD6rITu5Q=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b02d60f-e011-4d82-f596-08de8f4ef57c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:57:22.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcVFYrwn1y7H44tUivc7IvmLQhUOOyKa5nIDLofwS5VyFJe21cWpajQXTUmQhXxjIJsnPEAby/5GdBcFouieZ1q4vTSCXFMTIBrhPmG+RFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6983


On 31.03.26 17:26, Miquel Raynal wrote:
> Hello,
> 
>>>> For example on Winbond W25N04KV this leads to detection failures. So we
>>>> should maybe introduce some kind of reduced clock setpoint for the
>>>> initial detection, that is safe to be used without RX sampling delay
>>>> compensation.
>>>
>>> That should be the DT max frequency, no?
>>
>> Hm, I've seen it the other way round. In my perspective the DT max
>> frequency describes the maximum clock frequency supported by the chip as
>> given in the datasheet (assuming there are no other limitations
>> introduced by board design, etc.).
> 
> I believe that what is in the datasheet should instead be statically
> described in the SPI NAND vendor file.
> 
> The max SPI frequency DT property is here to tell at which speed to use
> the device, and this depends mostly on the routing.

Ok, agree.

> 
>> The RX sampling delay is a timing parameter specified in the datasheet
>> and it is relevant in order to interface the chip at maximum frequency
>> within spec.
> 
> If it's not design dependent, then we should handle it "statically".

The RX delay introduced by the chip is not design-dependent, only
chip-dependent. There might be additional delays introduced by the board
layout, but that's out of scope currently and I don't know if we even
need this.

> 
>> Your approach would mean, that we need to manually calculate the maximum
>> supported clock frequency without RX sampling delay compensation and use
>> this value in the DT. Then let the driver increase the clock if RX
>> sampling delay compensation is available.
>>
>> This would have the advantage, that even before initial detection we
>> would use the correct clock by default. But it has the downside that the
>> clock value in DT won't match the datasheet value.
> 
> It never does. Winbond chips can run at 166MHz. I know no design capable
> of that natively (ie. without finer tuning, like what Santhosh
> proposes).

Ok, right.

> 
>> In my approach we assume the driver is able to use the maximum clock
>> from the DT (same as in datasheet) by using RX sampling delay
>> compensation and only if it turns out the compensation is not possible
>> we will lower the clock dynamically.
>>
>> What if we do the following?
>>
>> 1. Add a parameter in the SPI NAND chip driver that contains the maximum
>> supported clock frequency as given in the datasheet as this is clearly
>> the best place to keep this device-specific parameter.
> 
> I've so far avoided doing it, but yes, this is something we can do. It
> is going to be simple enough to implement as all the infrastructure is
> already there. You can provide variants with speed limitations (look
> into winbond.c). I was writing "0" in the fields which didn't need a
> limitation that is something else than the maximum speed the chip can
> sustain, as anyway the DT property *will* tell us what is this speed, if
> we are ever able to reach it.

Ok.

> 
>> 2. Allow to leave spi-max-frequency in DT unset for SPI NANDs in case
>> there are no board-specific limitations and therefore the maximum
>> frequency supported by the combination of chip and controller can be
>> used.
> 
> In many cases, the limitations are board specific. Anyway, this is
> already the case, you may just not put any value in this property.

Ok.

> 
>> 3. By default limit the clock frequency for the READ_ID op to a safe
>> value that works for all chips and controllers, even if RX sampling
>> delay compensations is not available.
> 
> I am sorry this is not going to work out. There is no such harmonized
> speed, differences can be an order (or two) of magnitude different, we
> do not want to pay the penalty of a very slow identification on all
> designs. We currently do the read several times with different
> parameters. What if we were trying one more time by cutting the speed by
> 2 (completely random proposal)?

If we try with reduced clock as a fallback after the other attempts,
there would be a slight chance of one of the earlier attempts with
normal clock rate returning some invalid data that matches an existing
chip ID, no? Isn't this a bit flaky?

Let's say for a worst case scenario a chip has an RX delay of 20ns (the
highest I've seen in datasheets so far is 8ns). In that case the maximum
clock we could safely use for reading the ID would be 1/(2*20e-9) =
25MHz. Do you think it really makes much of a difference if we read the
ID (only a handful of bytes) at 25MHz or full speed (e. g. 104 MHz)? I
mean this should be fast enough either way, no? But maybe I'm misjudging
this.

> 
>> 4. In PHY mode, check against the DT max frequency (board limitations)
>> and chip max frequency before switching to this mode.
> 
> There is not such thing :-) the max frequency in DT currently would be
> set to the platform limitation. We need somehow another parameter
> indicating what is the maximum speed if we can fine tune the timings.

So we can exceed the platform limitations using fine-tuned timings? I
guess I need to read and understand that tuning RFC series.

> 
>> I hope this makes at least a bit of sense. I'm really not yet familiar
>> with all the different use-cases and limitations.
> 
> If I get back to your own issue. Is there any chance we could avoid
> tweaking the DT for handling it? Would there be a configuration of your
> controller that would allow reading the ID of all the chips with enough
> delays? Currently, the spi core doesn't care much about other parameters
> than the frequency, but there is perhaps room for improvement.

We could use RX delay compensation (one half clock cycle) in the
controller by default (as currently done by the STM32 driver). But that
would break if we use a very low clock (for whatever reason) because
then the RX sampling delay gets neglectable compared to the clock period
and sampling is triggered at the very end of the clock cycle when the
data might already be invalid. At least that's what I suspect based on
my test results.
And it would also break if the chip actually requires more than one half
clock cycle of RX sampling delay.

The RX sampling delay setting must match the used clock frequency. In
most cases there is a lot of room for tolerance before things start to
fail, but it's not endless and especially at very high clock rates we
need to take it into account.

So if we don't cap the speed for reading the ID by default, we somehow
need to know what value to use for the RX sampling delay or we need to
try different values. And if the controller does not support or
implement the RX sampling delay compensation, we need to cap the speed
anyway.

