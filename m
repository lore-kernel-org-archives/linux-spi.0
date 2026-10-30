Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793354208;
	b=3uFinxRDB2saDfUvoIYVt8KN0l27dAp1rf/VuDZYDGgEY0MR5n6DGkjlvWaIIzKpIZR9
	 7js/l2dvSanSHuZCSbKM6VCIpvh6P12f32LRqYAIWwv4qHpZ9cueTcEUPzspC5SgdBqRE
	 tgpJzJU8CFSk8vc/xElUE6S++188SuhhmKyeCXlWWFCcKi2zsFWmYWUhj+aiXT3R96OQw
	 d6oZOoDGtAvjOeewI+ruMRKe93rj2rcu4KlGejndhSZuj+5kFVJNgCnyTYP7QKN9cciSb
	 B4JRP8uW5a7wvHlW3bMRAzAJf8u0Y90Y424e/LmCkzl00pIrc8sw5N6J4fgYFAb0X8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354208;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9KER+SkiGFYeht7dukzvNUWBS361rHWU57kqQfoV24g=;
	b=zTtC+2i8HzfxpMih6IkfT5XBzr+Fbdnj6oAZjm08YY/pWCmMnxid41HjEjIvQLe9Vokf
	 EOOw03Vcppm50JUVgS9Guukk3FNRFgPg3f5Mc6TNMv08Cr2K4ZNjTHgPAbtdvh5JxnFVa
	 nCKIH5EizkBz9p8tUEtKrp1G03IXfreQPrrsGCnCmcIfYPjWG13Cwng9NSEm7f5zvuA6Z
	 iVe83UAF6r2Le8AKvP+DpGWNlWqa21a2Cy7VCGmo3dk+hZKpAZZ3Ligu3BwkQBnWilhAM
	 Z3VCWNUIEdxNGM/S+tB0wNbUr9jp0ZmYB/uyG6/xcnKFDB7cr5ceVcrYNmD/yniHQbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YdY7FAGa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xtcu3c9n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB9606A31C;
	Fri, 30 Oct 2026 09:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABAB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YdY7FAGa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xtcu3c9n
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8GK0w3159456;
	Fri, 30 Oct 2026 05:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=9KER+SkiGFYeht7dukzvNUWBS361rHWU57kqQfoV24g=; b=YdY7FAG
	aVwWnYj/mIAUyCj9ZMSGJpT7wQGkpJiwylQuxr51hv2lCioQ3fzhFc29qC665FD9
	O88LkhqJ50s0LYWvoNbz3lXLnlz+mfpvGqb9jllYw+V5lg7qA3dKGYH2VfBuJsbY
	D8SdtUhdLu1VSUcmV/rIJxvmPrJjEFRTQVAK53WzfBNYQ+AbhA52q+JW11FGdcru
	En3ZXbJhwtVBVnrN/+NaLb+xfwzk5nwGXOKsbgwT3tV6+X2qYtBTCmPbWMWqXXNJ
	tnbIz/IMkSegQcB82At9abDwNBA09jx47AGEvjQ1FdN5+M9oeihHdNatCOPqclSA
	ymcbg5ofe3ArHEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9KER+
	SkiGFYeht7dukzvNUWBS361rHWU57kqQfoV24g=; b=xtcu3c9nj7MDoX7d899+a
	UG0ymGerqqNyBI4WVkO0wB/YO6CZyKtLO/23rD13F87dxmsZChApkup6GouMd3Lx
	yPHGyaxQWNWZVX2pIxRL9+UzdoVzm3ixfJy7hgk//rD++yo0GfqGG6hFsRIzHAwA
	8e5Js5dKTrnzzxeZJ3L0N0iVJB9dKrmzt3F5SNxzopkOx4OjiiX9lHd0Tv7qVBl8
	uxufwo7/pk/yG2cRWajtmQ0qHq9fL9/k8agMqTi3Uf99wkWdW1tCqmtDQW1Qghda
	BU8RgAodM54p0b2Hms3EeVW7CkiU3PTVAel+f/LW8Qqfj5L6bU4Vd6sEdCFoPY4N
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bu4ep-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 05:56:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBIu/IX55oAIi0FgAwfcxdmb/kwiQXZMJw5/zbrNNOOYhSUcig83JB7bDxiNh0/YBS2Pje/4vdoldFR6XdE9bVshHkVroMOKU5Tw0DsQr5A2qN4yzN73fkG/4ujmAS5PYrJLH29KZo+nmObnszRWLGXDkLVBwN/vMvA9biXN6YrbbsW359JfLtGyzsme0nq77Dvn6rWQJTtX3oP3HDWQH3V4g4/Qn8RtrjnSmwBxnseCmjvi/x7+4mkmx7msJO2nj0z7nlm/xAkTfuiTaKnjv3rpRANw8WYMDjORCdzLwOo4tdqwusWa7ndUhEibDJlTskbkWwJEBU57vGCySUiHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KER+SkiGFYeht7dukzvNUWBS361rHWU57kqQfoV24g=;
 b=lc1ui7JFsLAQiQ8th3qY0VqbA/qBIV48SwqLXnocS70fUK3pzbIbz5mKwqZtgtKWcNRa8iVLbdO0xly3sqNOfftMc00lDWvL4VwAydTeG1tH/R11v+fTrXeEm6f2WD2C6kTZtlUxvzRtSDHvHlzp3Lkyh4T092ywEaCaLtE7O1rnph2Av2zu7GUkm5Wa3sgmeXy8jMtTVNH9zoaLZIdC71UZzvvXaCSeXP/iVHZ8SISqWtDZ59E/IEyxQzAAF23fqN3sw+9lfuFljHc5wH79Rw45B1OdfdEhoNS+Ysiwt2JSx58jikvpKFkPdfZ0ft4SjhOraKHSvY1+N1SsU/fqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8101.namprd03.prod.outlook.com (2603:10b6:8:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:56:21 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:56:20 +0000
Date: Fri, 30 Oct 2026 09:57:36 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 2/3] spi: dt-bindings: cdns,xspi: add ACMD and internal
 DMA properties
Message-ID: <auRpD5u6JQgwQM4f@nsa>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-2-53cd44690e04@analog.com>
 <20261029-tag-scrutiny-b9ef1299e88c@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-tag-scrutiny-b9ef1299e88c@spud>
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: fb26b4b5-a5ed-4838-ec38-08df366c0c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|11063799006|4143699003|56012099006|261009223027099003|10067099003|261026121527099003|261021121427099003|261022115727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cr90GJkR0r3eyKh6Oc0feqsjjQntAhInlHGBvtbxF36q93mNpQoSOt6YNSg9av9xG+3BrIIBRnhF9NenIxmIDsK3bkNC24qeVyCaRAlU3vBR3E+yMaypY8V/j27KUQHe89swkNnDJVZGXGL54WGwzF2Hsti/bUv+A7n2L8R4zY5P2a67pJeg/NqnCMNgJxYMnCfuqqRLgGJXSNDZ4ISMuA/ksNnZXj6mwNGUV75IVgv/nEXZS0e1w2aoNNuqHWdc6xtD6eNAkP6k07VBRP09trvr2mUt0MZlUFPtI66cCmwwdMGaonxRikTt3Ei6ze7hJMUWd//6ydLpqth/i4ZwU3EKxPZm4cDenyh52GxjSKXOWvupiLKElu/EMNxNvnDWkivaYM99qFD7JzUOtofiZCjD5CHoAxruN/dv+9wj5CD/36ZpiBpXPpuo9fK9EUDy4yn6lIIEXnNrZ7tbmt0Q6KHwar7en9O/UKB0ozcO8ja1X48uGTV4xnoTpF3EeqO8DVRiDqHYJsIaXvTTM1vJLbVGfRFKpr6YgCV9SHnJU7gwGm7PAHxCUqDa9BcBHstWSj8m/HKfJM8as0u4Fz9X47Fa9KMyjNvc6H56aByO0eYx4+GZcbgOTYaVaau+IQIWo0tB09FnpnEViqZPwex6oMsXvlwPQ0aEHxktdxPusB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(261026121527099003)(261021121427099003)(261022115727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFlhZU5pODl6UXJJeUMvM09ReUNKZHF2OVhuNElrSnZ4YWNWWEhwVjRBOEhC?=
 =?utf-8?B?eXk5K29ZUTBTSkZDOE00U0VDeFlGdFlBN1M5YzliSlQxdGlUd1RmbnNjK0Va?=
 =?utf-8?B?OExVYWJHM1dwbUltVUNmZFdVM0tIL0h6VzA2OHVXeTNBMkdqbk9VVUJmK1Fj?=
 =?utf-8?B?Sm1CNlBjOEhtak05eEo0S25VS281NjVJZWw0NCsyUHN0QnFhcStpd0Y3OCs5?=
 =?utf-8?B?WU8zZGk5SFNOYm0zV2Zrb3E4QUwvc0luSTFISlZsYmwvTHNYMmNZa0U4MlNZ?=
 =?utf-8?B?bjFRaUptcGlvakwxM0pTcEFpWGM3QXpTV0krVGpQUHppZEo3RjJSdnBZNlhW?=
 =?utf-8?B?QldEYVp1SjdEZk9xRStXTlBTakRZR29lNmRqanZBZnViQWowcVVhbXpMYTZM?=
 =?utf-8?B?aVpmR1Z3bmNtcURHSGZiYWVCcEIvU3lPYXVqSHNONEZlYWJmVWR0dzhFZ3Bj?=
 =?utf-8?B?ZFFnalZpbS9NeUdlL016K3FLWFdxQkFCaVVob2xyN3pTT3BBdlBUbkpIUXMr?=
 =?utf-8?B?a0VSOEZQMXo2YmJ2VDR6eFhTRHA3WTRqeGFZOTlscktOWlU2bGxUYkZzemxH?=
 =?utf-8?B?c3BuU3hJSjdDQ092Vk8ycUw5OW1Odlh5aCt4ZW1HODN6bng3V1c1cTB4ZkVP?=
 =?utf-8?B?Zmd0UUNaUUhtUGhaYy81ZlhtbXh0bnlycWZraVFTSzlybUoyS2pZY1dNSVd2?=
 =?utf-8?B?ck1jdHhrQ2lCSXZlWHp3UTV1RE9PU3JIRTEvVG84NGtUc1FKNGRjanp1ajVa?=
 =?utf-8?B?WlZESGlCTjNZRFVXMzNPK0FLTEdSUE5XaGUyejVOczBiM01sTXNSeURBaC96?=
 =?utf-8?B?R3BMZXU4TFJzUHNmS1lkT0lacnFNeFo2L1JaUzRWaS9ZUERGVVoyY0ZISTFP?=
 =?utf-8?B?ZTlhWm5BN00zTmIzNEptc2lFWEJsQUpFN01XNjZjYnYweWg4YzF5U0xFOG5M?=
 =?utf-8?B?bU1VS3AzeHRRd080ZTRmbkd4MTVvSy9ocm9nTEYwUG1zdjJXNTNqRktKcFZX?=
 =?utf-8?B?MlhsdWtCa2Q3cGVzRHpHSExOazZCSEt2Y0NrNVNuL0FqZXM1WnowSllJcG15?=
 =?utf-8?B?ZDF4b2tNYmVjS2ZIUVRJN0Z1Z0NxV1pmczRaT3l5SDJnbGZxVGt4VE43dzZl?=
 =?utf-8?B?bkFNalI2ak4wclJwNEJ0bjNVZUJaMW1GWE9XQi8zRWRTL1RSWUp4Ti9hMmtn?=
 =?utf-8?B?cXhEYzVjcW9xYkFtVjNqbGJOS0cxNU9QSnNmdTVGNXZaam5peW5HdkliSlJV?=
 =?utf-8?B?aUxKZmQxN1UvaEVPenVMQVV2Qi9WUkpyTkMzNnQwWHF3Rm1xcVJCT3lFcnpG?=
 =?utf-8?B?Zjd3cGdFcTB6UjZoeXloQkh1SnREUFExd2dlOWI3eXlia3lMRUR5byswUHJ2?=
 =?utf-8?B?Ym1QaDRKRXJrT0htUXluajVhQmwvQjBoWlJhVllPYmRSeGQwYjhIeDBxU3Mr?=
 =?utf-8?B?cDR0VDFPaFQ5QUI0M1M0UElLVGQ3bHRZUE1jejAxcnNnMHN5ZkN4ZlZaQlJw?=
 =?utf-8?B?Z0VrWWNBemo1NXBzaERxeEFZbkpDdWRyMHF0Y2IrVndWdmlSaUJGRHVoWDRk?=
 =?utf-8?B?RWhqelpiaWlYOGFsNlhsaWpkSGJhS0xjaTcvR1V5a2lJVTc5K3lJM2I4cmR6?=
 =?utf-8?B?azBnN1h4K0w3TjZGYnFnT2FnYTA0cS9WajdLRk4yQjAxN2dwMEdjTnJXUmJY?=
 =?utf-8?B?aGxxTmNzMTB5dFlqUFZuLzNUWjk5ancvMEl3QzFhZ1pqRjBjVlRGa1NlS1dW?=
 =?utf-8?B?Q2NIM0xXSUxvOHMvRkljcTFzek5lRUZFR2g4dnc5SzdzSUhtN3dtUEljYStn?=
 =?utf-8?B?WGRKOHZvVDVaamV2ZmVDYjQ2eDBISkkyMXNmZGU1VzBuaENQeERPaTQ1U1d4?=
 =?utf-8?B?TzY5dHdUWUhzdXYvY0xpWTdKYXF6OVliaFdCV1dqNFlvOEQzSTl5cEJQeWQ1?=
 =?utf-8?B?cG4ydnpYTXROdTM5T1liaXhsdUtESkpSZHlWNWVYS05yQWpNQUJxS21ZeS91?=
 =?utf-8?B?djZWSFJjeVlNVGVoZmp2Q1pLVE12RkxPZC9Scnk2RVcxQWdwZmYrb2lRMmsx?=
 =?utf-8?B?bi9YaUFjYzA3RE9IRzRSSUUycGxrRFVwOERBUVhaTEZiRnk1aGF3ME5ETzNB?=
 =?utf-8?B?TmU2dFhPcCtLWnhGamVJdWg1bnNlRDNsTVkzOGJqbWV4Y2trNGNLSWR2L1Jo?=
 =?utf-8?B?NUhHMDdrUm03S2diQ2p5RGo4bXYzUm8wS0xVL28yTEZnMm9JWVVrM280RjBY?=
 =?utf-8?B?cjVHaXRrcHREaEcwS093eFpEdU9iTk5FVHBFZVZYaDFWRVZ4UUF1VkRDcStk?=
 =?utf-8?B?a2NCUHdhNlptdk00czdWN2FpOGdZclQrbkxmeUN1T1dKZWEzUThIdz09?=
X-Exchange-RoutingPolicyChecked:
	Q+vuzDr13NUKrua2uMst/ZKT0iGXe1y6CGiIrwClTj1fDVNLwGD7sj3mJk5iBMuSon5tBao6Tx8k/tYDnND7tfplNH5GVG6qCmzgy353bgUw8hxoGTdYo1pH3GOo108MPUyOZ1Yw718SWKsUCyg6T2tsVbW1piRyq+h7RbGjZBBezjeytrpgKuqH5kgKPRbdfue/ZtvIs1/ttKeRhIll385OWRCcXqO/K6RT7prv6iMi8oYk24+X6cfPfYqQLVdioih5pbOCRwbii8tTbJEWGUg0YCXkO44QEZJYdOgfAmvnDH2MyWy40FUkBF2QIlnchKMnFMDHiQkTiVW2bPK0PQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb26b4b5-a5ed-4838-ec38-08df366c0c6a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:56:20.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV2M4z+IhudYzngujVVehXcD+iPov7Xy2q5YrbECRdWjjk/+mPZQ+Tw5kWRAT5q11s6vzbm52mRlm6NMbU0cPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8101
X-Proofpoint-GUID: GZPjDC-f58zAOigPA2gRbV_VmG4zQJqH
X-Authority-Analysis: v=2.4 cv=Sc5i5fRu c=1 sm=1 tr=0 ts=6ae469c6 cx=c_pps
 a=/mfax+0MUk3zis5Hx41TAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=tvBRgVDA9LD6tOlAsocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GZPjDC-f58zAOigPA2gRbV_VmG4zQJqH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzOSBTYWx0ZWRfX5IvbmbLd9s4X
 5Cvf0rt0Zr7AnhgRJXkxDo4exBRvUlMpdEgGTPyXN1cgMiBBEdahGUVHLgVKlHtcSoQUDjzAVfH
 viW9OfGkU3Tcm7wn92UzK3tvkmPo7CRiNhObIeX8UFy1t9xfuxuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzOSBTYWx0ZWRfX0scvHfSz9neP
 QZsBWz90gzn7/oXlr8HaTMbauGYjzqNZUfESEIvFw34Yg6rTsxyQ7EwRh+eDiPQT95EBvIXNYZp
 0ims75SdXp2SBcHp5HZC7beqk1VzvWIibgoAyIKDLwaxDU7XRmWPNHI+jtGx5safyBcwUj/xRZk
 r1PP9wx4+sTDUjbWr28oqlOIurR39E467LkYn0vqY1ohfHoV22MQinNTd7vhzVeMla22q3UzBGk
 AU+/dlU8mSMJEUiCGH48V9P4fCL5WjbWMpj/Qigy7vnEKJ3U21Up0CR5J559Nmom00I1PryeN/1
 ClkdRvm0nNxNb2n02AcduEEQvegnI4kuBB+RwgfFcTpJcoW/DQx0nEid7uO70KHgxauXbz2l/9L
 2y9j3YWOSXufDC72ssqIc4E+iHX00PSZCjPaaivC8eCLKP/ytWhqKYBb3G5Q9pAQInzxIBOx8a+
 iTC1jct/5nN3ejC7BYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300039

On Thu, Oct 29, 2026 at 06:31:00PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 04:03:17PM +0000, Nuno Sá wrote:
> > The Cadence xSPI controller supports an auto command (ACMD) mode where
> > high level sequences (read, program, erase) are handled by the
> > controller and data can be moved by its internal DMA. Whether ACMD can
> > be used, and whether the internal DMA bus requester interface is wired,
> > depends on how the IP is integrated (e.g. external SRAM, interconnect
> > wiring) and cannot be discovered from the controller.
> > 
> > Add the cdns,has-acmd and cdns,has-internal-dma boolean properties to
> > describe that. The internal DMA is only used by ACMD, so properly
> > reflect that.
> 
> Why would these properties be needed? What the controller support surely
> can be determined from the specific compatible for the SoC integration?

Alright, I'm more used to describe peripherals than this kind of IPs but
I imagined that these being properties of the IP that would make sense
to describe them in binding. Ok, but I sees this leaves the door
open to just add properties in integrations that would not make sense
and if we're going to have any compatible conditional kind of handling,
I guess it makes them pointless.

- Nuno Sá

> 
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > index 38a5795589de..9708ede79730 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > @@ -40,11 +40,29 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >  
> > +  cdns,has-acmd:
> > +    type: boolean
> > +    description:
> > +      The controller supports the auto command (ACMD) mode. The IP may need
> > +      external hardware (like SRAM) at SoC integration to fully leverage
> > +      ACMD.
> > +
> > +  cdns,has-internal-dma:
> > +    type: boolean
> > +    description:
> > +      The controller internal DMA bus requester interface is wired at SoC
> > +      integration, so the controller can move ACMD data to and from memory
> > +      on its own.
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - interrupts
> >  
> > +dependencies:
> > +  cdns,has-internal-dma:
> > +    - cdns,has-acmd
> > +
> >  allOf:
> >    - $ref: spi-controller.yaml#
> >    - if:
> > 
> > -- 
> > 2.56.0
> > 


