Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289737;
	b=zR+K4j53lMzEsbMNudyYRDyNAsqCcCkBxd7gBvyzyhIupEKUSoVW0WMY6u4ZGi9F5H/j
	 pNywkHYCqL6KeIkfVir18YPWw90Ozh8vyvJnV3vhoBRrveCqUY76CH8tUh5trj31E6ohF
	 nnZZ+Bj+KCn3W2MLY4X+QjyOUt2WLHZG0ABgjhHH6O2/l57brhI1JcofwN1HjiWi5FQvT
	 3ANfI8NnjKpsrSea4ZnSCqyup+xHMy2wGzuGC23IeV5srYsrL1DEg1ieLlmGIjqBAPku0
	 oenXBialh5zIpNfQA0RHGv9oOzCl+srz2mXPGfQV9YnrSy5982yYHKc/KQzxjxgzqGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289737;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zRx0c2wZ5SPnlmrdbWPhYxrFm5c7q8+QEHtrtNuV4rw=;
	b=KB9ul1wqZUL1qixqbM2iNu1ZJQoArDh1pm67L79jXsTUYn3qz7VBMfq3/PWL3Jj71uie
	 ObIJiAkOV31WJFgQN5uVH1zNBVGtp7S8JgrFPlVTP0537WDD6lx8LhicTclJkl+6Aq0jX
	 kw2qumbaVWHH6cUv6aG/LtFnZOIQnRKOPZ1l1bgwfrL1k38ZrCtsaPYLQ6+Rqzl0Wd3AG
	 1FRIRcYQS/lbtaX5reYgbNGHlCar//WFRO/mZ4HIL9UropfBYFnDZ4B6v+OYrHcnugB1Z
	 2zykUOjf6o6PYkGtX/fE+IfOK30V+72vk6KM/C0iYigHrKpwBr0KlQUCygosGVGG51w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QynWceR5;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=teSJ8srO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D697606A31A;
	Thu, 29 Oct 2026 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D697606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QynWceR5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=teSJ8srO
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TFOZ9u1497536;
	Thu, 29 Oct 2026 12:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=zRx0c2wZ5SPnlmrdbWPhYxrFm5c7q8+QEHtrtNuV4rw=; b=QynWceR
	5iTTcDG3yHzWIpi5k/HBMi4N8j4ApOClpayIQkhcTG+AQhZ7jarcifRbIkkoJdMf
	bjy6BSr6qYhBOrSnCLsLUz3qCp1wK2K6bRgJa+Ym3hfzRvGJtVtGvpRNyaKxrGTJ
	Ojl82AizrW/UPIyv+6YXEUVujQ+h3pjkL857fec8sToE9erIjJ5WaVG+esD2cFMF
	VG7C+poRRiEhXPT3puQ1YOJLijb829WfPC5gwd/Wz4WAbER/eehi4PYL9dl1wO0l
	o7LrGu4fVUOsEsYv90WnxKwEomb1Dwq0LCo9Gg4HyJdw40beuFP+2gi15Sg06Gh+
	N2gFEeLYXmYSogw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zRx0c
	2wZ5SPnlmrdbWPhYxrFm5c7q8+QEHtrtNuV4rw=; b=teSJ8srOLkLtb6fEELdU6
	KivKG27zUnPQNGYak+bSF/gHjKMfKDE1vmTrJ+CxWGcm86bH71MTclKvAR1eNxP3
	C7Ve4Pfw0A0AWGviCWQ662rDSF2q6Byl4wjqmAVce3NsS70aqRSKXEtIehOg+cG4
	PJAFWLt0Mmd1vpcAQhmsSpo6oonmbe0/K87JsIwu6hoKh5Cj3iji76jWCqXl1p9X
	Qm9B+FB/wicNf3ywm4iK3fDgSldt14zEhBUbEBYu0EOxBN8mw7ry7QLE/R6TmzSY
	oGkXNQhS73WJZYvdMigYvLO31r3nZc0Ve/+Lmp97M8LDhYnZvwBgZwv79k8iWxIO
	w==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hm1d0jv80-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:02:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEhYJ+gPLeZaaK7c1zdWLTGid2GEN22ADq60bbaHIowVi0qeU/lCGa2jVEQvsKwvMCJrkkIFeJRRSwW4udx8QnWDAsrr1qtyR3FAICY9ERbzMTKZXnmXTRGWFvwgPS4TAfRusmQabyp3kvzHtEI9rjv0dOJbGG5XuiDQoqV9PAkHMcZGC2jamfDFSGJxSWJDg/pGNw4MYz+u6K0KP8D+dZRlSTCmxWQ2YDF5Kbvz/+OBehYINFg3217lguBg4jG4YK5KFnaJeA4f8HBnEmzTwYVyvXa70h2ToMCOFgg05xqdwlohZAzbrw7sWgsbHPWyIlIhtixMrVU30z6dr+i2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRx0c2wZ5SPnlmrdbWPhYxrFm5c7q8+QEHtrtNuV4rw=;
 b=lDYNUy+Lje+hzpS9ySIH23ztKJ1l+lzTvLjmkohpZ+ucqAiW7tKwbrL4Tp7cNYiMqbbMgWdogNMUBZWXO5HWo4uGr5trM3jp+iN1bQTBPPxj7/BLorwWHbMo/9pyZ9R7+HOFlSpvyE9yHBfIeacaX162n0XSuZ0vUaagorl32ruJdG+SBOpgK0oh9vXWLeUywVBUv84vVDkSIrYMNfzfYY43fmQnsQDgKXVctTrzYaWE9EPUpG1XdVnlVba3R2djkLCa5klG4Rr/9ykKe4pNxyiInCqOng18j15nOijmfXgLOJ3suTSUuaDWZliPkBcJfjEybMTYIoYtVVNIa6hExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH8PR03MB8202.namprd03.prod.outlook.com (2603:10b6:610:2c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:02:06 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:02:02 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 29 Oct 2026 16:03:17 +0000
Subject: [PATCH 2/3] spi: dt-bindings: cdns,xspi: add ACMD and internal DMA
 properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-xspi-cadence-add-acmd-v1-2-53cd44690e04@analog.com>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793289797; l=1748;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XX0gxXnCNdosBSCABRYIjAQGV1gYTFZbUPJZ5Hdiiyk=;
 b=id16y5jhN2MtUm7UhtjC+vMdplmK2152ZaY63fHfZoDK/54CwTiCed7POrT1ZFtfugRW4TDDG
 jH4AGz3zk1MAEHFNbMEsr1vDDzL1WeiRqaM7vDhemUg0v2UbMx/255o
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH8PR03MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: b53a4184-2515-44a3-ec81-08df35d5f8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|261026121527099003|10067099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	pSYbxEYTO9sm3bZXoy6LuDUjYD+Mm7mjGe8FRWiN0eBcUoRo7DV689xKF1cQcx3u+yB/jQUct+I9Bnj32MdGANCXFzvyNl0wfGnNy0v76yJvqSGNOPTuc/AWM+FE/XuylfbCTfH37W39PcB660oOGkrqsV7gRupkmRd0vAWWH5yUF16I82jPtUuZgE8nXxcNe72+29x3EKsoCKNv0rlDX9rwc8jRGYcfl+dAuNT6O4ayLkxnlOMzUgkFvhsiPz+6mMLX+Ww3T55x73CunCHnh47ndSZfWWq030k54uZX5houGPdjYroS8SS+0i3YgJy9V5o2WbVWjZRmofE/nwdHS4wzvhjx5x6C6eZe2KYQ5FqvLG7kz5Ml3T4AyOYaRz2j5wc2POGTi2rXmNpwggLTzGvBF+DEzAid4jvpf6mr9BPldzfn4dNLxzYPRTV1VsDe6iJPbnOopdPzhcJROklS8Qt5BFSbzGeD7c4o/eZkZ0uk2HV8Eyb9orG/JkCWCw2pad8qOEBiZ5Q+sd+jlI8qaw0H6iaOyI2VqMpSkrdt+HBa/Pffb+dKASv8PiEyYoGVALUa7tmASdIekWZyyC08ljESizaDBYvItHSq/cbKHsFLKDqkqeEQomKIhskiQ6NJKkISt2HIoC+GwYRz8032RI9SUv7NUagaTQ2ovsg+Pyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC9JS1dLMTFZOCtRTG4yR3FnaXljTTczeHUvd0FhdUZoQWtBNzVvVEFXdzla?=
 =?utf-8?B?RGJWYWlRSFVOdUl2bUxiR1BoTnBiOWVyajFNZktQNVlUNC8vTFNUVDRRcndU?=
 =?utf-8?B?N1h1VGN1VWd5NHVhK1VSYmxXSzNPc1huVVlQdHhQbGpoSVoxWUIrbUlpZGtD?=
 =?utf-8?B?UXQybDJSaSt6SU00V040NWJYSktEMTBmU0pVakZ5clducGNzK3VPTlV2eEQ1?=
 =?utf-8?B?VXZQQkNhYzF6VWNtRzhHeEFPdXJLQmR1UHJMTHoxdGxRZXZOb3Z1Z2ZIcGpR?=
 =?utf-8?B?dDRWeDY4WVJPUElOdlY2YTFpamhzakZ6dy9EdVlwMU8xc3M1ZWFuRW1jTVFS?=
 =?utf-8?B?NlhqVEg0Z1Q0VFNjdkhLaWZmeFhPRU5kUUpSbG5IcVl1cG12ZkhkMjgwbmNp?=
 =?utf-8?B?cE5nZUpUK295YWJSWlk1ZEFEZWNrT0ZjQnp2Q3hUUkN6aXludVlEcVBFZndl?=
 =?utf-8?B?dVhCNVhWZy9RZXhNblFGcXR5VHZIWm9BMWdtUlJZcUV5VVgwQzdFdG9IUzhQ?=
 =?utf-8?B?bWR3UVFLRDExeUs5N0dGR0RzMzRaVk9KZHVqYnh6cWpUaGNyYkFZS1BRZW1n?=
 =?utf-8?B?Y0FCTFVPUWhFK3VWeGRsam16THdKSFBQcHB5M3VMUnBseVQvYkp0OXZhaDRp?=
 =?utf-8?B?KzllWDBkaldaNTNnbHN4Qm5mU3pQOXRBSmFEdzIxb1ZUUlVpNjN5SERDVW5j?=
 =?utf-8?B?a0t2QjVjMTZxU0VMYVlVdm52R3gxd1lvZmgxejFEb005VFJaUHI1L2JjRllD?=
 =?utf-8?B?RlNxTm5ZYlRMZGFwR0tGc3ZZaU1FR3RzZ2hiZUQ3b2V0MGdzbklHWXpuaGlS?=
 =?utf-8?B?b1pvWGJBMjhkS3cva1hpNlhYWjh1YjBrODlNRzFtWlhHaXcrcU80YzBJVndZ?=
 =?utf-8?B?Uno5bnNna1QybS92ai9nUzUrNGs5K3pyRVpHZ1p4Zzh1VWN3aUlmc1ZTWGNB?=
 =?utf-8?B?cEFkS0owUWYrdkVVNmJsY0pUQk5KbHNOb1FQVzZGb1hDdCtNcUxrdEc0a0Ft?=
 =?utf-8?B?eU15aFVVY21oS3VmbDJKeVVjWVlnaTFVcXZVTE51UXdWbHB3aVVtZUtJT3k5?=
 =?utf-8?B?alU0cDQrcjZ3UFRHSFFGclVNQUxVem9iMXB2SUhvcktXQ0wyNERUb3NNeDN4?=
 =?utf-8?B?ZzQ2R3B5R0lqbm9tQzZEMmJ4dkE1d1U5MVFyOWErelhHSFhGa1hIaWVTdnEz?=
 =?utf-8?B?T3d0YWhMMHd3dTJRRzFRZ0d2ZGJUdG1XMklIVHIySW0veUVOOVRjN0hlai9l?=
 =?utf-8?B?aEh1RXNTZlQvb3hQa3JvZ2FNc09NVVBTQUE5YXdHMWU1d0RWWW5OYnFLZDdP?=
 =?utf-8?B?dGRoM2VzRW9DVXRYVWxDRWE2Yk40aGFHRWNJVnRxeHNQVkJDVHpaeWQ4ZE5n?=
 =?utf-8?B?b0JnME9rODAwYzJHTG5aZlFCKzR4Q2JvNGdoa3Y1V2VkRWJPck1aQW9KaWZ1?=
 =?utf-8?B?Y2RTejZFNmo5cWFXRmlHTm05cEQ0QjRPdEd6MC8vRjY3NEFobC80c2swc2M2?=
 =?utf-8?B?cnNyVjhwdTVUdjFLbXRuVXViUjRISXRrcHAvblY0VnhveEFMR3UreXhSL0o4?=
 =?utf-8?B?NkRFbk9kYytMeTlnMWNDNlgrOExaZUl3U3RMb0t0blFYc3o2ZEhzVjZtZkxL?=
 =?utf-8?B?b3NuMW80NjNCUFV1NDJ4MFM4UEVRcUZUWU1Gc2pxT3JhY1lIMDhLQStRbEtP?=
 =?utf-8?B?cjZicjByYTFURVRUcDRUODdVQXZzYWpqamZoZzJHbXFWQ2MzdGN4NGRvd0Zh?=
 =?utf-8?B?NWRJRGtzaGFIdkJwVEc3dHhvNXNsaUgvb3pta2c1Y3NrMCtoY3V4UzNTZGZX?=
 =?utf-8?B?cjNqdG5DcnlJSXFjQmlVRzZ5RGVldUl1N25TaEhwbTBMK1ZXQmMzYmFsVkdz?=
 =?utf-8?B?ZmhUNHg0N3BhNGhTVXQ4N2NCM0cxdUpiMlhBcURUSDNMdU5sUlZMWjNNY0NW?=
 =?utf-8?B?V1RUOVhVSGZ0WHNYSkhpSFNDRnVJVXhIOGs4eE9IVWU2THdwdkJ0OU4vaXZH?=
 =?utf-8?B?aFZnUVkzOXZNQXZwRXJBbE8zRE0yZ0xQbjhONDlOVnNQK1dGbzkrZ2t1L2dB?=
 =?utf-8?B?YmhXWllCL1JjNitiZjZ2V3VwZStwc0JHTTJmU1Zxc0Nxb25qRmxleGtWeXdX?=
 =?utf-8?B?TitzWVVJWUlDRmRJUzEzWEh5LzFyVXJDZGliK2VteVFhOG5LandJTXBYTzY3?=
 =?utf-8?B?eUhZVVVuMVJydmpmZ2h3NEpuS05DZFlrYS9JK2xtUk9yRmZkRitMWmZ2TzZz?=
 =?utf-8?B?dVR3Nnh3NzlnZ2xEdDA2T2dqOWhkRWRieGk0V1F5UmQzRmhpdFQ4RmxZVnZL?=
 =?utf-8?B?ZXRFRTRtZ1RxY3RrMGt6MmwwY2NGTlhLKzRmR2NuRm9aTlhQejYwdz09?=
X-Exchange-RoutingPolicyChecked:
	MCc5wixq3D/J20J9eekYFRrBmrQidomdYZDfnmc/Cu85ob6Ij3i2A24F/p8uaZgImI/X/4uRI98aYnMvWWW3ui+l0GTYO7Hl+sLAC7IxL1elDxo/ffrI7ienBKpS7J+BM5wigRkWKi1T6SvB4dlSaPcByu0OG9aYLItB8hLt1weAlKPJxLO94IWo6jjjj/czQC6+gcIQCxyWIsgC8euMP3h8pEoIxXCM/wT/gSNuR/IeRD/IWKDfDIdtpkdNeDN22RYlElxbG7c5tCqubB/AOTmgDbuWbAFSARaxTI3J0hk8D1zOfc/XzAXvsgXHQOpmseFBhWqB3EivY95jkx83LA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53a4184-2515-44a3-ec81-08df35d5f8b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:02:02.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zl92LBKPjYyrjmkymV7+HpjCBtnvJm8IXMs7j6QiEypmojCN8KbyGEY/jAoFcjTBoAT3/gzezdt4oveGqh7wRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8202
X-Proofpoint-GUID: Q-B979aULDzWn7RN2eLC-UHoNvgiBbQM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX8t7WBgRGME/N
 fO5yictdJ7DSAjvBKoM9EsdcXjxqGnQQZ/VGIdn0cvuVGJKLD7j/DyDWSh14Oc6xiQ3hfUsRpAx
 CxhXYcqArvd0CR7X4Vc47Wf/G19ZGKw2kbvc++4VYdNdYD2uW5JU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX0iKeX+5sGKx7
 RXCLUMVwVgpPxkyE66nfCi8MmfjfJb9V0GhVLV5qyrd6bB7/JxRAPAWFYGxDHOJa+rXbULWjbXj
 b9LmMVwEoO0NgZZqct9caLpNfCDivBX6t2wfXdhbhS7VaeQbX/NlVIhtKCAKErq4uZp343HFzBE
 Y4CO9SNyoNntI67Z5XmZgnjngbqGkn+pcxpQ9EAhxuH1yjXv/UXjcIWO1P7tQihoIpzF3TY8qge
 QICUgVGsa6RyzuoSg3zg07Q+vvEfyTjAAOqvelfO0bvlSoC89pZ7kSxpv9mVxy5O/J0xBRalzdE
 plNlI3k6DVidFqOArYH0GnrwSqtrbyA+F2iEJIvDxFiI52SWXUZPeqW0sk8MeaiBrMw8wJdughU
 e6Mfts12VaH+eCwte2isYq4rBkKqlIUNgNUOxiDyDtBqD2ChJ7cjvicWX8kALBq3MkC0pfZd2mN
 gteHzkeeR+f6Xg2HlUg==
X-Authority-Analysis: v=2.4 cv=M7XYuCws c=1 sm=1 tr=0 ts=6ae36e02 cx=c_pps
 a=htKwazZePKloe4WR6Wq9JA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=vQrPp2G2xGUN3FwHDZ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q-B979aULDzWn7RN2eLC-UHoNvgiBbQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290062

The Cadence xSPI controller supports an auto command (ACMD) mode where
high level sequences (read, program, erase) are handled by the
controller and data can be moved by its internal DMA. Whether ACMD can
be used, and whether the internal DMA bus requester interface is wired,
depends on how the IP is integrated (e.g. external SRAM, interconnect
wiring) and cannot be discovered from the controller.

Add the cdns,has-acmd and cdns,has-internal-dma boolean properties to
describe that. The internal DMA is only used by ACMD, so properly
reflect that.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 38a5795589de..9708ede79730 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -40,11 +40,29 @@ properties:
   interrupts:
     maxItems: 1
 
+  cdns,has-acmd:
+    type: boolean
+    description:
+      The controller supports the auto command (ACMD) mode. The IP may need
+      external hardware (like SRAM) at SoC integration to fully leverage
+      ACMD.
+
+  cdns,has-internal-dma:
+    type: boolean
+    description:
+      The controller internal DMA bus requester interface is wired at SoC
+      integration, so the controller can move ACMD data to and from memory
+      on its own.
+
 required:
   - compatible
   - reg
   - interrupts
 
+dependencies:
+  cdns,has-internal-dma:
+    - cdns,has-acmd
+
 allOf:
   - $ref: spi-controller.yaml#
   - if:

-- 
2.56.0

