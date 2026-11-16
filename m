Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794839189;
	b=Ms13IrcI8bzQ+xjvBxvg1z35BvRkrikVaBL4H/NN5ZET+1y/hhNnzBMzOYgnJzEzldIl
	 52I9rR7TBZEpUL2DZGM1hGO3OSJLvxpI8/Q0fRpqT7O6q0M/9RyOGG91KAPGGdGFGCj5v
	 BkIPMjhDS/p0rEuFs5vBiRwP8I1DapQM5sRfIiXykKsmIkhqcQKpDHvmmPUOhQVcVBRX6
	 gykkwMRajHSbk0gu+LFxht8NyRxLe0YgyifWK7GHlP8ch9Qwkm6YhywHDXdeYVColSyzw
	 bbP5yjWOXNOLoKhaS4hJBkDNFL122sfThzX/CyjXe05pfLHH3b7LUVGIZeRLGHJoC3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839189;
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WJ+5hKazhHQAkZk7VG4SMsooI8kg0LZlEUi1zqCeV9E=;
	b=3wZ4knE8NlPS4Hpdi2L2Tm2lN0WPAcBY8r8M51pDJ7iKMuUfLBk6IIRIWQjkWEETbp9r
	 iBUKKnejvz+sx1dTmQI9f4aBiCL8uKK3sd0NNy+2rGRUD0+Hgr17cwUaFFQ5tMRhwdM+B
	 7u/Oeh+aB0HH+cZ7eORnlQsYqOwVFTaW2WzH6yYW4VaVj7gMhAIWDwdvDp7G4B0kiG4cT
	 3KBF//VhCcSHKF11NNc9jFbTFsb6MKym7lt/KLX0MEzZB+hZ5iOwVQXPvRMel2zHF9Tlm
	 ZquJ6Uw5OBlfP5Q5qZtHQXKZQcgVj3jHPKYSZlNFQ7yG1/uHo/uAjSqEMoNP5Zr56HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=HszPkyCh;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GTvqLh+c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37C606A31C;
	Mon, 16 Nov 2026 14:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A37C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=HszPkyCh;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GTvqLh+c
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC1Qnd1129001;
	Mon, 16 Nov 2026 09:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=WJ+5hKazhHQAkZk7VG4SMsooI8kg0LZlEUi1zqCeV9E=; b=HszPkyC
	hk4ND8Z9XCTDtedYZsuPIDC223dUJXhP0usO2b/dqKWOq4tS1PvmyJoT6pF2Ak0X
	3AkY3Y67rz52AmuhuJW2WW2T1ElPYJyatcKACT/qsx6MD4m7LujO1/Uo8rRiusGA
	w4ey8K6MbOoSALCu01mke6/uP6ITRih8xt00UuEq+JOxk4R1ahSG7wV8PY78+iOt
	5xIY5hDZKMETvFkO0EEHG2/JM5g7tRDDppp48f6700a8HdNHgxhK+BF6swPHkJGR
	Zj/+DYlRcXL7ExwIY2h4QG4TzRGaIE0kg3DcqPyUovOgXRpvG+DmNvts+SAobrPH
	YnYEOnoF2cRMrqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WJ+5h
	KazhHQAkZk7VG4SMsooI8kg0LZlEUi1zqCeV9E=; b=GTvqLh+cDKJHE8835qIGI
	sHZKPc6e4gyyHJR36uBBZMPEefiv9NOA3+DyH45z5oCkWDHXx1syLFeMv3DNL6id
	2M1VPtXAwYEFregMCwa9GZEizXEfZojiL8r+ICiGHpScbbLYYwTfhJuP9WewLGAi
	YDUtGfGYpUFlUOMmj6vet9+lDEA7iHdWY9hdOVB6M2fvv0wqYm/k007dqwrgG0Vr
	lsNMTjOWJteE72DocrGJAzW8Kok9SYK0IM0VqpQxVHPP85AtDU/YuJ5nwwO3EP49
	5oDiLu7jmefYRVhnNR7kHfMzJBv5utWvy268UGPTVhyvQWvoOTbWTDZmMH8npJCa
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hy9umengj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:26:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVm8MiTO6lFPoErhGlOyx9OelMbEdMSHzSTgJbX1zP8hnps9O8JzaN7H2msIdLhNA5Fx5oL7VQ33zkOBWjyRAgZPIPoZ3OmMb4TCNPNGzdjkpOojjzi8umyL8oeLZIouFSMu85ETwhemPIJXmxzK2WJgT0P3mMHW0HV5CfL7VMIJGxyFh0dMEzSEvzUNorNuUuh3609sfF8sMwD/Ca29D9Q37SkWdcgdr9YRrii4dOW7FkHWTfi9YiSQ0WN797yqvEpp108XARo4Xm7LkNp3TBDag5ISqfrCCQU5w3MDbv6HHPDO8Yqk7XjENLXvM/0ncInPxQQqbGUKDXifXXNWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ+5hKazhHQAkZk7VG4SMsooI8kg0LZlEUi1zqCeV9E=;
 b=psajKMYLfmZsLtfSPUTgYBmOU5ufzzxtA3RaAq+8qym8XytMk3Sb4hZRG6t6/XfuZOMyzFS2hY85z8PB7S2nB9DA49CZZTzb8rrtmP6lj22SzQhmVFnVPlvT//f7Q+GYH001fWe7Hrbrd6yAMloTb3UM4gIxZYmHb1nj8ApFd1LsPIUAKxVHocraY4wHtLU+icFLdNX1ln6JDHm0tsxL3NTD1tUMMWiM19IElfym1U2M4En8ecjSC6pLA/D9kDeilrL5nj3w36jYhG/rOdETbO8u8yechOIGLderpQG/A8qYQ/z+gHo+qRFFzFdIjUw1RLT+fUQlGqJ38m1BbYpz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BLAPR03MB5523.namprd03.prod.outlook.com (2603:10b6:208:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:25:08 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:25:07 +0000
Date: Mon, 16 Nov 2026 14:26:33 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add DMA support
Message-ID: <avsRgCbjzFVdS9GI@nsa>
References: <20261107072044.17574-1-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261107072044.17574-1-jszhang@kernel.org>
X-ClientProxiedBy: ZR0P278CA0111.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BLAPR03MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: b33725fb-f9da-4a46-b978-08df43ed698f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|261026130827099003|261026135527099003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261021135927099003|261021130227099003|261021133027099003|261022113327099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261009221227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SXYSNbce7Rf3Lq9clRhy8IjF/Htt0VenOhqjHemLzPrZHikZR++PeQIgopAD/XTkj5iw760L6YGjZlpHgb6jGKvTgRCLgnaq/lK6bf/IJZe/5h9qOVi0QBudj+r708TgTp5LeX0VsmLumJqTzztd6C3i3354iVUmAJ6geGa+iC7Iq8AkUJtPESGGG+CZYCBW8slwx3WddnY1o1P3A2oTUhNITXmemkM30rQEbBRFmeqI2jTz120p//rLNughirPrqnWmrvOOHWuDCXWn3iyFdO2gD0BpTIU0YWExS1FHQ65vCnoznX4vivjhgAkPXCxPp8PkPmMNY0oZeHVYaWF8HzLsbjsjWzclUXr3f6T9GseYmUrLsCDvNJR5WjLsVbmxAc4E2mXdDtk2hwM0jB1n+1kBG0IFluNLCC2EyTFbfGdMrQewWr+3+GBPMwaKlXhPmeUIypY/CmmnQnfesAoDXoSscMXNtXfIcLmosva34adbldNEMu12xOkA0ABYeZEMkYrgY7LPEuWD8xdkINqXCEFq/dbMLKctINVieL1pKjy/ofmed0f5hkQXg3Odt3Tq8kfZ8RAjbUL9nCJEG+VpxjtdOyAedOlE9wwM0UBw5el7uiKMPQarhBVnjdC64tFPvyq4904O2M8VdJkWbDZAC35/MaQzHrppL8vEmMxMq80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(261026130827099003)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261021135927099003)(261021130227099003)(261021133027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5yamJwNDVQVHlZV21iYm9kL0tNODR1eW9wcjZuaFMvZWFCSFcyaGgwVDN3?=
 =?utf-8?B?UTNEZG5KbkI2TmxvR05tdHR0aXZrSG11UW80ZmFscEcveEtvQmRkVlpYYXdL?=
 =?utf-8?B?dXlVdEFlLzVRbUlQS3N2bG5mSzBGSDRVVWE3c1lhc2U3eE5uNWJQS0hJQUw1?=
 =?utf-8?B?Nks0Wmx4S1ZmVDRjZFcwRlRKN3grUE84U2tubkZTcDlNS0FVZVpJN0ZiNi85?=
 =?utf-8?B?T1VYaHp0cFErc3NLMXZXSS9mUSsreitCZllsK1ZYZld2Q0hTUTd4SmMvRzdK?=
 =?utf-8?B?RlUzeTNsRGd0M0JGKytRY0drdE9DUDFmaFp1SEFFRGY2TFR6SmxRUld4YnN1?=
 =?utf-8?B?UkFjUGsyWm9lb0JIRVBtY0N4NnBUS3FSNEVvZXBrRXJXc3VZKzNKOWJ6eVdM?=
 =?utf-8?B?RlNaTWFXdkRjdlViRndrWTFkZzlVemMwbzF1UW1pWUJ6U2VPWTZtcnBQUS92?=
 =?utf-8?B?UTF6UWZQVnpJMk1sQVZMbGpGUGlNN0t2N3FrcnNCWW1pKzcxVUFMbndXNCtl?=
 =?utf-8?B?RHNDY0VxSElSZ2tRSTBmdFRrMi8rWkk3SmJTRWlzRk56cVlUWUtYOE5IZWZ2?=
 =?utf-8?B?NGNFR2RHT1NERmgrUkNXbTM2NE40U09jUjZYcVpWZWtWZGkwMnpzaTZsbmEw?=
 =?utf-8?B?ajlUVGdUWEs5aEo4T1lvdTJVSkx1UVVnMGRzMU9KcElLV3J1eFE4RDJVdzY4?=
 =?utf-8?B?QmZIbkc4Zk5pRWNVTk90eGc5NWRjaWE1U1hNNWN6bkdqeFhKTUVEWTgvWEVq?=
 =?utf-8?B?L05aZUd2RzFVWDNXSjFFLzNMWUFSZDlJVTJFVFVJNDh3TTQ2RDdlMW9oSWYv?=
 =?utf-8?B?TmllMTgvcjUra095M29STk9Sbk1TdGQ1bG93NDJVYUJpWTJ6Sys1ZTQ2YWEy?=
 =?utf-8?B?TzRDbVhWYnNVajZRTlllaFJtaGlPQVlQZjlNaDhTM1locWRwYzVXYmJsNDBV?=
 =?utf-8?B?enJxdDU3MUxLdDE1VjV2WlQ0eUs3SDdjbGI4b2FhN3ZpZm9CNkVIN09TWUt0?=
 =?utf-8?B?WXFLVmRyNEptamJua28vTlMzdVlmWHRadWVucHY5eHBIdm54ODhEMzFJZEp5?=
 =?utf-8?B?Y0FEVExXQXVtYWgveGpVczVqRCtRSFR5TEhGRFFsV2RNbGxjdFowYSszUm4y?=
 =?utf-8?B?WFo2VEQrbzNJVFFjc29RaDhibi92ejhrS1VGcGdRSWR3L2ZIYnVkV0JCZmJp?=
 =?utf-8?B?V0RGMm5jTDM1UGN6aldQSVh1S3g5ZEZMbU9TbEcwdEhKWEdVT2lvZUwzWTd6?=
 =?utf-8?B?Wjk1OFlsMmJKSGlmTWgwZWR6UFVrcVBZU3RXaDBVUFZJTE9yNThUQTUrK1h6?=
 =?utf-8?B?bmN2UHVXVmkyeGVxWWxUU3dIREVPOHAzWlVDSWkwYjlSTlNBRUVud1NjZWpR?=
 =?utf-8?B?QUhqYXd3clZvTHpOYVEybjVmcWdNOHBwaU1Ec3I2T2E0ZEJIQnFFRmdNSTVh?=
 =?utf-8?B?TWFOdWJxRitXK05nRnBHUWk2dWRWcDU3U0RjWUNXYVNIbnRnUGtTY0hvL2hK?=
 =?utf-8?B?NlBydCtMOWRRTjFuUWxqTVFsanZ5aEFueWQyMzZkZ0xGUksxUjVUU3hRZ1ZE?=
 =?utf-8?B?dHhnaHlnblpxem5SWEhGVEYyVUgyLzVkcHpWQng2aHBzRnF4VHZJZXNFQmxH?=
 =?utf-8?B?Y2xYVzA4K1FFeE15dUhNUlZLNU04bVozcEJBQ0ROeXp0RnV6Vm9CQnNZZlgz?=
 =?utf-8?B?NGxQQjRQNm9zeTdpOHAvVDFlYTVJYlVrdllYTWFxam04QnU1V0ZMMVJnTGQz?=
 =?utf-8?B?QXJ4U3JBV3ZNOG9STVdrV016NkJOL3hLc29iZWJNUDJPbENtRVFIcm9VNC9J?=
 =?utf-8?B?WmtLNjZ6NHlRVjE5QUwvL1NsNk4zYmhvd3dPVEZRZFlaR3RidEFIdXBVbS9m?=
 =?utf-8?B?aGpjQlEzclY1NWh2WEhibGRTYjdFS1BoV1UwUFdyOXdLK0FwQjF1RERISHVB?=
 =?utf-8?B?N1Z6cHE1aWhFQWhOUGVDR3Q3K2IyblpFczVjakJlTjZXNlYyQithRENzUHhq?=
 =?utf-8?B?dDNQdTRCbzZSSnkyM0NnSlVDdkJwb25jSWc1MlRJcTVVZ0FqSXpzdk5HNE1Y?=
 =?utf-8?B?YXRtUDZ5N3ZsUjZncnFPRGhPNkNjS1VEY3o0a2J4NmpuNjR6V0FBTW4yUjNs?=
 =?utf-8?B?LytEZUU0NTFNcDlFd3djYXhjRzRWNWhzQ3ZzSWNwcUxodk9mN0xBNCtpYjVD?=
 =?utf-8?B?c1FScE1aWHk3UXdEb0I1KzROaGY4a0dXbG9DNTR3Y0lCbGxEazVZamxORk0r?=
 =?utf-8?B?TlpNQWV5YlFaeHVaNWhGSXJEOTArRThJTUdBSjN4RmIrd2RXakVybXF2Y0JB?=
 =?utf-8?B?NnE3Q20rVzdUVkVsaVFMN3pyaG5zc0lQUzVqM2J2VHEwVjUzNFBGdz09?=
X-Exchange-RoutingPolicyChecked:
	GjbEAZaPqFpXENxAZh/Chw9Z0nkQYDWDVfWvZUAvKQYNB6iO32E5O3lGsi11o0FUDqRXN82XLTi0HV+VSkNDD0ZEKcm8cl1c46uSNK41IHZ2JZnKOW9N4wRlaPOv9EkIFcWbs4xjWKDhvAMMFY+Slzkon3KQwyDnODR8Zw3s7Bud1ra9CDkv6VWSFt/VeHuMfdV4mp668XIKfLmTAaGwAuI2QZ8bYlL9PQRofDqEuxgBt+8HuZUJpMVjGfFXOcwW0LnYJCivbQLJNGWuLlKHmLvCGQipNF4mqMQ9X5+iv1w9tnZrL0KQm161fA7gubysi92p4uUNF94fWrT598prTA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33725fb-f9da-4a46-b978-08df43ed698f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:25:07.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RofnYNJzqqiThzqsqx7W0C0Bvw/DAph/WNA3V7Xjt5ZtPEucP1o5NxYvJTP8hpsIvJQQ8msTXqtrAn8gBKzEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5523
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX1HS1brxAg07r
 xsXgHSgCzp24MfxPbhIR+JfAcLoDVkVE5KnCO+hDJgszqRRr+M/U9MGmD9kBzfh3u9wWqL2rOEE
 lE3xLQJfa/25+740OenKW5g3IhyudpWqBf9vtz/9JBXwViY02FlO
X-Authority-Analysis: v=2.4 cv=DYaCOftW c=1 sm=1 tr=0 ts=6afb1283 cx=c_pps
 a=EBeQSdYSX+IxWZlepev2gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=Z-YWsG-BSzkDv-yCXVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZrDWiuRuD0_H0Cwppla-pT71ksLwmWRG
X-Proofpoint-GUID: ZrDWiuRuD0_H0Cwppla-pT71ksLwmWRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX+Z3iUkB1ufeJ
 nkRjRPYelZN2UCnkHlS8Vu7J4yW3xnsxO/dpHcWF6cu4YDMfKO0Pt+cbwx/h3HXZi2y++ErlBDL
 2sIPrSd1bSdDYI1p5JMkNftrwW7WOO5hJGM7OPwQx78GsViSkWE06V3dEmrogX9KzlLYhYmIh2A
 xItGt2Iu70LNmyC9eFumYGUC/vmTXfdHgFS8nf0rP4SQDEJql1ich1doccuIT+UOqWID0WIiRyW
 Ov6IgurzBBuj8XA7OxtaWzr87AJDtN5/tM9X4a3MbBjWmUytw2QMBfm3F7xowfY2RTKudKSqqUd
 3lA9MqyH4PDzr+zqGDCEMOXH2zDjRGYEyhxSvames5e5yunaW/rS3V9QzsXzghR8Gvrx4TPQ2xF
 8VeUQYy/ZnTr49bX9BvajowjzQ5qgG/JM0/jSESObxqgBmFoAB0oVU572H4b5VrTBxQiDLn+YG0
 E/pvTG5XYMGSrf1Pyww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160057

On Sat, Nov 07, 2026 at 03:20:41PM +0800, Jisheng Zhang wrote:
> This series tries to improve the cadence-xspi cpu usage and potential
> performance if the allocated dmaengine is powerful.
> 
> But no matter the dmaengine performance is powerful or not, the cpu
> usage is reduced a lot.
> 
> For example, on a dual CA55 platform, test with looping the following
> cmd:
> dd if=/dev/mtd0 of=/dev/null bs=8192
> 
> Before the patch:
> cpu usage is nearly 50%, which means one CA55 is full loaded with
> the sdma io copy.
> 
> After the patch:
> cpu usage is between 0 ~ 1%
> 
> patch1 documents the dt-binding
> patch2 adds the memcpy dmaengine support 
> patch3 uses writel_relaxed for cmd regs.
> 
> Jisheng Zhang (3):
>   spi: dt-bindings: cdns,xspi: Add DMA properties
>   spi: cadence-xspi: Support dmaengine for sdma io copy
>   spi: cadence-xspi: Use writel_relaxed() for cmd regs
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml    |  13 ++
>  drivers/spi/spi-cadence-xspi.c                | 149 +++++++++++++++++-
>  2 files changed, 155 insertions(+), 7 deletions(-)
> 
> -- 
> 2.55.0
> 

Hi Jisheng,

I could run some tests on my platform. Here is the dump:

MTD=mtd4 SZ=$((16*1024*1024)) RUNS=5 sh xspi-dma-bench.sh
mtd4: mtd4: 08000000 00020000 "xspi0-nor", testing 16777216 bytes at offset 117440512, 1 cpus
=== STIG + CPU (use_dma=0)

  write                   14.32 s     1.17 MB/s  cpu 100.0% (1.00 of 1 cores)
  write (read back via other path): data OK
  read #1                  0.35 s    47.93 MB/s  cpu 100.0% (1.00 of 1 cores)
  read #2                  0.35 s    47.93 MB/s  cpu 100.0% (1.00 of 1 cores)
  read #3                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
  read #4                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
  read #5                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
  read: data OK
=== STIG + MDMA (use_dma=1)
  write                   14.39 s     1.17 MB/s  cpu 100.0% (1.00 of 1 cores)
  write (read back via other path): data OK
  read #1                  0.37 s    45.34 MB/s  cpu  70.3% (0.70 of 1 cores)
  read #2                  0.37 s    45.34 MB/s  cpu  68.6% (0.69 of 1 cores)
  read #3                  0.37 s    45.34 MB/s  cpu  69.7% (0.70 of 1 cores)
  read #4                  0.36 s    46.60 MB/s  cpu  70.3% (0.70 of 1 cores)
  read #5                  0.36 s    46.60 MB/s  cpu  66.7% (0.67 of 1 cores)
  read: data OK

The script is a LLM based one :). Might have some slop but given the
results are more or less what I expected (the data performance also goes
in line with flash_test), did not bother too much in
checking it in much detail.

So, cpu load is where we have the actual win.

The test ran on an octal spi-nor

- Nuno Sá

