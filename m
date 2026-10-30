Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793355295;
	b=UDYUBJ3sRcpSrRMgC3xsSoqKa1tPB7zdw7EO6LAjgkpbhvw1tV/co6WNih6AcBVLTxw8
	 eE0GDrIVzaSfoyIMOwQhsqhT3fAJBoMxJQ83oTb1sr/O4+bnysYO+LgP16SNWZdgLdfj9
	 V4bbBp+hiNR/yictLhVCkUETnvUahjRSaReKz71KQRwj6MXfXGu45oHPZYvNrX77M7zoe
	 JqRvn6nbVlBqN2ApLdwk+DEzEXYrzryi7xXEiFVVcR1FaUdmhc46/ypDfL+54OmnhxQf9
	 OADtD58WicsPKsSdlbB55jnoYl35zigHju/yKFyt0S8sRfJmyRDqonfkWBb8qAfesSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355295;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4rSKEoOidr7TeLc3iGLou4gXD6nwjVUpr/E0pdpOW10=;
	b=Qd3chSBKXMqtj4TDZilgdY1WSqgaKbtuc5AeIux0qgPM8d25i7uTXO80VENVIOZOKHNM
	 OGAp+wlQ5QoHahNrogzcb+My4gswGSJqX0yKOPuVH4upPwc37lXMA+SlMg7ZfNTCc9qKY
	 4VOOU5ISSGFLhaF9gCTbAm+bXk3NmFbZFKya4NiKPG2oLgXKteSbh0erQqwLrC5Hmj4l3
	 +HQo4v3U0M2saSE591iykpBwusCyocRpdBQYFU5PIVPAkPt44X3HlmBZqh7dENPxDF6M+
	 sYCbFzGnxLray6eMHmBmrj1CeePtN2eI7ahvd1Xb7cHaEe56Ympvl0iM82NyqeRv2jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Rcf3yzzs;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lAICzBXL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AA606A31C;
	Fri, 30 Oct 2026 10:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Rcf3yzzs;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lAICzBXL
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8GKKq3057758;
	Fri, 30 Oct 2026 06:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=4rSKEoOidr7TeLc3iGLou4gXD6nwjVUpr/E0pdpOW10=; b=Rcf3yzz
	soB1lQugVMuesS/sqwyuzXka97qkHahKAedyvomCQc2jHqB0lSuXdByJCmcxY5ce
	KY5ihET5UWLzjt/P9zRBakCToWd8UW+lBO02BxWRYXU7uYakX32x/8BxZU6BLjPJ
	etYZMoh9TFmlAtU2mAtx7xC6CbdCYpMWGl+bZZ2892VxKeyc74cHcATtIKQGqib+
	hYbNuj8JHNHCnqbdvoYCSlID/RTK2v/Hn3ikxBSXLAapnl6ngzAeiXT+JpZ1Xa7c
	ySF3EnfTfFHsz4rXqYMCw9inUY8XAqCzpQVcR+AfsjCNr5RSoz4+Km5Q3K8IPOcw
	dn1hZq6vb6uKL5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4rSKE
	oOidr7TeLc3iGLou4gXD6nwjVUpr/E0pdpOW10=; b=lAICzBXLP9oXJwXGLKXa3
	LHfec7+FNPqehQ/1++CEGnYvb+XyoTI3Nm9pfpU4t5/RKAPVeWv3I4JhSDulOJWM
	AWNWbMd8zjJaIOnbSvBHSiLwcNTlCQVQVOi+Fo4KfT6RbjlNSpfVExP4rIdWWq8X
	AdZfiG0iw4W/S72WTKGbKETTOUE0U3lz2YJ/DYSEk7nRCnm1ONGonnvH47qM5qol
	6r0wcUsFIgwWuKX+9sBObpKJv856LWbQJoKmYAM4x0bcnt1aqXkXQLBn7Jkx5bLI
	5KhAJZcy+aNCICG93HSxtH2SmrcWhWCUM2q6VHOBr1lh+Vo10vu3AJEiMZOaI6KT
	w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b35qt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 06:14:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9bEkfWj71/Zhat8ts6MqKjF4Z8qbIgcHphu7fqN+8Obdy2G+qFoVnovPNsqJj6RNANukA9cvcso3BroQyE6IaTvxyRkGXKdU7Fpm9XyeWU13DRcmmkV+HgMawqwnwlXzyS/B+SP1PmZRVIYpJoB6f/Zi3SD0wt06LJX1VdUjW7b9h0Q4NuO3GS29V78n7bX7fr+FvPlk+68Y+cVMKfkdSrifN/E35xLF53eGh05X91SuQl5q3t0wm5o/0ZWFhfzoL7ehqe8l0LqvOgYbNTfOjV2umyKLfBwAOKNb/F4jul/evuB5F78GpyDEuOEe7FC2NTBT5L1Cmfhecr9Mq8QBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rSKEoOidr7TeLc3iGLou4gXD6nwjVUpr/E0pdpOW10=;
 b=ikEdfobt4jOaaID4YIJ4EnRn5X6MKcE0SEfZsZsHlEX0CfkO9GxcS5+84ctgk/xYgCvhZgJNIamJ6rDapZIgzHPVVE5GUzzSW/Bg5faDzXaw2S4Gx43wQjfVuNWWRlLGWqy1dr6T6ja6ibQJKoEB5ENDzVrRkEiZ3b+ouLT6aU/rLvPEDNiH2H988MI7pkY82SpiyPVmRyd4HKndQo+VQejqbIlZBtHKA3d95DxQlC3+iSLSffF85hJ+YgX1uQjS70EL1/ULYl06ocdoY3BP0YZip0T9XcVBYrvKVe9sEL6wCi2pnVFK4VTsEzY7QmkBjHGFkWr3TS+NGFqRfK5zEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7045.namprd03.prod.outlook.com (2603:10b6:510:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:14:37 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 10:14:37 +0000
Date: Fri, 30 Oct 2026 10:16:00 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <auRqTXctbxuuEfLL@nsa>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
 <179329269255.62540.11497211982924609522.b4-review@b4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179329269255.62540.11497211982924609522.b4-review@b4>
X-ClientProxiedBy: MR1P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6b9703-c175-4168-19c9-08df366e9a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|5023799004|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Zfy34SruLP+4gjQDHSWg2vrMSQhcOUNOmzpuZIzrm9KQ8B9mhgUOGMqOm2jvkLrRqJFIxntBU5LTreaNyI2QZ+rwcqHI1almSSzc8gS9LB3IAE3RC7fBcnT6tSTR0WbZbHWI0lbs0Vc5zaYrFn3V/r4sktmQlqPeYG6a9TmI2ZoI8FwPeMOGQv2GBfLpoQbaaTVVsAaAarAIf9D2zUOdb2voAx26WVOKQ2rSSDrcYfXfM30yzPu9HP8D2oHRHiiaT1T4amD8HE3mRbdG4Z+azZG2LrQgai5XupX4pD8k+eWmpgLfrPFlNJp41fMZYMhcd6/UpaLYn+ECthm6T19HuHtRfBP89kWyk9qG/XeinRW9i9+EuEoHTmmBbmz78mm1RQHsciA0pTDUZ3wF9Rwb5I4Z2g0OqpzOZjq1KPGgAx/pKYIMioaDiapNd+jUQs4/fqxdP7o0DfsjQBxmm72vCFanZ4xu+rrWNh+LQ48cKJ/68Rx91JtjJ/STzBPlTfeojkKhuHgwErz/pEASEqN1pbPmWX+QQ/R3FQuXpZ2smOZTYcfILCKeAKVVkJ8v7zmF+mHF9Llxjz6gPIyguZokOaSghqAWwig99OsO2uZKUjr4I73yB9LlYsKKVCmZP/Mea2gnx50PvHskVnLzCe8MxXtoLHTkS+J2sZD5uPYY7io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9NUDkydFp5dUJuRmQ4V1NTQzBjdENYbVV6dWY2RkUyUEJLMGk1TXF4NzQ0?=
 =?utf-8?B?ZFJIcGIxbi8wVUdkQnM4TVFuV0lkVG5vV3lHQW1lOXhmaDVQdWx6ZzFzQmdF?=
 =?utf-8?B?Vnk3S2RqdFBIY1BTWXY1WmhFbEJYWHhiVXlqUDFCTTQ5eUJtaUtpc2laTEdS?=
 =?utf-8?B?SysvemhZTzcrdVRnVmM2MzVZWUw4M1hKZ2xyeTFwZFpYRkdZdnRzeGRCZlJr?=
 =?utf-8?B?cmI0R2lWTHdUNHg5Sll2SzlqSjlvU2pNcUZYQlg2WTRmRGVGcVFwNjg4NUF6?=
 =?utf-8?B?ZG4rcDltVzFVUGljRXRYdVlmT2pzZ0k3WWFtNWJoT0NNYTE5MHpUajVIalFP?=
 =?utf-8?B?ZXNyMjhtSk93QVVKdTFFNmNXckZmdXJyMGlPcDZxWnNoZU9EbE02STBrMnFv?=
 =?utf-8?B?SFMzOWxwYVBFSzlwU3ZyeUpFczNKaHlxOGJLMngxZTQzeU1sc2FyYm9NYVkx?=
 =?utf-8?B?emFTM3FiQ1o1cjZIK2gzNkk2Q1pWUml0eWxReERJTndQMXdVSlZEVnNMTFly?=
 =?utf-8?B?b0hNUUlGV2FiODA3VzRiYldVczg3RVVOZXVEZEFpT0xBKzQrM3RzTVIvN3RY?=
 =?utf-8?B?Nm9yRGFpZjNHc1lGcGdRZkp5bkNkVkZBS0hqN2IyaXZRcWluQ3U3MzRGTjQr?=
 =?utf-8?B?ZVdwZ1dHQ09pMnUvUU1JdU5wcWIzQ05IV3drd0JrOFRHMHkwREUra2U0RGZu?=
 =?utf-8?B?M1FGN2lKM3dIQk9OWnFLa1NFWGVFeFpwQUsyaXN4TFJaNGZoYzIxNFJHNjky?=
 =?utf-8?B?RWdQYmFaUEdSWWdkYy90ekZENTB2K0dDL2FhWHJldFcrZHdTb1JvZDhydVdn?=
 =?utf-8?B?anpMMUZ3NHpOUXF2Mm1aNzNCSE5YMy81TjFwZlBZck9UTGVDVVpKcXFlbzV2?=
 =?utf-8?B?b2ExMHJmbVpIVXhMcnM4a1p3NGdHcnlPa1FnampoakoxN1JxQmp5UEpjRDVU?=
 =?utf-8?B?ZzhUY3Z1eklpMXRld0QrT29xZnBlcFVRb2hyQmlTNzZ3NG1CbEgrNVI5ZFNC?=
 =?utf-8?B?VXlJUHJDUDVMYXhQcGRFelVpY045QVMvcDN5djV2aEMwT3RHWXdQRGU4UkRu?=
 =?utf-8?B?cFBNZ1N0VCt5aUhtODM3U2pYUFpScGtQOVBRM2lvNkhwajhUeFpncVhCV1R2?=
 =?utf-8?B?dEI5NjExUEQ3a3BTTXdvdkp1WWV2R0hkWjk2M2VVUVF6Uy9DMXNzMW9zcW1D?=
 =?utf-8?B?b3czUkJlQkZRNFBRS0hrckNoSE1FQUorbjJ2aVJaZTNnbUZVQVlPbG1DRkNJ?=
 =?utf-8?B?N3QvME1NUGg1ZDlBbDBTSFhPeThiS3BIRlZ3OHcvTk1rYlM5RU54a1NDenNo?=
 =?utf-8?B?bzY4SW0zSVUyOUJQcTAwQUFKQjNyUVVhK2R4YXBPWDcrRlZQWis2WG9SNVZ4?=
 =?utf-8?B?Q0lZQTlMd0xLNXJWczE0Y3BkYzZCRWNTS0tmdC9ORXRwNDcwMDI4NG5uWGJ1?=
 =?utf-8?B?R1U1SGNvU2JMSktYck1qTU5KdXJxVTNMbWorWGFFSmNwNVpsbWlJZytzUVFP?=
 =?utf-8?B?T1dPMGV4UlZlZmJ3bktHYkw4Qk5VYzVwWVhjampORUFyTHEyd1dGOWY4eVVi?=
 =?utf-8?B?RmEwQkQ2bzFsUERHUW5Qc29IdjZncDRIc0Fmb0R6TS9UMnlQY3dwV2R2OUoz?=
 =?utf-8?B?K2NFRlVzaG5XSS9BMVlSeUNSOXdzbS81aWo5bWd6QmtZWTc4K2FuTml4UFlX?=
 =?utf-8?B?UnhzUmdYYTliTTVRU0w3aERxVjlDUUZUTUlhQlRlRnBrME9LeGordHIyZW1S?=
 =?utf-8?B?N2dWRTMxeDljVkVubThadVdLZFo5NnRUajZibnQvQmwrckJIK1NEWHlFb24w?=
 =?utf-8?B?eERrVkxkVUhjQi9OSkZZd2VLOWhmWE9YRTlnUEx5elpHNWNoTzE1dEpFd0Nu?=
 =?utf-8?B?NmhIa2xya3hYczdvc1pKWE8wRmZLMDFEZ1dqT3VnOHlRcHMvenppM1ZXNTJI?=
 =?utf-8?B?MU9Yd3BYaGs2czFFVFlHUWlXd1d4NjU4Q09GN0JzbkxuY0JqNWs1NXlSWjYx?=
 =?utf-8?B?cVRGZUExZlFEMmNMOTJvTVBuNStQT2k4QnBMWGhsR3ZBcEdrdGZCSDl2RTc0?=
 =?utf-8?B?MEx4ZW9pb2VPaEJscmY2Rlg0OXA4K3lqOEg1V29qUDBGRGkwZ29KQ3UvWjJW?=
 =?utf-8?B?ekZqS0IwOC9vSDlHWHI3eVF0K1V3enZ4ODhYRkkxL24xL2xOK1BsV0pFcUxn?=
 =?utf-8?B?b0lnOEFPMmhRTEVaay8rWVhXNS9aa1J3eHpVN3ZrMlo5WmNaVjdJUUNlVE5j?=
 =?utf-8?B?cDdZZkMySGtUZHUxd0ZoTW5jZE93Qk41RzUvczJIYVh4cis3Z0tnclJEZEw2?=
 =?utf-8?B?dE5sSXpiWTg2UEpYMlhpL0Y0TlRDOFIwQVV2aS9VQW15Y3VuQWVxZz09?=
X-Exchange-RoutingPolicyChecked:
	r8jgDQGlgrnjV8toQ9fleS/hJHwm+xB4tG6fLTKjjCKGx3lKAdnW8VnTkFNKfvsQpg8gi2Hk7jYoDwPkl5JxQnIqOpt4O/ISz1yxsLnR9H6Q5a1KySRdd2l/XrwouAwN3rJq37jo8i/XxX40T3jW3DW1kNHGwWBOJQonnITzYGbto8PX5phll28cp1wpmi+illOv1YhSmMVA24vMuh4Wuc1PD9SeqmjL/Grbav0eEziSKJru6fHS7v2JkVhoc08cu0saKhV8AWAd08r5QroX7ijHq/8IbWBbfCTny8rXI/Imvh9ud+FlteF1MC8KHPy+9BZ6UCjKbVGMtUfqdcm3MA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6b9703-c175-4168-19c9-08df366e9a27
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:14:37.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b72TK3osllHDcTBhYIGSocX/GlfKT0vrCFaiqWSiC0rNdK5QhMEQIJ8w54MnMcSsa7SMIohWzJyoRkMtZOa3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MCBTYWx0ZWRfX3Aaec9LS6Dxq
 a4GD9LV9GEIgGKM3g6nX4gTBN+P2e87dDUFiZo1gI4vnuyMYaaqEAG2UzuM3sI927GhbYbyzaq7
 710KOQj1RNNz4yG/nGAA6bW4eBzx4xQTGxpLab/70bFBQs5YqDybPJ5NBe3k2MqOfGN9QWwhMI1
 WMOYaSUJ91BrH6RsQv4RreBlFH5xS9abaGEJjF/fJZtuShBQlV/i6jNbN5+ih3+MFuKfu4tSuPl
 cfCG9kn5W6Uoxa6VZZJcPInt1VCLfkZK5u2oH6cEx24HkTu/8APW2t5fmVIH1SrTzKww1rc6avc
 k9n3w05QKdKpeDqsKAN3vRk0BS6CpfDsLTnvRdmjxCdK2VR54eTFBMsqy/d3jyNAhlc02fIF+vp
 JkMX9QTJCbv0vsXPv/b2Y9yO+tOxrJmjl9vxLgPsYsw62RnLFIig2L+0atNIIXCpk21806LiIIC
 xi/9OzTOJsTmRrEl+4g==
X-Authority-Analysis: v=2.4 cv=UMJIjyfy c=1 sm=1 tr=0 ts=6ae46e0f cx=c_pps
 a=LawZwnZ+dX5EiMlPDlYRuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=xMtXEWJbyEUXYPCWiGwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MCBTYWx0ZWRfX0r07/ko6xcbi
 UhSIGWfJ/8cwTPWbs/6qEdwXvAKq0F+QsM0vp6mY5WNPyP5w6SJepl6ZfMiiaxaTeUKAbkkIPQg
 9TOjX/ryRHkFKNYMuy5SYgroq1GW6MQW8S4YMOqnsYYZT9f265v9
X-Proofpoint-ORIG-GUID: MPCOaJfdXqVvuRQ2_L1omyigC_XBgvtq
X-Proofpoint-GUID: MPCOaJfdXqVvuRQ2_L1omyigC_XBgvtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300040

On Thu, Oct 29, 2026 at 04:51:32PM +0000, Mark Brown wrote:
> > So far every operation goes through STIG mode, where the CPU builds
> > each command and drains the data. The controller also has an auto
> > command (ACMD) mode where it runs a whole read sequence on its own and,
> > with the internal DMA, writes the data straight to memory.
> 
> > +static int cdns_xspi_set_work_mode(struct cdns_xspi_dev *cdns_xspi, int mode)
> > +{
> > +	int ret;
> > +
> > +	if (cdns_xspi->cur_work_mode == mode)
> > +		return 0;
> 
> We need some suspend/resume handling to invalidate the configuration
> when the IP power goes so we set everything up again.  I'm not seeing
> anything here.

Yeah, I did saw sashiko complain (and my local LLM also raised it
actually) but I do wonder how can that happen? So we need to assume that
in suspend we might lose power (maybe because it's regulator powers down)
and need to do redo all the important initialization bits?

> 
> > @@ -677,6 +893,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
> >  	struct cdns_xspi_dev *cdns_xspi =
> >  		spi_controller_get_devdata(mem->spi->controller);
> >  
> > +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> > +		return 0;
> 
> That function has a minimum size but not a maximum size...
> 
> > +
> >  	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
> 
> ...which we have here?

For ACMD, in theory we can just configure UINT32_MAX on the register so
not sure if it makes sense to clamp to that?

Unrelated question,

Conor is pushing against the new bindings and that it should be inferred
from the compatible. I tested this on [1] which is not an upstream
platform so I wonder if it's ok to add support for the complete
integration even if the SoC is not upstream?

Long term plan is definitely to upstream it but we do have a lot of debt that
needs clean up.

[1]: https://www.analog.com/en/products/adsp-sc846.html

- Nuno Sá
> 
> -- 
> Mark Brown <broonie@kernel.org>
