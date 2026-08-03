Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34A2FE56F;
	Mon,  3 Aug 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748426; cv=fail; b=vCCczxr8OC3xfm6wm6Zbcqi9RjMIXQkQFeUvqkDjDt4RJ667NaEixibLcsGoCI4C9J65ZKg10FZMQlbFQApttYJwgotURiV648jXa/RKop2YtRLZw5449DsS+ifJjqatNb1VHDGewimhZE6Di0XaEpOf+tY0TQkYgBLeo7DsmSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748426; c=relaxed/simple;
	bh=4IG+DOf7NOt2iGXIn4Jqp2Ws9RQtQ4DLj7qrmiv8FxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m9Dnc9UUFWI7hRKMZSMbJw2TwoNTERlhgP3J5VujjGe1A4gsGhDKlO3kIqoHivly6Tx+Y+krUNfTnqfnaqy7uPHUGZVNukOOtc/F1332mE70xFG6cqq41JNVA6iulpENr5OW/0B9iQE1eOtt1rwt9cUXUE3KjWO0CFoCL189++0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=VIWZP2Je; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="VIWZP2Je"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQdWtzlb2bYDjhT2mqG/XPV1Rkiv4wDq2AyK3V+HvZjNQ2ItFBjd//fXSiwB4R2zPRPGNLnPxmIN5sKGAWWcBM5pJwdSsIalQfZhOSbP7i52TOiN5Zd0Cawhpc5khW5FbX/2dDMXZD3Vu619GW9xIpNbKLhLKOnt9af+4OINTNP4r/6MG6TodA0tFgmLtbSElyvcijjeuiS+l1EGkNqzUGZRWYGKZxDL5HbYGn35ki7BXDRpJmWjULAgLK+rF0czMcJBFCyI7Cre6RqfDErg8CsyLGNgzWDsE9t/M2R2+TakaqLsedhwTabcX47ZldwGLwNHPvnUou5YXCAygAuJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/OORMzOkzjtKG9xfImdbFMoVap7o8KxevTVzD6/mFE=;
 b=TrZDypylX4YbGeUAz3S1i70h6sHskYxtvOuNrs1rLF3oq04RELRPJHYERJhE3ZCF2WfLKdw2bIxhtBMOuaKXS5wxOtDQEUNUqudTYGGoHcRGKZ7jeWLNtCAFsD47JvNg8I6q+RUQIjquusUp88RYBqp0UfZKXOgnhvumzSujjhyYIyfQhk9H04ScIlGnPsY5TH9nOSpNzjXquTeStbESmfyDzrGt2dldsQTyoHbfNM25Yykaw14ppc7fsW9wGy5wAEGIaIKSsivBOhksxk4uOc9WuieNpKikWwxDBtxpzXsK0KGru7ZQoQoEXDLXivx7v8JqshhtgYgalw7gkLHk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/OORMzOkzjtKG9xfImdbFMoVap7o8KxevTVzD6/mFE=;
 b=VIWZP2JegLYck4AD92CjpmQJNj1soPm3AG0/Czl0KzcsAigzf1RIoglc1sfR0GkWASp+Z0G9x0vcTQSWC22EVQLKegQUC6LRclMYxjG/LmNH7bnwJT+yI4cOlboxzXIfpts/v6dr5JPNKy/wecvSutfGrW3rc2zDGi+IifYwCcBMTqtvWddOMe9gadUiz8qZdmzt0zDbT+yXv/0j21jDFwy8xRKrWgIsV02NHccAxk2Hj3ZH6f9ij9rKGPKjeRwNJ8KmAKvFwwYlq9HzFte+gb5fEKAqz3MKlak+tuGmFUVom4jXGXSvq+AOTQ4jV7VmhumNDlP1wFcf4CGQwhSdHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB8234.apcprd03.prod.outlook.com (2603:1096:990:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 09:13:34 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:13:34 +0000
Message-ID: <1b01109b-c264-40d1-bf07-6ce27f9561d5@amlogic.com>
Date: Mon, 3 Aug 2026 17:13:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
 <20260731-a9-spisg-v3-1-a15da3f70029@amlogic.com>
 <b09ba781-9042-4199-a7bf-126d07e97408@sirena.org.uk>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <b09ba781-9042-4199-a7bf-126d07e97408@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 98df59b6-1447-4295-f071-08def13f7eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xvqoPshKC0DKdRLDGu5ZeMlQlW+PLs7vzQp9w+kitmtHIbE84aSmFHffZoeNbpzuJh/Jw+Ws7vluJwg5d8ckObaUE7QyALOwIIUJrMa2R8qMNCAZlF9lz6ezdqhrxlMCryheZPgH5JqcwwiO+y2y6cyiVBb6MpRyxUH4WkvGYIPvMyYKKG04PuUfLHTLQly6OUswguoPpa0N14tON5MkuFi3b7ZDRR8AEiG+9PFTkRBd8q0J8vV7rSYkbBu0JrHyfpaqN8oye28IA3ifAM7oI5C0dZxrZMzbaeLygkTJmJIRmMKUYMMbV6hcVc4GFZJBxk8c2ql84psjAxhP9qHvmfXgP4jpt8SdY8itnqKkhoVUFh4rBAl+5a1KAMmpexewBIicjuNEFjP7OmVFdkJFPjn448XjiRAOr0zC3R0ioBPpzt4DGbfmXEZWNqnCz43woxDzqyb4KopzVHcQLcNVKFhCAdaOGYisOk5eYuZSmANCUJLd+hFTojAuKh38p2YHFIeAReG93SYP2uogZZCPBfA/452393FsWPX+QvhOJ7HpjsW6UfqY7AQVOggzRUlB8msiM1+hn1SkltSw1/mHdhGRhxjLokdFzS+KVhAaqgBVKW4fr7/N/xNY1MxIclrHELRmXOiOM/HQbZJ98Zs1kZnueiIjqjOkyXQRIvDHv18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ErTzRoU0ZFeVBLdGNJbHBtZ1NjcXpXVXFrMDFIQytjOVh5akNDSGFjOVRU?=
 =?utf-8?B?ZG1mTThwWlpOVEtLR01MR1RNUFErT1dadkxUeXkwRENpTlJvT0V2V0ppOG9s?=
 =?utf-8?B?S2JMSVhiT3UybkpGSTZ2MS81T0VxRDVJUmFIRjhzQnM4SFRlekFwU3Q2dVE3?=
 =?utf-8?B?QlBRc1lUSWxKa1VPRFo1YkpXd1dVZ3dWbjJDaWVRNW9xVHhFTTFDUDJITjZ5?=
 =?utf-8?B?T0ZMQ3ExUzUxS1MvdTg2UmFVajlmeGw4RHFWVzJpTDU0OWRkbmpQWlkxRjRQ?=
 =?utf-8?B?WG83NDdvazc3d3FWMUpKTkQxYkl2b1BQczNhanRXMjhEVHpEVUJpcGo2a3c4?=
 =?utf-8?B?TVh0N3hYSlNQSS9EMkVYd3BmamQ4NjJwMitsQTNjR1lMUG1oVUs3UjhvYTJl?=
 =?utf-8?B?L2ljYzYyTjY0Ly9SL0o0dE50NHFYRC9FU2hjaVVkNFFPbS96TjF2NDJMSHkv?=
 =?utf-8?B?Zk4vWDNLUENMeDBjZWZUNTZKYWpXZzkyemgrZGVDdmppR1ZmZVR4TkN6YnVa?=
 =?utf-8?B?SXlGejdFNUtISU0zUHZZMW5SZHdKL05hRjQ0YzZyU0syRENkdFE3U29mTDR1?=
 =?utf-8?B?M2RBK1NYMlRBTWprTjhnWDlPR1lqZXMzeko3ckRvRTY3YXAwQmtLeCs2bzJs?=
 =?utf-8?B?a3FvTmF4RHZKOG9QUks1bStlWG5hbHAzUUNibDNTT0d3dEFKQ3NZY09XVVVi?=
 =?utf-8?B?MlNVcHUxbktlQ25XR2VqcEsxRUN6OTVoeHplQjFWMEZleFg0ZmpQbHdDZ241?=
 =?utf-8?B?bWNZSG9pOVBpbDVzY0hRVDJONWYvWXpUc2hlalJtQzQwQ284WmhGdjJtOFJE?=
 =?utf-8?B?Sko4c05KQVVhZUZiTThoWStrOGlsRDBjZTFpUmJFZ0RZYi84eVFWQ2hsa2VJ?=
 =?utf-8?B?VW5SNTlWUlJhaU1lcUd0eXJLOStyTUI4Z1U3SEZXMHBmV2krMmdVQlZnWW53?=
 =?utf-8?B?UGo4MXBrRG9VNVNmZkJyakVqd1NSK2xGOEgzUXNWVElvRWxrelUxaTRXY3NV?=
 =?utf-8?B?RXd0bHRjUi9HTG1XVjRmT3hOQWI4MnRlUEh1MmdNN1pGMVJqekRsR2ROK3or?=
 =?utf-8?B?c3diaC9lemo1ZFYzTEEwNS9YTWx2c1FEWHJOMEV5UTNnZ3BpZDdQZStFZGh3?=
 =?utf-8?B?bmgzWmdOcjU4K2YrTnZORlNodk82TmgreHdNcC9PMVRWdUU3WC9zcHhrR1Fa?=
 =?utf-8?B?MldUZG4xMkZUZVlySENnM21WT2NxYUF0U0puUUNBM1o1YkhyUm5MaTkwWUJ5?=
 =?utf-8?B?RXBBNm8xckVVYVlTZk9EY3pSTHhiSkFWRk5POVd0SXJXTE9PZFFYNVpzU0pG?=
 =?utf-8?B?dzJrb0V0cmJaV3pjc3owYkJQbGc1TVpIWnBJSThObTNaVFI0Ly9UV3Fzd3E1?=
 =?utf-8?B?bkl5b2p6N0R1Z09ZOVF5bnl6UkJudUNyYzYyUFIzbmR1U1VhV2JkcmorblZI?=
 =?utf-8?B?RTk2N3VDTGRqLzVtVno3R2tWMklvMHlzNUp0ZXQ2NjJoRmRpRVlXVkppeXNI?=
 =?utf-8?B?V2Y3ekdWN0N3VStLTVl2OTg2TFVRNUp0aUFpYkZ6WTBFMFY1aUtkc2dNblJz?=
 =?utf-8?B?UzBsV3haZk9walVsV3hJV0orVXZwclVUcWV2bWRZWkpPRzc3dXdBbDc1ek95?=
 =?utf-8?B?WGxKbHppYkxzZ21ick00aWtjMVA2eG5tbmJmRGIvekZXbklVZVc3L3VkUStC?=
 =?utf-8?B?eldoYS9IK2tueVBGY3YwcmJncGRjL2dSOGU2WTZ0SE92d0ViTzRmUUoxZGkw?=
 =?utf-8?B?akNMRS9keitpQy8yL0ZGTWRUM3BJejJXd250T20zMXIyb0k5c1J0RFltSXdh?=
 =?utf-8?B?WWpySFc5V2xYNHhFVnZ2aXFKM2oyQ2NWUGp6QndsdEtOVUV4M1FmZlhpcC95?=
 =?utf-8?B?K3RnZ0ZTZjAyNWU5cmVFdU52S1Ricis3L2hFL2h1bDlKa0o3QndJb3ZpckNs?=
 =?utf-8?B?VXRZeUVvdVZTb0NPQlN6Q3d3Wkl3U3NXZkk2VjVBN1QycldNaTZKS2p4SkJG?=
 =?utf-8?B?S1ZKdU1MU2UvSnExNUxhc01iQ0NDcnlJZzJOQ0tzeTFNdG5ZdVExdHAzMWR5?=
 =?utf-8?B?R1cvYVEyTTBMdDJmL2FGdUpZOTArbWZON2FxZUxTQmFYOUp5S3ZiV3ZCNmVp?=
 =?utf-8?B?dlUxOGJFV3RoVVFPK08xODFiZS9DNDdoaFh4Q0NiRXFkeE5EWGoySnp0d3d1?=
 =?utf-8?B?bEFXQ0NtTThWWXBEV0FEZGdlYzRRMmRHaXZHNk45RHRRSEY1OVExM0RNQ3Vq?=
 =?utf-8?B?bG5NSi9wQitNNlFBVDJnNm1xcDJzK3lUeUlxREhGQUtCRkQ3K2xmL3RVWStM?=
 =?utf-8?B?VDZmMmt3NEhUK0pMWkR4ZXA5YjJiSGw2QjY4ditKTkwzSDgxUm10UT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98df59b6-1447-4295-f071-08def13f7eb4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:13:34.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98/N+E28k0+lcQoPLV1jhnFm06t6P+fTOtVX1RKdMaItwwFUtVNtNDRIbyS0uQ+syePDb465tui5D8XDPDgH83FW2jVsZDAA70rAxBGiVm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8234

Hi Mark,
    Thanks for your review.

On 2026/8/1 06:51, Mark Brown wrote:
> On Fri, Jul 31, 2026 at 09:08:25AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Document the Amlogic A9 SPISG controller and its additional Device Tree
>> properties.
>>
>> Add the "amlogic,a9-spisg" compatible string and define the A9-specific
>> "amlogic,mo-idle-output" property, which configure the MOSI idle output
>> level.
>> +  amlogic,mo-idle-output:
>> +    description: |
>> +      Controls the MOSI output level when the controller is idle.
>> +      0 - Drive MOSI low
>> +      1 - Drive MOSI high
>> +      2 - Follow the last transmitted bit
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2]
>> +    default: 0
> This looks like the standard SPI_MOSI_IDLE_{LOW,HIGH} we have in the
> kernel, plus one new option.  Usually the client driver would control
> this.  Why do something different here?

This controls the MOSI output level during the clock idle cycles 
inserted between consecutive SPI words, rather than the bus idle state 
after a transfer completes.There are some issues with the description 
here and I will make modifications. Meanwhile, there is another problem 
here. Since this mainly concerns the attributes of the device rather 
than the host, is it correct to add it here? Can I plus 
SPI_MOSI_INTERWORD_LOW/SPI_MOSI_INTERWORD_HIGH/SPI_MOSI_INTERWORD_KEEP 
option, in spidev mode?
