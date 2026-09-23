Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF9417D99;
	Wed, 23 Sep 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166266; cv=fail; b=tRalosE2qyM1kEFYQt5L0kvpzQgDnxtAvjFdNBQVVRPIlFcYNkOBj5eMiKwDJdewi5I4u3OwU7P+yqBdqVyqYSNkvxFzfrh9m1R3qYxmlr4528ZWzpMqIlw8FH5ho2tJXHQKGlrdKlyQP9a/Q53nneUylmpG58110j7U69iPwnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166266; c=relaxed/simple;
	bh=coDgJ2xqgul9Jsd8VHuS+zCZQ3j+QI9R6Q/tOhcko7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rXb0725aKN/O228xHkE2b6g9BYrwM/LZdLcc9YcSNGylJVpWotLQqpeQSWc9doBtganNGd2B5BNKJTD38JRXxdtmn6Ddpa+bCWCJrH2eH4ADkVTxl6GqFi46CR1iceCtbx/RceN5dOMEUussm3jYrAbZ0bsniJvhVH3J2QaLdgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g+AZ5MGR; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g+AZ5MGR"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8HjiI2936814;
	Wed, 23 Sep 2026 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P/N9/
	6ml5hiUtI02dhjsoZcUBJ7KDSIfEEAyqYWuzWo=; b=g+AZ5MGRhYYcT/AspsJpX
	A1F6pHdV2ophZTBHMI/t5Y+dtHTgvG8M2BHI1lrej7Gp6NjtIfhEqaHysMarE1GV
	WtW4zN8ClFKVJjbhMqj1freqQmLirJ7SGwiUkPgg/wU2RlTdkrKLdGOFYFUwz/Zu
	HcK8C+VJbHtVNW8D6L243n3UAWNNBSY6fPfaDuY6hxs00u2oJVRl/PL/gT6IaUn0
	vNXWTxBOX/3KBlFx79VWamANYysked5hG1DApXJWh9IQXx+WUJusZdJQy3Jo6YR/
	/u6/tuEpWi3buAx7y7QEoGa0ChjcNEpIB0WFTFPFfqALo+esJ9Xcr7lE6jsbcLxO
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gvagqs4b6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:23:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4HDndf501oBBoGZVGPQN65JvFFYrfppzBOz9WS0CipArZ0g7MdQaZN53Mj/5Ic0RpaMYKcm1zwI9rnKDjI3cXwpKrB3u9wkjQ3ET9JFR6oNI4uId0AK396KbrrpX3HViyo/RyTaveWkjCiVkSpdeyBHeySHldPSVb44hD04cRsGqwA3i1e/+CnOQIU6IGygaoOPnWJhtM0PiWBuecRFiHQ9IDZYcTpYvramYEukWoGwLTFgvTSRYeDzjzWoYFAD4/OKjYYFWKLRsTjcayl30iTnhODV4t9247mjDVzTK92sMS9yR6z8Fnm/8xf40gTS0UhKv7Qpmm9Zo6twLi9+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/N9/6ml5hiUtI02dhjsoZcUBJ7KDSIfEEAyqYWuzWo=;
 b=KKnJZC3xfCTuas3IMxZoI8lZGP5NX1OnWtanuVMMmAYDg8O6nhYcYmDRuLMNVKUaGjP/syq+IlDQimaS/iuVtH0jceZ+cqO4EA42p4o1voswO0xGVhGj2YOE+1TP/bOgpE6qlDNiu9b6BSnB2miIO1fdoTXRmNwXsDPms3t9SR7hnxVswgxwh62TtHtXw/IDZLAisgyduP65RFpK/2vEWrHEjcrkMkg9bF6SDuwm7KdMRIoM4pqRKSb3BRztzBTNlQNgM7pUzZs/NQRw5zyVqc8dgvwPyKHupC+e60WPYP4RrEuH2b0nVT0g0u7hZTAUhlmRQY5L1kvhPi+afdtWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7224.namprd03.prod.outlook.com (2603:10b6:510:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:23:29 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:23:29 +0000
Date: Wed, 23 Sep 2026 13:24:34 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Fei Xie <fei.xie@horizon.auto>
Cc: Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND
 and NOR
Message-ID: <arOwdePAmoghlakj@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921093701.1341766-1-fei.xie@horizon.auto>
X-ClientProxiedBy: MA3P292CA0044.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4cef9d-56eb-4a4b-b3a2-08df196d7927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|3023799007|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z0n88qCpBLwIzNqZimilcQPbQJcp+dqGjdEkL1JPsOadhXp3S4BFR1TsOwnYT6sKjr25NoIhi1VUpmmNE2R71SElyYF//9fAABz6qnInM2lq+/Bh7AkkqR4xVSGNQOnQk4dXWla/1iOyDaa6yAJZG4UNIh3qgZzYYR4LiRDsXamEwk/x0DDJdYAAz16SyyFExabFcWkcEs4AJoZv1xgGMluIb2nJJJlV9pTuiU0NRG7aL8IxVcEIPT/ku7kno7jCxh6oebcz68zHVoVHMCWuEnZmkC2MzJMBQQ8EhqSAclRyteCGrCLrOELMY/CA4qNimKRWMBtqUTeXG+S+2Il5kKqNRimtIGREW3HNN2mEsjuvAyabWJO09c3wcoODQ64jqTnTugOWjpBDOPo4S+ERVNTLjkHqBDImfw/K5kzkUr9kqqaoDH1UqOgnztX0zz5ZnK1d6msDvRmwDIRe9WBwoqLguVbZdPliYAOQZanx5HHARKKq/i9Y/SKsv65oE/NrAnI7yT0IQbwmT4fDpiF0pT8Bkx2bJwMF1EYg+mqIYL4VGAUnFQZT5DsZkApDMd8VrBVhAuEZREZmKEWx6YDv+i+6YqdiB/o4tJuW7w6u5g3GsUGvm6rwePcBKFuwaGtX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFpb2hwZ25UYVArUGJyTTVydmZJd205S09tNHNJL0wrNE5jM005K1ZMak04?=
 =?utf-8?B?eVEvZTRLZkpxRmttWHhUZm5uSUNISVhmUjFYOVdtWHlNVnIxSkhlNjROTkgr?=
 =?utf-8?B?U2dQYUNlSXEvOUFTQXVtY3JSK3hJMk9udFZBd1EzcHRhUmF2b0huYll4Zmhv?=
 =?utf-8?B?TkkySzBIUTBRZVpSS3h1anRQTlRUN2Z3ZjRxR2w5dlcraXo5Tjc2eXc3WEZt?=
 =?utf-8?B?cEpnelZPOWR5eGlhemNIdU5jdVVnME92dkJFQjFHcVpKWm5oSXo3RWNHZ0Fx?=
 =?utf-8?B?d1JkNTNveHZNOW1nNXU5NlYyZVppRjVscHVoN08yWGQxZE1BQjEvQVZtL2pP?=
 =?utf-8?B?ZGY3dktUSXlsZm5yaldOUTlXTE9KaTdSRXJMUThZOFVSbFdRK1NqZ1hpbGxL?=
 =?utf-8?B?MDU3ZzVBZGdVcXo0cC9GdktiNjlHa3VZNjNoQlNUSWpZMVNiR0VKM1dndjFL?=
 =?utf-8?B?SFNyeVFXS1BYMDV2V1dhdWIyMVRlOURPdXpkVHM4NmJZR1dSelM3VFViSFB6?=
 =?utf-8?B?WEZoalk3Y2svN1hobnFtaWtaeEllUjMrdVQ4SVNPOEhjYlU3dEF3cmp0anF4?=
 =?utf-8?B?Z3ZsdVJTUHNnQkJsOVdWblBMYnJXTXZUWmd2Mys2N09qY0I0YUNadnA0cS8w?=
 =?utf-8?B?dWZpcGFOd0pGWjhXeWNKSXlUUkJ4NnY1b3VERXd5WHkwTFRxTTN5czREY1Ar?=
 =?utf-8?B?QmZZQ3ErTmRnTENTbDFhYnNyakJzTlhIamY3SVhTL2U5dDRPMWVYZDNvOXJr?=
 =?utf-8?B?M1hPQ2J1WGhPZ0ExQ2FSb0gyTEp0MFdINFdrbTFESnhOMEZFaXhSVTM1UmR4?=
 =?utf-8?B?N1V2Q0JjVGpCT1lDaEtrdUhXdkw3STdTWWVtalVhSUJFNFp1ZjVuSXFmWmtu?=
 =?utf-8?B?ZUpjYVZ4cjFobTd5Z0QybzBwRFpQNDhrQlE0aEgwM3lyOFVUZWhVMVI4ZDVn?=
 =?utf-8?B?SFM3RkdVdTFRM0dRY082dHdLU3NyL3RMRzN0MFBVckNhcDBYMnVLcCsrTnVr?=
 =?utf-8?B?anZYcFpVN1RKZ0dwRS9PellYQmJaMXFMYXlDM2M0d1dUVE9ESEFJUDhRd1NW?=
 =?utf-8?B?bHFWWTBuNFd3R3pDS0lsdnVDOGYwbURneEpvN0htZkN0ckwzb21HZk0xVnVX?=
 =?utf-8?B?ZzZJYW5kak5zcS9DL3lXM2l3OUkxb0FHWkdBc0t5VXJ5a2tRb0YrQmhzTXcy?=
 =?utf-8?B?ZHY0Y2V4RFZXbGxRU1RVZks5TDNWc3Jqc3poUnlXYlJXbUl5bDJCOEtHV0pR?=
 =?utf-8?B?ZGVSWkNXYzczNjJGTklZODVadU9nUWdBc01ES2pqY0JQUjFOaXN0RCtXQ1Rk?=
 =?utf-8?B?MjJvR0VabHUvbjZSdkptVjhOSUJpSUJJN09zUFg2SnNvZ2J0bGl1aVg1Szg3?=
 =?utf-8?B?VWR6WnN3dTgzWkpWWXRGRW8xM0d2RVJaaTM4Y2hGdTZFWkxoejBSU2xFV0k3?=
 =?utf-8?B?TVEzdDJVamFnZ1o4azJCRFluS0tLeXlXd3F5d1B2b1E3Z1Q2Zk9Vd1JpY2pm?=
 =?utf-8?B?VHVUb1p2ZEhkSXdkM1V1aGdITGJpVWU3ZWtNV0JlMjZMV0RFYWlreDljbkYw?=
 =?utf-8?B?WEJDdjQ4ZzFBRjBmdEllUVIwRGhyNzRFdlBwdkc4bkZHKzlBdEQ2bjFvbjlH?=
 =?utf-8?B?Y1Q5dUUreGMwUDlucnI5KzVjOTg4NHRBaW5yOG5FNGM3L21oN29wTENMMFEz?=
 =?utf-8?B?aFEwRW1sOTlJRksxWkJhSnE1d3ErWTRSLzdWdTRNS1hsckpkNEJDMlZadDJV?=
 =?utf-8?B?ZjdrM3NTR2NYb1pXRU5GZ3hmT0h6TFdPZXFWQkdJcDhxdWk3SE9aRFllT1Fp?=
 =?utf-8?B?M2k5UURSMlRZR3FlcS9YNHp6bVdyb0ZHTExqcHB5WDNrSXlsZ1YzaDI5U1hu?=
 =?utf-8?B?bS9qemNNdlk1d0N3T3FnZGN5Zkp4S2FjdkR2aGJNb25xU3F6dFJra0hVWEI2?=
 =?utf-8?B?NkkyS1Z2dWJxRmQzRzkxVFpidlVPRnR4SktnRG02NDgwbjFqQ1NaUExNTFBK?=
 =?utf-8?B?MFhKc3Q1bnY2UGlqUXJnOGtmdEljcUJjUjdtQ2tqampsOVV2RFpVTHloc0VN?=
 =?utf-8?B?UE9FMFc5Q1ZRSURoU1YrT0d6TStIclNLQzY0a016WUxydnpPVlpFVkxNeGVy?=
 =?utf-8?B?dzlQMVl4dEFjRjZSb2dVU0cvNi9NWjNzQUJlV3ZCK28vbk90NHE0ditpZU1L?=
 =?utf-8?B?QTI2RkdQTkh0VlB2c2RLaDBxbWMzN3lUYkFKc0c4S3ErYlphUVFJVVpjMXZr?=
 =?utf-8?B?ajFqSUVqTTVKRjIxek92cDFkejVRRWhQRXk5VW5WT1JWdTZMZ0FpUjJmV0tK?=
 =?utf-8?B?bFp6elpLRnZPdUhwTExxTFgxby9kRXdYN3hXMjdiMmlGSEc2cHc4UT09?=
X-Exchange-RoutingPolicyChecked:
	KMpW3n4owNdxku/QbBrpCOZGAydnLociKOhn5haL3NribFOt1mSj8+3Jqha3Yt0Dt/obS6vsftmLihaQNvoW+z/SxU55zwZrZu32H42iPQ9BC57pFfDy3afPjn4PRx5b8eZJ/c01FXyWwuFsWc6jd3LjDgBjbQXQnWLBEZrZOqwc13NffIu8MyoEXZ82c9iNVSJPlRcFWErCuxv2gFKycUoR4I9073En6xgVl2v0t9vHX/pQX5llwVtewfn84mkRWZzL9EZhr9oVxpMdZIyaE0dibyBQ2uHUUIJak3JFTTQxoMizV8PcRAOEXlrDwjdgsLRPpu1/6nR3Bfeg8qynFQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4cef9d-56eb-4a4b-b3a2-08df196d7927
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:23:28.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpsBPooJ0bhlcFadvaw5LcXIdJhX/aTc6gZ9IBgXq2u9b33T2fRXSoQ/fLwtbZg6uu9xGvnB6ZnenGyDO1Ydmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7224
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX8YqgFc/v+hmY
 454B1O51FVTPlpqpX/+cLmim280jVooaT5PEs+ENVT511GEjbQDP422y6RWVzOnWvrl1VVG8Qu7
 v9d9HIZLGa7E0Oqltr9pCmKookGqE1qEuWPLE8rzJfL/fmys8lyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfXw5DAdLDPX9to
 FSwfqMLLLnUj6aw/mCWUc8qRos0DDWfKFkwT96QEpoMfxGRvZVGrwzoH/ctcYq5VcphIfxdIZNn
 UT0wigKajll9lTfOwkJCpSrxDgFjzqnYLojQ8jbRAK4n9EKLeuam9NTnT3B64S0WzEqdb0vfr8h
 mNJxp7+5O6tIb6SXkaYRMZ3FikdyHlFzWSLbAO1CKuCL3gMh7NidmqxPPtn2ianlX0Vu2Hcco9h
 0P3J0jBP1/C8arzHy9/Td1ECc7tu+c1e/1W1vvRv2DG4QT1P90j9tdPmUG8+brvFMi/Kk3Xx+9U
 hDxSO2O/43K4Unsl1UVvrZLmUfg5XPnHKryD/G07nYT8PWo2nYu76BhsL52PLl0b9+XNxiQxezF
 jOpMoz8G2op32MlXEkVLJRwju8y7y4xbheMBF50yfH5pjDQG6E6YiZ7z1vecCVi3jXghcFE7lX0
 dfFnS7SN1tyrg3XVlNg==
X-Proofpoint-GUID: 1HrBDV6v4Ob-SPwnLctN8WRuT9KBNeEH
X-Authority-Analysis: v=2.4 cv=TJDQ2Fla c=1 sm=1 tr=0 ts=6ab3c4c9 cx=c_pps
 a=rfO4B3dVWuFwsna5lJbweg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=nFGiBtTo4-QzsRKFKjEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1HrBDV6v4Ob-SPwnLctN8WRuT9KBNeEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230049

Hi Mark, Fei,

So funny enough I have been also working on ACMD for this controller.
Even though it's running on a platform which is not upstream (but we
plan to do that - at some point -) I was also thinking in submitting
this. But Fei was faster. My approach is fairly simpler but it comes
with some assumptions from what I saw from the memory chips I tested.

The patch is in [1]: More comments below...

On Mon, Sep 21, 2026 at 05:36:57PM +0800, Fei Xie wrote:
> From: "fei.xie" <fei.xie@horizon.auto>
> 
> The Cadence XSPI controller provides an automatic command (ACMD) engine.
> It can execute complete flash transactions, including command sequences,
> device-ready polling and master-DMA data transfers.  Software submits a PIO
> command containing the flash address, DMA address and transfer length.
> 
> For SPI NAND, for example, a read transaction combines PAGE READ, status
> polling and READ CACHE in hardware.  Program and erase transactions also
> combine write enable, data or erase commands, and status polling.  This
> avoids submitting each command separately through STIG mode.
> 
> This RFC contains a working controller-local implementation for both SPI
> NAND and SPI NOR.  Unsupported operations continue to use STIG mode.
> 
> There is an important layering issue in this implementation.  In order to
> program the hardware sequences, the controller driver obtains upper-layer
> driver data and directly uses struct spinand_device or struct spi_nor.  It
> also keeps state across individual spi_mem_exec_op() calls in order to
> recognize a complete NAND transaction.  We do not consider either property
> desirable for a final implementation.
> 

> The hardware nevertheless needs information which is not available in one
> spi_mem_op.  A NAND read is represented by separate PAGE READ, status-poll
> and READ CACHE operations, while the ACMD engine needs all three before the
> transaction is started.  NAND geometry is also needed to translate row and
> column addresses for the ACMD address space.
> 
> We would appreciate guidance on the preferred interface boundary:
> 
>   1. Is a controller-local implementation acceptable because these command
>      sequences are specific to the Cadence ACMD engine?

Don't think so.

> 
>   2. Should SPI mem instead provide an interface for submitting an ordered
>      group of operations, including status-poll semantics, with SPI NAND
>      and SPI NOR constructing the group and the controller translating it
>      into hardware sequences?
> 
>   3. If the latter is preferred, should NAND geometry be supplied through
>      the sequence interface, or should it be exposed to controllers
>      separately?

I think a spi_mem callback with nand geometry/info could be something
admissible.

But now comes the experience I had... I also tried to use the ACMD for
page read + status poll + read cache and I actually think we could get
away with it by caching some info (like the row in the 0x13 command
which we always get AFAIR).

But more importantly I really did not saw such a performance improvement to
justify the added complexity and so I kind of dropped it.

And on top of that and now it starts to get more interesting, the real game
changer (for speed) is when the nand chip supports continuous reads and walks pages
by itself. Continuous reads are the only way (AFAIK) for the spi_mem core to
give the controllers reads bigger than the page size (like a full erase block).
And even if we somehow add a new controller capability to let the core know
that it can give bigger blocks to the controller (as the controller can also
walk pages), I suspect things would go south for nand chips with
continuous mode + ACMD also trying to walk the pages. Hence, we would
also need to take care of that.

Another thing worth mentioning is that you take an "all or nothing"
approach for ACMD. What I saw on the NOR flash I tested (which is an
octal one) is that STIG mode was actually more performant for smaller
chunks of data (my threshold is around 2k).

On ERASE and PROGRAM I also did not saw any meaningful gain at all.
Pretty much because the device programming time is the big bottleneck.

So, to sum things up I ended only using ACMD for reads and just using
profile 1 on the controller with no geometry knowledge which worked for
both the nand [2] and nor [3] chips I'm using (and all other commands
still use STIG). Again using the sequencer for nand might still be worth
it if the chip does not support continuous mode and has a big enough
page size or we somehow support letting the spi_mem core request bigger
than page size chunks of data for controllers that can handle it. But we
still need to take care to not break chips where cont mode is supported
where I think it makes more sense to let the memory chip walk the pages
rather than the controller.

Some speed tests for comparison on my side:

cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00040000 00010000 "u-boot spl"
mtd1: 000c0000 00010000 "u-boot proper"
mtd2: 02000000 00010000 "kernel"
mtd3: 0df00000 00010000 "rootfs"
mtd4: 08000000 00020000 "xspi0-nor"
mtd5: 40000000 00040000 "xspi1-nand"


SPI-NOR
-----------------------------------------------

ACMD (only reads are > 2k are done in ACMD )
----

flash_speed -c 5 -d /dev/mtd4
not NAND flash, assume page size is 512 bytes.
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 1054 KiB/s
testing eraseblock read speed
eraseblock read speed is 106666 KiB/s
testing page write speed
page write speed is 1035 KiB/s
testing page read speed
page read speed is 15238 KiB/s
testing 2 page write speed
2 page write speed is 1044 KiB/s
testing 2 page read speed
2 page read speed is 26666 KiB/s
Testing erase speed
erase speed is 433 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 428 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 432 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 431 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 430 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 428 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 430 KiB/s
finished

STIG
----

flash_speed -c 5 -d /dev/mtd4
not NAND flash, assume page size is 512 bytes.
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 1054 KiB/s
testing eraseblock read speed
eraseblock read speed is 64000 KiB/s
testing page write speed
page write speed is 1042 KiB/s
testing page read speed
page read speed is 14883 KiB/s
testing 2 page write speed
2 page write speed is 1049 KiB/s
testing 2 page read speed
2 page read speed is 26666 KiB/s
Testing erase speed
erase speed is 435 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 435 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 436 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 433 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 434 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 429 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 431 KiB/s
finished


SPI-NAND
--------

ACMD (all reads are ACMD given that page size is 4k)
----

flash_speed -c 5 -d /dev/mtd5
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 6497 KiB/s
testing eraseblock read speed
eraseblock read speed is 44137 KiB/s
testing page write speed
page write speed is 6336 KiB/s
testing page read speed
page read speed is 16842 KiB/s
testing 2 page write speed
2 page write speed is 6400 KiB/s
testing 2 page read speed
2 page read speed is 19104 KiB/s
Testing erase speed
erase speed is 60952 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 60952 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 60952 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 60952 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 60952 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 60952 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 60952 KiB/s
finished

STIG
----

flash_speed -c 5 -d /dev/mtd5
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 6564 KiB/s
testing eraseblock read speed
eraseblock read speed is 19104 KiB/s
testing page write speed
page write speed is 6368 KiB/s
testing page read speed
page read speed is 18028 KiB/s
testing 2 page write speed
2 page write speed is 6432 KiB/s
testing 2 page read speed
2 page read speed is 18550 KiB/s
Testing erase speed
erase speed is 60952 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 60952 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 60952 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 60952 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 60952 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 60952 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 60952 KiB/s
finished

As you can see for the NAND, for single pages I do not see any major
difference (things become interesting when chunks of data are big
enough). The way I see it:

1. Do we really want to support erase + program? How much performance
   do we gain for those? My experience was pretty much none but may you
   saw something else.
2. For NORs, things are relatively simple and there's nothing we need
   from the core. But we should have a way to decide when ACMD pays off and
   I'm not sure an hardcoded threshold like mine is good for everybody. It
   might depend on number of lanes, clock speed, etc...
3. For NANDs, things are more complex. I would say that if the chip supports
   continuous reads, we should treat reads > page size pretty much the same way
   as we do for NOR (what I'm doing now). The question is what do we
   want to do when the memory chip does not have cont mode and what we
   want to do for single page read? Do we wanna go with the more
   complex approach of "exporting" nand geometry to the controller? For
   single page read and IIRC, I think I did not see that big of an
   improvement.

Would be nice to see some real performance numbers like the above.

Also, If I understood correctly, you tested this on an older kernel than
upstream right? Have you backported [4] for STIG? It kind of matters...

[1]: https://github.com/analogdevicesinc/linux/pull/3478/changes/81b30eea886fc9decf45d22f0a185d5f76e3bb86 
[2]: https://lore.kernel.org/linux-mtd/20260911-mtd-nand-new-chip-support-v2-1-e2925bf78c26@analog.com/
[3]: https://lore.kernel.org/linux-mtd/20260914-mtd-spi-nor-new-issi-chip-v2-2-3cd4d7e434b2@analog.com/
[4]: https://lore.kernel.org/linux-spi/178056886874.53724.4850286391745939707.b4-ty@b4/

Thx!
- Nuno Sá

> 
> We have prototyped the second approach locally by adding sequence callbacks
> to drivers/spi/spi-mem.c and constructing the NAND transactions in
> drivers/mtd/nand/spi/core.c.  It removes the controller dependency on MTD
> private structures, but the initial version duplicated page/OOB preparation
> and made the generic sequence interface carry NAND-specific geometry.  That
> prototype is therefore not included here; we would first like agreement on
> the interface.
> 
> Performance
> ===========
> 
> The SPI NAND path was tested on a Horizon Robotics J6B platform with a
> GigaDevice GD5F4GM8RE device.  A vendor Linux 6.1 backport of the same ACMD
> implementation was used for the hardware tests.
> 
> Under the same 80 MHz transfer configuration, the sequential-read results
> are:
> 
>   STIG using readq:  8.24 MB/s (7.86 MiB/s)
>   ACMD PIO + MDMA:  10.08 MB/s (9.61 MiB/s), about 22% higher
>   STIG read CPU:    59.74% / 40.87%
>   ACMD read CPU:    approximately 16%
> 
> Using the lower STIG CPU figure for a conservative comparison, ACMD reduced
> read CPU usage by 24.87 percentage points, or approximately 61% relative.
> 
> The CPU reduction comes from moving device-ready polling and command
> sequencing into the controller.  Software no longer needs to submit and
> wait for each STIG command while a page is being transferred.
> 
> The ACMD program path averaged 2.94 MiB/s over ten 128 KiB writes,
> excluding erase time.  A 128 KiB random-data erase/program/read test
> produced identical SHA-256 hashes and byte-for-byte comparison.  Read,
> program and erase were also traced to confirm that the ACMD path was used.
> 
> The mainline series has been compile-tested for arm64.  The SPI NAND
> hardware tests were performed with the Linux 6.1 backport because the test
> platform currently runs the vendor 6.1 kernel.  SPI NOR has been
> compile-tested but has not yet been tested on hardware.
> 
> This series is intended to start the API and layering discussion rather
> than to propose the current upper-layer coupling as the final design.
> 
> fei.xie (4):
>   dt-bindings: spi: cdns,xspi: add SPI NAND compatible
>   spi: cadence-xspi: add ACMD support for SPI NAND
>   spi: cadence-xspi: factor out reusable ACMD helpers
>   spi: cadence-xspi: add ACMD support for SPI NOR
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml    |    3 +-
>  drivers/spi/spi-cadence-xspi.c                | 1259 ++++++++++++++++-
>  2 files changed, 1260 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
