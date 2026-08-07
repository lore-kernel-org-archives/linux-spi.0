Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39088435AB2;
	Fri,  7 Aug 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114188; cv=fail; b=b+APzNoBvTMK9YHdCOKk+xApk2BLyT+XD/MxrGCjKNTn6XavJfv9rxdEeLYjK7qtstEbzUtVxgZ+/lT01o0GqFvfjGY1D+Qf73fuYiIFooxFYD/1l95SE5ioNyXizBpKRIpxa/AhhHU4k1MLDezGAk/fjitn4T2/atUJotLz+ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114188; c=relaxed/simple;
	bh=QMc5CbxrTaMOacfqAiD+yTgkpS9w6BkSipbYBcercvw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=r6kuhzzPH86Y+q/XE5z7t0pTgE0Q7XWHW4G27bAcdXvmZQAM9GIY+cWZzh1/pieQ6LwhEt16H1ErCvssxk5nlvUR/xKb19RMm3twH8u2d916hs2MGFCpyaKdXJpWI2wb8ABzeQOVjNyOjwtWqaVXFj58c0Zf2KBgxT2dasgUgfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JAaXA8Hf; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JAaXA8Hf"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CfpZU3645862;
	Fri, 7 Aug 2026 10:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y0N+d
	W0V1NaIPAk/cw/BX54bBPYW2sKqwNbL5Rgw5xA=; b=JAaXA8HfSmurnVsDVAWJ1
	yc0YqvnvQes6/KbTbcU2h+0HQ9lsMpN9akSVQta3I+MK2mxs4pnWJioeBlyGMCTW
	vQk7E1GSMfXERlqOjwdyEyyG6gKHljHovfiAtCkRU1n9YJahEJVXAEtWDD430URC
	afARQayofPFg5rC3+GWVTOsEjMhB/mxiPLz1dpugCNdsnRobrRbmLGmxohuRQkAb
	Z66Zw1X7xtdxn7ednXBZQP5Ymfpv4nyMDJ7b3niYWRTBzk2MXbKVWlK/c0CNzIzJ
	LG0BX6FKiWjWpEAkQ6e30Q1GFoZCI2ERlBNvCiYUlpPgVC8BXq2ewvEbhFxa5i5A
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fvnvxygc9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liqE8ERZcWuMNN2tXcwrcU04+OT9JntSISRSil3BqQuvwUofLe7hXNnt06sWnolIGyG2KIBh84Kx44b5mN0Q+roh9eU/HIrYVHuwnm0gavT7rPtLZ5tOpyAKMBgFZSMXZz7rwT+xUZPOPNnsKakysK0a/X+OhwT+WN5EoGZGSPBnnmeVPso9j68ijgTZr117BBx9CUE3T+pfddW6Zh3E9m1DwvSW528/BKYKHPkEAn+/lgNGHk8ZPfvz56bpU668WcxsgBVbU6p38ND9FX8QwtUMe1LaHwg5EN6PyS61nTwlqlQPeMDEyixbSoOH8SYcqOLGHJNWKf/vVg/LdZh9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0N+dW0V1NaIPAk/cw/BX54bBPYW2sKqwNbL5Rgw5xA=;
 b=Y1fPm13aegtXF7KRZFLuGcY/vzZCVsgiYB1OvWSqg6URWP9xdJSlZOPlonAYyurlkLXv6CyhqfdcZ11knb66jNZ6effKoxDnYLjxXaxeFSQ4eJFueR3mT/6aD+hFiiznfOI6dv82jIsWL9qm/oGxKUr3x6xbjg5K0EjXNq5pqr7rh3KfAypoflEr1ANH5nVSY1vE/VBnCBc+alUlcmxPPEAXrJH416g4GBzrKM8bdyQ1ktbD5t3xv94LjnGhDagBSxG5LJR80EDP2DNKl/P1zmGHo7pnYE3Q1IOO3Kzo1maEXEiETvIiBKkfdnc+MONDxEUz9wZ/lu5SQZc99UGgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB7251.namprd03.prod.outlook.com (2603:10b6:8:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 14:49:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:49:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 5/5] iio: adc: ad7768-1: add support for multiple
 chip aggregation
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com,
        michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
        marcelo.schmitt1@gmail.com
In-Reply-To: <6a951fd7064d5c4a64c74e3afbe991a1a2ec82dc.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
 <6a951fd7064d5c4a64c74e3afbe991a1a2ec82dc.1785725359.git.Jonathan.Santos@analog.com>
Date: Fri, 07 Aug 2026 15:50:22 +0100
Message-Id: <178611422293.552144.16034252988170080090.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786114234; l=2348;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QMc5CbxrTaMOacfqAiD+yTgkpS9w6BkSipbYBcercvw=;
 b=ongHDL+fWZIwtTPEgAaaMq335W0wNU2fVQwTxSR5t5qteBd8kL0n+wuMO0dhQWS+9dO2lz/cm
 FMGPg0FBQT/AGj3XrDlP/9zXapQ7/3zfyTCZhcAsVZFvw+Yo+pbcMRi
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1ef072-b20d-4e83-59f0-08def4931c20
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 brqIJ2GT7xjMTzbgJu7Jn2qeLiXA2urQoVlfKiLJ4rCw0E4Wp84stLeykZmaybCSoMSN9CfHdg+rSSVKsyyzwY9m5Z8W5ohK6xdErS42CKnlMHXttNModpxn5NFsOr9J1kwvPgzLbcXiScRiiDX3XyIE4ti2XUBKQO/lCmkBRz0OpxFgBLBhRrlBkGaI+aBT7h3sSuYyMdbHXghxxeNJn20WUdIxxyjxlhrTXmdr2u6DN7QKeRxm0Y8X+3mys8j5lc6srO4P4kWazO2uJf33LzWB2Jm2HOh9S27W5tQ0f4KqhS+3MXS4ZUwxC+8+llOgJepAQtnzsPDG8gOtvjI1Rw7nP8ZRq1VF57T0epkSRmjuvhy7Y2Dk0YF+r5RABfsbGqR4Nf21MeAZpRcKp1WLqjpkpUsl+2COcOBNDRPZ9BGx6B893jNSiiFUdOTsyE/UXx2HWypqeo7YDoUmDQvNcrQEiFggDT1l02lgW+JTry51SWhxEWzCAUX4uL4hOj9z97JokFu73wUiJjQrICl5NVnSQmnrYWb6LPBSg4U/aj+2NO+Pyt0WXcQ3THUMmoUGmDCmAHqSLmWS4rFNbZqWetKklSTLlupaRHwGyEcavTxJ4z99Fb+lGMvg/S0GprOa7CiIqjltwgSXH12wW+XoXiY1uIPrKqwMdObSL5Njkvs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?STcxcWczM1VENEgxVG4wamFBQmk2eVdVYS83ajY3RVBrc2U2SG9hV2NWQXlx?=
 =?utf-8?B?TktkR2xpb0ZZY2x1dXZZMVladENSMHptSGpYTnp1L2xqRlZZQWhOaVQ1MnV4?=
 =?utf-8?B?ZHlUTmNsd1JvT3I1UDMxTFpPWk5WaDhhQkxGY01vQ1BaUXMzUDNtMlJnQTBu?=
 =?utf-8?B?ZEVFZXFnYlRkUTRwbWoydzNIcnRiZDdSOUM2WTdxOEs2d24zS2svbjZLV0VU?=
 =?utf-8?B?a1NGcmFJS0JKek9ZUGUwZlFmU2g0K3pQSjhRdGpjZm9JNGIzNzdBaU5ES05z?=
 =?utf-8?B?RmdoOGUwdkZjTGdLOEpkd1dqYjNobEh1RUZTcXA0NS92TkFzVnpGTG12b2JN?=
 =?utf-8?B?bUpVYm9qUUFNZXFFcmdTSnBpTVdXejhpeDZucnp6dDJyUCsza1BCdG1IL3JT?=
 =?utf-8?B?RnhCejdrYzlNczQ3YWxSbGovWXZjbmh5Z0Exd1NrZkZXaWRvSUFiZWhRMFZU?=
 =?utf-8?B?aWpJVzJjTXRjZTVBOFFBY055aFh6dW1EbnBTUTJYNTBpSGZFT3ZHbG1oN2Ex?=
 =?utf-8?B?VWNVNWRQSDE2OGhjaE94MTdvSDE1T2tsQlUyU1NOaEFxanVHV3RlMm1UZWVG?=
 =?utf-8?B?Znl2RXIzdEsyQlZRRHAwMGQwT2g3VjhiWEE4dmx0ZWRxT3lCL1VieE12N2pY?=
 =?utf-8?B?V0lqZEg1djN2Kzk3UzJsYUpRdGhqMmk3VHJQdzBWUDh6U1R5L3Eza0pkMG5y?=
 =?utf-8?B?MFpVNS9GVDNnTzZEeVA5eW9CbHJCY2hrWlZhMEZ2TFR3cTNqbGVnenRhZVY2?=
 =?utf-8?B?WjNqdGV2bkZ4bEJzVStSVldiY3pQWTNPV3AxMWpOZStuMWE3UUM0dHA0cERM?=
 =?utf-8?B?V0lvQ08vUm80d3pOc3ZWc3dNS0RYUVljNWtWd05BSnlVcDFkMXFJeUZnNFBL?=
 =?utf-8?B?am5iczJIZFJRL2RwOVFFbzR2VVdCTHkvUUNQbDVySDVHVUxyZjYreEM2cGlN?=
 =?utf-8?B?SmZVRkVyUmNvYSt3c1ZOMVR2ck5wTHE5VEpnQ0hUaHJ5YmZCTXRsMGJCQ0hQ?=
 =?utf-8?B?TWxFVDN6enc2RVltMVFaYUMxajBsS3p1WERVek5NVXlaWDRWTEk2dVMwNVkv?=
 =?utf-8?B?NFhXdmx1bThHVU1nY2pWbkFuSW12bTRtaWRXanNRNU53cWVVMWE4b0RJclFh?=
 =?utf-8?B?ZWN3NFNyY1kvREE3VFY0MWFjejhXb0x0bzRuUW1uVTVVYmRaWWhVakp4WFk2?=
 =?utf-8?B?czE3emtEWDl4V0UzSmg5TjRxdE5iS1FDclllWjArQ1pZalFUT3Q0YTB3U3lU?=
 =?utf-8?B?STQrUXBINXZHaldqSVFTN2o3TkdYZk1yWVlIWXdDUXErZCtreWdub0NvWE9l?=
 =?utf-8?B?czVOQ3BNMEVYOVQxS3F5MzBIM1lPMkh3VGxHNFRNWHUyd0hHVjlGTWYzeE1U?=
 =?utf-8?B?bTA5WjVRd0Z0Y3Q1Y1o4YUE0ODlkamxvaFhJbWJoTU5RZDBNNjZCd1JDQVR5?=
 =?utf-8?B?QUpCRFRpaUs1dzFxeEJLTUtFTGFXR2hMb2I3MFRLQ1ljblRyUmpXRTRtMlh0?=
 =?utf-8?B?dWVyaG1PZ1pnejVGUEZaMWdwWThTd09jczhsa2NvUDBpMXpLQ01qZ3Q1UFNK?=
 =?utf-8?B?eVAzd0IwNnlUMG5Md0FScDVNODVleXA3Ni9PemFUM3BkdDhndFViZUlBTXds?=
 =?utf-8?B?ci9IVjEyWjNOVmdpTmgvbDNndHJXSlVZdHV1TEpCZksydloveW9Lem83OURY?=
 =?utf-8?B?LzZhai9lWC9rOUVielhzVXFiTGxveVc5WEtKcGUyOEJXbUdxTnFlRjJPSlUr?=
 =?utf-8?B?NEZVNi9NWkRwaGxDWXUxSGU1UmxoOEFjUFJLQ1N4RERJTldkQlFvdU82bi9G?=
 =?utf-8?B?YytRZUt6YkIyam92ckhxRlA3WFBqTmN6dmFCOEE5eDYybUZlc21qaWJweXpW?=
 =?utf-8?B?SmhXWWMydUdUZzkwNUxwSWVtamltZmtleWRSYWF3U0NmRXo4NFhJdTdGVnVB?=
 =?utf-8?B?U2xybUNuNGdMTHVoUEJBT3Q0S2VkTEFnbmxIQzRmaGJMVGJqY0xaSVRoOHpv?=
 =?utf-8?B?NGlCOFhNNktYMm5PUCtOdWZCR21iTklLeHBWUDFUS0xEZ1A1cWhSZk5rNHJ4?=
 =?utf-8?B?dWZJSFBUYm5jZXdQUzFSMzQwOCs5cjc4WnpzMktkVDJ0cktFNmZYNTNXckJF?=
 =?utf-8?B?S2g1U3QwcDdGWEU0TG9GQTZreU5BRFByV21haHRZOHlVVE9ubjlzRFo5SFJv?=
 =?utf-8?B?Ti9uMjA4N1hsQVZJbFZPajNsL1pKVFpOczlhQ3B4Wkl0TmVMb2lPSWxtMENs?=
 =?utf-8?B?RElaWmZ5aHRNQXZwcG5wUUFWVFM0MFhUeWNMQUZoaTdicGNpMG1lNnlTZXJ6?=
 =?utf-8?B?eE05WWlxNk5SZDB5U2VncnYvb3ozM0k1S2R4ZGRoWEp5dGNtYkdrdz09?=
X-Exchange-RoutingPolicyChecked:
	bZQOtYKYk4ZvaN01Wj2KT2SkqEz9VJ25CzRs8hLKkxhiD8uZ/723yGDlhwHDgbTuP99m7Dcblon7JR1sMTOWPYC64e/fS4Wuq7sPVEOacAnLkPD2PTJvb4vlNv2nhrtAR0B/lNcTDX05YJIKyywIHXxMqcwulXRDc+g5X/zi1Mqq8WcMHAJpA5aiq5CnmjSyW70o7y9RHxAcd3YRFjlFxiPY4zEwbNshmSLCi5v+WCmAdCeTrlwLwRHVXD4bt6JjJ5BPhIi7caUikmW2ilWryZmFB6S3myKpfuuUI02BM15jlioRlPhC1CvuTM5lzRHU2BsatUtdP69HslUKjE6Now==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ef072-b20d-4e83-59f0-08def4931c20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:49:40.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+LxDZtwQevqlGz8uQiCZHEMGBF7huAY8c+JLWXEoTt23AYwYxBFV8lTcQb0UDbGApA9LV7NR6t5pRdKWWBItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7251
X-Proofpoint-ORIG-GUID: XiP2m0NSWCNibqGwmJjTNLc_iOcn-mvo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfXzOFnyfmvFR9W
 iQ+zhc1jqwvD6TEh9VAZmoDqN/prH7XfLjDqkzG2jHzvkVQkCc/cU8ReCi4TkV/hjEQ+jhzMRuY
 VCg/JGdQykWTqieFxFRAl3OGvvISN7/myvcJ31IhVd1TIh5KFUgA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX2crlYmldw7fC
 g9tgtBu0Q7NHnpYnpSJ+UbldOhhEq+LUbxkP+nbDxsuoDdjBRd0uLFZWsuAZKxt0DFH/hpSNaze
 uoEjunDM88bCKaXZsnn77+Snln6HFkBX/5kGBdZl1XMw2N4p3NGSKTAnl/1+TNN61HfT/r9EAKQ
 F//gKRt93kf9wfzx63tCGTW1TAPtPUipTYEcsAbN7XO6/O6L9rQDIF5afugKwa+jCEWY/TW7BB0
 AbLeaPXreKSwS3KBrhPleFcLTNiqQCBApnKb5ny8bcwtxCcAJzQnT/x1AG5F+utPW+JUuO2jH2+
 0SWGRvGFP4dwXXdpfXRTfefepgGu64kUSLgt9cmHIv/fSUTb34w9iikVbMvV2kVpj7iwxqBdpWh
 YbymbiwUQejavt9MOBDH/BD6aZQJQ4fq/uKHS1P2lOuBIKP86cUyZ+l98jvUkRApjszeJNC1YC4
 lNP0Jis85QLRlphcmHA==
X-Authority-Analysis: v=2.4 cv=F89nsKhN c=1 sm=1 tr=0 ts=6a75f088 cx=c_pps
 a=dfvQMip10+6xT43tUf6YKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=DSSWTDMvCdTPENKBalgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XiP2m0NSWCNibqGwmJjTNLc_iOcn-mvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070116

On Mon, 03 Aug 2026 00:02:43 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index e9060c1bbe6f..0a34d408c188 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -1694,6 +1706,55 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
> [ ... skip 25 lines ... ]
> +	indio_dev->channels = channels;
> +
> +	masks = devm_kcalloc(dev, st->chip->num_channels + 1, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		return -ENOMEM;
> +

You're assuming that num_channels is 1 which it is for all the chips
supported. But semantically I think it is wrong! becasue we pretty much
just want two unsigned longs being the last one the terminator. Hence I think a
plain 2 with a comment would be more correct.

> @@ -1830,6 +1891,15 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->chip = spi_get_device_match_data(spi);
>  	st->spi = spi;
> +	/*
> +	 * This family is composed of 1-lane devices, so we assume that each
> +	 * lane is bound to a different device.
> +	 */
> +	st->num_devices = spi->num_rx_lanes;
> +	if (st->num_devices > AD7768_MAX_AGGR_DEVICES)
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "Too many devices (%u), max %d supported\n",
> +				     st->num_devices, AD7768_MAX_AGGR_DEVICES);

I'm not sure I'm convinced we should tie num_rx_lanes with num_devices.
Maybe it's fine and it's unlikely to change for this driver (same for
the direct mapping between lane id, cs and device number). For example,
the below:


reg = <1>, <2>, <3>, <4>;
spi-rx-bus-width = <1>, <1>, <1>, <1>;
spi-rx-lane-map = <0>, <2>, <1>, <3>;

would be break with the current code If I'm not missing something.
And maybe simply introducing subnodes as:

adc@2 {
	reg = <2>;
	// Or have spi-rx-lane-map directly in here and have the new SPI
	// ANCI API parse the property.
	adi,spi-lane-idx = <1>;
};

would be fairly simple to handle and completely flexible (I think).

Anyways, one thing I'm fairly sure. You need to update the dt-bindings for
this :). For example,

spi-rx-bus-width defauls to [1] which is simply wrong for this setup. We
also need multiple regs and the lane-map.

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
