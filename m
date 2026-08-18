Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07EB35DA61;
	Tue, 18 Aug 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069603; cv=fail; b=f+kTwHPGp6+lWmilleC9AFPecCMF3yRG1ZTyN+SGzAoY/zN/FHCZAf3lkCLnpEJr3ut98rriGz0BQGfHjSWnqzuqeb0b8YhnY4Jzs5t6MhCCuBgriqwpQolfLXdBoyeZnNKHjglr8CQJPGq0N5banvCxAdXla8FY+vjPZ0+rens=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069603; c=relaxed/simple;
	bh=YyzDQCyYsAnIQ5iIkopvwKGl1pSTVJMXpitQkna5N4Y=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=dIUbqW4cR5ADcW1ISIsmZwVU9Kqgsh0r8e6Oo4mY2f/UcSM8K6Nu9TON/MmAUXsGGd7LZmPFjc9P+tCCHY+7QYCXUN5A7N2/BxVVpwMx5m4/bVx+NKKti/50UoEmzGZhDpIRTdTgSCYqq0w8eclEn0VxHHzqlHTYdnP3uKSSWjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QsFD3sNZ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QsFD3sNZ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuTGK3681489;
	Tue, 18 Aug 2026 12:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DIMlO
	a4JiSlWrf7z88Y+3A8Vs0ZRggrEUHXpJLEuask=; b=QsFD3sNZbI8P8Z1cGawlb
	3vx+nt7YI0pxuqDir+ZdTy2M2V95tum5JfHT6eX2DbeuZdoAoD2PTkp7sn/D4jz6
	drEqKpZHKsd0qsRGnobFvXJFwuAKCrjJTW6gxDXA1C12Z8aAqfGYcFOvWcapQS1u
	4Y3hYuEx7q6Oj3zJQBqZTspLhozCBCXlhfR7SR0RdS+niayo8LoEq3eLyo6GyUYj
	oRD3mYy4kTBpKOUZ9Cd4r13/UhL72kutbrpKUDe2tc5XJSrV3XPqU3To9hqkDKis
	N7ipDtlyjOQ6oMmiIuxVfkin9suHFXzYVTNc869YChJLAK21LPxJvzJFnuXGD59S
	w==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4mn5ah4v-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:13:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVB8YGVKk903wKjQbjgojEGxFNm3T3kGu00frYr+cOOvJFXHwB2dBc+u7vOXE3peFRCBKvOvBPqEV2RhOSf4SR3AvnhhMFW1Zevu+ZUcKYGp1BEfjcZUceVFQwb6SCbHOS2/06ezz24dxbtaTW7fQwstTnq2edPu1sS9fSeN5k3WiFiL09a10S2VbyAXfLMQ3lMYkaTPgwHQ6lsWjvv5VLHwwzgEKL+cuI47XJG2PLOY6+b3N2dP0DYXjmHimBJ2juSnZVd7BQSoRntbfbPewES8T9fC2JyC0DrsnxwlsTaUl/kkxa44BazgtGq/ATgvFbkVinFZGM8rDq1lEp7tWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIMlOa4JiSlWrf7z88Y+3A8Vs0ZRggrEUHXpJLEuask=;
 b=jVBAH28yTedyM3OMXIA/XxdiK5RZHEmwZLJe1KSBgbrrYriwU06xjj9O2K9Cak3R1QW467Y8nL+Pu1QbXP5/yQNCgSwGAwgL5MIejUpUfDfXPFerf/9zUjNu03EAbjrgd9jhS3xQoi/UAoT7mjlmwpKPM202g1Lmw8/OVq+Ks5yAl4Jn70U3DHAZuX7xUivMb+vwYQloiRh+k9Fy570sPJlrbv5ZINsGyAaxqFx7E89Uh7pmdzqF0atJVR/gDnR3gcYNRGvazdFRCk3ozPlCa53E+hRbNHi7Q8Oqh1PvHTynlv1M/j8WudkeqhYsjR30vWBdE793S5FU/sK1U6ahjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7268.namprd03.prod.outlook.com (2603:10b6:510:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:13:12 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:13:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/6] spi: expand device name to include all CS lines
 for multi-CS devices
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
        jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
In-Reply-To: <aoP_cbcqHEA5L7iK@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <5719698587a0a7658a3980168eef0731a5e7506a.1786973376.git.Jonathan.Santos@analog.com>
 <aoP_cbcqHEA5L7iK@ashevche-desk.local>
Date: Tue, 18 Aug 2026 17:14:20 +0100
Message-Id: <178706966052.3163.11425556311922813200.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787069660; l=1903;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YyzDQCyYsAnIQ5iIkopvwKGl1pSTVJMXpitQkna5N4Y=;
 b=NJtDtarpXNyGK5WeggKLKvvjqfBzFETiyGJ8VsX363Mb+gbXop6wmvDf/SL79FkUlufgH0mqF
 IckSjIBQBYMCLY19fw0cZHVLOY9gr/3BTmkSrUYnIpaI7U360bgVCzm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f3a4a4-4b68-4189-9a4a-08defd4398c5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 rTX9ykFjmOLbDIHRhLDuS+Lw6WbkzvExfrro9OpBduDG4wAk5T/OjE51sBmrObT8xhFjJzZKAK/HXlNA/KIeJa3cjVqrlpTrgbMCbdaEtyRhG8Dqt/qJIQXLOwXVQLdgaz2P2gewI9/4Pg113JpOpL+SVFU0QoAc2apWmfMsW/ed75+h96RgsAam7aMvPWCuMHeaQr7NwbtgvJz4CJD1iUitq0m1acblgjcOdsNfuAjrTuJGaGjMRpiGnBVNvUFjEBJbHAkXyUUqJuqZJijJ4I6ttwj5YAJ4EV7L/ARxH+5YvRpqkZGqfIcc4K+jX6e1hT2QZH/j+PuQxCniWxfrAD5gRUg8E9WdHczolUNus4ZXaqSQLtblFlOY20RDTZiI9jizc8S1Tpm2ws/UumalgzGsaQks+zZLERswNnCmF4C8kDozRAPgSODOa278yI75aVcqwG8EEjmwPsECysX8m94CMS5G0GfG7wYPEAPl/p0ym32Aya5yr+bErqlNv55HYDzLDXonwqpBBz8/tSUo4Sg26thl/KjpzVwYayS6pcBWL2LUeCardPUy9jMKv3zPbFKs9GERjM1YxRJWxT1pyZTqWEE4I8Umj/Acp90bb8mj0hyTQgKqcLR218Vyxjfc8AA6zUN1D3vCeM/S7RJtrO23sCDLQ7gCvBtIc7vaHwU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eTN2bSt2YkVwajVYK2taZjNiTk4rblFnTUZQMGZiV2J4azB1dU91QVZqbnZF?=
 =?utf-8?B?NzlIb05mUW1OalI4b1FkMmhpWGx4eDBQeHJhUFo1NmcwcjkxK29yb2VJTUZG?=
 =?utf-8?B?YmRIakp5cmQ4MjR6YTU0OGZqSEQwNjV0L3VNUFRWNit1NUJyc2tCbGRUOGx2?=
 =?utf-8?B?TDltZlUzNmlRa0J3NVg5UE82OUtnYUd0WG85MGxPTzFQS1NuRnBaN2N0RlVC?=
 =?utf-8?B?QUw2M3RRYmFJVEtMa3ExWWU3bXhtTVBXbit1amFXU2x5NWFKdHpPWXdGY2ky?=
 =?utf-8?B?YTNOc3VHTnlSdEppMkhPdXd5Nnhsd3JFMHJaaS9KQnp4R0lsYWRXbnlEZUQr?=
 =?utf-8?B?STE5LzRpVzdva1ZzMi9vY0F5RUZUZ1ZkUi8yaWJsS2tUQnd1TFFxeG9PdVFw?=
 =?utf-8?B?VFdrbFd3VmVjTC9qems2aW5mL3AySEN3QjhHdTFCOUxPTlVnQ0Z3c3dDSUNy?=
 =?utf-8?B?WGU5cW83anNxU0Z5dlRUamoxdmFFVExsNlhOWWFTU0lNcUd4MW9oeEZJbitt?=
 =?utf-8?B?MTcrSUpteEszRFVKVDVWKytRMS90SWh5MW5rL0huMWIzY0hIQ0NxWTU3WHRp?=
 =?utf-8?B?OHFKc1N3am5qaUNRazNhSWRhSHFoMVdyOEhqclYxUVhKcFh4QVZKdkxhNER2?=
 =?utf-8?B?Z2orQ3lDcXMzeGVQdk5VaXZwcTBLWi83cWoyWDBvTFNpa2FwNEpkdHp2bTJ0?=
 =?utf-8?B?OFU1a1RtdWRiZ09qMnRKQW1SaWh1NndMZFVoTVRUby9qSHNmbWY5Vm50L0FV?=
 =?utf-8?B?TlBEdXN2aGdPZlJRMjFhOFM1N3JUT0xIVEwwTTltNlNETXZzaHNPeUFVV1BR?=
 =?utf-8?B?eHloUkV4WUF6alVGa2ZTMXYyVDNjMm8zSUp5UkVkNFR6cFFGL3pBZGpYY1Jt?=
 =?utf-8?B?SEVXM0ZSYys3V2tndjFuTll5TmQveWpuQkdIamtDRnoxQnRZUkFtYkpNSUY2?=
 =?utf-8?B?T1YzTXphdjhvckg5ZnZWcmc0Q0w5ZXpUV1g3T2xmUjZYWHFCWTF3UzdCTWdH?=
 =?utf-8?B?QjZZUU9nVTFoWnpsSFdzTFJ6c0ZPZHQzd3JNVWIwczJ2TUdsMTRVSnNoNnc1?=
 =?utf-8?B?dEtyYU01M2YvT2lNS1AvODNCRXB2ZmZEN0RLTUtNSjA5MmVjaDF5eTE3VEUx?=
 =?utf-8?B?dlh2TFN2MzlQVTRGK2tMMi9hTC96Z3JCT1FuRmx0UkJSQlNzNEg2WUt5TlFr?=
 =?utf-8?B?bTUvd1FrK1VPOUpTRktCNVprclZCRnhiQjRRZGZ6c2lZMmRTNC9naVQ2SlRM?=
 =?utf-8?B?Q3lBN0NuMHVkNWVQNE1sWmNJRTNsRmhRMTl3dWtubTNEc01oeFZwWENpdFlE?=
 =?utf-8?B?U2RvZ3N2OEszWXpBaStCWFhYdGlkYlBBRkxCVVA4eENlZ2tyZTA2UUhZSWJ1?=
 =?utf-8?B?R3FoM0xxNUI5bERqV0hRVStqSkE2UDVHNzJHY0J4aWdoWHdQNnJxTGt5VVBF?=
 =?utf-8?B?Njc4M2YzVUJiaXNmb0NwaWRHdTFXUlVyTnkzcTJFYUtFZFIrTWU5UE1vUmZD?=
 =?utf-8?B?bjZaK09vaFRwUm92NlBtSEg5UDhxaHdhYWFueHpXYVg5M0FDM1ZhV2EyekE2?=
 =?utf-8?B?SWRRaTBkUWl0VlJhaU1Dbk9UbmR0N3M1eHIrbXdROGFubFlTd3dHM0oyWTNs?=
 =?utf-8?B?T2tFUDMrM3FMcGdIZTBkNEZ0WjIvdjhvNjBZdkkrUnB1bUM0WEpGRVFXME1v?=
 =?utf-8?B?OGY1MUM2U1QrSXhzeEhNaExGUERGOW5EZ1FvUG45dzJ2NmFkdUJoWTFBUTdZ?=
 =?utf-8?B?Y2FhTFQ5WGEyMEtEUTFMN3FIaHRSNlVuS3FFM0RVNjd4bCtvNHVkNGU1Qm5k?=
 =?utf-8?B?L1NBbE8ydUJPeVRvYk1BQWtRK3FZVEVubzFxTTJNZk9GV0pveXg5RUtvdmEr?=
 =?utf-8?B?UGFRMFVuYUhvYUo3dWl4eVBlOWdnSGZTVUhTUU9uT3A4czByVmVQeTB0ZkxP?=
 =?utf-8?B?L1cvbFdUWWxWZmFUOTBNTUk5YzhqQnlSMnpDWFhFYkJKZHNLcSsvZ0xhMmJw?=
 =?utf-8?B?TmV1bW1tUTZzUnVFNklWdTJqQjY5blg0alR4U2krN212TjJaRHZKOFVFSUQx?=
 =?utf-8?B?WlBubTg4R3pVMU1mTXF6c2R4MTd1Q0EwTFF0Rjg4a0VFSWFCZnJiOXRaam16?=
 =?utf-8?B?bFpWWTIzK1NScGRJZUNZMHZNbm4zYW54WjFWRk1NVjg1WVlUQzRYdkRxU1VZ?=
 =?utf-8?B?Qkt5R1JSVERJaTdEbXZId0hlVnN5U0pnWFAzSmk3bHlSWlljcTBFdlJyTjUv?=
 =?utf-8?B?dklqTHZzUU1zU1N6MDA3Mkd1LzZGeTM5aFZ2N0FNVS9jOFZ3NmZJRGZTTTdT?=
 =?utf-8?B?TDZsQmdTL1JuS0JKaHFmU3ExS2w0WkRHdUR0MnVwVUpwR2ZJM1pGZz09?=
X-Exchange-RoutingPolicyChecked:
	JXT8zayCqs3XmFIfMwwXtQr5D8oCYEls2bRjgUCUN+DnK5MEFKQ/4zmZuaCfCr5TN5VkkRKqiFD5c/pbZ+M7WVL13v3gb7BM1t0f8OTGp7ousXOnfFM2b3IfcGEfLRBKGa4a8vMYBmMkxbouo9U3RGchWremMuujSatiZ/ANy7V2328vCH/JF9Fr+AS2N0YCnO/FLutkLALcxMKWfByOfCo5t49GZxakxZLVf+kg7SaL+K2xMLFowyeK40jeAPME6T+JDzWGgU0NtgZXzSTlWkkF1yV4FUV6nfKTjWS+1x4v29QeYs5Hd+Fxo9spqMxgpEbShTwan9JKCnYkjtBPug==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f3a4a4-4b68-4189-9a4a-08defd4398c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:13:10.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HADL3U3FBCs9PdYj6PeLWRP8f8Ngl2kn+S3ENmJilq3ZxHsipPjBWKL2hT4lwMXiNho1SjMTY7+Ie4jI7S/WLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7268
X-Proofpoint-GUID: ebAXsXN30fyFQEQOxhcebs0k8OkoVmxg
X-Authority-Analysis: v=2.4 cv=Lc0MLDfi c=1 sm=1 tr=0 ts=6a84849b cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=MGWj_vWPkVdxS589E4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfX2Wanm4oaiXOa
 vRHIQ6OcLb602EjAsyK1848q+bqrt9ppD7mAhIuMlt10BNHGx2DpsUbc6L8j0HQkoIc57lwc1Zi
 EedkeHtpuas6xFPLR+64bdfKeug4neDb0+Iumy9TMMC+nNGiV4im
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfXww69m/XtBQgj
 nrtnqNi/ZJrAZugcBgUH91xM5zLrSIn6Lexpe4To76oe3TFtXEaq6BltSYYxfumL0YLtQ4F3NzU
 d98r27c2XYnIK6Q6Z9QlwzeJRW/V3da4lMtyZF5WyBkJBbnQ67s5LJBULD8Wb8LWxM9asI9LReD
 SbFTJHZoSL6439QAmrRQxB0th8kdWYdPHA/58FSnZDoGw8HFv6P9VCMEH+FPvHGIHGzMjL8ocw2
 65qiujdc9qxIiJ2bh6wwf/AsaWmBZJ9p/Z0yp6tG3Mz7LN1TU2NMlPTQh/+qmZmaeD/7b+AiFbp
 ZgPr+05WDxvy2AL2rICdnz+DqxnBTaiflLZ4GvSAaYTzfhJQOXdBf1sDf3wMoVOFxuN3QBnHhAr
 5GAUVVfDToDWULxrs1hwLOqyT4LJbfUaHSICzFwBNFVZ8ziWgckPSiGZIBaxdvEr84+2mOPNITD
 N7q3uZvJfLKUPx1uOEg==
X-Proofpoint-ORIG-GUID: ebAXsXN30fyFQEQOxhcebs0k8OkoVmxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180119

On 2026-08-18 09:45:05+03:00, Andy Shevchenko wrote:
> On Mon, Aug 17, 2026 at 08:32:57PM -0300, Jonathan Santos wrote:
> 
> > The device name for SPI devices was formatted as <controller>.<cs0>,
> > always using only the first chip-select index, ignoring the remaining CS
> > lines.
> > 
> > Change the naming format to <controller>.<cs0>+<cs1>+... so that all
> > active chip-selects are reflected in the device name. Single-CS devices
> > are not affected since the loop only appends extra indices when
> > num_chipselect is greater than one.
> 
> ...
> 
> > -	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
> > -		     spi_get_chipselect(spi, 0));
> > +	cs_len = scnprintf(cs_str, sizeof(cs_str), "%u", spi_get_chipselect(spi, 0));
> > +	for (unsigned int idx = 1; idx < spi->num_chipselect; idx++)
> > +		cs_len += scnprintf(cs_str + cs_len, sizeof(cs_str) - cs_len,
> > +				    "+%u", spi_get_chipselect(spi, idx));
> 
> So, if this won't support sparse CS list, I would just go with a standard range:
> 
> 	dev_set_name(&spi->dev, "%s.%u-%u", dev_name(&spi->controller->dev),
> 		     spi_get_chipselect(spi, 0), spi_get_chipselect(spi, 0) + spi->num_chipselect - 1);
> 

I don't think there's anything forcing cs to be contiguous. So cs4-0 does
not mean we have 0,1,2,3 and 4 which I think the above implies.

Moreover, i also don't think is guaranteed that `spi_get_chipselect(spi,
0) + spi->num_chipselect - 1)` yields a valid cs. IOW, in theory

spi_get_chipselect(spi, spi->num_chipselect - 1) might be different
than spi_get_chipselect(spi, 0) + spi->num_chipselect - 1

- Nuno Sá

> (yes, need a variation for num_chipselect == 1, but I leave the rest for you)
> 
> Note, I do not see that we are expecting to see the sparse CS list here. It
> would make too complex logic to follow. So, range approach is KISS in my opinion.


