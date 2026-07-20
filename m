Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074430569D;
	Mon, 20 Jul 2026 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537365; cv=fail; b=Q36jafLoZ6iQgM0mwvBNr9yqefy/24/JKREhqid1SVJkWLxKveF4JOVXCq1ayPDAf6bYLttXR5U5F9vn5K6qyjdBxbMH+WoixFmYkCya54SFm/saWNYucNvq6Qigxym5OKTKljrAVardjueQVsf92ms0251kAZ+bnAlkP//PXoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537365; c=relaxed/simple;
	bh=6cpoej3VncJDA5H3xAyMP9y66Kd/twSkqgBj03XmT4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WHhxr/vDYT3ZS5Ng5hA8T/Okr8k5VghsR2WhGLoydlGh75l8KNLT0cECRRwheh9c+IvNETBE1gj92cVuzj4TLC02qVxjTNASfEDSyE9blEdNyWX3C93kqwKBgDMax/JGEABRoyFcyduaEPngLVccZ5DGuzfBqMBhYKEXN43e/go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dMLyi2z+; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AAB1evWs; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dMLyi2z+";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AAB1evWs"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66K6TkfS1455208;
	Mon, 20 Jul 2026 03:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=DO9SDKrpf/tEhK4AasQ2ll/M1OM0TVmt3QnAV2RuG
	bw=; b=dMLyi2z+iwRqyHVZAv1dryjQoIqN3ofQJW+z9ES0O/SHLJmXlaR1oGzwS
	xOe/yUOwLXnuSyl+2L8AM9Bo2haa/2KirSVpGt1Pk3+VsWri7EP8kUutCp/QGWbY
	LdNLJmMFqPdw4LY60De3dyiiYe/lrQlhc29toV3MrDuiOpJ6gZApk5+ps71jW5OO
	5Y3gpwcpA20lLBkrmtDyd2+bGsazAaHgUOkcqa6jGgVmkmDR4lW+Yist40S3WK25
	9w2Vo3UD7FS/iAIyXhDe1DmMQLEAC0npYwlkzcMhF3YyGRRXXTc2fCzi1qMMhTR6
	xGOcYoHsSW4FDkXdXTiueXkEGF6pQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fgtgh4unw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 03:48:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnCqiHLVsMwC07/jTmn8tITzNoaUVfwzH4gZS52XKpIAnsTUIt9nmJhM68njTWb2W2N1iFPMxscHVC/wmgfbbned9mSm61vkfluY4sps00jFaXSyzmh5OBEa1CjBnQe80sNSbytcOa5ekVxY/ahhavuTJSBpcv7a9DAak3K1EG5q+1GAH4fD5n6VwDtaO7q+gbf2EPCD5mRii12POi17CU2oUeyVcZ2DZUmdlW0drUMSDHdCahgEU7Cy6EKQ+aG8mGNFkZQ3fr6zhlUxPcKN11dasswGhiWPD2jiU81/Ca2ULEHP5of9kwK7khVnl80/JWXmMRNV3xgR7LPAB8JkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO9SDKrpf/tEhK4AasQ2ll/M1OM0TVmt3QnAV2RuGbw=;
 b=DCTCpl7kGtwlrK525dx1+xKMeeHpmm/O3tGijujXlmrxhbHekdZ5RfoBNRslezBr37eEenslR8pKoK/upKBDil7yCvSQdUgH8+j9t8O3xG9dvrapWXzGrP/+6AKuiEckMw6bvvGXzeMvPhoKf4YJqhVxH2D5kdVrTOO3H9OUQauCi9lAPP6agak+U5GXjE+LkHhwKeM5fAnh1S6nKe0014tneSSyvz6+a11pHfAbjiDm2gvokjnjVXVEINjs0Eem1j24KUVKI0CynCHTiI4VIn1nDxRpBIayrO6sgYB02oWmMJzcZyC9fq7UNpDycFjU3JoYKuLLuoIE+mvLCfw4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO9SDKrpf/tEhK4AasQ2ll/M1OM0TVmt3QnAV2RuGbw=;
 b=AAB1evWs0xoHZLBxElpac3ycHFp8nwXagvry76VyB9CA52JAnMrLIFAmFrAON+oPV2/PbJlhrwf7GAsCIpslusCq5lpucfyDVp08CA3kkLv6SP0mVwpuZMi/sb/NLMLrXucn4EJQKd3AnOlDJ5DzVP7+9QcKxO3W50inY3S1JY8=
Received: from SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::7)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:48:42 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::6) by SJ2P220CA0010.outlook.office365.com
 (2603:10b6:a03:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 08:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 08:48:40 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:48:17 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:48:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:48:17 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66K8mBvb2567280;
	Mon, 20 Jul 2026 03:48:12 -0500
Message-ID: <d6b3c768-bff2-40b1-b767-f17219281fb7@ti.com>
Date: Mon, 20 Jul 2026 14:18:11 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/17] spi: dt-bindings: add
 spi-max-post-config-frequency-hz property
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, Conor Dooley <conor.dooley@microchip.com>,
        <s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
 <20260717185116.2065505-2-s-k6@ti.com>
 <20260719-camouflaged-unyielding-sawfish-b6fd09@quoll>
 <3d470ec8-870a-4e14-90e8-6c7444950192@ti.com>
 <fba1531e-e416-4817-848e-94e9b3f3b501@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <fba1531e-e416-4817-848e-94e9b3f3b501@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: f1006637-5015-4ff4-7a30-08dee63bb297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|3023799007|6133799003|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o74rxeE7zpEP0MS34GTkQYkzX7nnyuVBScLLGJhvn8URTZHyBVkk/CrSP6Y/BM1XaulkWugv4hGvDZxOY7MHvzmygiSRanmcQxRXJSGIgUaA+NjALssu4L8W4xFtwOQT1mCFT6oY23K+LFWJoaKYrayEz4W9svayr1zMr9zXvmQRUg8qI6TfMnssI8iHi//MiRlnr0w9c/qMXdo8mJjKiH4sZZKbL172OFmM8Vi6jyBAvNSbZwJOwJgE9s5DNLlx+lOxeutE+DSDAi1ncTshjsz3X/m4jOuv26BRSXJEmomgfKAQndtOd8JSwFW9o3bq3qwn8ycN10OfsufoUv3xVjG5V53FoYTu46jMLiLDmrzPeIqxJ0UMgKAEGEfEuN/+TCeTLMY5zPJvR2oDAFmScoi6gwshUwiT4fcQJc13WTY8lgs35zNb+pNlXAVQAwVs/8hlHwR5BpImwovQlY1YPxwjxzmL5Z4lSKPH3bcaiTpAOFBl6CBL1C7vilvezwvy0neBjnGU/zq0fjSqmxeqKHSJQ7HitkirqIYKgHEJvREcpKrLvGMVW7LwUcbJWhf1G9xadccvi2YeCcxOm1WKc3sp+KlkYK0XuhGGLUlfSOD1dnLAuJ0fwXHy/JqGAvXd1V9GM8gEYXc95lnJvyap9nkWvJ37L/4ep6XKF+YvAlAr7fGgtw2riNzHfpRKrnDCGy3oUkDQzxBnipkGLbJmGA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(3023799007)(6133799003)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CfpVXHfdaBbFSoW1IfB55heCg89/NrLzn5HyOuIGFNZ0GQUoW9khNZSQkoltbPeN1f+RZ74DTn9EwAPszK03zHfGCQpg+Obzq0hCCRUpXChS52BNZ1wFRG3wdTsjCunOL9BV+eIxhSFRpKhXoqE4QcsKwJlDG4AzBQePpJsLg/t5QLF4AFZYU5zPp/pPHWXdPOa/UO1twI4GcHuP1zLiJGFBSqV/scWsML/zfSMsgLTZSKjKWH3shF6623r7wwDNXR8gZ4IpQW7T0RI1p2UIz20LcMFsfnF6V5xIrVyu2x2pU42G9Ua3ks4YgL7ttydBNK4nTHfhTGz3zkbVBA0OCCEpQFgNQ1U73mzYFBzbxbAgLCHaBlZHQI1SJ+OQm6JwqbW9gjDSqN1RoXtXJ13OcDYwz472sw7kq1Te6JNp5/XvT7DKWL3zYaDRfhN/bY5h
X-Exchange-RoutingPolicyChecked:
	ql7/ElOd4uvYJBxdVMH2kWJjjaM9DmzeURzKj07/NSM6a6awN9fPPXfAyv5lWfX5rfO1zOzm5u6UfMi7B87hnUUa7npsO19IqneIn1KF/FwSWyJp/BiPrNrFYvOyGYHizWUI8SKtrH3VY++E4NTE0UFTHZD9/E5DV0If2V5HL9Xtwrg/R/3o/24fnRfMSHEvlEZi88d6WXGuEdiYWrgTtVOfisWuHmyl+o1Lu/hinFPPrK3B5ql+8rKrw/2ivYx0RwZy1dV/vH+z+SwfNdt50B10qez4dE6RDghS6RrrHlRaeA1uBGsjNjfhRk4Pqo+wMh//VWR+1GskFhaBFqdCnQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:48:40.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1006637-5015-4ff4-7a30-08dee63bb297
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-GUID: 8KV52EMCGLtNpunuk39sql33SzAhc8mg
X-Authority-Analysis: v=2.4 cv=LtiiDHdc c=1 sm=1 tr=0 ts=6a5de0ed cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=Kv86BVyq4rBoqh5-JQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfXwt2W6hDoXreR
 UX3okJkasNzBGm0VIOVYWw2NtEqyJbrcIzPwxSjo/JCdEbnTawKRfvDROmYj3mB/P2MABM9bdqE
 0VssRnJjnA/0pwHNJzY8eyHEc/2bBC1UBkEM+HIs2KuVlX7vpK5fT1B9k/4wdLwW52z+jsl4YUG
 dMzaOGcsxXDnqQS3//E7/MP0o/uP7UWrtS/tOyARZfBS19vqACeMrHTbrz4iZ58i9SLfU+2Q8lB
 ICV6TAj2Ek8Rd4H1UWUIkCu8qW+MHfc34u5rW6FAO5nZU4v5U0Vo/0LNyOaxHvbLRZQn2ehOJGt
 YfFwL4Q7cvXmOPE8gZCwd4rYIDo7ZnxDMwbqejfDe/FPJLM3Mm1HbUeL+V+bI4vE9dSHiZWP/qS
 XZvt5d5W3vZWy+gR+jJhi64j4DEFeLhVXl1slvOo1gIdO09CW83NLMQ5ygIAc9FLtoaomVixSGz
 ZrNAteA2I4Qexno0JPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX54ZHLdXy3qBG
 KaEIqVlhXeZiUiTcffok3qYZVnH56J1pWg1aVFyP3450ZZK3YRcz6E81vPFIPDDuXGdrhNj5WNj
 lC5FTallivZZencfvaRQY3afcaCiYcA=
X-Proofpoint-ORIG-GUID: 8KV52EMCGLtNpunuk39sql33SzAhc8mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200097



On 20/07/26 13:10, Krzysztof Kozlowski wrote:
> On 20/07/2026 09:38, Santhosh Kumar K wrote:
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> index 880a9f624566..12211f8c9f7d 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> @@ -45,6 +45,11 @@ properties:
>>>>        description:
>>>>          Maximum SPI clocking speed of the device in Hz.
>>>>    
>>>> +  spi-max-post-config-frequency-hz:
>>>> +    description:
>>>> +      Maximum SPI clock frequency in Hz achievable after controller-side
>>>> +      configuration.
>>>
>>> How did you implement my feedback?
>>
>> Three points from your feedback:
>>
>> 1. -hz suffix: added
>>
>> 2. Array property: I still lean towards keeping this as a scalar for
>> now, as we don't have a concrete use case for multiple values today, and
>> supporting two frequencies should be sufficient for the foreseeable
>> future. I had responded to this in the v4 discussion as well, you may
>> have missed that response.
>>
>> 3. maxItems: Since the property remains a scalar, I have not added maxItems.
> 
> So how did you make this property scalar?

The -hz suffix constraints the property to a uint32 scalar through the
DT schema framework's property-units.yaml.

Adding an explicit $ref or maxItems for a unit-suffixed property is
rejected by dtbs_check with:
  - "Standard unit suffix properties don't need a type $ref"
  - "Scalar properties should not have array keywords"

Thanks,
Santhosh.

> 
> Best regards,
> Krzysztof

