Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225621;
	b=337A5W9cVq2MTu9qhUeDSiOFuOj3GTcdF2NZAlWj9nvJNAxLubx80FO5LvrqOul5FqJC
	 5buZGa8DFFIx+oEt4BV/NUoCu/+TR/9vmxSQX49AxBRUBT7IiavgmHsKCL37fkcXoyd87
	 +UzaldsPisw82tKHczSt+ZyWX5cAyu3VMHwPUkfZeO86XA9OXH0i4gqgoWk5srTpbR1g2
	 WgDqvmoiGnfCP+RO5arvIFCJLj/dIh5Z7P5/THwddG8tmujS5EvG8kwsTco8D2fNwndDs
	 FSG7tYarJsFfUWmr57hdIUcKlPEwGKEj91usN4zz1SamDsWJwpg/tc0iXIJiwwKgJ7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225621;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nBpYxTzg5Cnwd0SUJSo89tDCrDAoi2WNpBId1h/ZsDw=;
	b=3c5X314zrle+8XSLmSvQ3RhYMsGiAL+6Q3VRSHtnT4UpO2mKvv85UCore/RgYYMn7b+V
	 +wIerBTevv1kUzus/m1J/5y8EEX5fl/qpHKl9fm2SqlN2qVnZYpF5qny3JbZemf9zQ16b
	 QbyL7yxoCD8K0h2MGNxCbqbfxIve8gTGgCPpeg0jPps/4kn1xtb6t77PRPu+2sm9pCQnk
	 XbxS7Gx1wnFv041x+Ivi+HZ0dwYyHShWBFO/yrdmWtmEcLvF3r45wr3yQLKS3XatCNgm8
	 bw7ZoqrptRUs6VYEACzMEjTuWCVQ1Pd1l/ETATSQZjnS+1F6z+KjblK6tn6kKNGIM/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hEAPFhgP;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="xDx/thLE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B3606A321;
	Mon,  9 Nov 2026 12:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hEAPFhgP;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xDx/thLE
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9Bw1ce626551;
	Mon, 9 Nov 2026 06:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=nBpYxTzg5Cnwd0SUJSo89tDCrDAoi2WNpBId1h/ZsDw=; b=hEAPFhg
	Puwwj2s2Y8LVOLMIG8m4SBzUzHar/jgKt1hQhruYxs93VZpYQqhZJv3TVKZotUL0
	/iERmKG0gMKJETW1yNFcOsx/leWS4idYbp9KP9hO6jSbvWgFIYLw0mj6K/Cyq8XX
	Za9SQ62XPKff+37DxJ0IgJ/ur0E5L/+u/mYn9zM2fx04jDNeowyT2KOWqyg5Tf5T
	RyUn/iAxZzf1RGybszJTr3v5g9yGwxC3OmHL9Lpj0MCkkeVDI+MKIgRrM3mXAZyG
	BNTjbLE8L8t5HUmCXux0HrDP0vQsVqHEMXgYGV6FAYMArD7/ekWJkAp4dxeBNyhs
	A4jw1X6DvZPQUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nBpYx
	Tzg5Cnwd0SUJSo89tDCrDAoi2WNpBId1h/ZsDw=; b=xDx/thLEmHPqYLjLOZwd+
	7C+FYmjMtsOqRCW6+KYIZcyPAE48n1azNZhkGSDwnyaHz2ZEj2UjZAGkNc0QIF6A
	RJeROVkswxcT+jpkg+dyjipi3LGqprvsRZ7hudGY9Rd+muFLIcorzJ22CJ6t8/ZU
	ZCWJKO6odsymBvbCb5HfSUm3avReSVPRcphpmkuBQ+Wg6YTu0ElsMSxdYinNF5xs
	kPACbgae/ifxh5HeV9GNrUHFka1Zy9i7RHghGxwnu5r/XCnKdKtA7QeuXlG8A5m2
	MoTJWTTpP/Jh+aiOAe7HedFZSv2LRdkmoPfSTXwV4JqW8jMDto1X/RIqDoUlxXu2
	g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4huds0r0bc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 06:59:46 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D76ovuAtFVceSQOWPd9npo73OMfQiID4YVzf5o3AGWjFJ6Sqlvzy80IdSkBfFQGSf6H3suWsTYRDIMjUTZ4dqCvdbk3nqU+D4/N5pVx/KrZip6YZ55NUu1GE1mLtgqDXvnbPdG+ac4BZg2ncTfm4DovRGODLxpyPMAZNLXH+rhdy2sF2kb5t6m5iQnApZLrMhaXFJ3jW8LTnzB6W90lCd9yYU43j+E4kySrvkUjjsIKaHLXOGVUO1f/Fd+rR9Ol/HoOUsE8krBfz1I7/bmW39IG+hFf7JupsFLuiL9lz7qTwKCVHlnyu8KG6Xc+FTJ84gaquY81tyZgH7epB7u1KWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBpYxTzg5Cnwd0SUJSo89tDCrDAoi2WNpBId1h/ZsDw=;
 b=Z19DCl3vunbnHF4+73dEFffJlDtnp34FSQsG2YtpH4icRWu1DnYBTwBwTbWYgtwvWYKfXm4BmwmFDpBbst5cZJH9L1dO6JCdqo9Swe21hoq0udbjaroJE2UwDvZouLAKeaTDm4pQ18Vq69DDCxZu+2tc4npA/eyIaey9iej+wdWujLpiapY2Bzk2psyvmAfRLSEjg1odoG2PCziSQUPNTHCfyuMnzk8XduHaDpHzLca2e9M6XDYdp9qviWk1yV0IUyMhHpRmASSiyUVABpomHZIoh5HBOm9ULqGZev0XSyMYx4BtNGVzSZbqqs524/k2IzMU87eTch462EEwwl+VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SN4PR03MB989447.namprd03.prod.outlook.com (2603:10b6:806:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:59:43 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:59:43 +0000
Date: Mon, 9 Nov 2026 12:01:00 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <avG1pKdwnV5CSy7M@nsa>
References: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>
 <au7Tz7Xp_fropQVZ@xhacker>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au7Tz7Xp_fropQVZ@xhacker>
X-ClientProxiedBy: MR1P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SN4PR03MB989447:EE_
X-MS-Office365-Filtering-Correlation-Id: f54ad588-1b0b-4844-326d-08df3e58f0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|56012099006|261021133027099003|261021123027099003|261021135927099003|261021130227099003|261021121427099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261009221227099003|261009223027099003|261009221727099003|261009220027099003|261009223327099003;
X-Microsoft-Antispam-Message-Info:
	YIpAWhl+PVZiZLHXXWW+4TaicCtbRye30sdfQDrFHqBHyvi6IhQpF7Ywr3y94ZVvFVHoY+m4OSSZ5h0iFnmOkXAtWrcygrvB8obyhr5kbbbJ3J+BYQgow6grOyoR4G4Eb9kVRXT+fzK9udv2/ZGL3vYD8/YS/Z9r/BaNXDAEncNUBg5auNwGL7Bee3XiMbq7APUdiZv61Xy+KHKMraIc49m4FuI/1A+hCTPYrH0nITPWA3ODmdTrlQNFyxPZnuFnnEoMWEPfEsi8/gZjxxUyZGrxHHSXo7e4235cEU7gubYqiX3yvuRje3U0PjAq7KrZEfv6p/Z6ZfQ8Tk2t4DZVMqBTJZtQ7a5MM9KoH0jK1xwDlmaFmyUMlvxb+Fm4+s2rsJJuH/fKenBsTIyW9XmuZerSYp+mUmbsk7PewvvcF8Iqbrz9zCMHDXEmGqzwZnbJgYes6P1lKFWhQE4yB8mxQVCW2vpo9Qd9ynR/W+WD7qqdHUNLs1kHdyUx21OcI08ulOArceFChjGbSinOTmSptiIz2O91e6Myc8nhyXwrGrw+icZhJWZvgUcNrHpM6siubvGZklbGaduLpJUlkLwvX2zUsFG4cr+vJlDdkK3ytcP96Ggria7255DEF7Udi/FV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(56012099006)(261021133027099003)(261021123027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009223327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1Ycnk1K1UvdGcrVlBQei9nbkVwcXl0YjRLTzV3NTRjZWFOWkFJc2N1YXFT?=
 =?utf-8?B?b3ZDWU53eXpzSVdtS0ZvcllXYnAvSy9NQ3FoRHU1N3h6b2lvbXdicENVanZN?=
 =?utf-8?B?YWVRazJDUzlWaVI5TERkaG5mMXlsVENwVmsxL3BrT3lUUjNtYmRGZ0RObVVW?=
 =?utf-8?B?VEYxNWhMeC8wMC9Vdys1c2RJOEY3bFExejQ3dHRtNmhtbjVYKzBHN29tQmdv?=
 =?utf-8?B?QWRlNDhEVDhQTzYyMmY4aURhWGxjLzZSMC9LVVI1UkVHMVQxTzFJRmxmL2E5?=
 =?utf-8?B?K24xaGpJbDlUTVd0Q0VCQlpxcEdxeCtQdjRvQ3UwSEEzcmN6YyswOTJnNkMy?=
 =?utf-8?B?MmdlUS9DaEhKQm9FSEk4UnVCK25hYWd1MTg3NkFzSHJCQVJpeTFtZnFXKzlu?=
 =?utf-8?B?Q3FtYUY1T0d5WTdBdzBjaHg3clY0QTI4VVFCUjNMSjhjVHgyR3lnWHVtSFZs?=
 =?utf-8?B?NFNvWXBhcURxV0I3UmhQT0JQY1VsRklTYWJXaVJYVm9SLzU0SlVuWVB4Q3RZ?=
 =?utf-8?B?eGp0QU9PYkMwd05sUUNMY2o2blJzVE93NnRsS0pRQkNhc3JLaityWm1laUxq?=
 =?utf-8?B?M2FPMHJWQnJYQkJzV2tWRDhaSzkxRGdCeklMdEZBdmFvbXhHaTNOdE9id29Q?=
 =?utf-8?B?OWt0MG1uY0lNd2xkOEpBdkdqMUJROXNYbTNyYytKVG9PWmhacXArL0tHRE5D?=
 =?utf-8?B?U0drbWxxV2NveXJSZjdkdk5aNFFMazNsakNpQmxFc0VVdFVLcmIrNEVlWlA1?=
 =?utf-8?B?VytUMUJxYjFBekg0L0owdDRvL2ZBVmZYQjFQMXJhYmFPWEd5bEk2Z0FPTW5t?=
 =?utf-8?B?U3h4V2I3Zjh0YnUxaFZjaS9RRUJtM2ZUVkg3Y1dyVitMZFoxU05DMm00Z2tQ?=
 =?utf-8?B?VGt3RjNpcXRKWmd2ZXJwdWJpendBWXdkdkRmbE92NFczVFA5aGxaL3BaMmZi?=
 =?utf-8?B?Mjd2eHZHV2dpaUVMbzlOTS9zUUQ3c1pxRmI3NW5JWkZiRVAyOXhXcnFTQlZm?=
 =?utf-8?B?SVJhK2F6WE9nc2RjbXZhQWJWTVI1RjZnRXFGN2czaUxUMEdPUS9rL2Fyc3J3?=
 =?utf-8?B?Z2xDdnZvL3l2UkIxc0J3VEpKTHEyaHg2eVFHbE9WdVIwUVFscVBvK255SnZM?=
 =?utf-8?B?NFhQS2RpTGw0c09ZUUIyZ3ErNzRBZENDbk92eXF6a083azR3eWI3d3dXYWNE?=
 =?utf-8?B?a0dwUVdGelg3Y3VXRUE0dFR4OEdBNWxUL1pUcTdYWDlma3p4NDYxSFErYTFX?=
 =?utf-8?B?TnhIUUNtOCsyR0FlSVllY1FvOVFRZndCUS8wU1ROK3ZvSnZxcEF4eEc4bytz?=
 =?utf-8?B?TFdiWWlSRFNISHFzV0plYzF2QWZIdHliZmJKeTh5TldTT05EUFlQWXJQb2hz?=
 =?utf-8?B?KzlMeTZUa2dhMC9WakFRVEZCditaZ1hJbHdnai9mc2dkNmpTUEVmWnhmekNX?=
 =?utf-8?B?RklCZTF2Zkd1VDBLbGNvUHBZMFYwZ0VsNG9xZUZoZFQwd1FmeC9ld1J0eEVK?=
 =?utf-8?B?YkxJeXZKSHJabFh0UkFaaTRCRGp1ejZJYmJMSjFpbC9mRnA3SHBBL01pNG9z?=
 =?utf-8?B?VTZUMDFIT1dobWk1UGNDQjZtbE1xV2pjdGdXTGNOdm9EZmN0bTMvb3RlVlFK?=
 =?utf-8?B?ak1SQnhvRUc0SlA2c1RyYmRFM2JaYlJKRXo4Q1Rkb2JpWXBXQS9MYlczelEz?=
 =?utf-8?B?WTcvTzQyRXAzWUV2dU4zU1BNVjJmYXFYK0ZCVC9kcUpsbXphRzk5OXptSHNu?=
 =?utf-8?B?V2xmWGg4all3eWRJeFlyN0l6amcxQU1saWRaVjFORkYrWVpkekF0OWR1NDF0?=
 =?utf-8?B?T0NrMW1pOHFxdy85czVYTDFMWUIzaG41NFlBY1FycUJGbERTbkhSTkFtaStu?=
 =?utf-8?B?d3FtNXVONHdlSW9oTzk2bEFNUmhKbTBxRVgrRFN1cWNySXBaQTQrWFlQZXVs?=
 =?utf-8?B?dGpIRkVsemI5a2p3cFlGMUVyR01oclRKeGpHbHcwWkFiaEM2RUpvYlZxOCt2?=
 =?utf-8?B?N1N2RGRSeTdzSkFTQXo5bFJ5enJCN2cyVkF3ZkdsWVRMQ0xuZ0FpaGxjYk4z?=
 =?utf-8?B?Q3Q4QjdwM01KRExqNkdSTkd6bE8wQ1hPaTRuT2d4eDREUlE4UXo4RndFbnQ2?=
 =?utf-8?B?eC9uZkVHa1hLVHk2UitkQmVteDRqWElzT1NaNGI5M1Fna0drRzdicnY1ZjEv?=
 =?utf-8?B?ZE1LQ054OCtQQm1xd1E3bkJjdTUyQUhaOVMrZllpajV2N1JSOVFVMWY3ZFBq?=
 =?utf-8?B?QmRMZmYyeGdSbkZwOTZZVXdub25XSnUraHpGS2F2RGk0bnRmNmZ6amV1UVlK?=
 =?utf-8?B?UkxZRnNEa1dNTDV5MlhQbE01bjc1c2NrT052K2ZmcmtsNkRQMzVCZz09?=
X-Exchange-RoutingPolicyChecked:
	wuRCD6q2CR1/rCK24oIDksxhhBhZaQuKcrQqdr+5/0tzLb6rMgbH/cn2F+y1A42X4ruolRUkC50fmXhH4AwwxtgOyg8bmF+j02VuskwFIO+u0Bqcs1w8oZt4GzBgBJ01Fw3zdunB4v9EcA61PxWywo4Pgd/Ggfluaiahvp8r3ZagOdUiNUF2ZCYMRGoIKxwPLiEQjJRQZuFGAgxyBShxDu1x1/+iy8RP6ioomEghnR44HTAm1BfnztV89Lo99FLFk5s/dWMgJskPzUCiOEjkI160JD+IQGuAAvhsjNRN/9EvgiGmZfe2/Lfr3deKIKC3B/1LgkdeE+aCZpq2mOZkQw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54ad588-1b0b-4844-326d-08df3e58f0df
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:59:43.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufxXgjnZfyWnpY8cGtntVMlr6jkL9qC4/TQZfujWtbXxa0nlh49FyfupOe78bhD20aeFiO5vC0eT0sBkXlZJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB989447
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NyBTYWx0ZWRfXxYiHKV66KczU
 HaXWWj2hby6Tm2zT70Hy/5BOnJ66LmpBmAWCW6q2a7Mm+370w7gTjIbxbgCaQKKp6y3MtYlY4Kd
 cJQNUVvSxg2CqMtL2FRWQaxt7F/FM1AClHATplV0Z7CpPr7KevS2
X-Proofpoint-ORIG-GUID: 6VMhu1m1HsA63fZGNps-RPUI-9mUP_c8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NyBTYWx0ZWRfX8ZdEKWshSexf
 XGYFYfZ8tRy5drK3KOBqXlJBbeSJqLuNqqOSf/vxznpfq3eQIbjrlWaf0i9RANi0D17kp7RUlZQ
 +4ZdHRkBDA3lzH/xRbp6crLU2hudM4VwnmAQSoRni1XuSBtmF8cLUv7xuQViztI8gGNfTFs31MW
 h1Hryi0R/KQLj6Gren/A5xp9YnoHcLwAQfOlIzxnHjO0qp0KBDuOBG4lQJ11L6xn7kyqySSYz7z
 YWqjDc4yngpHcRNxxxKRRNmOFAEoKmEOVbVf/gCrhD2zEQvTdoR+ef7wqXyFK2VUoyFKt9fmzy6
 oCii51+7wDfXRmxDggySFkEHXV7bOi/jB6Nd/45OX/8dewRbE3DRHACKxvfMu+DYgqkIOphiWEh
 B9QzLHqNRH2Jw4UsB2lqwSqkh+ATRtgCZo81qmx9nRlPaU4wc9se43HZSsbMc+v/ZY7YDz2Co1j
 /OiJfm8erBMQUD3A08Q==
X-Authority-Analysis: v=2.4 cv=DpLDa2/+ c=1 sm=1 tr=0 ts=6af1b5b2 cx=c_pps
 a=TdY+Vr9RQ+qa4geS/iuwdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=qOIGJM2YW85aICZ6mjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6VMhu1m1HsA63fZGNps-RPUI-9mUP_c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090047

On Sat, Nov 07, 2026 at 03:31:27PM +0800, Jisheng Zhang wrote:
> On Thu, Oct 29, 2026 at 03:53:07PM +0000, Nuno Sá wrote:
> > The Cadence xSPI driver currently drives every operation through STIG
> > mode, where the CPU builds each command and drains the data. The
> > controller also has an auto command (ACMD) mode where it runs whole
> > sequences on its own and can move data with its internal DMA, which
> > pays off for bulk reads.
> > 
> > Whether ACMD and the internal DMA can be used depends on the SoC
> > integration (external SRAM, the DMA bus requester interface being
> > wired), which the controller registers do not expose. Hence two new
> > devicetree properties: cdns,has-acmd and cdns,has-internal-dma.
> > 
> > For now, ACMD is only used for reads of at least 2048 bytes with an
> > address phase, using the internal DMA, and only when both properties
> > are set. Smaller reads and all other operations stay on STIG.
> > 
> > NOR and NAND are handled the same way: NAND operations are still issued
> > one by one, not combined into a single ACMD sequence, so no NAND
> > geometry is needed. The real gain is on large reads which, for NAND,
> > means chips supporting buffer/sequential read mode.
> > 
> > Another attempt for ACMD was sent in [1] but that relies on knowing the
> > NAND geometry which brings much more complexity given that it needs a
> > proper interface implemented in the spi-nand core. So we agreed on
> > starting with this simpler approach and then build on top of it if we
> > agree it pays off (mostly on cpu load).
> 
> Hi Nuno,
> 
> Thanks for this series though I can't test it because my platforms
> disables the ACMD during integration.
> 
> I just sent out a series to reduce the cpu load and improve performance
> (possibly with powerful system memcpy dma engine), if your platforms
> have the suitable memcpy dma engine, can you please try it?

Sure, I'll give it a run and compare stats! I need to first tidy up my v2
and will test afterwards. Should happen this week!

- Nuno Sá

> 
> Hi Fei,
> 
> can you plz try it too if your platform has suitable memcpy dma engine too?
> 
> Thanks
> > 
> > Some stats:
> > 
> > ACMD
> > -----
> > 
> > SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
> > -------
> > 
> > flash_speed -c 5 -d /dev/mtd4
> > not NAND flash, assume page size is 512 bytes.
> > scanning for bad eraseblocks
> > scanned 5 eraseblocks, 0 are bad
> > testing eraseblock write speed
> > eraseblock write speed is 1054 KiB/s
> > testing eraseblock read speed
> > eraseblock read speed is 106666 KiB/s
> > testing page write speed
> > page write speed is 1035 KiB/s
> > testing page read speed
> > page read speed is 15238 KiB/s
> > 
> > SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
> > --------
> > 
> > flash_speed -c 5 -d /dev/mtd5
> > scanning for bad eraseblocks
> > scanned 5 eraseblocks, 0 are bad
> > testing eraseblock write speed
> > eraseblock write speed is 6497 KiB/s
> > testing eraseblock read speed
> > eraseblock read speed is 44137 KiB/s
> > testing page write speed
> > page write speed is 6336 KiB/s
> > testing page read speed
> > page read speed is 16842 KiB/s
> > 
> > STIG
> > ----
> > 
> > SPI-NOR
> > -------
> > 
> > flash_speed -c 5 -d /dev/mtd4
> > not NAND flash, assume page size is 512 bytes.
> > scanning for bad eraseblocks
> > scanned 5 eraseblocks, 0 are bad
> > testing eraseblock write speed
> > eraseblock write speed is 1054 KiB/s
> > testing eraseblock read speed
> > eraseblock read speed is 64000 KiB/s
> > testing page write speed
> > page write speed is 1042 KiB/s
> > testing page read speed
> > page read speed is 14883 KiB/s
> > 
> > SPI-NAND (Cont mode)
> > --------
> > 
> > flash_speed -c 5 -d /dev/mtd5
> > scanning for bad eraseblocks
> > scanned 5 eraseblocks, 0 are bad
> > testing eraseblock write speed
> > eraseblock write speed is 6564 KiB/s
> > testing eraseblock read speed
> > eraseblock read speed is 18823 KiB/s
> > testing page write speed
> > page write speed is 6400 KiB/s
> > testing page read speed
> > page read speed is 18028 KiB/s
> > 
> > For now, we have a static threshold to decide to use ACMD or not. I do
> > understand that's not ideal. It might depend on sclk and number of lanes
> > so not sure if that value will be accurate for everybody. So, open to
> > suggestions if someone has something in mind regarding this.
> > 
> > [1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/
> > 
> > ---
> > Nuno Sá (3):
> >       spi: cadence-xspi: rename sdma_error to xfer_error
> >       spi: dt-bindings: cdns,xspi: add ACMD and internal DMA properties
> >       spi: cadence-xspi: add ACMD mode support
> > 
> >  .../devicetree/bindings/spi/cdns,xspi.yaml         |  18 ++
> >  drivers/spi/spi-cadence-xspi.c                     | 269 +++++++++++++++++++--
> >  2 files changed, 273 insertions(+), 14 deletions(-)
> > ---
> > base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
> > change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
