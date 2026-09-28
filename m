Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083334D9F97
	for <linux-spi@vger.kernel.org>; Mon, 28 Sep 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607736; cv=fail; b=cgduY4JB9pv1MeN2z6L31QSESfvSUiRSFojrznIpE20W0iF9DMQWXpvUdNPHQSN75HB5nbGI6lOwbY0bjX+LaV5l6BBLKxDFZWwAsfuw+bQmzsLBkBjoKx82RXNSFDGWIa1Wakr6Ukvwvn3rY/fM9dTd4AGJaKijCItS7qmW/xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607736; c=relaxed/simple;
	bh=AaM6FkfLYKlzkff46WBJyn69tXBHht2co/v2HBUr9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zya9Z+tA/FsH8M1ndf9VJpp94leKYr6zeQCcfOQFtybkBZBGZB8JCld82JCVgGh9I4tQxLK0z7ZLkyvOCnYgC0+DIxAJfgl76VZLTx9jMqeTbiJZ9Ju07NE9yJazGJrPiSNDfqj/ajJVg3BPJ+pqg3gydKRVsORR92JoPUDnwqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vRYgBCP9; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vRYgBCP9"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEgwpH655743;
	Mon, 28 Sep 2026 11:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AP2B4
	acdb3G8x2rYxrPYgEjWpboF2NtZgtNpCfdUK90=; b=vRYgBCP9quvxek++45qpS
	Rd6+pmHF9g7oE5WtAZeFjfLtwfaQgGy1pW9w8zOirJCbMSdCnFOSw7opnJOxN1zk
	p7NS3Q/H1+fYkjG5MpOYUn/bX8GCTBU8dQqsOcDWECAGacerdJNDfGKcltWwoqgJ
	WnNS+ofstMn4C8jV+2vYH3EH6gc1Iohu87JsBV/zPlfv2lNzCmpbkeTLpN2VxexU
	fzR8w/xGX3myFsZXD15v2KRA9uZF65Sf+WX1CoaqAR8ht27f9Vv83FGs42w7lgPp
	vsPbYC8loL5HDqWmdRegJzHBo317GhcAMHFOHSJRtwyxW7dLq46b1hxuoxEqsspm
	g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gysqr08fu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:01:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLxB6z/IJwGsdy9Q3FXXr1unN1mN3W+GlglZ98WBRrPboeOdK2jQ7WjbUbeI/QRwXr79asQniZn16SKGD5WVbQWBYOws2q3avLgFQih33oaTvzbNX23H/NgnpsNCTGoeEri3Y/BMMpmkBdCXfigsguI34jG7OIGAZxiNMhnQQPiR/vTfj5nRCqsIqQ4fym1dMMnfeD3xjltw9/Qg9s7+3liWhACLd7AxvvnPHm4tUG53zSNngV87c+AOI2ZZ9KcDkJFKy5fKQMI9UpsKjicZsTTwsi2Qh1KnmgMMO0iJ1fvg6VsMtUO06meLJCsG5XXRYHgxllNZIUI1ymRc+VkCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP2B4acdb3G8x2rYxrPYgEjWpboF2NtZgtNpCfdUK90=;
 b=L7OKBr2GMm9DhRSAA0Ouqcq6id5NdylxDD0AciqQq4795zOXUbCJf8EKxeooBpMAlv8O7f6c6h+zolE/EepdY678oIlnW9EfAzrEeMCPOZzPbJMDLHfqTuG25nSz2EkeT/ew11/gGaFtfCN1IKCiBZlQ64IXrk9QxIX6BcxoZDTnxdvAyMPiHWn/h/Xs9Ctp2nVgc/5VQ9kjTMXEJLShBdWUDUzcab5syM7WvHJuGLHtGuU++5vGEwuSvkzBYVEP8/B09X3Y+z72L3AUsy0ysAgP2S0dEmO5F+InfGWtCsQ3v8h5+omA3LBXwJGDZazDtEC5DBix/HHF5+kSVsi13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BL1PR03MB6151.namprd03.prod.outlook.com (2603:10b6:208:315::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:01:17 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:01:17 +0000
Date: Mon, 28 Sep 2026 16:02:27 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Fei Xie <fei.xie@horizon.auto>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND
 and NOR
Message-ID: <arp-E1MDFLfV1ASq@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <arOwdePAmoghlakj@nsa>
 <20260928055005.3987624-1-fei.xie@horizon.auto>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928055005.3987624-1-fei.xie@horizon.auto>
X-ClientProxiedBy: MR1P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BL1PR03MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cbd55c-d9dd-4d38-7aa9-08df1d7158ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ec89lRLGN9zrYG7wLYkvGkJcLLzWt68xOAaLgb0uZ/E6+qchwKDhTXV8ToDBgTKVTs0GMWs04BR+Qiwh6T4NS6DDT4Tmthps4s8vV9U6t6p2uJHqzgKZQST034ijumzZcOQDk1aPOkYByCE7W+fW77TaDqm1Dxhc8XnWRW3+ennAg7JtJEq0hM823ApfiZc5BaF2D41/qGxlAB6Nh3NCp5GUR4orCv3gX2/XP3ek1O4HcpIwEw7C7Nx8vGTf2Kimnvf8JFDMFOfm5qulQ0JBvW1YSLHj00F9CKaINvSsMINq8DKTg76sPrnSwwe5cKId0G7zxSPRwbqbzLh+Nl2V13e6qF9+zuYlM6p6ATCTiDAGOz2xfvrjemXmwBJDP9+2b3o0vikJOB2/RjgnM54INPNinx3ZimLb1kca621JtSS34QPMdD7L3gVNgojwDFlK3U1RK2aBXeDHlEOsJ9ULQWRYQDLytZIlpoqDp905l+s80TpbGY26Z0reHvr4MG1gytEnD7aqz3cksij4R6eTDeIXu+802BqLUq7eGUdFvus6Hpxy5tiWOpzzRekkAMRbXI6H0sTa63mkrlP+jImiU7wytzOxnKerfFEVkoJZ71YTXZiwE6ZwTVTlB8RXC0iW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWdSTE5MQlRsOG5pRGJmR3FnRTN3akZreElUSDl2b1Y1dkI3cTllVitoSHlv?=
 =?utf-8?B?OXVpK0RQekI4K0pOaTFsaHByaTVNK2FjV2RvTXFJM2tMRGFjdEZKTzBuazFB?=
 =?utf-8?B?MlVxb1FZVTZleWVrTjd6dStqRC9QU1grUnVlY1Q5V2QrMFErTmpydi9FYktr?=
 =?utf-8?B?dUYxL2lieDRSNHF5N3Y0RG1leDQyb0g5ZVRCWFpmQ2gxcGZPLzRZa1pkcFNU?=
 =?utf-8?B?MXhoVk1QbzNJV2IxOEc5VzhzU0Q3NjFpSHNsbXNaSXdieEUrblZremVuelBx?=
 =?utf-8?B?QVFha0NGc3lVbDBqbTJuV0J3QU5ZN2NGWFdnRUNwRUhjQy9yUnAwUHdTYWNz?=
 =?utf-8?B?VUhqZHhORWxaekcxejZrUVlaM0FGRlBpN29CbjhSVkgxMnFWQlpBYXVuZk5r?=
 =?utf-8?B?ZlNVdzB3aitmSEozNlJCZGRxR0J1Q0FhWGtTaG90dXlUZUlVSWttU3Vrdkcw?=
 =?utf-8?B?UXJxN0FlbXpHZ1pWY3YxS3d0Qzk0VmJ6WGRCbTFaTUVUU2htRFowRktyYy9W?=
 =?utf-8?B?MWNDdUFHNFdFY3I2b1lKRXhmZGhjVDVlbXU5bTh4VUxWcTQrb2plc05KT0Rr?=
 =?utf-8?B?eFdDTmJQLzZiSlpSTVVuYlVaV0JpNVFMWGQyTHpJLytxWmJZSjRRZ1l0TnM4?=
 =?utf-8?B?L0RDQlZ4VDVydGZDOEpVcDJ1WmRoMVRHYnV1cVI2dzNuLzNXTWU2NG9WYXpX?=
 =?utf-8?B?bk82WDRCS2dKUEZFYW1YWmdKVEpLWFJUNUp0a00wSFUrQW9RZG5mdzlRWCtY?=
 =?utf-8?B?V2FGRmYxRWl6azgveWhSVEw4TkV0bDhVendUamVKSG4rWG5wVkV2UFZnZ1Ez?=
 =?utf-8?B?YTQzZjRjUWtEYVJnNTBNWlpvZlFYSFNPWEZzVTVWcFpjaGY3NFhxWTZTRUpX?=
 =?utf-8?B?MG1URlBPaTBzV2NsYlYyMndCMkt6aUxFVWJIZkMyWmlreURWUEQ3dnlwNTBM?=
 =?utf-8?B?ZWw1UjNRSitWOFRCUFB5Mzk4OWE1ZEVnRUlMRzF4MGVteTBPc2xRVmxVZU9J?=
 =?utf-8?B?UzMrYTNHVWR4eDN4Ym4wUTlrSVlVWGNPSkYvNS9pUEJkTUZ6amRteVpFdUMx?=
 =?utf-8?B?VWhtMzRWYThuNFpKTnZsOGFtUmtTQTdKSlBJS3NmdTRvRjRoSWhtejVUb3Zl?=
 =?utf-8?B?dEtIWGJVcDhNbVVUS0NlRG1RdXZqdTFVYlNZVnN0eEZ6dFdDUkI1OFR2bUNm?=
 =?utf-8?B?MURDdThqOVREWEU4ZUJycXRPSTFZcUsvTzlVY0NZNGFpM1NqTWZ1ajlRUml3?=
 =?utf-8?B?RUphQVlOMnc4Z1NHOUs4c3Fhc1ZYVFlLUWlxME5ReGNtWG9BTXRHYk9jenFr?=
 =?utf-8?B?MHUrTlRBb084MEhPZ3d5VjEwemM2TjBXTy8vNlhGYTB5MTF5elFVY3RwVDZL?=
 =?utf-8?B?U1RmWVEvcEtVazJkdU1iWU15b1c4QTdvSW5XMTVsdm5BeldjNlJnNmlpY3NY?=
 =?utf-8?B?b1VlamJKRFlKUFhKNmdoUElRV2RzZXdKV3ZKOUFDaE02dG1SRzRyUDZHQU51?=
 =?utf-8?B?S0NSK2Z1V3FvUmtWdzQzVUwrWUVMNkFGOFFxUWdLRTJ0QXZxa1lKNnZSMHM1?=
 =?utf-8?B?a0JIRlJBTkt4VnAyMTZQMjJhOVdsYnkyZWRta253ZVpIWWdYdWpLWEhFaDFM?=
 =?utf-8?B?UkczWHdyemJteVdQNm1vSVVDc29DczQ5ME5XVjgwSm16bHFCcDFNT3BqM0FT?=
 =?utf-8?B?M0JiamZKaVpzUEljbFFSemhtNjUzTzRoRGxtdEdSZDdwUkFHOEw4dTJaZTV2?=
 =?utf-8?B?MjZVbE90cnc3cTg4cXFRemlVRFp3WDE5S1VCRnFGalRScERsQ3lMS2JNVjl5?=
 =?utf-8?B?cXVlU1V4YzloL2R1RlVZS3NmTm1ZOEFEZU1ta3lrcWIvM2pmRy82TTR2d2ov?=
 =?utf-8?B?cnZHY3ExOUNBdzlQdEtsMFQybGhENk1PTDhvTVF5Q2RIVlNMMEFDakhEVmhE?=
 =?utf-8?B?WHZ1VDcxbnEyYTRQbmFxN3dSUzJCZDI3Zk52cXgyY1hJZDJHR3I1NlNMM2Ez?=
 =?utf-8?B?dTY1TGwyR1REL3pEa2tnTEorZzVHQkZZaUlMUDZBaWNKbWl5T0RIeHE2bnJa?=
 =?utf-8?B?R0ZYS0kwZ1NiV3VobmZpOStXSFUvWEtNNkprK2VJK3N0UEZxUmNHTVVNRVhh?=
 =?utf-8?B?QXdDSUdrckZhWFMxb2c0NUtqbjJBSWtxWWltUFJ0M2g2ek1BNmdkMWhra3Fl?=
 =?utf-8?B?K2FMb05kTmZkc3dvWkdWbjU3R0h0SnJWYVF0cDk4S1pxSkVNTFFLY3l3QXFQ?=
 =?utf-8?B?bWlwQ3ZXUm1yWFRFU1NTZkMxNUNxVXhjeU9Fa2lTVnVPK0loTUREOVJIWUFN?=
 =?utf-8?B?YVpKQVBrTi93Qk9TeENqQTRrc3N3blJFZktzZjY3enArSFpZWnRCdz09?=
X-Exchange-RoutingPolicyChecked:
	reNU7lU/UoK+bDWfZjP9hEuzR4d0aGUo5rmVqoVj07nXILDQDekzwaO771B74JpgAeHZ2mHFzqt0bcl9JSCqD1LO8+lcwjaSkS0zYWs6NXfk9ElzIoJyNY/qjQoNFriIkX4wFkki+50bwIIZu2SyWjiJc/cZa90lu7naervObedFctiByjvnL9G0FpGvvGTKn38VoETLKCmqaIMa0o8YGm+59xtAudgU40grVB6W/HoKhkNGbmeLvO9Wih8a9wLlKq7vGjeJnQE1BmPOJRk0g9AcXSRMfmb0hF+DH9SeHiCc6lGt6VFiKHkfVxK0hM3wfcOB1ifcujX1DJvRS3fJqA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cbd55c-d9dd-4d38-7aa9-08df1d7158ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:01:17.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+JN/4NrmhO0Fvl8Vg7FNl6E+kacnBkPpQ1r1KprVbUzmlaPxwtFfKFPTw0lpdBTknIZQVpdC+YQPFgimx0GTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6151
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OSBTYWx0ZWRfX+eIcNKtVGXDj
 x/QFnlnJeQHdGExEMCUjy6SpkNSlHWOxLRz9SLlVX2epMAiFqpZp464AkWtfwy0fsYWz95/1afJ
 rWLlPZ0I5nORevVmk6UzJYKpjK0vp88MnSFV8PosAKQxkEYUCRlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OSBTYWx0ZWRfX/C4zFd4yAoKg
 ILr730dhvdjPIWrTT6Zdx2b5wn3ml+LLLDSJcKxjrH4Enx7ubeoZGAuRpY6CJ4b66FHMERJK21f
 meRt+iFFHoeUipUpQAaGvBhfHt15AO3t5hNgqswKrH+KBkvEotEZGe3pY6FkvnbvI32e4dbT2x9
 oN43WKvurkaLE3AQaSBS/3Gpgf4xkm/T5gf4fjAIPatkYBIaf0ti6w5BxtHti+USHfClh75r87J
 MMVw5uPvd/0YjGTl6L5R1qFrSEFbFjjmlgoWFQNsUnMHW0A25pr2VdkBTyVVAUfAgYJmXqNeLrX
 ofZEcYMKKWhnWw0PERUuGQEnwafjUluU6EN7ASajBB1YTrFOtGBEpVN+0WeYHCj7TG/Sxm4fm8E
 jXTP7udD1grF/5jDyMqLhvEzpmEkvNAi3IRMYBEaUVn3+DZiuoFTucoz3/XjqSag3Khq/XldO25
 eJgdkQ28ScYWnz+ekMQ==
X-Proofpoint-GUID: pJsYcrsyGf9A3IWdpVyia9eGv1z_XmHt
X-Authority-Analysis: v=2.4 cv=PdBqFShd c=1 sm=1 tr=0 ts=6aba8141 cx=c_pps
 a=H8CAifLk0DAaaH9V+JapoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=T8JQXa9jkDW_iO3E5KsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: pJsYcrsyGf9A3IWdpVyia9eGv1z_XmHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280059

On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:

Hi Fei,

> Hi Nuno, Miquel,
> 
> Thanks for asking for benchmarks. I backported the 32/64-bit STIG SDMA
> transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
> kernel, and compared that STIG path against the ACMD SPI NAND path from
> this RFC. I have not applied Nuno's separate ACMD read implementation;
> the figures below are for the implementation in this RFC.
> 
> The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB eraseblocks)
> on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both paths
> used the same board PHY configuration. STIG needed one additional dummy
> clock for the EBh read-cache command on this board to return correct
> data at 80 MHz. This is a local test adjustment, not part of the posted
> RFC or [1]; I excluded the incorrect STIG reads from the comparison.
> 
> I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
> numbers below are the arithmetic means, in KiB/s:
> 
>                                STIG      ACMD PIO
>   eraseblock write speed      3685          3555
>   eraseblock read speed      12468         14222
>   page write speed            3671          3510
>   page read speed            11931         13716
>   erase speed                40000         37647

So this goes along with my expectations. I think we can all agree that
PROGRAM + ERASE is not worth the trouble? We even loose performance...

> 
> For a separate sequential-read test, I erased and programmed the first
> 64 MiB with known random data, then checked that each mode read back
> the complete area byte-for-byte. Both SHA-256 hashes matched the source;
> the reported ECC failure counts were zero. I then ran:

What do you mean by sequential read? Does your flash supports continuous
rads (or buffered mode I think). If so, I would expect much better
number for the ACMD case. But that can be the issue of having both the
controller and the chip trying to walk pages.

> 
>   /var/busybox/time -f 'real=%e user=%U sys=%S cpu=%P' \
>     dd if=/dev/mtd18 of=/dev/null bs=1M count=64
> 
>                           STIG              ACMD PIO
>   elapsed (three runs)    5.30/5.28/5.26 s  4.66/4.65/4.65 s
>   mean throughput         12.12 MiB/s       13.75 MiB/s
>   mean system time        3.55 s            1.06 s
>   process CPU usage       67%               22%
> 
> On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
> and reduces the reading process's CPU usage by 45 percentage points.
> The flash_speed results show a similar gain for reads, including
> single-page reads. I do not see a program or erase throughput benefit:
> ACMD is slightly slower for both in this setup. These are SPI NAND
> results only; I have not benchmarked the NOR path on this board.

So CPU results are the bing thing here. I guess we need to decide if
it's worth the amount of complexity it requires for the whole thing to
work. As I mentioned, if the chip has continuous mode and we try to
read anything bigger than page size we should let the nand chip to
walk the pages and that means the behavior we have today (IMHO of
course):

0x13 (STIG) + wait + read from cache (ACMD)

If we're only reading a single page then the logic in this series would
payoff (slight performance gain + significant drop in cpu load). One simple
way for doing this as a starting point would be:

* Nand has cont mode -> xspi controller does nothing special
* Nand has no cont mode -> Aggregate the xfers together.

Doing something dynamic would be much more complex I guess. With the
above reasoning, having some mem_info() kind of spi_mem callback to tell
us things like geometry, continuous mode support, etc would be enough to
handle the above I think. The reasoning is that reading a nand page is
always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
spinand_read_from_cache_op() so we could probably aggregate everything
in the last call on the controller side without complicating the nand core
logic.

But Miquel knows better if the above could be a viable thing to do.

- Nuno Sá

> 
> This is hardware validation of a 6.1 backport, not a claim that the RFC
> was tested on a current upstream kernel. I agree the read and CPU gains
> need to be weighed against the controller/MTD layering concerns raised
> in review.
> 
> Thanks,
> Fei
> 
> [1] https://lore.kernel.org/linux-spi/178056886874.53724.4850286391745939707.b4-ty@b4/
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
