Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403352;
	b=p+pi/85mfk7e30h/3wEIboOtBFkeBemKnsmoicxWKDQrtGyzoPPvupBEMVOhMp/809Z+
	 xuaYPWBjuv6G5A/7mw4dOwcgdvLW7VzmvkE7t8GQpYPQz88485FVZUrpfqigkR3K82mMn
	 WYIpHiAg2nLGW90bapR7PPOYcp4rT5F7ifWxNL5A502BT6JImSx81mTORZKL0zPqyq2M6
	 ypTrzNxpFyA04CT7h+tkvQhOIbJXVSPqV2puz4uPdoQii3hyVxw3CmJ0lbKjFLvPyzXuZ
	 /tZB2QtkS25VD/vw1vsxBMK6hCOagXKz0zwjgQRcl+hAH5vQ65lkBeQ0YEC+UwGefhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403352;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NPG67XUdJLQ8Ojc4fHFh2NN+x4vnu6VuVTSXY2S/nhk=;
	b=SE4vJjV+xB5SzfZfkIvv7o58hJeTvJb4unpRAvH1moFmoF7RobPl13cvI3bkncwAWqiM
	 OTQJHaDmvHrQReqqQocQQ7x0PxGbu7dvSD+gP69yRQiyD2nMt2oD3uKUWoXp+/IVoqCzj
	 yBxj7TWM7c3o9hX2x8XE3z8yt4oUfMCiwTUgaaMl7gS7wo9JwkGddXNSOyWWWuG8OtmA0
	 /nAPLVpZ4TRuSRCs5OBz9B1x3pOzQ94g4KWsNi/v9I4aoKIgqY2oUjDJnKMF+8pIf3/M3
	 M0xqOIMOilyhRErhb/bDuQsm9Ucw9WwyNrxwHkhK53t5OtvjpOUOudmqEQUTHwsPTig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uMGMSxcD;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="ZPG3/yj7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EC60A2601;
	Wed, 11 Nov 2026 13:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88EC60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=uMGMSxcD;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZPG3/yj7
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWG6n3230321;
	Wed, 11 Nov 2026 08:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=NPG67XUdJLQ8Ojc4fHFh2NN+x4vnu6VuVTSXY2S/nhk=; b=uMGMSxc
	DpipLvuekINbqjgex9vdz+liWxj1Mx8/Yk+kg+DO8d4SEl503IeBO2EFsIR7j92D
	eEgJC5zNvo1zljDdVwN2djlKSnkzuTo67SBryY63ur3zR9+5HfKj5Zs6m5p9elO6
	4gKvifahcg3166kJVqsaub0KPdog2/z232M3zOe6tUS6GiaczGeICso2aqWlKTN/
	Ls+6fO8ys295md0yzeGy+omlR7K3ConQP6WHOBSgesoCcHVmnSlGsyWCAuN3TwGt
	a9Nr6dUVaCa2Y+mJYOf+7ATOKtlVdHsvJsG+/mouzbuB60yHGM3Z160B+m6utU4S
	5WNpcomjVr0/BGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NPG67
	XUdJLQ8Ojc4fHFh2NN+x4vnu6VuVTSXY2S/nhk=; b=ZPG3/yj75TJrDyHsP7FMj
	PJTnbPybIEcjrm0b8O8S6qC7090F4Ajj9dReVEc3gBIwJWM8HvMYMNMx8Vo8iuDd
	luUSmsb9b90kP44+Z94Nw1hfZTWvsK1xL+VAT1MdE9wU8wDDcr3tjNJNNW2Wpt63
	ptu4SSoj2ABiGi3Gadzi7ARcsAGsQLx/hCQ8dLjY3A7+VRny9qg3yRQMnPkcuAqz
	iikfqdvWUrPvL2NTTRFrbLeoMADGYiFTylQdL6RgIWQkkmLWxJciNsKlrsqxsqfk
	d8hypey9/h3OariLXMNl/suiCWUPz49gFYnXhpfjLWZCRWY28B2XuHXeYfwoNBXO
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hvjvpa8mh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:22:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvI5V+LkSSooZKF8+7gdxE5uLcWwfpWQcFUQ36a0O3Ao05VjW9kJrmJxyuE2RzxUpk1fJx5RK86652RRD9dHP5MCRGPkbE0/16uV6Z42Dx/Yyjl5NSCo9Op0k/y1gPCnfXPdXjncCvG6QffVNYudSGZalD3q5UG9J9otqo+67XZjjVl9nhR3puWH/DSsvlCzVBHzRrJiD2z2EVgojnbp1C3O754pmBSEExMWna3OJclzCBXynEN3HOWxL6v9msPBBvEXIFk/Tdp7lEi5JvuxnnZxaQ3gm6ZZEZJ5KdhTDeBvoN+UvFEOBuQEv+PdiuhOtylFRVq115wkV2OjqpW3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPG67XUdJLQ8Ojc4fHFh2NN+x4vnu6VuVTSXY2S/nhk=;
 b=m8SxzRb6zm+VKu3lbw6eH2ki1fFzoPjtAoc6Xg3WkmfyO8Tk7QKUbO2DdRI5uqrJw3k8W9OzpDOZ+mFLycA/mfMRjZVSyeuHrpCqouYfluhArLswmGgMSHDsSrK79QZYtTXPmwXGzKkEm92twt6Ajh0jIpDaNfgEwMra+VFPBvMOcgxo+wmoiPiMUYYKyMLIQjD57ck9pjAsNzsOKkWpIO7oeAqQV9GHpYPNjtqTM6tpJqP4z6aoRiZyQzMcFHXPB1aMAZLqR6yUyylaDI6ZUPcAMkE/CjjTdff3Av6oytO/RgxCA3up0gl7BSXyWU8YUN6gahfWhWweQ7S4ktohwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:22:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:22:09 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:08 +0000
Subject: [PATCH v2 7/8] spi: cadence-xspi: add ADI SC846 platform support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-7-d339046ada8b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=5060;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=j/uVSnFFscOgWkc5pOtRWPZiLw53yn3gH2ZcUeHduRg=;
 b=RaM2FZ0NiGyutamuvYzt8JRZ9Q9WTNTFvxFiTS6o+3e/R9tE6zx/H8/R1YBs/jsjzK9wyK/VE
 Le6gQCmYl0+CCEDeaUI9nBdfSugm0cS+LI2gsi+T3GI35zhMKBY3T0y
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a937b940-d9cf-43a9-67a6-08df3ff6c9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261009220027099003|261026121527099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|261021135927099003|11063799006|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3frqFF2R9qfZQP2/Glu7TT97FVhSqZqQFnCaT7jBcDqpEF7W0Y8UEIHnIBHiUOwQ2K/WyKpYUpmHQwTv4NLqgZO3gvXRVs6KsjRmnqWRHYMAI1r/rwKjLbGfIeyHbOTRpF3Sunl5LXcrahnIVjOgQi+sNvs475bAYYplu04DGjO4/TazQ0BcrUdhMTscSktnNoF/cTcX874XN1Jm7l9IuXxYe5GZO/mjFuIywIP8hcy94mjNzIfliElcyHW1LnOV4Wl08tmipZGJc+AD5qOGT1Dg2vQPaAuA8vDQKUysPk3A3zFDXpXhyWoodX1S4jihLIrUolgD+/54Ej2JkGgjTH1FHwFbuU+A9wR7wDGw1Cd5Ki9u4kV/ADmQwRFesFmr7LiBCtebSEMAFt6HpKxKPYz50ZTnRzlupbY75TFMDnixmmukn0OyS1t/XrmQGzViN3PzbYAKSZd4AAd7VWiXp5/vPtxzc9CxZSgD7oI5/gBziNvvov51i7QEPhQ4Hi2+ZVk+sASKfIEMCxFRZktxG2H1u/nrkj1havnBND+S0j0cS5rdczIHtdFMmDJYIAz147Ahku1hc6X0XeyMf6et6Mlkegt5XaA+zs7W/YZfO9HkQfeg1+3yBeK0XsSXBrrJU2A6jhSZDrRBmZ3wcK+JQn1u45NsXYKYwzGWwfwDVQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261009220027099003)(261026121527099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(261021135927099003)(11063799006)(261028144727099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlZhSVFOZFB5RlVTY1BZTDBFWGpUcVBZNXcxNWF3aldmcGdCeDZXMUo4TnZ1?=
 =?utf-8?B?SGFYbVZYcG93dFJLeWVWMVRNMVh3cUlqakhkVzJqYkVXQmx1NHVZMU54TU9p?=
 =?utf-8?B?cWFUZ0R5dHNiN3lPc2VJRldrTG9oWTJkUjRJWHlaT3I2d1psMVdTMDNMa1NM?=
 =?utf-8?B?MkxnK2hVajdHN2pzMVpMVFNLQzhYcVVibTRUdVB6anFDMzMyREFNdGNTdGZy?=
 =?utf-8?B?NDRtMER6OFV4VG01NjdmWmdXa1k0eVJXWno4VnR3WFlCR2NQOHQ5VmtKbnRy?=
 =?utf-8?B?dTJTY1M1bm1KSHdXR1VxcnFoUDkraDZYVmQybnFQZXpaVzVmVXk4bVh6d0ZE?=
 =?utf-8?B?YXpBUlZTM1BaK0YvbERLTFU2MTM0MXBnUEVYUGNCaHl5NVI5dUtzVVY0TDcr?=
 =?utf-8?B?MXpPdjdHMDA0Y20wbTBDWVZIeXlIZXljZ0dXdzhnR3pzd3NuOTIxNzA3OFQw?=
 =?utf-8?B?alNaTmdteUJ5Z0ovWkYrdVg0UnVIY3ljbUtZUWpRMExONWhmT3ppcGNSYWcw?=
 =?utf-8?B?cFNjeE5neGRtWThKZWFaa054Vy9PU21oSVdYSVBhRGo5Y2pDa2xJdVVLNEdK?=
 =?utf-8?B?SFF6ankwQUF1dUpOaThkdFE1dE5Jc2pPZ0lKWVdZNlZ5eUpISXVNbjRuRE1y?=
 =?utf-8?B?WEFUdFJXaXU3UStlL1A2Y29hQ0NPTkxha1RmZ0Q4L1ZYVEdPL1hDYXdvWlFt?=
 =?utf-8?B?dFFQbURZN3hKa2xUWjhWbk9MUVp0WU82c3owdEtoenF3dVZHTHhBU3JkeTd5?=
 =?utf-8?B?OTlNU3h6RDhoQ2d4STh1SVREZjFQc3hjWTVlRUZlc01pS3kxSllmR3M4MmVJ?=
 =?utf-8?B?QkF1cDZ5NnNzOTZ2ZzlWR0RVbExULzJaSXZHd2hvNjFya0RDQ1FCRUhjNWNq?=
 =?utf-8?B?V0Y5MVdLZnVXKzNJcDY1Uy9HKzN1MnRxKzlQZEw4Y2ROVmFsbFN6dU5wSmt4?=
 =?utf-8?B?M1BoWkVtaVRSUHhuZDF3c2dVZ29FSDllWkswaVhXU2x0TXUzY3VET3VUZFk1?=
 =?utf-8?B?T3A2N1BPRXcvWFZVUTA3UFlYODl1dGRxVzlCM0s2eDdZOENPT2ZGb3dIekRr?=
 =?utf-8?B?UXd0MGMyN3NhcTYxZjQ0KzhhR0U3dHFZcmhQUFhjQStjSmpiam50RHJoRkVj?=
 =?utf-8?B?QTRhS2NyWnl2aG8yaFFoL1ZJTXN1RVorT3dWK3ByeHN4dUpNS1ZYNStqR0dQ?=
 =?utf-8?B?OEIzeWZZM0NKeVhwV2xTYnJlb3gxTVVRa3IvR0FkQ1lIdFdONm00UGo3MjNH?=
 =?utf-8?B?bklVRWlyUUFZSElScGw1dDJ1WldYc0RSN2xJVGxCczdsd25wZFRvNU0zRS8w?=
 =?utf-8?B?L0dZY1M2VlNVQ0w3em51SzVTSHlIaWRyNldhcVBLMW9WTzhEenNrOHVRRHUz?=
 =?utf-8?B?TWZYVEJjYVYxTXNsSGRKNkFockViVkU3aDNEZlFhTjVDd2U5TEVrWHJCbUpB?=
 =?utf-8?B?N3VUWXlLOUxCdWMxNkZwM2dCalR5R3A1RFQ0YnBjQmNkMHhheFV0S0dEdGow?=
 =?utf-8?B?T1lGWlB2NkNUako0Y2N3SUUveEREeHhaU0FVWGx0eThOUUtydm8xU1RnbHRO?=
 =?utf-8?B?dElsZUNyZnNSU01kWWVtVHVFaXlzZEtRSGNOOTRJUENhN3JWeEs0aFdkTUhn?=
 =?utf-8?B?MlNRd3B6b1dtdzJoOHFNb1k3TUxDMDJNSWNxNGpPWlNmQVhrUm5Od0p3NStm?=
 =?utf-8?B?ZGtHWmhvamFOZjBQMkJOcUx3cS9VTGN2T0FFMDVNQzRHeWdDdzl1QzhUMWUz?=
 =?utf-8?B?UlVPUFJkVnpKRlNWWUh2SnZOYVJPbkRnMEVKSmpSKy9ZZkhQaXVxeWd0Tzh1?=
 =?utf-8?B?OHo0WlhiekJNVmFNbWo4aTFVaGFuMnFOTE9GcGY4MGtaMWFkOGY0L0N6cTh3?=
 =?utf-8?B?a2cyMk92Z0JKbGRYaDlucitvYndPaUlCWnhUVDAybEJzbklhdWliRzg0ZjZt?=
 =?utf-8?B?cjh2TmVTUWVhTEh2ZUY4bGNUZGR1WFRYREVPa21Kb1NIMUJLbkFnL2JUR2J2?=
 =?utf-8?B?YUFRMmpBNGNTU3FCZ21qNU5hcG1FUFgwODVvbkkvcXRxcVAvMEQrVS9DUjlp?=
 =?utf-8?B?cFBSM2FJNGJySi83aVV2ZTRCdStRem5vNmJrakl0SkN6ekpmY25KNmIrUDhF?=
 =?utf-8?B?ZDh1dUFqL0FFdDlVbnFEVm81UFRTdGdwTmI3aFl6Q1BiK3FZVTZham1iSWJF?=
 =?utf-8?B?K1lENWxqSXpJRVJjYlNPQXU4bFAxSEx5MEhaSHZEZUVrOEMvYzBrM2hOd1Vy?=
 =?utf-8?B?UmwxbXk0K2ZxWk9MdHRvdGxWWUZXMXo1d2lrZFY2ZUhWL1VzOXhyS24wOTVS?=
 =?utf-8?B?dWw4RVpmUW5vRDc3OW5iQjQ2MjYzZXRzbFluWEN0RWNxVUxGRnJTQT09?=
X-Exchange-RoutingPolicyChecked:
	FhV6n1M8fIVS8cZy2HytJ6v4ZZ46B6aoctMLJKxjItjX80O53tCh4o6VZEPJQxcD11+vnFsBEezj3Svumr8SGDc9jfN0xlrPRPvN6yi2y29BclS1hFJG0w9EqgZpkveOl2YYUa2nSCOOvK8miInorKzP6/nyRryoVAXLe6GHK/puC2FUbMFOdJvIIBDXpbCqlqbRi8IK1jFIW79CI6mVvv5fEgtNe29NivICJJYa2FsqxVwrQQjg6lU7jlEKxwdy/aWxk6nw4nSFQNiyRxS0ePgkY8+3FAQYj8eWP+o11Q8Btpvu0vEuq3cjVdBVC4+6AXfRazuyE+SpJXkMyFMYHQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a937b940-d9cf-43a9-67a6-08df3ff6c9b6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:22:09.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKqW5s6w2gRwh7gtiD7Q+uR2LD7Qfwl1XcO2BnldAkhfLmC27b9WyybrquEYv2w0wrDgaK+bJQNqa0ZViV9eSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Authority-Analysis: v=2.4 cv=bvnZl0ai c=1 sm=1 tr=0 ts=6af46c03 cx=c_pps
 a=JigUrrSO7vm3KiUpdjzzBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=R62x5OX-oynB5HbIHSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: v1UPIXktQM8FdTG3526Hd6OE2Q06Tix-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXy5+zuC+yUr9o
 iSKunK26gebDP2/GLG0MVnUx35zWRmDJ7eQjS2VDzbi1/TybcPvruvyghwP1H4AdeinWSHSrnlJ
 29Enf2Axn4RJzcSBYeydmMdUL8QvErZJ6KtdvOH/oNbtJC3EHFX62HV17/38AS+ARpeHMF5l1lt
 tVSxEXt4rY0g8j2ZvHiGLmnMjaBfFnNym2A4Jz3L2xlz95neJ2mApurUCRwzOSRIAhnxh+akwwu
 C316q/nlK1QbNxkVBtFOgPFWCXP9mHaPbKt4Lfz5HNfQD27crOnuHhrkE/o77xNw69oSF+6esuL
 SvOc5ql/Iy24+IdHwusDQNgPPoJ45qWeboLlearetqX3f2OQhCPjRzLnnS72UPyUXDo/2yqtHW0
 /nRUYfDr0dZr5+Sc8yx73lwyN0OtpTO5tNbcBtDumBvImTjEafaEJ+4qCjQfgvPQHtaIGN7/rXc
 V+iLCN7sN5ntcgSfJcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXwM81d5Jk7xYg
 Vd9+B/+VEvZywtPOWHarR7fgtPwRrJLFRid3z7Sd282TIDh61l8WBg6K0gLWHeMTs7gQ9DrNcVp
 XQdiefL1QZclvaP7v8a5j2fQuQE/2UCMHu+MMJwuqhutU28PvokZ
X-Proofpoint-ORIG-GUID: v1UPIXktQM8FdTG3526Hd6OE2Q06Tix-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

Add driver data for the Analog Devices ADSP-SC846 integration of the
Cadence xSPI controller. It uses the generic Cadence memory operations
and handlers, and only needs a hw_init() callback programming the SC846
specific PHY settings before resetting the DLL. Being a hw_init()
callback, the PHY is also set up again on resume.

Waiting for the DLL to lock is done on the PHY DLL observable register
rather than on the register used by the Marvell path, as that is what is
documented for this platform.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 75 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index d592512dda63..55b37175f08f 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -42,9 +42,15 @@
 /* PHY gate loopback control register */
 #define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL	0x0008
 
+/* PHY DLL master control register */
+#define CDNS_XSPI_CCP_PHY_DLL_MASTER_CTRL	0x000C
+
 /* PHY DLL slave control register */
 #define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL	0x0010
 
+/* PHY DQS input enable timing register */
+#define CDNS_XSPI_CCP_PHY_IE_TIMER		0x0014
+
 /* DLL PHY control register */
 #define CDNS_XSPI_DLL_PHY_CTRL			0x1034
 
@@ -235,6 +241,14 @@
 #define MARVELL_RFILE_PHY_DLL_MASTER_CTRL	0x00800000
 #define MARVELL_RFILE_PHY_DLL_SLAVE_CTRL	0x0000ff01
 
+/* ADI SC846 PHY default values */
+#define ADI_XSPI_PHY_DQ_TR			0x00000101
+#define ADI_XSPI_PHY_DQS_TR			0x00300400
+#define ADI_XSPI_PHY_GATE_LPBK_CTL		0x00180030
+#define ADI_XSPI_PHY_DLL_MSTR_CTL		0x00140084
+#define ADI_XSPI_PHY_DLL_SLAVE_CTL		0x00003fc4
+#define ADI_XSPI_PHY_IE_TR			0x00100000
+
 /* PHY config registers */
 #define CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL			0x1034
 #define CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL			0x0080
@@ -788,6 +802,45 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_cntrl = readl(cdns_xspi->iobase +
+			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	/* Reset DLL */
+	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
+	writel(dll_cntrl, cdns_xspi->iobase +
+			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+}
+
+static int cdns_sc846_xspi_hw_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_obs;
+
+	writel(ADI_XSPI_PHY_DQ_TR,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING);
+	writel(ADI_XSPI_PHY_DQS_TR,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING);
+	writel(ADI_XSPI_PHY_GATE_LPBK_CTL,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL);
+	writel(ADI_XSPI_PHY_DLL_MSTR_CTL,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_MASTER_CTRL);
+	writel(ADI_XSPI_PHY_DLL_SLAVE_CTL,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL);
+	writel(ADI_XSPI_PHY_IE_TR,
+	       cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_IE_TIMER);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	cdns_xspi_reset_dll(cdns_xspi);
+
+	/*
+	 * Unlike the Marvell integration, the DLL lock is documented on the
+	 * PHY DLL observable register.
+	 */
+	return readl_poll_timeout(cdns_xspi->auxbase + CDNS_XSPI_DATASLICE_RFILE_PHY_DLL_OBS_REG_0,
+				  dll_obs, dll_obs & CDNS_XSPI_DLL_LOCK, 10, 10000);
+}
+
 #ifdef CONFIG_64BIT
 static const int cdns_mrvl_xspi_clk_div_list[] = {
 	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
@@ -806,17 +859,6 @@ static const int cdns_mrvl_xspi_clk_div_list[] = {
 	128	//0xD = Divide by 128. SPI clock is 6.25 MHz.
 };
 
-static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
-{
-	u32 dll_cntrl = readl(cdns_xspi->iobase +
-			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-
-	/* Reset DLL */
-	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
-	writel(dll_cntrl, cdns_xspi->iobase +
-			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-}
-
 static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 dll_lock;
@@ -1416,6 +1458,13 @@ static const struct cdns_xspi_driver_data cdns_driver_data = {
 	.set_interrupts_handler = cdns_xspi_set_interrupts,
 };
 
+static const struct cdns_xspi_driver_data sc846_driver_data = {
+	.mem_ops = &cadence_xspi_mem_ops,
+	.sdma_handler = cdns_xspi_sdma_handle,
+	.set_interrupts_handler = cdns_xspi_set_interrupts,
+	.hw_init = cdns_sc846_xspi_hw_init,
+};
+
 #ifdef CONFIG_64BIT
 static const struct cdns_xspi_driver_data marvell_driver_data = {
 	.mem_ops = &marvell_xspi_mem_ops,
@@ -1428,6 +1477,10 @@ static const struct cdns_xspi_driver_data marvell_driver_data = {
 #endif
 
 static const struct of_device_id cdns_xspi_of_match[] = {
+	{
+		.compatible = "adi,adsp-sc846-xspi",
+		.data = &sc846_driver_data,
+	},
 	{
 		.compatible = "cdns,xspi-nor",
 		.data = &cdns_driver_data,

-- 
2.56.0

