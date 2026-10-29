Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289133;
	b=cTIUU4qt64ToIxWjSz9yLmgkFt5dEcuEnE9DZaldVEDKnCBr3MnLqkn6u2eSc3wJPc1P
	 ZF3c5QcJz0YJXxKMYDR+wMlakP9qNwrZThXgXOF/ricNyntUXBWQz0MQi/u30kOD8H5+u
	 xuVPBLPIYF2ezSaPSjrgouEl5bku3+GZBomNNkxrGpDXQ0AjECSzRFnBsqAAs9ENg5Oi0
	 tyHB84UnDCLmyqRnwgtJYwyrnmUiun45uQCWXqrTFR34yZZymp0TezlxK7ye/NUY+O7qs
	 DfpTDhcg2iHsSzl41TNu365iTZTs7r7pULei7h01Chwa0vFXMmePTHv9i9TmyOGvkZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289133;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Subject:Date:Message-Id:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QH2UZ/H4fY9LztefMJAPbtIvjqm9Ye/lPmm8qGgtbXQ=;
	b=vy8d0+MmpGFkt3MynhWaBbqtTZpmn0760sGB/rkhjOjZLmWdGRhA1o8kRrimopLtElj0
	 4vGc6UCssK6t31To2HuGwhoc0kZ0kvs9G3rt9/NrGRTovOzaSkLapUe8/RH/r2AZg1OGv
	 cb1Atjo5e+neodHkAoTavxayLCDqG3J8AoqK3XK1iwdsxSuFJTGqHKRxkv7NASRK96KVD
	 81AO4azu/ljiuWrIG1Gs+gkr4FgO7+2/ZpkX0GBCDftK4wRPkJTpz/cht4xD/cpcm5O+h
	 pwbTjqDfPVwmEKjELAeKxEq+p5mL/7t7Pf7EhUBhec5AHtQm1NCwK9yc9z2jrcU6LBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pCRqvS5p;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cCQa4MV0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D389606A31A;
	Thu, 29 Oct 2026 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D389606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pCRqvS5p;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cCQa4MV0
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TF6X7h2845737;
	Thu, 29 Oct 2026 11:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=QH2UZ/H4fY9Lztef
	MJAPbtIvjqm9Ye/lPmm8qGgtbXQ=; b=pCRqvS5pNAYnwpMWR9X812uv0oxH/LFT
	hsd9S7l8Z9zAQPW69P1TGaEg3Caprz9P54MSmxbr7n0lRH1pGBXtWXxon9m7Yx+6
	96ov/QS7PTYixv/0117ezRDdOI8rpyLCTd3EDL85+HE6OcwonoJDkcxFhTiPi7io
	Rmhs08KYaP9VvRdGjQXHUtr7M8aEyjUnMwAQOuRwYLl36iX65jVAkQ51IxbOxTi3
	atFWkw/rKT0t0r87FN0mgwdYB2XDQeKOkDQCiPgNg+nN4elu9Wd4qTTgyhJMvo+X
	KdDuxipibSdpk2B4zIVJ6QaZKQz134JHxCNxG8dYB/NsV2RTjXSDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=QH2UZ/H4fY9LztefMJAPbtIvjqm
	9Ye/lPmm8qGgtbXQ=; b=cCQa4MV0lqLpCNTZ3cV7LTc152pWyn0uMYaRlJ3Yusr
	OYlIOdlgRZMNkdAab2mHJNHULTZ56pB1S9lNRNvNd2B1VKo5KQNm3IyXZYm4S1wZ
	out/mpdMu3ztlk76MkT7JUZgg4rydaQreYCyfRIw2MXOJqzzul4nUhidOSn0W6My
	atKo8D2yYCxZhvMPCYrMBl2iiBVr2oq5pUTyARgmX3EN8CVYDxJ4cJNeOlaSYbRw
	tgAgSzNY6b5xkQCwDPDwA23R1dztYK3pSXSW+FS7UsN9jZnE1hmKd/G3YJhSi2g7
	K3iz2AfeQtuyilyQbiMknZArHJc2MC8liIoJUcnp/bQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hkrqh5nwt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 11:51:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiI+3DSm2XfBdzNQlpM12hN6+8LTAcDXLeR6obo6qPrba0dehi+LYwUPQrw39gEYt/QXHmd2/RXJ0aZFw5tZE1H4IZGj+h59FXhkBsPuYLlmpfXC83+D/HLe2n+9yU1z6thVHGmagHGIZpvFDYA0ySaVrFQlickQ+LAcVyUtpTi1MDg8X0o7KvvC9TO/2SNjKtQ+SLDlY6kpBwp6Qfyzrv+zWsQvg68O2WmffdPI5sU7Y08o4Jrh289k1AZd69GHRnFGttCCGA+UBujspoMssSgEy0/XZzFuBep0In/uxKc/mhVQANDjgdwBfX8rKIYW/4Nq5NoZ9ficMAm21Ggxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH2UZ/H4fY9LztefMJAPbtIvjqm9Ye/lPmm8qGgtbXQ=;
 b=vSI5vNPITFPd5GPiyFxrv9E9BFHMhlha7k5P+HAiGx+ys1djKfhMVHM3vzqAz7xCWBCrdD27+wtZf5wXBS9q+cVeVevWvA8QguF908QS8BbRa8UGTdxMtBTG6CFb4YB1I4Xhq0038UNotjXJa8xSn9p8Ui0TCezEJGoYs7Y8k1Sk4EkpAHIKaPekIUxM4fPzOP3Usw+IIArCy6fWqs1NIQPmfJlXgBC8k5S5Kq2Wsav5H6T5C4/j8yW1Oipjdf5MHDOseLGPsSyahWqzRYGBQpfzKtb1GsGP+DKFOV5KDrG1Sc8zTd8WjtCiPwxrjk8+L4uQuoUTe/AARUCdi2OQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5853.namprd03.prod.outlook.com (2603:10b6:a03:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:51:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 15:51:46 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/3] spi: cadence-xspi: add ACMD mode support
Date: Thu, 29 Oct 2026 15:53:07 +0000
Message-Id: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQpkHBq4iLdOavjmAsGZVC6
 d2NuvwW763kqAanY7dSxdvcHqWh33Uk11wuYNNmiiHu+xAPvPhsLFlRBJxVOctdeZCAIUUZ05S
 otXPFZMvvezr/7a/xBnl+Z7RtH60e0dl5AAAA
X-Change-ID: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793289189; l=4025;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ea4vrjPf97DX6ystWfrFNof1PLOJUKpNnDo5F8DgLeM=;
 b=fcIEEhtxiLiMB8pz5U5p8+nlM0xMDiI5qI3CNUliXj/dIPEEAEgpdEIBWkib3Z2gv2afCjsIt
 Os/IYLw8/dhC+AxoEVf5Q7CM+wutl3ELVHWr9m8webFrFZwulbDP4hv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a921ac5-4198-4a60-fb19-08df35d48993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|6133799003|56012099006|11063799006|261028144727099003|10067099003|261021123027099003|261021121427099003|261009223327099003|261022105027099003|261009220027099003|261009221727099003|261009223027099003|261009221227099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	bW5v7OHJ6avGwPMpMffFb/fiI0GBlcmvehwMa7erqbiPz1KFmKWiHQ9/vQswKMTj893Yz2dCNl0Co+mAuPisOTrFDAcDlH1UT5M9+OKXbRr/gwuxAoyeDPWaUa81hkzFb7MqMKiAbXA/dkoHtTZjsNE6i3qfAQChwHGzfT5oDvIN8+UHyPnyjIIca7N8Vm3+e1F+tyUObIgyFBX5ccjq+sMCbmlAmAn/u6ctTXPI2rhnELYZBRhuOUi5p9tJHpvW/ZjX7REm0pNfXY4QJRgjNjEoprfd/XIDIF4Ch8XakXtC5/2lyhw7Wsveps1pUzJdG7jr15UU3K6aT/1bKoqPViiZTEjX47LP+43JbAaa9WTU+ubpdnfogLEXG1UNcw+OEZqDIqeIWYlVXXfM5gPYfDwm5YdXShRSo1NxW2SVNxBr/IXCwwM+S97bAMObZUk2+fcvB7ExxzpYAdLixrqB7awXJhV1nctz71NV6IV13OMty5qeFyylHPUmKR6yLPmjFZ6tXJ4EatY5p2JUG4NqW7ITJc8dQgxoq4KzVxfVjxv7Cr4O+2w+wz0Oc3VC+Cx20r6Zz0uZQATqUeQAG6GkRDmvHu5FVlFsFvMNO9o+LdTSCfLmHPHUAiz0cJK+FzER
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(6133799003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261009223327099003)(261022105027099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFtR21CaXpWOXozVzlDT2dhQVN6V0hzSzNTOTBRaTFKbi9xc1BMNzBwUEJX?=
 =?utf-8?B?OGtBSWZ0Nm1CN0ZSNE9iemk3anhwQ0NESnF3RFZBRDVHWWhIdXd2SitBaExE?=
 =?utf-8?B?ZFpJRWFLR3BsTDUyVFl4SGQwT2V3RFg4ZDVUU2FjNW5zVlB3NTRONm4wVDdO?=
 =?utf-8?B?WW4yb0RrVUVKZk5iMDQ1VGdmQUJ0VlJ1NWlJZFNmbzQxSnJXNXN4ZmFkTmdz?=
 =?utf-8?B?SzZzMWgrQzNSa3JMQVFvZGRLWXhKa1MyQ0p6M3JzV3NJdWZFd04zZ2FvdURW?=
 =?utf-8?B?UkZ5TzVIYmpnNlY2amhyUnJZalYxNEtYdHlxSlVtMi9vVkUvYzRpL1hnTHhk?=
 =?utf-8?B?ejlOaXFnVDZJWHRXZ2o5S2Q4bGZRNytyM0RVTUpBaEtDYno2ZWtBVGZGa1lk?=
 =?utf-8?B?VWFsV3VyR3pPR3J6WmNKdFNQSVpiOHkzYXVOQnJ4aGlpa0lRWkE1dGRDbWZ2?=
 =?utf-8?B?dkM1VCswVzc4MEkwdjJCNnlzUGdpN1ZZZ0Y3YjFGeWltUkVqektUOEt2YTBB?=
 =?utf-8?B?L21aeDJPNGNLMzJwQUNtSTZOZVE1MXBlajJQUjBLTTVmM2ZUWTUvYlFTMXhv?=
 =?utf-8?B?WGlGZ0xobjJuMEg3QjhVWHFQcENKREhCS0xWS1YyNGowVU9kTE9weVVhSHJ5?=
 =?utf-8?B?Mm5nMjVDRE9ZR09WMEtzeThqMUpVcUJMMnhycnpjc04wMkVEbUxaM2s3eCth?=
 =?utf-8?B?OW5reGVuSkxXNW0zNklQWW51WWJZNEd4QlFMZ3JhTFFRWldoT05jTGF1eElV?=
 =?utf-8?B?Q0RyamdSbm5BOERGcEk4K2VVM3JFMis4UzNHQVdURWd1KzIveTYzUGpFeUkz?=
 =?utf-8?B?YTlwSFpRME5rZjE1clZvR1h2MmdpUTRFSG1rUHF0a1FvMTNScHExSmVrYUQ4?=
 =?utf-8?B?cWd4YTlDRTRSUmJrOUExYk1TZXJyeE1McTVaMk9McTJoak5YVE5RbUE2b1Fv?=
 =?utf-8?B?bnFHTmJ1djdDYTQyb1ZFdTJOOUY0YjNHaG4wamZqYXpleUxseTJLNWZzRi9h?=
 =?utf-8?B?ampDMjhzMVMxaWVxVnd5TzVmUm5kZU5xdlJyb2dWQm1UUnFaZGh3emxvbWlX?=
 =?utf-8?B?RzJvS2crN2lsbEtGMU9YQWRlMEwyNDFEY3J6N1FHTklOc2tCM0RNY2kvemc1?=
 =?utf-8?B?SncwYUVsdVJsZE16TUV1U2R1eThiQjc4Zmg5L2NMYU1kYVI3WG5EaHhWSStN?=
 =?utf-8?B?TkUwL0d0UnRucTZvU3lYYXRZYzBDV2ltdlR1M2JhTE5LUEJteFFsZ1ZjaXZM?=
 =?utf-8?B?NTc3VHBYMEhXSmZ4ZkpoeU1EbEVwbzZOUW10Q0N1SUkzN0syL0xhZ1NpQVRq?=
 =?utf-8?B?YU5jNWRJbERrZU1KS2hoc0tmSzhNVjlnR3hXZFQzUGpnSHlDUWNtOUY2Y2cz?=
 =?utf-8?B?VktnS2xZakIyRUxnNkd0WlN6ZldyajJETHQrRXdrTFBrOTU2eFMvd05qVXkz?=
 =?utf-8?B?TWxwRVJkbEtMUkhMdVdaMC9RZXdQRmFFVndJZjNmZG55aDd6V2p3cHdOTWJ0?=
 =?utf-8?B?OGxUV2h4UXh2MW40SW8zL1JNdnRVYXhWc3YyYm1BaVNnK2EzbmtnS0N2WUkr?=
 =?utf-8?B?Sm81dUxaS0I3b2JFajB6T2ZCdDVyKzhKZ3Vka2xweS9FdktkR3I2Uk14S3p1?=
 =?utf-8?B?VGJJMVFXeTZOeThySEN0ZVovR1p3V2V5ODhrcWN1MEM2TVljNFg4UEFBTE44?=
 =?utf-8?B?dnpmVVA0bFJtcEdreEdKYitTMDh2cGE0ZThqcWFwQW9GbzNRVnZwM0FkMWhQ?=
 =?utf-8?B?cGtqT0FjUVUzNmZBYUdBT2VmWjZKRjRLNmJKNnBRNjUzemUrcktnN2ZpcVVV?=
 =?utf-8?B?VTdFa3p0UDZxcEw0bFViRzJ0bzFkOHprL0NXWWd2SGtpdTJlMmZUeUhvRE5v?=
 =?utf-8?B?azZGSTNEcFA2bjNMajJCNEMveUVQT29EUXE5dkpITmcwK1ZpNVFmQXJaUE5Z?=
 =?utf-8?B?ckQ4ZFBJQnRQZXloaURFN1NncEQxK1NkT0NWK0o3RU9kTmNZREcrampFSXh4?=
 =?utf-8?B?SytIU0I0NWhRbHh4bGhoOU9pUU5aWHdITGc1blVDcFA5dlBoMVV1UU5FZEdz?=
 =?utf-8?B?aGY5TWNIbUhSdGNMN3JtaFJsS0taZ3BVSjljQklMaGljSHA4YW9mOWtoY3I1?=
 =?utf-8?B?MkJSYXVJL2NxZ1FCQjFOdjJVajB4YnU5aE5HRzdLOXcrVitRRXMzR01pODM1?=
 =?utf-8?B?VGlpbnMyekZuQ2tDcHpyMllzZ3JGVUZ5NjFtNTdpcEE0eHFSOCtScDNtVmdo?=
 =?utf-8?B?UWVMakE4SmkvNjh3NFRKV0liSnJqNk9tQ2k1c2E1YnJkeHVkdGVScmVNWEE5?=
 =?utf-8?B?SWpheFZoWE5pZGRpeHE3K2pnMFQxcXUzRDBxZE9iU1BlWkFTQjdPZz09?=
X-Exchange-RoutingPolicyChecked:
	UAairHN6xiBWy5Zy2E6t5ggpPTck8Exb/aciwyiiFNU7Lt4nzlg82REjuqzEYflkxnepyF+Noulz4QqFfyi8Vyd+Bwdrk1KRkdh5nTAHKnzytQ1W8h/yZbUjqaJsxvB4/UDZFGR7npfcT8LLBX8K+GIRnBnjCIrGkcEGh+CMW0DVjvegwjXX66h0xGGwvmOrz//TNTQpqEK92W5a00cBdr/qtKsxSHDlcb+1vLFgOAYJpDBzULLV+55ObsmFARkPEbeQi+IlOAtX13K44TQKlRjEviP3yvnQhOLLVjslhmM+Ss0eUMMQI+xC5sA7J4ohOKcz/NXwN3r9BipphQqPFQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a921ac5-4198-4a60-fb19-08df35d48993
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:51:46.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8UXISrb7Yvywe9x0RIAmVmQijh6a2Fsz+7K7L7HgTKcbPNvKZ/6iLhXIbjLgD62YVRC0YofD7VIjaQco3MdQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5853
X-Proofpoint-ORIG-GUID: MOx-jrscsrQsGDkg6XKv0QTrxmpAz-Rv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX1UxEWIwSEmvq
 syoLamdbD3ys303rbsNmlNMfA7FUYmYVzLhDNEpP4ajKYByOlqHvvl9BCKnP/G3kubB/uCKLjsd
 hJfol9uVgorTYswddB4KX1Rh5y2DQzDCGmK20XuoOwTELB2ES0Ay
X-Proofpoint-GUID: MOx-jrscsrQsGDkg6XKv0QTrxmpAz-Rv
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6ae36b96 cx=c_pps
 a=rV7DuXtNeKhYS0+Ag8nf3Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=VwQbUJbxAAAA:8 a=AGvDhWosoQo0MtVFrpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX+N0JScmdIfpj
 P76ETUYTVvOgKGC3kn4nrfpXtLztfFxNSqEsjGiCiYyqkf2S/sE9qpo9mnoPR4ew0KRMV+WN+G/
 6ZQuCy2oFiMnicdwNcZwFLUifsSzJqnNYRVlDto7+q/DgbzUqdAJBA0idpQI/OOLhtKlDhm6q1V
 SuCrasP1YPv81iMl3d6UHnoSXuVZAhmdXYDGF+1rWpvzZjk14pHSn2DXUCd+/UUddUBtlqNgia7
 UmdFrFr0t4Vi8s7jMKbyjiWqAEW+rlYql0FIO0qW2d4i3FdgYeGZpTBXgbyHHLPFsjobySnYGZO
 oUsinMF48iurJH2xVBqA3FP4D+EfwQ73iuSqLn+vvVKLrjLJDErEW115bvyQCmMoJlESeGQTZ07
 7p7s2fHO2sSopT5hr3VdoQSMg8Zm4GsSQNqUThz8/6coiF/AEZ2Z/jK2dbEan6IP/4x8PAIdGdB
 ax+7PImoIwb/Xed+YjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290062

The Cadence xSPI driver currently drives every operation through STIG
mode, where the CPU builds each command and drains the data. The
controller also has an auto command (ACMD) mode where it runs whole
sequences on its own and can move data with its internal DMA, which
pays off for bulk reads.

Whether ACMD and the internal DMA can be used depends on the SoC
integration (external SRAM, the DMA bus requester interface being
wired), which the controller registers do not expose. Hence two new
devicetree properties: cdns,has-acmd and cdns,has-internal-dma.

For now, ACMD is only used for reads of at least 2048 bytes with an
address phase, using the internal DMA, and only when both properties
are set. Smaller reads and all other operations stay on STIG.

NOR and NAND are handled the same way: NAND operations are still issued
one by one, not combined into a single ACMD sequence, so no NAND
geometry is needed. The real gain is on large reads which, for NAND,
means chips supporting buffer/sequential read mode.

Another attempt for ACMD was sent in [1] but that relies on knowing the
NAND geometry which brings much more complexity given that it needs a
proper interface implemented in the spi-nand core. So we agreed on
starting with this simpler approach and then build on top of it if we
agree it pays off (mostly on cpu load).

Some stats:

ACMD
-----

SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
-------

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

SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
--------

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

STIG
----

SPI-NOR
-------

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

SPI-NAND (Cont mode)
--------

flash_speed -c 5 -d /dev/mtd5
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 6564 KiB/s
testing eraseblock read speed
eraseblock read speed is 18823 KiB/s
testing page write speed
page write speed is 6400 KiB/s
testing page read speed
page read speed is 18028 KiB/s

For now, we have a static threshold to decide to use ACMD or not. I do
understand that's not ideal. It might depend on sclk and number of lanes
so not sure if that value will be accurate for everybody. So, open to
suggestions if someone has something in mind regarding this.

[1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/

---
Nuno Sá (3):
      spi: cadence-xspi: rename sdma_error to xfer_error
      spi: dt-bindings: cdns,xspi: add ACMD and internal DMA properties
      spi: cadence-xspi: add ACMD mode support

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  18 ++
 drivers/spi/spi-cadence-xspi.c                     | 269 +++++++++++++++++++--
 2 files changed, 273 insertions(+), 14 deletions(-)
---
base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
--

Thanks!
- Nuno Sá

