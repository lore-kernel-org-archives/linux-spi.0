Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E646A5F2;
	Tue, 18 Aug 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076865; cv=fail; b=T3l5uN++9tnVl7ChNsxMllVtWIw35br0IYYOgw3zQeSu3zLUO7yJMQONvZTtN/2LRWnVaKb3q35BXu8HCNgf5XDDKjv+WfNgHHjAxzAD1khirTLxX0jIhcOy2toyARpivcpytXSUiYTyFuwtD3/K1MAyVH06vBSfbBj4gbPzI7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076865; c=relaxed/simple;
	bh=rAZzn+AvUZYav6jNDPvBNEW9RGFQub1Q4sPlViY8Pcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hGCs8WQ5jQqmC6ehFjZP5E3NItc6GUITCtq5BqCCCF28SoQjktQN+2/wXHnCEQkOuEv4BaC1gNctGknKxm0Rnr/FAPr2oSUGHICjR4higBUGIp0TGWmNFFHzMxoHFpHIO2TVRQ55VtJRjilXf9qpV4KbpFStiY+5xjZfj3YhFUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=DKWAH25J; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ljqITh/N; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="DKWAH25J";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ljqITh/N"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67IHAL4V063439;
	Tue, 18 Aug 2026 13:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=s2cSbDwFtpu0oNpz7gu6teiaZxeY9NflEZBT3wL2p
	r8=; b=DKWAH25JghaHgmJLwxJSN9x+8sqDwSsodiXVpnEL9INZZmHdqmYORDXm/
	JzxLVC/G7Lu7QFvIVQ9rHbl+qhEzB5mlL99fERMlVIQPXcCeovdOGLALhu0RTqyk
	Egu1TajhiSQInttIqRU62SWhLbDxbeTsAJ4XQ+PRy64bFwM3rR/r07m9M3vd8Kn+
	17smmRdI8jQYkwnk+qwQ4JcZwEAoQz7q6jNDMPXE7kbijeXi1d8XRF42lwzAXFLp
	aB9YsqEo/48PhsX90WNOZAmsY4TZkaIN3fQstBJOk4gqRWvzKp1QQH3BBVe7Gy4g
	5szULBrr+GiLk9VW+kx/zLLOxcHLw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g4fbvvnm5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 13:14:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6FLTVAfJ8W/CV2i/+yMl3Mv6GNAW9FFYxF5K5vToTUl3w20u8+bwMwSAPgwowDKuCa12WsKY2nCoDSSkDA6DuKaf5T6mNMlN2Hg6FJF36DYQbD3iQSvqPmPXEtqnLMN5S9WMUPuJHEcfrAui10354aHp5NucKMXsqAOz5jZKNyRhzFyNOGfisOQVDKg9BWGddrt3nBTZ61flfY2qqFhzv+oLGZ/qtcSSXWcKinHkhmBTeH5z/7b98qBIzb9eBXIUl07U5h+GU4uj//RPMmDcc7mO2RRu6qYL/Z87+3cWMuPusMge4IoTF0GKFXojpah5VTrG5nbGGROqpvJDSnQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2cSbDwFtpu0oNpz7gu6teiaZxeY9NflEZBT3wL2pr8=;
 b=f5xZ4VH/X8bHE0vpKyOJeauHy6xYbWftfG1BrRGs2frPW1x/fzYpj9xHCa48kOICorgeVpbmNwB+5GWaw9LeZUaCrdOzi5zEK98ZCyZ2sTKj5412DRxbsFKRFMuwv3Bjf7P7Xl1YR5H5lQHW+oxIP+6KZ6UTAStuNbCGibJlikaIHojkTKHFbg25yfbjptl3xWlCX7YQT0sMGHECLhwwOEyQdDFNCBK3UfmFrt1Q28OWOcpwHaxPRHl51MTGUBr/cgPSVzJxkAHtXPyq9QTdkWTXruqyB6wg+9K7cIlr7ceAVcuVuYyzIzi24NU0CnQhLAQh17XZqxZ8RF1kBu3XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2cSbDwFtpu0oNpz7gu6teiaZxeY9NflEZBT3wL2pr8=;
 b=ljqITh/NDO9n8h7XDkM5L1dsfu/LD1EBiCPnSDG51pUp5SoqR7H5J+tG9O9d/1o2KsOpUYllLs5lL/64b7N8xrMa44mlTBbKpo8GWmJwZ+YyFhC8gQWigey9UPSBzBmUO+9JUG+gGZX3coqgmGbwmNKMiS6SOwSLynK79lemxuc=
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 18:13:57 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::96) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 18:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 18:13:56 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 13:13:37 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 13:13:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 13:13:37 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IIDWCG1895401;
	Tue, 18 Aug 2026 13:13:32 -0500
Message-ID: <0a18a8b8-2e93-4375-a2ae-3e7316cbaab8@ti.com>
Date: Tue, 18 Aug 2026 23:43:31 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/18] mtd: spinand: negotiate optimal controller
 operating point before dirmap creation
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
 <20260811183313.1550425-17-s-k6@ti.com> <87bjb6l8nr.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87bjb6l8nr.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BY5PR10MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d027d7-899a-4a4c-f19d-08defd547822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|22082099003|56012099006|18002099003|3023799007|6133799003|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	SJk/TWsX9J5exHnGyTXbIHlJ8d8IDTRRXnJnT8fQVnV6/cQfQQlDZRJCyBNaJZ2kQbEaoF7FI/MsCyFI35YMKEI5wsk9otlkdbG1hQ0NYFWBiwzUA7Z4zN7QUrO0fIYyNYNLoXCsCnX3Uoh5K+vVnL5Vxeqk5k5u8HIl6MCroX0U3W0mk7HH2R7pedwhkEAEIJtJXDyLbmt+TtFzti3dwyYSGN4teqVJEC9iR6+/UPlulJOVEwUjz9n00ixTq1ep3N9ng+MJpeB1M83Ildm+RBQeICWWXOPiOHNvHlV+VI4iPf9S4CVCCf1QVA6Prr0Vbiwe3vrDs6qDsOk6BY6F+xh+qIITT93r7Nmmm6Tlxs4wVtQ6oIMxHiL1DHHxRK7KdoswoxkgLdMh3FFmuv3xzWQCc//x+Jz8QtLuaKjuhc5bjiHqdqUHCwcR4sCeN1yuJyF4JkAR3FMniWLH7TZxHrdJqNzDTtkZGO809/nFzrwGdhfVNoTq/445plFkwooxfjxKxtpk+nf7TkpXTi0L97lr6au2oV/FJYx8iCTWCcsGgA4LFhvQXY76zL6i+lJNo3vn5S5hKhxlbaPJ4KIm3nRAQiiYYuzTiXRMZLrwRevSbngN8h/RkX8UKrlHTGDld/QGNhj0NXh+rThgoT7cihk0fmkQ6lKVvvpmuqvMX8me6N98njQO1TKhbS9jU1/ThMu5SevhuDqpm4YWD84B6Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(56012099006)(18002099003)(3023799007)(6133799003)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	itI7+yXN2f4cBv54MiVgmectSl2mCQkxU596P0dfrQTB7Alim4OyM70b4bIps2FHG0S4JZv8Jeph8G7igK8qMQyxXWLY5rNjIn266NOL7m1UWGODfbfBGOOiEsklRQgMhi40Bc7DkVTyPvNzelU8pN7aQiR+9WvelxLgrJzsHu3bCGSBBH4EHazk5XqDuSaeDfMmR6WZfeDtWVsbddoU4v3ThZ71m5FXC9ArPGav72Q1XhGjLbIBnAEOWlhGQkQxw/qH2+pgJ2Ja3Y9Rg+GbbECYJgPUc2ruwrxPCJ9Dos+4hs2dbvhWTYbtPsjXBb/CJbpICgY+sEqsVcgtxvjse5RWvl2FMVNVNhzquL5e/vf/7gJUxy99y7t30NXvdklY2hY+enwuy0BcTwZjdkolPzuJH39S8R2y6+q2yo0TT8HMmRPYI4glZsuV8ilgpwHF
X-Exchange-RoutingPolicyChecked:
	re4b6UTAKWa7GwLzKg7z7cLUnC1VynhcT8PM9uYJHM9ZtXkrCm+nmXLrgwxYuAVgS2DZRBGT3GcZJ/3jwonaqAWWYhcLbg7K7aBHM3WH7TXqCe3yX6BgVXvvISwNMbWQPzZQ1601jKpXN7V2VQTd1JdT/m0HKGw+B1WguBVyx6DjrH+FZh+Y652JK8M1jVcdQ9GJJv0U2SDbZ2bXcx82+mKq0X/rAaIR5RNC/yYx3GBApZNtDUaVmHGGwgKuH8D7aNt6uDz1V7U+pqfJ7fDvQGrkxZHfrtRkc/H0o5Vp6/7adm+y/ZkvSaH+sBu+kADuAgeKhRI7oSL2NfYFvcTX6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 18:13:56.6804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d027d7-899a-4a4c-f19d-08defd547822
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEzNCBTYWx0ZWRfXyTaumzB+JjeE
 0EGW57R00z1inAeQyru7OfHdcHzBL4xSXK4jv4/ziUZLKvAo9Sg6J7pqy6E1chV/njuIK7/UPz7
 ynOs4vDwANKbvhg3xSj2kqhqxmUE6iU=
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=6a84a0eb cx=c_pps
 a=V+mzYH1ZSfwt9Wwm8MCB5w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=_5h-cKRuB_vkGlxcQI4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CLxQL0rgH8wBi36yApaDtyPskEOUEb9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzNCBTYWx0ZWRfXwZhaaAa2RTXN
 vnjwcL9iHbkhbKHU8S+5SGXCREEMYklAC2vOFggYqqYdh63nHdQQM18uT6Dh6+PB2r3ni9en07H
 v2A04QDk7or18Rc/pBNmNg3uEdoSeqw5KgwOOEI0xvf0RD+QyI2Xv7P2bYjXXjvDGAdJNFZD6rL
 uyguLNXWq9KZZ3N1GKnlzh2McC0QNoR/nBHvtQPJpPWDOJ/RBkAthvFmumUg2M4DOqmP+8+oo+/
 a16QFNTq7X599EHoBE+j07SKT8DCvhLdvUIxwtvsx3D3jqlrsX4cXbXtZXrmfVb1XFWaX71YImc
 cE8upN6G6A3K1Nu/AfRZRi90ZQJT/1Ks8HDVwsvYpLQkNE1+2JYIVoMxK8Lt2rrHRJt21QKvh7P
 1t2CbddP+kXBPAowKCutX1S4TcmhG9oAzCmfAa9pjRmDzRIy/cJjn7wXxDG1iGMSIhu+fIwC0yV
 Wpd7Zg14OKsY1a6/Wfg==
X-Proofpoint-ORIG-GUID: CLxQL0rgH8wBi36yApaDtyPskEOUEb9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180134

Hello Miquel,

On 13/08/26 14:05, Miquel Raynal wrote:
> Hi Santhosh,
> 
> I have only one comment on the spinand bits.
> 
>> +/*
>> + * spinand_try_ranked_variant() - Try controller optimization on variants in
>> + *				  performance order.
>> + * @spinand:    SPI NAND device
>> + * @mem:        SPI memory device
>> + * @iface:      bus interface to iterate (ODTR or SSDR)
>> + * @tried_mask: bitmask of already-tried variant indices; updated on each try
>> + *
>> + * Iterates the full read variant list in descending performance order,
>> + * skipping variants in @tried_mask, and calls execute_tuning on each until
>> + * one succeeds. Ranked iteration finds the best available variant without
>> + * re-trying already-attempted ones.
>> + *
>> + * On success, sets spinand->max_read_op and updates the matching
>> + * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
>> + */
>> +static bool spinand_try_ranked_variant(struct spinand_device *spinand,
>> +				       struct spi_mem *mem,
>> +				       enum spinand_bus_interface iface,
>> +				       u32 *tried_mask)
>> +{
>> +	const struct spinand_op_variants *variants = spinand->all_read_variants;
>> +	const struct spi_mem_op *best;
>> +	int ret;
>> +
>> +	if (!variants)
>> +		return false;
>> +
>> +	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
>> +						    *tried_mask))) {
>> +		*tried_mask |= BIT(best - variants->ops);
>> +		spinand->max_read_op = *best;
>> +		spinand->max_read_op.max_freq = 0;
>> +		spinand->max_write_op.max_freq = 0;
>> +		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
>> +					     &spinand->max_write_op);
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
>> +				iface == ODTR ? "ODTR" : "SSDR", ret);
>> +		if (!ret && spinand->max_read_op.max_freq) {
>> +			if (iface == ODTR)
>> +				spinand->odtr_op_templates.read_cache = best;
>> +			else
>> +				spinand->ssdr_op_templates.read_cache = best;
>> +			spinand->cont_read_possible = false;
> 
> Why do you disable continuous reads? I know it is not the same as the
> read template, but it only differs by a few dummy cycles, so everything
> should work as expected. I believe without complexifying much the logic
> we should be able to support it.

Yeah, right! No need to disable continuous read as the only difference
is the dummy cycle count, my bad!

I've updated the logic to re-pair cont_read_cache with the selected
read_cache variant based on the protocol shape, while ignoring dummy
cycles. This keeps continuous read enabled without any unnecessary
complexity. I'll include this in v8.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

