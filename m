Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793375993;
	b=k1EK4qtKyA4fPwsq5DWPzOfVF2ai38RMLcsNpwtdqIf/wU22lYGK261H5Kvzya0ckHgz
	 7NGXD3RjTcgYS8zWGDtGzCMPnj9UdUxH0kPksCogawRwNODZz9o5Inw3knYA1rZHyK/V5
	 hP2E5EKo/a5vzck7M9BbPI+kIOUcQ/8W4MKdCHfhbMWHg1vxSmJ6ddkwhSmmq21RL84Yo
	 f0FEr/M/+p8A2ogSKToUyQEbYi2q7JEGJYDCi1gtgVKHlo0wkArcA5c6nfQkxMMjKJg/Y
	 Zjrv+w+XX6kORk7EcrDJRb12evmmp9+EQV+H64HK2cmFhISy0PNIiUBg/yf08M1GfTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375993;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5d+AblXCvwCJ/kaXv7aOTQuRldp9W5R7NtfRjQXCuZ8=;
	b=McAIZH3fKo6Qd/ZuYlV7lQo9qr4SfWlDwIVxYVVh2VnLJ1Y2g7+7jck3g3XQSALUnKCt
	 REUSGiqPyQg/jzYQsjgux5H/wnuiC2HpNgXL8gpvSu9nMAl/X81XiuycTLuxjiSoSpsZ9
	 LZ9w0mavo8DBRGXOxLNLGVr9szbqy9MeYny4DtF7h6Ml+dz/cCZ8ZODlTSS4kD/LyuEnT
	 6jm0oXMB1kfbTTwosCLAViQHnM9uOmNTD6E0ykBIRUfWjZgnQnftoNrV1OcnPNjRZ5kw2
	 RJi0WUhsP9ygIC4m5oGN2INAUe+32NVzGRZb05/nLZiez7hLKCo+kQnNqd6w9f+JcSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jpDF69Y+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eHN2xXT6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C79606A31C;
	Fri, 30 Oct 2026 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jpDF69Y+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eHN2xXT6
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEQui7133262;
	Fri, 30 Oct 2026 11:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5d+AblXCvwCJ/kaXv7aOTQuRldp9W5R7NtfRjQXCuZ8=; b=jpDF69Y
	+0FxnT/ExyvIicFQnpC53H0z6VG0Q0t8+8O9uwoRm6LGKnPEqhWvZhEsPk4420gL
	3UjLlRQzaLMJhivPxO6slu0VcNgvIyMgyRSVkLk8lOg5zAhHk9iz5zTOVuJ43l4Y
	Vryite0JDd0Yl8ucGTTWSni6s6hA/wUWgIVr3RmymRjMebKPxmZsW0nG9/l1V8wQ
	l8VdvdCkpU4I0IaUWxehCPPl4K0HkDmAsOMJkMCo2SYlX8F8eI/hE43PZdRcYwYM
	Ydh05llPzuLSLkzX2g2Ek7snKhXAMUCOrHbid2zBTKwl/U5ydOjT9euHt6Yvp67k
	ml+EX8nnOpvgbLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5d+Ab
	lXCvwCJ/kaXv7aOTQuRldp9W5R7NtfRjQXCuZ8=; b=eHN2xXT6KluyE1Aq7x/Bf
	D3y7BTB34YLdC9xnYbHZFBPJ10td28gLYzEweb5H9d4AuRpOjqq7Z/rhKG9sY1p1
	+iXsTsLK6TDTc7lPx4NMSvg2wPuzZ6PnS+eCE9P7weWVGd18WpJdXwJ/R6NQakSo
	nQuP6+8wfJs85Vlcp8aHnx6bU43BO8nfefbrI7iEP/Cusj/Vh9rEnPA5c8IhI/0d
	FvX+ZVTANN5Zj8CNUaYH85Hscqwxi2NVydCQzSMTax4xt6HU7f6M6EWFYh8wSLt1
	TCoYplR/51T2IYumwYYgXU9PGakiPfXIPUUg+dC1gB0lzX5RO374KW0q3tq79lEH
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4yrf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 11:59:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcu2Usno0VjuiDo1F3upssFPR4ZQZwmu0hYd3cmM08FG6KQYwZXCdYkBUq/uo3asNLxllk1LEwygXf+WndsAASCgUA0SegCBbygyk0o1fo2qEfEgcv7zXj4KAIpi2En4zY5xYs6K1xmaGNlAZAJIGbWnR3RyLQG5sbEdL+W7Ex8L0TBdGulGQv5fIjSG/YIWqOfTbsIk0UV8AFWfN3XtL++Agjr4IpfyRj3PVAV+mRn5AV734Od9BxdGbKYukb3UZv51APit03rYp1M7CoNpBGuYyhF/XTy73DOTCzoVEuJbOUbGkeRZMLdFf7bbUaW1JYajOmsGE2EAd2NLo57TDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d+AblXCvwCJ/kaXv7aOTQuRldp9W5R7NtfRjQXCuZ8=;
 b=eWLanKSHaayo/CfVvjcLSz1dHSSCEZyHi3T2+7enrGe+8hZeK2qEe1bJkv89rr/Bi3SdJgMzFY/yYhdTawvEcPKNNFwiVt5FK7QKN5y7N+FVUliK/lper1/BerHy81vOA+2G6EusUmknIvCJY3nuEHKXhj1KvVFRIGuGUYI2tP4Lio4g5hB8L+7Dm71yNdm4QcJ3NjIs3XFHh7dh2OPKLteEuKwRt/Rb4G9I5cGqjKjNk2X4vVUANcuNYYi0q4jU2OKxYf+KpJuSjh5Xo96ZkIMsspo/laf5w0dALt+BhFJIjGq0EjcIUutofhInJS6F6QPPDlEWDBQqTq9JGi3T0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH0PR03MB6131.namprd03.prod.outlook.com (2603:10b6:610:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:59:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:59:23 +0000
Date: Fri, 30 Oct 2026 16:00:46 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <auS-tFYUCIvMg-hH@nsa>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
 <179329269255.62540.11497211982924609522.b4-review@b4>
 <auRqTXctbxuuEfLL@nsa>
 <e9d40994-ef33-4f0c-9319-4efaef3d8711@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9d40994-ef33-4f0c-9319-4efaef3d8711@sirena.org.uk>
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH0PR03MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9035596e-75ed-4579-11c5-08df369ec3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261021135927099003|261026121527099003|261026140227099003|10067099003|4143699003|5023799004|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JAyu0Dncoqhn0gVJvUY4kF7wJrYEQGxJT8HsDwr104HUKesmoXc9E2SdbI7vEHEIQyrVMEgjUt5S2ogHBbnAqnu0jP0fN8Stc/s+2iasQvUZtQOSLu3WO3J6sUY5z21uG6StiRLcpmcNOIbpXiXo7VE+cOD98xiNpjVRXlB2hsMB2n/LVHmzaofsgfWCHwGvByCVuUoJ4LU3zjeLvHRW3N0BeBL975fXgXIqAuO7cXJjRXevRh/0aX8Oc18cEfuA3ngZvG2mxPt9YVvnx1rcnGnm4p3REFAP4HAM2BmtJF+i/GJ5skvTz2lVPcB2TAjcfLv93wLmFMtEUPKPAno7gWlGizLXv7MHjEtriG05RbBunYkSCxRX5rqqgIrVBKcfmAq+hcOFfJXLsskjKGfiTrvU74ctX5oxfq5KSYqEv2N2XrDrVY5SDpL5dj1/RF90In7+ihhqb+NnR1Kqijvt1rO8ljC5dVyRK91i4UJs2g0xad+z8Jgq34TATqQzYObUfSlDUIGABarv1jydjJImI1vNo4dKoVhXG/g9GG27hWrZx6ZhsDeVGVKVfo7Tjuanf2dMbn+GgBQYZODQYVZ93ZsBZzUl7IYg6wHyMkjWUPp6LozAY+Y6qUAnfnYOEUmRYMChXtPu/BWtoHxtWA3rSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021135927099003)(261026121527099003)(261026140227099003)(10067099003)(4143699003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTZlakxocmlNWWNXUDhVbWttWjBYZnUyZmVIWlhJN1QxMXo3Mko4RXBIdFRo?=
 =?utf-8?B?TDJOVEo4MHcxVS9IREtsUUdUaExjYk5TVnNBT1RRZmxkQ2Y4SVJocm5Yc1hi?=
 =?utf-8?B?SkQ0cWZ2Mm9pL2JBRWZpbG1CREIvTzUzRldZck1Lalo1UDNaWk1xT00xWG5q?=
 =?utf-8?B?bC9uNHg0emw2UnNtTXl0eHFpV0hGd1NjTTVaYlhPR1Q4Ly9rZ0lDMTdMdlc1?=
 =?utf-8?B?QjRubTd1QkNhSFVpVTBzV0VtRUJwc1AzZmNqK2gxUG5sekhwZHNqdEZBbStQ?=
 =?utf-8?B?SFhqSzZkRWNwaWZYZWZHTU81K0svVzZXUXpIQmQyejcyU0NpTjJBdkhkQSsx?=
 =?utf-8?B?d2t2dWw4Vi85Y3EzdVd4cTVnZ0kzVzNrcEt6Ni9rTUd0VkNsOWdjaXEvSTJP?=
 =?utf-8?B?NDVaSHd3MVEveXJuaU9aTTVScFdFZ3lOdWoxc2c3amhqd3BMUEJEL3MvN0tW?=
 =?utf-8?B?dTRYLy9XQ0RiRngvQ0VJT296eVpLM3JTMHBJMTgwWU9NbzA1NFlrR0dMallt?=
 =?utf-8?B?YkNNVHpLNzJsWGY5UmRZR09DaHp6UmU3TlN0dFZWQkFrTTl1S282ZHRlUEZW?=
 =?utf-8?B?MzhkMWRzWTI4REhieG1YcTZPNkhnYUNFZVN6YmhiMExUSU1NTlVSTzZleGdQ?=
 =?utf-8?B?YUFKRHRsb2VkZDRmb1c5SlZDQ0EzUnVGcU5GV3dzdkVkazJja1Y0S1hTb1h2?=
 =?utf-8?B?d084Rk5MTSt6M3h0M24vRHBNbzZQRFNFOThBZEE1UDhDL0hkMG1oK2dDMm1s?=
 =?utf-8?B?MU11L3Q4RWQvSzZ0a3R3WnlHNnV6UmNOZENnYkw3d2RjeUc0WDlieWZYVGZ2?=
 =?utf-8?B?czAxWGg0ekxQTHF0TUI4NXNGNnlIUTE4aDJ4Yk5lTmx4Wm9qaDR2SExEQjNr?=
 =?utf-8?B?S3lKWndwWFFtSlhjRnBFdllGZkNUaEQ2UnFJQlNQK3N0eGVaRXR0a2F0Tk45?=
 =?utf-8?B?S3FYRGo1Z3Jwc1FrRHd3enZWTzBaTnlsbHd1ald1c09oKzhZL2NEenk2VXpq?=
 =?utf-8?B?VEx5VDQ2NzZPM2NRTU8zdm54QW90elc0Z2YrTU15VkVoNjl2dGxIZ3U1Mk5H?=
 =?utf-8?B?YzdJV1dzY1g2S05uK1JsSmpveUdVaW5BUm03aHFDODh6Mm4yckQwdEhHUHNS?=
 =?utf-8?B?S1Bybitva0hMak9vUjc3Y0dIbDQwVUpqNGVvK1NCYjJaMU1NUEZIM0djSEFn?=
 =?utf-8?B?cXRMUnBibk9WSHMrU0REaUVGaEZKb20vTlVEbGl4ZC82VFMvOGxyRjdQREdD?=
 =?utf-8?B?RFl0YTRXaVBGenExSXBFbDdoa0liczJra0c2dlBqZDdJc3p2Y3JhbEJMamh5?=
 =?utf-8?B?SERqTmRraEtpSUxLOHpHd2NuSUpSN2w2WkdaZ3liNkI1aU1qaGo3ZExlaWQy?=
 =?utf-8?B?ZEdPdUxWRDFnemh1V1R5UGRPdkVrdG1IbXNyTFBzdk54YlVVUHhYNGs5R1dB?=
 =?utf-8?B?RW4rbnJmaEM2MzIwcjdKVk9zeDMwNG9uWDV4OFlmQXBrM1RBQ2ZYQXQyOVBi?=
 =?utf-8?B?RGJYRDRjQVF3RGRIMHRudXpzOHM3Vk5WUi9RMnc5STQwMnhWemhnY1FwWWZS?=
 =?utf-8?B?QWVwd0ZKMFM0dkpzT3NhQkNCdUo0aGdIdlRFTkRNUG5KMHh0TS9aeFJGRTcr?=
 =?utf-8?B?NG41a21lK1NOWW9uMENpQnNoM2x3RDZ4Yy9TOTZYWUE5SjZJUzk1bFhMUVRG?=
 =?utf-8?B?aE5lUmxLTWxrS2lHV1dtZ293bXpqMUZnU0R1K1lvSC9DekJJMFB6ODgrdTlD?=
 =?utf-8?B?NWR3L0Rqc3lCZXVPSE9ISDd5dWI1SnU2bkFYVUFoUUhkVjdZM2hWTzhmbWNn?=
 =?utf-8?B?Q1BlQVpLK09TcWMzb0E3TlduQVhXRlRtYmoyVlhRQ2NlS0JEcHdjVER5U3hE?=
 =?utf-8?B?Zkd1azZsOXNiWTY4UXJYUEVQZCtsUnhMZ3VXUml1YTQzOHdrN04wVzd2Q1Zo?=
 =?utf-8?B?RGtTamFPS2FZS2V0SmFXcWpha1Vaa1BwT1Q5Y2c0Lzc5NGJNaE1JWDdiMEtw?=
 =?utf-8?B?a3c5bmNzdXl0Z09NcWlodGZtbVE0Q2dCNGhLZjM5MHdyK2lhLzBobmxQS3dC?=
 =?utf-8?B?QXJLQ1d1RllaUXpOVkNVMzlTSjF0WVhTWFFqU00yK3RPc3FiVTdpVGY3Nk10?=
 =?utf-8?B?TEczeTZBTTNMOTdaK1RBMzlUZzBRR1Z5akltNXY1eWZWRlo0ZzVYMW1TdGtZ?=
 =?utf-8?B?ejQrWjdPR0VxcXg1cVBYbTNjdU5paEQ4bElmTUo1eUo2QnhwMUsrMllpUURs?=
 =?utf-8?B?MUtnUzdHNW1MWUFhRDl5UTdwUk1EY1Ixb1BzZGcvck90Vm83dDk0bmlSOG9i?=
 =?utf-8?B?NWkzdEhxaXM0Qk9obWVrL2Y1c3U3b0MrVmtsMnpiQ3VieTYxWG96QT09?=
X-Exchange-RoutingPolicyChecked:
	JvkRX0nr8p4atDSBwh2yF3Y+T9mGP8rUqc6QX8p4xAohdaExjVK3dj/1FxpFd1dJ2bKgD+p+BQzKoZ7T0x+qRwOfo+2RevCfRVhWmKjkMR31kus2+JcvMEz08t4u77/sICNry6jt6pB/ChJg4D7RnxFGU9fow/ejZSRNW1xufuO2ezpaEOTu+NY68EkvRLT/aAZH2zb0p92OJS6zFN5s8xJBlkbtZm/zf3miYffsE9skSpeDn1Z5YVHowpOZiFdb2O58oTIiJ/KAP0ZSPZZM+osyfiow0BsS3jqc38HmelYrAbixZb7mWtawd4vYCNmY0L09DKW1O/TOeHmG1tK/Pw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9035596e-75ed-4579-11c5-08df369ec3d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:59:23.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PdER3HtZhcaNTsWHVvPi/7/KRKZcpJIG8HCvvONMGY+IUXdE3GBRBjZVM5XAtd442bEbcXD0Jc1MiX7zRwSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MyBTYWx0ZWRfX5ymqmuJe4XZb
 sX+PDTXjzsZJaU5gWQKYvmIphAGMCgRIG1qpQSpft7bdrnfOJk+FtJLINnfGnaFRx5SaFC9wiF1
 gLaEixUHomJt3WJ+To+MP4izA6WPFHWKeRhRaH7Q4OG/1vwb+3X5qc7vtwCR/4LgtHErwejH6dg
 RhsojsE5yWWBY2/6fF46MdCudVW4hnCaZNJpuw7QVFlKysIQ4bZtcCJJf4GM5cDRU8EjfJumasy
 fDaQICyTGCyRlJMo6hlchJv/kB3HLO2tqyvOYc72i2dqE3OnJLJxMMTkjsFVMBGw8N0UkSUKxVC
 xaESChYO1YvUSektUJeJeUKMIIvy5mvJW0tOJPRfoLUW9HY6p/Zfrq1avGTijV1CpdyApgcHAfd
 nRNkxpluZvLk9PGI923AiYbu9JOFQbVSexksIH4PklgDM/VxExkTwJCCgJ0XO59aDRlNyl7C9V+
 tBvP1Dj9HhAmponzxJg==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4bedd cx=c_pps
 a=Ho/Krdd5x/ljPkV1+9yTnA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=-HKnLzwKZLn3ursufDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eZDZpl_cypBJZJQkguK_HazLQbY9rD42
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MyBTYWx0ZWRfX3AgA0OubP2ZS
 iVoUPaaPfUhU8tPEq9DjNoIaRBfnLaIbqFzn9GITCONCSV1zzF1mGVNeEYIDb/tzjtOAt1Y4sB4
 fcaelnuV2vcZga8TD8FS1w26tefzuVrMkuTxgrGzHmI+UZguw6iR
X-Proofpoint-GUID: eZDZpl_cypBJZJQkguK_HazLQbY9rD42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300063

On Fri, Oct 30, 2026 at 11:03:07AM +0000, Mark Brown wrote:
> On Fri, Oct 30, 2026 at 10:16:00AM +0000, Nuno Sá wrote:
> > On Thu, Oct 29, 2026 at 04:51:32PM +0000, Mark Brown wrote:
> 
> > > We need some suspend/resume handling to invalidate the configuration
> > > when the IP power goes so we set everything up again.  I'm not seeing
> > > anything here.
> 
> > Yeah, I did saw sashiko complain (and my local LLM also raised it
> > actually) but I do wonder how can that happen? So we need to assume that
> > in suspend we might lose power (maybe because it's regulator powers down)
> > and need to do redo all the important initialization bits?
> 
> Yes, might not even be regulators - some SoCs have good internal power
> domains and can gate parts of themselves very effectively.
> 
> > > > +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> > > > +		return 0;
> 
> > > That function has a minimum size but not a maximum size...
> 
> > > > +
> > > >  	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
> 
> > > ...which we have here?
> 
> > For ACMD, in theory we can just configure UINT32_MAX on the register so
> > not sure if it makes sense to clamp to that?
> 
> No, if that really is the limit it's fine.
> 
> > Conor is pushing against the new bindings and that it should be inferred
> > from the compatible. I tested this on [1] which is not an upstream
> > platform so I wonder if it's ok to add support for the complete
> > integration even if the SoC is not upstream?
> 
> So long as it's an actual SoC that exists rather than some random FPGA
> configuration or whatever upstreaming just the SPI driver is totally
> fine, that's one less piece that needs doing whenever the rest of it is
> handled.

Nice! Then v2 will bring the work for the SoC integration! Yes, real
SoC with two A55 cores and a shark DSP.

- Nuno Sá

