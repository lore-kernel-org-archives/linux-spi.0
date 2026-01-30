Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421122D23A6;
	Fri, 30 Jan 2026 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780514; cv=fail; b=MC1KbtI0dyq0XWA7L8Azv0whYmIBFn3g6bcQZvRA5DWojIQnK72Llhh7PXaZ4Dfs6yfxDojHpHTyyHGVwmS/8okezPXFje2yO8QRKlmV5rry688A+Yuj65ggCRVRVpIoilR7ArAnb1wy8ctXUYz5qO2qQidkq/SJi8MYxyDaoRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780514; c=relaxed/simple;
	bh=cLvj4ZdMdZTrEezjBTZBsvqKwsMT9AGalP8lI96sGgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nw42pH3IWN3JsYdgxGsslhistnKxWzONhcUKaVvZeaCu5SNCBfDvUUoQXiw4yXiivKEcJODfEjruDtShcJ2T4nguU5UIj+ugtv60kIBwPG0h4UiBIq8H102fWG9OASX8oNstVVqUVEG40jzvgkB2RLTFMuQ212F2CKoPzfFd6J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PhsHMMvO; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PhsHMMvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ6NsUI06IyiOVuNqeSR3U+3YhpF0qsaD4ErNLx6TOfAINWwxnN2Epsrc5QG9Y53sLI85JjsrhLDJld11/AVjOPFZuqWjYxOAChaEIhSRJ+Kh62iF8yiL5Zbxhr70vdq8qpkxpB4BkvYOt+ke3GeV27qWFC+OZGhsSp5NNdvVsPKmZaD6JF50pxT5AuZRLf5a1yFu8RROLs12ShgPmlnpqgKxIykeJziKptW7CNWi9ArlmroBKTd+KN6mzH+SfPISLk/qgNaWrgXjrNoToAFztu+Ki97w4G0yFfiGgIGat6dlyFkp5Criwancd/4B3ZN4EUbC3rtnYZIFZCERP78+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioqwMYzZ3i0DJYqThy1OUO1aIUNQmL2XJEyPHOzPrcU=;
 b=LL3HdSE2fifRUtWyg/NKtxNep+xURrL0H26hYlsn7V0XbiJcCEYEMPKWhqHaN133w5KWEMBpGfnAffXLLd35tVkAk4cOHRS0lJE4i/TdZiAdpbC/I62HCXsuwxVJcfghJITSj/1lab+tAgG7oHvqwhfvDbR9eCBoONx6syfR+ogzvU7qtIIeFVEisOWG4PCcODaE63ZLHRTtWLqgbUIJnUFI75IjglffbRun71O89mMhhddbFweSgv9gp/Pm7no1t4+y8L3AEkZLvnsWwggAXrxGqTx4+Atn1RycEOiHDfM83suMqPYuNf23i2ulva8rmmwkhVrrSzmhF81TTCDvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioqwMYzZ3i0DJYqThy1OUO1aIUNQmL2XJEyPHOzPrcU=;
 b=PhsHMMvOeaFHwL4abWiw56J64SkwpHl6Nururm+5aRuBd1r+DkCNzH0WuiE1jyYVvna8oP54kRvTxHos3+bKX+bfOhuIi2H3Bwi1OY7V5TJZactzfZ91n5ftLXxqi8Vs+iMW1S+1mICwycZM6szG8zsxTb09irtuQ1Dezs/uR5aix5dJXlmFM8n1+1WFpUiHjhyhbp1I+ydiUGEIgDOgonWFitmJ0OdaOfn/B0y8B6Ir/M29McZdy/zn5jfwDaSfcWi9CdBkW4Z4Ka9gvAQyv8+5qJSsarWwvYEH3wEmREtyc+6Fp2Py8Pi1XTlIbBDAJBtQoxxfc3FY2IE4wctHOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 13:41:49 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 13:41:49 +0000
Message-ID: <57a63922-e194-4882-aa52-9447255ea1a3@nvidia.com>
Date: Fri, 30 Jan 2026 13:41:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
To: Thierry Reding <thierry.reding@kernel.org>,
 Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Vishwaroop A <va@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, soto@nvidia.com
References: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
 <aXyE1kfP4GeOdYs5@orome>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aXyE1kfP4GeOdYs5@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: c8db4470-4b5b-404e-d767-08de60055142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdrQ1ZpNlpvMXQxcUMyMkJUOFIyMnZzLzdJM3FnRE5tMi9DNDZzTFZ1VThP?=
 =?utf-8?B?WkppNXk1SER1bmVvZXppY0dzcFhPRzdqOWpXN1JyekE2aWUrc3RYRmdVTVht?=
 =?utf-8?B?K2NBSmxQd3BxNFlvbi9vaTcycUJ0RjE3MVVqNFRkV3crNTRSVUs4RmIrN25I?=
 =?utf-8?B?YndlU0ZLcXF6S3M4ZVNBREJaa2xwdUNLWGl0azl3dTREQlF1N3RXVS9Hc1NR?=
 =?utf-8?B?OTVydFFldDlkVmlpNGdSVHptd3ZqQjBqcVJHYjhPVjNhY0p2UkgwMGZTTDBX?=
 =?utf-8?B?T3RvaXB6Q0pORlk0YjNmQ29jZWpZdElyWnV3VVZrUDNwTUphek1ZZVRDZ29j?=
 =?utf-8?B?MHA2ZnZTeTJyZE5FR0V0eGxwMFlndjVpR1RkQ3M2NFd3NFB3MVdWZjB4d2RC?=
 =?utf-8?B?V25VOFZqN0ErTFV5Qm5rTU41emUwbTRYT3dzNGFsYi9uR0djdTdrQWNKcTNh?=
 =?utf-8?B?dXozWk5WL01BZHNoKzJXL1kwOUJwQ1FjdkVVc3U5a1R6SjJyY3UxV29ickxT?=
 =?utf-8?B?NFp5VWMza1RER3RVZkFaMlFUdncvWklUQWE5ZTh4d2M1QjlxcXRvcFl6QjB1?=
 =?utf-8?B?cHFjTUJ4cGpOWkluNk9jQVJveHBUamkxZnVhbXdxWDF0eFUwb21xZllESkZm?=
 =?utf-8?B?MFhDL3k0K1hrZ25xMkVsbWQ5Y21pMGcwMHN4SzQvekFaRC9LRVk3eW52YUxk?=
 =?utf-8?B?SjBSd3lERTE1dVVlcldUSGdXVWJhNUlhTEFXMFlNajlLeFBCMmQ1Wk1HNVk1?=
 =?utf-8?B?YlpITktOajNLUGoyNkh1UzZyTG5lbzZmNWVmQThmUkY3MmRtNWdUR0hvbTk4?=
 =?utf-8?B?WERSUmVZOHViakZZTXBudkpwNy9YTnk2YXRhWDNIYVRnNXFTbW9YVm9RaG1I?=
 =?utf-8?B?NGFxaDdBVFFuem1pSFRWdTFMUUdOTGlhWFV1WjBpQVRCUWxjaTJtZmY4b2I1?=
 =?utf-8?B?eWs1cGpFVFlkSHJReVJJbkR0VTVXTUlPS09oTG42dlFQdHZWbmJrNnhJL2hW?=
 =?utf-8?B?Rk80czQ5NTNFVi9qRDBaOWhyYmI3Y1cvVHQ3aVFseFA3OElBR3dvRi94Z24z?=
 =?utf-8?B?WDYydkpWaDVKOEY1Q1lDSEpGU3V6ZnJURlNTNU4zTEhXZEZsLzVPakZqMGhH?=
 =?utf-8?B?UFRDTUpmSlBST1B3MFhSRGlQSS9QaXBWbEduM25pbkI2VnBPYTFtL0d2VjBN?=
 =?utf-8?B?Yy9EMmJtWWFpV1B3ZVlScDNTczVLenhubkVEbXU4Sk9HeEE0WWVSK0xtaSs5?=
 =?utf-8?B?YkNTb1NnUENQRVJIY2xMUng3TXNNSjBZN1JaTjZqRnhCeHNFM0tHbGVpMFRu?=
 =?utf-8?B?TE5RV3ozZzZQK1pRR2JrZkNrZEZyLzdrbHpQMSt4bUh6OURZN3A3OENCVzFx?=
 =?utf-8?B?MnFiaEU0Tkx1V0ZLVnpkNUNPdjB3OGFIYkxaYi9BR3RuZ3ZndTUxZkU2Y1d3?=
 =?utf-8?B?aVU3cy9JckV3SlZkSk5COHhqWWtGTUMrbWM0bEtmM1QvWWdmcy92eU1SeDlG?=
 =?utf-8?B?cEVmZ3BrTXNDeitvK1U2aTZ4TXBSQzVQdHBNbW1vTFE1dDdLWDJHK3JqdzR5?=
 =?utf-8?B?VXNrR3lCNXorWDM3K0NPWVhmYW5iMnRzMU5ZbjZxL1l2UjR5OFd4OTZNd1JD?=
 =?utf-8?B?Y1FXL25uYVJRMUROM0F5ak51UVpZNU1DZmJoNzNXSnp1cC9MQWxjNE1td2FG?=
 =?utf-8?B?ZEZUZWFIZHMxU3Y1WnJMOE90YXNJUHQ2ZnRoYjhFSEF4RTJZUTVOK0M5KzZ4?=
 =?utf-8?B?Yy9MU2QrV0Vpd3o1MmZ2ckdBajRnL3pjeGVFSHEvVy9HTFRNMEZwNDBpVldp?=
 =?utf-8?B?a3ZWdmNRaFRLV0dmVllWRWFxY2dSRkUxcjU2NGxSRzJiZGMxVEd4enU3SXVO?=
 =?utf-8?B?WVk5bHRad3VEYm1tdlV3VEtXL0k0a0h6NzdoR1RwdVdWcmJHL1VvNTZUNUIw?=
 =?utf-8?B?cm10N0NTc3F2aEg1MXJoVU1RcllnR0s5Y0t4QUE0VGx4S3NzMkxiTG5lWmZW?=
 =?utf-8?B?RHdlVEd1NjV3Z1VhcFMydmU3UERIU3NzMFVtSU5mWE1xZEJZdFExMUJ2bW14?=
 =?utf-8?B?Z3VZM09VbkQva3Vsc0MyRmxhZ3VRQms3aGJpUGJlZGlZb2FPRU9KYXNhRDBD?=
 =?utf-8?Q?JnHAGr6Hu1XPgZmNSPLA+6L3S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzNVZFFuOWljY0dmbkQvNlppd1ZNbnNjWWwwc09XTVhuLzdLQU9ydUdldHcr?=
 =?utf-8?B?dWQvbDk4MEt4UDNCZ2NZT1VSYnBjL3UvaHZuTlVRYXcxWEtHVUttMlZNSC9o?=
 =?utf-8?B?MkJPTEpMbFMwMkRlYXN5bVl3Q0xyQXZKbDNSRkoxVWc4V2pITmlsWTdkM1dq?=
 =?utf-8?B?dktiWFloMVhMejNCZXBCeHhzbmJSSkw4ZUg1NlpGNjJkNDVleXYyb25EbFlG?=
 =?utf-8?B?U1BzWFdlYThoVkYwWGN6S05nVzBYeCtRU3BFZTNLMm83N1JyaGZDUXVMVXRM?=
 =?utf-8?B?ckM0UktKbVZCOHNSaE9ISEdwejBLZk1RSktvQUFUWStIbWNWK3M2YkRVbmhG?=
 =?utf-8?B?Y2xib1Nvb0ZUVStYUW5rbndjTDJrQ1NIdkVaR0J6eDRSSFdQMDRKZm1rd1Y0?=
 =?utf-8?B?ZTd6LzdCYVE1eWZybVJTLzI5eE5ZV2pQNVhaaVg2bGhMUmt2WFhzZU5mZGZP?=
 =?utf-8?B?VXYwTzhPbTBmV3Y0U1FDMTVDdlN0akwycWhDcTlScnUydXVDcXZNQnNZb3Bv?=
 =?utf-8?B?bFQydmxXL1EvWG8xR05FTVJjMGJNSnRrNGhEcDFSSlppNDZ4Mmp0UysyYlBn?=
 =?utf-8?B?TUhtOVlIenlCdjRWYXlQMEtGT0V6bGoySVFHN3hHaWxyQWtySCtYUHcrakQ0?=
 =?utf-8?B?QkNXVjhyTERjanhJbHl1b1FFaW1mZXlBWllQWThZS1FNdXo2V2I4QnMvL1pJ?=
 =?utf-8?B?aFZJcWh6STh2d1NJbVhGcFdJcFdPRzF0eTBEWW11OTZZUWdkTjB4cjd2WGtH?=
 =?utf-8?B?aE9jQmlSYktvMnpYdzhjUEVGWGJsYXVHamJhVnI3dTZMN09TVUgyUlRoZjFa?=
 =?utf-8?B?Y04xRTVxZ1NKaTFFK1dvSUV5S1NrQS9qOFRvZkNRcnBMS3NoOHhkVFhPYVhS?=
 =?utf-8?B?WVFOM0xORWpKSG9XSXFoZ0xweUpnM0RkdGNWeU9qMjNRSWNTdll4dythRWJh?=
 =?utf-8?B?cURJaDh0U21QRmR5WnFmWWtDelJoSWhmOHhnOGNLTityQnhnMGNMZTFnMVdq?=
 =?utf-8?B?Yy9Ya0VscDJFb2MzcWhPUC96MHNMTWRORjVCUXlzYVVXUXI5QTQ0S013ZFVl?=
 =?utf-8?B?Witmd3RQWDBTOE9aZ0M2ZkY3alFtdVJSSFNIdFBYdUlOT0h5OTBha0I3NEx3?=
 =?utf-8?B?d3BjNTJ0aktLRHJTWlBOZVdvUUZZNlVtRm9JeVBtdWZlbTJoTVJXbDc5L2dj?=
 =?utf-8?B?aXE5RW5WNU8weCtRelNOWjFmQSthS0luRmc4ZlVWalczYnppSGJvZG1jMjU2?=
 =?utf-8?B?anZrNWdLTlkzNG05YWdaNTN6VDE3VVFzWGhEaGFsU3h3UFhvd3c0UjcvMG9q?=
 =?utf-8?B?bzhBNFlvRGl2Qmx5WGl4RVFYeXpORGpuaVNiN3hoYi9wMzVORnBYMEcvaVBo?=
 =?utf-8?B?ZW43eEZ6QWxPeGJ1c2xITmtrcWhvSDA1TkdnaHhteGQyVXo0V01uaTBjdHhZ?=
 =?utf-8?B?ZVcyRkJHM3MwWFNnZlhhWC9hUnAzMmRtN044ZFdGRnlVVmE5ei9hQWYrc1lW?=
 =?utf-8?B?OW41cDBJTm9EcW1lekw2TDhPWmlkQ3VOa05QT3FVZThKRmFraXJ5anQwREhy?=
 =?utf-8?B?cE4wTFpEcUV3N3pYbHVLNDFWZ3BKVGgxRzFoTVZJTHJrWDludStpRW1NdjIy?=
 =?utf-8?B?RFdLK2d4M1Ezd3pJK09oeStHYTJuVklMN3plWWpSMm5ZVFN2elQrejMweXly?=
 =?utf-8?B?RU4wMVl4NjZGZlNiK0xiOUk0TWExZ3ZyQ0dLS2MrZWVNNFRwZFU4c2tObzE0?=
 =?utf-8?B?cXU1YWhNSFUxdWR6K2tQdElYRXRMZEUvTUJsUDhNaHVUREYxbVNhZXBIQU9Y?=
 =?utf-8?B?Q2lEQ0JDSDIva1VFUkkxUUw4Z1dMdUpZLy9YYy9xQ2RJOEI4MEZrU0VGcHlQ?=
 =?utf-8?B?WUMybmVBUHZaYlkzR0JEbGIzUHNYVnhpOVBJZ0VZYStDbk8wclhwb2MwWjlD?=
 =?utf-8?B?OThwcGNDTjdjbDZ6QkVyQUM0V1hHUmdIYTRkbytCWE1oQmZxcUpzTEg5NU1y?=
 =?utf-8?B?djgra0d0RU0xRzlLN3h2T0JRbU5UWVVFcktPYnNNVW84REwxaHFaNlAwbDdY?=
 =?utf-8?B?WUw0bGd2ZU1FeUpVVVBSalNLM0hMS0xDdm00WExiUjJzV0R3d0s0RFA0ejNX?=
 =?utf-8?B?R002bTJLZFBvdEJEVnRpRXUvc0ZtZHdYSEkzYU4zakM2ZnFvOVV6T1kxTitW?=
 =?utf-8?B?cFcwY3JvRy9YY2RHdGN6eXpxWGkzUGVNZWZHUWExejI5VmZ3RlFydWdYajJM?=
 =?utf-8?B?enByUndnT2wxeWlMditiMkllRmNmV3ZKSENJMlY2a2NOSWdtYUhCYXExZ0k5?=
 =?utf-8?B?NStZbWRkUTBURVFmWjRqZFdYVDdGcjlmS3F6ZmJEaU1IQ1JsZmh4STNlYm5L?=
 =?utf-8?Q?8iCH6QoT1D4pG3eB5mQky4oaQKcyzgh33ePxwicNFtH4c?=
X-MS-Exchange-AntiSpam-MessageData-1: TeJfB0AsFeEamQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8db4470-4b5b-404e-d767-08de60055142
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 13:41:48.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QqV6NSc99DFHs3JaEOEYGjnPst13NbwARTpiCsvhfxOeW5so3mptCYhQr0rbrSikRkOh4sbpP6WztH5PPU82A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858


On 30/01/2026 10:16, Thierry Reding wrote:
> On Mon, Jan 26, 2026 at 09:50:25AM -0800, Breno Leitao wrote:
>> The tegra-quad-spi driver is crashing on some hosts. Analysis revealed
>> the following failure sequence:
>>
>> 1) After running for a while, the interrupt gets marked as spurious:
>>
>>      irq 63: nobody cared (try booting with the "irqpoll" option)
>>      Disabling IRQ #63
>>
>> 2) The IRQ handler (tegra_qspi_isr_thread->handle_cpu_based_xfer) is
>>     responsible for signaling xfer_completion.
>>     Once the interrupt is disabled, xfer_completion is never completed, causing
>>     transfers to hit the timeout:
>>
>>      WARNING: CPU: 64 PID: 844224 at drivers/spi/spi-tegra210-quad.c:1222 tegra_qspi_transfer_one_message+0x7a0/0x9b0
>>
>> 3) The timeout handler completes the transfer:
>>
>>      tegra-qspi NVDA1513:00: QSPI interrupt timeout, but transfer complete
>>
>> 4) Later, the ISR thread finally runs and crashes trying to dereference
>>     curr_xfer which the timeout handler already set to NULL:
>>
>>      Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>>      pc : handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad]
>>      lr : tegra_qspi_handle_timeout+0xb4/0xf0 [spi_tegra210_quad]
>>      Call trace:
>>        handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad] (P)
>>
>> Root cause analysis identified three issues:
>>
>> 1) Race condition on tqspi->curr_xfer
>>
>>     The curr_xfer pointer can change during ISR execution without proper
>>     synchronization. The timeout path clears curr_xfer while the ISR
>>     thread may still be accessing it.
>>
>>     This is trivially reproducible by decreasing QSPI_DMA_TIMEOUT and
>>     adding instrumentation to tegra_qspi_isr_thread() to check curr_xfer
>>     at entry and exit - the value changes mid-execution. I've used the
>>     following test to reproduce this issue:
>>
>>     https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh
>>
>>     The existing comment in the ISR acknowledges this race but the
>>     protection is insufficient:
>>
>>         /*
>>          * Occasionally the IRQ thread takes a long time to wake up (usually
>>          * when the CPU that it's running on is excessively busy) and we have
>>          * already reached the timeout before and cleaned up the timed out
>>          * transfer. Avoid any processing in that case and bail out early.
>>          */
>>
>>     This is bad because tqspi->curr_xfer can just get NULLed
>>
>> 2) Incorrect IRQ_NONE return causing spurious IRQ detection
>>
>>     When the timeout handler processes a transfer before the ISR thread
>>     runs, tegra_qspi_isr_thread() returns IRQ_NONE.
>>
>>     After enough IRQ_NONE returns, the kernel marks the interrupt as spurious
>>     and disables it - but these were legitimate interrupts that happened to be
>>     processed by the timeout path first.
>>
>>     Interrupt handlers shouldn't return IRQ_NONE, if the driver somehow handled
>>     the interrupt (!?)
>>
>> 3) Complex locking makes full protection difficult
>>
>>     Ideally the entire tqspi structure would be protected by tqspi->lock,
>>     but handle_dma_based_xfer() calls wait_for_completion_interruptible_timeout()
>>     which can sleep, preventing the lock from being held across the entire
>>     ISR execution.
>>
>>     Usama Arif has some ideas here, and he can share more.
>>
>> This patchset addresses these issues:
>>
>> Return IRQ_HANDLED instead of IRQ_NONE when the timeout path has
>> already processed the transfer. Use the QSPI_RDY bit in
>> QSPI_TRANS_STATUS (same approach as tegra_qspi_handle_timeout()) to
>> distinguish real interrupts from truly spurious ones.
>>
>> Protect curr_xfer access with spinlock everywhere in the code, given
>> Interrupt handling can run in parallel with timeout and transfer.
>> This prevents the NULL pointer dereference by ensuring curr_xfer cannot
>> be cleared while being checked.
>>
>> While this may not provide complete protection for all tqspi fields
>> (which might be necessary?!), it fixes the observed crashes and prevents
>> the spurious IRQ detection that was disabling the interrupt entirely.
>>
>> This was tested with a simple TPM application, where the TPM lives
>> behind the tegra qspi driver:
>>
>> https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh
>>
>> A special thanks for Usama Arif for his help investigating the problem
>> and helping with the fixes.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> Changes in v2:
>> - Replaced the TODO comment to clarify why the lock is being released.
>> - Link to v1: https://patch.msgid.link/20260116-tegra_xfer-v1-0-02d96c790619@debian.org
>>
>> ---
>> Breno Leitao (6):
>>        spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
>>        spi: tegra210-quad: Move curr_xfer read inside spinlock
>>        spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
>>        spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
>>        spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
>>        spi: tegra210-quad: Protect curr_xfer check in IRQ handler
>>
>>   drivers/spi/spi-tegra210-quad.c | 56 ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 52 insertions(+), 4 deletions(-)
> 
> For the series:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

This also resolves a NULL pointer deference I see on Tegra194 Jetson 
Xavier NX and so ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

