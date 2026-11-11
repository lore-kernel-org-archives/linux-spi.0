Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403351;
	b=bsxlU6c6ltMGR2z36CgKAT37yO5rBOIJfDOfuCUtSzdfZrEAbBEyJuY96LNzwiIw3dbL
	 TzkgT/mrL0QlnkN2FTdzT5nDM8H6LeKzLYHb4/isYqKg0/ek8IVLfniUAodcaKOQdGQo0
	 Fyg5O1pz97g8u7g18/wzPrsKQ31Z4iXCiuEgg9XDahQgwWTsltHdDEh3/FN/ZKU92Dxql
	 JhEb4TokbgkifyYqhwd+lT6eCvDRre0ko614gC88VEeDFQix4kIs1lDvYdWonrOpHd2LT
	 VlVG4l9MwbZlxh1ERFGLQVCkUpOc8tTh0najw7wmXCZHRhXFbuQgif9RMqOwv1WskXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403351;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KJSYNJt288PpIF68pmujRTErvBSVIMMTyH8aMuMJ6FI=;
	b=c9njk4+FOM1d545al7CILaQdOWdpQUtfZAY/cR54f4O0X/ePdfup5uZzEI/2PWQu7YP8
	 ix2CamCC73B29xlko+tVU1Id4YeYUiSeAF6vF2Um2ZpebuSX4VLIzRtdXopkfW+BI1hyf
	 oQbuGSKTl911GO632EGfMeakdFld1NNnRWc6it2zAYyUTdqmg3PJ/o6rSv9l+8core7tR
	 lynOomn6KQrBjQomg9TCzeKZ4NgdRifIkrDcc319e2mGtMoludp81dn/cdSCOJ9k/HsiJ
	 VVC8aLO23W2yuAWe1bjXk3q7v6q9eZs3sx5ySjRcn1D6MjGttYtEZPf3JBMBYarblKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VUHSpzrs;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="dvu/RAj9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A606A336;
	Wed, 11 Nov 2026 13:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC4A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VUHSpzrs;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dvu/RAj9
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWGcW226402;
	Wed, 11 Nov 2026 08:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=KJSYNJt288PpIF68pmujRTErvBSVIMMTyH8aMuMJ6FI=; b=VUHSpzr
	syzAJFW146aKluZosoTwX0cWWVmI+Xu0480+5l4O9NnXPn3OU+lSzz0H3RmsD9RC
	yvDehwcxk3K9rwQajSACg5ZaN9to7FetdT7GRLpDRcvp9dVpBSyBOaRfh44I4HNW
	jt0UxX4vlM4MpY9H32mi97GabcI6Mi1g/oytphKo8yZp5YlEAJzbQp8W9nGY54Av
	Vdr34953hP/lPDRc5OGc3pw3amMFKxZv17vH721iSAiAsjXwIGYTjwED8ajrl3/v
	S+MCPDymk/DG4yvVuWYOQ1xxO9puY1vwoS8waaASMfJlcdgXZMUCYuhjuF44QrIT
	fP95xKTtS/dyj+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KJSYN
	Jt288PpIF68pmujRTErvBSVIMMTyH8aMuMJ6FI=; b=dvu/RAj9xnvfPBatX1cXP
	QV4j4yiwXNZ286sSZH1wGBFmdYHBHeLCQIL/DbPgbzqZ2tlbRAfEJdi5C0tXMZ/T
	4pjpGiQQCYAX+JHqaWLTvQ+isrJyyYIgvCzn5bAJFAAryjd4hvGbyR89FLhRzTVq
	1XbXxlHIY+NltSfYptv8cNvrtOy+Rhu6ymuJJWMxlMAj7h92NjUG74DUfP2y4U05
	M3SgRfVOSuRcsm1Nstvdi/dE6tIxmsx2dgRLXpGRUgMwrocY6pwtvjsgUDPVCtrB
	lycP0sFNq/uZAJj/5nvQA14by/jiuYVDfL8perBpRq7P7M+dl/o5C0PWrfwyH8q4
	w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvhw3aa7a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:22:02 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjLKgZB1AddkWSf1MjBvYm/XkSUmZ7NhRpZj+7HbaFBkBCuDhfgnSgvG2Oa2UivXcJltG5jDoRxn5bUP5dMUnK4yKPgKJKJVnIvYZDx2aTHvN0F5Cmm4mg5UEJce818RU+UDlDonAeJwgCd7T6ZLNQ0w/viJEq+/vMWK9McdcqATskU8PvfbpHCsOu6fzXWvepOafxieeRuEOcHHRts73ue6IxAH22hR9AzD8chyIQ5buWzulN+jwhqUixIDvz+KH/0zp25kPOS2kJgatMC1hwMacDJKdtzBw2RpZapvqg7/XotLoguqsGlnuU5NQR4KAFCPtyrfDZv4KK7Ned4LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJSYNJt288PpIF68pmujRTErvBSVIMMTyH8aMuMJ6FI=;
 b=tjRK63bv9MMQw3sQRlTndtpcT72Kib5iGANPfiVCAA7SalbIx3lD2DAFKBGJQsptDk1hopKMG9sYTjWQjP1KmYr6F1ehelu1io+ojJFQH17XLbueP5s4QQOPCU/GC25yBZNUKkSjz9GxfRH9oEskdm2ivs09Bq1c78A1FN/w8F7KP2U9YK69hrFCy4Sj9slhf+VpN70naoAEga9NoomLtYbVgcRy+e2eXqv3FA357lAyqnmKXEtc2NId86MblDrXMwLanfGX4Av9bS+HJVoUIb208EqC+VrHF0aiZz0h4X/3Lg9wzjZYO8TBDC/few2pArzWkSxZcIC6ILqjqVcLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:22:00 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:22:00 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:06 +0000
Subject: [PATCH v2 5/8] spi: cadence-xspi: move platform specifics into
 driver data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-5-d339046ada8b@analog.com>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=9608;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7oIGlIze5PR9LyZK/bzGFBKc2UPX6wtQCAu8XY1UHHk=;
 b=nnqhu+AyOPdfgykDD9+1C1VAdQByAKU1rJmXkbCqatcLiGyzxNPyElg0tk6p7777lfOn1DERf
 uG4XYeQKhZuCwSgQ8/u67oi9B8TonUPiiL/4HIucRj9MhuRtZVM+8Zm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR1PEPF000077D1.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::408) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 90acb523-bbbd-404c-e3d7-08df3ff6c49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261009220027099003|261022075727099003|261026121527099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|261021135927099003|11063799006|261028144727099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FqAHPXEEwiwdfhqyjiqmV69JNL3AvazWTgZ1b4vpQbcBdIWOE2PBYedweEg/dODSCFs1II0cgAP/oNrvQYaJCiqaDbg3Y4CrAfWqhZs5EexwYQG8/1YvYKI+EflqEKMy1KNdZvvO9iZoF2ZLrfmc4Uz1aQJkiD3M20pjVaVxsN8rDx8vjdNgPr2BaEJCYqWRsLegr4yWVWbbab44szMxEpN9bz+Llxs+A/+JPtsEh5HEHnImyQaAmHi3Rrk9xYge1YHaUUGqI1POz7bCe1nokoaU/Keqhks37GA6KaQ1K4/Ef55571PGsh+Yts3ZQ0Pc5dmR8hVpIhk5M9jwdF9BMR02UTums4DUlGO1iRWz2ivJMVGCnT5HH6N/sMSIu8acAfpFKv9P7ZSr44rutU5FdV5mrIKSb/wcfUrIMBCbQRatE2bQSs9sDjpR2KOVEFGYZSuGvzp5DHUT8HtyPo60q7/4H0e+hw5YZ7P256ukQSJ5ecPwoZUojHOWZteKAq6u4heqPmTMZNIfj4l+5IApVHcjpKItXT5CGBmyR+Ftr3JW6+Fjm4SJEKdQNXqNhCDmBbr8SEIdpSxRYY1cMtqa4STJXisfWF70Da05cW1TKOhaA2WpZLTpS9X4+ZzJekTl3nIapl7QBTFRj1wEpEMXgFb7XnGJ8W/ocMqFQiiQY2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261009220027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(261021135927099003)(11063799006)(261028144727099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkZZcUI4S2tCaHFnOGRDeGo4OHJxd29oSzRncndZRWxkZEdMRDRObW1FNW5i?=
 =?utf-8?B?bDJvQVJNU08rbzFvdFA3ZmM1U043NlMxSXk3dEpGZkhyREJwUU4wUDVPR2hi?=
 =?utf-8?B?enJvVmhZMU4wU3V4Skg2dW0zaHZLQVp3Tk1DcVN4U3l0UVVIa2xLY0pEY2Yv?=
 =?utf-8?B?R09nZ2Z0U2ZXelhSS1NoNHdWRExxQlQ4VUFURjZmN2lZV2JhSnEyNkdxSkl1?=
 =?utf-8?B?SkpYWkRuNHd5YlNYSlpQTHdJa1VCRzA4LzkyYUtFMEU3L0J1YnhMUC9mb2pY?=
 =?utf-8?B?MUZWMjJlMEdINjlYL1FzMVpVZThpSG40V1hVWmwyVk1hNy91T0NjOFh4cWFU?=
 =?utf-8?B?OTBkVVB2VCtKdE0yNitYdXJiTU0waFJYdGpEMFovUmg2NzY5ZUd2TlhIaWRB?=
 =?utf-8?B?SnIxS01NajczNmJOMTM2MlFCajVKMGtLbGpLRXRzMlZtTHNIczcyUVNENHdj?=
 =?utf-8?B?RWJtVUV3dXE1d2g0Vm9mQ1Z0UGxYUlpWQWRzSkNJY3hCaGtNQlVtZ2JxY0py?=
 =?utf-8?B?dFEwaTBNcXBWeFZwNDZhN2U1MERHdDNpUzc5RzFYcmgvZXp4KzNYRUl0alVH?=
 =?utf-8?B?dzVEc2NQNjU0Y3hhYW81NHYvczI0QjQxZWQ3c0tPZ29ObEF6RGdFV1QrdXZG?=
 =?utf-8?B?TDFtWU42VUE3OFdQbUo2bnVwYXBGaS94c3BPM0NiR3BQbzZqL3VQWFBnN295?=
 =?utf-8?B?bUQvYVl5SkhzMk1qT1hMSGwrRFM0OThJaUtGSVZab1VoMmtPdm1NM1FkbWs3?=
 =?utf-8?B?SGlRUWdqc0pIbUFMcGtZc01adnRFWkFiS1F3Y2h0QStCRGRUOHJmY1NEdWFI?=
 =?utf-8?B?QnlucDFqR29HZVV1cjRlS29iMVhUU3NJTTYyUWF5TnJQOGhLQWduaWZjYzVW?=
 =?utf-8?B?cE1kenlJR05weC9KK3ZJY2ZvMldBY25jVDhBa05RWlEzK0xQVncvNE9aWGx4?=
 =?utf-8?B?d1BxZXQ1UWwyZnFmUTRVQlFwVjJzaTkyc0Y0aW5qei9STmFvTno3RWpWdEpa?=
 =?utf-8?B?TlBYSUVsSXV2WmNMZWc3N25CVTlRZkNNT0tSeEIzdGtwbTZFT1dDVUxGS0ty?=
 =?utf-8?B?djhuMTN6czJRZHNydHQ2a3o0c0lQT0xESmNGRnRjVmVodXVVSjJUVjVCNXFa?=
 =?utf-8?B?dlBVVmhIZDE2ZWl1dFJ1aHNlYWdYRlBzNXZlMThPNFVnVjdNR0tjNkhnU2Nq?=
 =?utf-8?B?a3k0a0M4R2dVZnZtekVtaXc3S2dMZWFrUWl6NmdqeGNlWUx1NkdqS01vY2Z4?=
 =?utf-8?B?V3RoNmpueHJwaTNwelc2a3VPUzFBNFQxWUhtZlpjSzN3ZHA1dXdwWFpybDBu?=
 =?utf-8?B?QkxIZG42UDBuQmZGV0d1MzErbzBKaXF0TnI4NFhWZ1pnNlhKTmZvdzV1d1cx?=
 =?utf-8?B?RW9POU9ZcFBlbE5QQ2w2OHcyM1ZaM0JtWDJacEJvbUJOckNIMXNubmpWTUdw?=
 =?utf-8?B?MEZCaUFxUUY3aTk3ZlRYNllETFd6dTR1d2pQM0hZQnFsbGtPOC9oS3huS1Jq?=
 =?utf-8?B?NVo2SURieTQxcnlob2dBdGtzS0NjNnMwSHBMUEZRWm9Qa1dEVjJtOWdoVDlj?=
 =?utf-8?B?WUE5VlRaRk9jdkxUd3I4dkRMc2NFdEliYXFucDVHQVljL2VjNXI1cXArMzZ2?=
 =?utf-8?B?VWk4OUFqZ0xwb0ttOEpNTUpFMjlGYjhtTDNpYTdFeG8zSDdZQmhEVHZTeWJn?=
 =?utf-8?B?dU1zNHZSbzRFcU13OHlNYTZ5a1dlR3BEZmFZRGZ4UXBSRU1zeVU3bXJYYjFZ?=
 =?utf-8?B?eUFodVpVRm5naWNNOVVWWDdGR0wvRFR0WW4xWDFSNmRDdUZ1Uys2VTBlK2tT?=
 =?utf-8?B?ZTQra2xNRzlOanpiWUtzOHp0TUVHZnRYZTFBbmhoYWR3MDNQT0V0TjVucFQ1?=
 =?utf-8?B?dU9XbkxScG9oYnhWMGhBT0kwUlU0U1ExN25rRWFaSVYvRnhZc0ZyQ0VzaWVQ?=
 =?utf-8?B?SU5CQ2llcHdES3NFREhjUGRMdm5OdzQvZDlzTXNQbHhXbHVOTzJLQWdCUXlz?=
 =?utf-8?B?OVk4K1kvdXc1L2ZtNE5QSksxYXg2akNhT0VvQTc2MWRzZHhVSGRhdjM3R0Vi?=
 =?utf-8?B?TzFDMjBTWHF6VkhHOGhEVklnek1DQmY5cHRrbmRrUDNFUWtwOHRwNloyd1R4?=
 =?utf-8?B?a080V0JHSUdKcDhxeTNzVDA3V3dFcDlldVA1N2hCOEFOQTdkay9Sd2pDeGpD?=
 =?utf-8?B?emFJNmI5Tng4eGwvZVc0UHk3dFNIcFphTk1JN3B1cnF6Q05hRC9YVU8rcEtJ?=
 =?utf-8?B?ZjBsNnN4MVAwb1Jqdk51QTVrU3FIcTBNYWZIbE5zRnB1d3VsZVZwOTYzZU9u?=
 =?utf-8?B?MzhMemFMZ2l5eFJXV1p6Q3c0dW5Nd3ZUZ3hXc3FTSWNrQnVNSHhDUT09?=
X-Exchange-RoutingPolicyChecked:
	oFFcWZ10r8d5VOZqpro8irAAfz13UPWaNO7+48Fsivh1a6i7MiBwPRfSWy6Ei6QnJ/RqLoDbnSmqkNgwDCgGK1oZDuLFvkeu7cSQhgbfCcI8HVh0SvYT3dzIL0T/O3plrekOCr8LgarHKda76E01QNy87wDqWghczo/IqVPHsqDYDfyfKDtwjNKVyK5wsHC7J/5ka8SS9GPIh0Dg1qTX5eKxni9jqhC3kx2enNoAFNBvE+8gnNdXUaD6GIzPiSsvQcLGE8mZzSl2jVqUw+Bf9jhpkYysv9FEA0IvA7LSt5JNbLYoyRewyJWe3CMPifa4dFjXPyXe7KfN0QxSGzj3ug==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90acb523-bbbd-404c-e3d7-08df3ff6c49f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:22:00.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyIuZRvrFRfXv3F+18zO1ywxp3oOv9mbmNFlLldS0+5fzzsKgLq8fHqg/XfEib6B+yK80RIsM9DxR3fvXn9pXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Authority-Analysis: v=2.4 cv=VJhIDNPX c=1 sm=1 tr=0 ts=6af46bfa cx=c_pps
 a=+3f3g5PcVU0WeXiSVbezXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=7m7CLd9EMIogzCAbFYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uhSOsInBuYPbKoHqym_1D2wMxXFQi8LI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX6kS0F2FNOyIo
 DjfC5HN72Sxij9vGOyDbNRb3C+e/4dLraKn5/F8kat/BUHjC5zfx6Ix4/08cl9zZF5rZ5kSs9CS
 QV+g/F2dovlusLKfcMhR5Hvggr/gid7ewFhNJpD1A2sx33QYAqYO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXwf5EUHqVK/pk
 q0isehdxDizZq6WZpQqctKxqIS2o8qifd/gSySKDHIDV7GpnEWH16rDr9KrmC2qeRHLTvhjDJsB
 83qBUxZahNrpfzo6um94C8UyRWrw3gcvAZKv4g/7G4SC1dCaTUXugFcFT1NtYNspSolprVAmHx6
 vD/e2wxbpwXqoMmVpRwS2dZq1T9z0NxXFieU4aNocnSJALr/pt08vd8o8QnbYLE8bW7kEyNa4TY
 1mCd5x9RfWBJSmgvQuEFoYIVslijCNNJxiky78v71DWZMnsLPr7VNpQ14XS4VatqaaNbCf0Gyb3
 ET5BP0F89A/5CR1c2hnxcpBhKBgIRIqTS/syZvvWrt+dtDFc8sXR4qRBxZxttH6BGNjPFwKe2bV
 9milhsVZ7LymWhGBfGqx9ctpIbJV/3hSkTbLZqyYDHOlbKiTR/WBwvDUOr4KUnrzO3sWinWY4W+
 /a09x61Cmvun1BXqBgA==
X-Proofpoint-ORIG-GUID: uhSOsInBuYPbKoHqym_1D2wMxXFQi8LI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110053

The driver uses a mrvl_hw_overlay boolean in the driver data to decide,
at several points in the common probe and resume paths, whether the
Marvell integration specifics have to be applied. Adding another
integration would mean adding more of these conditionals.

Turn the driver data into a set of per-compatible operations instead,
including two optional callbacks: init(), for one time vendor specific
initialization at probe, and hw_init(), for the vendor specific hardware
setup done both at probe and resume. The probe and resume paths now just
use these.

The Marvell XFER register mapping moves into init() while the clock
setup and PHY configuration move into hw_init(). Since the PHY timing
values were only ever the Marvell ones, drop them from the driver data
and write the constants directly, and rename the helper to
cdns_mrvl_xspi_configure_phy() to make that explicit.

No functional change intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 148 ++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 70 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 5d8d102ef397..d592512dda63 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -306,22 +306,6 @@ enum cdns_xspi_stig_cmd_dir {
 	CDNS_XSPI_STIG_CMD_DIR_WRITE,
 };
 
-struct cdns_xspi_driver_data {
-	bool mrvl_hw_overlay;
-	u32 dll_phy_ctrl;
-	u32 ctb_rfile_phy_ctrl;
-	u32 rfile_phy_tsel;
-	u32 rfile_phy_dq_timing;
-	u32 rfile_phy_dqs_timing;
-	u32 rfile_phy_gate_lpbk_ctrl;
-	u32 rfile_phy_dll_master_ctrl;
-	u32 rfile_phy_dll_slave_ctrl;
-};
-
-static struct cdns_xspi_driver_data cdns_driver_data = {
-	.mrvl_hw_overlay = false,
-};
-
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct spi_controller *host;
@@ -357,6 +341,17 @@ struct cdns_xspi_dev {
 	int current_xfer_qword;
 };
 
+struct cdns_xspi_driver_data {
+	const struct spi_controller_mem_ops *mem_ops;
+	int (*transfer_one_message)(struct spi_controller *ctlr,
+				    struct spi_message *msg);
+	int (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
+	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi,
+				       bool enabled);
+	int (*init)(struct cdns_xspi_dev *cdns_xspi);
+	int (*hw_init)(struct cdns_xspi_dev *cdns_xspi);
+};
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -794,18 +789,6 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 }
 
 #ifdef CONFIG_64BIT
-static struct cdns_xspi_driver_data marvell_driver_data = {
-	.mrvl_hw_overlay = true,
-	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
-	.ctb_rfile_phy_ctrl = MARVELL_CTB_RFILE_PHY_CTRL,
-	.rfile_phy_tsel = MARVELL_RFILE_PHY_TSEL,
-	.rfile_phy_dq_timing = MARVELL_RFILE_PHY_DQ_TIMING,
-	.rfile_phy_dqs_timing = MARVELL_RFILE_PHY_DQS_TIMING,
-	.rfile_phy_gate_lpbk_ctrl = MARVELL_RFILE_PHY_GATE_LPBK_CTRL,
-	.rfile_phy_dll_master_ctrl = MARVELL_RFILE_PHY_DLL_MASTER_CTRL,
-	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
-};
-
 static const int cdns_mrvl_xspi_clk_div_list[] = {
 	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
 	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
@@ -844,23 +827,23 @@ static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
 }
 
 /* Static configuration of PHY */
-static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
+static bool cdns_mrvl_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
 {
-	writel(cdns_xspi->driver_data->dll_phy_ctrl,
+	writel(MARVELL_REGS_DLL_PHY_CTRL,
 	       cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-	writel(cdns_xspi->driver_data->ctb_rfile_phy_ctrl,
+	writel(MARVELL_CTB_RFILE_PHY_CTRL,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_tsel,
+	writel(MARVELL_RFILE_PHY_TSEL,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
-	writel(cdns_xspi->driver_data->rfile_phy_dq_timing,
+	writel(MARVELL_RFILE_PHY_DQ_TIMING,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
-	writel(cdns_xspi->driver_data->rfile_phy_dqs_timing,
+	writel(MARVELL_RFILE_PHY_DQS_TIMING,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
-	writel(cdns_xspi->driver_data->rfile_phy_gate_lpbk_ctrl,
+	writel(MARVELL_RFILE_PHY_GATE_LPBK_CTRL,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_dll_master_ctrl,
+	writel(MARVELL_RFILE_PHY_DLL_MASTER_CTRL,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_dll_slave_ctrl,
+	writel(MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
 	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
 
 	cdns_xspi_reset_dll(cdns_xspi);
@@ -1231,6 +1214,31 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 
 	return 0;
 }
+
+static int cdns_mrvl_xspi_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	struct platform_device *pdev = cdns_xspi->pdev;
+
+	cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
+	if (IS_ERR(cdns_xspi->xferbase)) {
+		cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
+		if (IS_ERR(cdns_xspi->xferbase)) {
+			dev_info(cdns_xspi->dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+		}
+	}
+
+	return 0;
+}
+
+static int cdns_mrvl_xspi_hw_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
+	cdns_mrvl_xspi_configure_phy(cdns_xspi);
+
+	return 0;
+}
 #endif
 
 static int cdns_xspi_probe(struct platform_device *pdev)
@@ -1256,17 +1264,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (!cdns_xspi->driver_data)
 		return -ENODEV;
 
-	host->mem_ops = &cadence_xspi_mem_ops;
-	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
-	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
-#ifdef CONFIG_64BIT
-	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		host->mem_ops = &marvell_xspi_mem_ops;
-		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
-		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
-		cdns_xspi->set_interrupts_handler = &marvell_xspi_set_interrupts;
-	}
-#endif
+	host->mem_ops = cdns_xspi->driver_data->mem_ops;
+	host->transfer_one_message = cdns_xspi->driver_data->transfer_one_message;
+	cdns_xspi->sdma_handler = cdns_xspi->driver_data->sdma_handler;
+	cdns_xspi->set_interrupts_handler = cdns_xspi->driver_data->set_interrupts_handler;
 	host->bus_num = -1;
 
 	platform_set_drvdata(pdev, cdns_xspi);
@@ -1312,19 +1313,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		}
 	}
 
-#ifdef CONFIG_64BIT
-	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
-		if (IS_ERR(cdns_xspi->xferbase)) {
-			cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
-			if (IS_ERR(cdns_xspi->xferbase)) {
-				dev_info(dev, "XFER register base not found, set it\n");
-				// For compatibility with older firmware
-				cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
-			}
-		}
+	if (cdns_xspi->driver_data->init) {
+		ret = cdns_xspi->driver_data->init(cdns_xspi);
+		if (ret)
+			return ret;
 	}
-#endif
 
 	/* Optional to keep compatibility with existing devicetrees */
 	clk = devm_clk_get_optional_enabled(dev, NULL);
@@ -1356,12 +1349,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-#ifdef CONFIG_64BIT
-	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
-		cdns_xspi_configure_phy(cdns_xspi);
+	if (cdns_xspi->driver_data->hw_init) {
+		ret = cdns_xspi->driver_data->hw_init(cdns_xspi);
+		if (ret)
+			return ret;
 	}
-#endif
 
 	cdns_xspi_print_phy_config(cdns_xspi);
 
@@ -1404,12 +1396,11 @@ static int cdns_xspi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_64BIT
-	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
-		cdns_xspi_configure_phy(cdns_xspi);
+	if (cdns_xspi->driver_data->hw_init) {
+		ret = cdns_xspi->driver_data->hw_init(cdns_xspi);
+		if (ret)
+			return ret;
 	}
-#endif
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
@@ -1419,6 +1410,23 @@ static int cdns_xspi_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(cdns_xspi_pm_ops,
 				cdns_xspi_suspend, cdns_xspi_resume);
 
+static const struct cdns_xspi_driver_data cdns_driver_data = {
+	.mem_ops = &cadence_xspi_mem_ops,
+	.sdma_handler = cdns_xspi_sdma_handle,
+	.set_interrupts_handler = cdns_xspi_set_interrupts,
+};
+
+#ifdef CONFIG_64BIT
+static const struct cdns_xspi_driver_data marvell_driver_data = {
+	.mem_ops = &marvell_xspi_mem_ops,
+	.transfer_one_message = cdns_xspi_transfer_one_message_b0,
+	.sdma_handler = marvell_xspi_sdma_handle,
+	.set_interrupts_handler = marvell_xspi_set_interrupts,
+	.init = cdns_mrvl_xspi_init,
+	.hw_init = cdns_mrvl_xspi_hw_init,
+};
+#endif
+
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",

-- 
2.56.0

