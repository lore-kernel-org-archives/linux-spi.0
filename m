Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476406;
	b=HOpOmQasF7Y250fJjhu02/0O5YObfTu2ZxT0wM0+v0p8vuazpOwJT8D9bWWphxqXV3qg
	 Wa79Y10GfsaP9NmEYk18L77uOufTcPKv4fC7CRm/9dwsOjZhErzAKMWHpwl4QP0JZ1kTO
	 Je0+uMbKyGtlMsUGIX6cIxySl4lT5kazjIw/7z/LnrPwZPawAsVWm2Osi7npf4vmZpYP6
	 PNXHAONtLb0/r2HHOxFFvjRd+b+z8hINOe4SSKo2FbiPa9wx2yJw4ZEbtlpBLBUw5N9Oo
	 uUiLAszy/L9JXBHW97HRDA2OR5f9nW0vFNwftEs8b4b7X58huDe5tRq2sSe5ie2WKjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476406;
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UXAyuBNhOhkx3tB2R8Cty6b27sC6O25lzXHBUhuVYVk=;
	b=Xi8qAeJNpfTXbik7CjhJ2u9K4UCC9symsDG6QV77tnSfS27S/4D2uEYgg/mUNXSGGXo0
	 1OP4NfVnW/dDTiI5his8ATQJIfeK8U1c4TvKBQ9XpsC3k6zo245G9Htqcq0QRrzSD4WDB
	 eC1jIWeMyfPYOHgMEqWYjWE0LyOLTl5+prYPS0rL7Seek5rpVRqkGXUVqDzraxgI2d0mU
	 Y33YPG4F+ISowgjI8rU1CxG1elWuvq/0X2gqbYzhse7l3NznDQIzaO8D60kTpoX+MW+Co
	 fXkmDqqr0bFk5o3GtdC//nDzoMuIlgGtVXtaJ4DkliyWxcA+srMTaybGPpoPOnIK3Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ECyxUy7X;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eYzqa5PP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E6606A899;
	Thu, 12 Nov 2026 09:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347E6606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ECyxUy7X;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eYzqa5PP
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC67tsf1090885;
	Thu, 12 Nov 2026 04:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UXAyuBNhOhkx3tB2R8Cty6b27sC6O25lzXHBUhuVYVk=; b=ECyxUy7
	XKITqZ6bi9KjKHviWgbs0dt1nTkScEZN4+j7XhXKVD6kpY4wLCXXOMhXaGC3SRdY
	1HOoY8WzUlarIRNxvDiuIvXsHFoOgJC9xMd4ZUIcSDJsyBvZcYCewiigQKR/W39c
	tFQTt6MRIOmwgXiSsJh8vUGv+ghnz4Diaf5O3yLfbpV2zVSgj7MsuVfzimGPcwqC
	n2+GA2BfY0OI5wuPy++On2mo3nuhwjWIvnK/bmSQ0foFKzCzJe2SZ64WFIjdlqxn
	/EUzNuYIVRw8/IGfQFPJ5yYrz8hgSZKM7NwnM7v9kHpzcgbZdclFoBkQ7qNrXIWp
	AFBFMJ87Vdi+BQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UXAyu
	BNhOhkx3tB2R8Cty6b27sC6O25lzXHBUhuVYVk=; b=eYzqa5PPNNOZgtiPJwJKB
	TR9Oh2a+c7cxN9FsqPXEKnKFdYVMK/uzGLL9FzmxIajydctFgZK6IrarxG94RnYF
	M3MzBokPzQuFOrb8GQJaX5EHwVovXWlvijD3iox+of7CSXC7EiRXN4EeJyqTMSvu
	1i8E2ATnES9ImKnK0H0mj7fLpnJjkbZJi8l00hh/C/wWpQ0rXeXOUAJpI9KlDy63
	U2K/lj/ovp83fR3ejel7q03LRI1hkMr4Fol7et4liu4MTunRl18u3pjIIM0cNkPf
	B+GYHG9wGBjR1JGuchWk6x3+cGMo7irNvcGU6nc+nVdY7GN1w8tTKbFew5b4L1XN
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hvw1pcjaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:39:53 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNs65EGODlI0biNQ/VC7PMx4ShN5Ku/z4bCmT+t5Hr9aQtlav4eyV5u+3Yt/FEvzQ5QQs1ESetSj2cmoEQtx7sw32lBnja5zNIKYRFnPnBrZYzUYLZzua9Ne5dApxe7+vUuiu7hU9JZByYjYYCz4UQt2pHG6+393DzLVNBYezrfW/xKbzlu/dFVsiKS83WSBA3uZ42ZIsCdg/jKbCvkFHqeoolKQL74zEXMcDaWKBsKY79cBNrY16a1QTfF3kjYoTsvmZpd2D2JDKVdwF5Wk/gu673v+Daj0ZWfGyLrPZq7GHW+wqCI6L2xNhdu2a/cwbBAJHRA6/tOhgJejrB8LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXAyuBNhOhkx3tB2R8Cty6b27sC6O25lzXHBUhuVYVk=;
 b=RxZtalSTqW9isvxGvN5L4t2XVGAxTsDGOL5QvfF5h+uMbLk9PocRj/MtRQkoDn+teLKb7+GiOMj2j7ozLrQjJcO/1NbqtEu7AdvMZjGOiO8674Gi4Y6zkrTUq81kypik13YKejIyEZvlQJUOMa/6YXm7QQfjZfFtWEU1dolej7RdJyE6FfEPKpINrViyiZlG00rwiAaE9SiuXMpMdy7wnnDO56Tudb2S8KlIBTr7mVCXrYEgF1gNGQ723713XQhPzQa76nAhLKah7axKzRMYSLqjKQcZgvk25WMKDrn+mceTmquAstYCHyfYnO60vmU28lvz3gd/rJ2hedH0wENuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by CHAPR03MB989201.namprd03.prod.outlook.com (2603:10b6:610:301::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:39:51 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 09:39:51 +0000
Date: Thu, 12 Nov 2026 09:41:17 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 6/8] spi: dt-bindings: cdns,xspi: add ADI SC846
 compatible
Message-ID: <avWJrWwHe5ApSUbT@nsa>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>
 <20261111-entomb-backdrop-815e4dc81c7e@spud>
 <avWHJuW2Xj4BJ_cv@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avWHJuW2Xj4BJ_cv@nsa>
X-ClientProxiedBy: MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::8) To DS7PR03MB5464.namprd03.prod.outlook.com
 (2603:10b6:5:2cf::12)
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|CHAPR03MB989201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1fdcd3-70f6-45ad-9974-08df40a0e624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	W1HGDNyNACajG54RWLhntkWLijvDMB8LwD1kUO4Cg0K12kA3ADxTDbLgZnXr1CL3qCdksHUf34LsRJEtwJCrihiokdq3eFCJ3fPVJcehtSu1+moZzrZXGoM8kkwyeldaLYLgHTB9hb6xgPCoZ6CAsWwfK6h0kyJAs58Gy2UfuHsRdWXCv2zD/QX/BoFtGYIrv8fIIcSkTVtggeNMPs1fyleD7pTD9rdKD8BspPuSJCy9gRwl7MwtIoG4D9w3oDEhDzJ/8VGiXt0zcaxpKrxNokqwt5itN78venFJfqJIe4pTg7eT9NUB4b2jeGFWM4hmRKRIfeaDjE53qyRFlkBFHyz1evusRyNHqNRCxmnf+Fck0FvlqJ2RtuRtpstfy9rDKxHjX+a8eG0rPo4N6SnIvGtIs0ieOGh5YDmRmAzVjcSuqC8pWbFFRX3fzEocgEAHd9bmIPGUfL6oERWMbpZqX5TgoYGv1lwRZomkDEQfwKUZrsvSFGWfilp6jLui0SBAZWRlTp3B9XbmG3zou/7akrn4DgJF5y98wMue1JEG8taqnAwGxAKIeXJp6SE20bBm0Y4WcvYlZoziznjTlKNiTbMSuu03dQo6GPjisSR2053VJVYxqKsvlHv0CcokxFi00eDcwmvEZZg73q+xMY23GEDNg6mMBktfMTg7btzz9DA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3I5SERST3hNWi83cjJodHVZVmxpVjViY2xMYSsrbEdLSExicm13dGprK2xW?=
 =?utf-8?B?SE8rR0dJejZSQUVwYit4eGhwbFpZY2YwdEpST2IxeUw0TWxTRmw0cTNoamVv?=
 =?utf-8?B?VXNQeFh0a3RxMm1ub1FMVk4vMmhaNDdQS0RYb1QwK3ljR2kwcXpLTGVlanhs?=
 =?utf-8?B?Y1pkYmhNbGgrVm1ESzhWY3lSai9rellTNWZ6dXA4bWNRdjl5cExZWGZCT2RR?=
 =?utf-8?B?VmU3bnR0UVlvNldBb0hlVFJBZis5SzJqMkVZQTB3OTBmdDVTL1VRTEo1dkFK?=
 =?utf-8?B?SDU0b0RzQWFHc0h5VC83OFRSbW04eTRZamdaV3BMako5UXVndlp6eFllYzd3?=
 =?utf-8?B?aFI0cUNPTWU2S0JLRUhvZkZLZDlwbFZiSktZejFzRWZEa2VKY0xkN1NETVBW?=
 =?utf-8?B?bS9FUy8vSXowb3doRjNvb3BRUDl4b3d2M3F3ZlJmMjhKZjBwTHoxVWZ3MmxE?=
 =?utf-8?B?cHY5bXhiSzJ4NDRRZUU5ZU1TM1hnSzVDcFFHQ3dHTWg1c0xGSVJzbytLWnJQ?=
 =?utf-8?B?RVIxVjNldklyRXJBU0dnd1YvR1Y3Y0liWDcvNEx2VlQrS21mUmo1MzZBYlZG?=
 =?utf-8?B?Tk0vZTZ6MVFUa3RWVXVYZHRXc1VNSy9aZW1Ta1d2R0RLZTdDbjU5U1FnVnZz?=
 =?utf-8?B?RUtWdHBwRU5ocmlxVlRCeTNUR2JVazlXSWt1OTJkNFhrYUF4Zlc0TDlKRWhF?=
 =?utf-8?B?a0tzb2Yyang4enVLZUdrUytKL2haZlR5ZHFXOWpTWWkzSFFZZHJ1Qng3Kzd6?=
 =?utf-8?B?ZmFha0I1ZmxPNkZwTUtFT2tLQTJLS2d3Z1FqRFhIUDYzcW9iL1RRR3pBaXlM?=
 =?utf-8?B?c0FJTGFFcGdlYlBJeWZPV21pdllpOVI2ckY2ZHlOdG85S2xvQTJaelN0NUdF?=
 =?utf-8?B?Y3BkNXNCNENSanlTZS9oeUFpdjY3aDNRcnR4Q1lMd2NoWVQ1RUlBSm5JQUpi?=
 =?utf-8?B?VjVJMTBwb2RlQjRJWkxSSzVuZVBKNTVublFPUGJpWTJQUHg3WTRLWkdLVjln?=
 =?utf-8?B?cWw2S2pMeXBCRmRTREVEUW9EM3J4R2dkdVhzSkF5SDlzalhzbUZGWW96aytt?=
 =?utf-8?B?VG5ma0FrR25OT1FRQ3YwWnpmbkJoVVJiVDQyakNqZ3FmTi9yeVpVRjliV2x0?=
 =?utf-8?B?WEdLM0FMTTZqYU1RbGt4emNaVmpuSTRvLzMrK0ZGVi91c1RIcmFDMldFSHFh?=
 =?utf-8?B?Y2cwdlp5aGZZYUkybmJtNnB1TzltcTdaSGNvWkNpMDB6ZWtLVU5NWStudlRa?=
 =?utf-8?B?ZDMydjlWMTlwTDlidkVnbUdhOXhRdFJCNVZSb292em1vYnRjNW5vSmY2aG5E?=
 =?utf-8?B?ZjNRc01hZ280UTBJK2ZxY0hMSThPUVdvSVI1NGprVnBqRmhZL2ErZnpIQzhj?=
 =?utf-8?B?RjljMWN4MW1tcmE3Y0NyWTNvNzBoRW0xMkZmclRneExhcmtneFlrYkVaZks1?=
 =?utf-8?B?d3hpdTBlMElZc2pOUlBjYkxEUXpOdXJGczRPd1Y2b0NkZ29CdWtFdDJzNkNW?=
 =?utf-8?B?ZlFQSXBlOW9CMzk0QXBuRWZXZTYvbGc1VEdiMzlmNW9qSEMrOStDQk9EY243?=
 =?utf-8?B?eG9CR0VuRmFSMEJvT3JjcHRtSHdWbktEMWpuaUt6eWY2aHNvdHc5aTJmZzRo?=
 =?utf-8?B?Qy9aMGkycWtJY3JrN1piMVNQV05QYmlWTE1QRVlHRkdzWVVQc3FJdlhzSkxG?=
 =?utf-8?B?UjBsTjBITTBEa2tyNVJGZStINzlzT3RQTUVjMlQzYTRlOFl5M2F3Q2ZJVFlE?=
 =?utf-8?B?SWVURjdHenJZclFnRGYrQVNaSXZEcFB4UTNvTGVFM3hIK1FpQnhIYW1CL1Aw?=
 =?utf-8?B?WCtQL1dsYVAwSFR1YThRTkI3MXRpdnpmNEMzWEtBSm5TL3AzSmpWV3d5d2Zj?=
 =?utf-8?B?TTgwMVZ4MlBRYVlMSGY1UkE1VFZRRDlyaUU3NUJaOS9IQWR4Mm9oRi9WdS9i?=
 =?utf-8?B?NUQzS0Nlc1BIaVpSYUN4azNldy9NblJ4bjNZd3RQcUxpRk5pNlE3SFAwbjRn?=
 =?utf-8?B?TUxYR1l2cUFMYVJMTmNkcEJ1dHZ2aStsQ2lhTnJEZ1p2N2pzYmh6VjZOcG5F?=
 =?utf-8?B?VWxnVEl2VG1tWExBLzZHQ3NMR2RyRFlkSllmVlVEMFpsY3dMaW8vNXJCV3U0?=
 =?utf-8?B?UXFJanhlT3RRdXgxaDFjV1RVRzV3YnZSTzlCR0t2Rlh4UDVUZGlBekthaDRS?=
 =?utf-8?B?aXFVQ1plU1RyTUVCN2JoNitBaThLT2Q3R0tyM1lITGxMWVByYy9tUGRNNzJw?=
 =?utf-8?B?SDJHbGdLUlBxU2RMS3NzYTVWOHUrQ01HTVE1NUlqQ1R4dE52UHNZQVpLL0pw?=
 =?utf-8?B?SkhWMlJjbTNqeTB6UDBuZmZJMVdzb1RhWjhLZzFNd1JvM0VHSmo2UT09?=
X-Exchange-RoutingPolicyChecked:
	Wk1ypKTzmCzIKFe0maEoTo/dGsX6iFjC7/ZtcnuzZa7TB3ebYgcOWXMPtCWqbRIRzvyI/ChnY+wlyWRFr7wdvLf3nR7kzFuhbUBWYswdyqjjH6jZgFJPL7w3LkrhNGXCTO84e+b1tb2nVspuhv4z6bD06jETCjnM4q64VojC1QeEGaDFe9OgwdegUGyv2y2XHewRH0MXMveDSLIVdaRStk0Bej431NGn73eqasUOofc4Rm+6pJpkwpvNcZmkCUMmAfBv5Faeo2fSiAYeaDsyuR+e8Eci4wxEDfPEl0rZlXOU/pmf4IhjfVazk3kYFPkoebeJMOkamf+L0t94mGrQAg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1fdcd3-70f6-45ad-9974-08df40a0e624
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:39:51.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ratF1xKtAUsnid/6Sqx1tkXSXRSwKO+O7fOzCOIi9RXFm2dDViIL483CuWpQq0ter+d/S1uAEdpbCJZRNbpPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR03MB989201
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXwNAaGnmL/Omr
 l+x0my7eCbyWrVYhA4AtdgfEZeoQqyhcQQ+0kJRekInlMc62DPPBnczBiM9SOswNgiWJB4S+S3j
 Tn4R3SBAhZUHfr6CpLxaRxYB6znCJx5ZpIRkxg/6p1FkV4x4SDmj
X-Authority-Analysis: v=2.4 cv=N468hG9B c=1 sm=1 tr=0 ts=6af58969 cx=c_pps
 a=lqu9J6zwYwW4kQ66rv+4KA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=YlobMCVq4X_dZBPVSZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXzi19Kx6/8ckQ
 qOXqd4cEeeVXppTcAUnugPmO5D16tIex/uEw5o4+hPfhRqsWzCHJoLHcWtU4cWkDSkR5AEmMvqV
 zfPfOaZj6Spoh174CSLw2Vcsdi/4ra1NNOZvCu4qLoUcshp8ptuCQATKu9OPeEdCi1wnToKNVId
 czFnBmzH7c/3QBh9zi1RgMgMXTDGZWW2dJhqQTd7FVFLSLjPudtRBdu/qxEKOnUsjlqyizwfCOH
 BhjVldUG7g4iZHPDKN/yBWk/sRQi/Fv45EFnWIFKwh9JNkFcsk6yfYV4/8i5vceKe3KT9cP7Ei5
 LNOW8olXH/ShPdeB92DN5l7Lw1LikLL1l7mQ/zMUGsZxYNJqZYTz7qlYuAeEMpZu3cyNpb/ZVsx
 gDrO0w6Db3LdDXopMvpkfykzZ5Ej21ne9jXYx6vw0BMQ9sm8z9MR9Zij2w7udNOeSDO41RQ5r0T
 OyYmKeFZNtsJlfMwtgw==
X-Proofpoint-GUID: mFICzh-cMU7gK_JK0ec0BGTtePUxu31d
X-Proofpoint-ORIG-GUID: mFICzh-cMU7gK_JK0ec0BGTtePUxu31d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120038

On Thu, Nov 12, 2026 at 09:32:36AM +0000, Nuno Sá wrote:
> On Wed, Nov 11, 2026 at 05:58:09PM +0000, Conor Dooley wrote:
> > On Wed, Nov 11, 2026 at 01:23:07PM +0000, Nuno Sá wrote:
> > > The Analog Devices ADSP-SC846 SoC integrates the Cadence xSPI controller
> > > with its own PHY timing configuration and with the support needed for
> > > the auto command (ACMD) mode with the internal DMA, so it cannot be
> > > described by the generic "cdns,xspi-nor" compatible. Add a SoC specific
> > > compatible for it.
> > 
> > I assume it's the phy timing that means the cdns,xspi-nor compatible
> > cannot be used as a fallback?
> 
> Exactly. Without proper phy settings we cannot probe the memory chips.
> There are some works being done to support phy tuning but even when
> that lands, not sure how generic it could be supported.
> 
> Hmm, I guess you want the above mentioned in the commit right? 

Nevermind, it's already in there.

> 
> - Nuno Sá
> 
> > 
> > > 
> > > On this SoC, the controller clock and reset are always wired, so make
> > > them required.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > index 3cd7321319bb..d6ac05b2efb4 100644
> > > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > > @@ -18,6 +18,7 @@ description: |
> > >  properties:
> > >    compatible:
> > >      enum:
> > > +      - adi,adsp-sc846-xspi
> > >        - cdns,xspi-nor
> > >        - marvell,cn10-xspi-nor
> > >  
> > > @@ -53,6 +54,15 @@ required:
> > >  
> > >  allOf:
> > >    - $ref: spi-controller.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: adi,adsp-sc846-xspi
> > > +    then:
> > > +      required:
> > > +        - clocks
> > > +        - resets
> > >    - if:
> > >        properties:
> > >          compatible:
> > > 
> > > -- 
> > > 2.56.0
> > > 
> 
> 
