Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A8395AE7;
	Mon, 20 Jul 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543706; cv=fail; b=ZOiKbxOhAMR9QvkXjVDWXRy0jRczE1lMkT5DRUqXXSFOreu7TasYGCg2Lsa6uhHbrBwPNON3Cz3gav9RzrDgZrmwxzw/P+8mdnqWNk/AHT77wnLVJEqBw/pPi3Y1AL/PVvFdjbHw/0TRy8iaeTj6nus4BunSZyUmdNuXK5brP4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543706; c=relaxed/simple;
	bh=fi4jovF70aHdGAoqxK9dnmTdNFIRsC1zbGQBkmklgFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EKTELwLZF27i4CUcsE/5zhc2j8UuMJAjfjhYD65O/+0hgkBWFJnyWuvDzN5xv2ID6TH5C5fls7yr0xrS6QqOFaOxQPiAI4m+gF1pgly7/rwuZEvIf6B5GABr0zyVIBp8GmB6lB72EU8hIoyhforcKfSq18kVmYsOzexf9itxNs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GSmL4ZLJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IM871ERk; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GSmL4ZLJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IM871ERk"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vNUd1859646;
	Mon, 20 Jul 2026 05:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=009hu5qVL3bUFSWkgvvrGkskBkP330BpIvb1ujQIQ
	7I=; b=GSmL4ZLJ4llYfcKoOju3loqtwcMB1SOWvIOQ28VnlI8Nmc1YIYrTL7qV4
	jOXBOg8dEbJt6jRJfrmaVmNR2Q4H3l1FSy48pzChuAIe+i9scavMAqOA7xApoiX/
	SjWdVIHcsWPk1hDOKaVwAwjrUhVmx7UyFxtbFglynqivBaSlbCYPDm/c8OgfCym7
	nZpJC5T4wcfJYgMade933Ajg/VswZe8DktaFaqp0BYfCwFL8hhpg/xdmyVNOIyh3
	JEhoxZGbvE02Ir2Gs34loUJ7bXGA+iqpBgF1iyRD/RtIHgq7fWCzBw69pPxYIjtz
	6uGEjFkpFsvjkPBQm+4TBWu5IrMeQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fgrmkwhew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 05:34:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbVNp5Res58AqF8kEhU2uDWdoCRwOL3gBY/w5x2+NmmZNngsVTIFRuFp1jngIm4JFNwKR2WwvbhnSoVidZDa1CyTj012/x3DM4gmmf7SU129gn0oMU2mjR3JEMv0hJFRb53xvOEAQXLuU3Ejtg4zHTLTCBjB333FCp4OzKN0f1xqoFN6lBJaQ1i+XT7hz96de+8czs5ShT/SPWzeY9IrwhlNc8Ujpkrz4BLfZ1Y60jfxPRxejsKgrZr2bdGtorwW2Rafs6kSaF8nNqu7uiQdAW81ycrKzEWZ2C1ydzgZF2TRgjZjPeSCcIiS7Yd2hPkMw13AKJ5oGi0E0a1hU724Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=009hu5qVL3bUFSWkgvvrGkskBkP330BpIvb1ujQIQ7I=;
 b=MfqO/5EWSwUj3ynsWBpuJc+5Rfh692FWhiexm7sbTqEG5nV0amgLUDlcXfT2S42PPTo3/P1TAtjveLoXLisdoEThpmDj3PJ/onmFysD9vjehLGcekrZ8GQGUsITgcYrn1UvKZ14szY7IYzO99IRMOeuG04z1RBw8UjwkbpJZiHkjVz/MchrhngtPBIIzCiwfp7bw3mrRp9nGCxsGgfAeTwKoNNAvx2xf0i3tOTpRascmcYIYmtgJ3X26UzLnDZYEj879yo457D4LLnYaBR5vEVt9O88hKnRWxSCZDbE6WUAD7yWM7cEPruFnN6/QyjEK52cq9jVA+c/7UoPOP+fJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=009hu5qVL3bUFSWkgvvrGkskBkP330BpIvb1ujQIQ7I=;
 b=IM871ERkr3l0TEUzZ5Nm5cPhNmOveaDqAqwGtGG1YybGn5OI7m9QMifaoD7Dp0TfWW5xHyxu2nMGNIxh6IpH3XFB32seeqoIbo5dujwxYCe72uTdkWBG8dlEjnWIjGmmkaXniluTDuayHB5HEwKorWa2vHRGBuj6zS3eWB5mh7M=
Received: from SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11)
 by DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.16; Mon, 20 Jul 2026 10:34:44 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::76) by SJ0PR13CA0006.outlook.office365.com
 (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Mon,
 20 Jul 2026 10:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 10:34:44 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 05:34:43 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 05:34:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 05:34:43 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KAYb2T2762196;
	Mon, 20 Jul 2026 05:34:38 -0500
Message-ID: <2aa827c7-afc0-4edd-8ecc-786ff96913ca@ti.com>
Date: Mon, 20 Jul 2026 16:04:36 +0530
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
 <d6b3c768-bff2-40b1-b767-f17219281fb7@ti.com>
 <1a681388-5ffe-4df9-83bf-a7622ee489bf@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <1a681388-5ffe-4df9-83bf-a7622ee489bf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: e0823a98-e9e4-4904-d2dd-08dee64a839d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|22082099003|18002099003|3023799007|56012099006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NF906+tO0zYNboo8YczJV08mS70JVzSuzfka9nX68vgRATU5OJoe3z+4GtA2pa8HBBgZyQipedipzzvTXfMbo8xzd7bLRvlsoW8gz+XN+TVYOdMbUp1d5bOl5PGi1xujm8yZ07u4NpuCoEvwWaZfjHeW+OOaFEpXiR1XY2NWuT3M43b2eNbi0r/+/FGPevlRQ04+nSKWWB4D5YHUnpfkanhF7VExgiXoZWfLeYv2F8T6FZUodVSRx04V5/NPW9sZ7bvGUIMNF6fIj3y0pxy7lCiqqH+v2lGK24dseLqho9T4tMHJW/6Esk3XpEZT3KlLGyIUfYJwx5W9bq+98hJlVDE2tF5mavwHcVx9Cxac5zVA2HWXhypcXgeMmv+8hs5AtYGZtfNns/UMtYtG8zW19Z46cvXdJAmrQ5sTB7AoVjDWdybr4RGjt82clE3F42nmn43GQUfWfyZPQrbPZMKBdtyJ1PRJkEeZdweziOAKwYHml/Rto6WFnsqNL3z21apBFMIY3GBzfC/VGUCoWk4sOo5HzfpvQDDH60Fl9nIImif9OaUCWC/r4xKqwe9TVtQos5AykhQMLUUEHTm36s+63v+p9KBL6GquqEMX5XBOZwyjEm/QZ+iUeefPJe/GRZRz23Re5nSvdMwKSW6LFOhmGgxG8nobJmymIn0fhM3HLC3lBpHKyRNpZeubUtyvmbMYLxntTHXU76xuzkS30Jea3g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yvtCulGs7K95DL3DxMIBy8AItyvY/MqGO+zv7xvn5uAO7iAs7AVub55lZg1KR4H54V/INY5l+SqEJsLwh0PetXhCh8zsZHG8WUVq5nxSnFOv9p55pZXh6BN2WrC0FxTd9NdLfxwEA8z55OoyInnTPMNsz9EFUhmt+oOlVWc7enY400lFEt4E4Nbg3Zn3GiwNt3O66EfK3C30yTqSHsmJg65detO23kRwPGYiAld7XzrrG0fPS8cb6dZdZZAt0U7kKmAr63MW1FQVBiXOE7TAe2/cP5CZDmt2jl0wIFIHrk5QjypwNCU2ccRupvS/L0luVc8GFdNmpSWsf2I8HLTRV+DjWOni3yo6wn6sN8/dRVEzjztQdF1ZOWGwPJWpwJaQiMz05d7wGx5Rsaz4R12ykPtYCo1H1iGnqZooSFrWJuppGNNVcQphH/iBbx0iso9l
X-Exchange-RoutingPolicyChecked:
	oEc6lMiV3sIrJBdZ8y7AFIKDIIIKrB7f5ijpDNKyj/tQt/qpMaA2CpVKeOH4VeWikA9m+AXMuy6eToi/lVw+vGddNQj4+cBSQiY6xhjkA3RnpCcw3rbuy3h/TslLeHKNHqtRCbsizfCvQ4MiGP+dQ0Wc9q0bZisHFjVWsVQsc/UcUFWUjaukIHKUNfoIitd0U1fVKm+4fA0BiKlvv5k3BgioMR2YEhiKpS7xm03sTUgQuBr9deJkfblB4A5yhWxS9gLFW4yYWzBw9ubxyGO/SEao+C5+IjoWdYnr5tyygh6uHLt/E3oUxO90CUy8DrriLomiYvhmz0a7sfEKpUFlRQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:34:44.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0823a98-e9e4-4904-d2dd-08dee64a839d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-GUID: OE0b6d_uCZG9XxVubdOQH_8s5GEernRx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOCBTYWx0ZWRfXxraGhrhtumV9
 xDuZtqxuUii+GcoN3hUot6kWTyhB7JfQPJVAkVSY8WXFVeHGpfgc2rRib30SUi8vch8trILKFc9
 Qg8ccoy5ZpInc0fYmVES8Nqg+OUS2H4=
X-Proofpoint-ORIG-GUID: OE0b6d_uCZG9XxVubdOQH_8s5GEernRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOCBTYWx0ZWRfX8XFKKpwUkckE
 E+TaMxvMeY//RA0oDBYbxCdPttFqWcm3eop81tsZbwIa1faGQ8I2uxHEXnK6Xm3PBGZ18hocfY3
 kibPOVqLDnSySj0wzi09HgKe1zRZwMSeppYrxvzLjnGzOVK0iG9KcuVqZxbaUrEc1nnQb3z7gNo
 6O955FQ9R8rHdKvAswkYMyYcEuaLF5B6rcQaIRI9FywWn0mg53kQyZibCSqxMzLa3hvVGpXcKfo
 jt/AnRNGpPb2eKT1wWUvfSG83uqXt8bnRTQyFt3EXzs/yuqoAjCMenhkaIkMSPbfApKNNd2r2Qw
 PSUCOTZpDovMK4pAzGlyGgJ9TarENWpnS5yIDt1kdtVXXPiheI0aherULuQq5vk0gwUQL06hfaa
 vWIaaqmxwl6ySk2LBA8Idk7bFrhtb6plA0i4si7qRYb39FoAKSadjBqlX+N7CZamd3AExVc5CzT
 Df50+7AqtmJbal1mjIw==
X-Authority-Analysis: v=2.4 cv=KIJqylFo c=1 sm=1 tr=0 ts=6a5df9c9 cx=c_pps
 a=N6jWaT6qAb3kxWP2Z7atcw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=MiX5mLSNAeYTziVGc1cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200118



On 20/07/26 15:39, Krzysztof Kozlowski wrote:
> On 20/07/2026 10:48, Santhosh Kumar K wrote:
>>
>>
>> On 20/07/26 13:10, Krzysztof Kozlowski wrote:
>>> On 20/07/2026 09:38, Santhosh Kumar K wrote:
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> index 880a9f624566..12211f8c9f7d 100644
>>>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> @@ -45,6 +45,11 @@ properties:
>>>>>>         description:
>>>>>>           Maximum SPI clocking speed of the device in Hz.
>>>>>>     
>>>>>> +  spi-max-post-config-frequency-hz:
>>>>>> +    description:
>>>>>> +      Maximum SPI clock frequency in Hz achievable after controller-side
>>>>>> +      configuration.
>>>>>
>>>>> How did you implement my feedback?
>>>>
>>>> Three points from your feedback:
>>>>
>>>> 1. -hz suffix: added
>>>>
>>>> 2. Array property: I still lean towards keeping this as a scalar for
>>>> now, as we don't have a concrete use case for multiple values today, and
>>>> supporting two frequencies should be sufficient for the foreseeable
>>>> future. I had responded to this in the v4 discussion as well, you may
>>>> have missed that response.
>>>>
>>>> 3. maxItems: Since the property remains a scalar, I have not added maxItems.
>>>
>>> So how did you make this property scalar?
>>
>> The -hz suffix constraints the property to a uint32 scalar through the
>> DT schema framework's property-units.yaml.
> 
> Hm, where? I completely missed that, can you point me to the specific
> line? I see clearly that it is not a scalar.
> 
> 
>>
>> Adding an explicit $ref or maxItems for a unit-suffixed property is
>> rejected by dtbs_check with:
>>    - "Standard unit suffix properties don't need a type $ref"
> 
> This I did not propose - the type is fixed.
> 
>>    - "Scalar properties should not have array keywords"
> 
> Cannot reproduce it.

I overlooked this. You are right, and I apologize for the incorrect
explanation.

The -hz suffix maps to uint32-matrix in property-units.yaml, not a
scalar. Without 'maxItems: 1', the property can accept multiple values.
I should have verified this before responding. Sorry again!

I'll add 'maxItems: 1' in the next version.

Thanks,
Santhosh.

> 
> Best regards,
> Krzysztof

