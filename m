Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E7499F2E;
	Wed, 23 Sep 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167014; cv=fail; b=G5MBMA/dE1WsGKIfDsSRpXPHKAzJy/RwPMx7xiYkJqsAxofp5YD28WfC348QhTGnP4JetTYoEYQep3LAoyqCAg81LXLgk9w49zEmsCn0kFLfGacAlWm0XjSX8vLVYqasSIX60JhHEEQxq3IjnWCFbN3A/WW1NNMoabbnRNm2zTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167014; c=relaxed/simple;
	bh=AULKQBkbk6oEpX8zEicPfl1vX8ZiYH9CQP4Wago3ZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1PViLjHZ0aemSwSb+VPugjJu6544ZT/p9EcLjtDUoexgiHL6fY+3IpAqYW+xM0pF+6n64+jRS8WpHhc2LuuPgUk4e/byiONr7XsCC46XGy36WMRBQ00DiuW0+FfWePHKTK7yRg14zSKx/5/zVrf2zvvPci/rzJFi928MYANimc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jx5V1P+n; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jx5V1P+n"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCBK5P651675;
	Wed, 23 Sep 2026 08:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tbX+l
	fojhyTh9EFOjzwEBlHdlfwpASk3k9CCeU9dTfw=; b=Jx5V1P+nfJbdcY0wGlMsS
	3EpDAWtsDIONeonyYwTdTv351zJMrXoQx6qxDnHMQ60GOnUss3Kq5f39orNY+Sio
	Q+3LOe+2uOwzSeg9gCCN+/shEog1pnTB7kp1sfFzDg3t0EaaQJL7sIWKqcXK9o3K
	9KRrj+8ugCDH7AgsyG/oCGfbiNuqPLBVMYsws9GuffpL/hj2R0TcA9sb4mbQwfvL
	eijfsJ+YhreQas4iDzm567nN0QprVbTM6pBstJGLUVbEHfl32IjHKEsfg5s0ky9K
	DwU4UhY6ZIZp2SW9vFifME6QhsFvngLotYKUSLh9+D/bYby10shR0k8DdxpQqPc2
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gv5n72qyw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:36:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avSxlTJk1Ms8E4tZBI6KhAFN/5q6UkZwUU0S7F+LsQbSGlLrPQCiNVYU6P8VhmJytYm2GCCTpUJyGchKjSualHebc3imlUU/mU9SQ/QsYcspVf22vFFowo9jeRLl/bts+xVPGA4R2fkIXi2pUH7kZk5DV/g01Wr4yrYS/Tgnf0mnqxQr9VnNHfwNbSJNELiWyGGEZvuZV2FYwc+DoLbsYC184f8LOfxUYUlrMiYHXuBzLjUwY8DOB/Z7hEhrgDm4AsSNKgjcNIeBOZ1FnMTb1JKmw4MHBs/s9sxnBomCtfdbOXFR5PjP7HQ9aJPCtVxzzkT0bOdgPabS4fm5CivXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbX+lfojhyTh9EFOjzwEBlHdlfwpASk3k9CCeU9dTfw=;
 b=u5kOzKCSzH3Z/OfKwpVdVfybkSFOhmEcOVy/pMqQkcKy2yKxjlh57xqdGoYKwRzhZ/y+BYHOzWAlJVNis9+se/RsgS+rBFn18jmlcM5oBZFj7UfZyzTr7vM75vrtj6Yer4d5Qyj+/qtn/TKlsIty4fBHSCLYNyywGUVqp3P8/HkoVNzWJBOizbCx2YbocciMC2Oh26xlO4xb/6aVESfyKoPCuHmkRtwyjbiKB+DPQiTfrK/Tj5xqnRiYbmcwU+KfpLwyCiUV8mTjAr4uXMKRBmpyA4rL/p4Lm7MMqoUZ6nijNCXycmlqTOxuWRn9vh3035A5tOCHeEsq2rE7XNI2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH0PR03MB6113.namprd03.prod.outlook.com (2603:10b6:610:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:35:55 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:35:55 +0000
Date: Wed, 23 Sep 2026 13:37:12 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Xie <fei.xie@horizon.auto>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Message-ID: <arPFeKTafhftz9yj@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arFEjzkHGMbecWWV@sirena.co.uk>
X-ClientProxiedBy: MA3P292CA0022.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH0PR03MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 680c18ad-c411-493b-4b75-08df196f3621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ulRPhoVfv2Imj760Q+nBa0sE+1Xi1FNbHkNSjutkIkN6+o3qkdUxZzrtKEQIqzUIncBoAIYCn5pvZQq8gdl2PKvHUfh144B7HXXV9+UlRIKla3usQCwZF3082GazRjTv9T/F/LntK3T741W6acfmfuNwBgk7IZVmbpiqlOP0kj5+fg8cjX8FHb947u8tsleUmvXwP0fNkCFoxSVdVW+lPpteH0tsEbxmQn7d9sCoggA23zggARu6/QSBT9MIPA3H79XSdScKWmnZnBJy80JAZkEZtNKOXwGKYjoK4E/5HO7cScvYyuwfIVY5AZ/UHRI6G7+dnTM4Ef2fTF7OcYKvDJ1mFvrr+o8MhlWJjttT9dGeLx/LQJHyK3JoILGlilb20YvKdb55ZwOLA38cxDHgv5fFD1EIM9Pk52faKMouWSpKLZ/J08Ai+LmSQFY8wpA7Y2W0xECkYJOfWiDlgSQ4QWJu/kMYztK26kMKr3SpV0eO/UMJpCQUKOHp7/vPCnnKV4bZiRFyOr8JIDW1cHEL75A8/IYfFvLQ78Hhjs1m1Rcr4vqqyvot/cvtT3d2KVEj/yZ5COSgkGQNyBezZ3I+4MsYLx+HnkgF8jExi/LAzZftk+WF6mN0OvCW7dJ8jBJYpbA8wO3lWtUvIAbPx4L8bDvYiCZz7RllLBfb6OgT5LY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCt6cnNWQmxIMzFZL1hlNnhNaXhBYmt1a25wdXNCNyt2THQzdjJhOWsyVjds?=
 =?utf-8?B?ODZDcWJOM1ErVldiMXpDNWovdWRhYndhUkVqZnhtWXp3bVZCMSsrWXd3SXB2?=
 =?utf-8?B?b0l0R0FVK2xPc2c5eEFIdHFCZ1ZTUllORVc5NWt6SVh4U0JMUnpzTWtWRFkz?=
 =?utf-8?B?dHhrU2RONWpxMHZ0aVpmRTBuOFNFZXVOYXJ3MHRrZmtLcElqRXdRS1I2N2pG?=
 =?utf-8?B?eWIxNWptaUx0cEtmVjc4L0NEN0tVRk52dmYzNDdMSnpPVEVMSDB0b3ZreUFZ?=
 =?utf-8?B?R2sxNENyWW9Ldk5HcmUrWVoyeTdlYlc4VTNBUUpyL3B4aTlIYVBVblU1RzJ6?=
 =?utf-8?B?by85TnhiVEJQSkxwVHR1enNySXltWE1lbVl4V2xXbHNLR1pqWExYN0taYWFz?=
 =?utf-8?B?NVpORUdSdEV0SGVyTWZLUkVlbkJ1NHZiL1lqTGhZNS9PeDdNWXF4NjFBc3Bx?=
 =?utf-8?B?NTJ6MzlHZkJFQWZNRVgyTUp6WXV0bTBidTFOVmpQVDhrUWR4QVBoc05qdDly?=
 =?utf-8?B?TUZRZFVlRS91TkVQc2dnbkIxOFUvK1lMQ0N4eHZaclB3cXV5VlZ0bU1ITFYw?=
 =?utf-8?B?UDl6M0N0MWw3aEZwaXB4NVBBSW40MWViY3VXT2pqT1BsczIrcG9abTdMU3cr?=
 =?utf-8?B?NWt0QW1zMW1mV2NzclJuMkdabWNPRDlhVTBBWE90cjJ6Q1hZWXdIQm1ZQnZy?=
 =?utf-8?B?clZndkpuUWF5Rmo5KzJTaFgwS3dPUytxenVpOGttcUVXUm0xQnVETStrRUh4?=
 =?utf-8?B?M2ErT1IzemJtVEh5dDVibWJEc0dHMHhITjl2eHNhR2pmM2d4VW9JSm9nenR6?=
 =?utf-8?B?TmJLNkFCVG1UMTN4UWNjaXBPSjF2OWMvVE45dTZIYVh1UkpaV1pMY0M1WTVT?=
 =?utf-8?B?SHdHczBmcTIrRisxM0NVZVIzc0FQUWU3My9zYjZVNElGMzVkb2w5RjY4bzMv?=
 =?utf-8?B?akNPZitVZ2wwVzFJN25qMVpuY3ByaXJ6QjQrcmFKSTBvRXY3aytXaHNISnJL?=
 =?utf-8?B?Vks5NnpHSTNsN2hZRlpvcTd0QWxTTlNKM0NCZVpHcGRQK3RqTVZSSllZeVdv?=
 =?utf-8?B?b1ZFSXRnVVg2OE5hU1A1RDhKOGtQaWJCdWM0aUFhMnhFREl0ZVVNd1o4Y29x?=
 =?utf-8?B?Y1VCTmhUSjFVQlVRMDgyQzZzNkU3Tnpyd29HL1YydTF3ZEM5ampiaXZ6UlVG?=
 =?utf-8?B?RnpXSDVVb1ZOU2swdGEwaG5WMm9LUUlPamRNNGRhNkcxK0lRQUJLeitGb3ZL?=
 =?utf-8?B?U2dabU5aNkd3WFgwOUFXTE0xOTJ3Zm13dVVTZ05TcytrRUdkRkNzVDg1bjdS?=
 =?utf-8?B?TXMvZzFqRjlNdEdLWnY1Ujg3VEVLWitZSjh4N3YxWmVKTngycVNSd01LTVVH?=
 =?utf-8?B?N25CZlZuZDhFMVZWdFUvNGVDazI4b2kxZkVCQ2FTc0FEeDVrd0I0QnRMQUox?=
 =?utf-8?B?a1NEZWdHalQ4KzVyNHY5Nm8yRzJGTnpubDhXK05hS1pDUVRoQjIzaXNON0Ru?=
 =?utf-8?B?RHpVOG9UMGFLWXdWNmV5dVUvbEk2L01oZG14S0IwcnVKZTNBREp6NTQ0YVYr?=
 =?utf-8?B?R3F2TGovN3NPeTdFbjVYcFo4L2VKeVRwaUd4eGoweHMxaGtDSkMyWXZTTXRB?=
 =?utf-8?B?OEJaNHRxQlp6WHVwQ1pvUm5jT2RlRUZETUI0TGRJV1BsNXNtL3hQZlNBSS9r?=
 =?utf-8?B?dVloV1puUG8zR3NCSWhmbEtud1JrRnBhK2JtaUxyNmN5Z3BTTXJxaVlkbnFC?=
 =?utf-8?B?dm5yWWVMZkIrZ2NMWHBlZVdhWGRQKy9uQytGQnQxaWxhcDNOMmZEOEhDTTF6?=
 =?utf-8?B?VmFqSGt2SmpLd3FqTHZIdGI0djVNaURVeEZVMGlDNnBoOGNLTlRHdjJlNE1x?=
 =?utf-8?B?T2s2MUVSRENpYXF3NTFVS0pMZE5TNU11Y2Vxclpja0doMDJFV1M4K2ZWZ0VF?=
 =?utf-8?B?NVNrYlZiL3NKWDQ0M3BHckFyaE9Zd0pSQmlsRUo2SFhIaTk3ODBES3JsZzZ2?=
 =?utf-8?B?OFVmT1FZS3FOQUFYWmEydDVGQTFpdHd0NGpFZno5em55aHRMMGpsRHFnN0RM?=
 =?utf-8?B?dCtTUXdpQjdrYXZFcWJlZWU0SCtXUFBNcTR3NGJWTU1UOUtrSUdydFlRTldX?=
 =?utf-8?B?SlhHQWcveGpUY0tCWU04cVNBc1NBYXVrZlBBT0pvWUdJR0xNWk44VTJ0U1JO?=
 =?utf-8?B?L1NiUWZBL1pheUsxRjZEMkIxbHUxRjVieGpLYXdWYUMrd0REWGljUEQ5Yjlx?=
 =?utf-8?B?NlZyV0o4SE5HaTNLMWI2eXIrdGZla3dNNmtKTHpBaS84OFVFWG9xSnFITWJt?=
 =?utf-8?B?QVlnTDBVeFJobHhVanBMbUhPdkZ0bGJhUGM0OHdReGJmRkZ1cjlBUT09?=
X-Exchange-RoutingPolicyChecked:
	qxFL9TsqaFacCPugU+2PkCMUNB/d8vL3k0JlbvdmFVTxMJR9z+vRr4dudD+S5wzvETnqyiku0wmL532s9tok7Edcvz8dPJwZ04kPMLvLvIXjz4895T2iGodc0FB3g70CkRcbLUskAJgFI7hdWZc1whhZ3NHp2s6wY91Ev9QUcItTag1cfnqTrNUlCjuUqJCFdWUBHqvR03ejQKpQnDkijVl+2aqsVIqztMMKqQqs9eV/MsqAGXb9u4WD7KkVEGwvxxxfLyIin364jBl+pLynseOhcbPyXK2O9i61bS3T2Lhhm+rIX9EFlp/1U4pKrtGtceffYczO5irOGL0c7CQj4g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680c18ad-c411-493b-4b75-08df196f3621
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:35:55.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcABdcV9tRc1moPg2fIDUsYvT2XmkOH54GgX8w8Cu74vn2F4dvsDO9yf6X+yCkndK7okVoKXiYkjW13vLOAJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX/TJKUnW6fdNm
 3fiIh21zBKYLLZGdBOO6Xz1mTuOj2AsIweSD8FzAosqEonoMdtjlEAICNSRrYIeMOjQQeANp+Uy
 KlzHC9A6hudmJWRduvdtV0kqeD0uBM1Lc8nu6GTDArJHEbYPag8AjV+wbF6GZWGsqNST6EXWk+l
 c9wvmzOqmkzsb9OihzyFmUWMuWElAAD+zYdjflI+H7005ejEDrPpP84ErGN1NrXDpojQcvLwhJf
 wHFjoULvf9ktHMSeMIQt3o1K61KCj9a4+PRO2tj+DMUhL9fvyfe6h1KZpQoCS6C81KR+YVi4os9
 JPxUelyjkPJySifhjgudBliK6IAIgKxcDx9o3Dfzq5xorDi8ePjaQqWlF8cWK9xJ5zZRS1dXSLN
 KNmg0kqyPiER3raWdbWZplJ4f6LCIEbX5Yere5P2EM8h3fdeQqAqNVMp80/aK94gD9+tdm/Tkvo
 WVQZrcV7GeS7Vzn5s8g==
X-Proofpoint-GUID: XHdhS67x36Ss1GqSjex0gUOsWJFFr90E
X-Proofpoint-ORIG-GUID: XHdhS67x36Ss1GqSjex0gUOsWJFFr90E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX/xQMthi6SBUa
 hMmTfBPPkI9ZnJwMSSJWaq7uMv+H8lXGoccT/P0fhdLr5cYY8tDQNXDcgWCdVbdaD8WUrCUS5/t
 A+UpoH6PmsSYfHo2eg27MhbWf3lSsufaYwbGN0V9R+f+9IdYCrGQ
X-Authority-Analysis: v=2.4 cv=EKiTQFZC c=1 sm=1 tr=0 ts=6ab3c7b1 cx=c_pps
 a=feJg8xcwi6yo0k/5NfVkgw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=q8uBho_rRhyo8_7UB6wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230049

On Mon, Sep 21, 2026 at 04:51:59PM +0200, Mark Brown wrote:
> On Mon, Sep 21, 2026 at 05:36:59PM +0800, Fei Xie wrote:
> 
> > Add PIO master-DMA support for the controller auto-command mode.
> > Configure the SPI NAND read, program, erase, status and reset
> > sequences, retaining STIG for operations not consumed by ACMD.
> 
> > +struct cdns_xspi_acmd_info {
> > +	u64 row_addr;
> > +	u64 column_addr;
> > +	size_t data_nbytes;
> > +	bool row_addr_valid;
> > +	bool initialized;
> > +};
> >  struct cdns_xspi_dev {
> 
> Missing blank line.
> 
> > +static void cdns_xspi_nand_erase_seq_init(struct cdns_xspi_dev *cdns_xspi,
> > +					  struct spinand_device *spinand)
> > +{
> > +	u32 erase_seq_cfg0;
> > +	u32 erase_seq_cfg1;
> > +
> > +	/* SPI-NAND block erase is always D8h with a 3-byte row address. */
> > +	erase_seq_cfg0 =
> > +		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_VAL, 0xd8) |
> 
> CDNS_XSPI_NAND_OP_BLOCK_ERASE.
> 
> > +static int cdns_xspi_nand_init(struct cdns_xspi_dev *cdns_xspi,
> > +			       struct spinand_device *spinand)
> > +{
> 
> How much of this initialisation is parameters based on the specific
> flash passed in - what if there are two different flashes attached to
> the same controller for some reason?
> 
> > +	cdns_xspi->dma_buf_len = spinand->base.memorg.pagesize +
> > +				 spinand->base.memorg.oobsize;
> > +	cdns_xspi->dma_buf = dmam_alloc_coherent(cdns_xspi->dev,
> > +						 cdns_xspi->dma_buf_len,
> > +						 &cdns_xspi->dma_addr,
> > +						 GFP_KERNEL);
> > +	if (!cdns_xspi->dma_buf)
> > +		return -ENOMEM;
> 
> Why do we need the DMA buffer, I'd expect whatever reaches the driver to
> already be DMA safe?

So the controller can act as a DMA controller and issue DMA transfers
directly to the above mapping. However what I'm seeing is that the above
is pretty much a bounce buffer and needs details from nand chip. Plus,
as you put it, we can have two different flashes attached and then what?

So what I have (and I do not see any other way tbh) is an on demand
dma_mapping for the buffers we get from the spi_mem (which should be
dma_safe yes) core and so, no memcpy() at all. Yeah, we have the
underlying cache maintenance these mappings require but as said, don't
see any other way.

- Nuno Sá

> 
> > +static int cdns_xspi_acmd_run(struct cdns_xspi_dev *cdns_xspi, u32 cmd_regs[6],
> > +			      u32 thread)
> > +{
> > +	unsigned long timeout;
> > +	int ret;
> > +
> > +	cdns_xspi_set_mode_acmd(cdns_xspi);
> > +	reinit_completion(&cdns_xspi->auto_cmd_complete);
> > +	cdns_xspi_set_interrupts(cdns_xspi, true);
> 
> We have the set_interrupts() operation.
> 
> > +	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
> > +
> > +	timeout = msecs_to_jiffies(CDNS_XSPI_ACMD_TIMEOUT_MS);
> > +	if (!wait_for_completion_timeout(&cdns_xspi->auto_cmd_complete,
> > +					 timeout)) {
> > +		dev_err(cdns_xspi->dev, "ACMD command timed out\n");
> > +		ret = -ETIMEDOUT;
> 
> Don't we need to clean up the hardware if this times out?
> 
> > +	} else {
> > +		ret = cdns_xspi_acmd_get_thread_status(cdns_xspi, thread);
> > +	}
> 
> Does this need any updates to cover more error types?
> 
> > +static int cdns_xspi_pio_mdma_read(struct cdns_xspi_dev *cdns_xspi,
> > +				   struct spinand_device *spinand,
> > +				   const struct spi_mem_op *op)
> > +{
> 
> > +	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
> > +				 CDNS_XSPI_ACMD_DATA_THREAD);
> > +	if (ret) {
> > +		dev_err(cdns_xspi->dev, "ACMD read failed: %d\n", ret);
> > +		goto out_clear_read_state;
> > +	}
> > +
> > +	memcpy(op->data.buf.in, cdns_xspi->dma_buf, op->data.nbytes);
> > +
> > +out_clear_read_state:
> > +	cdns_xspi->acmd_info.row_addr_valid = false;
> > +	cdns_xspi->acmd_info.row_addr = 0;
> > +	return ret;
> > +}
> 
> Does this do the right thing for short reads?
> 
> > +static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
> > +				      struct spi_mem *mem,
> > +				      const struct spi_mem_op *op)
> > +{
> > +	struct spinand_device *spinand;
> > +	const struct spi_mem_op *read_cache;
> > +	const struct spi_mem_op *write_cache;
> > +	const struct spi_mem_op *update_cache;
> > +	int ret;
> > +
> > +	if (cdns_xspi->flash_type != CDNS_XSPI_FLASH_TYPE_NAND)
> > +		goto use_stig;
> > +
> > +	spinand = spi_mem_get_drvdata(mem);
> 
> This appears to be peering into the child's driver data without any
> checking that the child is what we expect, this could go horribly wrong.
> 
> > +	case CDNS_XSPI_NAND_OP_GET_FEATURE:
> > +		if (op->addr.val != CDNS_XSPI_NAND_STATUS_REG ||
> > +		    !cdns_xspi->acmd_info.row_addr_valid)
> > +			break;
> > +
> > +		if (op->data.dir != SPI_MEM_DATA_IN || !op->data.nbytes ||
> > +		    !op->data.buf.in)
> > +			return -EINVAL;
> > +
> > +		memset(op->data.buf.in, 0, op->data.nbytes);
> > +		return 0;
> 
> Are you sure the zeroing makes sense here, for example with ECC?


