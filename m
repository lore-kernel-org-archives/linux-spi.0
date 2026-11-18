Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993928;
	b=JV9CLzw0riDUqo8pMD4Adq7Td7akApb9S+5a3mJWKKqryvTZ5jaEXXxSW0uGJ3VkBVBA
	 qVFdF1qvr2qp2E+GMjJNWzJnQyEcID1PjxwTSxrRSLrgKBUTDH4Sui5Y9U4T0Nz+OSELB
	 EnjwJfyhd/Evbo582BWLogL+twevXJE6ZkxazIbh8PRyVoDCOZmN6Oinx2wV4V9oSwMKF
	 rWALqmu3WxENN9QV6WHR+MAbIiu0yUGjottyc7AhEFErAhTm6uE90vSwAWWNGrUaIGfwz
	 lNgKWVB/+deLw4rYKmQaMtXZiBk9txSsSrxc5yuyNhIhIh2gIabt0FQ8g/PFLF8komg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993928;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vbYGLrC94NsPzE3V5ABmLXEO6YPHsONjxQYzB8w/Wvs=;
	b=A2luzQL4j3fL/OoWnnVqcp9LbA63xA2LhphmFB/kVKOF7D/ru5Mo3PBhLu3A4UmPd+cZ
	 lfrojeskYOR/USNzsImVe3lbLaEMCwuA6gdIbXg17I1VwJ+P+A+3wESDceu3Uqss3oKx0
	 rbld02zON8eJdreA4TxSgtIcUvufhwcIIba+HzFMP9aa3jLtJHbpKapWtrr8HXn60RrGW
	 vECyZzAPayeGDZRCxz8E0mQQd+O7aoWe6uidpipAmFHlJo+V0OBJvTyGlaou2n/GmbSmy
	 d//3Y0BnQJYlaj4YuJUsdh2hc6GeS8HWPR7Q0X43LEqZVCreEr04CH9NXNE1PdAYgXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GSd24WS9;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XwRWs+Av;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A5606A31C;
	Wed, 18 Nov 2026 09:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GSd24WS9;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XwRWs+Av
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9IvdA1572680;
	Wed, 18 Nov 2026 04:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=vbYGLrC94NsPzE3V5ABmLXEO6YPHsONjxQYzB8w/Wvs=; b=GSd24WS
	9JfK7A7/7u3b7heYPmApcqMwgz1LCDDmN6lkV+DXuRUcKAYjeP66Vol+frIgTgqN
	PxnHLPqUCRnUGWNsv/n9K4WlT4u2OuiwjedS4FY8oH6E50hjUeE0SNVL8TsBB7Ls
	kyI/5jYTWDfSD5vj8ylwB1jRc4wLYBIV/oyokGdnlLcU9iL60jI5M/JhgE/cHR8C
	f/zaEIc3QbWXlYWGUXOPwonkxLsmwQs3fNHSJgOG5uRFEooLmwB9qs9jlxWzriF4
	XrkWgOkyfgOi2jGHnH8payyl52Iy/MeJ2ynGhhwePfiNJRQYCH2K8vTbCZVp0kmv
	mBAi44IuAKLNIxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vbYGL
	rC94NsPzE3V5ABmLXEO6YPHsONjxQYzB8w/Wvs=; b=XwRWs+AvNQ7slA9X84uZq
	eVnrtrP9ZNhcDof0BrP6o4zculgoqieuqkb9UHyApc5/4hKRFiEf2x3DdXjXrNTd
	OTX7GJNuoKjI0BtY1ju10Fs4aGWe3zL5sIggngCkx6Urm3hacTd9GtNJec6J6bcp
	Ft77qRuBZPxuYdRxJsGQNgPW02nIpfhY88StSXj7oJKoGyMzuLTdyTi3tTnz5CWm
	DaSFX3XA3+KaPHYIM+00wr/LCIn1txxxkf+3DlzEOp1ajszNY3Q/Aq+SVAuT5SA8
	579cMPJbeFKPQR0AhD01GqVFFsp+DT7gyCMhUYnA0sDzUAWKQK+HNc0NMkMyai2P
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j0yuck74n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 04:24:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5QPp8VT1AFjJPi1MMbznZxixR0fDxLh+su4eZbALoscNy2MclcZP4nurXsI7I/bWr17sb3AxviATzSu3a0Ns6bzjF2tWxiDA+RXuzXA4WtKnRpyBHFqzcCEa/3fBgPsN9vep1KGl31/923S75ZphzuBbdiR+VnnLhH+f7N+JpH+rcIUBCm9chB9Cx829CX8tZL0TJzOaEeQKrnQmLJR1OrkbItFNPtVMFjY9U+kNOSxILsir3JM9rk2wJj0Ub22Q5OP/P9X7EiJIk4+Tlnp2lj+5p5XogXyHEPgUTb5WLNyuPe86oyvzN33VqxWYBZ8R4qPcwIMdPlp369vY5BRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbYGLrC94NsPzE3V5ABmLXEO6YPHsONjxQYzB8w/Wvs=;
 b=brqRHW3ufjj4IZTd3NaTy4STWN5nK0PEZArLtKEQziCMiccjdQVrqIt4v4jj7Njpax/uSBE8HT2fYPhB0gmIa20Pxgsyd84Pg0SlrMIKzBTX8CXaJ2XQ820WseOrcqsNmNDw8tF5InUhLtejFdKoAa9A+SlvyE22bIpBF+dxZFGDjOHCKHlMBgIm4YAZPQpXlyISEvFQ+KeKo6zWggdhFx5/NS/M8vl10ksgsXcx0BGhwHGWVuCW4BE2vfWRwOs9VhiJ5o24tkSEnYKIoIIPBWkuzI0oTElKEaw1pQ02PtmpDqeKUnwimMFXUG2Xi1Ka5tryO+TTEnIe2FRfNR5ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5115.namprd03.prod.outlook.com (2603:10b6:5:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:24:55 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0615.015; Wed, 18 Nov 2026
 09:24:55 +0000
Date: Wed, 18 Nov 2026 09:26:12 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
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
Subject: Re: [PATCH v2 0/8] spi: cadence-xspi: add ACMD mode and ADSP SC846
 integration
Message-ID: <av1u77DUXulwvkZr@nsa>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ef6dae-dad8-4bdc-c627-08df4555ce6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|6133799003|22082099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003|261009221727099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GachYTwaH6DiBOO50okv8MSMKYWm1+YKxQl779zoIan1ZMkngUqwp/OuYUbvZDLWrfIUbXSlsXLOGrYRR8KWH5dQcBhtz0fx9AgiBbHTaRk5T/MvoCvm53jwVKCJtKdUICYhk7A0JJZ94OIBIktXzbRWC9WAG/mipy/keS28lKp9tNlCuLJ7EKnXJCfGV39SNt74tTb2FcGnOeKDtDS3jdP3t1tQ4NreLpmHuKA1N+sUX0CLaSJsEjEQfqVJVBMEM/3hP/n4O7Y80icaalixyI6lMTMRTPI9yW34DkWYXTLZwO6ZOZdnHhYwqdw0C8WYvBncPXwkBcKNuI0Lm1mNH8LfcxJHWM1tVJEEexjHewR0b2HN8h8Yyk0Z8GIGo83Xkb48n3CFZ+z4KLQChbfA8lYZq5soPgkyWrTtJ1ZW1ThTH8uK3OuvnVh0DvLl/7iAzKqY6c2SDDGV9p0L/qovWxRb0Bg3Inxm5GuDhATlTaOW31gNhjK3gUSQpwZsc/2wPewLmPEf9pVohQEO3ykygMead4ykPr2y1kpjcIXr1lV8aHoR5scvLIG7IfuE+8aSk/PF+dP7lG6T+mQ2xNCb0uj/M5e61Mv2Pa1vo08ezM6fu6ubYmxl0EW1wZcL3rJC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(6133799003)(22082099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009221727099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWhHME5yelRoY3JRVXZIbTRRWTUyK0F0T3QvaktmSzBYdmR3WktobmJHdVNS?=
 =?utf-8?B?MTRZaitodm9IcFljTmh4d0V5N2RjT005UGdBQTdnV2tuTGVmOE9JeXIwWS9i?=
 =?utf-8?B?ZkkzeWEwQUp4aVFWWmRNWWh6UU85MHRJa3dUMUZmOFFvNk90U2hHSDM3QURF?=
 =?utf-8?B?bU9TcmpXZWUxdjJSM2ZVeUZVM3RsRWRxTUlxWGhmSmtXTGltV09iZTF1bER0?=
 =?utf-8?B?K1Z6QW16TjNTZHMyUmNnSFp4cVo5Zzc1bHVGQnUxR3hWN2JGZXdGTFlxMHhO?=
 =?utf-8?B?ZzExK3JhSm14QmNFazBSOWc0ZVo5TDZTK08yNy9NYnV3K0VCT0M1N3hnUVZv?=
 =?utf-8?B?L2lvYnEySUpMM0kzanhOL2NEYmwvZjdnR2tDdGxEQ0dmMU9RempSWTBwWXRw?=
 =?utf-8?B?Y0pSRU1qRVF4eVovakt0UjdaZ1Fhd0VCanYrY0R2R0E0ZlVtbzA1WHVpVmFR?=
 =?utf-8?B?cTNoU0o5d3hVaGwwbU9pL2pmZkxrc1hSKzVvM2hKdDMvNzZUc0xZS1RDVnFx?=
 =?utf-8?B?OEpUWVgzcEFVa1dobGZvYmF5RzluK05IWEplUWRpMlVjaER4WThtM2ZGcTR0?=
 =?utf-8?B?ZUdvL2RsTGNxQ25kcGVrYlFWWkFNd1hYWkRPU1FIbE9mZWJHdmFVNW9WMHJi?=
 =?utf-8?B?WmpiaHpjRFVqQkJlTzFST0ZBYjUySzFTQmtDUkE3MDRKUXZBVVk4Z2cvREdn?=
 =?utf-8?B?U2VOZ0wxYzBZS09sNFEyRlZjRGR0RTlCYnh5eVNkVGNidkFnVER5RUQvM2g2?=
 =?utf-8?B?czN0WGthWDN1UUdOVEtRQlprc002ZUZoTWQ2WEV1QWFROVNkKzQvT0ozMjdP?=
 =?utf-8?B?TUNncDJnNjc0MldKWGFSUktDU3J1QWNBamNEVUl4NzBYMlNhcU82ZTNBbDBW?=
 =?utf-8?B?RDFxUG9TY2hncjlsSFRsd3RkMGpPZUNRcktnV2FDS0cwWXo3MzdyakJXVnp6?=
 =?utf-8?B?ZGk4U1B1NXloRDBvSUZQcFNYQ0MwSmJXblhSVzdndjI3ZjE5Tks3MmE1Tlhp?=
 =?utf-8?B?Y2RiNjhmcVZOWXd1QXhYd0JYN21Ra1l0bTVwR0JDdEVtRDFtdi9Ub2swTEhp?=
 =?utf-8?B?KzRWQjBrYWlCTzlZSGpPZkhIanVVRnZrNXBXc093ZnVXZmk1MnJ3N0w3ZzUr?=
 =?utf-8?B?WWJuVDZJaUQ2US9FM1hmUTFSemVCaUdsNmlyZ2pTdDA0N01NMUJXZXo2cUUv?=
 =?utf-8?B?RUkxcFp4d2RVR1c5dStQenE2Yi81SlRmOGUyeFp5QVNBaHB3QmVMcFFHUzZQ?=
 =?utf-8?B?STlqUG5xOVp5NXRqNzFWZjdwN2oxUkduM1VpdlJDYnp1UUNIUWpmcmQ3Y2FY?=
 =?utf-8?B?ZEZPbnhjYjdiMkVQWmo0Q1dVR2FMYkl4ZHc2QzhhVmhoTFFUOHJwT2tiSE9G?=
 =?utf-8?B?NG1iZGpwUysyeWkrVGI0UnYwakgzOUdjd2ZreWFXV0hscEp2eGMvdVNBbk9H?=
 =?utf-8?B?OEtjNGdnbm16alRCQmZZSkdtRC9HVWIwL0pLdlZGalVOY0REU0FMRlhvZ2Ir?=
 =?utf-8?B?TkkvNm1jb3dNR1o1OTYxdEJGWlI4MlVPbzBhMEdXYXlEaHVIKzJRTWNSTlN2?=
 =?utf-8?B?eXpvRFV5Y3l4K3lyRUZpN3R4eVFVQ2ZUZHo0cUZwUkxYN0FobDFoTGpUUHhv?=
 =?utf-8?B?MXdHMHZjdUNrQ1ZvcXFYQ1lQcktnaXYzdC9kOUt5QnV3OEVMNTdNdlh4OHBR?=
 =?utf-8?B?cER3WnNhNktUSjFJZm9TQ1NkNzBmcWtURTZSQmppNWdtcXM4TnZ0NGpYOTlq?=
 =?utf-8?B?aVFwZzRIR2taV2J1bjAzeVhFUmxMeVpTQjF2MDE5QmRHVjhnN0xEUkNlY2g0?=
 =?utf-8?B?VDZoZFlGSWF3UWQ4UjBpRmMzTkg1VkxDZCtoRHBvalJxYk0wQS81RjIwRDc1?=
 =?utf-8?B?VzlXQk1ZVVJFbVFvUGJyMU1qMUpPbks1R2pTdmRISzRhNnZlS3NrUjJ5bWRX?=
 =?utf-8?B?ZmZncXBmT1lEbG5yNVlHUXhCUHpNdHl2a0FwL1B2ejlRYnJseGRhbVoxMXht?=
 =?utf-8?B?dHB6TmdKT2hJZDJvK3BVUXM4QVIycVZHaEs2QlhvelFDNG5yTTV2M0l6L1c1?=
 =?utf-8?B?RVlONzlBeTBKdHEzUEJaNlVzQXNGQStpdktTYVdPT29VRkd1Yi9EaG53Uytr?=
 =?utf-8?B?V1g0alJHMjU1UmFvKzlQd2kyNVFlTVpkdDM1SFZRb3d6MjNRY2FYdTNFT20r?=
 =?utf-8?B?di9wZlZhZXkzV3hJNXEvb1g3Vit3eGx0OTJiVGR5WFlWL0RNSEUwK1dhMmNF?=
 =?utf-8?B?aXdHNzE2bmJwMFFIK0RlMVdpWmplQ2gvY0JibkZJZXIveFJsQ0U5RmN2RjNz?=
 =?utf-8?B?RWdlYlNKbEhldytndXdLbUR3Tjd5Z3plNHU4T3QzOWVybFNQUzhaQT09?=
X-Exchange-RoutingPolicyChecked:
	fKGdUJK/GFxGxfVbnucmrzCKxEBm9VF/lDfpQvD30BwvAAHqkbDhxiWgpWBsRTqCby9vgNQzhqmcR23wrSf5TnvPMnWUBYqdH+Qg04u2mCyrLoY2ypk6RCTpt+CALVDWre3CWdW2kq71Uv55QqqbvseFNfDGFhHlkwqCQhYxv4ddJGSniMYzzBL+e82GhzjKtJrtRc7jkpzcwwPx0vaGNeI24b24zyINOtE2/IIJZTOVTwU+G0uQmSf0ccIOns40V7FXBOrXPTLFgcURjq9+sc5iJRFsH5rMyEsB7jUizvNWqJ6roFN+ySP+u2ESBj/kBVf1wZTacuKQtaQbkQ6PrA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ef6dae-dad8-4bdc-c627-08df4555ce6c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 09:24:54.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWh42aXg2b8q0UA3UN48gAav5TQ411idUosRL50hBlVgMJ3Hk0WA26e1IymRey8wSwr/myDVYPb35BUEC1bcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5115
X-Proofpoint-GUID: hWNAfq8d5oyUoFfzCkVqjD9k1SHe8juX
X-Authority-Analysis: v=2.4 cv=TILQ2Fla c=1 sm=1 tr=0 ts=6afd6eea cx=c_pps
 a=QsHTWkejXhsF4jLr7vu2uQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=UL9bpcFbrnaoTBOsY1EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfX53qqmwcdCqyt
 hDCcOhkr62XPnt8Qo3y9CgcgP5WEFYGmoImKfiqK0lb4VpFEH7ht3zsv7NGD904Csi27QzO8YCa
 Wf/msCZVFj8JhHM1JEZEa0lafYJ/0kGf/yrc122yf62iCribEEb69VqiHUfjSE9AH/QA+2EoU3j
 NY9laJDBus/33lZJ+XHY5lTRNMfCvBjl21ucdQj6fjuHduACfVAEU0KU2ohE6mIStfLxAuqrhLN
 vqssMAEpzcMqMR0BTU4Sa8eLkCAgd/uY/t08OQSDkJkmCG8qPXNZFztS15+VfTVU0NPFdjP7LId
 Wd3GJ8Akea+ZXyNb8EvY6xoyRB0d0BdyaxFY69C00NWhA3rh1awblb2WQAMxb/93zvkJQLzDwzo
 ZQt+lvqI0KlNpWmqDJS+WIxvxN9A+FU/7adiJrkNvJcOVsSONzRdBhyW1VHXuk6CF0IOs5kWeXf
 Uf3uYeXcMTQLkGGmTFA==
X-Proofpoint-ORIG-GUID: hWNAfq8d5oyUoFfzCkVqjD9k1SHe8juX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfX/VYtH/fUnexQ
 Kj2hobATp3z5W52FkEjYWjFofx1aOSIv8qAoCdX+6iNZjCCJm73Nt0w1MW2bZipBzA0uj7pnNwo
 Pnu6Jb1nFGERozUzK1bKE6lFzr87PbvwjbaR9qm7jiZhcNwVvsY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180037

On Wed, Nov 11, 2026 at 01:23:01PM +0000, Nuno Sá wrote:
> The Cadence xSPI driver currently drives every operation through STIG
> mode, where the CPU builds each command and drains the data. The
> controller also has an auto command (ACMD) mode where it runs whole
> sequences on its own and can move data with its internal DMA, which
> pays off for bulk reads.
> 
> Whether ACMD and the internal DMA can be used depends on the SoC
> integration (external SRAM, the DMA bus requester interface being
> wired), which the controller registers do not expose. Hence, the series
> also adds support for the ADI ADSP-SC846 integration, which enables
> ACMD through its driver data. On the way, the platform specifics are
> moved into the driver data and optional clocks and resets support is
> added for the IP.
> 
> For now, ACMD is only used for reads of at least 2048 bytes with an
> address phase, using the internal DMA, and only on integrations
> supporting it. Smaller reads and all other operations stay on STIG.
> 
> NOR and NAND are handled the same way: NAND operations are still issued
> one by one, not combined into a single ACMD sequence, so no NAND
> geometry is needed. The real gain is on large reads which, for NAND,
> means chips supporting buffer/sequential read mode.
> 
> Another attempt for ACMD was sent in [1] but that relies on knowing the
> NAND geometry which brings much more complexity given that it needs a
> proper interface implemented in the spi-nand core. So we agreed on
> starting with this simpler approach and then build on top of it if we
> agree it pays off (mostly on cpu load).

Hi Mark,

Not sure if you still plan to look at this version? I assume you also
expect me to rebase this on top of the current work done by Jisheng.

- Nuno Sá

> 
> Some stats:
> 
> ACMD
> -----
> 
> SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 106666 KiB/s
> testing page write speed
> page write speed is 1035 KiB/s
> testing page read speed
> page read speed is 15238 KiB/s
> 
> SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6497 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 44137 KiB/s
> testing page write speed
> page write speed is 6336 KiB/s
> testing page read speed
> page read speed is 16842 KiB/s
> 
> STIG
> ----
> 
> SPI-NOR
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 64000 KiB/s
> testing page write speed
> page write speed is 1042 KiB/s
> testing page read speed
> page read speed is 14883 KiB/s
> 
> SPI-NAND (Cont mode)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6564 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 18823 KiB/s
> testing page write speed
> page write speed is 6400 KiB/s
> testing page read speed
> page read speed is 18028 KiB/s
> 
> For now, we have a static threshold to decide to use ACMD or not. I do
> understand that's not ideal. It might depend on sclk and number of lanes
> so not sure if that value will be accurate for everybody. So, open to
> suggestions if someone has something in mind regarding this.
> 
> Changes in v2:
> - Patch 1 (new):
>   - Fail on command errors reported without a known cause.
> - Patch 2 (new):
>   - Wait for the controller initialization on resume, as the IP might
>     lose power across suspend (Mark).
> - Patch 3 (new):
>   - dt-bindings: add optional clocks and resets.
> - Patch 4 (new):
>   - Get/enable the optional clock and reset the controller at probe,
>     waiting for its initialization after the reset.
> - Patch 5 (new):
>   - Move the platform specifics into per compatible driver data.
> - Patch 6 (new):
>   - dt-bindings: add the adi,adsp-sc846-xspi compatible, clocks and resets
>     required for it.
> - Patch 7 (new):
>   - Add the ADI SC846 integration, PHY setup at probe and resume.
> - Patch 8:
>   - Infer ACMD support from the compatible (driver data) instead of DT
>     properties (Conor).
>   - Invalidate the cached work mode and redo the ACMD setup on resume
>     (Mark).
>   - Always report the ACMD error from the command status, the thread
>     error interrupt only wakes up the waiter (sashiko).
>   - Comment why ACMD reads are not size limited (Mark).
> - Dropped the sdma_error to xfer_error rename patch, not needed anymore.
> - Dropped the cdns,has-acmd and cdns,has-internal-dma properties patch
>   (Conor).
> - Link to v1: https://patch.msgid.link/20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com
> 
> [1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/
> 
> ---
> Nuno Sá (8):
>       spi: cadence-xspi: fail on command errors without a known cause
>       spi: cadence-xspi: wait for the controller initialization on resume
>       spi: dt-bindings: cdns,xspi: add clocks and resets
>       spi: cadence-xspi: support clocks and resets
>       spi: cadence-xspi: move platform specifics into driver data
>       spi: dt-bindings: cdns,xspi: add ADI SC846 compatible
>       spi: cadence-xspi: add ADI SC846 platform support
>       spi: cadence-xspi: add ACMD mode support
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml         |  16 +
>  drivers/spi/spi-cadence-xspi.c                     | 530 +++++++++++++++++----
>  2 files changed, 457 insertions(+), 89 deletions(-)
> ---
> base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
> change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
> --
> 
> Thanks!
> - Nuno Sá
> 
