Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D32187346;
	Tue, 18 Aug 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069817; cv=fail; b=DUo8SupoZvQ1ADM/k3hVpaa6QTMWuiZeNwZyOCTec7OZ0JWkGw2HECHv5i8f+SgDS21KWip7HlUEQeyS2R8GhveLePwdrG2wDCGIa6WqamoN2j/wIdPJXkRCQyr5M+YeN14rYg2Ufkb+nQMFuiuAbTUfMWiOu3W2hqc8q+1X+2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069817; c=relaxed/simple;
	bh=0Wa2cyDikDtFOjvT6I47v2X4dBZJrmUhoE4ckoVkjfU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=oaRY/9UjLIgC0u/Njo7q+LR9iWIVLjpfsAi6lAedKiFvpHBNkcIn6PytpoTKToRxeYJxSLZR/R1qqw+ynxtt5G3eA7Ao1Omtq663dDCdbq5KDaCeYO7k3ej90K1LlO0KH8j3aUX3NYnTtDFV3PAh7rBAafHvgypGboYU3xXh+6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yj76cjCi; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yj76cjCi"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDtCbD3840295;
	Tue, 18 Aug 2026 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3a+ck
	7VSgo3zmrcu2g8tFjzchGS47qYXC2xoatM73yo=; b=yj76cjCi8gRFPvZSwEDfX
	CkiLePKAAD8Hvrja+AKe58lW8vhMfkhLP1qiQ3BKJ0DdEXNGQbGYScyzhP9kojYf
	voranWV9lFEhxpuuGi+pETE6TFW1G2GaqvmQkLaCln9fUSBrqSXeBzz0zqWoc7ae
	szrfYHodI6w84qdS1DwQvy8++OunjXngOMNDL+VxLPKuiuk2w0Pbe5S7jxWLS7MC
	DkHTtKl4fUnU0tF9yHEfbu03pYkdTsBmJ85f6eE7QxAHbfE41mUHEWRC2O99iwpt
	5cQ99aTClnKfNcfGQeJxhuS5Yvl0f+33ClX2Cpp5ot6gxF6hOBLPv45LpbtcOGUL
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4p1p1dtj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:16:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBQyl8EYXHNNtsYiwV2ZSagD4czrNf9caVh8NqiphSsU/JP+YOAu5ZKupTugq7RQIiy3PSo+SKtMKSqJ6z5dP/XWOlu99MBblOHu3mdTBZ2hZZOPkEUrt7G4HFgOIwOjKSzNurric3ySS4Ao0ud1hblcrVmoEMErvPIvJbBZl9AIF5iHSmXypsrncTH8XdcVKiDuJKyCzkSB0mPYQpAJy/Fb1dC//ASgRjO/ax26y34g0gEhXxyd2/yx4SSkV5G4y7j9jAc1VcbqFkeUigEEL2EEU+N6BYPewpr2ebWy6/ZcS9RueFgalUf4+aGrNuX4LrYRN+Y1b1BmapcQT/HBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a+ck7VSgo3zmrcu2g8tFjzchGS47qYXC2xoatM73yo=;
 b=FXXqyU23QKjAZSChzFIxiJ+ZeOTumHRRxfnMxOEP+K4gR+X05ixxWM9l5yGVO8ybumllSM7+w1dL+EvLf5wXE1uN6ZNAEv3O2xDiQx5AoNx8FCFCOt/EqrPS44LeMi7NbuInyJXppJesGI4xji4SBzFkMLDqUPJw4EypJRtyIdGZMtY0rJvYO8gXN3KVCTJsCP4Tjz9bXQwOnfuosXJNuTC6lwfCQr+adCCi4iW6TVEkOKmdvPjwAMMpaQH7tB0LaKIDwMCMoZZHWvVpJVlw5CasfofR4slFZn0joQ6+LfFoIz84gIMZN1mbDUFl/dMn3yJW6yWcDcip37ftdPiQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7268.namprd03.prod.outlook.com (2603:10b6:510:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:16:48 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:16:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 6/6] iio: adc: ad7768-1: add support for multiple
 chip aggregation
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com,
        michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
        marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
In-Reply-To: <098f11b4ceca37037e770363bf4aa7e8dfa6bdaa.1786973376.git.Jonathan.Santos@analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <098f11b4ceca37037e770363bf4aa7e8dfa6bdaa.1786973376.git.Jonathan.Santos@analog.com>
Date: Tue, 18 Aug 2026 17:17:52 +0100
Message-Id: <178706987295.3163.11524351499173013451.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787069879; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0Wa2cyDikDtFOjvT6I47v2X4dBZJrmUhoE4ckoVkjfU=;
 b=lSCfWVlm/B2/GFJ2Vw3sXK8qAFUKa/MKzDiDBcDJEGaHt1fSIURDES3rfmzbrJJNeR8pP4upX
 +bDbrsHbXbmAdAMDZflFLQ5n4C2IPcZuBffr+Tqs4PjMzYg8/08Moac
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 29877fd4-dc8f-4213-09a3-08defd441ad8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 UP8GjXJpIw8KsuIsgju7xkaPkqtIQHBKEdSkRbPdAleXEp2CGCj+Qp5sOFOlUNn7ey0+PQIf97oaDqrX5kdYN6X+pvsMI5faZChPnGtTOvVHRWMI0tW4/OyXfiC0IdAK66Ah5Rc1u2AheUWexJaF47lc5PTvrKpCbFJBMVGSetoNqw7/iSLVir/eEVue81VcuV4Av9xvDXbFlSOKIH8fRRPtFHtWZLKupXb8LOBr/4UxoILtfs1x3RN4NZ+PFAdJjBqlLQMxmdiezmkVcxWkrRWNVa3q9GtCkBUBYEtkDAQm0Tm6XkcpD1ZsXTZDLYMWXrUj2c8aXjrxUsBw0bMtqTeoT/mo7vuA0YEt7m/N36OAjSqXTePamt728hM2m1fOVZG3++mTKG60airh5vDaHb4LZYp2FZdFqqSCOWRa1z2Uz1d9V0Lut3uz8Hb6OkHYGtYqIHyiz1jX33jMlaLWr/989CBB84fHaEZnL6XE2uy0roRfICH3QHr7iuke1ydelGPkRdRVt5/xI5FjkbeW/s0V6Ya8Z6nAT3qSOIg9i455gMppZYv7EwcUzzNFx3NGexrMRADE+s7sslUTa62iqA+bzrjTDtNRPVnhc1l/7pZZ+U4MBnfPqbTYmvkjQowYsVGbkVlKIN06WY1/a05zTImVahpWpr50e2pGM8wCREE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T1dkKzcvdEdWb1pFemRmbmUxZmdSRkxwWXB3VEtXRjdLMWM3WE45ZjZyLzRT?=
 =?utf-8?B?aS9CSzR5ZDJERkp3UFdtNnhHZUZjTmp2R2VqODh5Zm9jZzdTQzc0OWRZMld6?=
 =?utf-8?B?MUhxR1grYmNHTkV0blh2dnVaMEhXZTZjZGR3YU4xYUxpOGFWMGJvdWQ4ekJx?=
 =?utf-8?B?ZGxyRWpYZUFKSTkyTmlPU2xZNHdKYzNsV1ZJdmpvN0lrYVpCdXFnZWN6U2RM?=
 =?utf-8?B?ZGM1MjNSMEU3YWNONDVwYXl5SDF2ZXd2VytUcmhVOGdyS2FGNnlPWlFzelNC?=
 =?utf-8?B?TExiUDZZZFRMdzJTM09pRE5ZeVJFMlhOamxIOFZoYWh2czVtbSt3MlN4WW9I?=
 =?utf-8?B?cDNjVGwzcTlYdko2dllmMGQ2TUxqMzhtNHdWazVZQ1JIZzBNa2FFY1RwWEZ1?=
 =?utf-8?B?NlJjMFRxSnJibGxkSHEyWVVzc3lOYVdkNmJrVWJFTkxhU3VBQ2l1RmQ2dFQy?=
 =?utf-8?B?elJuZjU5c1FWZ3pJS1RHTTcwOHZjYzZZTXpQcUhnZ0J2RHAwdENwZXF0Wi9I?=
 =?utf-8?B?U0g5YmJ1NGpVTmxYVWg2MkdkcE56WlcweXVMejZFcHN1TmRKK1JBLzhRY1ZJ?=
 =?utf-8?B?UU1HUWpHTElhTDRGRGJkNzkwZEVmaU81WGRIZ291WGcraTc3S2dXcitadkxV?=
 =?utf-8?B?dWdEZjZ1YUxTK3FiVjhsMmtWT1ZtYVlnUEpscUdqZlROelRxc1lVZk1XSDQx?=
 =?utf-8?B?Q2N5Q0NpV3ZQdU1TMkRCVzdQbGlJbkZCQzVKRXVsY1FDbWlqU3NEQW1HdmFW?=
 =?utf-8?B?eW1EOHQ3T3NoTCt6T1hlSHNUbXZEZWVJaUUrNmh4WTVZdnNheDhRRktiU1dV?=
 =?utf-8?B?R2JVQTFJQS94aXJiNUo4T2IvRFRJZHppVWY4eDFlUnZUekg3d2hCbktvNXRF?=
 =?utf-8?B?WnJNN0lYcDAvbElmRmtDWGJLTGF5b2RXUlFtQnJxYUNEV2lxS3NKdW50S1Vy?=
 =?utf-8?B?Zm9uT1lnRENYK2taSm40cnF4NTdKZEhDbEFCU0RuVmptUWd6QzRGdkZaTWF6?=
 =?utf-8?B?c0tZNnVTRnF3aHpYMWdXeG1yU0s5VkdJVjNORW5ydGdrNVgzdER2eUZKT2xU?=
 =?utf-8?B?RTFhbkpwejJDS1VBUDJCVlE1dk51bGtiOTVzaG9vZENaTHFLL1g1a0d3UmZ4?=
 =?utf-8?B?UE0zZlNMZ1NOQXEvaEtYWW9HdlBDbFJrVUkwMGZnL0hVWkNFemhSWWpDOGxT?=
 =?utf-8?B?VkNpU2hKRG5hQ3ZQbmtHTFQrckdoMll3SlJRMU9rVnFzUkwySFA0SXBKSTVK?=
 =?utf-8?B?THZGNzJZZldSM25PWVVZWStYaTN2WTc0RmlGUFpLcUU5VmdhTVF2SEpkZW0v?=
 =?utf-8?B?OUR5Y0F2WGRtTFFLclU2MzFManc1QVY0bDFQb3lwVnZsOGdOOUpUeC9jdnhr?=
 =?utf-8?B?cmw4YXF6RGZ1UUs5VkdsR3lNS0dkd2V0QTh4cHpobm9KSmx0S05UVGZVQy9t?=
 =?utf-8?B?dllDbjgwUVh0SHhRL3YzbXJBa21WODRGWFlwQTFuUDY3VHFaemo4cWJ3RjV1?=
 =?utf-8?B?VG5ZMjJFSUNCOCtOVkVjVlZyaFNybW9kajlHZDhmVktqNjhubGVQTngrbVh5?=
 =?utf-8?B?UEM4TGdHeG1ITmVVL2ZIMjFsVGoxaUVLQUwvemE0VW1KRFVvNHZ6YWVHSGx4?=
 =?utf-8?B?VXYyZWpOSnZvZWplWkZqeFE3dURha2cvaWMxUklBVkVRQ1FkTGpkOU9GU2pG?=
 =?utf-8?B?R3ovc01ZUnJRTldXR0dRU0xWQTVzZ1FYd1BFc0FFODZodlhmY3Rxbng4bm1M?=
 =?utf-8?B?QmtTN29wRTFCUXN6WHJDZU9oNjRsQmdITzBVZFVFdllQSFJ5UHVpN010T2Zk?=
 =?utf-8?B?cVJMVmdCcUUrOFgzSjNQbjgycm43REhJUU5raDUyTzl0TmNRQ0pKUXhRbXli?=
 =?utf-8?B?a0xNR25zQWdaREgvWkthZ2xMck1IanUwWXd3b1VmWUdjN3VmUVV2RUx3dlJO?=
 =?utf-8?B?YjVwSGptVEdLYXdzN0ZwODNFSzZrZU1oTGR1YlhtN1ZsYnhyZ29VMWczRGZI?=
 =?utf-8?B?eG00WUtZQmMyU3ExYlNnTnQrWElPSFR5U0R2MXFOd3dLMzJNMkw2ekdCZ2lC?=
 =?utf-8?B?Tm9nMEtpa3R3RW11SWJBdGRKRmZnODF6bU5SQzFmSjZFcmVRTkRvQ1BEV2Rq?=
 =?utf-8?B?T2JpVStiSnZlSHVrSVVEWGxRZWllYTNTTnBSeC83U1FqbXhmUGx4RWFWUFlr?=
 =?utf-8?B?b1pucmlPampML2pKRkEyWFFEbllUQjZjUmJ0L3JWdXp4UDZCTW12TWt4NWVp?=
 =?utf-8?B?YnlMNDdFVkcxaEpUai9nWHd4ZTdFc1B5NGFnNDg4TCtycG52SUxYYnpubWV6?=
 =?utf-8?B?Uys5OHJkL3piamtRdnNYb1BMUTVZZTVLWUJrUmlJWk9NbG5jWUZQUT09?=
X-Exchange-RoutingPolicyChecked:
	px5HAstzTalUlD+QYeWqrrMNDK97TGolWpkBJyOxcfBJibgQTbRkuZXxS8RZC+d83ZobGbCQXAEEX1r2kgMsC7ZET6CkNyZ9a5pEfe8tRsC3tPYtTREaFXKAwBioqiakhNm6j8I4AbeN5Y6kt0DW+f+lxuR9JOOBSIWbElb9mXQGpo3rSZMNEcgb6i6U3j+7rmL+woinnC0atbz4tM3XT92AKNZR/8B/AmkEakh2BzvxX/AsYviDAjYW+IZ3NwDCWOxQJNpPc+yl+Bbr+5/76GKJsVSSU12DfJYTr1nf6rBV/AMoMpXqTGxQuuSSmK2c4dcW9U6q/irfWzFKsxtgIQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29877fd4-dc8f-4213-09a3-08defd441ad8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:16:48.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg2w1BYSeapyrQxikZqE4U/drOpssBqUfD9jlXsVeBrP/E2UKS+joc1gE34qFgtVDfsFSY+dxmJX/RXOUWKixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7268
X-Proofpoint-ORIG-GUID: WaRhgTcFpzGkcwN5mojCbZv0M8NqD1FV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfXzuRYKDLpCIVW
 Fe/vpq20+ng3nBnrE1h0G5k6SsWIb2oBgTPkz2V6j4bvo1m5Tgnw2dQQJn2PIIae+GATSQpO+Q2
 wJlUGvSlKARWjLmGhkIeImizLiybuoTIix5yNKNzB1nJCa19FlkvcYgMjiJq5bRzAsXwl/ftV71
 e1K91Od6Jl8Q0MjYdorCb+lwcbRViKVGQZO1DUfoOMypRDB+tfcV7OYe9qW7F7v6HHwIyOp6t9G
 P+WmKG4k3L6e4LM7P4wdNDh9uf90ZgB+nS07/tOgzedrbCria00LTqdZOlBk2QSPfDEPCdTB3tC
 iGA0ZvgmknE82mXWlPef/u3fKqS4+91SoXHYc13YEXELUpHwPW8U3KR6kl6YPeVDKRZzmga3lHz
 dI4HnoGiYS0OGr4xe4zfAtB6IuOCL5u/wyCCclpwe3HmXOM2yx/T+IhArb56pHClLD1WItuREa+
 zJ/h7ZVnpkP9HC8Kspw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfX2atOKhYk8sy3
 lg0qua4vzHQ9lyBMUW3Qyxseizw9N9i3fTICr/ftmfCOjsZ23XtQBmZB+B+5WNPiAdUmfGFXiy/
 BkM/38Wm0I0ddpJw4fli6QuzIdrxY+Ru0bwAUWEhZOGRTfCRVJ43
X-Proofpoint-GUID: WaRhgTcFpzGkcwN5mojCbZv0M8NqD1FV
X-Authority-Analysis: v=2.4 cv=a8QAM0SF c=1 sm=1 tr=0 ts=6a848573 cx=c_pps
 a=UMwgOSM+WKnhBjpqxZ5HKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=fG2clyhIRr9KWKxFdqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180119

On Mon, 17 Aug 2026 20:33:41 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index e9060c1bbe6f..deff36165ed1 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -1830,6 +1892,15 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->chip = spi_get_device_match_data(spi);
>  	st->spi = spi;
> +	/*
> +	 * This family is composed of single-lane devices, so we assume that
> +	 * each lane is bound to a different device.
> +	 */
> +	st->num_devices = spi->num_rx_lanes;

I still don't agree with the above! At the very least we should infer
st->num_devices from the number of chipselects. Anyways, won't extend
much the review for now given that David seems to have some ideas
different from the ancillary devices.

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
