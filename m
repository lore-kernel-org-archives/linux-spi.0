Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB225A645
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069350; cv=fail; b=lxFdjDRnoRSglowX6lwqOYDEVgMwk7wgrLaU29AcPx3clkSEUXSMX9exEsb2b/ZjWe9jsG8w3ToaBtx7WYjo4ckwqYeujm5AQLQIEEGEbW5/b/iPCoDfTUAyI9mSuLnIe3/b2/MlschKwmQluEkE8Km5itCS3g64aQBk+cqPRoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069350; c=relaxed/simple;
	bh=W6oLP92X/P4npdHpxrdKxCqGfoqACXDPr12j6tzYFKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H+WNlszyguovNtJY0SSQK8jy0BJmd2zF5m1RbQd5F6HuQtxscbWwe0zCy+qCi2ZjHdRT8vMce6nOR+9+6Q8dgZ0PvaTgWE50hIgnC1Te1se2BjSZLWZLM645Lw/84xhmfDg9mmrpi8kneTmCZj4/DzNDH/GmxEQpNvy3ukptOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=eCfe/h01; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CrAhTp5I; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="eCfe/h01";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CrAhTp5I"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kPOJ2503963;
	Thu, 15 Oct 2026 09:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=pfDreqZaSiWg/TAeQOWkuv5pwqFprkkP00kZC7pYiuQ=; b=eCfe/h0
	1RILq6U/BVmRfEQCbLgtFi6T5DWOtl9cx2A0umfbvFIbE8hw1a1im35nPcZW4sdJ
	RajEyjmkD7JxoNkwm+6Oi8gI6XeDmIxqnpWvs2f3mhpVe66ZrIfaime6oOGiwWb0
	130BFprLy+2KIRMVAqCVXUhVCj3AWQX9q6W03WDyeN/0EH8Z+dZQJAJyRBn1C7Xm
	3j+cn88i56rHSixuMVjpBW1acCMR3zlUq2vXUah7jlxe1BJaOG6AQkZ2gOvD/Cn7
	pFvKsayiw9RgKoYdancNi93hRWTmh2m3rfL8hR+dIW/fAd1Vw92DqVfy+xdDwiAI
	3ivsopTGgE9oXFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pfDre
	qZaSiWg/TAeQOWkuv5pwqFprkkP00kZC7pYiuQ=; b=CrAhTp5IQ9IyPn0NoKF1H
	f+2r7StLDaj/SXDiVk4z05WuJArsD6Nynmz80M20EhqgYHusNwh+j6Ashv5Gxv8t
	cqmrfKY85yKrGNabKbDDDycEUi4wFNcjodTtXUdaDv5nged6WezhlHkFekNsdM+T
	0kbSdmIkLxxaneqz6l+q3+dt0VWJ77sz93OEwJPv7CaI0oq7VraHm0YJEvsiG64H
	4x+4Jaclc9+Z4C8Q6IX2aXf29iriX3E9HR/T2UpqKYjLy817Tm4sRJS63zD2cXjz
	UOU/D/JOlWrQawVeRZ9nUfaQ9MgRMQTNxYZAU4Ma/7kMd3RMduaa3BOM3jv/D9L7
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4harn923qs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 09:01:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwoTdKP57GRf6I5Evh/Qkspi+/1PPSfSeH8gECIAs9Vm8/1ccX12LChqzYYwDKzpbPQGbxWTbDppwRvP3+6cZHpPlx0D2uGBF8XtZIm6WY/8CjNMdSQuarklOgeI7tU6YjuCNOGZt4SU71PD82LlXXSmPKYmbjRBI0XTYZI2rJuCpfaj93JKeS6/JgBys3af5DX+Cbass4d2EkcNWEk9zeVkkuPJdeymUZJLoAlkfdBkgilD0DTIrpisPDHKuNgP/aeJA3FSf94ccIh0aEGFo9jFnlWOb6wNSXYfn9VFJbfEZcn0w2V295c+AdfgzdjkhGkYQi94q7wTfUbU3ClLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfDreqZaSiWg/TAeQOWkuv5pwqFprkkP00kZC7pYiuQ=;
 b=i17RYEzQ3iJLqOpZx5cMJ2ciQzdU2/YG62arNXAVFj0RaK572dvb0h/R90Ml0V45MzZUKafabVmJ46KaYVh/zrKpo57tPT6atwclUzWaCLLQcyRO578l+WihYB8C6guEHmkj0OzeEEoi41tsbsVnkAlUyt080An6hf5CckEQx66137pWokNdqFwZUQmSWr80n8Th5PxFFOnHQjgDK3sqqAuoh4suvo/fBgiwQwSsx8hu1XJ1MbSUr9DjPNNnYq0k5pNj/wIFRhPlO/rk+IzfG4s+ybXdy1oYQF31E8pBfmVMlqRBgR97bkFcobiqzsDWElBYem3mTV0uiDQkaoDNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by SACPR03MB363256.namprd03.prod.outlook.com (2603:10b6:806:541::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:01:56 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 13:01:56 +0000
Date: Thu, 15 Oct 2026 14:03:09 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Fei Xie <fei.xie@horizon.auto>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, miquel.raynal@bootlin.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND
 and NOR
Message-ID: <atDMqnFiKJc5pVlp@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <arOwdePAmoghlakj@nsa>
 <20260928055005.3987624-1-fei.xie@horizon.auto>
 <arp-E1MDFLfV1ASq@nsa>
 <87bj99lef4.fsf@bootlin.com>
 <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
 <20261014093453.688565-1-fei.xie@horizon.auto>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014093453.688565-1-fei.xie@horizon.auto>
X-ClientProxiedBy: ZR0P278CA0163.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::10) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|SACPR03MB363256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb78830-b544-4d02-3015-08df2abc7d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|3023799007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IbcWZrcZ4PUMjtszweWnaP5Hse8yuw8PMNnUIBdttawh0T03FcBg3ZR+GtRjXVF4kvsKyQlauQLO9Q7PSoVWPqrm6aSb0nzcaFaSr2mIf8DHGdk9Ig33HGzluyLS+5C9GcusAgYpdkMfiFLGIYaPBX6xoHKR9+XJeRPwnx138aeSrPB982ifSgyPWDi5hJm4GBgTePUgbQq6OrMH7vK9HXtQTBCSKfXsB3m7G9RwdntaG3FDq0szaKgz89RJmWAXRLEGkJY+odPiokX9VJlcEXKRtydSag9NgP2ynnqlSR3J+1Qrmao4cuy2DN8eu0a0X8LqY8rG3y38Si1B8AJtE2QWvxvTgK4WvVTGU+P8g3vygpGGZgm7GtrnSPyGwma20qB7Dp3F7hI+Uc7lY9HFuw1oiAMjUQs1xct+HUpMCrBvlqVmQRLPGZAM8znFNzkcZNHN81yVxbBytqa4/6DmB34o/h6cimY3LVkziskCMV1A5VDrYEt5SnjwM0aB7p07cu0OtSckkb7GILA+Tfgk3BbloXQkkoZraLhujHCovH3kiI7ekyP3kfRJk/TJ5OYK4Nvj0uxhqXlLNhAb2ww6C+xXS4j26QRsooCISrnFnXzbW6sGpNgbhOKmZgGj38/I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZ0SE1EL0ZFRmFpZW0xMS96dDZXVGVNckdid2lWTVdHWXJzUGt4bE9GVGF0?=
 =?utf-8?B?dUFhSUZQdXQvaXJ2ZjVkaFBDWlh6SStJR2FlRnFvdyt4UGxjWHB3ZDFYa2wy?=
 =?utf-8?B?YzVyKytFdXFnMHpuaThoQmorQkQ0enlxUzhUazczQmtEYW5RWGFHa2IyeUNR?=
 =?utf-8?B?WE1HNSsycm00cWhyUTMrWmQzRVBndGxDVWx3dVV2RVg2NjY3bE43V0kwNjNr?=
 =?utf-8?B?T3kyVXRTWStjRjlQNGc2dldGMWNJeExxUDFTTHFJdnlkSmF5MjF6NFpnY1Np?=
 =?utf-8?B?cnJPNzlCRTlaWmVkWVVjb3c3UHIvK0dKQ3lzajBpL3RYRXFrVlN1aWVOaTF2?=
 =?utf-8?B?ekJSUldXOUhqczJ6VnphY3NXbGdGTEdLUUFLZGdlWUhCRHYrK3VFRzJMWFhz?=
 =?utf-8?B?ZEdMTURaNDBhSFhqZ2VkanR4VHQ5dGlxNGsrQjZzYnpTeVBBM3NQNUNNejlB?=
 =?utf-8?B?a25kRGVXU0grL2U5SnBQZTZMWi9GeVNTczEwTDlSSExPaWVCT3BwQm1xTS9Y?=
 =?utf-8?B?WHhKUHBzYU5QVHliUExqaERDRmhiMFN2RVZPTC9WZUovRTBYcWEyQ1ZyWFAv?=
 =?utf-8?B?aEg3TU9CU1U4MTllbnptVHUvN1lUQm9BNFpybmhvY0hWbnNRc2VXdk1wc2ls?=
 =?utf-8?B?Zmt4MFAxN0tYbXhMK0g3MkwrMTREcW40NGNqT1NvTmUyenpScFZUSVpTYTlV?=
 =?utf-8?B?c1o1aG1VMXg2ckVtWFJKcnhLOUpxQnNHWEFxbXR0NDg3MlRHbkNGQk8veVVM?=
 =?utf-8?B?UExkdHJ6Sk8xWGpYTmFWbjV2ZXp5eEdIZnB3SXRRM2pTNVVMSHhLVmdjQ3ky?=
 =?utf-8?B?aXc1RldyVmw1citKYTBCQ2N1RDVsOU95MGVJY0dJM1h1UHJQMldzK2N3eCt4?=
 =?utf-8?B?ckV1NVFOd3luMnczYTVNUTR1dkNSbTBYeFNoYVFURG16UU5HRHB1V3kxL2l1?=
 =?utf-8?B?NDlzaUg1Q2FVa2Izd1JRVEpoRkZPZDcyN3hOSzNpMUk3NmVmeUhnRDhub0xB?=
 =?utf-8?B?dkRiUFRweUhqdXRZK0N6MFdnTVIyN2UxSFIzMEJCTFNFdEFDZ3ZHMnRFU2Vt?=
 =?utf-8?B?dFRtUkZwTTJsMGF2VUlLVDlZRnN6OWFBQkd1d0FPOTlwSVRZUFFXKzVFVGVL?=
 =?utf-8?B?K29PakdRR1pJYnhvRGFyemVNWHZOc3E3bzIrSXNsUk5ZejYrcWlYSWUrSFlm?=
 =?utf-8?B?dkZsUCtBRlV2bUxzTXY4VUd4cTRybktRVmFUVUZLazlnTVh0SWdoOWRrb3pV?=
 =?utf-8?B?VGxvNmpRbDNjRzhGYUVmVXJQOW9CNE1sSnhKdFFORldTM0QxaG43anZzb1VP?=
 =?utf-8?B?dnlSd256QnNvNWVYN3hUSlhhd2FYbFMwNFE5Q2NqdE9hblpWeW8yZkVldkFZ?=
 =?utf-8?B?aTVqUnViWHdCeEpaS2dKZSt5RUR6SHpEYWN5TTBhb01ZTFVoK3hDbjdRclp4?=
 =?utf-8?B?Q1d0cGtBUjhwZFAxMmxGMUpGU0tJeDNtQkN0aDEvRW5kdDYvbTVFUG9DQ1do?=
 =?utf-8?B?ajFQVFlEM2Y4Q2MyY1YxVjF0Q2IyZDh5eUJqVmVUTFNQOTFBUDIzVCtkNlpk?=
 =?utf-8?B?N2FrL0ZnOGttTUpQSnY1R3VTWC9CM0lCOTlLWEZkS1BYcXEyR3pZejlhSnJN?=
 =?utf-8?B?RnVVZ1o2U1h6OVB4T29IaWUwWU9udGxlMWpoNGZuZTIxNmtQNTB3M3grM3Rz?=
 =?utf-8?B?bU5QTjJJb0N4VHF1dDkzRFVCOS9aOUhyR0V0ajVQT0gyU2RyZUpjODFqT21s?=
 =?utf-8?B?R2NnMnc4ZjJvR3QyNXVCL3owd3JRUGNHbnE5Mi9LM0M5SllzMzJVTXZ1MUN5?=
 =?utf-8?B?WU00MDNIWjFhbk95QUFTWDdGbFFVSkJzOEFKZDdkampoR3ZHaVRWcys5bGNN?=
 =?utf-8?B?QVk2VUxJckJVSUphT2VkT2RzWG9WWlNCZDNtQk1sYVIybCtuUm05aEhsbW5u?=
 =?utf-8?B?cm41RVRiVUxlSjBIdGMrb29wc0hXZmN3aG4yK0d0TitUYUZMeDMvMW1tbXhF?=
 =?utf-8?B?ODBEaXJ0WUdDR0Nhc1YyVG5KWVRVWllEWkdNalpSRjZzVm5rOEk4azVtK2lN?=
 =?utf-8?B?NlVDTHlhZ0IzS3JlSTYydE4rbXhLeDJyYW1KUS9qS3pCMW1xYVNudDZKUmJp?=
 =?utf-8?B?TXorOWx3d0xCTlAzQlhlaGpLK3ZZbUdHNFdpSTIza0RWNjNtNm54eVNCYjJa?=
 =?utf-8?B?TkhpMEhzd3hGL2Q3ODhabkJrT1JhWGVkangxL3dsV1NmWGdNRDU3MWd6VldN?=
 =?utf-8?B?MXhTakRFSlZQcncvZFgzbkJZVHdaUHhLczBTUGhwZXQ3SnR4L3VrR1R5Qkcw?=
 =?utf-8?B?NC90a0RyQzZHYnNHb3Z2TVFBNWI5bXBzalJZbjA4S1RRa0hXT3V4dz09?=
X-Exchange-RoutingPolicyChecked:
	oalX1QPiCM/NHSsNHPalR9Vwbo/BlaocXWWK2Lrdvm64h6ODCLT6W9P9I/6LTgOsU9OkibztC0CG3DJ7oVX/JjSKdtLN2yrBCFQ7KIKOSO1mqOnyH68cjtYsxEezJaA5/nr3bhPZliwbnq+uaQ5qnL5vQhvkH1edQmR656ASiYOlpIPCQDvQVIqbd4Sk59ClOZZTkRn79yUPCHnwNbVt0GOu4KQcQtXJOAFcfpjOhjx2epoRrQ4Jm0DVaJhzflXZQLaZmhasiTdz+BTm3RPprG2PVpARmnxXb2TckDD+M95joxCsc71xQRPa/Inbf163HTUcaOZjPG4QshcBcXB0Fg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb78830-b544-4d02-3015-08df2abc7d98
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:01:56.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t2Nh5nFP7m/JfA4eyoxoXxt0CG0tlfGtQRWhbEw5r9nMgo5bCR9Kmo2LMczgu9K3MOLz0lLuWVJN15O6vnQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR03MB363256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX0+adCRVtBcHn
 rI90hKTIxgpViE+nBbbWyaF/hYPdyAzsOnPJrwOBb91hYocJkPnFUbLppG+1jKQq5t31WqPNBJu
 Yf0RX334Fec+pI2yLyn384/gHULOjMQ1x2Y+UJHaQ1ZrDBPfW8y5O1sg6CcbWbkx1zUMUw9WsdJ
 J0WID5BoTrA9m9L48OWMrdpQ5MlCIZ0vCF6Su3Zr8q4s7lyQW2GkUvBrJg2vfw4pXFBiGgXY+mm
 pclu6ZyheUHXH+GgYEOt00iKJ/wvsLvabyKual+DBG4Zg8ZRwqjbOYEoG1W4YxYEnRobDZd7Vih
 VwDZtFlhiV1Gs1qPvwIqg5sBpKxaZxJR0cPJfDnTZ31bJ0tG9zJyr2OgoxHiRq2biGMilWGoNwA
 l3iOsxmDxSZw9M6FYTWyhdog0fB6pp4EZ/uQR9B2WbTawtjTdY7kE4TBJRNZ8X90TOWyYEHg6vL
 E/qg3vQAv3VTXxXOBkA==
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6ad0cec7 cx=c_pps
 a=ScYCyfYCeG8NXYeL6jRcjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=t5lKuJT2QOhmwdEfcCMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 5SvaGcAbUx9KD55ZH1a12nimPHfymVFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXyUOfwceYcxA6
 TWBRPG3KHUbVMTKA5CwZv1HhZ9owdT4TUbHp5v+AgPVHtyAuZZRpo9Y8SY4a5VMaHgMcFyGJ3QO
 oJftVhOlOCBntBCh+5neeDatLW0jfPuneh7rod67c9a6tfNNyH3o
X-Proofpoint-ORIG-GUID: 5SvaGcAbUx9KD55ZH1a12nimPHfymVFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On Wed, Oct 14, 2026 at 05:34:53PM +0800, Fei Xie wrote:
> Hi Nuno,
> 
> Thanks for proposing this. I agree that starting with your simpler ACMD
> support makes sense. Please go ahead with that approach. I would be happy
> to help test it on our Horizon J6B board.

Alright, will prepare something for the next few days (or next week
tops).

> 
> To clarify my earlier benchmarks, "sequential read" referred to reading
> consecutive addresses from /dev/mtd18 using dd, not the NAND device's
> continuous-read mode. Our GD5F4GM8RE datasheet describes page-based reads
> with cache output wrapping within the current page, and its SPI-NAND
> driver entry does not advertise continuous-read support.

Yeah, gave a quick look on the DS. Seems like it does not support it.

> 
> Could you point me to the version you would recommend testing? I can
> compare it against the optimized STIG path and our combined NAND
> read-sequence implementation under the same conditions, checking data
> integrity, throughput and CPU usage.

What do you mean? IIRC, you need to make sure what you're testing has
this:

https://lore.kernel.org/linux-spi/20260511031732.3199-3-jszhang@kernel.org/

But even with the above I saw a slight improvement on performance by
combining the commands. I did not check CPU which should be big gain on
aggregating.

- Nuno Sá

> 
> That should help establish whether combining page-read, ready-poll and
> read-cache operations provides enough additional benefit on this device
> to justify further interface changes. We can then use those results to
> decide what, if anything, should be built on top of the simpler ACMD
> support.
> 
> I also agree that program and erase can remain on the STIG path, given
> our results.
> 
> Thanks,
> Fei
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
