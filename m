Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4E53A8AB;
	Tue,  8 Sep 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873347; cv=fail; b=dYjRV6h1dXpao+vPObtUfn0SnCGBlfvE7RNvHWqzjPJ6ZaoJhnTVtPm9afgHA0JfJfti9EpojjfgC321gRSZvuUjKW/HgBhzUrmaBBFfFxdV16T7TBfaIqgsYR6141TMBmA7p8zb2Gf5zri7dXJuUHKGXImty6nlNAr8WGnRtQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873347; c=relaxed/simple;
	bh=+dIjTny25Km6qS5z1O6oma6DcauRiq0PW63yz56JsmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fiAKmJ7bXqMfmfhbreKJJiSDnbRRIa4j8N90dNxoDvANIqsKEuhEYW6ps9qZ2wimPXMlQmV41f9n/KjhrZ3gGiN5JtIo5EfUyZaShC+iKX6GKkZo0LmFgBN9ouS+pFRhzlUvvm/1ny5R63Pm2lwb+aamL06sIcaye0GFF7GDGek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Rvq5f/lr; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a8qAbSEe; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Rvq5f/lr";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a8qAbSEe"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Con9E1605204;
	Tue, 8 Sep 2026 08:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=aA7Th7lzUdMDJFs7Uye49ulVRSIpHBW/yFevIPT52
	NY=; b=Rvq5f/lrTK05pNPPrBBzHdOeZ+1XJYzX63U5naOyg75EAKMDDRH4lEvm7
	MqtYMwEeJqsCg2nFWfrfNsbopS5IzBbOpo9Om/4Uwp6JmHJEinJW3OFLljPgX3X1
	KVsYXG7O6vnHLLdkn9+GihYPSq/rr9BzKSvyaIJyBpRQfgP2ZIxnKuBFheDDRGW6
	hF+vI+EYvHmd2S8LBql3xCG73VCucuh9GinWdJlEh7qesf+RKyWNcLLPIOLS9PDv
	1v8lhbzpCL3kVn6bpixjFSfHz+/pWWrx71qRho3xRAaBtM0yhEOpiy6Zh5CzTel0
	amu4EEP+lF2Cnu/dQsp+frFORQzWg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940k5rn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:15:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFmYI88gkQoqGR8w3SYCUrYFTVpk22B3s7UqgCyUBE4dFe85akZFbb4EexJHWT6wkaPQm7FZcJ9EpoyFACM8f6iS9YUZVOmKlzMKLE1/GZJbhz4wgMRd88+749+c6Pf2bYZ/qjQHc8udZcO+ou93oqRyctpIucoHjeED4l3iJh58yG2OofgdIJNiDILcfGaWYvzHDbHnDAcQPG4pUDHvViAM4l1rmMcG0bmI4LLPbAoyc4B/NO3ZnOF6f0aXvoHaHSp8WJasxnIcuaO6AqBHzmXRHSGupzpTpJNh1tDsJMcYxXQGBQfbpO9t3wUP3H+JMrHsRoE8yMdThc4lMLxWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA7Th7lzUdMDJFs7Uye49ulVRSIpHBW/yFevIPT52NY=;
 b=ucwqIYvE5Q6XHI5rVdpQ+sYEQrvUNv0zWCQgoAz4K8mDcC7Fg3WnIGA8UD6lLSDvutBFXRVNIge0Dw7tV24EEhrxqUYEa0gjNhZH+kPPYB44h7msd05dGXmOd6s/IhK0ILinxqWTflDiV6Q0WwvKjCgTy+k5WMLe+DFtNEyl+fCpJfTnMfXltdgfoEP8fUy4jLsbBuWnV+oI0l4m+n6go0JOqnzEUJYueCu8NtXzaSjZK+WI0JEASY2SLnfW2hehMyTF4EzOr+/q+wMAJhTp4ozoOSHiZFi8P4EATlpKsuM0vs3o9xpJs/m7+176gG4LXX1spPn2nTOC9dLXBmpaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA7Th7lzUdMDJFs7Uye49ulVRSIpHBW/yFevIPT52NY=;
 b=a8qAbSEeGRP2+tIPuvYoqmRGH7/7THhjqN1U6F2/xJoMackoc1lEZ3ZvrLjOBLKfsRKfjUYUXaSq1Mn3eyGbC37oDX+AvS85DyKKlKtRRn4UKocHKqUgzAlSX6ZZ0xlkOn2K49IfcfPr5m8E8sUHG0kaItKCAk5TadOA9VW7sZM=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 13:15:15 +0000
Received: from BN2PEPF0000A98E.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::37) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF0000A98E.mail.protection.outlook.com (10.167.248.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:15:13 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 08:14:19 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 08:14:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 08:14:19 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688DEE8t2519261;
	Tue, 8 Sep 2026 08:14:14 -0500
Message-ID: <693550b9-a1fb-4732-b6ab-b06fd6b11423@ti.com>
Date: Tue, 8 Sep 2026 18:44:13 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/18] mtd: spinand: negotiate optimal controller
 operating point before dirmap creation
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>,
        <sebin.francis@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>,
        <s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
 <20260825171737.776052-17-s-k6@ti.com> <8733vp0yuv.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <8733vp0yuv.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98E:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ae45ec-1d33-47d5-babc-08df0dab3784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|82310400026|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ck0dsl1+zcu0TE9ZFj/nIM3ZfvKgiUy/SlsF2n1SDA7qppGF07oxJXunCgG/BMEHZThgcu3Q2P1hUZV6ZuMAWcFbEm+fi+o6qFpz0Z//7suOuC+hbRs+jn5upn4Clc4pJaw0uOUo+CzXVJyIJ3/byvVXwoaZagll6iL5MDBNSvNfLsakUZ7/YFG49Ik1xx1LpnRCz7Wt2o7xRlLZZZRcBaKPqFHGar4d88VyucLo6hFdde2OImHEiyGZ5trkw4ZjDl44HlGC9doU5baAtiIAphMKxmqqer028QTYxQgMO4lOkdgWikchvfL3L4l7JTd87YTjwGiQCI4YJ1TR2MWhhJjRMQAcZJnVI2iyh5QMfKK8EUAZCmwxldellfKlrfZtXj+bZaCXcULxIpWdy1MTc/3Gt3IuFv7iBl7zolNp+/NMCKPk58zHXNE6z2xs4RCziVbM9FsdntWQP9Fh8bGhFHc3SFgWPnca6UOLEl3ITVUeKLtTsYiCaVYhMFWfoGivKS70YPbWtJ983VKb+J1JgYfKENm6gw8HQ53W9u3M/KYbNVEzo//oty2ZfwIvbrER5+LepGpux6SvpE3do8i2vDhqFjjRH2fsCWSrklOzEobUHcB1GcRUiPMQfF1by0lZUPfk0Wm4q9+Ncf5khyhIbENRldLCzEID1PorhzTfPbj9Y+Mv92GxcbLG/Js612Yne7Eeki/oSYU8hhXEArW21g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ek36LFRJcK6iJ2wjrPwX3Ojcgi3eJwy00KEheTEDzX57Udf2IE3Og+8VoSdiHQnnm4kM9ibKx/LRvzc9emPT4A1pxag6pfkzesj+vQQ36D92lft0EcS0E4K184UuZmftuo1P6wHJylFz/V2ljSQXNAfuQuy3w2MzSqnZIbcAalSJ3ZmngUa0XElb6BP/cnIU+OWg3Mm1Bg4DqEo7wzf3Y0sl0yZhtrH4h+WhhL5wcaRw6SYqJTYY7fjrXCj8xJU8I1EFdUvPgSBxTacU3jdhEN5XQFpDw0kmLxNTA4PF4jl/T2A6Ze5zGgqHc0HEbfVXZ70sUd35Uoxc61b/ilcy9oYoYQcVoBMa0Ti+mBVpVdJKGryAoRAvhU02l9giXEwHSLZNrO82e1Qo4jq4fR1t6EK1XXl3kHZdeqtPdgOd3VCfRCMTrvtUc/X0k0A9EhOk
X-Exchange-RoutingPolicyChecked:
	W+M2UCmgaESC/fgReT3bs5fi5OtiDoyfrsXzcEgLkMzoMMWbCnYG03JbgnuL5qQ9/Fz3CyhLM+TCF2Fx1cmjzAnCMDBfSK8XtgJNO2ZTOn4hk7VJowhoInUJj3wvVX+NfAUP7ooYgwNbNVgA49fbD06lCp8XOHyFqx0jzaRo2HSVepGoLSoHaNAZe7+lvnfBT9qtFmzzqkMM1Cr/9diedlD2ERSUEdvrE/6Hq/T9gJXqeaDerbHUY3xqv7hI/HxlIEIS4QPj4D/MCz+ReeTaK9bWptl5MKW0ysdBN/w6kGafafU7ykyEq57BsT9aJr3YBB0xuD7dpBHLzmwviiNh+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:15:13.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ae45ec-1d33-47d5-babc-08df0dab3784
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-ORIG-GUID: fRFXX3AUFbTQhVhaplfsS9D-UdTQWnB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0MiBTYWx0ZWRfX0eAZ4wuFo+zf
 /x94jgps9Ue/SKFEU5YQn+dnUDZ8cpHNkFGKu3zOfKUmC1rn31BzdegIHTp5OQmYbdexIG8KzBP
 Bw27yqMpvoduGIb3PsWdZN5SlB4ea7LaTJJ5xAFxeOI+EAhR7NXSxbu6kz1XXcWabFk5iKUtEzj
 JdqQK5dN+L9xZ3LF4IYfNJQKz39dqmFFTbNCA5MZQcwxAIx+vLtcdBY7RPC2KrDr1tdqRpcj8GV
 G15a6piUbCNolPgnNFk9C0Ycr7+lsaJZPdIwqtgUx0tKsISODhiaLT2X282J8/mjLREqWLOf7YF
 zeNwjrNvibHcUnZOBMyVEhpQsUpaa8x7mdPh4FBeAfg9b79PZFRu0Fql5y39eajZyswXRYA2sNX
 POaubsFTgjxb38AFPWY731JQ6hTnMPb5xZ5wZKrOfCBVDnuLB3N9OAWZk7ESb+0bd4pah/TExnp
 zj4i2alEQmxwP0CDkaw==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa00a6e cx=c_pps
 a=3isWwmYGSdluMw1j68YAZQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=_5h-cKRuB_vkGlxcQI4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: fRFXX3AUFbTQhVhaplfsS9D-UdTQWnB7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0MiBTYWx0ZWRfX7fi/ZCuV+Jh4
 lPaxt0J3uyC9iZu05q0swElcDiuTOf7PdCImi+fT8g0KtbF1yOudBjx46519SFkufjD6FCtOYJ/
 Geqk/480NbEt5TcWSc38DS+MBrkbumU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080142

Hello Miquel,

On 04/09/26 21:53, Miquel Raynal wrote:
> Hello Santhosh,
> 
>> +static bool spinand_try_ranked_variant(struct spinand_device *spinand,
>> +				       struct spi_mem *mem,
>> +				       enum spinand_bus_interface iface,
>> +				       u32 *tried_mask)
>> +{
>> +	const struct spinand_op_variants *variants = spinand->all_read_variants;
>> +	struct spinand_mem_ops *templates = iface == ODTR ?
>> +		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
>> +	const struct spi_mem_op *best;
>> +	int ret;
>> +
>> +	if (!variants)
>> +		return false;
>> +
>> +	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
>> +						    *tried_mask, NULL))) {
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
>> +			templates->read_cache = best;
>> +			if (spinand->all_cont_read_variants) {
>> +				templates->cont_read_cache =
>> +					spinand_find_cont_read_variant(spinand, best, iface);
>> +				spinand->cont_read_possible =
>> +					!!templates->cont_read_cache;
> 
> I believe you almost addressed the concerns raised in v7 about
> cont_read_possible, except what you do here is still a bit dangerous
> since you could re-enable continuous reads on no_cs_assertion capable
> controllers. I believe you should clear the flag only, never risk to set
> it, something like:
> 
> if (!templates->cont_read_cache)
>      spinand->cont_read_possible = false;
> 
> With this fixed,
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thank you for the review.

Fixed as you suggested - spinand_try_ranked_variant() now only clears
cont_read_possible when the newly selected variant has no matching
cont_read counterpart; Will carry this into v10 along with the other
fixes.

Thanks,
Santhosh.

> 
> I believe I will take this patch only after Mark takes the batch before,
> which looks mostly good for my non-spi-expert eyes. Either Mark shares
> an immutable tag, or I wait one cycle.
> 
> Thanks,
> Miquèl

