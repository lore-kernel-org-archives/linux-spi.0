Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B5340407;
	Tue, 19 May 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201864; cv=fail; b=FauVxfkp+ID0QSSgO0acGR9kJC1awesmAwyEdCDuGG8JJMCR2Xgkd3+5v4XDvhNKTLPrBN4VT2bHvBroGNe/PZSYoYr8WC1bsxpbRvJlEibbV1TJQp6+g7iXlBSppY5zQ/6n0zSQ1aQSGo2GHlOi/Met/+8CE+28HqpmVv8uBYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201864; c=relaxed/simple;
	bh=wVfBAJWVvlF7hyw3ZwpHZmSVN9a8MwNy/L4/iIMMP7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KiZxVtpW9ie2G1M4e4YtZoYYigQWez9nO9zomk2T+trqMwb+PcgTbxO0ZMpXQD6XKTpapmJ8Ppq43NwiPIUDsoRFiK0AMxnhbo/bTKd4DKv90yj5IgEYN2ZDY6XZ6mcz3tVWd8asy6C41hKS666iq/oHBQ9bl4Ki+7ADuRHh5HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opTAlKc2; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="opTAlKc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNW03WQILXCu3TG+rxraB88zSpZSCI0zCMcYdNK7p/hvKI0zk+YaGzu7bEek4YcLHx2xcPaGnE6wIVOd7QC90DPYZnSk4ag64deUVIkXq40Kscg3+k8waNjm+y/+CXRVZhLb+jpEFQe5n94kpIKMMwULR6vPYJVbXVzVyBMQQVfq84Jqhby9mIhOHfhgwX6PX+t58odVPfLLzT73T4nfuN7j45Z2BeIUjwkFKLLh6SYhlkx4XH2TpdTChHEjl2Nd8wKynihx5QU+E4xVgFTmtbX2fe2ODKaWySjuFgTkHcbTyaoK3jQqrYMa+nNdMJHTXbdaA+qqIzQGfaJJ4VWTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdInfb5gfUmC8CLj8y7s0uBQCkA+1Q8N7KMSUQ6CwhA=;
 b=jq5qBTbYKDzZn0N8eAhGcZgpAqOiNpae8OPkwY+X/sdnjTXyusS78ZxzT4b0b875UqU0+uwWGBAZRDDfpRYHMbl2DSth/B6LAE2mqdvvkZP8XrqwXI7BwmUpfbo/COiOWf/+BVuUmlM+Atb18McJg6vuQKcmrYXOSzi1CrtuMPxgxqUg7GXUgxN1obIyklSV/yWDp0ts+JFRsHSAzbMgg7NWGyIdkDhu2cavBdYXLaS63/lu1AwlqFVLIhCShTsZDjcmoK6QT6Y1vC6X9MM7GEYWsWGGsq9AL1aFTj6GnLU0WtrBzB6npSqf1J8d4800fhjYZOB9CWU/guoRULrS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdInfb5gfUmC8CLj8y7s0uBQCkA+1Q8N7KMSUQ6CwhA=;
 b=opTAlKc2ItdXjlDSktqU4if62Ha/eLHlEqcukJP1vw4wbtrj5rtTcOgGp0Ect6juSBm0zaCVWDbTQTLYd3zFOsU4+BtV0s+YsEwhHj8inx+eF5GDjJPviv61YeZ88pEj/Ly9BI8q5c84CREosA1uPLyejnlIMuZp3izt16C8UAzooIOSTu7LCIK6M+CtU1uYqpWSefcCb19gibL0qAYAguHkMsCestjvesmn5HRXH/vvXShGlPH0yDiqw8/GFSp/iDQLp9BxFjybUdVD8lPp++m2+TDaNruSOXuUjJMWpWT+lde+3h21HU1pf93rllS+GmjPExovdTY1/RhCVhFwsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 14:44:02 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 14:44:02 +0000
Message-ID: <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com>
Date: Tue, 19 May 2026 15:43:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
To: webgeek1234@gmail.com, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::14) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 864897e7-bdd3-4595-f072-08deb5b51170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8kfWeMOTMvFpfjoBSK8gM+GTgUXs10T3/Ah8Ik2L4yl3Shi8+EbMYt2HWgijAYwtAu5/x1cVpJJwDIvRUZJDKG0BE/VBA725lk7GJX2O1t2ZzMN2JHxJ2NOkkqGxPB6iFw0f/PbtsvfGc2GSwGaJATEULEnDenTmIn8d1Z9skArkU4WhDSXkfGxmksJbHzznlDWX21oi5/jOACQO5+oS0xwEUUAswY4fQagDmmb1Tl/ULQAShKMGHHEHkfaf1ZYAv/N9E/2hr7Tv6rIVYsgR3PX0dJkt/cpnVayd0zZ61gvv3Oib9S2Ir0l28o3YckBSBAMy7Q1g1hY1D78oVTRHLeaMdySHtcl+NjBliorRtEQuJmDLu571ApAh0JPKP8uUD8/QEsRSJO+dlmhVj2q+NQBss5wR+hoybpejn2CygH3jAZhyO5tB/2bgBV1itJMDY/jNc/CMy3ZOzNl5TIkQeWCNI4IKpgElIeYaHOaClyX3y8Lqmm7cRDsmHnNR7yo5YOueim4eaY+9AhKnW5vbWvLgcDHr86kkCP5fUr/ntBAqyBLFGZ8dPEWHiqcerCuNfg6VmE0cl9udWWA0MvSyKmgl3TphTZS05TJtQaBz1TMMrAmmv31PSudMSoRnphK6AwoN4Rh6twqSXHFieOvXhDZn5g6810OKeMsSBUl9+ytZKwqdpazDowS7KNbcasLZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXJQVnpXc0F0RVdDL05WNjJKNGVVTEtkTWtnZlBLRzFwUFVMbHZFKzdmdzFN?=
 =?utf-8?B?SlN5andqUnFCVmhFMlFhNHlWdVpSMGg4SHpmcWM3dzZ3bGdQOUNiUWpZQXIw?=
 =?utf-8?B?SU5RTkVaQmY4M0FYYWw0YkZyWWJEQW5TU3BDc3ZENUxyUTNqeUNEcERMckhr?=
 =?utf-8?B?NmwyQnl5cFNkdlZtSitGT2lXQSttTDJZMUwxaTZKRTdNYnhYSnpTSEpIK0pY?=
 =?utf-8?B?Uk52V0ZCampjQmtUR28vcFdwU29reTZiL2c2Q25xbFhUYzlqNXo1c2o3b2JR?=
 =?utf-8?B?cG9peUIzMExLVlBmL2x5RGVoVEdXUjN6aDZ1WWxXS2JJR1VRbGFBVE9HNDhS?=
 =?utf-8?B?UkM1MlBVTmN1dTRiN2RFZldYRDJVR0tKOXhxZFNQMXhBRE5mc2dmVlFZYVhO?=
 =?utf-8?B?RWw4a1p1bEpWSW0yT0dkRG1xdXVFYnBuNW9SZVNyNXZkdzkyU3pqUTNpMG1C?=
 =?utf-8?B?UEN1SnlmRm1xNnUyU0lMQ0NVQU1KMDNWVWRiK0RwS2VmWjE5WFJsU0hwaUJB?=
 =?utf-8?B?d01ycHNKeDB1b0dWQysvSlJrMGtoVEdsemM1Z2xZMmZSZndXVVFQUEowek01?=
 =?utf-8?B?U01KbjI1VkxlT0x5MXdDbTM5WWFKbStxTzRveEo2c09hVzlLRmJFTUtMdE9t?=
 =?utf-8?B?MVljdkduMy9zd0lrRWhPSHFOY0NsYkI2UU5TcU41V2tDbm9DTXl3RGFrRXBC?=
 =?utf-8?B?ck80aXJ6WXJQeGttcHpjdkcyYWlkbGpwMEFCa2ZNTGJ4NlNqM2E1UDBCTkU1?=
 =?utf-8?B?bGlndHVZcm5IcnJvcVRuaUpCRTAzUFRZYVRMb21IREh0OXhCbVhHWndZYzlp?=
 =?utf-8?B?cmN5OHA3alRldHYwTnozMXRiL1pGM1JMZmxZZXlhWUkyc0p1R21KdDlOWWRs?=
 =?utf-8?B?Zk1DVnhnbzErc1Z4ZmhJek02OW8vNTFxQ0tPUjZqMG9adEc0QStvWWlPZGxR?=
 =?utf-8?B?RnF1UEFXdU5reUdYRXFiNGs1VnBhVlFNYjEvQ1JyekNJZ3JSV1JBS1VOMGhv?=
 =?utf-8?B?eDVUMVhHbzNGcDgvZ2g0U2o3OERURFJvMExDZ2F4dHlnS0ZDZ0dtOXgvMnlS?=
 =?utf-8?B?Y0ZtbVc4UWx5enpmSUFkeXI1TnZJemt5bEJOVUt0TXZ6Q1UwV0xkWHpyZ0c4?=
 =?utf-8?B?WU9JWkpDM1pqd3c3VzVXVWk3c2srWXZ2TEs0ZndDVThCTU5ZdzJHSDdTQ2hh?=
 =?utf-8?B?ZWx3alY3UGNVZTZDbTVZNncrV3Fyb0xUVnJJMnpmczVkQU5rY1R6YzU5d28r?=
 =?utf-8?B?SCs4Y3A5QVd6aG9tL0lDeFNxWFJ4YmdlR0NXWS9mRFQxeUdIMGsxK1dOc0Rl?=
 =?utf-8?B?V2xwVWZxMitoVnllcEYvZCtsUHUxR0lWUXpUQ2tZZ0Y2amoyN1lKeG5rM0hI?=
 =?utf-8?B?OXFtekFWd0NmMWhkaUJxRlErU1ZPVUpKakJSZGIvZXFzbFZmVml5RTlVbHlw?=
 =?utf-8?B?dXlsWXdOekRlVUR5NmNyeWNlODNhQmFuUlRYRnZiMU0zaUhCUEJOd0JNMitT?=
 =?utf-8?B?S0dBdzd0Qkt5ZWZrcDlEb0hRazFRWjdFb2hWMkIrc2xVTU9WNlB0RGhwdzVr?=
 =?utf-8?B?MURhRjM3cnBvbDFwZ3NOckhUYWNrMWROTVU5dUhYZU52cTc0anFacVVTaDk0?=
 =?utf-8?B?QXpqVFh5STZuR3ZKTGplT3ljUU9aVXcrRnArQWNTanlFK09iNjZkYXk1TTdh?=
 =?utf-8?B?ckZJZlh4bGIwMWlWVDRRRGpVM2JHUHVKZS9LWE5nYnQ0OENlbWd0ZU4vYm1C?=
 =?utf-8?B?MERzb1RRYTcrbEpIank0aUY4OE5pRmdTMGdQczdWa1Q1TXRwWUVzbmswd1Bm?=
 =?utf-8?B?S0tBcTVKRGFIV29xNTRDRmhxRGVLbXovbDIrNTcrR3JHVEJadG04cmxPWHVh?=
 =?utf-8?B?Nml4T1Z6RXFBYmQrT2tTSEFwdVRFLzhLSHJudkx3T1JJRE9lNlVrbjg3dG1F?=
 =?utf-8?B?dTk4MDBzSGMrN2VLSnkwTFVtb2EwMys0NTVDazBmNXlEN3hXV1J5MEpNY1Bm?=
 =?utf-8?B?QWFSbVNOVURkNjlvRXhVOWdXY0V0cys3M0hYVUNaQjBKOU5Ya3RQMWcvOHFu?=
 =?utf-8?B?RlgxNGwrSDdwNGZUR2JPZWs5cXdzS2hhcktaYTZqaGpzMkRiUTVpcW9iNHMr?=
 =?utf-8?B?ZjBhTVVtTy9KWnNsN1VVeUo0OXd0RVFmbE0vdGdxLzlIS0hKYy9VR09rc3dC?=
 =?utf-8?B?ZkY5YWdHZVI5d2x2Y082MXZ1NVVaVFVvYUl4a1VDZHZya0lHSG1qWjdQbnNG?=
 =?utf-8?B?ajU4bUVaMFl0ZTRzb1dZUFFyRGJjeC92VjdCQzRDU0VNUTF5empaQzQ4TlZn?=
 =?utf-8?B?Skt4VmRQSXh5V09ES1N4VFJmS3lML0FjWitBZFBZVWNvVERqS0dTZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864897e7-bdd3-4595-f072-08deb5b51170
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:44:02.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c34NsWNDd5E8SSnTBCK3PGtvFNMLo3P+IFD7i+7HYRHTjFMhF4fkwjxYyCATdeRY4jnw1+g0bo0sqIcrflDvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169


On 15/05/2026 21:35, Aaron Kling via B4 Relay wrote:
> The reason for this is to properly support the spi nor chip on the
> Jetson Xavier NX module. Prior to this, it would time out on all
> transfers and sometimes even trigger a cbb fault, locking up the entire
> unit. With this, reading and writing to the flash memory works as
> expected.

What kernel's do you see this on? With the latest mainline/-next I do 
see ...

  tegra-qspi 3270000.spi: cannot use DMA: -19
  tegra-qspi 3270000.spi: falling back to PIO

But I don't see the crash. However, on linux-6.1.y I do see the crash ...

  tegra-qspi 3270000.spi: cannot use DMA: -19
  tegra-qspi 3270000.spi: falling back to PIO
  tegra-qspi 3270000.spi: transfer timeout
  tegra-qspi 3270000.spi: error in transfer, fifo status 0x20400006
  CPU:0, Error: cbb-noc@2300000, irq=15

So I believe recent upstream changes in the Tegra210 QSPI driver have 
fixed this.

This series does fix the issue on linux-6.1.y but I believe that is 
because this is really enabling DMA support and so PIO is still broken. 
Ideally, PIO should work if DMA support is missing in device-tree.

IMO this series simply enables DMA support. May be we should clarify 
this in the commit message, but otherwise, I am fine with these changes.

Jon

-- 
nvpublic

