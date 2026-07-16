Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6B7082D;
	Thu, 16 Jul 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181396; cv=fail; b=AZr0GcuJNv+CxNDvHdD5K6UsoUrbigIIkx4/cQ1/mdsVOWuCiPEJYeoDaKqcBrgBgKBgaN6JH6R3XepUmBjmYT9aqVlQXV+tnP0ng4V1hY/sG30SQeoir01aQ9Cqj+w6Bz53lWO2sZ8hJu57/Q6ZvQIygq78/49NkqbtO4IAgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181396; c=relaxed/simple;
	bh=0J3MoVISUvq7Cd9KBDbFaCdoLDsTeqCFav/WFmM9B1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=htNwAPAT6wwL5/DM0QuJnqQp03/U9S0Lp52qixKhw8CfgL+VmGW5nkxAqrFpukYM4tbju6ZHeht3oB0oGYNuH0pZCdeJI84R575fuJThM/gC8LbBP0k0o52cYvL9yNOCUf/8FjpqUbp2kW6tmN819108gSaDA5oyp1s4fHV/vm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Glem42Tg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oxpMZKJJ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Glem42Tg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oxpMZKJJ"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3uF7t2761611;
	Thu, 16 Jul 2026 00:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=kaiR0VXqRNXRdPCtHk0QULVorybZPJ35fArMFW9kY
	4c=; b=Glem42TgVK3K0aqdiBZYlW5MoqBSJJcQx4o7kPMScjPqPaoSTg8MUhM7z
	rxPs3Msh6llPxcULg44QM3eN7GgmCO7ee3tDuLcjWhRDPasBBEKQJrSXr8lIApW9
	iTeKUCI54nlJr+vvW0D5y3PhEoc5XV04Bw2UJ2mmda0xVJjr8e18vegMhvzT3IeJ
	C99LJ3k5NmjwNi0h12kS16iQuh7jypDJD3RAFuzNLeKwA84kTMlZ1R2iA4uknz0N
	Z/TyLtXs65KRhq+brD+rM53HcqDoFrmdcSZ5e1Ai73vpA4Fc2aa5nzLUxagpQ47h
	vcEISfuu3nIRAuDF6tfGylxCRS3VA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe96tnpym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:56:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZHoKXZmCaoub4SYpf2YF4e5EgPz7PlVaDTYxs43+MVOtHc/Xw8K0FNIwxJRLf3xPETqBNYelcCELAD+T9zZ4K2F/FjEivk+dKrD1I67dLh+l5l2slV4l/fUPO/UU+zzJ8a3eOYV7C+RFn3/KG4ud5Uxsylp90fHFqJgcSbGKOGROqmILjXG8RmSlcAThc3RvdbkX5OaQwKaLdm7FqBdP9O+LRBfyndYpaVPZ2OPbXL2MioYczPlA9ANnY9ATJJ+8W1NoWRZLfIOOP2ruqhFqyNCHKGuIlt0W0aIoKDhdEdr+RZodKgQ68kPonOBBGnP+7RKv3lk+wvAf5xBhguu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaiR0VXqRNXRdPCtHk0QULVorybZPJ35fArMFW9kY4c=;
 b=ZgroIz581OPE4s532TtgsKrOEH2T5IiFqo45152Y/NBEjltWpXnXYGgNuvqo/JoUFWJxUQs8onGc6SQMGkrEj8tK2/LXjnxTRP+czGX7JsNfAVhbZSB/izqdEZotThvDDu3QIqGssjyxz8hJa09xoxa7wKKHEflReqRqoD7EUoA0RX+/tGWVIF54XkaYR20iPhSavCniJnzT6s3oI8kG37EY+cDvX3/TFlvdFh3kycUopCoBqFdcwVpQej2I5rBo6mJwtZdF+saSBCQ5CzX6ZUwXYWWdRPhGpM01QHh1W8YSxY6XnnRAa+1OtyVA8cqHw0ygt9SrCsNGuBBPHI6Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaiR0VXqRNXRdPCtHk0QULVorybZPJ35fArMFW9kY4c=;
 b=oxpMZKJJxyspJdhgsTvf4nCLEKaalZONjbXLbZiBaMbWVPjqwIwqKq9Xddwuzymi9aJhfpQUIC7eoJlLDbC2VnuGm1QQQ1n09uE0ks+m2WbVG59GgoGHbwreeEFm9tTQFVRRpT3BLz/bW8JDzMM087yzDMsZviJtURBZJPYDTzo=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 05:56:21 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::2d) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 05:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 05:56:20 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:56:19 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:56:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 00:56:19 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G5uEmB634372;
	Thu, 16 Jul 2026 00:56:14 -0500
Message-ID: <f22cc919-06f7-4129-a18c-2559164c464a@ti.com>
Date: Thu, 16 Jul 2026 11:26:13 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/16] spi: cadence-quadspi: add PHY tuning support
To: Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-9-s-k6@ti.com>
 <bc3d98bd-bfbf-4981-8c14-4ffec0f55f7b@sirena.org.uk>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <bc3d98bd-bfbf-4981-8c14-4ffec0f55f7b@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dc8cc0-26ab-4b3c-6373-08dee2fef5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|6133799003|4143699003|22082099003|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kLTxBewF6649v0DyOlwYrsuOlEWNX8++0xtd+yujqE2/8wMdHgbllXZE5X0C9WgO0y4JGmUPXShaYlvESAL4va6zwBnkcVmTV6Hn0iUtEThHB03tw4On+zMCNo3WJGmGa4qJbck5Cs4unfg2nA5s66OAzuZvajpAkJTPHSQ9VCzuUj/92afle1ONknd56rCPpSajVnoDwZdM0eF8pgkiEW8JPu0kmeB+mOUXqMpZIeLfqqnBStjwmxzfGR5Y0JCfSAzFWNO6igt5AdlvUCE/go+T5T4yIf3Ef/0/AbnIcE5Z1kJyIQpPLVuFaIWVEEDN68ZCAD7W1xtpRxxOs+55biQMrTCJaxFKHDmLjd7hTGQ35BUSMzeV/4Kn+gIxcUnU8FgY9cJPUT1/4CcYpmtZhArZlp0Df999slL55nlrP71zBkhtPY6OLBIFxc0NcKplH0BydwXmVKDZ6hgKDCmM5/rmAGh1hVv44+Ke7M7g7bDRdgtd0Ddbkt4cs8+p8RH1zTpEuWwXTk4rc5himVEblsYL5ec7OP/ghaVFZqQ2NXmBsMmt+HQLKjS3K/x32hCRLIR37zUEa23wN4VaytZheafNHBr60mryKeFlixJjGkZUAa13hVxEXXMjHR+5ADFY69ZED/q6jJJ7q5xDn0qxgyTzH592apRLNTYYMEQydXmxE0q5T37re1RCJX29pYmq9w9mMyWPXJ6NSubvsVe/wA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(4143699003)(22082099003)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jldRQ6JA4oy52xlS0V3nR4wDYzNB3BnqfnhfopEYU9tTQJTzQ8ehHUGezJuB6h4VDmzfEBqaFBhAclxcuvKSlQYyBq83NpLe2f5Huy/6jSB5iNSsoOm4jCDdLClhYD/NArkMizUe9J7En6Ds35DUvbpRuyDSP9n/GbZQsCFCEknBRAp6K2hIvGuHTyDhLAQYA9F0BP8qymi2UCxEz9t04bOZZjpVwEsYu7nFGa+qcRYD/aNosBm2aMiGEfuV4Tl3XR8OvAUXvNK17v5UJ2isYtrZHdtlOJMnl5qZgcr7Qoa2l2qyJURvKixjxLRX5UBuql/W9KtXoeVTJemikSAxUm2nADjA6Xz+3Kb7trf/z/r1xQ0fhREaNvN6aOHZchPGJwusVhuQSd2gYTePRZNq82gxs8DOvuQKtb1P55Ai8+E/sAKusZu7GENfSzPXYMcQ
X-Exchange-RoutingPolicyChecked:
	Sx9Hz1W0KmLUeYNXu6o4ersQqzcngFsrH3Lo3J30GiNjDxZxhyjT6UTm08nkJWXZJ8MWGobhLTt1lIYbJLn5sy0DoabTOAq6m1mOjVX7pd/zoZ0kgjdPwrsBbJ+2Hm+Mhkdl8+IGx8Nu72y/ZoxnQnbQnYXxy2b89XTJnj53JhxEgzFDfhR1+YBpSrycrqLnegqCccgkNRotlCIAkA8Vjfh78igPUotm8rrRejy3pZfUNNHuFxaeEwuOCVj+Dsl6wmriGehQZL5LlzXbixCM0cJt0KETpxsztI7FR6xmG4TBU3L837J48ONa6N7MlVdPBRqn2GuZqWXraypEejUsYg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:56:20.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dc8cc0-26ab-4b3c-6373-08dee2fef5fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-GUID: 0JdsCY25aCteQdL4e3SmOUda2Ktrsg3U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1OSBTYWx0ZWRfX3daKjR0ZJPoT
 nX4eBYc2LA8QlUSBxrfwIQODWgUIf4AOyU49LcDShuNf9gvkeUP5/fb0YczzlLoVOTcSg5UCNqq
 JMpyzEj71fyo3VLBDVYlneMco4hcI7I=
X-Authority-Analysis: v=2.4 cv=VbnH+lp9 c=1 sm=1 tr=0 ts=6a587288 cx=c_pps
 a=HD8lxhnvDrzpkXyYnuuseQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=hu4gBHimjtvF_tcbHWYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0JdsCY25aCteQdL4e3SmOUda2Ktrsg3U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1OSBTYWx0ZWRfX0SmjaLUTu3jl
 XEw3dcmcfaQuTbBALJdESk/W1UkYt92/JMn1JWAXPtmJfGIH/WtEU6zjr0JoDaap768DbP6XCfH
 zxJu8mrfjS1fxAHs6IrQ+XHFIjWqGU/gjFZRh06KVgV3X0CAAw1gi8llX0dTKfvKuESCkVFZRmX
 UF+Hj3bZ4JYmyGtzEQ0lLynr/BNtf6PIpoqaGJa6TetQcGpc/KoHFReUUJpSHAgeYWZ9J2ZpbkR
 08gDH1n9hlNDl7cNmxLRGyNA5wds8Mh+Y66nkQiWm0SYOtt5q+f7K2M22//ejCwVxYvtQ7eGdLJ
 ELSh59QqfhDpr/4U/pzZuSGYjxRQAaLR1aigvPGYgQL5IQ+jNfxT3IVfk3jibV7Ym4QQFRKwc9c
 DLKpnNrI4K+6q+TLi2++QokC+FffurVp5cXs0xMc+SMeMcbHWLRwZ4ZEEj4iLWGLv/H9razIyb/
 0Efje5Q0aaQIuFMbECQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160059

Hello Mark,

Apologies for the delayed response.

On 19/06/26 23:03, Mark Brown wrote:
> On Thu, Jun 18, 2026 at 01:07:17PM +0530, Santhosh Kumar K wrote:
>> The Cadence QSPI controller supports a delay-line PHY for high-speed
>> operation. Without calibration the PHY is unused and read capture relies
>> on a fixed delay, limiting throughput at frequencies above the base
>> operating speed.
> 
>> +static int cqspi_get_phy_pattern_offset(struct device *dev, u32 *offset)
>> +{
>> +	struct device_node *np, *flash_np = NULL, *part_np;
>> +	const __be32 *reg;
>> +	int len;
>> +
>> +	if (!dev || !dev->of_node)
>> +		return -EINVAL;
>> +
>> +	for_each_child_of_node(dev->of_node, np) {
>> +		if (of_node_name_prefix(np, "flash")) {
>> +			flash_np = np;
>> +			break;
>> +		}
>> +	}
> 
> This isn't going to do the right thing if there's more than one flash,
> that doesn't seem a super sensible hardware configuration but I'm not
> sure I see anything stopping it being set up and system integrators do
> enjoy differentiating.

Oops, I missed this while testing with only a single flash connected.

Thanks for catching it, I'll update the driver to store the offset
during cqspi_of_get_flash_pdata(), which should resolve the issue.

Thanks,
Santhosh.

