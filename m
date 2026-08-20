Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE899318EE2;
	Thu, 20 Aug 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234078; cv=fail; b=MUpNVWl5MkxeIy34tvLNCIBvXeUvl//Kg37sOpe44LTGQe3nD1tQqhgRxgkKFXETOT1EkPbqFc3CLQ2QFaxFxbhr2AEgKC/aVFUoAfFVNvtKflUFyjj/Bv047BMrr/zYXnt10b1KvecHbliT4SBkGWpi1r9btru6/KgemS2wRMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234078; c=relaxed/simple;
	bh=Nitu8CHfQ7JfAY4pSBez5SPvqrCF918DELy49VrHdM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AFGQiQ5CZLexpEAQr7KBALJ+F/WXQSc+3c8s/gyO3dbKwCHRkb/CbiL/tChhHggApmkGwnQpLM2tHkq3zypuNDiNgASddXz59e6MoYu3IE9jD9TE3Dq1PrLtOQJ+l5usaraBTYLqtDynOrN6qSCz1YCG/k97KleyaRrPI+L920c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K2+9Z2GT; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K2+9Z2GT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bptVwVY038SxTuxKsHgAOyO+5Cse+VBzSrTNzohU8t4auwP9RMcx+1CnusAe/gGy4eUpOTsrxkM5NLb/cORl9DobxDYqf8c8WBJCN4lM5l9TPy5CdF2o9JkGWVdtdb+col4fJjvs8I1rorkfm1bkfPaPb9eMxyUUj2YK9WU7I/+R2TafuXCNkxJS1Lv4ufm/EKEEwlNgXENBmX/rx1cguq3s8XX98L38mGxMhfJ3XPE0P38fs7lU+FP7DSe+N17nCrEnKoq2jkeiq7eCMh9eUhae8tWtgZF02PJ1Nz4f9kjLV7HAMhABNvvsjXGGHPv9pKD4OEZxe7N0QrJxTBVIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNRhLmBkWV1AqCs61FoBqa2jenSJpAqkR4qY4Q1oiRY=;
 b=AyVNegV6/aXJJ5xhBT5mXIXoa53JAi6SHftHBUwwCdbSO8XepGVemuwuN/CytthfZrCMGsz94QxRgZuvgbaA99PdFn8TNrGGxF6bCBBwfJw6EiSi4W1ybebOZYbNzPKeetUOn1K7rIpcQMWsPr552YaVf8vMJrpIs1/M5lbxrrodr5xkIp/xa8+hBluvudG2pPKg9Bj9fCGRD56lQar5DTyyHUmDliQ2AqBQBcE/f+8m/AdY7VM5K3T4lsRscmMOamtKbjLTYe3dACVus7WwFhuDcMLdRYAO7utzXjJuE9y2EOXTOfIT/BC97EDMI6g52YH3YduNLZhym3t2UnjUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNRhLmBkWV1AqCs61FoBqa2jenSJpAqkR4qY4Q1oiRY=;
 b=K2+9Z2GTH6uhS7ceqUqzyHNeyWsIsTG5g9PQjWxj2Qkl+pCJSSq+HX/IORCj3cQfTlbr1XKUYx+6d+mHBa5AjE1pfpZgO2qlrfAmR5GuDNkFGcCNGLqoTkvdAbHEcxiB7AnWhTbFN+LcniMwMJRbNcvFkPeKsz++3M4EwgZ/hZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 13:54:32 +0000
Received: from CH8PR12MB9742.namprd12.prod.outlook.com
 ([fe80::f305:b211:5c64:be08]) by CH8PR12MB9742.namprd12.prod.outlook.com
 ([fe80::f305:b211:5c64:be08%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 13:54:32 +0000
Message-ID: <c690ee50-d044-4bfb-b19e-0960e40335a5@amd.com>
Date: Thu, 20 Aug 2026 19:24:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
To: YH Chung <yh_chung@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "akshata.mukundshetty@amd.com" <akshata.mukundshetty@amd.com>,
 "bleung@chromium.org" <bleung@chromium.org>,
 "groeck@chromium.org" <groeck@chromium.org>,
 "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 YC Hsieh <yc_hsieh@aspeedtech.com>,
 Maciej Lawniczak <maciej.lawniczak@intel.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
 <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
 <9180f5d5-9885-492b-b80e-c2aaaeb39501@amd.com>
 <KL1PR0601MB42768F2FB7E907618E1DAB4E90DE2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <d1bdc779-724a-4851-8c26-7e02981bae7a@amd.com>
 <KL1PR0601MB427610EA42683AA298B53C4390A42@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <KL1PR0601MB427610EA42683AA298B53C4390A42@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To CH8PR12MB9742.namprd12.prod.outlook.com
 (2603:10b6:610:27a::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9742:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 23679928-612d-4c87-4bb5-08defec28f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4CaUVZkbPcqxf9zJVxRdZyNTg66U0zZtzlSTSIWSJms+4DRRaJMO+L6KcZjLbolkBsV2GzWASDnwxWBDsIiNGyQFf7l71sQnYOL4pmudJgjKswQJZ1BZz+fpPoREjIa7s1lnbZL+HhLOOJIfmmGWK4EyJouW4X9gumI5qWn1xrJOhn/sNB3KJCOUw+nrq1hM6qQznDeyQFXUYywMyod+Hf1dCj/Y2SpxEXdwJfoQ/FftmvQydkbeT2zyzWtn1ihEZ4wjMh0anVunX1YBEDky+x6bQxdgkXA2hdCAUDtZyge5IihaMF1oIs+EJPmclJ8mRHTt8fDwZ4ip5iaeKKDj7QmWXqEHY2XZpRLkRyHsANs9oFVNNxFLVZM12XSFknX6l0po9RkjsQV4uMMrbd/sq9KqNsfVs8ZyMbMFv3GWWZbAYeSf+UwT8GWaV8gsW2C2KzPvkOp16O5W+tlFeTuQKePI9PV7m/eB3sxRYhxbCnXYS0BlHePtIWE4zbG5Y1ojHWAdjfC1pDmDUKU2kwb+Lb168A3wjlJibCuLGr08rrO6QGSdvpAT0OPuZuwgp+aSrOCooHJy6rhv7CupXjylPqlftSdPAfnKLNH62HsxP7t4EfWhLokWOysURuIHfqn9lLdnQz2gQN43siYuTeUsWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTZBTmlVdUtxenhQM25yQ1lHUWNzbUF0NUZWUkRIVWxIMFdYbmlucUt5TDZw?=
 =?utf-8?B?Q004aWI4T3ZzaFowR1lHRmtSM1dmQjg2R0xvUjlyTHNucWp4cGM0VVhleXJs?=
 =?utf-8?B?cTVQMU8zclJXZHcrUk5DdC9Pc3IxZWxHRUphbFJIY3h1Z3lpbXpYZmZ4bk1Z?=
 =?utf-8?B?OFhaMEc4MndjbVdnbS95ZFhzUk5GczI5SFRBMmJtMVM3UUhpM0NkY3pPSmti?=
 =?utf-8?B?T2N5QzJaaWxIYjEzRjFzSzZaM3hCQ2xGbDAxeHhWQ2R3WVc2TjRSNWMwWkpX?=
 =?utf-8?B?amRXT2NhbVJQdzEzM1ZLVVBxamZGRG16cDNhblpFRTNRZFNCV0NGZUVqRVZ2?=
 =?utf-8?B?UjBndEJ6ZzdGVGhpeUhEdzBsQ0J3RWlURkpaSTZMSVNSWnlTRThxQmpHNVFK?=
 =?utf-8?B?UndhT016c2cwVGtGRVpQQmNxM2lnQUwwZXNaZHdSZ2ZCRUdnQzhLZkFGN3hp?=
 =?utf-8?B?M0k3NHE4VlluZkQ4Y0tEWFNuZURYVDZHQzBQSk5sVkQ1TzZsT1NzSUduZER4?=
 =?utf-8?B?WVRRa2dtZTVEK1drVm1KTHljZ2hhQ2liMS92ZDk2Vlc0Q3FxeHM3UzljR25D?=
 =?utf-8?B?LzVXTkxMdXBpNHNpN0ZTQlBJdzBxeEdXZG52cWNOTlAvYjluQTNndDMvY3RK?=
 =?utf-8?B?K0VlRm4zeE9UQyswcTZHdW13ZXE5ZXA4Ui84SWJUb3RrdWNobGxVcmxxODg2?=
 =?utf-8?B?ekJZWE1QNmRIb2dHT3lXTW01WlBWT0xORSsvV2lmMGhoenE4bjgxdFN1dTBI?=
 =?utf-8?B?RlVscXhra0ZTdC9ubXNMYldTQ1ZRR2ZJRHozM3B4bVdFRjk4TFdSRUxiMXJH?=
 =?utf-8?B?T2lML0tNUzNoUWZNU3lMRjNxK2EyNkJSa21ZS2ZOeWlFMjZTTGcwYWE1Uy9N?=
 =?utf-8?B?czNFb3ZXeEQ4emxkV01oYWtxWi9OeWdZVE5VRWl5b0ZtelE4MmVLUWs4TndJ?=
 =?utf-8?B?RkJSSXc4V2pYZVJFbDhQVEJsNUNERTlobTB4WXhOQlg2TUtPVU82YzJrclhk?=
 =?utf-8?B?WHJFNjhRZHJwWWVLcnFUTDE2Z3U3cTVGTDh1U0lBblo0S05Pb3JybXNlak5P?=
 =?utf-8?B?U05vVDVzajJGZ3U1dTBPYkx4emF6cTRZUWg3akhUcmdQZU9yN1puWWhOdTI2?=
 =?utf-8?B?T2VaUSs5RGNSUkE4TVoxM2VTSXl5ZkhWQXk3cHZlZXpFdzErVWVrZ0VuWUU2?=
 =?utf-8?B?ci9QMXV4UUt0UnlsamgrOG12cUd2V1Z2QWUrUXRVZWttcG1pZ3NncFpucndy?=
 =?utf-8?B?QXh1cHk3YjhwOENEZHVVcGpUaUhsNU9pZjN4elV1ZEx1QTdBeWUyRGJMOCtX?=
 =?utf-8?B?anRKTG1CdmkwTVNvTnNOcWxxZjN5YzQvVGNacDZmbDQyOWQyNHlHKy9LUk12?=
 =?utf-8?B?eEl2bUptcmpUdDI5ZEtjMCtERGNDS0dSa3BWVUtWcHQ0Y2lWUTdqTGkrVzR4?=
 =?utf-8?B?Y2lZbDcvWWFIaXZRVnluM3BoUGhhdGRFckZRNkE4QjVadStBdHh2Tmk1QTZ2?=
 =?utf-8?B?aERaTzRtanJ3QWQ2SXA3QnJPY2VyWEJBc3FIZzdGbUNIaTJmay9rWURrV1FU?=
 =?utf-8?B?VDk5M3RIclpQZEdqcytiNno3SXhpQWdpVURVMFRmdXdZaWhPUElyeXhZS01Z?=
 =?utf-8?B?VklaZ2dJZk85YjdJTVQzSy9qK0ZIdFdhYnNPdEd3OUY0bzd2U3h1TzJmazZO?=
 =?utf-8?B?V1hQbE5pQXFPMk14em1WaFVBZTNCa3pNdHY4bXg0cnhhNTVFV1Y0Wm5vUnBK?=
 =?utf-8?B?ZTNid3VNVE91d1JPVHRCK2Fzd3JMUHZ4VHZzdHdTc2hXRFJlRVptdXIwTFZO?=
 =?utf-8?B?VUdONXovcGFHQ1BGUGFxSExDUE1EajlQSTlQbmJwUVFLem56di9ZdjVleHF6?=
 =?utf-8?B?djFxU2N1NUU3V2pPNng3N3ZzNE5jb3dFakJnZGNjc2w2R0NadmY5VHljM0ZW?=
 =?utf-8?B?SlN6NVljYm00RHVkMkNQMlJiVU9YZGJBL0lZUEEwblg3QmFicUM3UzN0T3ph?=
 =?utf-8?B?VG1kYlpua1hOeGYvR0IvTW5Fc0E1Q0FML01tdnNNVjdnajhhclluV2txRkhK?=
 =?utf-8?B?d2JsQlVEQjBxd0pCQU1QRmdIdnVDMnhJeWwyVFRpRHoxOVNqb1RBeGN3QW9H?=
 =?utf-8?B?NHdMZnljT3RwY0x4b1l5ZmJoRk5uTnhrbDBpakxTNVcyRjRoekQ3aVdiVEVx?=
 =?utf-8?B?T0ZaWVVtTS9lQ2FoaUFIK2NWSkZ2UFRKaEVQRUpLQUowQ0hKMnNzTVlLVmJL?=
 =?utf-8?B?MUkwWGVjN1JKQTY4a0VCNDNoWGptVndTblhvc1ZHOVBMMkcwb0tOWWNEaXdh?=
 =?utf-8?B?bUt2VXRlZnhsV3E0c3pKRVBsUEN1YjF6aXBtR0xaMmpORitiWjQ1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23679928-612d-4c87-4bb5-08defec28f96
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 13:54:32.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c28ZGSvszN24fYk6ExoWASzzMB+L49hvIEbEVq7Lzmxe3z9cSZrM9/w9GAHHhalqU8vdRY38s/DfZQk/DCzIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

Hi Chung,

On 8/20/2026 11:55 AM, YH Chung wrote:
> Hi Krishna,
> 
> Thanks. I'd like to introduce Yu-Che Hsieh, who will be taking over the
> eSPI ownership and upstreaming work from the ASPEED's side.
> 
> As I'll be leaving ASPEED next week, Yu-Che will continue the discussion
> on the eSPI subsystem design. I've already briefed him on the current
> discussion and design considerations.
> 
> Yu-Che, please take it from here for the upcoming discussion and revisions.
> 
> Thanks again for all the discussion and guidance.

Thank you Chung for the valuable design inputs and best wishes for your 
next role.

Yu-Che, please share your thoughts or comments on the eSPI framework 
design whenever you are ready.

Thanks,
Krishna

> 
> Best regards,
> Yun Hsuan.

