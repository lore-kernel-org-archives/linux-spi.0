Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8D2E2286;
	Tue, 19 May 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219301; cv=fail; b=U/z47zZuTmztOCL6nYUa1eU6/hYbzRFoO+p02nL2KiEowxKEGj2WZp7wdWD1b/Bkdnlc3SDFJPmcERSfZ3hmLCPv2MAAvff98Kzp0eStdv95AeUZHdW4S5A+99zTgcHZxVU2KZRvoLBzbyzUoT04DlCMFsFmRP182WQmYbbbC8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219301; c=relaxed/simple;
	bh=uuV4JyEauTzsIl6XGNbEsyJCzDxWnLyFYRClvvLt3XE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0NAStV4juFEPZDKUMFdhA2Txt5GO9dij3hHx/ky8HL7ptD9Wz9Sy/X/gU7tBnrVpMc6k7dotW4XaPR1/6u6AKJCJVRjbaQi66BrIOovEiSKwRIuTIdbSspVXpzdNNSfeHtInyjA/82G0iRE/Pm/lLtXFuRkrFohrXGZejz8ms8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jf86CetN; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jf86CetN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOYs/gm41cTnjsJQBB7jUbhnv+6WOvKqsHTno0h76UYkHQFoc7p47RQfWtZIh3QuB8/sPLwErlTfY6AEiUuDlxvlW2+pQQ8bcZ0GhjLRodNRg8A9uhYn9MJREEzqif/3msGJR0hw4krZMTQUZXmi+HFQ7Mmr5huGFSFLSLQ2CsMdka5caO+dbMrx0W68HBQnXo5JHakrC99CVomVCkttkXGJJHuCg07gdqldpG+0GOjkNLY+pBcH6c4rDD37m3lp+Xj7JasZHxpZsBbJTH4UtHmzV9XPx5fRIYsGJQ3YomJL3lo5HYPq2mMSDMLtgX7XOwu+5S5lBQ7r1XCbglokJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abGOxz4qSVnAOwDkGGPtbSvJVnATx3CD4iHpgxtq6Xw=;
 b=gDsGfIes3xB+TvLTDhTrila7g+kAnKj7umfjQa29cta1A+GByCIEV9mfrO5Tfa6g2NXCGbVRA/YkpDvdKhodn45lwy198X2k4TltoIiLF6Eb47K8sMUqmf6EozXRveKrzn0Qhx8gh+jPX9Wl22AqDgi7v69reLm8tfR/f2o5D+gN9BZ6uZYnuziq9wNBn0R0Hsi+gEcxmd/ansQQp0SUg+2PwnLZ7yhXMJP0h+xoM63u2sB2DcCzFRCSc7AOlQYaFud3NiI/ieDtFFxO16LOJCGTIxnK4FTyVxs051LRpuuX8mBZAG+0SqfEL/ujoLR6JvVctuBe5AKAeeOCtF2jjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abGOxz4qSVnAOwDkGGPtbSvJVnATx3CD4iHpgxtq6Xw=;
 b=jf86CetNyB2tYtrcCxwrLnIeLLjjYzZo7WOMEg8/9YWbqccEqV6qkOTn7IvEnBl9zuapxJBe4uZ0z2Z9VAcfZvNeD7TBOsVnBorA0X4GcOwhem1NGJojWU29d8OfUAIVoMc+azca7AUUzYwBXbGllD7MJs+Ulg0Jsmd6rTvRUx7ldPjzSPOOsaw1GGXXTAnLtfaERzyP8ANyjecLZBOzTXsgNPs9qc9/AhRbfdmq0DzajnvTFA8oytmHtkFbjS37CNC92gNT9oLuSzu8atVIaav2MwKUEeVEmH3T6SRjroVvm3PmkS4J6DyI0WWBmprkumklR/z07hi/a9KD8LmRxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 19:34:55 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 19:34:55 +0000
Message-ID: <5f9c2088-4dbe-4b4d-8702-aa698dbbec0c@nvidia.com>
Date: Tue, 19 May 2026 20:34:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com>
 <91fc534a-6529-4880-8c92-a8713118242d@nvidia.com>
 <CALHNRZ_Ke_pC4tept4_vGOB0ArwjcaMu=mc=wJrQ0x79MKid-A@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALHNRZ_Ke_pC4tept4_vGOB0ArwjcaMu=mc=wJrQ0x79MKid-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0176.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::16) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: edca4a62-2fec-4580-23a1-08deb5ddb450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	bmXzl/2EbhzeqchTIQUDCRSfkWLrZAhUn67qr1VKuuJHHs1TSg5JQEWM8YoFpXuYSOLNol0UWzbe4ilTZTklFNvuaG7DhTDNpoiu2Qb4Ut3+HrpafRNyVpIDACq9PGRS5OisUOLpP9v9T1YjCzCWQjLnaufSPYVDwxYRYMwF2+NU1ke81ZqmLiqP2oZnQlsMMcWvETJupGOrFZkqQmMO+hJKQq3PS8uQU4jhCjom8C8G1VZEroykJYaIYydgGeLL9TwiCKwNz7J3z5LQ6vlVUevQ5ylbO6kYMfaWGZBJZBuW0W/W9lTSv5toOyLbnPS55zobBrAiCY/089eFbZGnonHxdNPVedtwiO1q/tXCiTwXrcf5NPEIz6GApTr4vTtPmPglLVrfp1JVC2slvEVzcyjMVOPcg6H1ohqklBujXxU6qUKFOUeXyPthn/ttmr5S+Y6N+BIoZBwaT0qYYSz9aoGnHlgc7zcOTlmoD9pNtBmfblQ5sHaPKI7kWCE0fByrhwn2FhGCSrSBPwFKeZXtrcgVXU5ToZB/c/eKtOz3rBWfTSFx3IG7uzesLIfcOKQ+mBr3goj+mdqtvmckFv///dw0RzWIL/RCau3UMvTOWVzjxV6kspuhtqRVVEMK1VLHNAi0WGY6P3RGw9kQx5ye5LRxL9NOP4fRxgyVJ+W1hLxRbzLPW0ksKwZAFqST+fsP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um5paENHZktQcGZYNWtyR3JFRm1XRythYk9VOWxBc2kweTlXbU9CdEtnVThu?=
 =?utf-8?B?dnJXQUR6QUNTTGZXUXNYWUxxRU1zQkwvQk1ISko3cFh3VU5sTEs5SStaWnl1?=
 =?utf-8?B?Qzd0dDVtTFFBdmh2UW1MdVExTXRoR0hqRy85ZkRoc2ZaWjNzSzVKdzEyMitn?=
 =?utf-8?B?emFtRUt1UDFUQ2l5dE1WL2xkNytNb3ZqTkRFcXpValhMc1liRGRGZU0rN29q?=
 =?utf-8?B?bFZGcXlsSUs4WnlLdVU5SXFtci83VjdTSzRoNXRYTGtDRUpyamNqYmVJbk8y?=
 =?utf-8?B?ZHVJNlJYbTJXN1FOUm0zbnVwMk5KMWk1VWFrS0ZSTmo4S01iOTN6NUFuY1hT?=
 =?utf-8?B?dWtoRXUzTkNJT282UUFKcVhLNDdHN29WL0FXTHZDZmNyNnh3WUpKQU9wLzJN?=
 =?utf-8?B?Q2NUWFBRSElZZ3pjdXpDNkI2QWlHQks1dUk3cDhsbXVZZncwQW40cVJ4cGdj?=
 =?utf-8?B?QzQ0dGl0Y2huMkUrd0w5YzROcVNEdVI0anloa0QvSmFNb2lmU21xcm1FNFhy?=
 =?utf-8?B?UzIrQ2w3WDJVZXRsL1RteW1SUHN3MDdqNWRyZ0ZBalB1dEhaZkhUQ2JrSkky?=
 =?utf-8?B?N2NOQUltVWJ4Vzd5WEdVTVFPclBkQXFyb0h1Mzg5bW1IZ092bzZtZjFQVGxv?=
 =?utf-8?B?TGFMUW1GMG1EVTBaSzVzVjNMbnVuZ0RmWVBUVUVScyt3akhoV25zVkFwMHIy?=
 =?utf-8?B?ZTRwendmdDRLbzc3VHZWNkp6V2JhVi83Zi9UUXM3SVcydFdRNllyNE90aDAr?=
 =?utf-8?B?SkFIUW1vMXpqaHdLRzVrUHZ5MmhUaHZsdVlGWEk4bGJnS3B6b2FKdUZJMGEv?=
 =?utf-8?B?dTJNbTErVGNkbTh4VFJtbDZTWFUyK0ZiMy91Z092RGd4cFNGb1JxRjhTWkU5?=
 =?utf-8?B?ZEl0M3E1ZzVDcUFpd3lLaWZBSXh1OVNaUERxN255TEc4ZHRXS0xBaFpBTWZ1?=
 =?utf-8?B?ZllDWGtyV1A2dUtWQ1JsdGkwY1BrNy9NVW1la3RYTjdiM1kwTVIrWnc4Mm9E?=
 =?utf-8?B?RkhFQ1hpRHBYLytKRjl4RUZhZlo1OXNSNUtqZVNESDgwMG53VHJ2QklzZU5D?=
 =?utf-8?B?cXZodm9sZDBNWmNqeEtDTENpN2p6aGkyeGt0ZmVqdG44aDJxQkRXRVNud3pi?=
 =?utf-8?B?T3p0STM0cDA2VHRjVGd0T1YwY01tVkRBdjRUSEwySkdyYU1BYjNoempQTEJO?=
 =?utf-8?B?QWZSZ1ZpdFZIMXVlRnhRdTBxU1NlTE9mTlZxQlpORVRqTVFUdS9OaTlBMmlM?=
 =?utf-8?B?aU44My9HeDNpM3l4K1hmaVMydGI4RjlHNiszNTRKYTdDanRCZ3hjcEJxSCtw?=
 =?utf-8?B?c1R0c2NjcTFUR2dFRlgxYkp4RnVnZ2RCOG03WDU5T3VBbzdaaWZYYlp1OGVP?=
 =?utf-8?B?WWxrTWtSWWRMYk5PSlQ5RVZQUyt6YVNGalg0cVlwMEJJUDZNZUdzQ3ZaME8w?=
 =?utf-8?B?K1llZGF2cjdsMWxqWTFNeTI0OHRCOVVyeU1WUDkyQzBrS0lkd3hjMTg4VEw5?=
 =?utf-8?B?Q281Qm9xZWY3dW54U1k3aytoK0lWN0cwRFEwdzlaM1pQazdDdXdtM1dhRnkr?=
 =?utf-8?B?TGlXWC9NVGFwa016bzc2My9HZnpuWFRlamY3dy9YYUozVEVOTFJaRjdFZnRT?=
 =?utf-8?B?MjdCV2x4bGRWWk9NWXNvL1FZZHlEdjdOS2Y4WkdOckIwTXJVNkJNTGpFOWV2?=
 =?utf-8?B?RDFFcFdtYzkvbUJIeFZJd0VZRFNQMys4Z05FZ3IxcnYxejJYbnNhR09DUGts?=
 =?utf-8?B?aDhSeFpvQy91VXg5YWNBS0RtVTFmcXpvWWRxbFh2R1F6K3loZEFTZDJERTdj?=
 =?utf-8?B?cmhYZ3JNNXNTMUY5bkRRU2pocnBVRGRiZi9XRUtic1d5OWt1enlpb2FxT0JW?=
 =?utf-8?B?ODcwZWs2RXhENjVMRnoxb2svc0ttQ1I0VUZEVS9YNmRHMmdRYzdrdHpZNGkx?=
 =?utf-8?B?QVpvR0JDVGVWVXZUNHJxakhkWU5Ba04xTkNmeTNxcDhpdTBKNXJSd0dzN3Rh?=
 =?utf-8?B?TjN5WldDeDVPVXljWld1L3pTYUR0clB6bVdkZ2t1aEw0b1ErcW9SWG1aT1dM?=
 =?utf-8?B?OUtiNWZPUWl2TXFxKzRiSmhUMkZycmh1YUJjdmQzNXZ1MklyY0JKQWFvMGhG?=
 =?utf-8?B?UUpJbldLbm1WQjNLVWgyWStaRktHTnJsQi9ONTJoa3NLRi91UjJXWUdXTWJk?=
 =?utf-8?B?L2FHKzZTcnNUQUFGMlp4NEJ1RjNZcWhUdzV6ODNYaHJNTFZRWVNOaDBSczdJ?=
 =?utf-8?B?OVBhbTU4cnpGSGVTeWpCdmpoMXpJOVUyVkFqQnJtUlBFZ0xoRElFNjJ3OE9X?=
 =?utf-8?B?cGpOVzJnTzdoRk1QcnJGRC9QNVBWR0RiYkJBaXRNUzh4UFUyMW1vYWZPSDlV?=
 =?utf-8?Q?FpCGWABSctXLR1jjPfxDN3uxayHvUHgAhV0yc6/ra4Eu3?=
X-MS-Exchange-AntiSpam-MessageData-1: rzrOEbCSFxgGMA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edca4a62-2fec-4580-23a1-08deb5ddb450
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 19:34:55.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSVV3goMsprDr9KDRYHI3jNCa1/qx5yN2+E9eQFA7zXVTz+TqdUzu0H0fdsQmPLvYjaVnIuRvmWmKIqBPOWaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058


On 19/05/2026 17:48, Aaron Kling wrote:

...

>> BTW, that said. This is a much simpler way to avoid the hang on earlier
>> kernels. So I would be happy to get this merged and backport to stable
>> as a fix. Again may be we just need to clarify this a bit more in the
>> commit message.
> 
> I could update the commit message to be more like 'Enable DMA support
> for Tegra194 QSPI', sure.

We should still describe in the commit message that this is also prevent 
a hang/crash from occurring that is being observed with PIO mode to give 
the full picture.

Jon

-- 
nvpublic

