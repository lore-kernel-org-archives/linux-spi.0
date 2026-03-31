Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021111.outbound.protection.outlook.com [52.101.65.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD981732;
	Tue, 31 Mar 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951102; cv=fail; b=kxNkxfCfUjwvt+n7BPTkZyFPZsbV+DtOEiHWgNCgrZhfF0w1PXrRtRWkjW1YPWhdi11V7wVo3IbCLnUWoxPS9ZvGNdbk1IbREJU196DB9gRk13BEsBCb1OFF0EDud86M+zpp2YUj1Xc+n7TWrLeOlI+eOD+D+wlomZI/IrDKX+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951102; c=relaxed/simple;
	bh=jrCamqDeZ1vUZuv2a6t2T4JYbhbwFKzzxqsSgF1PH0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A3CLbfDK3s3pGutaGH/9DjlZLqLw/f1VbdoHSfEY9eDQCCrvjv0/5Pg/GG5hk+LOSxZSyaDy+j7aIt/pYciQ5t6uX43poZH6eGVBZ2lc5ZEZ0UWBRoT6zWxk1BGsW22wyg2q0KOYrU05k9LLYAKNT6fvuA0KN7e9GmxOwXvbQ/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=V3Xn2Bvw; arc=fail smtp.client-ip=52.101.65.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="V3Xn2Bvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohXDfpgRknkkAx7SO+eyADE8e6Y8hh6lEa2vjs2FXi0sS6aVX1AieFLyQSwxgCZLUfJHKzjoP8sqXi0IrnOA/6gH53oE6mds4U9ZzCToSRxn/c/FGAxx7gRlgFsSU4bgAuqYa/Cz75VCnzAE6/EwpkJZDnJdIlaCK8aXD13FSzRQWq/ks4St6byny1t1b+TQ4Lrlfu4KDKxxxb9b8vEc2y1rX35xIYaQuE0aJGHURyHYBPm1JtwdACLuOJao72/tZhQTYU8OAXm/rTDSa8FNpkPDEWTTOHb/iG9imlVD6XUVJWZ1j6I5JjjyzIR2TKEZEar3DGR0kxfpsTdrY/1nGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtzYOMcnnVQ1cBjTjqLj9JmfW2kd8R/QjumMdV0CA/g=;
 b=EuxTkOlbcLh3z+paLuePTsOe0A11Ey5g2tbhj4zFaVk+YBSseEeFGWWSy0/lD68qLPLowf2ZSugfU7A1KvsL28P5rzFGjjm1xbn1I1ehqmHy9ajO//W6SEnip1EodLxeDo9eCx8ybi7BPp3ZXJF/fGfqfofFMOKjOseFTYhEVUq+o5W1UsjbLD7csf69tHmSSHYtlhLk1mQo9CkOnUuVbb/PMyjZjvOQvRV0QUxhNLGyWDCDuVpSSbrBr9zheoMJ4sBvOjpGjY5ONc57yuMX7ZLqfz7Li30/VSLI0hjmhPp9FkhJfjwi8h5dgRQaJWGR4fWUxCkHgQHIymHnsJfXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtzYOMcnnVQ1cBjTjqLj9JmfW2kd8R/QjumMdV0CA/g=;
 b=V3Xn2Bvw4BXoEWjghTfBqfe4J+2VpwdohJFE8mcOn+J+CB/MHsDzi3J5Fjkf1P7RQJ4mBO110bX6AzV+Y28OBUqLx3TUFZYAMnLS45dea80009ZIlC8LtahuIxqTXk2eJgxWzKkT3zYTVgC4Mq3KTn4a+0hC97E4ATcvRB+LEPrESlRA0pxWpKYzjH8IR9+9PSx45hJ7NwutOxV0cL267KHJPIOFKWKWLdJBtOoQj2ReTmWMe/z1ZqdKdarjSfVWWJd23OK7WHjXEAS1UtJ1mVhQ8CEEJ7MwbjJe2owllU5tnujfeHjeLfiMGjYS0M2gwrD4npAI6WNbwottG5wlEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB7610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 09:58:13 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 09:58:13 +0000
Message-ID: <633fee13-a397-410f-a595-db95e04b8110@kontron.de>
Date: Tue, 31 Mar 2026 11:58:11 +0200
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
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <87ecl09wtv.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bc29af-990d-4bfc-eadd-08de8f0c05b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	On86BcW7tCwcWpj7ZkMkcd98Ana6/QSUYvJ8rlnGBgfxB/NVdGdjTkKGcrcHEhEdJwxyoBZoJqINiDku1bYKqOKrt+rpK+pWDO2MvDElnwTDJ7vJpVhsAbCGWqBQC1ldaL8a0S/N3pf0edBEq5Ky7bbPXtkdzQeY/OxOrM8hHOBwhqyMXo8SruqSHkhrqCElyiC1f7nXXWdC3ayfzwF+uUkfAHr4pvvQXw4nrCfj29ZLHIMRLhq9ftSEal8+w09DM0hXZTeckKpO1c6gKjkMbZyHEnWTN6fG45m4vXzwg/wEnRDe3eBlUlCMQ/sWEG1N5hcFiXsvggEjyjUgGEJKZoJfOr0AtB+2y2B4TNGa/J8U/2X4DOgT/Rx5yt1asWQ19qv9H4nosFEhvaOZzyKrcqmtD7aG1DJEbySpjxxSGsfSjrJjjnUfRDa7I1qYb3U5mYkv25TWqNTwCS/7E2vxKK7yakeYGc41o0XSreau7Vgl1LdQfrPn95Up4kpEN24Z3/+Lweckj8Pkv0eEKLlsH3Bwxbx3ZAiNq13wNmzS4H8COfAdZWwUyYZc/n+2dd0jH5vhIww6Bi9AFwOshTigXQxShtx4uVzfjOEELFXLy8pFYmhMOFnbv6A8W1gc5rpOavJfBlptHBuSaqkGoNO8PTDuS/MU+KKVgHBNJXPzlGZBXkIU9bitpCBVo2J7Cgztjzof39NpSNzDbcPiNRjPcfp+QS2t+wcwkrX5AJFNlEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVl6d1V0Q3VGSnNzQlZlM1habEhwNnl2TGgrUU4rTXR3Nk1LQ0piWkpSeDk5?=
 =?utf-8?B?TUwvUnRPQjJ3Tit2Yk9teGZXUGsvRTdzQjdyblR6WWQ3NmlnL3QveEtrRCta?=
 =?utf-8?B?K3lFSXFwQUpSSERFcndlNzU0L0o3K3p0akI2b1FZcnR2VStzbTltQ2Z5U0du?=
 =?utf-8?B?bVYxSURLc3dGdEM4WENGSUhjcDYwWDBSWVM4dXE1a1lFYmoreG5ocS9rcHNq?=
 =?utf-8?B?SUQyV2RoLys4aVpPUW01b09WZjV6T3ZRZ0dSWFJwbHJjbW44TWNhdUdJN293?=
 =?utf-8?B?RTQ3aEtXVmlqRmNodDg3UzBjd25BYWh5dTdEYlAvRmRhcW1wa3FNOXR1K2hn?=
 =?utf-8?B?UURNcERDL05sTlZheVZUUEhVT3JoUFdKNmkxeUR4YmdhVWs0cThlM0lsYk9F?=
 =?utf-8?B?T1UzSThoQkgxQTFhY01zNFQvT1JzaWhEeHdWb3dNSGppbDI0bEpXaUYxS2xk?=
 =?utf-8?B?MVBPWjNqOGM0ZEFoVDgvb0pVNDVhRTBrWG1YZkdsQmx3UUNrY3IyVFNWNEk0?=
 =?utf-8?B?dXdaTWNYSHpEOEhDYjdQVHF4bjlSZ3V4bHo3RGxXMjZZNk1QU21lS2lCaVVF?=
 =?utf-8?B?SlJ6c0NrYTFIZWdnYm9xR2VBK3k5Q3pGL2RBUW5CRzZtNlVZV3lpVkVSd3Rh?=
 =?utf-8?B?Y0M1bS8rM2J0N2tkdXdYV2kvNE9YU3RGQWZuVnBuUEE5Qkh5QU5HR3NtZUJB?=
 =?utf-8?B?Y2ZobDFmdjlDaC9NcjNhZFhVRnBqTmljVURvdEJ1M3FhR0M4Y0RpZWVTTDZu?=
 =?utf-8?B?TW9SeW0wNXZWUmR0T2dyTlpDYzc2YXU2Nm5NWmhOdTRZR0RaV2tGQVl1bHZK?=
 =?utf-8?B?NkMrOXNSOVFLSkZWWGU1Vk1rSXloQTVtTTBrTGg2M3gzbERlN1NEeTZSdzlw?=
 =?utf-8?B?Zmw1WlQ0YmRGM0ZNYUtVR2ZhQWxISVJSTDgwQXdTNlgxUGQ5MXN6MHh6ODJi?=
 =?utf-8?B?RWFUako4WE9qTWI4L2xENDlCSVRhSWd6VmNyZzQveWIzajNIOTdPenU4dnhH?=
 =?utf-8?B?NEdZY1JSWndGSHJLNGlrNFR6aWpMQ3pMOWIxVDVXQ29WdEZodFVpRU81dWJ6?=
 =?utf-8?B?Um9DeXVBRE5oNjRjQlZxekxtS0ViNFRJOWVPTi8vUHJXaFhBUVhkME53UzJh?=
 =?utf-8?B?YzdsNkc5SzV1dlNYcVJsMHhIOW5USGpseU5rV1djbWM5OHQ1RktRb1JnZDgz?=
 =?utf-8?B?d2hhbDU0NTNIaGpjdWVVRWRlbG1jcG1EaXdlK1lXOVV5TjdmNlpLdWtqVWZH?=
 =?utf-8?B?TVprSzVSRnhneDNYZndYVVhGOG14aXlpYm0xaWIzYnhpN1dBT1dlRDgwbmdu?=
 =?utf-8?B?NEQ1OTUyaFIxMkZ4OHpsTnhxeDkya3psRWZXNDFQQ2FobzRSWEJIRW5WbnJV?=
 =?utf-8?B?eXdhUERRSmM2L0N1TG8zbFI0QmtwdEtYL0x5dlo0MmJHYmN2cUNhQmNDcWNT?=
 =?utf-8?B?YTVzb3U4QnN0L2VBZWRjK2xWTmJORmQwNGlOTjRZVjdUdE5iRUZUUEQweHYy?=
 =?utf-8?B?akhDdE8vQ0xNTEIvQU1TdEtRWjQxWjdNd1p3blBOWjN1QldQZ2lOd0RXYktw?=
 =?utf-8?B?djd4U1RZeTg5bUl3T25zVDd6S3NKaWhNdHJ2bnNSL0VQejI2ZjJrRm0vcXBt?=
 =?utf-8?B?RS9naDROWlRyb0syZGJlSlgvRTZkZlltOXhhQmhld1VZUHY1OEZGNFJIbk83?=
 =?utf-8?B?akRyVmVOSXBkMUV6RHFRRmhnNjFsbTYwTnJqazU1ckZlb0lpUUt0dVlzd05x?=
 =?utf-8?B?ZnQ4Um9RV09HdGxVSGY1eFJoUzF0UDRnQm9tTGtTQ0R2UzJlSlRXUFhNSVlZ?=
 =?utf-8?B?c3lwMHBjenYzNFMyYkowZmpPNDlubHc0bENIOWRWQThjYkg4VzNmbldpSFpj?=
 =?utf-8?B?L1ZDUklEbXNqQjhTTms2K2h0RlJITWwrT0ZrMzhYcjQ0bHp1Y08ybGd4alRI?=
 =?utf-8?B?aDlnWDJQcVZDYzFIemNaa0F1b25ZNEEwcmdRTUV0dXc4Nk9QSTQ5ZjdFQ2xE?=
 =?utf-8?B?K0J5bFcyYjRaSmFGaTQzLytPb0dncFJoMzdDRnkvbkVHTG1XMmJzUGRrd2Ri?=
 =?utf-8?B?T0Z4RzBFZjM1d3I0SG1yc2VHMmFDY0VDcFhNWjZOQVhMRm5xc0h4M0hWanR3?=
 =?utf-8?B?SWlnemtNWklacE1FZVRSOS9jcVZ5a1Q1bDVhblo3SGg0SnJOa3JlZEhyS0p4?=
 =?utf-8?B?UDdhWWVFU2VEUkFyZVVXbEtqa2ZIZG1naHJZZ0xxeFFqVnhva0FZKzZQUlJO?=
 =?utf-8?B?anpCUzYxbkpvU2hpdzBUZ0h3V2tyVjhabkZnaG9GQjFwU1hBb3NXNFB4NVg5?=
 =?utf-8?B?RDFlV0x4bG14eVdTRDgrMkpqY0hNMThkK1hqbWpRRFFrVVVBaE5PZXlzSWxK?=
 =?utf-8?Q?mdxbx/3frZPaG234=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bc29af-990d-4bfc-eadd-08de8f0c05b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:58:13.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWhL6qEhpyvWO62H1DJMzFVGJk+r2fkWJXwcE8o9wLcoUB5+UgH5El8uofKYWEA5S8zZ4PxbUlGAOAUR6vqOspZjcvwPi07iBdfTT9iO6tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7610

Hi Miquèl,

On 31.03.26 11:23, Miquel Raynal wrote:
> Hi Frieder,
> 
>> The sampling point delay is coupled to the clock frequency. So if the
>> clock changes per-op, we also need to change the sampling delay per-op.
>>
>> In general, if we want to avoid switching the parameters back and forth
>> in cases of alternating ops with different max frequencies, we should
>> maybe do some "min of the max" calculation and use the resulting
>> frequency for all ops.
>>
>> Is that what you mean?
> 
> Not exactly, I am not afraid by the time it would take to switch, I am
> afraid by the likelihood that both the PHY tuning series and your series
> might want to force a different maximum frequency. For instance with TI
> designs, when entering PHY mode, the frequency is 166MHz, period. You
> cannot lower it because by design, you bypass the SPI divisors.

Ah, ok. I didn't know the PHY mode bypasses the usual clock setup.

> 
>> We could even set a threshold to decide between using a common "min of
>> the max" frequency or do the switching per-op.
>>
>> One other possibility would be to somehow cache the per-op frequencies
>> and calculated sampling delay values so they can be reused when
>> switching without much overhead.
>>
>> There is one more issue that is not yet covered by this series: Before
>> spinand_id_detect() we don't know yet what RX sampling delay value the
>> chip requires, but we already use read-status and read-id operations at
>> maximum chip clock.
> 
> Not exactly "maximum chip clock" as in Santhosh's work, but indeed we
> run these at the frequency given in the DT as bein the maximum
> frequency. If that's not correct, you must lower it in the DT. That is
> why I am in favour of having two maximum frequencies: the standard one,
> that just works, which is the one for non optimized settings (the one we
> actually use today) and another one, when tuning the bus timings.
> 
>> For example on Winbond W25N04KV this leads to detection failures. So we
>> should maybe introduce some kind of reduced clock setpoint for the
>> initial detection, that is safe to be used without RX sampling delay
>> compensation.
> 
> That should be the DT max frequency, no?

Hm, I've seen it the other way round. In my perspective the DT max
frequency describes the maximum clock frequency supported by the chip as
given in the datasheet (assuming there are no other limitations
introduced by board design, etc.).

The RX sampling delay is a timing parameter specified in the datasheet
and it is relevant in order to interface the chip at maximum frequency
within spec.

Your approach would mean, that we need to manually calculate the maximum
supported clock frequency without RX sampling delay compensation and use
this value in the DT. Then let the driver increase the clock if RX
sampling delay compensation is available.

This would have the advantage, that even before initial detection we
would use the correct clock by default. But it has the downside that the
clock value in DT won't match the datasheet value.

In my approach we assume the driver is able to use the maximum clock
from the DT (same as in datasheet) by using RX sampling delay
compensation and only if it turns out the compensation is not possible
we will lower the clock dynamically.

What if we do the following?

1. Add a parameter in the SPI NAND chip driver that contains the maximum
supported clock frequency as given in the datasheet as this is clearly
the best place to keep this device-specific parameter.

2. Allow to leave spi-max-frequency in DT unset for SPI NANDs in case
there are no board-specific limitations and therefore the maximum
frequency supported by the combination of chip and controller can be used.

3. By default limit the clock frequency for the READ_ID op to a safe
value that works for all chips and controllers, even if RX sampling
delay compensations is not available.

4. In PHY mode, check against the DT max frequency (board limitations)
and chip max frequency before switching to this mode.

I hope this makes at least a bit of sense. I'm really not yet familiar
with all the different use-cases and limitations.

Best regards
Frieder
