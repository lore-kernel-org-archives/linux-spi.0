Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793190184;
	b=hzmYoMrZsP8S++jcLRIIF+DMQrWQOBFrQJcQls1CjVTD1o/eEL08fogS1M5PGJnGSi7L
	 f2grZzshgK4k/VxNRlNl4FH8BKgfHzVCa3Z/pJ9PyIjyT5M5bn+4isvPgtjMmkB9bsqyw
	 mW6+cvq1LoCNzXycCDU8hdgDTmE7zYRWHMzt2X9kOUzgZnhmLIYLMKsIga4ft9tqTzy19
	 cYTA7GPFrrgrA9+FRdq1J184zEgFPj/l/OMnAzXppYoZzDq5ue3++C9nEvu17fARCOVnb
	 LDF8dgLFwSPmza1I9GIGi9TCRUss9BQ6cKUPD4yD1jS5IH4KEobXefn/JsBNGK7zu/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190184;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ate9j7LxjtB40NZJYsztC3e06L19dyPc7LZxm67TkIw=;
	b=QzeWVGVA9KGBOme6CtqCtv92xKNqFaxXCsE9u1Iqrh/znSl1ZH/BWzBTCmBYcgTb4yUY
	 36wch2bLs7CPB2oJ/1KKOT82BpGVHp9vyQQHTgb3OnvZa3WQ4T5Jh9TECZtalw8/aHX1N
	 VpnXAR+bZ8TpvfixsOxw2VEve8VCHUpI3GfR9ZVmVXG6FYUD9jJIIvH5CL7GGUubXa4kx
	 whQB5/5ahz8k7r761XE52wgpijYWZdfXY1aRMDEHPkfJU30NqgkZzopsniAvnykYU2SDK
	 gRIE3W/zCW5y8nMJfe1SspFAmNby4kGwUFPzDFpLXeJGnfQV2sOCnAvSGiV+RGUi9DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UZyjhEMB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.52
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9E606A31A;
	Wed, 28 Oct 2026 12:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UZyjhEMB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6oFoVL62ophAB4JggCerqWIiv57dPyyKDvz9qPAyq8DzHCNGg0b3YyxWGQwL6iSIGC5KIw+n+jLCDBoD0UsBRxJJPHi/Yi3BJgVx3BC7lNa78CEsjdrHvDosudUsXsUK8BuhhyIZm6FT/9qcFBFNYETnBqdrASExk6l60IqBuSbWiWc79WsfSz9ZI8NkSxH5pg3Wo6BpN0EeUFuGLJN2WdVUP22utlwXI4lOALmk2G7ZONQ73KkGJMHFehc/h1Phnl+XgU4xDcRIgsBXvlCpK6mE607RyP6QW8X5IfRr5pvYg2aeu6y4JWKr9ypRY+3bfXddHwMRW84ZIoKjJ8PYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ate9j7LxjtB40NZJYsztC3e06L19dyPc7LZxm67TkIw=;
 b=ZkuFlkb/oUhWGsRRrWIzhEwxiiER0gUm3uAmscXd4n2tjdY4uhSvGnpxUz0cMAuDfR97/J16/rZpZB3MthfBKECRHFfqptXwxs/ThlGOsxOgIOxihNTjOEDLmFsN/mCmStrlo00YY3i2KBfkswbiRsfs2SiUW8uwsYOANZGITdtuUE7bZKDG3Lzhki+YcMs/jZaJxQ5fIyNPO7nonNLPl75xNVNw/vnrP9k2c43K5eYThEl1MHmULG/e3SQEK5BIs/akCcAz9IwkFzKdb8F+X9kYmnkzPJ6rsGd398KgVuHU2mmnFBGHsaeGqEcauUi73oKqh7rwhedjTVAwbCuMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ate9j7LxjtB40NZJYsztC3e06L19dyPc7LZxm67TkIw=;
 b=UZyjhEMBKCC/SFG1MWcVgqkcwmtWtVOKz+TuZtZfODJiDsFLpSaLso0sb9sD7R8tNNhqjj7D652g7pW0ViwBFCoWxWr3P1gVPwu9Qa73sC+8yhfpkDkjCh4NrKlk0+Ty/t+vSruaoqZa/OIMPbDP5PEhymifkgJnR6l2doNIm2A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by SAWPR12MB999163.namprd12.prod.outlook.com (2603:10b6:806:4e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:23:00 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 12:22:59 +0000
Message-ID: <9a6499bf-7a72-4f43-81ab-626e2b83b7e3@amd.com>
Date: Wed, 28 Oct 2026 17:52:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: amd: validate FIFO usage before executing message
To: Weibin Liu <liuwb@xiaopeng.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zhugl3@xiaopeng.com
References: <20261027021340.914399-1-liuwb@xiaopeng.com>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <20261027021340.914399-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::15) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|SAWPR12MB999163:EE_
X-MS-Office365-Filtering-Correlation-Id: 989e85e5-a5ac-4861-5bad-08df34ee340e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261026140227099003|5023799004|11063799006|56012099006|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Cq8/eJ1du1uG5tk8g+Nfn4xK2Skyo7OEliOo4eopT7Brrxolwpj4ux5pXr6UB/nTlNOxtZJ5zuZSJphze/YWQhrjyQshEpx71MNPY+5Nm1lr/5WthmRxbh1wN9Z8w7m5Fp30MvjSqY6UXTdApapQ0kJkaMibq9RxVsoZ/LS3pJqPHuFyCtkr+Q/VkhWM0gCITo5DEJJfGa7SPxaAMPHqTQvxGarQqXa+6SKd/HxPKGEl+RS26IIrFUN897nJLxto253JyucsxRe4XbKfyp9+oSciD+bMkn3yZZ7GcwZ5tT+ZkXSFJwlVgMIDDNS+syvCcPYNI8aQJZ7DwNR8G0ZNPhVUQTZ1JlhRTjdvOLGzuVTxPMuLpFXych37u3fl36uYSmw1ZbFjYZirfZmQU5UkmIcGrzNrMB21C+684uIVya5AfzRdcDD6qI40GTaSDduocPFZ/11Tivppq4yxCj3vFmMoN7CaLF5SVoqSKA+u1zOje4AOlyUkjiN1GOAplNuaPjy/PoXSXv8IJ5m2bnFAtv0QcsBsVaiOQAbtr+tcuQtJVUukvTCwc4WLwJHhrruambZby/GE5L1KFEcG5z5G8+Kttuokk3XSFoQ5eBqstJnzY+YRa+TS4BzSlQ8bToqeESHtFGMOhjUNoNYS3IJGTcq6bPS0+mWusm3K9ZSDNMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtQTUtkWXJXSklPNzUzKy9HUUFpZkRDUXJyWXlhak9kZmZaQkdqWnVqRUNo?=
 =?utf-8?B?ZDQveDR1dy8yb1JmMkJybmJsSnVaVkF6aVRreDBDaFNJZXZOb3dMT095ZjRV?=
 =?utf-8?B?YTZLT2QyelNYanpYdUQ4V0FsT0l4UVJTMDZXZVVTb3BGWGZXYlJnb1MwWUhn?=
 =?utf-8?B?N1lwdXpRa3E1bmFSQThOYzhqUFdRdHlheDIwSnU3UHRUb3VBeDFMc2pJdVN4?=
 =?utf-8?B?a1JzYjlacm42YkdkZW1FbjBjRVhHbVB0ODFoTHpUb05oWmxoR2Y2V1B2TmRQ?=
 =?utf-8?B?a3FkQW5ZVHM0bHpXWWlGL0psRDlqMTRqRG9yOURMZG1LTy85MllqbGlYSUVu?=
 =?utf-8?B?L0loVTZLc0ZvV1BuZVRuRDlzUVV6cVErM3d4YmkxeUF1QkxCdnhkczl2RXlL?=
 =?utf-8?B?QTN4ckdOTWUwV253cWlsODB6aTd3ZVlPU1d1TEVGVjZKdUNwS2lLMkdjVFVH?=
 =?utf-8?B?cjJvVTRCV1BpQkNtWmk5OUdnam1KYVBVaTVWQWR4N2lIUlV0TTdoS1BoTXUz?=
 =?utf-8?B?OGkwSDY5UlNhUjlka0t1QVBPMzNjN3NpWjc0anFGZHR3RUtFdU1XbzZGbFU2?=
 =?utf-8?B?cC9GeFFnTW5LQVZ2RTZGb0lheFgvWXZ5cU44SUFBZkFmc002dUc3dlAvRWtv?=
 =?utf-8?B?MU9ONXVRUG9tcElOemRxUVg2VFB4bEVjR2hDazBPQTQ2a1piRytlRndtY2FC?=
 =?utf-8?B?SUUwc01pNXkwc2tTYkdOdTM5QThFOVk0MmszS242UzFIeXprMmpwbDc1akFo?=
 =?utf-8?B?VFFocGhhSWtGeDl1ODBDRk5MekI5TnZQZW9ES0svdVYzTjFzeFd5Z0E2WkZs?=
 =?utf-8?B?M2ErM3d1ZUFiY1Z0VmFTcFFKNEhnZC9tVC81czhBY3Q3a2FDOHhJaTY2angx?=
 =?utf-8?B?U2tLODhOb25sZ3JMOVgvOUorbDJZMVBSWUpIKyt1UkZWc3ovdC8zMXhOL0cv?=
 =?utf-8?B?Y0dQeUNUWFBscjMyL1JOaDNubEpFVElJUkhtYzlQK1VoM0ZmMG92VzQ3TEtX?=
 =?utf-8?B?TG5RS1hhcEQ5N2QyVFdtWjhKTWE3cVp0UUtNNVlGSjNIa2plWGQvMWtBQUdN?=
 =?utf-8?B?bHd2U29oTHNSeTJiVktzdG1WckZ2Snd3RHdkOUJiR2Y1b0JUbUE0ZndxK0lD?=
 =?utf-8?B?MFBpbW44R3QxRy9SZlJSK2pxTGtzQ1JzcjZSVC9SVEZIOVR5NEN0THJaeWk1?=
 =?utf-8?B?TjJsUEI3cElDRmJsMG5TVGJPK0E3SW8zTkVNbU12TEJmZUF6aktmTmZ5YjdZ?=
 =?utf-8?B?VHZySko1SllBY2RqZXJTMWdPVjJPNU9tdXJjK3hwL3Y3UEJGUnVaWHFTYUNk?=
 =?utf-8?B?NEkyUnpPYnJmRndvbk01a3FqblFmS0xTRU4wVmUvYWZJZlRVaG9VWnVwbzZO?=
 =?utf-8?B?a2JMbnlHa0E3RkdJWC9IaDNjdG1OV29HS2ZEY1V4Z2VmeFo5d0NpQjUvaVhS?=
 =?utf-8?B?Wjh0MFZiM0tCbnpuclBpQ09NSnZKNExRenVlNzBqVjhud3d2ZTlwNC9jcEov?=
 =?utf-8?B?Y3UxN3Z6Q1BHVUdrK3VvSGV0Y2E4UnRVN1dPNnM1WmRndjdyZ1F4amZTdGxQ?=
 =?utf-8?B?V2p0SjR6UWo4YytIQmV3YjNrTHhOUDA4azJGUm5TcFVxSERJSFBqTjViWUJ0?=
 =?utf-8?B?NlZFR2VsaC9weVMxV3Z2NFcvR3AxKzRlU1BrQkxnZEtLQjFwaWp4MFh4TGxY?=
 =?utf-8?B?MjZBOWpsVVpWRkcrT2ZYVUozV3dOSklSOEJWRnhxUEVTK29YMXlLdk5xSmhD?=
 =?utf-8?B?L0J1eDlKUC9PNElKdUd2WmhYVjE3RGQvOUw0QS9HNnZCcGNMdDFXZkxteVZz?=
 =?utf-8?B?UDZCNjRJVVdFK0cwdWpnak4wdTc3TGNYTEJFdTBCeGg2TW0vYUIwSy9WTmds?=
 =?utf-8?B?WFBPN3pKOE03NGs3SjdpMDQ3cWJzSnRwZ1FKTW04S3h4dVRjc2gvU29Xb3FV?=
 =?utf-8?B?Z0lnT09oY2tkVTBCRExrd01JMjRieXlEY2kzMGtoRHhPb3RrZUxyU0RiQ3FH?=
 =?utf-8?B?TEN5VS9vNDF4Tm41Q0grTlgwVzhaak92Z1h1MzVZaFNVTkM2ZFBVNlk0Sldo?=
 =?utf-8?B?VThVM1EyRXdRcE9xZnhQQit5RTAwRmZqUjBBVmptL1hFY0krK1pWWWxBdGhS?=
 =?utf-8?B?VFh6RTJ5b1Q4WFJ4YlJlR2pwY09ndWthSEFDK0ZpSyt5SUIrMXp0OHAvbXhF?=
 =?utf-8?B?VlNMTFNzTG0yTDdMZGppMGsvZHZFdVpZNzRIWjB5My9nUTV2QW5ISnBtNjg3?=
 =?utf-8?B?czM1dzlFc2pJckRZelB0U0R3azFSVEkrWDBmbTlUN0NZZHFyRmlGZitxTTU2?=
 =?utf-8?B?WFdwbE1Xa3RRYWVKOTRGdENSWjdJcW83UUZFMm11YXFDWUdPdG5Zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989e85e5-a5ac-4861-5bad-08df34ee340e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:22:59.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqL6vjbHDo54oc1C3ae4LR533Zbu2IwWZy0d3yNCUHh+mEiVgSN67KYXlnnYi1hWE9AOTn0fz7trfmw/iO+XPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999163

Hi,


On 10/27/2026 7:43 AM, Weibin Liu wrote:
> The RX FIFO bound is checked in the drain loop, after
> amd_spi_execute_opcode(). A message whose cumulative RX length exceeds
> AMD_SPI_FIFO_SIZE can therefore issue an SPI transaction before being
> rejected.
> 
> Check tx_len + rx_len while walking the message and drop the drain-loop
> check. This validates the complete message before executing the command.
> 
> Tested with a user-space replica covering TX, RX and mixed messages at
> the 70/71-byte boundary. Oversized split-RX messages are now rejected
> without executing the command. No AMD SPI hardware was available.
> 
> Assisted-by: LLM
> Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Fixes: e2f4edfc061e ("spi: amd: fix len==0 underflow and FIFO overflow")
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>


Thanks, patch looks good to me:

Reviewed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>

Regards,
Krishna

