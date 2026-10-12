Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5F451991
	for <linux-spi@vger.kernel.org>; Mon, 12 Oct 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800005; cv=fail; b=o1Wy4o+L4gSRxG7xUI8xGtvBD4FmNEjQrUH84jTHv0/bnfLjMbZFJuUAVvoSrmr2r/XBYhnsqqJminC7+6oHrYjEU0m6q9ZYEVkkb3+ZIO8LwamsyqNWg8Y1HBpymBzK5nCT+6s9drMZ7lTx6hHV8HV6czu/Lr0R7GjvaV+xnAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800005; c=relaxed/simple;
	bh=q8Jo+NpYxh6eZwIJjy/HYaME5B96iu0iG/w8VR1I/e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+YNjySSb1Iu4i7pgCr2IM5P7shbu2ZXcEXM3pRn0MRS97W0VHZAmUZrbQJag1iA+M3GeijoBT1AO/WJJD1EjxQMFotTSeLlm9eqFS0sGKXqdv/eHwG+7IBsp8ChrmuJItIv/KJHxF8hHw+6ENDdH47BaRMOXBrHbvzNmgM3Oqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=iyC4JFNC; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J/Oqz7Hq; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="iyC4JFNC";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J/Oqz7Hq"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8LpSZ1680000;
	Mon, 12 Oct 2026 06:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=oYejRjcAf7sE4/zNCC992h3eneWbwoSu/i/N+vgbzJA=; b=iyC4JFN
	C8x+jnSm/a9/fY03y+OCoZ7xO+doz/+J0Fx2DgXzeNHxtTZKJdqbag8tPGXsKwqH
	7oYHb5/S3N88YogFcB2h/aFZZj9QnvDOjP8hGPoR0bmAdnZVbNc2gZg7mNTEDPV9
	kFkLdKq9WfZAOUdFM8IPvi7bLJEVTTvXchEhyf8odBS8gl6c1KYh+dIZNKnyEz+I
	hcRAhiVgucvAY0w8dL45C4H0mRcXEHqXNybeZFYlKe/9ohtMB1oGPJQmRlGRjM7b
	paiXsmn6HZi5f4oR0WbM1AiwwqznKHA1amuZ16RCuCm0Fq5xwH+NOetw6/IHJWxl
	uFDR6hXfNFDF/MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oYejR
	jcAf7sE4/zNCC992h3eneWbwoSu/i/N+vgbzJA=; b=J/Oqz7HqPTYD9dj4UuHz3
	VNYghGTPAP88a3QAxRuqc/65//6T3/oPvBE5b2vHf8DRwVEENqCk56F78imxETOu
	P0NdUQqAFWc/0GfRajCVdHD+LSI/3xYKIQETg8dQZvYvz4JjuD4N1B5aPHRDKtLH
	jkRo4Q7BF4BWwRagLKEqfu5aES5oTORGnGUSmcoVRCLdricfKR8ZQg3vYdDm9hPJ
	SBz94e92Y+GC+wSU3+T/Ict2wAK69YcVAm6m0Psp5ZEVmJdYNc4/61ATg4x5QF/o
	9hZLVNaaevae9mx0Ys9/3c7u7iW/ZxYsMKC2kbnrVKTRleQfN7y17D3yguWayYsm
	Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h87dgn5a8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:12:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVZlBZ+Sg60Gctr4ylpPaG7fj29yDiuhivaqp4LKZtgm2ItUL0MvF+8QAHHizwu07xrdEtHvc1nGz7sMxhcyuVA0l33SFBL5vHknLKBYETXzf1KlxWv7NBeV8Z5x4a02B0sOU8FkUdvMcoycDgiTdL3w9ZuVolTQR58VJBd9Ws6D8EoR3tS5mweoi8taOqSukhDBu8oQgGw/vZvqRNfNnANCkLJXjgiJtpjolU1WfaNtEkfBKmGIaFSIb1SJ5POjPO97RyDZVwco4ykOboW1fBxCxfYOTFRTH2uCubDfLuJWuTrgZi7bL+ghReplzdIYt+0oxOGI51gwEXxIzq3c3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYejRjcAf7sE4/zNCC992h3eneWbwoSu/i/N+vgbzJA=;
 b=eFubkgBHcyGHqADRI7O6PE2bJJwtU1pZRZkuchpsHSj1NMxn3K93/O5yrGfLoXIOxH+AsWMkUBvWC73s6mUe2wmMtF64H67D01phz5ZA2eYkEOtTDfxhCefClRahGGkNGOnSLBVa3yNjdMFKHN5HdsHUpaO3LiMc08JKBfKvBjxsGQiwiOWnN01Q4sCRRj5keEAdLoZW87MsK4D0gAZR1kbFjP4rahoRckiqEt66c3SrkvC6jvNZkPBeZVEJmr5ixAd7VXILl5pb31j6ouL5xez8bBKlFuYWAIx+Hu1Mv0DRVIyoBjg9UFatvXrL3FsqQfEjajwSm1Theq9TZYACtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5194.namprd03.prod.outlook.com (2603:10b6:5:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 12 Oct
 2026 10:12:31 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 10:12:31 +0000
Date: Mon, 12 Oct 2026 11:13:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Fei Xie <fei.xie@horizon.auto>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND
 and NOR
Message-ID: <asyi_TZWMFTL1xSq@nsa>
References: <20260928055005.3987624-1-fei.xie@horizon.auto>
 <arp-E1MDFLfV1ASq@nsa>
 <87bj99lef4.fsf@bootlin.com>
 <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
 <asXPFxphyuGXxsfH@xhacker>
 <dde19ed4315a58bb7f109486a05277f40c2a2842.camel@gmail.com>
 <asegz79z-SNqphVs@xhacker>
 <asht8pnVDV80zNXw@xhacker>
 <c747a7e7b0c0ed8157fed2443a40b9ef896d1b1d.camel@gmail.com>
 <asl5H2kE2OR0UCZe@xhacker>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asl5H2kE2OR0UCZe@xhacker>
X-ClientProxiedBy: MR1P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d684c1-285b-4de1-c7ec-08df284953b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|10067099003|5023799004|4143699003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	udVVLqLNofqz24s5aS1EvaaXNXI9oPI1kw6vaErGujHNRlgAXjpxh6Owt1YUZWs4oEFqsScHBylRI+hdsDhZAiy4afR2w2WjS5Yc2D3jFaTO4yIxg+fd1bqEz21xHT1BTYnu/4Qtz6iiSahO69O1MrZdn3/cIIIDoVZWY0XzFAHqymYwqa1glKiQdJNeIE4T/IsHzkVNN+Hgi5Zn8aYOvK6cHIvFmnt/GA7Ig9Z9JcRVZAysU+MvkiWx0q0zNb+QlEJTTkIzOQTZmjS8nr5iD8DLkDqZOZTfqycOLIr7RveQLJZQiOrdV3pE+MRJ5oBhRM/ZYYTkqas2fbIByUU3GJG575omqrjyq6wzAb2lFHTYKUknVCzL53jqpmYH2IoUPlf2WQq7rpBxwEfZdIUFjhdOpgutu7b8BYbZGtLkR+IdyZ5cZJ/HIiUpC5z9HNgCCK5uW0z1hFzUnoEmmeAF7kHv7YPY7SUHMqlLq/yPFd79R+4AyyuAgHPinr84Ma8OBcL4ci3/Tchm2IpXCV6EO2OA/eyAzFfTVmazsj8whltAh9daBg5+Y8e4ogLRjCmmb0MJZkD4jy1ZWCGuNKzQcPuDWkEeYrJ+mB8dOovR+azPIvL9p+Tso30XJqayZi2mmpJYYVDC+lqNdzKAJ5inVfxVg0+bi/7PsIMCi1sdJmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhCaGMrMllWYWNSamZoeTVXTUVWN0pEdXVNYVdXWS9PeDE3dzhrNWtvZHI5?=
 =?utf-8?B?RE5sSm1FRUM3NE5PUm05bWVuZ2dCcUY5T3pxcm10bnhpVis0N3Z1ZEs4NGJX?=
 =?utf-8?B?RGI5Kzg4TVBRZjhURE5wZVRHS0FnbzUvdkthbjBZTTFrYnNrMjJwQm9RdnRy?=
 =?utf-8?B?eW5WTloxOHUxY1FhaVZ5cGlFdEFQL2VrUGo1bmVSYmxob0drbEFuTWFGdmZE?=
 =?utf-8?B?ZXdYZTU2elRzWElVdXptdjJVQVFmT1RmbkRXMEFvcGQzZkIxQ1dnL3NDeDVC?=
 =?utf-8?B?QjEvL3hMZlpMRDVzTUt6dDFaUlhCYmFFdm5xYm1tN2VndElJNWRNbW1OZFBo?=
 =?utf-8?B?bVJ6S0toNVhzbU43VHdkWFpYQWEzcWFnYWdkYUFnczFGaTZCRFk2TWc0MmMx?=
 =?utf-8?B?WXI5UGVJejlQbDlUTHpMTXZOaVd0MUF5ZGdCcndEa0k0Y1I3emtJNTVDOXNM?=
 =?utf-8?B?eFo0aXVsVzRtRGRLd3hQc0VYWEdMMWVuUytUZFRJUEYvVjloRnlUdG1UQSsz?=
 =?utf-8?B?OEdIMkFZTTJrc2t6YkFpaUo2aDFDTHh2MGdBQ1p6K3hBVkJPUkg3N2ZVb2Yv?=
 =?utf-8?B?RndCQlBqR1JXZkk1dmlRSXBiaDdtQmxkZzZBWE5VbzdFSnhmaERPZER0cEVQ?=
 =?utf-8?B?MDNtK2R5VElIcmNBZ1V1Yis1UU9kbVRQRURhSGNvZ0JQamk0SDZpY1phUUlt?=
 =?utf-8?B?a011Mm1zZ2laelRDTForT09Vdy9KZzlrRmFNMmZRWm1MV2dYdUxMUUN2dXNm?=
 =?utf-8?B?MVZldVo0Rm0rQVFjMS9aT3E0QnovcEtvQmpmMFVXbW5hSUpQTVo3Uk8rNExj?=
 =?utf-8?B?K0VISm5xOGFwUTRjb0p5VFhMeFVxS0VOeDhTZWowZ1c3K3QrZVJkTzNyakpq?=
 =?utf-8?B?VGpQV2IvVHRvK0wwN2c1UVBLL0hLL3lXYld1ckhrUEhGY0tNbHF0TlA5WXUr?=
 =?utf-8?B?YWpEV3FDZDMvbzVrd2dkNXpmcHFtcDU1aUdoQkpLdXJjdnBLTXJSTk5IQUtZ?=
 =?utf-8?B?QkNPWFUyR2ZZSzhxVHFuSXVobWsrUlN5OWhwWFY3YjJvcXdWYVc2cHRBNEta?=
 =?utf-8?B?TFdpOTZJd0F4cXZaVllBUkE3VThBdW1MQVBSTTZxaWRmbEJFSW9YYlZ6NmZN?=
 =?utf-8?B?YVE3SmxVVFdIaFJVUUdHS3JFald1aXFLaHk5SklDQ01pTU1NS05uRTVkNndW?=
 =?utf-8?B?WnVBaVh5N25hNXBSQ3gyTHg4OEw0Y296eElNWGtiSlJqZUh3VmJiYjl1MzJE?=
 =?utf-8?B?ZXlSYW9qTW5xbVMwSzYrMm90dDdXU1BySE9DV0UvUWhrMHhabUdSOXorVXlW?=
 =?utf-8?B?RUlxM2hkQVI4cWZaWGVBekNpMTM1dEFTVjBSU0YyU0p2ZWEzYm9WbmZrckRR?=
 =?utf-8?B?SFU3RXV1YVpnV0d6c1NiNHFxN1NMSnRSMTdhK2tFMnd1NXUvTW9ab3hjQmFB?=
 =?utf-8?B?MTlpQXViZ29jSXFxU1kzOENTYlRFOFpTeU1NZGs3L1pZMHpOMThwWFpyNW04?=
 =?utf-8?B?K3FYSmZpMnZlVmMwSEpwcWRDVHAxemJTZnpYTWltT1RIZnVjcEN5aHBFV3pp?=
 =?utf-8?B?bmo3T3IydUplblJ6dFFVd3VCY1diN1RDQjdIL1JwRDJaTTVoZGxMRVg4eEx0?=
 =?utf-8?B?bVBSUnNoa3J4dHFDZHVmSnJkZzFZT3JTUXNaY2F1SjJiR1RPczJ1RXUrMlQ3?=
 =?utf-8?B?b0sxOHBES1loRmlxUWVjZVRqOENqUTVtVWhVRjc0UDFmdkhPVlFSV3VTUEpL?=
 =?utf-8?B?YTJieVJQN2FTSGR2ZjNwSnB1WWZ0ekdtdG1sRUEra3hSd0FIa0ZENGdvV1VE?=
 =?utf-8?B?aS9iUFVDM2FoT0dQSkdMSDducFFadW95VUc3SWlqN3RMRDhQNDlDS0RVT0Vu?=
 =?utf-8?B?Y0d2M0c0ZWhHUStHa3luUlc3LzVPUEpHcW9PRUNPcFA1SDNZUUxtdnFRUWhW?=
 =?utf-8?B?R3VRQzY1SDRiOWdlWGJSSVpyU1NHNlhrdG9GQm8zWXVOTmhTR3hNaDFEcEtl?=
 =?utf-8?B?V3hNdzE5eVBkaFJjTkRRTEVVV3F4dTFROFlLV04zY3J6ZXEzcW0wUHBiZGhs?=
 =?utf-8?B?UHR1NkZYdDQwRGU4ZkJjRDUwNTMzVlZEWmZhai9pNURjbStWbVFra0hOUGRn?=
 =?utf-8?B?Vkc0RlZmamJnMFVBZk1BUFJwdFkxbkNmQlJtZURWY2ltTWlEQ0pLbzNhanpu?=
 =?utf-8?B?ZWx4TlptTUFXa1pNZUhzZVJvVm8wVk5NeTQwZzN0MWxOWFQ0THRZdVdrSVBE?=
 =?utf-8?B?NXNXZldLU1dIUVcyQk4xOGZZSHdaNnRFOEdTTUdORzBFd0lkY1YvZ1dQaERs?=
 =?utf-8?B?cS80TnIwUVZkYVJzM05yQzBjTURtVHF1a00rUEdGc3FXa2I5eitwdz09?=
X-Exchange-RoutingPolicyChecked:
	faG5sTnikQGSL+42FobRYnIDk8Mzyu4C0ks/it+tyEzRrzjdcN9UPbe90pyERupqnMnPADha9DjymtU81D5+6sx/cGeXQRKKcgJboHHvaYepemKlKkybmAPWVVpXYMHPGWTTpD+w1zDlFCbQ5nqTrAcRVOGCgHwXfUNm4UYVAxCduNxa7Y33N0SfoUAJ7uFisaD6tzz9qanLkFxykdFtGKor3cpS6YfE4OEMIvYgX79xk2a0WYIZgjwe+kfCKYoZ/PZSaV2rbN9PAJpjrMOaaM21e3V89sFKYMrDsPbfEPxX8cubste4sbOwVVGgbe7OainjgtTJdTJ6s2VPsAY68g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d684c1-285b-4de1-c7ec-08df284953b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:12:31.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfP9kabWA4/f6Jr6Gm/2ePDygObjeuYskdl0dTcwca//lHoFOglFblWVHouEGYnZxgwwFkRm8TwCcLE7RGK+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXxoIvWhpNgOit
 83QBo4bcbOp6OhoVHTLZ/V01PAVmv00H6cX2PZ/hiJziwgCYKMxGGv64cgdgop4Gs3gq0XzZf9X
 7UaQZa/I1q6pgfl+M+ZAZecsydPHf1/i1Xlcr+TaRMPQfYOiDJECGgKURK7oKPbXnNPp4kkyrIB
 NCUS/RSTXDtDID9ztmPamkLcc1D0nC7YAx/X0HclA7d3qkzX7+cyBXGH/DLv8J95CqieV0ClcXG
 WipEPnE9q0hcTgjjvYTjltMm0LyvdHoU+IAALm1q3ZTZkIu2wXcklf9/L4EENNXutUAanEFeLaL
 o8vlD6A0XVYt4QweO6xTrxY6RpccFUvxR4mKQU0efVGw8bgFhM4ZQ8TThgcRHuMtba+R5y5MmES
 ahuTj8QrEt7/zOzZVVv2WBwWNJuMjpo97inRCEvbO2tQI5dgoj+MpQbOBB3Op0Uu5fHChRkcQzY
 aLUXkJB0z3LkNtDi6Jg==
X-Proofpoint-ORIG-GUID: FFjKZuOnvFeqnnp5pxFe6SoIvo2n8TPI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXyxmycGZWDM2G
 +fXWkjZMsEUz0jTpxLNhQZ4VAvydEbhAqjVP5NYHBbVlHenMj/xrnREsRLj94mZbPm3tB0zfJAE
 8upcXHvnOouQYowhWMDrwYQdrcuRY3h0Pmrapo46MqWr12naYl+T
X-Proofpoint-GUID: FFjKZuOnvFeqnnp5pxFe6SoIvo2n8TPI
X-Authority-Analysis: v=2.4 cv=Ea5d0/mC c=1 sm=1 tr=0 ts=6accb291 cx=c_pps
 a=e/sPstj0vE6DIEdYTBOJlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=Yiv1tTK3WQUpY4BrbpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120040

On Sat, Oct 10, 2026 at 07:30:39AM +0800, Jisheng Zhang wrote:
> On Fri, Oct 09, 2026 at 07:17:35AM +0100, Nuno Sá wrote:
> > On Fri, 2026-10-09 at 12:30 +0800, Jisheng Zhang wrote:
> > > On Thu, Oct 08, 2026 at 09:55:27PM +0800, Jisheng Zhang wrote:
> > > > On Wed, Oct 07, 2026 at 07:12:57AM +0100, Nuno Sá wrote:
> > > > > On Wed, 2026-10-07 at 12:48 +0800, Jisheng Zhang wrote:
> > > > > > On Tue, Oct 06, 2026 at 07:50:44AM +0100, Nuno Sá wrote:
> > > > > > > On Sun, 2026-10-04 at 16:37 +0200, Miquel Raynal wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > On 28/09/2026 at 16:02:27 +01, Nuno Sá <nuno.sa@analog.com> wrote:
> > > > > > > > 
> > > > > > > > > On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
> > > > > > > > > 
> > > > > > > > > Hi Fei,
> > > > > > > > > 
> > > > > > > > > > Hi Nuno, Miquel,
> > > > > > > > > > 
> > > > > > > > > > Thanks for asking for benchmarks. I backported the 32/64-bit STIG
> > > > > > > > > > SDMA
> > > > > > > > > > transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
> > > > > > > > > > kernel, and compared that STIG path against the ACMD SPI NAND path
> > > > > > > > > > from
> > > > > > > > > > this RFC. I have not applied Nuno's separate ACMD read
> > > > > > > > > > implementation;
> > > > > > > > > > the figures below are for the implementation in this RFC.
> > > > > > > > > > 
> > > > > > > > > > The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB
> > > > > > > > > > eraseblocks)
> > > > > > > > > > on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both
> > > > > > > > > > paths
> > > > > > > > > > used the same board PHY configuration. STIG needed one additional
> > > > > > > > > > dummy
> > > > > > > > > > clock for the EBh read-cache command on this board to return correct
> > > > > > > > > > data at 80 MHz. This is a local test adjustment, not part of the
> > > > > > > > > > posted
> > > > > > > > > > RFC or [1]; I excluded the incorrect STIG reads from the comparison.
> > > > > > > > > > 
> > > > > > > > > > I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
> > > > > > > > > > numbers below are the arithmetic means, in KiB/s:
> > > > > > > > > > 
> > > > > > > > > >                                STIG      ACMD PIO
> > > > > > > > > >   eraseblock write speed      3685          3555
> > > > > > > > > >   eraseblock read speed      12468         14222
> > > > > > > > > >   page write speed            3671          3510
> > > > > > > > > >   page read speed            11931         13716
> > > > > > > > > >   erase speed                40000         37647
> > > > > > > > > 
> > > > > > > > > So this goes along with my expectations. I think we can all agree that
> > > > > > > > > PROGRAM + ERASE is not worth the trouble? We even loose performance...
> > > > > > > > 
> > > > > > > > Yeah.
> > > > > > > > 
> > > > > > > > > > For a separate sequential-read test, I erased and programmed the
> > > > > > > > > > first
> > > > > > > > > > 64 MiB with known random data, then checked that each mode read back
> > > > > > > > > > the complete area byte-for-byte. Both SHA-256 hashes matched the
> > > > > > > > > > source;
> > > > > > > > > > the reported ECC failure counts were zero. I then ran:
> > > > > > > > > 
> > > > > > > > > What do you mean by sequential read? Does your flash supports
> > > > > > > > > continuous
> > > > > > > > > rads (or buffered mode I think). If so, I would expect much better
> > > > > > > > > number for the ACMD case. But that can be the issue of having both the
> > > > > > > > > controller and the chip trying to walk pages.
> > > > > > > > 
> > > > > > > > Sequential, continuous and buffered should mean the same in the NAND
> > > > > > > > context.
> > > > > > > > 
> > > > > > > > > >   /var/busybox/time -f 'real=%e user=%U sys=%S cpu=%P' \
> > > > > > > > > >     dd if=/dev/mtd18 of=/dev/null bs=1M count=64
> > > > > > > > > > 
> > > > > > > > > >                           STIG              ACMD PIO
> > > > > > > > > >   elapsed (three runs)    5.30/5.28/5.26 s  4.66/4.65/4.65 s
> > > > > > > > > >   mean throughput         12.12 MiB/s       13.75 MiB/s
> > > > > > > > > >   mean system time        3.55 s            1.06 s
> > > > > > > > > >   process CPU usage       67%               22%
> > > > > > > > > > 
> > > > > > > > > > On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
> > > > > > > > > > and reduces the reading process's CPU usage by 45 percentage points.
> > > > > > > > > > The flash_speed results show a similar gain for reads, including
> > > > > > > > > > single-page reads.
> > > > > > > > 
> > > > > > > > FYI, if you pull a recent version of mtd-utils, flash_speed can
> > > > > > > > benchmark continuous read improvements with the -C option.
> > > > > > > > 
> > > > > > > > > > I do not see a program or erase throughput benefit:
> > > > > > > > > > ACMD is slightly slower for both in this setup. These are SPI NAND
> > > > > > > > > > results only; I have not benchmarked the NOR path on this board.
> > > > > > > > > 
> > > > > > > > > So CPU results are the bing thing here. I guess we need to decide if
> > > > > > > > > it's worth the amount of complexity it requires for the whole thing to
> > > > > > > > > work. As I mentioned, if the chip has continuous mode and we try to
> > > > > > > > > read anything bigger than page size we should let the nand chip to
> > > > > > > > > walk the pages and that means the behavior we have today (IMHO of
> > > > > > > > > course):
> > > > > > > > > 
> > > > > > > > > 0x13 (STIG) + wait + read from cache (ACMD)
> > > > > > > > > 
> > > > > > > > > If we're only reading a single page then the logic in this series would
> > > > > > > > > payoff (slight performance gain + significant drop in cpu load). One
> > > > > > > > > simple
> > > > > > > > > way for doing this as a starting point would be:
> > > > > > > > > 
> > > > > > > > > * Nand has cont mode -> xspi controller does nothing special
> > > > > > > > > * Nand has no cont mode -> Aggregate the xfers together.
> > > > > > > > 
> > > > > > > > I'm fine with static decisions like that, but my understanding of the
> > > > > > > > above is that ACMD mode is useful for all reads. so I don't get why you
> > > > > > > > would no use it for all. Maybe because it would break continuous reads?
> > > > > > > > (sorry I lost a bit of the context already).
> > > > > > > 
> > > > > > > Exactly. In ACMD, is also capable of "walking pages" for reads bigger than
> > > > > > > page
> > > > > > > size
> > > > > > > (hence the need to know the flash geometry) and IIRC, that does not really
> > > > > > > work
> > > > > > > well
> > > > > > > when the flash is also doing it.
> > > > > > > 
> > > > > > > > 
> > > > > > > > For writes and erases however, it seems like we could keep the STIG path.
> > > > > > > > 
> > > > > > > > > Doing something dynamic would be much more complex I guess. With the
> > > > > > > > > above reasoning, having some mem_info() kind of spi_mem callback to
> > > > > > > > > tell
> > > > > > > > > us things like geometry, continuous mode support, etc would be enough
> > > > > > > > > to
> > > > > > > > > handle the above I think. The reasoning is that reading a nand page is
> > > > > > > > > always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
> > > > > > > > > spinand_read_from_cache_op() so we could probably aggregate everything
> > > > > > > > > in the last call on the controller side without complicating the nand
> > > > > > > > > core
> > > > > > > > > logic.
> > > > > > > > 
> > > > > > > > In general, drivers making assumptions has been a disaster in the raw
> > > > > > > > NAND world. This was the main reason for the ->exec_op() introduction
> > > > > > > > there: giving the whole operation to the controller so it can decide
> > > > > > > > what to do without guessing. But we thinking at the operation boundary,
> > > > > > > > not at the "set of operations" level. Since ->exec_op() in the SPI NAND
> > > > > > > > subsystem has been written following the same philosophy, I fear we're
> > > > > > > > going to try make rounds fit inside squares. One of the possible
> > > > > > > 
> > > > > > > Fair enough! Agreed
> > > > > > > 
> > > > > > > > approach would be to mimic what we've done for the some limited
> > > > > > > > controllers: pack everything in one single op (see the _monolithic
> > > > > > > > suffix in drivers/mtd/nand/raw/). That's just one idea.
> > > > > > > > 
> > > > > > > 
> > > > > > > I can take a look mostly for curiosity as my intention is not to "steal"
> > > > > > > this
> > > > > > > work
> > > > > > > from Fei. If everyone agrees (specially Fei), what I can do is to send my
> > > > > > > simpler
> > > > > > > patches that just support ACMD (without any special distinction between
> > > > > > > Nand and
> > > > > > > Nor)
> > > > > > > For Nands, I have a mix of STIG and ACMD, where big gains come from Nands
> > > > > > > with
> > > > > > > cont
> > > > > > > mode.
> > > > > > > 
> > > > > > > Then we can build on top of it in order to improve Nand support (mostly on
> > > > > > > CPU
> > > > > > > load).
> > > > > > 
> > > > > > I'm also interested in this driver's performance. A bit off the subject
> > > > > > but related question: Usually, the Soc may connect the xspi to dma
> > > > > > engine, I'm curious what would be the benefit of adding dma engine
> > > > > > support instead of ACMD? Is dma engine support simpler and
> > > > > > is the gain(performance + cpu load) more?
> > > > > > 
> > > > > 
> > > > > I'm not familiar with that approach tbh. But I would assume performance to be
> > > > > pretty
> > > > > much similar to what I have given that ACMD uses the IP internal DMA engine.
> > > > > But not
> > > > > using ACMD means not having the cpu gains at least for the smaller transfers as
> > > > > we
> > > > > would not be able to aggregate transfers. FWIW, given that you might not have
> > > > > looked
> > > > 
> > > > Hmm, my platforms connect two dmaengine channels to the xspi controller,
> > > > but I haven't added the dma-engine support to the driver yet. If the
> > > > ACMD is enough, why HW connects dma-engine then? Just curious, there
> > > > must be performance gain I guess. But I'm not sure and I don't have
> > > > performance numbers.
> > > 
> > 
> > SO the IP has an internal DMA engine capable of acting as controller and driving the
> > bus AFAIU. So we do not really need any external dma_chan. Just need to use the dma
> > mapping API,
> > 
> > > Aha, my platforms don't enable the ACMD support, instead, connect the
> > > xspi with dmac.
> > > 
> > > So when upstreaming ACMD support, the driver needs to detect the ACMD
> > > support either dynamically or via. DT. Unfortunately, I didn't find
> > > any register can export the ACMD availability. DT is the only way?
> > > Or issue a simple ACMD and check SDMA error?
> > 
> > I'm really not sure on your usecase. ACMD starts to payoff really when the transfers
> > start to be big enough. For example for my usecase, Im only using ACMD for reads
> > bigger than > 2KiB. That number is fixed but I suspect it's not that simple given
> > that It might depend on number of lanes and clock speeds.
> > 
> > If I'm not missing anything, the easiest way to handle things would be to detect
> > dma_chan from DT and if available use it instead of ACMD.
> 
> The ACMD needs an external SRAM, dmac needs an external dmac controller.
> So Below case is also valid: no dmac,ie no dma-chan from DT, and no ACMD
> support either. Especially, lowend SoCs would choose this combination.
> 
> It seems something like "cdns,acmd" bool property is expected, but
> we need to ask for DT maintainer's suggestion.

Hmm in my implementation, not really sure the external SRAM is needed.
Might be wrong, but seems to be only needed for command/descriptor
buffering (which indeed is needed for this patch). Nevertheless, the axi
requester port needs to be connected to be able to act as DMA controller
on the bus (or else your usecase).

So, it seems to me that DT is a sensible choice as ACMD does depend on
how the IP is integrated in SoC. For example, on the platform I'm
working on (sc846) the DMA port is connected on the A55 side but not
for the SHARC cores.

So to keep it simple a "cdns,acmd" would say that we can use this mode.
Then, having dma_chan on DT would decide on whether we use external or
or internal DMA.

> But if issuing simple, no-side-effect ACMD then check SDMA error
> during probe also works, then it's better than DT property IMHO.

All of what we've discussed seems fit a DT property so I wonder if the
added handling/complexity is worth it.

- Nuno Sá

