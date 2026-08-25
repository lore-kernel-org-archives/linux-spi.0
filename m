Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAC1E0DE8;
	Tue, 25 Aug 2026 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787634373; cv=fail; b=TTIOJDnAJ2QQNg/YuarMqrPqRGQhHoaFHH2MP4qkEq4jydqn1VYsNU4PiJmegfRN1nW5YiGBnsNFIh1C+j9qMuaqrK4K+bpJYispe6rNQ+JUOf1TMPmmY1r4fnYQMXyFOR/4tFf98k41bR90jrbV1X3wEb0Jxit+erFPC5JBIZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787634373; c=relaxed/simple;
	bh=ttI81DtVHrlphtBMIOvs05j3qgH3CTmRwDB7zzwf/nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pww6mXKMSwe+YXPTHXlC4e8I/+YsCC0U/9aO0vik1OErsa629zixu2mqBMbrGYVEmA7dPFdtUt63JfaNUBTsQziHED8OkQwkKpsEc3DZkPAQ4EMD97z7DcWiEY6YS4vpfhEs4Y+WtA9WLFTULGQ+YzK4YBjOuHJEcDLk+UDHuAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hxmzEK/w; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KIw6QUui; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hxmzEK/w";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KIw6QUui"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67P2Q4RM3999458;
	Tue, 25 Aug 2026 00:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=BoQMMEm584LPkJQ60L6haVe0J7ucmpJEIicBYAJb4
	zM=; b=hxmzEK/wt54q9rmpSQlWqdWP65s67o6qIfaCvS5eBuoUZwnOZlOcQ2OvI
	PSaxl1Ng4g/cCZbmQj6oMPFlSAPBH/1WA2Qh1iOxyIRNlGf48LNdqjDYu29aIhvK
	6jxh+SB6DFD/fWVdrYQ0HIdf3JjpP6suw6xAmtLHrWjinHavwqgcybbs9k4oqFqm
	JvnFj2p+5i5rCe2V6BANTlneDynxqwteFDw93XmvZ6YHPriABag5/Xv/ohS/3H0P
	wWpWX87UQHkfaWOKvcqlsHys5EZWEGqoJUW6Rujm4LlnhyS64o/4wMwVItyy3Fi1
	wxUBadtIhMwMxdtp12ihm8LKJMpXA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxgrr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 00:05:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMmhGVi/mj85Y2dwyxo3DAB3uYkuee5EXa1QwHbbIRRqOiwfuDbTT8cNbkhBabw+f4sbtshWDzb7iAIFq6wzI5kvktmHa677WrBbYyZdXnbMMLi1PnDqk31fAH2vtAefIavCp81t+1qw+m2kXHqSjJ/a2cyKD7j0FoV5VGa2qvMz+ewmyMAWb5+YKAbbUn3LPsqwEe9O9mFo/DqQ76Hbciiao4WxMXhmSlnPbfLhf4kEkYetEw4Wsbn3ltSxRc8UccC5KQoZtHzo5DR7kIWDXeGY3XvEErUKtehk1Q8GyJUzDSv3kc++i41xZfux2DpUD+yz08QV92xV56+tzSlZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoQMMEm584LPkJQ60L6haVe0J7ucmpJEIicBYAJb4zM=;
 b=OoWJh/0TM7cGaPJNTZgqzIKKLuz+I9rHgNq9TFQQxEmW0nIGjOsZx8DTE0h4jDzyo0hponSuvj2ps08J7bbIgjK0Zhge79Iizn5U+d1JqBKuacnT1/g+1djV7ifZKHYKreH9lIX2yiNJzZ1FDVElx4WoJUFKsSJp9EwGcwrrvEDI9Za24+ZIWJDLdobjyWgclSBtZzsZj3Pxl8jCi3sQchf3qCfipM9lnxxdiYUd5CyQVI+OsoLZDMK4fl0Rmia6WUAk7DbmjJgoIi2GWj7ZSdH4CnpSX39snEHYuQucGvCVfIv1SgC58v9fPYs0WXtPzK8fpJGKJnSs+kGtgRI2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoQMMEm584LPkJQ60L6haVe0J7ucmpJEIicBYAJb4zM=;
 b=KIw6QUuiZ32lyAwqvCbkUQYrcMMrSGQ+2IjMPvwHEgjflFnCujQlnxbgH/hvYcXtiO/J1eF4n/mkhSGSyEahts4J4l+1Y2Sgrr7B6WW5rZ5mOOY7sixEu4MDCZwLDlx2wWLNC723kLGMYD0XRtWU2ASgvybrfkSOEssd/YBfSsQ=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:05:32 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::82) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 05:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 05:05:29 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 00:05:04 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 00:05:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 00:05:04 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67P54whv333804;
	Tue, 25 Aug 2026 00:04:59 -0500
Message-ID: <505cb8e2-2660-40a8-8533-3335cfab5b7e@ti.com>
Date: Tue, 25 Aug 2026 10:34:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] spi: cadence-quadspi: add PHY tuning support
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fde79d-39b7-4e4a-a46c-08df02667bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|1800799024|376014|921020|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vnw3oMP/tYPraSAdFVY1OOEnImVAGJ6JzkkvOY8exO/fMVskMBTGbGrM9+wLkvw7PXMjwIMDGu/n+Jb25vRBQsRsp133V8K32jJ15bNKnZhg4/AoZV9SeYdd9hpHHnPBpVGPCbjNqhfmQpkLexc+SsPLGNm4fB1gkm7HJqhmzqN6qHZI01Nnvo1/qGMGSkOsqYs6hzAvdhQOSv8jCk+4yS7g+1ZTN1dhyVzVhSuQUcfeGDH0RUmGh5deZMCiS0cmNpteZtdLYv/GHM6UDoMZnHY4ZDKrcFoWJUj2InofNmEmP6rJf3C1OYgFXzAJLCeIGfQfK6MaMBCUUEJo7rUo1Li+MhdhOXW+pT77SeiqQGU13woSEEEEFhoxeMyfoYWmiIv0ijU0p5SDjiuBBrtH2nD82WJPO3lKTydseOxd+jDPvU11jX/HocweWzfOkVdf+Tejv7nm2mZIQrne5tyl9ncore1o/329BCLPHqaZVWFeINLlcDhRNnWFCMpY3kSS0OtzUUNFB+opSjD3FgTM81da0sdVTX0YlSp4wftuhOer77FHBjAotqbwEKj2ZE1H5Een735G5zIesijx5hAecd5hNGILDiWLD8Onfmg4VCoX4lRV7x03D60rcjSRn1Zn0HQg2lrrtFi4W/vvnvrSE5PPwmW1XYBV5tWOyB4+tIg/HnAd1fow+oa1d+WdMr4bNaaKu9aRbs7HYluw9wqTSY6Bd+Gn1qNSk9l37kS+CBu1acl+9p7Z1tmfLbjNBqXL
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(1800799024)(376014)(921020)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XyynGZ411nx7VcnJZO1klLUVX1xbo346nI+YsF8XjPMcsFNzflQn4nJ2TVhfYzuq3TCeKtWd+cdAShy4rtP9Z0P3zbTDd4NqGzmOzkciczr0CCS5OvMirKJUFEI1x7/nQGDCSMiZm8fR0qBGqe3YnrBjKxoz/yqzpdgqksvP1Hu/3vU/BGYYUN9mXD6PzA5HV2Sv5WFfxJSR8m4oi/UOhGEri2hCl1oVEGdh2kTKzHbr3QrWenuj97HfnGRHIJO2ul1MQB1VpEItsz5qvmzxYlDtXY3+HizNnlmBJaANyELL3OMv2oO2/0EgBwEFOumOg2iO76RMRN4JAPbDjJ+6glQk9hq4kI0DZBZJpwL8gBCJkKYNuwvoqupO2mbh16DflIXPlvFfvRtdThBm3R6vF+Ajm/75a9K84Qo0o3gNejOJnCC1IBwTqDjjaISejykG
X-Exchange-RoutingPolicyChecked:
	p3xe2qF7ELgCSog0L3rsygFCxMvJzXXKLGVQnsMEaf9m5JDYIKjpgvYqydh6rLfjEJVGL7GAWvkda9AGClH54nNsOF69+/8uYIf5KMQKgAcwrhB9dIXI1oOEILxCk+QqzohV3UAbnA1o3nRt+vTTpljWo/RJtyoy5b6e1tylUBZEbOK/3s0oVHF17u/IjnuOgrTaIF0Tkc8UveThhUSmDe6+TuB4jhzp39jOthklQmyeyl1ldz6sn8UJJ+7ndColnM/s0M41rofxL2+AfTii/ftMtNXuT3gKsoJKtEVxy4aDyIsZJfCVfJnOfhVFcdlhDQnlf0UfJ1/SChlmmkqySg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:05:29.8546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fde79d-39b7-4e4a-a46c-08df02667bfb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA0MSBTYWx0ZWRfX+Y/n2EVocIL/
 pJLsQ1NX6Ay2Woaxth66lneWaQYYxMDqyRlMpbrHip1HZDppsHjifaC3YlD532GmqaHIRmsZx1h
 aLcZ929iB0tP++j9lCix2CpBZ7+kCV8=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8d22a1 cx=c_pps
 a=2d9FbaPwie0YXhWIRYJR4A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=m1Myg4UaESxdR228leQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D1Dm6gBFVPCt2UVz415IbZFoagbPSujJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA0MSBTYWx0ZWRfX8WTbMi7vPWjC
 k5zyuoOwBxOFi1c2ZzokTp4zgWIH/fAz7c3DnlrLEhKn6VuMC/5CjLVLyuTiYOL8ZqVV5hq5vfF
 CsmIc0tpAgCrZxbKNNp9kb595284xxmUYkFqvsP4/LC0G5xkU8nk85mrqUZMsR15TU47jWzTn96
 2ctDibgxmTymQhbc0aPWwBd4NObyU2MIhzBdpW5k1y5F+PFMQp/ss5ddhIkRLutC1hHBySHkFIe
 68Gq3+bJJc6GtTb6MRhwOm4EDoUePHM5vDYxmUga4Q6SKEMdFxw24yXR3ZFLMhUFspTFm9Me4Ln
 Q3/egQZYLhqv4BegH+KG3mOJrDGTBwf1Ya2pIHSUM14X5gqtRbl/FgPmKo5SVw59/0EC9az15Z7
 wJGJgB0ATXdMxj4mmCeT7eMbphfEywU7nYW6naQjWXcmeI5TB2/p6OfUJyT4JP3qXUuGsrA/ikr
 kuB2LXN4di39SMiJRgw==
X-Proofpoint-ORIG-GUID: D1Dm6gBFVPCt2UVz415IbZFoagbPSujJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250041

Hello all,

On 21/08/26 17:18, Santhosh Kumar K wrote:
> This series implements PHY tuning support for the Cadence QSPI controller
> to enable reliable high-speed operations. Without PHY tuning, controllers
> use conservative timing that limits performance. PHY tuning calibrates
> RX/TX delay lines to find optimal data capture timing windows, enabling
> operation up to the controller's maximum frequency.
> 

A few of the issues reported by sashiko-bot are valid. I'll address
those fixes and respin the series shortly.

Thanks,
Santhosh.

