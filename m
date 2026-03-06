Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022118.outbound.protection.outlook.com [52.101.126.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37C288B1;
	Fri,  6 Mar 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761345; cv=fail; b=gEbIeAvfd5PoOsTvK6CGRAW4CDpWkcsftWVd2qcmObexv2wsUARoXAaakZkdIBSUuyKPC9K78pLxko4Xs5aj0IzRN2pX7AiowAaOXhPUzosqU+dYz939WBoZ/5AcnZEuQd55Resig5FQBluzScLQelhBGuemgjfZNLmn5N16DRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761345; c=relaxed/simple;
	bh=CmBEwUlGwRGDMWphkWs7UpgudDn7Lz7wi3Xa8skENb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ra0zEtNZKQMhYoWoW12J9xoWG5fiVdS05icUIgfovlbYuyixYdK7XvGP09ZKqPlm8t3DDB1rksxYnRg6ARBGUJRgGWd3NfQ6z5g6GBaaER6IGZEs2oB7aKiThFMsgOcFlMV1knNhIlCVD9a9MkbxLEf+7yVUpdCGOUA0istPPEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tYpYZwkR; arc=fail smtp.client-ip=52.101.126.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tYpYZwkR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjlyoSjbPUOtDy7TC7c2WnMW3K2L2jqGNraV5pE6u7O9U4FRsScNn+Y5DOJiS13wL5nbOssyZyRDPO9s7jkxn6/A9NgI8oUD1FRo8zLp2sUjyYFDJQCUUOc7lKOdg+Fjim1Efzbcc7bwls1aDSpH9vNwImQi5q7hoLnbaibE+/fwco+jvGSg+I5ChFD+gNew7fXBYSHNpO6IlipCDLQ5wYnBBddCt26Dj+7L6mCt3LFdSiaB27FwmWU5dAjnow+uoJMzSN15GU/p2Sir5EETCR/7cvHMrpNig6h87zQ25gN4T6nylSC7OsAWohJn8j+GpqZ9RbPiDGDdANSWENERCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEjSKiT++8J61RdTu46itkiiKmOUPz5G8rjE0hMZY6w=;
 b=v/hqnSfYUMNTCTmwnoYnMf5Yuc4kUmW/YW/FQLib0m/OB6kkUN/sgLJowPaPHPnZ9mmHfL9TKc4uisfkt2yU7nla+99WRwW09kc/HL50InziqKavslszPcpFuofIX2DuaMTgxoTnWqLQG9vivlRaUWSejYjMXE0Ui0HZpmDYsBiiYK+SZ7gjDC6KROdPcB3wXPBWKFO5Y2PPj829o3DCJaOmnan9K/ifi8SwKYw/VMdVACVlh6WtRMRmnmJMajeGJte3uUvDJwxc++XZnXselO8cdd6YepYVraGrHKX1Gt1wBMadt70XeSAAXc1afMwxB+NqHNAm5AayKpurvMnRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEjSKiT++8J61RdTu46itkiiKmOUPz5G8rjE0hMZY6w=;
 b=tYpYZwkRKiKt8hxRYHEdnEMPbitX4rPWpwodR8v8L1ZUiAlFX2ASpLMBDcyWgzvvWz/gl0LgdvQq05+m1qOVlHHcC1ubSyXXRbDhlJ8TkTCjHiPCbCcRQ7ax7fKKitQAcpBFs92pIz+ycRazgw/s1AE+eFBvKDIBIH1c1jN65igw6I5cHBE2b4vR7xjoDIINun8Kw/m21J2vziI8KNgvJBojTz2suY3aD2aIpmGsTJqIti1y2j7VghSh+XSsI4VRBabXXRbezxBQR/iscq/nk6f6Ih60bzHxa84WVJx6JFXyuNjVh+hBAKxA4FMcd7dZdvZPrh40ahcKwu1c4uZo0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7223.apcprd03.prod.outlook.com (2603:1096:820:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 01:42:18 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:42:18 +0000
Message-ID: <e26d90ba-043e-40c9-ba7b-7ccdb0a37606@amlogic.com>
Date: Fri, 6 Mar 2026 09:42:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: amlogic: spifc-a4: Fix DMA mapping error handling
Content-Language: en-US
To: Felix Gu <ustc.gu@gmail.com>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 80738ebb-2950-4d0d-2028-08de7b219a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	LQymJKkyyiQmj99Hp+4tlgxdPXB8q4fkErCvA0EeoRO6LL4/Ae2OsKBsAd7O4jm40GRrx2wxRIu1DQJd3YcGfR7gO8WSz8Ej59nEnTvpgTXFwpZrJDKr/mB/c6e1yYfRyO2FmzQh7LTbjnop7J6PN0IutuNvBmwC6xOu4uG9oPgqy0pCYocY6gOG+Klq+/bI0FsXfjIxOhXJtSlrsBf+F0L/1agTZ0jl7Y4wGJIZAm4BMZkxjf5dq6Qbo8T1H7SxhrHOwmFde4oHKkRU1lutnHp3GKhxzsNgkDE6OXiKbgWtqYCdGxMhFoyooJgrPwB2Lb5bLNDwmRcQO/tRfywzJoReNCBBIdlFQawTzGvo2Y0qSefZqg+hrU7FFyMUpGXCC9sFnTlUAnqyPH5uBkC9vTEC3+t8oVolT5yBLlkeNqjoOppvWrh5RWxpuOjuoDT1nDw23ma+JPzyFA8dKFJ2M5DrTOAvMS9Bfb695I9xpDBDcs+4mBwdt1wTtj7aa2sqv3TG1J7BCVCRjfgxp9WDMEaw3i+2nyRBGPnCv/HH7Md2hYqoacKFNTxL9Yn9yMjHL7MylosyCiUCfdkVMpo1FqnpQUfoDC0L51E0gc7hHc3QO3frNvWbYPM5svVOsmxCQ8CF8sARW5/+EAd1u0ciy0mJdkEI2NIrMe9Zmp2Chrs4XNCuOlX2j32aqxuzlPvZt7gO2X0wnPR/e5QvdhH5v86tX7gcuoAKClqepcoVjJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3Q3QVNXRHAramhpZ2UwZ3ZGYnEvTWpBNWJHRnMvVHovNFhwS1ZaUnY3U25v?=
 =?utf-8?B?amNyTG1CQVpWZUQzOGNmbmJpUzVtK1RkbUFGdko4U1JWc2ZQcW5DcTU4aGRs?=
 =?utf-8?B?Zng2bFBaOEVGT1YvM0k3c1MwZVRHTndvT05Qb3pPak5QZlA5cUFuS3IxK3Zn?=
 =?utf-8?B?SjFwT0gzdHAwWE0va1Bmdm5TRnBySnA0OEErbHVhWTBlVnlmK3J6ejl3S0ty?=
 =?utf-8?B?Z3pPWURsYmxueDhpUEd4SGJqSkpEWHZ1V3UvUXB0cCtKUENrYW5MbEtaTGRT?=
 =?utf-8?B?YlVkQmVDVkcvaXZRdkNpeXYwOUYyNTRXaUw4d3p1RW9qTTBsZDJHa3Q4UjV0?=
 =?utf-8?B?S1o5ZXJOWUs2K2FaTitRRzNONld6Um4wdFpXd0tZNVF4M3NRbE9odHcwQzdz?=
 =?utf-8?B?YVIxdFRqL3JLSUpyZy9TNlNsZEVlbjFodjBuZURhMU8rQ1IxMFkreUhrbUN2?=
 =?utf-8?B?dWUybGdadXJVWEgyckwzWjlKOGw0VUtqdWY1T2Y2LzRnYkpYa0xkMDFiOHlU?=
 =?utf-8?B?bzJhMTcyMjJhckx1akN4b0tPR2RvNWR3Yzk4S01EbGY5bEo4RWUyTnUrTVFB?=
 =?utf-8?B?K09jSy9ENzBSU3ExUXY0T01HeURyWm9ibjBNNnZuUm5BTndET21Kdm5KY3BM?=
 =?utf-8?B?S3NYZnpnOE92ekwyd1BYVFc5dFlzTUZSak1PT3BHRzZ2b09QZmZSLzArOGd2?=
 =?utf-8?B?TU84YTdpS3ZPN1lDY3dQY0VVT2R2QWphL2pmNWZGM2J3cVZTdHRtdmZxUXdI?=
 =?utf-8?B?TDZUQ2NDc1hwNzRCeFA1YVdKZUNDcVJVVVRoSTRXelUzNUhWcjNGcm9BMHJE?=
 =?utf-8?B?Q1A4TmJha1gyUm9WeUxqZEwyd2YzS2p3NUtMa1EzdzBKaU0wUDVsVUNRdDRt?=
 =?utf-8?B?SFZSUmJvdFFFcFUrR0Q4ZUQ5MWlMQ0JGempGYytkVVR4bUdGeDd4ZVdOWEpT?=
 =?utf-8?B?WDB3cFloR1hZMThOUEh2bUpDR1hGSEc5L3JraU9rNGVUcXYwcFBudlZ4TVJ6?=
 =?utf-8?B?U3NnR0N3YTZVUERFbUJDQTMyYjRLUFlSdCtIcXdCOTVDejJWRGRqOFY0M2xO?=
 =?utf-8?B?NnRtMnZ0b1MvMXVzbG1RbnY3OTIvakZQNk1hWGtyZ2RtaDgyVlB6aVQxWVZO?=
 =?utf-8?B?YnZqRXQ5R1lkTWxWMnE0RzZwbTRHMkx5SmhleFkwWnNKM1B4cUREMXRtYW1J?=
 =?utf-8?B?aDlqYVY1cWJuTEhEK2M2S2pLa0F4R0tDcnl3eDdwTkxzZGtmVitWaDNQN1I5?=
 =?utf-8?B?ZWJOTHR4Y21ZalFidU9jc3czeWNEZXRWdEJidS9FbmptL0EyNHUzbFo5WDJy?=
 =?utf-8?B?VDB5a1AwMHUxdVVIb2lRMmZSeW9Ud3ZaTkdBZTNaNFNVLzRwM0k4UHdRVnE2?=
 =?utf-8?B?SithUmpodEozQ01OeVRxSnJqSU5meFBaNzRHb25NSFlVMFJZVTlqUm5TREJ4?=
 =?utf-8?B?b1ZSV3dNTDVZV0l3M2dpcEM2NW1JdUt1a3ZEUjB4S005bmt0Z2Z4ODNjZk5X?=
 =?utf-8?B?Ymp4cjBKYStBSTRLUHVURlI1ZktVU00vbUllNEY0cEpYd2IzaENITnFxRHV3?=
 =?utf-8?B?V1ExenZ6dWMwR24vUkpCOGkyeFBUK0Q4akRxcW14b203RHA1amVPWlViNnYv?=
 =?utf-8?B?TXlBeXkxWGEwQWcyTmhML2FwMTFTa2I4RVQyc2EvMUZXcGR2eGJSczliZEM4?=
 =?utf-8?B?ZTJSRFI1aFFqTk1yMHNiUDNHU0xRSklqV3ZrWHo4R2dwNTlJeXBFMDdFY3BJ?=
 =?utf-8?B?aHEwblBBYXdNZktnNXRESjdWT0F5bFQ1U2xDamtOT0M0L2Y0d1cvN2RTMllv?=
 =?utf-8?B?YUlQNm1RWW01SjI2TTNkaFJRS3ZCVW1JeVBIcE5xdGZMWEh4L2I2V1A2SDJI?=
 =?utf-8?B?dDFvMWZtUVM0MDJUTGxuNENCdGlkT21wQThMdG9oTE9JZER1d2o0TzNnUHlB?=
 =?utf-8?B?Z3ZVbURHUU13Q3dIcGFkaGR2bUwrNm83SXRxd3JLcW5FSXk0WVVtMThZYTlM?=
 =?utf-8?B?SitOZWpOczBZVlYzTVo3Y3NUOHV1dDJpejdZa0Q0ckJzSEwzYXRuZEk3eVVS?=
 =?utf-8?B?R292Qkw4b1M0NjY3bUF3NzJxekZJTHQ0VHNOdVF3QnU3RG9HQjJRa09KWThY?=
 =?utf-8?B?ZTh6NTJoZm1sVkxPNzRUQmh4SGE0SE9oSFZFeStlcDFRbXM5Ti9HWS9WTDVo?=
 =?utf-8?B?Zit0dXFwUmxEYjg1aWtBZkdiOVdVblZLNExqYTZabTQvSEk1cWVjcDVpNEoy?=
 =?utf-8?B?UGViUUJkREJJckpWdmpHWSsrM21uZW1qSlJvYWtzeWljR0FIdEFlS2RTQmFU?=
 =?utf-8?B?bHJBWmhHb1pmSlVoZ3l3Q0hPYjM3QzNHTjFwajh0UVFqTzV2SGk4UT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80738ebb-2950-4d0d-2028-08de7b219a0f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 01:42:18.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dlpxPHcpiExuSAm7cHWyulN1K03aurcX7KfrfYfUJYMfDYCqVJKnOl+ujPk0IqrPGHT7fVLd3WML0xKIxATbDcXRe6YzOVX2ThXBLO3CmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7223



On 2026/3/6 01:24, Felix Gu wrote:
> Fix three bugs in aml_sfc_dma_buffer_setup() error paths:
> 1. Unnecessary goto: When the first DMA mapping (sfc->daddr) fails,
>     nothing needs cleanup. Use direct return instead of goto.
> 2. Double-unmap bug: When info DMA mapping failed, the code would
>     unmap sfc->daddr inline, then fall through to out_map_data which
>     would unmap it again, causing a double-unmap.
> 3. Wrong unmap size: The out_map_info label used datalen instead of
>     infolen when unmapping sfc->iaddr, which could lead to incorrect
>     DMA sync behavior.
> 
> Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
> Signed-off-by: Felix Gu<ustc.gu@gmail.com>
> ---
>   drivers/spi/spi-amlogic-spifc-a4.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
> index 2aef528cfc1b..3956869cfec1 100644
> --- a/drivers/spi/spi-amlogic-spifc-a4.c
> +++ b/drivers/spi/spi-amlogic-spifc-a4.c
> @@ -411,7 +411,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
>          ret = dma_mapping_error(sfc->dev, sfc->daddr);
>          if (ret) {
>                  dev_err(sfc->dev, "DMA mapping error\n");
> -               goto out_map_data;
> +               return ret;
>          }
> 
>          cmd = CMD_DATA_ADDRL(sfc->daddr);
> @@ -429,7 +429,6 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
>                  ret = dma_mapping_error(sfc->dev, sfc->iaddr);
>                  if (ret) {
>                          dev_err(sfc->dev, "DMA mapping error\n");
> -                       dma_unmap_single(sfc->dev, sfc->daddr, datalen, dir);
>                          goto out_map_data;
>                  }
> 
> @@ -448,7 +447,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
>          return 0;
> 
>   out_map_info:
> -       dma_unmap_single(sfc->dev, sfc->iaddr, datalen, dir);
> +       dma_unmap_single(sfc->dev, sfc->iaddr, infolen, dir);
>   out_map_data:
>          dma_unmap_single(sfc->dev, sfc->daddr, datalen, dir);
> 
> 

Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

> ---
> base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
> change-id: 20260306-spifc-a4-d40f84506d6a
> 
> Best regards,
> --
> Felix Gu<ustc.gu@gmail.com>
