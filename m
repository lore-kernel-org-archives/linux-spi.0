Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DB36495F;
	Fri, 25 Sep 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342102; cv=fail; b=G1ewrXIdFxTwYelMtPB9tu09wGC0dv+0f3oxltm9PKIIXRiGtIxpfY0RYf7ZyMOznrEsm8RIlNkklJFFHaGVAB85Ww9lf+zDM/TKBfp059Avm+Xmh6I9S5w24zwyV/SuUR12K1b2+En+k4OqRIILS1DbfaLIWOIC4Pz77x4ATwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342102; c=relaxed/simple;
	bh=urGO4d6s/cbb16A0qYoc0pUM9gRRyFIogHVZAWibD8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUuFikSDu/lKHz0t4dnSySbdFcHATdzY62iI5s7VqfpzQaFlMpIBuXchdDYJev4lyXMRec15Ydjcj7fTWhVSqfm7KRykKuoQh4Sm58EkFPbHi0b8IM2nnXPZ6XS0xdWikvV+20b85XlKIyPXQCok7rQvtLy88EuPozixacrYN3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aVPqHx2w; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Xctb1ZgB; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aVPqHx2w";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Xctb1ZgB"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P6G7jA2050979;
	Fri, 25 Sep 2026 08:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=5ipMgeo5tl67PS+WqSOxpmrzpuN0RXfTjG4Bqd3RxqQ=; b=
	aVPqHx2wl9auVXCHikOgR9fx+ymN/Yw+CUFpWnqG3VayZ2coBVgFaSGoQZviARBZ
	leM64IpC5YzuiRBHKMS2mHdBcVFMyyUJwbyqbyfAACtE9TTG7luE/756CRqJRtvF
	ETsWgvJwo8cLq5JbdGc5b50IvNCdKZWpuCBWA4aSN59zriJJTdqdmrxFsiNyok+8
	lJs868Fsd1Qv1yiyXCPlmZ6RoliJMDJtkzeBCRZHYZzKpzUKg0k5jRcvEujwbBIY
	0L/kVqV1ajdm0zJUZ3DwW+lov8a2KKcJLdzAwIDI2XEXCfvrLCwcQBFOnQEOZ96v
	uoOoLpX0LVZThNbCzlXUIw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021085.outbound.protection.outlook.com [52.101.52.85])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gw698h94u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 08:14:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZFP9IBhEDyUH6biSaWD4XEs9Vks1so/b9g1hY6KyYohl7gKnIJuqJkt5sQzDyHcsEA19bz+QSLJS9oaTonn1y3k90G5pfZZMihi3HI6mGNG8E7mntyEAP84ljOSxhrGjaSDmYS/pVG+Y7b1W7l/G9GD8/rwFFCIB94jYl1+Rv0/HQL82OJOAyJi0klisLLsWfO6NaL1/xLHAjfDdBRgb4px2u5KyJ/mrv5ISOrzHv5b5nMfwrT90oSUIkltgvLgvLwSchs4pVB6XWAEfLoVYTM4Wo13j9vGoK9ckrmHEgPmblrEX6j5pvKSFL67gMYEGJRvsGRoN7lhBvsLqgcRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ipMgeo5tl67PS+WqSOxpmrzpuN0RXfTjG4Bqd3RxqQ=;
 b=zRAkqsH604HJYngTD+HjIiXM6ilQR8H7DupD0K8JMz9Llzl7h1l/kYoibCDAubFqShHL0gitrx+caaFu5OMolH/ptQ9eN8xOwI3J+zGNPuYUqlCJ8WYhJzdsyTg5x/PfYaI8LNvhQPHm3jtmWxE26jWlH31w/0NsLaqxboBf+xkSqsSaKnUMWmyFvgEiueyav1Yv1FZEWRDU9r0+W3NzRkrM/OmXA0jtM2toJTIchvHgPFVYprwiBkh4w4QUGAqyp/XE5LpOmHpIGB6eePw3SgMta4v/tIgq3coCaOkx7hX6lX5QaR9H93BYL8h1OAfHREMA9keZfV9ho9L9gfF9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ipMgeo5tl67PS+WqSOxpmrzpuN0RXfTjG4Bqd3RxqQ=;
 b=Xctb1ZgBWc63YCF2pkSxxxt7mmt+AtYaATcMi1zUr+ukDKcQx+rDKRBZEgBUWMPYSM6EqQqnKGrE/DdzQDEAaYAzhimEzNiB7tcztj07b66WaEsizcTfZM/wgqUavSR5zZMdruSFbKXaLRbNyuD9irQl9bbIcOA1cHUX+kjH30s=
Received: from BN9PR03CA0094.namprd03.prod.outlook.com (2603:10b6:408:fd::9)
 by PH7PR19MB7581.namprd19.prod.outlook.com (2603:10b6:510:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:14:40 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:fd:cafe::35) by BN9PR03CA0094.outlook.office365.com
 (2603:10b6:408:fd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Fri,
 25 Sep 2026 13:14:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.3
 via Frontend Transport; Fri, 25 Sep 2026 13:14:39 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A8752406540;
	Fri, 25 Sep 2026 13:14:38 +0000 (UTC)
Received: from [198.61.68.157] (EDIN4L06LR3.ad.cirrus.com [198.61.68.157])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 36B48820247;
	Fri, 25 Sep 2026 13:14:38 +0000 (UTC)
Message-ID: <24c995b6-44e9-4225-bcd4-b4e7f6ebfcb4@opensource.cirrus.com>
Date: Fri, 25 Sep 2026 14:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS
 13 DX13260
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20260919134730.895381-1-rf@opensource.cirrus.com>
 <aq_4PuwVngaLZ3_F@sirena.org.uk>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <aq_4PuwVngaLZ3_F@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH7PR19MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 836a93a6-6762-42d0-f99d-08df1b06f4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|61400799027|22082099003|16102099003|18002099003|3023799007|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	C0NYI0c1Gpp3BX0XgRExZEZjw6P7a2x1ezqW1x8JZhIqqg3gxdDn+EtOKd/OWRcvxrAhfMSaVfhjaxCGaZpojWFBnkubNXxJp+pmMJG7LTWtRRBDECg8dtIlplbTHVd4jTDbXz/Bw4SIjJfAZd+z6AwNPVP6HSbfabYj+0q/dabHF3z3wK8ow3YEPb8MDsDzaMy9hgcMQEbF/JvUe/wK21PULdBZWfiwkxzRwC71qmnTYbjmNQ2tt5vID+dWNcPE6ibsNxkvO0cHz/TxyMiwotK48jpkqsW1e30Ra51xFB5XqnJBwJ0tMbHPOqhYt6prAnHqOfpjLMtC0/z1i/IvmdBU5WpUdYzuM6mvKD7MniP8rsNBA95UxkexjTU7EDm9CD5fRVhyMCZ77wehDaSpGQlfQTObsm05dgtJYEcbwW1tArQvRhSxfpXwgC5zwjYc0oFSCRwnbHiEB7XkCOumpnaPAnbG5UwQiUdEbLDD1n8ovbzx+6fbK2nUVJI84PORQlWMtZjbJsA/5Otw1hYE8c0/m0+O/tIm+CLNpju33gZWnfGR/UWS9psuHDfEdDLE+hOc3SnLbbW5nQWJ4fmddLRqLu1OIL+yWgCKv3GMQkHzQ3VKlQ/eeGVZvdULjjyvuEqqCHsy2cHLGGiNZC/z92Sm1ToNJTpUajNjqxSmlp4bb3MRKYy1U8HodPgihowc
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(61400799027)(22082099003)(16102099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0EFr+jDVqMZLNZ/unsap7LYBrqDw721K19v4HFO1pRLsHRU5ngonk6ldz1ZZzudb5UHBQBEzfk6OAUoUFh5/w3fqCoeYDPsCDZ9QADj39Gs9tZWMgEjrhu8mV6ei2mfByrXzglPvnmVC2ua0OC/y4M/43Q4VvD0zE/QXUd3AbvV2BhCh20OS+OS7o3DdYXZtnAbiJpf44v1/vH6G+ILD5bhDZ9Orz9cKXoeG31BZ5vIXB3Nfm++FmoMo8d4pRxzskbKdmXCKi4Z43C1OxZslUGczzlkOrBICaGNkufdW980kRjIOsdgqec5+F0kwQkPpTb539QbfF187fEmsMPTP4pX6cr3OuOWfjzw0Wu6rSZ/H0BnckcIakBtai8j0CWZtt+GWaX5m5+BGyXfir7j8P0NzUmIfR/scvEaMf7q85a8EHrL+WJe5hKnWWmeL3/8H
X-Exchange-RoutingPolicyChecked:
	mNxgX/yZkHycQoCQxdoTwe347NUuJDahnxuzeHBKKof7+eKswuKKzXaGPGiAfgNi3z0PRKy2RyO+ZRU2KuPAsePmcrslE9Yxa1lMHxMaKdahJvaWTHws5GVNdfH0O8vapekhKVYjac4UO87jFDP817Da4J/4+HT7kkQTOJ9KwT1+x0gwgwKD6/sMlgryGbXM5KTHkuxYR7KTSKyZR3juIl9XpqNfOtGoMZhygVXKkVBr+I5jqf/KPLteK3Mrp9KpEdr3UsGMN+9Dvg+Yqbdy5UWuuGzjvRnBdXM/CJDNCW4eYcB6dF7fHcuLz93yPPDeQowbrE0NhMLgzbd/dgYmsQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:14:39.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a93a6-6762-42d0-f99d-08df1b06f4da
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7581
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MiBTYWx0ZWRfX1MUg8zkDQhyT
 g8Vt0fmyll/X4EnPsLFyyYdB+r4B/KWpm0v99A0Ktk8ANcLgjcyaDVxwnDguLd5d5OpytTRiTCo
 kiiWC995ysYjuM2iZFIqxzpfLlz2/JWoavJq8bb5/x0C/6ts4une49KZF4W1KOzRAhmSZSo+a7F
 6maurOEtlQ2lr3VmbzvYRvyOiT8EcUhYfK8WZnI8cIj8sms6mwo6QeSdfW9pxb05nQ5Nv+gjifC
 qhQC39VOdCE4pNz7DpdA0IdwCwISdFyidh5TBy0JJNFCnxxSNp8z99uDDLc8RyRQTctyPhLIMBg
 k+YDLdrGh9ERN1h5JXSNiCdfr+oP0qI5S4AkTrbedlzU27KTkUzho3AEnkmRH1InKGYYebZvPIu
 aKVaCWB3fXUm8E0p+TYhnUqXJF14x0AYMZhx4hApChP8cXAXos1M9LTPEdjTozGKxZ8/D9PKk6J
 d9AzXRcSmiRIB2/2MZA==
X-Proofpoint-GUID: tuS_17o5ZXXJB-RRK5rYH7qFulHqg8Es
X-Authority-Analysis: v=2.4 cv=Zu94uN7G c=1 sm=1 tr=0 ts=6ab673c5 cx=c_pps
 a=GzbtWuAz25DTP0J0usuZ9g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=76egbmjv4PlEm7eSfK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MiBTYWx0ZWRfX0/pf7N4vNQmZ
 vXzKL0UM/FMaJbUQlMINZTUnaQPcMCq593HQB5esHIMbNNnVmN6BWS9xqMjkMXP0LYsF/a1NBsT
 jntjSdYQYQ2UgB+zAotr4fF/JwCgfGM=
X-Proofpoint-ORIG-GUID: tuS_17o5ZXXJB-RRK5rYH7qFulHqg8Es
X-Proofpoint-Spam-Reason: safe

On 20/9/26 16:14, Mark Brown wrote:
> On Sat, Sep 19, 2026 at 02:47:30PM +0100, Richard Fitzgerald wrote:
>> Create an acpi_gpio_mapping so that speaker ID GPIOs can be read directly
>> from the ACPI GpioIo() instead of relying on the spk-id-gpios property to
...
> 
> Is there an overlap with cs35l56_try_get_broken_sdca_spkid_gpio() here?
> Didn't check thoroughly, and if they are doing the same thing it's
> probably reasonable to factor out incrementally.
Only slightly. That is fixing a completely different problem that 
affects a couple of old Dell models. The normal non-broken speaker ID in
the cs35l56 driver will need the same change. As this is a workaround I
didn't want to complicate backporting by entangling it with the codec
driver just to avoid code duplication. I'll worry about that later.

> kzalloc_obj() needs slab.h (which will be implicitly included anyway but
> still).
Acked

> Could we see an -EBUSY if there's something else using another GPIO from
> the same provider?

I'm not sure what you mean by "another GPIO from the same provider".
If you mean can the codec driver also try to read the same GPIOs:

1. No. It's read here in the SPI bus driver because on these systems the
cs42l43 is the only device that appears in ACPI, so it's the only one
that has access to the ACPI GpioIo(). And there's only one instance.

2. The code only creates the mapping temporarily while it reads the GPIO
state and then removes the mapping

3. If it could return -EBUSY it could have returned that with the _DSD
spk-id-gpios property and the original code would have returned an
error.

 > I'm a bit fuzzy on the ACPI mappings so possibly
 > that can't happen.

Linux used to have a function to read the ACPI GpioIo() definitions,
same way Windows does. That was removed a few years ago so that GPIOs
now must use the DT-style "something-gpios" way, and an ACPI _DSD
property provides the mapping from that property to the GpioIo().
Of course, that _DSD property is Linux-specific so won't be in any ACPI
written for Windows, so the acpi_gpio_mapping had to be added to provide
a way to read the GpioIo(), but in a more complex way than before.
It's just a mapping from Linux-specific named GPIOs to the actual ACPI
GPIO definition. So we've gone in a circle removing the ACPI-specific
API and then adding a ACPI-specific API, but I assume something was
fixed by doing it the new wat.

The ACPI property takes precedence and overrides the mapping, but the
specific case of the cs42l43 SPI driver we know that the node containing
the defective _DSD property is always different from the node containing
the GpioIo() definition.

On the Sashiko complaints:
1. Code doesn't handle the singular form "spk-id-gpio". The script that
generates this ACPI is hardcoded to the plural form, so this isn't a
issue I'll do a change for that anyway just for completeness, but I'd
prefer to do that as a separate patch so I can keep the "tested-by" on
this patch. (I'll do a spin to add it to this patch if you prefer.)

2. "Does this ignore the ACPI pin offset". Yes, that's precisely what
the patch is intended to do.

3. The stuff about overwriting a GPIO provider's node. Sashiko seems to
be assuming that the spk-id-gpios is pointing at the GPIO driver node,
which it would be on DT. On ACPI it's just pointing at our node that
contains the ACPI GpioIo() that points to the GPIO driver node. adev
is the adev of our child node.

4. The "use-after-free" seems be the same misunderstanding, it thinks
we're changing the node of the GPIO provider driver. We're not, we're
adding the mapping to our child node and only the cs42l43 driver uses
that.

