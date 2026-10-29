Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289756;
	b=flfF91zKqfNyPDTAP/4LwdRlod13YwbPhQrTkMEvAlNRvr9q5gATNxxo/Ygg+S8rTKUX
	 u5pRhv1qIpjmW+FD4+dBYmIuJ+ShEN3YdJq2g1RKMqd0F+jpfjhJM0CSOtl4QnsYqgSq4
	 vIwLuYMYf8rAhoZmiP1Cthl+IA68bAx9KEywCMZ8/zwL+rxj98LVc5sAAl//Nim8euTmb
	 KVvKUsyDiMc3jz9Y/CUUMWT/x60CrNqfLoDFtGicUGmtctNVKtpBJAgYuUzq0+RoGPdAx
	 FPUf6d6m2KF/mdN1ku+EmQVF1AgkRKxdbXjEyYyPyKM7IlpLBP4QYFvMQvpoewsgs9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289756;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uFZObpKUT65tvDL3XV9MTzrjtnOwBgWH58aLvm2VJ9Q=;
	b=zjLkfcVLuZvnpLTkkw1jY+vrgUTCllc/nkdpBY57YJ5L9YJ+6+LkrgX7YNhy6gssVyCn
	 zpdzNZ8vFVDOOQHrw/s4tRWRInFB20KdKbonY0ius7xeJ/L7GeGpDxirixuhB+iVta0bR
	 p6yNP+RUyyx+ciKGtE1EkDTw02YmZyOM5Atzsv9JSEXprxtEuxNNGrlfDZGxv38ULIYjs
	 veQ/FGu/11sUS4YM+QBH4AQGrrEkfaMP1jkqn7DAarci+CFAsUhHD22nhPppb0cRVEguT
	 u7sPjwXjToOMg8fI7TVUvnfX8Ra99djewfoj8nuY6dnzaWwRjair+LlNgdlyFaeMgxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XpXXOyBi;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=n4eZY+AW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F4606A31C;
	Thu, 29 Oct 2026 16:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE7F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XpXXOyBi;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=n4eZY+AW
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TFQbLe766795;
	Thu, 29 Oct 2026 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=uFZObpKUT65tvDL3XV9MTzrjtnOwBgWH58aLvm2VJ9Q=; b=XpXXOyB
	iQMR6XBrWR0LE19yrB1/1L/gpAiq8P/fpn9ADbTcpPF3xI48GNDIewNP5gTYur2f
	2WHAtzmIWO1jJTt54yIvIvAoqd/gI16l2QWLzBV8mvcQbA1z4oSt6KjCXVrJ62iC
	BC9tS4cMU47/ExhFx1pqOOXA51VUab4TVhGSI2KGiMbDcNfMpYl26l57kojsu7GC
	H//EHXrc2YbTwdsqoxYg6qTRKpgIvpzsj6W3b3hofN9OTwYL2qJBuA4ItsOePCgo
	2EGfc5MfhT4UZ5eTYSjkgFl4ijifgeuGkg4MAHueUtJNE2mr6y9F9hIHYSWOinyG
	MQNvYeObGIr60/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uFZOb
	pKUT65tvDL3XV9MTzrjtnOwBgWH58aLvm2VJ9Q=; b=n4eZY+AW0uqUHmhu2zpgQ
	b9Pn1yNEoVzQJF4tUGv+ttEiKWevcM0oxZ8ilh2342GnSXMMHkLhks4jFVUHJi4W
	fucnwGASZ5ksqXHn6BRwgUXpsocJlQC7w2KOCJv7/epvlbSHxsEN72ZXYk9uvzS9
	McAQ1MEzlPL4RAekIQwx7zcbACCzWBFJCIvX3Yd2Qba5DcdsCG/F6WrOwzUmKA29
	l2ZCXLjwYosGDobKKEKPaHF9QQmIqcL0M3NrCupeF9DSe61hf5Y2jSVx4lP2cpO5
	Sm2J9GRpJkfTg/VUY0TBA939qNulJ878222BWAhDG5giC3/VijwtROT5jU5BUDtZ
	A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hkv6uvbuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:02:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJfK/u/T/WYKg/4bVE4vJQyzLMX1i4PuOTGVZ9ktHOJtA9nllYYyg8rZ/3yl2P1sVsi1es7XpAejejxYqVgOEqLBZahyIJhVuzARvaA0p/vAi8uZA4sOrrJnTO/ta+FBEYkJ9uN34vZxg2qzCIceUIvTTxMBEKYcAJWBhvHz9QbZ7NpKkQAxRn2CCrSqMFrxIi5WK5BiYdGFel9FAhDx4bGlhXT+ISSXsQAzWD/JDf4CpZIg/kj1+6WliPukPdW+eWKcBdnD06diQP/m7Mc/044NII1Q55e/Fomo21Ym5x3sH4mEGjJeF/TagjqXqf7shRfwoV8z2pZzKVqFV7Kx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFZObpKUT65tvDL3XV9MTzrjtnOwBgWH58aLvm2VJ9Q=;
 b=tDwJK03LyjcToxn9t3Fw5z7YFkiLC/2+hXbuforZ2C/ShgfEEnSET+4VVq+MTZJTmbCLlquo8wrcFRad1yZKh8q95b9rUUWyrPXnbrU+VuG9tCjarCVd7p9OqrE3U0/R7voFTy9R7b5+m3NRhbbmhm7tkpwKIS7enE8+DaKvBSEt5nR3jjxh1fuD8BtCcirHKG8oTIvmkicMronZP7f9s8oBD6Rk6kPzyVPN8g4K78se8iBfSnmmDBytxnQBcS//QqgWWmELzP9/0hBH5j6XepzpUEqv8bgX3BTXEJzcQNAOY+gPv9/H+28juUU8fYiH3XNV4jiO4wLRPzASAndVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:02:11 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:02:07 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 29 Oct 2026 16:03:18 +0000
Subject: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793289797; l=14640;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3dS+P9ApU0RWQ+BXkEnbbdgNSuPZhk7Sq+a7IAlIxZs=;
 b=+mApq6jzDishuoJiIA7uxsaHMO9tTSHCnPPDUP0kWEM9n0g++5x6G3SKu2QeZD1hHcjjMhhq5
 mtnBtkHppqUCyTvCiEhUMIkPDK3CMWNAiV27WFE2woqG5rGBvSJF/cN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f09d9e75-e7db-400f-aea6-08df35d5fb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|261028144727099003|261026140227099003|261022075727099003|10067099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	LEA6UgknEsXCAg/GGH9PBYqNgRnjFzuP18vnf0unAspbWgFfCF7mVmyO5oahU2UZO1jK/Z77lQxn2NivT3LkaDn7B4XVBjj5X7fXv2H9g/aOQG9A311KSfUpztJxaePfH9NVh7N6IRsJGdSTkBa2Av8EU5+945WXAxx4DTvX5pncq6CX6sooKlXpuEiPrqzhCCdp6BEy/py+LYnAEo2TiMFtB/dDdsSqTL54SJmsU64TENWpml4qLF4hBJ5pt4e2GbcEtzde7EjjTwifEFCfM1k4AnwHDzCbvq5iNpkVq3SPeKWNmDRGQmo4ym+1o6h4WzoFHb9MHF7yGtRZFAkjPABSOEr7kW549xZ9bOm+qcAJaqaknLUn5U7Mzm4AzJuoVIdMZsvW9vwJkLFCg2u/rdv//JKyJDj9OBS4bVmq7Y6/T/29uHxzvbh4i8hUdxlllEIw5ANT5UCfHT9R//uChOx6mq4wqSxPAYNssDxjiMZrvMPo4FQD5CsjDBAavj0jMLOj/GL4a7YatNM6XgyL40kFbNcpdu7KegaokwNaAsDqoIyu3BaGpj3DTs29dNcIVjz76c29yhkJbuxGDCgY7HZXY6DjM/BC3Y69ZHzmRtgyt5N2EMuO7UIlA8jHDmC0lSJSuxvzElZnD8MbfeGmjcOx8Q0m3ZbDA2kza43Y8UY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022075727099003)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3N3M25UMU05TTd3ZStQcEZOcllTdDNWNzQ5WW9OaThGVHlVamo4TllqWkZY?=
 =?utf-8?B?NXF3Q1dHdmxPOGVjTHl1ejVKRndqTU9OaU9uSkNMMWRrMEsxSVAzNC83dmE0?=
 =?utf-8?B?ZUoxNFFNZ3N5QmtGeTVmOXVFdDAyMmVLem9SSzFFWFc2NE9WY283VFBCRmxu?=
 =?utf-8?B?aWhPSmM0MmxVbk9OY0RuSWF4RVhEeTU1MHNReDZwbjBNV1Rlb2FjUGc4NWNw?=
 =?utf-8?B?QW0zN2l1Vy9GUG4wbmVPZXp4MjJOTCtjN1NOWmpZNEhUeldJUXZEOUx4WmQ1?=
 =?utf-8?B?bXBlSU9DcXQ0MG1mTXpmOGVlcTVEYU5sd0xZQi8wcEMzbWo1TDMzc3RXQVgw?=
 =?utf-8?B?UG1TbXV3WXpVbDRQZjJxaGNrMzlmeVI3bWtCR1dNcHlCK3FXcU5XR3ZqRTU3?=
 =?utf-8?B?dlgyK05NN2JVS2hMRjU1YzloRG9BbHlGWWR5WDBTOGl5Qm83NnRxSklSOE9q?=
 =?utf-8?B?MHB6OXhid3BId3c0SWRtOTVrWTJtRXZRYzBHMEU0NWlQc0h4dFNDUFJ6ZDNL?=
 =?utf-8?B?eGNIUHEzdC8zSmV2eWZhK09Xb3R3RVZOblRyQWFYcjBRajU5MVo2Z1hFU2V4?=
 =?utf-8?B?RDhSL3IzTmRvQnk3RTUybC9TbmNHWWdZUmhGc081QkxVd2dtTlpQd0VvYzVh?=
 =?utf-8?B?RnF4R05EUFphUDR0SndveEg5ck5BcnoyTVhkQzNyZTB5OXUxMFhoMkM5a3ll?=
 =?utf-8?B?OE9NcDJnS0YwbnYwSTJBb2RtNjNHeXZyNXFuOFByOSs4bnMwV3NyT3AzUzJx?=
 =?utf-8?B?VzRlRUF2Q1JoOGQ3Mk5vUUJWUjVxaHZIRytFYzljTVdVRVNsdCtOd2R2MDR4?=
 =?utf-8?B?ODV0MWhPYWtQcWViT2lVd3FaYTZpdW0vOVpRY2ZuYUxCUzNGNkdHOUpjOUEw?=
 =?utf-8?B?bVVnQThNZDVVbWVKakRNdXgxT1BucXNIdjdXQTlubFhQK3ZOd3FEYVBUeDRJ?=
 =?utf-8?B?bTQ1QVFQZURIY3FRazBTSWQrODZOUnIxSjMwSmd6Q0dDSHlycEJpMzIwTzVG?=
 =?utf-8?B?cVMvRjM5ODVmNnBEQk1nbVFKTndHNCtoVC9Ebll5WE1GOEZUZThOem4xWFZJ?=
 =?utf-8?B?ODcxd2tpNW5ka0FPbHhQK2RtY0pIZDhUVjBaakFsWTB6Q3NGSDFleVJqdzhj?=
 =?utf-8?B?V3ZoQ1RsSFI2OXlwNlJFOVFGN2VVQ25IMFdqMFA0MCtFaVZFWCtkbDFxRkFu?=
 =?utf-8?B?eGxKMHArdHRKZWRWZHJEREhSdWJscFNVdEZ5RXl3MUYxQnZKWFBEdUE4VEVT?=
 =?utf-8?B?T2hlQXhBM0RtV2p4RG1GTW5YOUc4M2FsNnAzNVNWSExXRy9YUnh3SUg4YVJM?=
 =?utf-8?B?TVVBVFNjamc5dzVPcnU5ZW5lSFljN2l0UytpMmozOWY1MXYrZU1zTlc1RkE4?=
 =?utf-8?B?UlRvb1diakwwNWdLODVYbnZWa2xHdDE3TmI0dzhHRGFRVG9hb0Rvc2pBdnFx?=
 =?utf-8?B?SGlDZ1BoOEpvY2I1VWRvK28yU1IxMFJxOTlQWGNjNEFNcExqdHpMQmM0Vzcz?=
 =?utf-8?B?aVo0KzdUWFJZTjNnd0RtQ1dqS0tUVGpyQTFzeXlVaC9tNUhYM2FiUlZ4RHVR?=
 =?utf-8?B?a251QUZxaGZCZ01iOEdnMkVYYk56NnV1ZmRjVmJVbzRFUmlHYVhwVm1TWnM4?=
 =?utf-8?B?cDdXS2lLdXVkOFBYNEw3aWhWb0Y1T0RkZXVHN3pybERhVURLQTFhd0plMXNE?=
 =?utf-8?B?dDV2NFRrdTk4eGZJVlUyS0NkUjUyVHFITFU2RDJZZERscmd6WThrclVTRXQr?=
 =?utf-8?B?SWgwaHI3NERwWENxbDhYdGpGakhVbXpsNUk2d1ArQUdUVXF2LzhBSzkrZDZH?=
 =?utf-8?B?UEIwMWhiWjRiNmxSWnpROVdMbVQwcHUyaVFPaXFNQTBNT3dpdjA3dVJSTklW?=
 =?utf-8?B?aFBDN3lNT3A3dUlKWlJxaDI2WDBZYmx1V3dzNFNRdEU2MUplc205RDFKaHVT?=
 =?utf-8?B?aWhPc3VkMlZmMm4zcm9HZlBtK2lERVUyZmY5WWY3ay9ReFAzK250Q0IyTWZk?=
 =?utf-8?B?SkhZazRQaStWclpqNm1jaFp3ZjRycUozYkNxSksvRklGRXJDQTZ5UzFpaWph?=
 =?utf-8?B?aHBtNXFjclJscTdSQkpSRFhOaHk3ZW9rTVk3R3N5eXpKT3E5U2hMbGNJWXFE?=
 =?utf-8?B?N01qUHRhZ0VIZDl1azNnTUZ3KzFrRVIvZllKY011WVR4ODVsdFE2NlBVWWE3?=
 =?utf-8?B?ekNodjBDV1NVOXJjMkFqd09JTG1rWTNqby81QnBlakZzdHhra2NhRVhtdito?=
 =?utf-8?B?bHVnT29xVGtzQmhOY0U0OGFrRmNLamZBZmtsUGFCOWwrS0ZuMndqSFAxN3d4?=
 =?utf-8?B?V2wranVROWkzdFcxWmJqeUNjbEFLNDBtN0FLQVZGVkg4eDBxZXhLZz09?=
X-Exchange-RoutingPolicyChecked:
	a5NluZ15OtzDCa/VFL7s5+CC9z6u/ky1O6KaSlea41wxxfxWWhz0TaIuks02aTvMNLYBvSP7598laMM/tfO6AOpA1lAkBi6oxmIh6rArJ7DOfH0iDkow/VR1fLjA6eZP0jxcWuu7qO+okDkcuhfwEq52p4ymRYzubAU34tSMbwLBm66tT4l6zvZ8oIpNZT2p9oyuVGEDRAaDiPOuGkKrU++Bij5oJR6eFnmTgn6rFKgBJU5foPU0V80TI2BkbyAV8MoKeOteFMKb0em3mCZe59cGY1R9xJVEIOhuk50pfVSGJIYN2LW+PplyXBec9lwbEij4RebxgOZhgH4kmtIOhw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09d9e75-e7db-400f-aea6-08df35d5fb3f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:02:07.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhW8f00AxnMV7Ls7SPzeg/uqbT95ng8HQpPUr6qo3U9xxIaO3oGw5e4ZL2+bkSKWIVotSqblCzkcDZ4j8EA3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX/gFNVs28oKGV
 NBxnsCirSJim4roxocbDYzmFkvFt9iycvZN51c0R1JfsLbDklT8vvU6QUi99Fv1I2olbKFBvFfS
 FaDSUgLqnzDSZgyH8DlihWXpYR+dgeSMicX6/O1eDcduckJxD9i2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX0c8Ys9WfzEOg
 02RaHKMXFUtnUmV3BkQaEbzoDVpQwnzJB7F2tS7RDAg+l+6b68GjlLvIwEfntDl+uWC8ZhO3FOs
 /GEH1qUbvNNMacs3Dq86vl48MotNS4W+4tqhdx9aXuL4SwAo7mRxmQ8G/0Io0wcnp2EBH9L2CHz
 4uA7kTWAvzxojmd6RzhCssbK3N5UayStEWs17XBYbqfruuQ2odxasBZCL3nPNDvEeIxDc2qq3/W
 DUhXq/xfYdFl4HcY3EZYn/QBkK7NFPgIOIxK9Rk6TiXBl+CkHgk5OVt1njhFtbtH/qUhSwfm5xR
 cAbEr+4XWOtJ7HRLHnu4wWWlGJjU58O6Wb98RW+l1M1Pcs+8CYPEB5OnqM75nS7nUs4Xe3X33Dk
 ymgLFBaurHlspmqM7x0ZfAnUpG2M0lsh7Hj0tJjGMvDB5pxa6npIDilKAflJqPraLLBpHh6lRd/
 b6mst7y8nZyUZoL/kXw==
X-Authority-Analysis: v=2.4 cv=U4QHnuru c=1 sm=1 tr=0 ts=6ae36e06 cx=c_pps
 a=Q0mMAVO0nY0JadJ+SMvTrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=AxGB0BZgqJB0tmy5THcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S6440tzkRPIt9c8TQ5OZDD3212KyPg1L
X-Proofpoint-ORIG-GUID: S6440tzkRPIt9c8TQ5OZDD3212KyPg1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290062

So far every operation goes through STIG mode, where the CPU builds
each command and drains the data. The controller also has an auto
command (ACMD) mode where it runs a whole read sequence on its own and,
with the internal DMA, writes the data straight to memory.

Use ACMD with the internal DMA for reads with an address phase of at
least CDNS_XSPI_ACMD_MIN_BYTES (2048). Below that, the per-command setup
costs more than the saved PIO drain. Smaller reads and all other
operations stay on STIG. Such reads are not clamped to the SDMA size
anymore, since ACMD does not go through the SDMA port.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 261 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 251 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 905292fa50a2..b2c1ba86fa14 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -4,6 +4,7 @@
 
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -63,6 +64,7 @@
 #define CDNS_XSPI_INIT_LEGACY			BIT(9)
 #define CDNS_XSPI_INIT_FAIL			BIT(8)
 #define CDNS_XSPI_CTRL_BUSY			BIT(7)
+#define CDNS_XSPI_ACMD_ENGINE_BUSY		BIT(2)
 
 /* Controller interrupt status register */
 #define CDNS_XSPI_INTR_STATUS_REG		0x0110
@@ -103,6 +105,44 @@
 #define CDNS_XSPI_SDMA_TRD_INFO_REG		0x0244
 #define CDNS_XSPI_SDMA_DIR			BIT(8)
 
+#define CDNS_XSPI_ACMD_THRD_0			0
+#define CDNS_XSPI_ACMD_THRD_0_MASK		BIT(CDNS_XSPI_ACMD_THRD_0)
+
+/* Command status pointer register, selects the thread CMD_STAT refers to */
+#define CDNS_XSPI_CMD_STATUS_PTR_REG		0x0040
+#define CDNS_XSPI_CMD_STATUS_PTR_SEL		GENMASK(2, 0)
+
+/* CMD0 layout for ACMD PIO sequences */
+#define CDNS_XSPI_ACMD_MODE			GENMASK(31, 30)
+#define CDNS_XSPI_ACMD_MODE_PIO			1
+#define CDNS_XSPI_ACMD_TRD_NUM			GENMASK(26, 24)
+#define CDNS_XSPI_ACMD_BANK			GENMASK(22, 20)
+#define CDNS_XSPI_ACMD_DMA_SEL			BIT(19)
+#define CDNS_XSPI_ACMD_INT			BIT(18)
+#define CDNS_XSPI_ACMD_CMD_TYPE			GENMASK(15, 0)
+
+/* ACMD sequence types. Any other value is reserved. */
+#define CDNS_XSPI_ACMD_TYPE_READ		0x2200
+
+/* Common sequence configuration */
+#define CDNS_XSPI_SEQ_GCTL0_REG			0x0390
+#define CDNS_XSPI_SEQ_GCTL0_TYP			GENMASK(24, 23)
+#define CDNS_XSPI_SEQ_GCTL0_TYP_PROFILE_1	0
+#define CDNS_XSPI_SEQ_GCTL0_PSIZ_RD		GENMASK(3, 0)
+#define CDNS_XSPI_SEQ_GCTL0_PSIZ_RD_UNLIMITED	0xf
+
+/* Read sequence configuration */
+#define CDNS_XSPI_READ_SEQ_CFG0_REG		0x0430
+#define CDNS_XSPI_READ_SEQ_CFG0_CMD_VALUE	GENMASK(7, 0)
+#define CDNS_XSPI_READ_SEQ_CFG0_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_READ_SEQ_CFG0_ADDR_CNT	GENMASK(14, 12)
+#define CDNS_XSPI_READ_SEQ_CFG0_ADDR_IOS	GENMASK(17, 16)
+#define CDNS_XSPI_READ_SEQ_CFG0_DAT_IOS		GENMASK(21, 20)
+#define CDNS_XSPI_READ_SEQ_CFG0_DMY_CNT		GENMASK(29, 24)
+#define CDNS_XSPI_READ_SEQ_CFG1_REG		0x0434
+
+#define CDNS_XSPI_ACMD_MIN_BYTES		2048
+
 /* Controller features register */
 #define CDNS_XSPI_CTRL_FEATURES_REG		0x0F04
 #define CDNS_XSPI_NUM_BANKS			GENMASK(25, 24)
@@ -139,6 +179,8 @@
 /* STIG command status fields */
 #define CDNS_XSPI_CMD_STATUS_COMPLETED		BIT(15)
 #define CDNS_XSPI_CMD_STATUS_FAILED		BIT(14)
+/* Bit 4 is defined in ACMD mode only */
+#define CDNS_XSPI_CMD_STATUS_DEVICE_ERROR	BIT(4)
 #define CDNS_XSPI_CMD_STATUS_DQS_ERROR		BIT(3)
 #define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
 #define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
@@ -335,6 +377,9 @@ struct cdns_xspi_dev {
 	unsigned int sdmasize;
 	unsigned int sdma_xfer_len;
 
+	int cur_work_mode;
+	bool has_acmd;
+
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
 	struct completion sdma_complete;
@@ -367,6 +412,18 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static int cdns_xspi_wait_for_acmd_idle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_status;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_CTRL_STATUS_REG,
+					  ctrl_status,
+					  ((ctrl_status &
+					    CDNS_XSPI_ACMD_ENGINE_BUSY) == 0),
+					  100, 1000);
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -378,13 +435,19 @@ static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 	writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
 }
 
-static int cdns_xspi_check_command_status(struct cdns_xspi_dev *cdns_xspi)
+static int cdns_xspi_check_command_status(struct cdns_xspi_dev *cdns_xspi,
+					  bool acmd)
 {
 	int ret = 0;
 	u32 cmd_status = readl(cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_REG);
 
 	if (cmd_status & CDNS_XSPI_CMD_STATUS_COMPLETED) {
 		if ((cmd_status & CDNS_XSPI_CMD_STATUS_FAILED) != 0) {
+			if (acmd && cmd_status & CDNS_XSPI_CMD_STATUS_DEVICE_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Device reported an error\n");
+				ret = -EPROTO;
+			}
 			if (cmd_status & CDNS_XSPI_CMD_STATUS_DQS_ERROR) {
 				dev_err(cdns_xspi->dev,
 					"Incorrect DQS pulses detected\n");
@@ -427,6 +490,39 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 }
 
+static void cdns_xspi_set_thread_error_interrupt(struct cdns_xspi_dev *cdns_xspi,
+						 bool enabled)
+{
+	u32 intr_enable;
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_TRD_ERR_INTR_EN);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_ACMD_THRD_0_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_ACMD_THRD_0_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_TRD_ERR_INTR_EN);
+}
+
+static void cdns_xspi_acmd_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 seq_cfg;
+
+	/*
+	 * For now, ACMD relies on the profile 1 sequence with no read page
+	 * limit (so SPI NAND continuous reads work). The read is fully
+	 * described by READ_SEQ_CFG0: no mode bits (they replace its dummy
+	 * count) nor opcode extension.
+	 */
+	seq_cfg = readl(cdns_xspi->iobase + CDNS_XSPI_SEQ_GCTL0_REG);
+	FIELD_MODIFY(CDNS_XSPI_SEQ_GCTL0_TYP, &seq_cfg,
+		     CDNS_XSPI_SEQ_GCTL0_TYP_PROFILE_1);
+	FIELD_MODIFY(CDNS_XSPI_SEQ_GCTL0_PSIZ_RD, &seq_cfg,
+		     CDNS_XSPI_SEQ_GCTL0_PSIZ_RD_UNLIMITED);
+	writel(seq_cfg, cdns_xspi->iobase + CDNS_XSPI_SEQ_GCTL0_REG);
+
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG1_REG);
+}
+
 static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_ver;
@@ -447,6 +543,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	cdns_xspi->dma_data_width = (ctrl_features & CDNS_XSPI_DMA_DATA_WIDTH) ? 8 : 4;
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
+	if (cdns_xspi->has_acmd)
+		cdns_xspi_acmd_init(cdns_xspi);
+
 	return 0;
 }
 
@@ -527,6 +626,24 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
+static int cdns_xspi_set_work_mode(struct cdns_xspi_dev *cdns_xspi, int mode)
+{
+	int ret;
+
+	if (cdns_xspi->cur_work_mode == mode)
+		return 0;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return ret;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, mode),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	cdns_xspi->cur_work_mode = mode;
+
+	return 0;
+}
+
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
 				       bool data_phase)
@@ -536,12 +653,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	int ret;
 	int dummybytes = op->dummy.nbytes;
 
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
-	if (ret < 0)
-		return -EIO;
-
-	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
-	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	ret = cdns_xspi_set_work_mode(cdns_xspi, CDNS_XSPI_WORK_MODE_STIG);
+	if (ret)
+		return ret;
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->xfer_error = false;
@@ -589,13 +703,112 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	wait_for_completion(&cdns_xspi->cmd_complete);
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
-	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
+	cmd_status = cdns_xspi_check_command_status(cdns_xspi, false);
 	if (cmd_status)
 		return -EPROTO;
 
 	return 0;
 }
 
+static void cdns_xspi_acmd_setup_read_seq(struct cdns_xspi_dev *cdns_xspi,
+					  const struct spi_mem_op *op)
+{
+	u32 cfg0;
+
+	cfg0 = FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_CMD_VALUE, op->cmd.opcode) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_CMD_IOS,
+			  ilog2(op->cmd.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_ADDR_CNT, op->addr.nbytes) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_ADDR_IOS,
+			  ilog2(op->addr.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_DAT_IOS,
+			  ilog2(op->data.buswidth));
+
+	if (op->dummy.nbytes && op->dummy.buswidth)
+		cfg0 |= FIELD_PREP(CDNS_XSPI_READ_SEQ_CFG0_DMY_CNT,
+				   (op->dummy.nbytes * 8) / op->dummy.buswidth);
+
+	writel(cfg0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG0_REG);
+}
+
+static int cdns_xspi_acmd_check_status(struct cdns_xspi_dev *cdns_xspi)
+{
+	writel(FIELD_PREP(CDNS_XSPI_CMD_STATUS_PTR_SEL, CDNS_XSPI_ACMD_THRD_0),
+	       cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_PTR_REG);
+
+	return cdns_xspi_check_command_status(cdns_xspi, true);
+}
+
+static int cdns_xspi_acmd_read(struct cdns_xspi_dev *cdns_xspi,
+			       const struct spi_mem_op *op)
+{
+	dma_addr_t dma_addr;
+	u32 cmd_regs[6];
+	int ret;
+
+	ret = cdns_xspi_set_work_mode(cdns_xspi, CDNS_XSPI_WORK_MODE_ACMD);
+	if (ret)
+		return ret;
+
+	ret = cdns_xspi_wait_for_acmd_idle(cdns_xspi);
+	if (ret)
+		return ret;
+
+	cdns_xspi_acmd_setup_read_seq(cdns_xspi, op);
+
+	dma_addr = dma_map_single(cdns_xspi->dev, op->data.buf.in,
+				  op->data.nbytes, DMA_FROM_DEVICE);
+	if (dma_mapping_error(cdns_xspi->dev, dma_addr))
+		return -ENOMEM;
+
+	cdns_xspi->xfer_error = false;
+	writel(CDNS_XSPI_ACMD_THRD_0_MASK,
+	       cdns_xspi->iobase + CDNS_XSPI_TRD_COMP_INTR_STATUS);
+	writel(CDNS_XSPI_ACMD_THRD_0_MASK,
+	       cdns_xspi->iobase + CDNS_XSPI_TRD_ERR_INTR_STATUS);
+	cdns_xspi_set_thread_error_interrupt(cdns_xspi, true);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
+
+	cmd_regs[1] = lower_32_bits(op->addr.val);
+	cmd_regs[5] = upper_32_bits(op->addr.val);
+	cmd_regs[2] = lower_32_bits(dma_addr);
+	cmd_regs[3] = upper_32_bits(dma_addr);
+	cmd_regs[4] = op->data.nbytes - 1;
+	cmd_regs[0] = FIELD_PREP(CDNS_XSPI_ACMD_MODE,
+				 CDNS_XSPI_ACMD_MODE_PIO) |
+		      FIELD_PREP(CDNS_XSPI_ACMD_TRD_NUM, CDNS_XSPI_ACMD_THRD_0) |
+		      FIELD_PREP(CDNS_XSPI_ACMD_BANK, cdns_xspi->cur_cs) |
+		      CDNS_XSPI_ACMD_DMA_SEL | CDNS_XSPI_ACMD_INT |
+		      FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE,
+				 CDNS_XSPI_ACMD_TYPE_READ);
+
+	reinit_completion(&cdns_xspi->auto_cmd_complete);
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+	wait_for_completion(&cdns_xspi->auto_cmd_complete);
+
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+	cdns_xspi_set_thread_error_interrupt(cdns_xspi, false);
+	dma_unmap_single(cdns_xspi->dev, dma_addr, op->data.nbytes,
+			 DMA_FROM_DEVICE);
+
+	if (cdns_xspi->xfer_error)
+		return -EIO;
+
+	return cdns_xspi_acmd_check_status(cdns_xspi);
+}
+
+static bool cdns_xspi_acmd_can_read(const struct cdns_xspi_dev *cdns_xspi,
+				    const struct spi_mem_op *op)
+{
+	if (!cdns_xspi->has_acmd)
+		return false;
+
+	if (op->data.dir != SPI_MEM_DATA_IN || !op->addr.nbytes)
+		return false;
+
+	return op->data.nbytes >= CDNS_XSPI_ACMD_MIN_BYTES;
+}
+
 static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 			    struct spi_mem *mem,
 			    const struct spi_mem_op *op)
@@ -605,6 +818,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
+		return cdns_xspi_acmd_read(cdns_xspi, op);
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -677,6 +893,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 	struct cdns_xspi_dev *cdns_xspi =
 		spi_controller_get_devdata(mem->spi->controller);
 
+	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
+		return 0;
+
 	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
 
 	return 0;
@@ -691,8 +910,9 @@ static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
 static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev;
-	u32 irq_status;
+	bool acmd_done = false;
 	irqreturn_t result = IRQ_NONE;
+	u32 irq_status;
 
 	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
@@ -721,11 +941,28 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 		writel(irq_status,
 		       cdns_xspi->iobase + CDNS_XSPI_TRD_COMP_INTR_STATUS);
 
-		complete(&cdns_xspi->auto_cmd_complete);
+		if (irq_status & CDNS_XSPI_ACMD_THRD_0_MASK)
+			acmd_done = true;
 
 		result = IRQ_HANDLED;
 	}
 
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_TRD_ERR_INTR_STATUS);
+	if (irq_status) {
+		writel(irq_status,
+		       cdns_xspi->iobase + CDNS_XSPI_TRD_ERR_INTR_STATUS);
+
+		if (irq_status & CDNS_XSPI_ACMD_THRD_0_MASK) {
+			cdns_xspi->xfer_error = true;
+			acmd_done = true;
+		}
+
+		result = IRQ_HANDLED;
+	}
+
+	if (acmd_done)
+		complete(&cdns_xspi->auto_cmd_complete);
+
 	return result;
 }
 
@@ -1258,6 +1495,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
+	/* For now, ACMD is only supported together with the internal DMA */
+	cdns_xspi->has_acmd = device_property_read_bool(dev, "cdns,has-acmd") &&
+			      device_property_read_bool(dev, "cdns,has-internal-dma");
+
 	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
 	if (IS_ERR(cdns_xspi->iobase)) {
 		cdns_xspi->iobase = devm_platform_ioremap_resource(pdev, 0);

-- 
2.56.0

