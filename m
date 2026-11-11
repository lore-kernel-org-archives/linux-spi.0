Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403359;
	b=DsK9IihiXCWEDNq/Jecbl7FaXy1jepnldlRhcDbhee8owz4cuh0cyzTGP5lMDf3XxN8m
	 R8xb92nEyUH9vP7FLeW5phG2OOOrCuPCz/WIW2wpt1GbxB65mb5i8GsjspHXxLyi/TMis
	 AEL7a/8AFUDVmKA8+xVxCpcc3tyHuhfJEYnVwbD6al85B5IlwLrXQtGGEkZyLgBQMDjh+
	 TDrhwqw3k1MjTCIMmBOEo0+nV3Mcou52AzKtAWEbZvwyuowZp43fFINLjgcnhfw2dkyht
	 BD+FMARHnxVMsUYMt4hlD5jdDG36udrzikSa/OEMSOQq67+PLIsmE+DDp3y4W2usPug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403359;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cYBZeJ2p/HzjEvDi8qR0IaOGcW6RJOHyaWluXFhWtSo=;
	b=DCzXni41Ouc4QiRwkLOqUiEfo8fYMSM5nsYPq6S/9ee2qisFI0d4A4y4hxYy/b0Gcrlb
	 B3ZBVkrRdR+Rvz64pNMz3bM4bTIYza9ZBokgKKKwATPJFr/+DdL9Zm5F6b0BR0c23O05d
	 VUSFxfWlDagrh1KFK3qhfpLdhuiy/A2tUvQ6dNPpFoiRezvjRHWtqVe2clBQmH1fx4bmm
	 oLRaWwp6CRQGeZQgLNZUAOR5p9b58hU4q2A6ixMh0BfAT8I+OZsGoXjusWpyp6S2+pjff
	 BZnF5WibP0epiF4e4ZOjpdJ5vX6d88IuTf8z+agLUi4Bsp/+wH0Ul80xNL6Mj5ZjkYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GjRa1YFV;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vlexA9pK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737C660A262C;
	Wed, 11 Nov 2026 13:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737C660A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GjRa1YFV;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vlexA9pK
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWBX3098068;
	Wed, 11 Nov 2026 08:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=cYBZeJ2p/HzjEvDi8qR0IaOGcW6RJOHyaWluXFhWtSo=; b=GjRa1YF
	Vpa8uyfAtMYai28wQyiRjpn2W/vdqfbRM3Oke5H5brekJ/sOAFam0GPYD+zL3yBF
	XciWsg40v0AZQvnepedwX1mewFMoqfi15JSHA1hAS9t6j1Ib6EceuVnDQi4ptNZT
	ExdIvw/FJ/pEYiZe7OpiRPJnfRQbeLxKlux1W3hf2NifrrkaIBIboffb7XOszX9x
	yOOOwwmNXs57LOfp4O5ihodUNVOSEwyyBpK9OgblTjImd8fGK9t53s9vbXh13d6Z
	kz9u28hNNyWMu/zIfn3AeZ005PR5hzR77y4iFagYyroXa/JdrAvZOIuEWuioFjk4
	tG/YNN1TDmUEZbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cYBZe
	J2p/HzjEvDi8qR0IaOGcW6RJOHyaWluXFhWtSo=; b=vlexA9pKVVTSHdrCJMRBz
	YT3cpRR38HA1kZU3X4MIzRKBA9RWjMnkC+q8DWzmR5WS1X6J/iLAkgRujAiseUCQ
	8+i8DimjUEVbN/VUB7PnsYsYdQ0kccdc0ZayMKrWNb52zzYE2zKe3Z+ukDiYgBRe
	cfCXTjXDZd9e9czT5why5bd7MlTTvJXtkQ2+8mQ37Ue5nCnDu1Dxc5GA+M3+yvKt
	FWTbjJqcMDyVmb0pTA9H5aow6Kl6DbRE6GoOGNOAFM8KB7Oije7xvGWJoL7pI73z
	NmeAlXeaRrk4qizKaGCjlJ4J4pcgC6zv6pjQ/tV/TDy0qTvFAqz7ZmScLPjbVwNa
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvqu90dcj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:22:17 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsoprx9+gQLEsz8XLHQtjNfjixeff6XQt+QLqQVKt24kKZJ6tUxdxwwMxx7isup7/gv4WZ83zQAfKjmzJSe/Cg/cTTi9FiJMzuffROn1PDqU+GVqItN/61BCEdj69r1jCxAjDYw6BMqZonUqn7aZ7nIsBOFb1Z08ET02N6qIZX2oigW2uYPGTqWnN7PWRI1Y4nCGN9tf4wX2/55mccFkOuOn4+Yi+ZqaMQaSS5HtGwFwznchzFWAWeJlOSJOXUcCA+g738Z6JuXGX0EVJG9q3vzIe2rLxdwJv2XgcYcJBzaEoCpe0ZrjELot+tchnXaWx52kkW8cwc+OdHTjA2cjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYBZeJ2p/HzjEvDi8qR0IaOGcW6RJOHyaWluXFhWtSo=;
 b=RvTdZobU3YxrjyMbmL5P9y6KK8V0QIJe934YM1VXcM1UtSXRvhcN/gMyk13x5w1eke3Y1IkmeW2Facox23UizW14/yd7piqrKEtFUB2HuGj2qcp5wrG+yIvJtlWdnK00ox9FXreN4H6br++SkKJUCL6Im8tzQAq8InptQgbLrUU1SgneiDD5nDbE4adtpMJ50Of2ruKbspdPIzmk0yQIKAMagr+TKZIt1aTmfITApNCKe55rDirxKeY4jO+MN61Uv8v+p/rYFDCN4Pl5B1KdEsDuEgjLXqTQvw5F2WJjqhs+hLFHWVDuKUHZtzlUft80KoeSQ1U5AM+VHbeJLYle0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:22:13 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:22:13 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:09 +0000
Subject: [PATCH v2 8/8] spi: cadence-xspi: add ACMD mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-8-d339046ada8b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=14950;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CF8VzwMt46Zo801d47OnKqwZhk2qfmGsMnWBCyYgJHU=;
 b=BMdfZcgugcMm+84EfH6mnNHGEbB4hLrulXYx5RC58AsEtXxMnk39jJeC8PTR91mwFlFErH9WZ
 nai9zFl6CJ1ClXPiagn6OI8xN5jEFpMhKUJkmlL+XbHhEytsm7FtIoP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5877b4ee-1e38-471e-eeaa-08df3ff6cc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261022113327099003|261009220027099003|261022075727099003|261026121527099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|11063799006|261028144727099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	22pJ/3vtA8gs/nciiXAhd9AgOGKPJkhx/Cn8QLwmPym9x962LTeo2LpKc+v+G5jritL0XftPlH8n1tHq7pOpH6bncrkXlpBDjDF4JQWcrDY7Sa8gE9FdaHNPbKN4QfQlpImNaPXh3gTNU/k9wevoAyLLLNwSdU+vc1hK+jXyV1jt3U6S5feb2Y3hnjm/PwfP0zVTAgdTA4kx/B0TYV4/PtuKzyhIZkZWyDg7ryDfUjMvvTd932Wbz9hYrF41U/5SBwIxv8nFqj+x2tTjCnPtFkClmxuHEuPaj20p8igr6ORPqCaEwZONG8XmhtayWihQeNbmGnPwfEBdToTzfgrJnub6dzlOfro6OGP0/kS4dW081Bp8bYjqPgzR8puwRuI3ZzMriVE8g+QV15TcEsikckWMgBD2xyYFelJdMt3/8EsEqJZUTEPkkpnU4KvzxaWWVCH+6w1zQkfy3gpXFoK5uusf+eURzF/PNdwOHK9cRoTn9irMHyJYg8KuOQnLZYXxpIpFF/PL3r3NGdybI7Xaguqx0c3A0bdnCANnbV4azDixU2yn6Ay2tALQcDmkB0NxaOeAZPP+lcaecFn9IAVPKm/jMLGI/E0qxlcyjbdj3KyB6uUdghhAuh8RF3n23w6v9I/zEI1LZuR9uX0sPw8/fKNEUJfRg+QO3tnMKrlLFvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261022113327099003)(261009220027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2VWYmtvZDArTkNtNms4bTBqNFN1ZzlhcTNuaitXaG1PSERXUm9qT0x6NHc4?=
 =?utf-8?B?ZWJCWHJYeTRNRFI2dFJQQkNrZnlZZGR5TkE4anlxc2ZwK2JxMGcrYkpTWEx5?=
 =?utf-8?B?THJSSWhPUC9SV0xId2xnNTRwVE1pMGNXNDBKcmdRN3BvejE1QndDTURWZ0do?=
 =?utf-8?B?UXRtVXcxVXR2ZFN6aWhGZjRJMWp5ZlRHRmhINUFSZnYyaDZiWGZxalp2MjB5?=
 =?utf-8?B?bC85MG1SK3RibW9nSWhHZjRNaDVFb2xDN0k0TjB6YUZ4MXZLMThZaUhtU0d2?=
 =?utf-8?B?N2p5d3BZbTJKaSt1QW5ZTlVNZlIvQWQ4dlVvVWlsMmZqSDRMSkExdmpWZTdI?=
 =?utf-8?B?dStMUzYrT3gvR0dxOEk0UWdqZndqM09Xanh3Z09xenRrN2JPMXA5LzQ2RWVD?=
 =?utf-8?B?ZWQzb3o4a25zTXdwQTdYclNwcnVqNTFhazMyaC92eUZVWG5GVndCdEN0QUJW?=
 =?utf-8?B?dXhNL0lqaHdMc0dNSXpxZlBPRkdCNiswemFhNDJ0Y0VJTVRpWW1CZEx1TFlw?=
 =?utf-8?B?WW5vYlllUXpaK2xVdGtoQXZpZFBEcDI1cmxFWVlzMjVQQXo3S1ROOXdvVzFv?=
 =?utf-8?B?UnVZZm1lc3hIcU9DanlXbjhqdGc2TVZrbGIrS0d4aFpBdEhRQklMQ0ZaR01y?=
 =?utf-8?B?ZmNPMmcrZjhnZWl2eUtsK0tONG4rM0FqSUkva1BORTM4NlVobkRNS3lveFRw?=
 =?utf-8?B?TGJoQlJKOVBsem43WEZzMnlyR3hVNW1tT2lVNlh4VkxWL3NoZGxoaEJmcC9F?=
 =?utf-8?B?ak9VVlNPK21rSXpNcGdIMHF3cFBidjdZaU9xcFhYbkdYaUx4Y0JHb1pGUXNL?=
 =?utf-8?B?UnVxRzRNa25ERnlyOSs5UFBxaENFYW1sWDlZeDVRc01jVkxMVktmQk10TEYw?=
 =?utf-8?B?NStqdnBOQnB3TkZ6T3g3TTJoa2Z5MFVub0xHRjBPSzVwTm53eVA4WlhEVW5k?=
 =?utf-8?B?RTNNTTkxcEZoQWtETk5XSVgwZVQxenZEdU4veWhCT2xLdXdadll2Ry85bG9x?=
 =?utf-8?B?OFBWbjlKSVNlbnR6eWlzUVJkeHlyaHBVclZLRkVndHBHVlBaMU5henhvVlNq?=
 =?utf-8?B?dVg5VDBtSitlNENIWk1xb2pubUtLSjVCdm5EVFRrbmpRSkh4b2packlBampI?=
 =?utf-8?B?QlFLQmNvK1krUzMrSXBQcVErWXJrai9EV01yOGVKQVNYZk5hbGROT0piU3Jt?=
 =?utf-8?B?K0ptRllnb2JjTVVDRmlBR1JEV1pwNEgzQTVGazBjQlREYTRvb21XcGJJQ2Vq?=
 =?utf-8?B?bTRscVFLZTdFR2dzRUcwWW5OUzN0MVA4SjY4UkpKTVJ5dEVYRUFqY1luclpB?=
 =?utf-8?B?ejRORWRBS05hODZ5d05NSzBxM0VGeURmOVo5U3JlV2M0RndaM3VLdGU5dlBa?=
 =?utf-8?B?NjkrZFVmakJIVE0yUVR1eWlTWWRtbTgzMDdKY2s0VW05WWxOOVRIaEkvZUxW?=
 =?utf-8?B?MXBEZGlqVzhmbGFWT0c5RWNaSU9Ya3FiSG5EazdUT0lOMlg4V3ZjOGFIT2Jm?=
 =?utf-8?B?L3dUbElZYWNUM25sNm0wWjMvZHZlakp4T0ZpZHlFaElvQnZsWlc3RE1hOHJD?=
 =?utf-8?B?VndmYjlCeUdLeUlQaEZ3azZlbFMzV0YvSzVHcTB5ck9qMXpzQmNmbHo2eDdw?=
 =?utf-8?B?WWJhMWtuU3dJYzNqam9nU0hDajlHcUYxWjRvTTQ2LzBRUVIrT0x6N2dFaGQv?=
 =?utf-8?B?a3Bsa0w3bFcvQ0VqbXVnMWNCWDRyUGZZM29MWGdiYlM2ZEtieWVMVTZNMHFy?=
 =?utf-8?B?UGN0MFpEMFQ1TVp6c0ZKNXFwWW1XanErMFBoNXdPbHVtejFVZ2xJOGRuemFC?=
 =?utf-8?B?NzVwRXFtbHg2RTlJMjMzdWpPdGxDakJ6alUrS2tUandQczIxNjFoQWFFTzBw?=
 =?utf-8?B?ejFmYkQxNHlLYXEyZ0hPS0RVVzU2SkZWb1hkQkQ0WFRwRks4ZS9QOXdFenE3?=
 =?utf-8?B?TVBsb1R3a1VlTWtCS21wMlVJbEFTRmpQRXNQM1NwRWdaMW9VQW52S0tZSXIy?=
 =?utf-8?B?YmhWK1BQSVBhbzZWV1M1ZWxvOU5ya1F5Y0JpUlNqRFRFb0p1VmJDYkxKM1NG?=
 =?utf-8?B?VTgxdG1Od2V2MGRZSmxxZnJJaVh3aWRySW5GbDBiUjRNNTEzYzB4NHBzeksx?=
 =?utf-8?B?QUpydmJyeTd6TkllYWpnTWdpeFdZaThIaEVvcngrZFZHd0dCd2c5UWRnakp0?=
 =?utf-8?B?Si9HUmgxTUNFTmNGSVpFVTVsZ2I5NWh3bFVyVldaNVFNcjBWOExUZ2F1dXhj?=
 =?utf-8?B?U0FrU1ZXcVdXczJCSzlmbUFwVjlSbm5rZ2hnVG5jdnBnNm5ySzU2MWNIMVUr?=
 =?utf-8?B?T2dKSEwrbzh3bnFDMnIrREkxbmRKUUh5dHkreE5hTzdxNkR1eU55UT09?=
X-Exchange-RoutingPolicyChecked:
	cH+TURVS3FbQQdYySs/JPr75hJEU/YqNkHhDFytqE7LjRktj9ghs49eds9jpo3agiHv2E0m97IK08aRxqvrfGdQ2Z2w5bUg8QNdbvEtM262rGsqKbnP+h6GdG9rCkF9KPz+0pTw4aMAWtkzReOjzT2IZcw0n64rFO/agsUMAhCPolB3xkszWML+XRE+BPb3kwH/kXL7p9hbs+f9sxkAGUSUIEHAGR5Lo5dyy6bOH5RQ6pLS4TYbgCNmxkblFKzqJbTMR6BPt9IQbZYlnsw4fhFeHR5EYFtzBTNrI7lS9+qoWp7Z8N/WSMrY72R3GNzJXsSbz9l68mt9lYpH8AQ4ESQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5877b4ee-1e38-471e-eeaa-08df3ff6cc7a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:22:13.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMgzazDrRtg+ROKrwS3GltNlbtZK9FVug0ova+RTtJEChulYV6c387jL4uqOMTKqtaY32S4r5YiY+Ltiw+y8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Proofpoint-GUID: gE_Fer-T9xnNuIt-mHkZOTs-YzJwAw91
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX3wSXkw2UDBix
 8X42u7IvqogOTRQvYW/OyZ0S3Ph/s75EiF1EuvuYlLK4hXsfBtYsTMSNAJIwwwa7oOBW7KQXrYb
 sFv4VT+XJmEnXccbeQVtucZawb92SWBM1I1/JyKi9lH13Iga7+Qd
X-Proofpoint-ORIG-GUID: gE_Fer-T9xnNuIt-mHkZOTs-YzJwAw91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX/jpp6HVKW2Co
 dwca9utg4tFzVdSX1j4UDWzB0Cmvj/cg1nYMWEXqohoGtj755oYhNztxRSOTQo/1MpwcHyQNU50
 Qsa2aqQDwa5tlshB20XMQEmv99OnifyU9vI4HnbC+1InZbeoEiVHoD54JVKSs0RlzhinDP04yg0
 YjnccDaiKBL12T1xvNw1y8yTFmhKr6qabjExCQzTCUlQxj5BsAp/ze8AEudQvzVypE8zfsDYFwC
 6tK4dQmZTDBvOGqNFkXlPo/jHqJeIrKoLdYaaBwi/VPpJsO5eXvDSqhsPhRIg7HUZgNU9kSAdVn
 ve/CwXLPuiozdAngOhH/floFshfpl1qFTWY8NzOcN5mfHBav/w9swWgDr30lPsIcLZz0B3z/oTn
 mMOyKpxMaPj4gRBpIE/5v3TDMtDy0b1qbLGH+m6Ehg4rJZ926uHAXkWq2m3Wyuq78mMxUXpv22a
 4VkV2gmammU9gPQ7y8w==
X-Authority-Analysis: v=2.4 cv=fcc4WEQF c=1 sm=1 tr=0 ts=6af46c09 cx=c_pps
 a=/wW/AzpUxuI2oar4/bQbzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=AxGB0BZgqJB0tmy5THcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

So far every operation goes through STIG mode, where the CPU builds
each command and drains the data. The controller also has an auto
command (ACMD) mode where it runs a whole read sequence on its own and,
with the internal DMA, writes the data straight to memory.

Whether ACMD and the internal DMA can be used depends on the SoC
integration, so it is enabled through the driver data. For now, only
the ADI SC846 integration enables it.

Use ACMD with the internal DMA for reads with an address phase of at
least CDNS_XSPI_ACMD_MIN_BYTES (2048). Below that, the per-command setup
costs more than the saved PIO drain. Smaller reads and all other
operations stay on STIG. Such reads are not clamped to the SDMA size
anymore, since ACMD does not go through the SDMA port and its transfer
length is a full 32-bit field.

The thread error interrupt is only used to wake up the waiter. The
cause of the error is always taken from the command status of the
thread.

Since the controller might lose its configuration across suspend, the
cached work mode is invalidated and the ACMD setup is redone on resume.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 253 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 245 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 55b37175f08f..061c245130ef 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -5,6 +5,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -71,6 +72,7 @@
 #define CDNS_XSPI_INIT_LEGACY			BIT(9)
 #define CDNS_XSPI_INIT_FAIL			BIT(8)
 #define CDNS_XSPI_CTRL_BUSY			BIT(7)
+#define CDNS_XSPI_ACMD_ENGINE_BUSY		BIT(2)
 
 /* Controller interrupt status register */
 #define CDNS_XSPI_INTR_STATUS_REG		0x0110
@@ -111,6 +113,44 @@
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
@@ -147,6 +187,8 @@
 /* STIG command status fields */
 #define CDNS_XSPI_CMD_STATUS_COMPLETED		BIT(15)
 #define CDNS_XSPI_CMD_STATUS_FAILED		BIT(14)
+/* Bit 4 is defined in ACMD mode only */
+#define CDNS_XSPI_CMD_STATUS_DEVICE_ERROR	BIT(4)
 #define CDNS_XSPI_CMD_STATUS_DQS_ERROR		BIT(3)
 #define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
 #define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
@@ -335,6 +377,8 @@ struct cdns_xspi_dev {
 	unsigned int sdmasize;
 	unsigned int sdma_xfer_len;
 
+	int cur_work_mode;
+
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
 	struct completion sdma_complete;
@@ -364,6 +408,7 @@ struct cdns_xspi_driver_data {
 				       bool enabled);
 	int (*init)(struct cdns_xspi_dev *cdns_xspi);
 	int (*hw_init)(struct cdns_xspi_dev *cdns_xspi);
+	bool has_acmd;
 };
 
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
@@ -394,6 +439,18 @@ static int cdns_xspi_wait_for_init(struct cdns_xspi_dev *cdns_xspi)
 	return ret;
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
@@ -412,6 +469,11 @@ static int cdns_xspi_check_command_status(struct cdns_xspi_dev *cdns_xspi)
 
 	if (cmd_status & CDNS_XSPI_CMD_STATUS_COMPLETED) {
 		if ((cmd_status & CDNS_XSPI_CMD_STATUS_FAILED) != 0) {
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_DEVICE_ERROR) {
+				dev_err(cdns_xspi->dev,
+					"Device reported an error\n");
+				ret = -EPROTO;
+			}
 			if (cmd_status & CDNS_XSPI_CMD_STATUS_DQS_ERROR) {
 				dev_err(cdns_xspi->dev,
 					"Incorrect DQS pulses detected\n");
@@ -460,6 +522,39 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
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
@@ -480,6 +575,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	cdns_xspi->dma_data_width = (ctrl_features & CDNS_XSPI_DMA_DATA_WIDTH) ? 8 : 4;
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
+	if (cdns_xspi->driver_data->has_acmd)
+		cdns_xspi_acmd_init(cdns_xspi);
+
 	return 0;
 }
 
@@ -560,6 +658,24 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
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
@@ -569,12 +685,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
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
 	cdns_xspi->sdma_error = false;
@@ -629,6 +742,101 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
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
+	return cdns_xspi_check_command_status(cdns_xspi);
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
+	return cdns_xspi_acmd_check_status(cdns_xspi);
+}
+
+static bool cdns_xspi_acmd_can_read(const struct cdns_xspi_dev *cdns_xspi,
+				    const struct spi_mem_op *op)
+{
+	if (!cdns_xspi->driver_data->has_acmd)
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
@@ -638,6 +846,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
+		return cdns_xspi_acmd_read(cdns_xspi, op);
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -710,6 +921,10 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 	struct cdns_xspi_dev *cdns_xspi =
 		spi_controller_get_devdata(mem->spi->controller);
 
+	/* The ACMD transfer length is a full 32-bit field, so no limit */
+	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
+		return 0;
+
 	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
 
 	return 0;
@@ -724,8 +939,9 @@ static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
 static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev;
-	u32 irq_status;
+	bool acmd_done = false;
 	irqreturn_t result = IRQ_NONE;
+	u32 irq_status;
 
 	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
@@ -754,11 +970,27 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
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
+		/* For ACMD, the cause of the error is in the command status */
+		if (irq_status & CDNS_XSPI_ACMD_THRD_0_MASK)
+			acmd_done = true;
+
+		result = IRQ_HANDLED;
+	}
+
+	if (acmd_done)
+		complete(&cdns_xspi->auto_cmd_complete);
+
 	return result;
 }
 
@@ -1444,6 +1676,10 @@ static int cdns_xspi_resume(struct device *dev)
 			return ret;
 	}
 
+	cdns_xspi->cur_work_mode = CDNS_XSPI_WORK_MODE_DIRECT;
+	if (cdns_xspi->driver_data->has_acmd)
+		cdns_xspi_acmd_init(cdns_xspi);
+
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
 	return spi_controller_resume(cdns_xspi->host);
@@ -1463,6 +1699,7 @@ static const struct cdns_xspi_driver_data sc846_driver_data = {
 	.sdma_handler = cdns_xspi_sdma_handle,
 	.set_interrupts_handler = cdns_xspi_set_interrupts,
 	.hw_init = cdns_sc846_xspi_hw_init,
+	.has_acmd = true,
 };
 
 #ifdef CONFIG_64BIT

-- 
2.56.0

