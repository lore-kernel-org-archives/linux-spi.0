Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C7347529;
	Mon, 22 Jun 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154717; cv=fail; b=VwOAHu1Aq/9AxuiUY7m7fdlqsaNsioUF3oGiGysKA4T7JPi6wjBM/z57PMaNyu08fWV1ApaIBT1FgY38CIY1JqpoCVYccXHLKyD3xaIEr1E1t46f1GLE1ju5J86gohXMd+VdY97dq0iTaddPo6OEYQMIlQCz4IbPPBvUw6RuJQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154717; c=relaxed/simple;
	bh=IzMV1b/PTTpR0zLFWIls4piWMnwrEHo3IZkJ0h9lNmM=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=a0Im8uyjnCi16u4AtLok052vHWvtIzTUtMUcSMyQlkVvPYQDU2ZMfSYCgks4fRQyQVsKTgmZwkJnrSppFBcHeHAqxydbwqi3hp0kEMyALgrW0Kfut7E5kCs8U2pAr/qaGAL/LEwaCRjUOGonNTnBy2SWV4fPjYuEDtHiPhh6Swk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ulTx+R6m; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ulTx+R6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf92Ec2z0PK1fx95OtiVUUZaYbCOx++eP6dfDzCcnd4vPCWIUQA5D+RHGUtIzc7xBdWsjN4DzmoPXQPPUfIA8phvjPr5nWmv7Htz+RUraWHzB+Le6hf581BYnR03accFo0LytqGvRVfLViPx3hbK2yGqEETUWTYNjQeon83BNwPvReUsbRPJpscQAqW/d2xVRfgsZQzc20wvNZlKFWygGJTaWfAfUWgQvWbklo27tLB0iLblQuirgy92qBkYDRI8x9Bk9CcBRCFVN05XDeBYvmc1XevRwKy6N/ulLSBuDcrc3Fqc1y4894lsP6n43fT/6i7hafwHdiGYF3W9Sg041A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=criEjGZaF43SoZ93bOwSOnlW2mBhvol3rEX39DM6xW8=;
 b=gb3go/2NiqTiZnq16IlKvJf3PjJmOB0GxPvR4Veb4S/63WEnBkBcmDf5qwCnum4LEbtax6FLN0sntyt1y1i9rmHfiD9jLDgDQhqyO6zgJvCyQqb9y9Jmkhyn2EFvH/RR7FANtX9/wpLBo5WrVO8pyIl0IePgL5dWf60Y/utrqhPKjhBBXFTI6VsE9GEdr7MnSJh34vAVkQqsAhxTEZOdWRcuYMEjjSGArKiJRhv+Py7qhOdoXJnq3mJyuuqUvrGG1sL8r2ikpdmz+4t42e5r+jjiWnviZHGS5Fv/LjCI/BwMablVx/2TUEY0boNVZO6Y6jFbiOheLX/8zDeap1KNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=criEjGZaF43SoZ93bOwSOnlW2mBhvol3rEX39DM6xW8=;
 b=ulTx+R6m86tw6d4rLE0SGUpzgz9Pb7X1Mq24pQx4r3cS7u49i4Z0ToKBDbb7lyGbMz1RrVNMhrLHWR/ZJCBoS58NTfa/1aHF7jmkOSyRMEAi/ScmgPBp51QkGOAX0zD3APpXeJeofcTB9WIcZC77K1Q1ehPdIeEsnGlFCjOljos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 18:58:30 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 18:58:30 +0000
Message-ID: <9548669c-7d3c-4053-b28b-c82490c0c2b8@amd.com>
Date: Tue, 23 Jun 2026 00:28:25 +0530
User-Agent: Mozilla Thunderbird
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
Subject: [RFC] eSPI: Exploring support and possible options in Linux
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0201.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::9) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 74996344-9ca1-4fcc-b8f8-08ded090405e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	t826Flglr8eJ7nrCLpfWvtFVO5+QwKOrt91MFtgyY3BnkZvho68dkgcgOnsHc7dID3hyJb3RoZRQ58ot1MmYTZTYo5wNdDuBr2plkLHgDQnWLlM/Ciw82kZrWrTZNde8Y6+nC6kYNZFx6hgoD4/j23O8HMCVCZ7OnQGhTwPj622j8ipHiDfA2E1dXmaZmpb7iT6GIpH46B7ZLJmfwBsM728UF/H2OcsGF1EwFzwDuq/UKaUdMgOCnglV0Vcbxtrm32fWpaW4OY7yVW8EPWBKNiN1/Smrwxj1fGTpzrhFMwuqQ7JHtCvi4BidGwKSAIPYrfsnQ5s2UXASvDTWu//fWiq760UGwvwwLXg0FV2HShHnGXCltSU/zHTB3HdiJnIchxv+331nk2QmSj1GobnjHk8f8i4h/emqETrxHL3GsZowUqrNLObcZMUa9FT740uhhCzi43hPaXdfpaXHoc/CgDrsPRuuexzQGb0z4laUsP80j2BNzcYp0Bm52y51EYyLRPp5Iy7QdRHW4IGZdt97rNqSRp+vWSdcrrFu7Du6UNJBKXGkYSc8CMnB8oTykJUlktkbrt/ooZ60U0uEXMjR6E3QdkSTlvCSB/9xYx9UsESm6wp35E5H6WYG6e5xn+K2n6LBjmx0Uilo7Bd+/eSISh7nmS022mT+TIa4y3/2yZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZIWWZ0TXp3cDh5WEswd0htKy9TNEVic2VpK2J2Z0hWWWN6UUsrYlVtTit1?=
 =?utf-8?B?UWVWT25zYm05bGFKNlVMYTF0QXZFWDBEQlFBYmh4bXFsWWhrajZuQnN0SEtq?=
 =?utf-8?B?ZXR6RXByOEQvRDZPdzFEK3I0eE9MdnVZUnpIM2IvMnFDUmpLc0ExWTR4S3cy?=
 =?utf-8?B?eXBnMmtRMEk4eW5oK3FEUFVlekhHRkpaeGwwNTEybmNvbGJabVhZWVQ2azdn?=
 =?utf-8?B?RGpPdWFYZWVuVmoyRSt1UWZtSW1sMnF5dTkyMlBYY05RQWlwUGhObEwrSlcz?=
 =?utf-8?B?TjY0TDNxbDc4Sm8zNS9aTjNobUpIcGtIaC9neC9YZVpkMVY5eTU4bFphUUxI?=
 =?utf-8?B?ZHpEOGRkU2tCUnlsaWxzL1YyS21XUzN0T3ZqR3QwRHB4eitlVjZEckVpZHRO?=
 =?utf-8?B?YTFuTUlxOU1KRzBrQ0x3NUVvTXEwWHNOQTBaaGthWHJ1aEg0REE5d251eFFo?=
 =?utf-8?B?MWNJT3E3UmNPNGlpMWxMdVh5NmxacDVJeGNBaXhudDhvSmdraFc4cENYcEF0?=
 =?utf-8?B?WW1HQkIyR1lJMUFCZTg0NEV1R2xyV040V2tKZDNFN3lFUnNNWlhLTVlBd2lz?=
 =?utf-8?B?aG8za0RHVXZSOWRJMmRyM251ZyswdHZCZy8xTHI5NXRDR1NDMGFtL3l4aC94?=
 =?utf-8?B?WDUzNHFJcGhSRTl3VTlCMmlMN2xOcDhNUmE2d2VpbHFUaVd4eGpWOWlnSk1F?=
 =?utf-8?B?Vy9OOFd3T2MvbVBPZTh6UmswNEZYRllFQnA3UElrOEJ0dkhwOU1sOUhkbGw0?=
 =?utf-8?B?RWRPQ1Y4L3UwU24rUndCVUMvMGVMSG8wRHdVbUpQNGNCT3VWWlZtTnZZekNH?=
 =?utf-8?B?a1p4eWtOa1JueW9jaVA3WC9xd1l4clZIajBLU3cxTmM5VnNPSGVwS2FONUVm?=
 =?utf-8?B?NnlOLy9wYzZQekU5YnV3c3c3M1JuUmFvb2pPa0hPclZ4bXE3UGxOSUx0TE5C?=
 =?utf-8?B?WUFOZkZ5WGd3KzRoNW1RdWl0aUl0QmxHczYzNVRuTnNBbDBDbVE0NmVyTFIy?=
 =?utf-8?B?L3B6SFhCeUVaQVlrbnp5UHQ3Y3J6ZGowTmZtWUlJbDBlaFZyUkJwOVJZaUJ5?=
 =?utf-8?B?d0dCQTAwUzZRdE1zR2tnb1YvNHJYL0V2OThzUURrY2hOZGtwbHlKUkl1Q0N1?=
 =?utf-8?B?T3RQc0ZucEVDQlNmZjVJenB1aHFHQ0dkRDVlWFF3UXVoMW9BRlpsTXIxeU1D?=
 =?utf-8?B?NVhyKzN4bGlRaUF2UXdTR0dJTXNiRmVPTEw2cU9MSXdDUkFzVzBCaHpQek1H?=
 =?utf-8?B?TmZ0ZG5VRW5kaUZPOGtEQXRFTFplTGFOUmRwRERpZE5JQkk0VFYzeHFJSEEw?=
 =?utf-8?B?NmZnM3plOWRhUGl0MkVySDI0c1hsWUtsTkt1c0p1R0RCcS9uN3kxQjlMVkh5?=
 =?utf-8?B?ZWVPaXhyZTl3eUhQUXY1T0x0YUNYTk13L2FiOVRUT3dnaEU0V1p6QWRESWVp?=
 =?utf-8?B?d0ZrMFlMS01PaGxuS1lpUEhCMVJRc1NMS3l1ZEVuMVFWRHA1WU9PS1I2S2Ur?=
 =?utf-8?B?bW84bUlsTWpaRmFPN3ViK295UUpVS2lNUGFkeUw1QjNlV2JVZXJTT0ZNc3FO?=
 =?utf-8?B?U0duaGdydkFONy83ZzF3WjdZOHhoQUZsMUV6TlRzSTlGL0EwNnU0Z1orTDF4?=
 =?utf-8?B?ZGlNdDh0TU5DZlNxQm85V0JacS9JYzM3QjQwUVRiMEFqRHBNU2NXcWoyRkpu?=
 =?utf-8?B?bW00d2QwTEdvdEhhd0dVNlpzeGloNmZldU5iMk0rV3lJYUxIWGc4THVYd0hq?=
 =?utf-8?B?QTMvcTBxNXIzbVZCOVFDTGJzZEdqQVkyVkVPaTd0eFcvMXVlaldCUmhQZytH?=
 =?utf-8?B?WXJraUNpbzIwbHZPLzVxVUdma1BRbldKc0tXOVFkdS9zZTN1MlZyWWpvdnpv?=
 =?utf-8?B?Vi9raTlpa2F2THMxUmVzemg2MGdwcFN4Ulo0aG1ySHp2ekVDNFdZeGg0dlhK?=
 =?utf-8?B?OE0wa2QwajhEMHJXV3hiQnBTMnpsMUZJc0RDKzR4aXBseEJRalNCaTJKd2xm?=
 =?utf-8?B?VE5iV2ZFYnkyTjVYZlhsaWpQMHVnVlh3SjZ0dG8yMnVqOTZQWklHcVcxQUlB?=
 =?utf-8?B?V044T0RsejVGaExDL0crREsvVTdheWJOVmR4WFlKWWo2N3d3d3h2OG9tQVNY?=
 =?utf-8?B?UzlHajNaVlRhd3Vza3k2aXJWM3ozTHBlQm4reFZlRGUzUUM2NzJnRlluZzRp?=
 =?utf-8?B?SnJFaE9YYTBJSzdCUGhEeWJVZE4rWVd6bHVXeTJpeFRFRUVJVWI4OXY1Qm4v?=
 =?utf-8?B?d0MrZ2FKekx3TDBwV2p5U1JnNWtodmYzZkR1MnMydkhlMFBHdTlFemdLSERl?=
 =?utf-8?B?K2xtQ0RUQzI1SUg3aUk0cUtlTHFpZ0JuK3hhVUE0eWxtc3Q3UjZDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74996344-9ca1-4fcc-b8f8-08ded090405e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 18:58:30.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux5DN5JcuNepAhkRNyJpDSnLBjdUU+xOxLFllaBjuKKybWzJQ5UXC18OlyKp6je8cxaWKUE52wx71CbkansPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

Hi All,

I would like to start a discussion around the growing need for eSPI 
support in Linux, particularly on AMD platforms.

We are seeing increasing adoption of eSPI for multiple use cases beyond 
flash access, including channel-specific functionality such as 
Peripheral, Virtual Wire, and OOB communication. In some of our initial 
work, we explored extending the existing SPI subsystem to support parts 
of these requirements. While this works for certain cases, it also 
exposes some limitations as additional eSPI functionality and 
integrations are introduced.

Unlike traditional SPI transfers, eSPI provides a more structured 
protocol with multiple logical channels, negotiated capabilities, 
message-oriented communication, and asynchronous events. Because of 
this, some of the newer eSPI use cases do not appear to fit naturally 
into the SPI subsystem model.

As more channel-specific functionality is being adopted, I wanted to 
understand whether the current direction of extending SPI is the 
preferred long-term approach, or if there are alternative kernel 
abstractions/frameworks that may be better suited for handling eSPI 
semantics.

I would appreciate any feedback or pointers from the community, 
particularly around the following:

   * Whether there has been any prior work, RFCs, discussions, or
     attempts toward generic eSPI framework support in Linux.
   * Would continuing to extend SPI be the recommended approach, or are
     there other subsystem models that may fit better?
   * Any historical context, architectural considerations, or lessons
     learned from previous attempts in this area.

Any guidance or suggestions would be very helpful in understanding the 
right direction for supporting these evolving eSPI use cases.

Thanks in advance for your time and feedback.

Thanks,
Krishna

