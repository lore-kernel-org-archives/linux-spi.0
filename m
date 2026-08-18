Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F53E0C69;
	Tue, 18 Aug 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066041; cv=fail; b=dAMWOxAlA5wJAi9cFFIHU2A/h6vrrSAtDLiAJwUUFav9RUOz0VYCK+3IlzYRVNriEL1yEDD27N0BVVRYm+aYJ5x8HLdTZjTKNKk3Zg6emulLvArknOvNPWKCW/wvcXfPsMZOvaGjORLwiG4aw4fOUWPQqWcZgBaYGhj6e+HHPro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066041; c=relaxed/simple;
	bh=RYgdr2n7pH7BXQfk4q/2GaLUYoPwEzlFl/3ilZptyVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FwHGBLiri/xE11JehAsKDQ17/CoRjf9gIJiVK5nuJ7/ETePRgxmItZx/73Ro1QjDNvJatgznXKUOqYuojQNW2EbWqCj1wDOf/Xml6JR4vgjdj2/5qeDlzgqjJM12EuS9LGxIC6mxWD9ae6c+02eAlj+ufH75PKDv0pIv7eo9ttQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fra+p1e/; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fra+p1e/"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDt09Y022121;
	Tue, 18 Aug 2026 11:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IYDJL
	4QK3+fYNgi9m0jZbluE3MboNrahw7C+Buxh9JA=; b=fra+p1e/h7j8HF6ZfngBK
	jvXQDNNqYO21oD3OSnlJUd9TepZEbiUpGkVuzryIETxKeO5P7Sqrd3xgD/5K3qFl
	I789LlMCui+5WbNNEw7WKHgydLzryac4rYwxC7QTGa4CzM+GZwl/wOlJ1orvzys6
	mqyMaNG5WU0IJJa26hNzF1/5bTJFGt4Xa92RjF1PsHd6tA5BCyuI9wqrVSQVsHis
	jsKq5rWOMmN1oJXXnktt1KPI+INlMvImkwm+BlRUJTXKNe6LEmtJZdqy75F+Mxdj
	efEpRq2aSeCZeDq3o43mxfFv+qrxtdBFE2mpsNrJeMXrBfjG5gwz9aE9mqEugmex
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4eg3ty5u-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:13:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl46FgIFkPctsQDs84wx/iPI/nMRFHEbx2eMbF4F/bXZt35gc7TnUz0Q/RZgfl4RDV42SFYEmiSt2oAYiD0S89QB8srusiMQ2963t9X9TxaJyShjwRaf0bowFOE49dV7tz01Kpfn2D0G+sxgeA70NU6e0zj5cmZX+GeXgWX6v/oHY2xq0+oRYojo+kBsPajjaDFGvBHrVoo2rddlLMCGMl52OTmc4UdZ+RloPzrKL5e63wX5OVug9niaw5PZrHuMdRGkDpws5ZZqGBFiH1rReLQPSb3EQCwh7NRtSE9ktQiICnB2Qgf9QPTztCsGTaD+qgZuXaYmdi/EzgyrSseKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYDJL4QK3+fYNgi9m0jZbluE3MboNrahw7C+Buxh9JA=;
 b=K0lFu0iu7HMKSUjRS5QVdUsNvfmpYdMyyHn//EJ4SkUT4WUh11qxeY4k4lK8eA/S5+Rxep8A05QFYXT7hRj+X2hoXCkcWUhsGVPEj6FMyht0OoUGUM+hA8IkquP5GhjeKYtNF/1Ma5ZSnry/pl58tJJsZsC+rna5LQkHNLUhUjmlJ4oAyCpVd5RIVvzGAi7Rm401D4Zrm0goFtzdcwgjTsfNg6aBSusPjvqMzHgtSkhhXY9PurYGeCK/gRnhmw2zkKsQEF783l6gJfSY35JUv6CTPyRVDdYp5ra1t+Et3MjzbGGZKIc/NWBuRY5oAFCpsz4kCQjaGnqjRqNL1aVvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH3PR03MB7482.namprd03.prod.outlook.com (2603:10b6:610:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 15:13:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 15:13:39 +0000
Date: Tue, 18 Aug 2026 16:14:40 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
Message-ID: <aoR1Uo2W5BtiYRSY@nsa>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
 <9841fd2e-434f-48f3-90c1-d62718d6d4d2@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9841fd2e-434f-48f3-90c1-d62718d6d4d2@baylibre.com>
X-ClientProxiedBy: MR1P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH3PR03MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eec9aa-4427-4564-1197-08defd3b48ab
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 /y65VB30q8x5oZPZU3wEGfDnuFjIB/7Ybbi5idvaTG5ocHlWT2s5IrWCFLQRlPkRiiQNvp74b7JeDYfF+pPcQSRxhWI7ig+HFgIvNnnwEEpVDzrDZv59EkkeiajeYwmFSmAkb5DAznKhRxRkU4C4VrF79Scq5/x7DRAWJ1PpZ+fN+2QYQ6+NFXg9GhTahld3UgtYRqvNl0ma6FjHmqJzrq5XqsURad6ukqxOhBY91ivofFe3hzP/WjegtqVgaN8NIK4Aqechkug/66wO3wLWlNwpVzt3TXhvN7e0plo02vwJ5Vi10m87xBvvPh1ALTx8otkuMWEc5OkRDl2QQmkBTFYBQpt4cbSY9mUqG6e3iVrNiL6jHhIGl+oKjfItCQ2QPVHXe2l+WKbUbe/h9AwuZpy6EF74a3yC2Xz6qcHeiYjEPfE1moQK1XdXdLeaSgKYxQvfrzvjUNG/0PRYRrJk9JcIAlUvzA2/+QZBMCiZEVfO3dVQSFQpJsTcZNb8ZYRKKRtgnp3wtGj957lhKtRh0dkbZHBCUkuerQqgRB+v557a3oXTtpiWgdzxD8u0UpdoP0k7J7af3s5pSwMIk2S+3Zm4a7s2GCaKE5zGvc3J6Zab9ERv3xUDM0xIiR9Rf6kg
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RmMxMEtqMEhkZXZPeE8vdDN2VFcxcE00RVNTd01iUHJ3cnkrV2IrODhCdGpJ?=
 =?utf-8?B?UitWOXJSMURNT0RaR0NiSUE3WVo0UUxCY3I2UFdOQlBIM1o1RXVMbENUc2RM?=
 =?utf-8?B?L25RSEc1VmI5WGc5VkxBWXJ6Umtsa3F3ZUhXYXRwYTNZa0JTVDJ4NXY1Rzgz?=
 =?utf-8?B?OWdXTWJBaldsdG0xL3U0K090WEdPMVptSUd6a3U3bDhJNnJ2NkZzM2Z3MWFS?=
 =?utf-8?B?UkxnWmlUd0tvWVlaNFJKS0FKU0did1dGVldVblRta09leEhZZGU0d0FmWEJS?=
 =?utf-8?B?WSs2WENWY1ZLVmY3dmtNUXJZdGsvcWJvK2hERWlHUURUVFNlYXFtVDVPV3FW?=
 =?utf-8?B?NjFZd0FDSEh0WWszaTNOb2R0anJHdGlzWnRLOXlSRzM1SkVOK0FQK0RHc2VX?=
 =?utf-8?B?OVVERGlxY1djZDFSMXpUYVpnaXRvTy9JMnZpY1dHU2hLMUtDZzhTY0xsMzhm?=
 =?utf-8?B?YUJRUEdrWEt3b3A4dlBUZTluRXVpcFVOLzdvYkhQNGxiZGhNWWNwOTR5WEt0?=
 =?utf-8?B?dVVXNUVTMTYrTzJwZm5ucUVtUVFYeDJCUlJsSG5MK1JhVFBCMXR3c25vWlZl?=
 =?utf-8?B?WWZpWEdGVnRJVlJKOStjR1diTUQrcXIxTG9qOVhqUERXd3AyWG9vbVBUNzJt?=
 =?utf-8?B?dkxvN3UvWHJVbkhnZFZrelVQTnRqRTJSdmJoYk1NN1haYXk0UnBPaGlHVi9J?=
 =?utf-8?B?bVAxZElDSDZxUEdRWWYwTkFwY25heE52dnRCVVR6cDJqWjJDUUlHRjVYWERC?=
 =?utf-8?B?bytqNjFQSFEvRStIQy9OR3Uxd21WWUJSSU9vOXVocTlrZE90bFVnWlFQYlVy?=
 =?utf-8?B?UWpmZnhtTjRRR2lMTC91b25iSFlDM3hFVWZQWDNNUS81VmE0VHJnYmZEMDht?=
 =?utf-8?B?QUcxc3Nwa0dicm9qbXVrSlVwWFRGbVZMT1o2dDA4d0dQR2lqUGp5SU1jREow?=
 =?utf-8?B?c3ZHWVdaSlM2bjNLQzFsbU0raXErQnhCWjN0bUtHaXpBTjlwRDdUMjF0V05z?=
 =?utf-8?B?V1pxcFdERW1OK3g2Wm96U2J6UmdqeHZhaWZUS2UrcElyd3FkQ2hYdUdiV1A3?=
 =?utf-8?B?ZkQxRTNxZTcrbzRsSTdYRERkYzJRSCt1eXEwY0NaaDc2NXBZcGc2OFdreDZZ?=
 =?utf-8?B?QTNMVVZsZlNoLy9la1pwR3FLS2ZPZHpSZGxxaG9YdnczUHRrL0F2TDJkR3pW?=
 =?utf-8?B?bkpSQ2pWb0NhNTJDTTRQQzRBWGtGNlNQVmwxZEw3S3dFTUtraHlRVStMRVRX?=
 =?utf-8?B?TGdReGx0L0NvWVozbWJmNTJ1N1BQb29nWUppSC8rSE0zYmpTQ210c3JOa0ZX?=
 =?utf-8?B?VWZkZ1djemoyNkdiR2U1V2xSV0J6akptUmw0ZWJLalZJdG5oN2FkeTVuOEJu?=
 =?utf-8?B?endVamhQbDB4RkhueStXRW0weFpzTlo2L1dhc2JjcGp0TWFxRGZOZDJ6K3RT?=
 =?utf-8?B?Q2ljZzF4RnZ4U241UGxrZ3A4OFpvRm9sWTVkN00xVStGaERGU1ZjaTFRZVZU?=
 =?utf-8?B?a0tHamUvWWQxZWVRVjhWdy9RWC92eGNaT0JxUE9RaTNNUHdKSEdLSnM0MDd6?=
 =?utf-8?B?UklNUUZib0dETHBmdWR2cWU3TW5IY1NPUGF2N09GZ3Y3VTRicUJLMzkwYytZ?=
 =?utf-8?B?K3B3YmN1SDhKa1htMjBxb3RKb3M0TkZ3UkVxdlEzNjBJenhjVnFXY2tMb0VM?=
 =?utf-8?B?QXZObTdJK0Uvclg1WFR3bE15VTMwaldrK2xxaDkyM1NFeDVvdWVvK052S3V0?=
 =?utf-8?B?bG9yc09FYVlscjIvRXdEMlFGV3Urd3A3QzVxMWRvR2dWMVRWeHZyS3hzYmd4?=
 =?utf-8?B?TDJjRlZrQzlEZWRLNU1pWVNCdWFhUHo5Z1RmZVV2WGxpUFBpZU9ucUpGd1VT?=
 =?utf-8?B?MGQwSURjUFZ2SlVNMHQxeENHcTlsT2diVjRJNzBPbUZoWE1oVGhSVTYyaHN0?=
 =?utf-8?B?bnpFaGhlYkhta1FucjZrekdXSXJ2TWowRm9tcFVvRjdrZFhZUnc5ZzIzTndO?=
 =?utf-8?B?b1FkU3luNjYxcTZwcVNvMjFMWDNtdHlwZzJBeVQvVXlFNENQdjgzd0JnTmd0?=
 =?utf-8?B?ZkFwYzRoUkUrRzZyZ2E0cVV6YlUwQU5ZWWwzcHVERllLNnpxRDN2UStCTEhk?=
 =?utf-8?B?cFg1cVlxdlNyRkdqS3l0emY1WFAvbU9MZC8zSXJwSk01Qy90NTRCd2VCdm9Y?=
 =?utf-8?B?ZGlkOXAvMXQwOGQ0aTZ4ZTVoWnFwNS9BaE5tcmxlYlQrMlB0ZDdzeUJuSTll?=
 =?utf-8?B?T0p5RGZNL2pvazd2OXdaaCsvOWlKaFpEVWxlWENnRktyOEdaZ2lLeWdVdXZM?=
 =?utf-8?B?ZkJKNWdvRG9YbjVPZUJLRFFmQU40c3RxTmtCbW96L2ZUaktwczlpUT09?=
X-Exchange-RoutingPolicyChecked:
	GixP8lfsFw2C/F07lUZi+N1vT5h5uqg7OXASIWtZ/0WbIJwfmD7B4A7+YfX60yZGLGx3BkhLZO/L5zkWJcfP63YjWNvoutbt23YK2IaPJ0HQ1RCmtDejefugU65oAD7GMKryn+r9lqvk1jL8+EyMyNBh03ucCPmDf4731LrtOX/XB3wCUhynKSHU/rsb0GlDHV/UM5Qop9MPimkpwQi5pHYRVhktUVf5bih4Ei237HdkU4ZWB48PMCBj2aDnzsxHv1q3on8JdaAFNRpybtbZoBtcgx7bNW5ZVQEzyLjQffcLKqqcu2Ybd0oL+Z8/8GkNMoucoEb01VOqnrO5w2P+DQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eec9aa-4427-4564-1197-08defd3b48ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:13:39.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9+qlpsk149XCjmjtXnfQ/Xb+3kDgdThfjjrp/qW5ecrfy7q6Zz30fO2L3VMwBb2VgImrqB2JtCRkwY4QEX46w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7482
X-Authority-Analysis: v=2.4 cv=BYnoFLt2 c=1 sm=1 tr=0 ts=6a8476ad cx=c_pps
 a=/dw4gKU6pt/qT5+OabM4uA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=P-IC7800AAAA:8 a=oAOo_s33Nal9GNVNT9IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: rmHamCbctbbpwbd2IzHraFj5zdFh91OI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMSBTYWx0ZWRfX4NwNrZy2PYTe
 0LOoIrQclKjWwm73ipqrbCK2ZrncIAqf6sPM0zknqkBQtJw8Vkx2Y/w4j9e5oLu3d6tpGe+665W
 Ou8lyOCtQDbxDzqneIVEPibeazwsw31Chn2W2VqwVgbhCNyZ9maIdyZOhz3gc6U1C1fWVEWPv7j
 qtij372U0CiyBTu/wWlPvRppy9r5CABJ7yBL9L6tN9aj2pB7V3nsKoVPoDvS7C29B+Y3Nie3ZH4
 JTq6vRcdAMWrcVYvI+vpNGGLWV9QbdoXoTACY5MXtszbHuZWmlAM0bINXe2srkBhXiUzTJ7pcTW
 pV3nHrH3OgQTYuZZPHhy9IOD5pU9SPIB/zsI6fp9ksb8h6VYPkp0P2GJeEM88A/adXqI9bAsHoN
 L9LWw3x+ab1h0LI0PbfkLhurv9R+WjauUQzvBLm+jBU11EQaWRwlBnvrcFwE4u4UA+zUboygb7B
 tNyxZZM4Dmaxh27YxfA==
X-Proofpoint-ORIG-GUID: rmHamCbctbbpwbd2IzHraFj5zdFh91OI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMSBTYWx0ZWRfX6jiHP0aPhqIb
 TnNbluaGUFfJ4537J9b0+XKQI5soIaiynRlJ3tIluzCTkJz9WBO3BHUwmSlcuyLX9RuRA2XLnBm
 18sb03E1rkx2u6afM3Q009O8YTOv+WVJwAB04zSXTnnXXUYxaNLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180111

On Tue, Aug 18, 2026 at 10:02:50AM -0500, David Lechner wrote:
> On 8/17/26 6:32 PM, Jonathan Santos wrote:
> > The AD7768-1 family supports aggregating up to four devices on a single
> > SPI controller, with each device occupying a dedicated CS line and a
> > single data lane.
> > 
> > Extend the `reg` property to accept up to 4 entries (one per device).
> > 
> > Add `spi-rx-bus-width` property to declare the per-device lane count.
> > Since each lane is bound to one CS, the number of entries must match
> > `reg`. Make it required when `reg` has more than one entry.
> > 
> I don't see why we should have to require the spi-rx-bus-width property.
> It seems logical that if it is not present, then we would assume one
> lane per CS. This is already how bindings work.
> 
> For example, adi,ad4080 and ge,achc have multiple CS lines and don't
> require any bus width properties.

Hmm that's my default then! I was the one requesting it. Basically
because of:

https://elixir.bootlin.com/linux/v7.2/source/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml#L76

So I thought that $refing spi-peripheral-props.yaml and leaving the
default value would make dtbs_check to fail if one used 

spi-rx-bus-width = <1>, <1>, <1>, <1>;

in DT. 

Won't it fail?

And if we don't give the property I believe we'll have:

https://elixir.bootlin.com/linux/v7.2/source/drivers/spi/spi.c#L2509

And given these series assumption of spi->num_rx_lanes == number of
devices (which I don't agree btw), I thought we would need to make
spi-rx-bus-width  explicit in our bindings! I still think but I might be
wrong and I'm by no means an expert on dt bindings schemas work :)

- Nuno Sá

> 
