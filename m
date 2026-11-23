Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795431150;
	b=Pdc82HQaPDF3TnYgQK5bK9FYo2GNrCENH+bssBoHBv0kVd8H2r1HVKQdI5KXO4PQV1Kt
	 vLwZd/ihqGMVy8gVjLoctSllK4qZ1+qIRowaCnFmQTTunqZBtmblHyBry6tw9TDos85iq
	 hFoIkBrHRNLVGsFSJ0GxoFy7aSyKV3PFk4je10+gLrAHbggIoGJip5AMyUZhtxh7SFbeV
	 WrZSPhux0/GTyrA/6ln0/kmvMD/d3mVW0SsPmzHrwteLUqKJzwIkxIgBQv1AwvjRuPlfw
	 EroUslfHHMAhrx0qsCPsCmoB/W2XfBGXdOqHHz2HIpHvTMcVNildT2B/x7cTJ1jYIHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431150;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UvAFfknvI+izp9Zmn/AK3OjGOk9DrjWXazqWo7j6VTI=;
	b=eKcq3ab+0uz+27BvwbsG3W4ODkWS/V7BAzOB8UNAlVluquSn0xPNRhEgkmlZZytC6Kfc
	 eqQ0LCRoAMjkh1ZfItjHxs4ML3MdAiKnd89QSYDMTwCSP26UDo+9kDQRoaj/5qBTEYQYL
	 a1n0lEJZ0QxiNTsmJWzDPBM9hLq1Rj6mpxX9+QAM9Nq3sfki/PHYFVwBZwvTIxWURAunL
	 F4rUJ1xBC6f52SG0XXK1Iya5IwlRjHTYsP5VBzkbhDVCmfCsBLNIBBy+9ISXqtOgToib6
	 3bru1EmyJerbrObjdM0NKaYthei71k5xtmTIiZRB3SsnYiqiUMuadzPJfdU5/aZNpdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=WKEwTzuB;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=COF9PT6A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38355606A31A;
	Mon, 23 Nov 2026 10:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38355606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=WKEwTzuB;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=COF9PT6A
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9GQkN379194;
	Mon, 23 Nov 2026 05:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UvAFfknvI+izp9Zmn/AK3OjGOk9DrjWXazqWo7j6VTI=; b=WKEwTzu
	B/bWWQ1FY/W7TxiTQKVpLjKoCr+xOl8eGnOEoASyPyUed+viWOv0gkiTBP1dNHY0
	50Teof+ktHp5XVPB4mJuP2lZMJCemOXrj8zGB2jF4d89oVFUNJ32xS86D34/dpN5
	oEi48Sx4u4ctPPSjcwv3ph+9OMAUbad2I7q3lpvB9p0F/m/WE+kVViJzCL4bN/oX
	SsXRsx8BIhWXW9nvr0+2P0TxJysZ397PzTb9y6acpsQBggg23iX3m0QJ682bO7L3
	ZROVd2c486DG/q/TU1HaRyx7ZzG3g7XFtSRKLLmPKuz0BCf0ghsX9DNrA/Xyu1jK
	WmOXQHhpw0eT75Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UvAFf
	knvI+izp9Zmn/AK3OjGOk9DrjWXazqWo7j6VTI=; b=COF9PT6AY8LUigZnLhVs9
	1B6CkSNhgq7dKE0Ztvwi69IqcLNHecQ7T/RM2eirEtWUlqswxJK96/Cm5vBQm10y
	iX7D3RCMKxhhgDVrSfezRjkmePnnVo74pLJLobLQhxwkNGtpEcIvSa2EykzC3mmW
	4G9dS7Gx30s8Ho90D48ZHDNvt/ZBf0+6OIIO+lL6rFWBwZ4bgshfsvznQ5fwgeBC
	gddGLUGc/8h+TjKtPNOHmJAzZRSWMCytcqZ6i+uTH4banhBFfcSoC6TtPw21sZIH
	TcY58j5gVSJD6lVinCKqknlK3rDdL20eAnqVk/LmTbEOBbbnH48pKtQ+s2FAd1h5
	w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4cb9t32f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 05:51:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8O0FXmOVpFXOdzxOVpK46AlggBI8yAPG8yEWn4OS9tcRj8pcGjF0OhiZahCBOO2Q3m2X1ojQWpZjcLYqQmJ2K5PeVGagl2CimxCbEAIPW8x578PheWyENYtcKqFeeExy22CixxKnYwDqYNJVS7q9weOOZ6XceWhFne3MbUTFntm0+3NdQ7Vr0TeF4QsoaAjo6jAsk5uAhUxi0+D3/dPR/b351Dv3Aa0xKVpWf94yse3LG9O3I1QI5dyi4WFYpaCmQhIIoRRhjEbCeZvkUgFF6qGR1ZMcFJBXC13eeGOjIg1WEzhnJ4DCqqfPy4Kc443sb0yK/a16BUKBOsnWKAhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvAFfknvI+izp9Zmn/AK3OjGOk9DrjWXazqWo7j6VTI=;
 b=kXT8a1mQ0mzmOq/SsTD2Gdw2H1fi4EWbE6+R1gtUaFT2Kb8unPIVPFNtEKbR+OKE/MskBw8ddjvnAHeygA6mGdqHKbSzmjqXbrEHRnSDlhBUIpY3304FVQy3PI1LLNzxpf3wvmGd30IekcYGNLjXqCLJegNVNnk2vwZVLAkMHTueB+7Gjhbk7zuIYivpLJS5kw91iNH6HQODeoOopr+mGZUR0g5pvsTjcZ2O5KXb11bf8JIKkIxRxYFJ0crANOEOgsgi0YMH6p/Wk0C3A0iLnYWyBgGbzThmOsSw1QWm6K649xMSg+8v7R5NuhCBr1EWXJEDXPvIg6gFuo/bHL7ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB989335.namprd03.prod.outlook.com (2603:10b6:510:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 10:51:48 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 10:51:48 +0000
Date: Mon, 23 Nov 2026 10:51:37 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>,
        Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 0/8] spi: cadence-xspi: add ACMD mode and ADSP SC846
 integration
Message-ID: <awQaPZuUenpHOg_k@nsa>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <av1u77DUXulwvkZr@nsa>
 <3c500623-8502-4d67-b53e-1f712ebb15ae@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c500623-8502-4d67-b53e-1f712ebb15ae@sirena.org.uk>
X-ClientProxiedBy: MR1P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB989335:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e9f674-f80c-45bb-9275-08df494fc5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|11063799006|5023799004|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y3OMrB5AASRAnicVYohu3fxLAFkLq0DUI0hUGKjDkCfo6+di2ZbVX0i2hUyBYf6x/EVUkLaVIYk9kMoLXBIfEoCOqYeHt5/KHeoDJ7A8TK93hDjom1JvglmPICx7Tzqj+/QHv/to6RCAmhN1QsXemHcuhHLviXVfccf7qDwH1zLpKWLJEbOlKjLWJbSBP95YktfSD1HqnfxA+n01SXrDerd2My/lCBmLVZTn7s0EVm6LGfT640CqUvV5oTa1ZnM12ozimbXZvBC2Dr/2rV3CchDGkbtRd4chIpfMFihu2YqCsixReM/38ZzY/orEr1bh/RFFeF5d3/lEDCsHbKlDUEGrNnq46BuW8XkZPhqamkZ6vMYFTp1kYjInnLurVCpU9FMSpoNV6bfm6xiMtgorTqGL90AMOYEiXkI55zmdf6MqPHgEDy+lpSXXeC8LbYv4xPJ/iab2DmcaLezEbLVAYdZ+ABGEtW/ZD+pzCaL591hclwiMAB2ymrXrReFJA8383JY9Gd/7GovWraBYMdGvlybZTbwfECqw1+qjTGQBdR9rjdwJ64YpG2cHhh7JEDP1pGfeaDXb2QO1xCX+0u9rlMnCiqDEyN88dnKiRpS2MWsdySfNoOTBFQn9cTPzm5oA5vZzk+/CiINdLxFGBTO8VQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFFwSk5kUGp4dUNHeHhjMGF5Qm1iU0Q5SHkzSFJWMnNaNDJTd3FhRmJ6L1dR?=
 =?utf-8?B?di9iUHN4VWVEYVVkMWFTMEFUdnJZYmdwaGlhTGV5Y3d0YmVoeWFMUWF4WFhI?=
 =?utf-8?B?RHJSVkozendlRnlPanMwYTI2V1lKSEY0N1c3ZTJhaG1Lb3RnSWlpVDNjelVF?=
 =?utf-8?B?QTZaenhXdjFFdlF5NDloa25MS3NZcDh1THFVcDRvclpPTy9mYWVyc3hGSTZM?=
 =?utf-8?B?VVdaVG94dWZmY0Qxa25ldWlNSHdHMmR3TTNpT3B3RkdjYjl6STJFYi9tMFFW?=
 =?utf-8?B?ckpmYjFmREhJR2VITTVmWmpxNmtMeWlIK1B0T3EzWVZodW91VjlKR01LblAr?=
 =?utf-8?B?OGo1MnpTUFVUeFFwUnViTWJzR0NBaElNRDhNcDlqSk1JL2taMVptR2dtQWpD?=
 =?utf-8?B?cG1La1VYVWdtOXpvTzJ5STkvbjRJRDl4d1grWkxqTTBhTmE1Szk5Rm1LMjh2?=
 =?utf-8?B?eXVmYlhXbzBxUWNOWkFtM3d3Mlgvbkdybnp5aFphNlZ6Z2d5Tm4xbkFaQ2Jo?=
 =?utf-8?B?Y0V3MStXWGVNb2RHZkVqUmE4Y0dwMDhCdE1FVlVYSUNFTzdlVkJReXN0eGZ5?=
 =?utf-8?B?NVVkN2d6d1dLV3pKYXpVaHhJRUdiZmdSRFJldjhSVDZySmpFdk9XckExTFBr?=
 =?utf-8?B?NFRMZkN2aEZEM3VlbHBTMlNjcndFL0VhK1c4aGhJbjQ3b3hjZWRUT0pFeU5z?=
 =?utf-8?B?ampSRzc4ZnFocGpmVzYxSlQxYm96TTZPWWZxVEYyT0UwQW5xS1RER1lWeDJW?=
 =?utf-8?B?cWNiMVk3Q1pYNnBCeTE0T2hJWVRiRUsxNE11OElVOS9TZWdjQnVoazgvek9n?=
 =?utf-8?B?dG03cWtFYk1iV21PejhNdklybzJTNTU3ZHRKeklnMnRCei9CV2ROYU1RV1Er?=
 =?utf-8?B?WXRzUUl5b0tjYkRvZE9FMXBaOGlsTHpRd1kzUkNvOFVPV1lFNG1uS1ZXMkx3?=
 =?utf-8?B?UTJUVkxlVm0vWGhuYVNLTERMVWVDZU1wOG9IQ0xMelpRc1VHdGk2UWFUU0xL?=
 =?utf-8?B?bzdidWhTWW9LUHRsREUrQXVUQVNXZkE4NTNtV2lDemg4b2RPTzJLRzYvVVZV?=
 =?utf-8?B?MXF1ZG04a0JtbVFqbXdVajRlc2VFZUdhZEhIUjllUm0vL3kvRDZSdURnM1pN?=
 =?utf-8?B?Q1Vxazl4bGlReUllT3ZpaGNwN3ZDZi9wMTZUdFpNeVJwSWtJc3kyN3NDSlpQ?=
 =?utf-8?B?Y3ZQWUNpWTRHQjJvOEFDbkE2UDdXbENYbGNWSlVnRFZtN1NLNDR4Q1Vld1FD?=
 =?utf-8?B?SnZIYWlDUWhKWFlad0wzTWtUQ1U4N1BBRC8vcVZlRzQvaVpaRXRmOUkzWnFh?=
 =?utf-8?B?VXMvQmxzTTlMVUJyRzhSUjVlNFZUWmNzejV5S1VRc20zMGdjYXVZUU5uc1Y1?=
 =?utf-8?B?MHBlSExWQTNBVEl1N1dSc09XczVVQ0tvVXNEMHRWVWFBTjlXZEMvay9uQzdx?=
 =?utf-8?B?U2ZoRUlDN2JEUnJhU2dFcWd2cFBmcElCbWtvbGdKMFpJNm1LTkticWp4cGxk?=
 =?utf-8?B?VExYazNndEN5ZW15V3ZUeEcwL0xCbkFKSCtKNi9uU2xoRVdQSXRXakNqSEV0?=
 =?utf-8?B?OGJsM2hrWnFydmMvYTR4dFNPSGt4c1FNYXJYeWRJRWpSb3VFTEtqbnFPbXZt?=
 =?utf-8?B?UW0rOFphSmVISmhVb08rWVQvcTRhNHBhKzNxTVFKZ0x5cC9zRndRT2NuNmRW?=
 =?utf-8?B?ZXdIK0ZhNXVlM0t1NGNKT1U2TllHNlVsY21Va3cyeTZia3N6VngyVlZwb2s5?=
 =?utf-8?B?ekZOS05jN3oxT0dwbFdSbWNNMU5LSUs2d0NjN29tUUF4UmVVczZrUkxGaEEx?=
 =?utf-8?B?UXZCR285V2JHS0ZBZXM0c0hZb1FmVy94VUJLYjUyV0cydXZ0WjJJYWVscitZ?=
 =?utf-8?B?OXdTalNISXFjUk5iYkJNTmFneGRhZEQ0ZE5FdStPdUV0Q3AwdER4YldpTEJx?=
 =?utf-8?B?UkhKM3B2Wlh2WEI1d1BnS2ZoKzhTbGx3ZHFwYTFvMEMxYWppOXRVNzJ2b3A1?=
 =?utf-8?B?SmljY2pkZGFxcVpPVWVsS0M5SkVQNGtWdUs2Rm45WGd4dGJGejJGSWNtK0E1?=
 =?utf-8?B?V0F4UGdDUHVCUG5PNVlkVXlNdjJRQmEzemJnUUhzZ09JcExGeEI0eGphaEk4?=
 =?utf-8?B?cXpVSXZseGd0TE10SzhxdEZTRjRHK3V1VTFOaG5jcHA4dFlqMG4zVnR2Mk5T?=
 =?utf-8?B?L2ZVcDZ4VTBMVFcvbjBFSWlMcTM2V0pDc3B5MjRrM01vdlFBT2cxcTNYZ2FN?=
 =?utf-8?B?S2x6QzhLdkpFTFQ4SGEyRWNXSFJEcUV3L2JBdyt1SkZ4SXhaZ3ZkNHVlbE93?=
 =?utf-8?B?WTB0dVcvQU1LRitjMFFUS203RXVGcVRSTGk2ZEZKRGlHNmRIVkYwQT09?=
X-Exchange-RoutingPolicyChecked:
	D6VWsAiE1+cMwtpz3yG6FCSNQmoSUCdhQ57FVAae8KVmZpR1Ke3r/3NCf/Jn5pAikDvCBmp4MiG3JV48rAuZI1HPRGW++5DDHVuu+nvIc/EoHFcQG7YFkeimU/BP3tFM4px2E5mB1TQ4woxPpKR+cR/mkkZ1WWAGcakNqelh2cH/1Y38WjzWYi7uqU2XCVDB/+ohpsxZUU31e56LxCskGdoazbYik6jBd4M+l6t9O4M28uBg98LnY1GGF6yBjGR7pUvni8RVPXiFSaqQGj5QvdmeeSIUo3QigSaif8fUWuPHg4tuqudkAMSpKPUQ5frLwY/oimyHQIn9f8EFx4n4sg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e9f674-f80c-45bb-9275-08df494fc5d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:51:48.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZGfKEww0jjCVNKmuU3rRtrT9h2HnxpFXtiSQiKYkG8el51uhvq4EQqAWSbWpj6StpE+WshmFm24+PsB5WlWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989335
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MyBTYWx0ZWRfX2yGB2kB3GXTh
 UaXSx2B9knExzDISJMzqZyQTHd+5mTlycK5Kaj2KN7Ik36DXvQXLlEqEhvAPpwSbVq6MNw78o0n
 AWkcDNBRA84kzmda6af5SeD8uLF/N6yeZXQfA73IQukdzd833R0CaAt2ijSh/Dcnrur5Souc8jm
 t0Kr8nFcxeOLP+Xfc6T0tAm2xTuwJmQB3tHw2HtHOSi9W0ulSlyy01wts3p55CGhEM5hkYRGBgt
 HrbWnpREQxUlHZxtUVWA2U7N5P4ewkl3dB/BDTbMeYdlc7wHLpl9HnLnlsP8I2b5MCSfOkKqqZv
 r5Mp3fZLf6kPbOUXyXaB7gCyDOPpupdKRffKVjPcLIJMYV9qoqEmnvijInAf0P5ZzxJ71L0+onQ
 IQm1nCPsDwiqyuil7GgsGavPoFyaNQF5X1k1eJemcOn4zRXV8OukrKi0DoKlwWnKKadyd23POox
 ig3yEREjI9ZWEjYTInw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MyBTYWx0ZWRfXzkp6332Nn8Vf
 6kCY0Rqn0aQpuoSOtkXht3xoKxIE68V1IT9dGs0N9UKLvXcQTzJnTrckWh9O1f3ZsbBvAOiPlvO
 tLMuoKUKh6/87HxSw6ccL3Ky7EQgahjupFBR7w/BEEwN0jAP6glQ
X-Proofpoint-ORIG-GUID: KhRja0tPc2kwZITnEk73oNQi0975-AE8
X-Proofpoint-GUID: KhRja0tPc2kwZITnEk73oNQi0975-AE8
X-Authority-Analysis: v=2.4 cv=Tu5zFzXh c=1 sm=1 tr=0 ts=6b041ac6 cx=c_pps
 a=S6sZQAOjBorY7schPX32og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gxlg_QD7mWfs-hPzMMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230043

On Wed, Nov 18, 2026 at 11:34:52AM +0000, Mark Brown wrote:
> On Wed, Nov 18, 2026 at 09:26:12AM +0000, Nuno Sá wrote:
> > On Wed, Nov 11, 2026 at 01:23:01PM +0000, Nuno Sá wrote:
> > > The Cadence xSPI driver currently drives every operation through STIG
> > > mode, where the CPU builds each command and drains the data. The
> > > controller also has an auto command (ACMD) mode where it runs whole
> > > sequences on its own and can move data with its internal DMA, which
> > > pays off for bulk reads.
> 
> > Not sure if you still plan to look at this version? I assume you also
> > expect me to rebase this on top of the current work done by Jisheng.
> 
> If there's some reason to rebase please rebase.

I just expect things won't apply cleanly.

> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

Sure, just asking because you could be expecting me to rebase and send
again. It's almost two weeks but I'll wait till the end of the week
before sending again.

Thx!
- Nuno Sá

