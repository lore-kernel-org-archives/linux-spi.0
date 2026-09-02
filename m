Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD940E8C1;
	Wed,  2 Sep 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342406; cv=fail; b=PbeFzT1+SQiGgwcOimhSNc46ROXQzfiyHyuj+VSsg6Of5owa17K8A99kt28l4Y6l30u8Rir0ZaDXP9Lolg8ASStNJugaVE1M/cqlbMxRhuxEmEtMUfdHCTIx/TadneUo/zlgknH6G0eDpsiLNCaKrBAAFUAcGlCmqCYOCYTArLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342406; c=relaxed/simple;
	bh=G51/QI41ojGQx5yYh+rjPwUhzPsvPcVRRFwvU5WkRi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XKcrYyG+bNFPYG7wNR41tKGjS1IOa2Xc+YRINRq8unjbWfOwORr8PV4GwYIsUAGR1knbT7qAcxxe/iP5VoAjQeHFzBmEtILC9hlbBfB2XcaQ7KkgCHjPmUUzX1jEEt300k/4lXDZ2H6Ua/JwYrACfCZyA0ElEEYs8K/FuS/rkpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jNAQKJm4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XxL2hks6; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jNAQKJm4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XxL2hks6"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6829Otlr1973934;
	Wed, 2 Sep 2026 04:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=h7Lr7RUg2XLtRiv9IHAgRQsVSRjyd19yr0r++Gty6
	nU=; b=jNAQKJm4wau7/NiSLIPKEiZfYdISoI5gmicBeykuobUGMEe//tfjaizOW
	JcYOCknLBol6dYusL15i+vFbG5EfpI/nBUSY+5E+LTRNWjgpwdJz7X/s9feoTjiZ
	TeHDk/qa5m/cpEnkRG/UUqBk1VlwWv+a4ojVMRRjFUunXTcbM0aPaBmNGNYyDo1P
	9+ORAJNZqP6mu0cApp9MI4+8lBNsWQBMo32uCS5ZqRmvCQN4p2q3Qss0jnaEcJr8
	rvsjzuMzDz+DI6vNQtmTPFpSp+xklXypHUDH7dlnIgZGDC5hETr2R6UXHNpVltKF
	rTyhGpYOf6GATisA1vJbEdJzBSb7g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ge7gqb3hm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 04:46:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXJyO3EJU06fX1EPEkhObNYapAKoJawAFpzkFLmM4nMwzvHmZw7gLQWaFBohjjX8kMs2/bqHX9NLx8vgTnFWc7hPiwXGw269COUgBEiRJEhVa9ryoHacALjPvEmGYMAEZIp01I5S2M4PKY7oNxRej3POFKTk9wjmCHpFfNr8UYm8zJ1F1CAs0BQVe18i8UQvHgWiItsNXp8UA54yvk9GSqxxLZekTpNfhnoB3I6Zk/Lli8ldupLnMM0l/yVU8Vz48DEfo4qo0rJb3Nk3eB6wDFUjLUGK0KX5cwhq6xXiM7OA9ukhaP3BZFL1H5ZHk2HectK43wixPyf90Ogpt5PzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Lr7RUg2XLtRiv9IHAgRQsVSRjyd19yr0r++Gty6nU=;
 b=Zm/rO4yRtvbDvcpoemqRM5ED+5sKaTtiSvivGpcw2yni7nAx+3lI30PsUznjNHAlsbBst70h8ZVQU9K0rFjCJf6lja2RIysvolwh3YHXnEoW7F2CaBly56Y8QVjnD3oChaTgj3bCBFNmVZ3W581o7VDhfj//rfeM064UBsrNr0TEFcG8sJkO+0GgKIMz24ZEL7/5qhZrNVYsnyP9XKqJFf8O/TwgUaU9NBHFV97ORCIM/LqT+471GoLzeux+3Q6yVy0E1hoHPdpMFzUXnrbz9X7tHCmLKNGO8+vmZnHCWY692JNqeq6T1GKX6P/l8OXIxuL9ZakQLiTb0YdOM44eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Lr7RUg2XLtRiv9IHAgRQsVSRjyd19yr0r++Gty6nU=;
 b=XxL2hks6p5rz8GofHDASt75UROKryniruyCHlgAcnvpQAjxK/6bRw8LMsRTR5Ej5Ti25xlM+magcpq33Dg6fVpSGw+rBjcJZLUEIqOuHQPwFfkMYlgQdv11hYjkyRN418265aJsnff8If17tiEz/7iIdlFs6PIMKL+9XlnQm8+E=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 09:46:18 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::84) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:46:16 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 04:45:31 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 04:45:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 04:45:30 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6829jPdq365858;
	Wed, 2 Sep 2026 04:45:25 -0500
Message-ID: <ebf61988-9fe6-495b-b1e2-eaeba9f6b98f@ti.com>
Date: Wed, 2 Sep 2026 15:15:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
To: Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>,
        <sebin.francis@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>,
        <s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
 <20260825171737.776052-9-s-k6@ti.com>
 <8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|DS0PR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5052d7ab-ce72-4bdc-77e5-08df08d70890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|5023799004|4143699003|10067099003|6133799003|22082099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	4pw1GW4Rwcu7Aa/Jofehx5fHA+SzKUc4n4ORrz6f+6prQJfWxJuVdK00QT+LGX9+3I4IfWrvowYaGpNOr7G1b3fiPgZPZEggW2MK/weIpBlIwvb1w50EpZkoLYvooxkFU/DaeyhT61q0JB434e0buG02w79fLcu7HbB7Fvc4U3SqvG2Gu7J0A3rRc3+GZWv4V/gYyZG6Q7iF3+C9Ds3rXPaQ3nlB/sdNQfuGvLODAyED/KSQ6AoY+uXAscK4sEl0meRY/hkuKeYpeHJ7OcclqgS7QgAUwEqQi7Ujs7+0C0dOOnNwPl2Yy/c3gno3NEAm47/UNFTf/qrXODfgJJByEtXYNdzCZqaIscRHL2RCZrA/GTbuuUEA0V9O3xa3KyLZmLh/n9cVIWuRsM5tREl4xF1ylax9MFFalr5pApujAVhvmPxI/bVRo38e2t2XStgDq3RKBUAAkaM1a2FPrfBqWSqE+/Fy19JsviegLmIhuzGa6Pj9tv4AQsy34KzOYkJrzxQ249qrdUWLI8j/kTdkWk7NPRM2Wg+eh2ciOltOb6E90di3jc+AQUron/zZ018hll0bZCxeviOfVBy9aYlFmwjvoL0PAPvFq1AQUShWYfFBkhVJpwcSjNRv/4HQzd6RouTZnqTXmdBQsXoT6Mda4Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(5023799004)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l/wMB2+8P8NCuqHjM7riQRLEaDPmPVV+lUuGdDVTHVfODGWphXKdAcd7iOQOFha+JnIxNsrw3e0fJ9T8JwZu0JVdEU2EIxVKGLj63m5/Qx/y3U06UlbgJrsaMRx7glwpeJkAPhHeLulHk94AmVpcs1CP9pzHSKhumlhr2SrSbHNnBWU/sas/7BLZSfA/crkntmIh9QYFFwh6jm4+9sMogmXlLi5IYvn6VxQAgVYPwJKOaHNdbBu2Re+hic3kViOi+a5zZjYNqnP5rnc5ECZI24XbmnPMCwGRHnyEPFpjnk7P/BD9SnRTcCRCyB/NK/kvaxDqT2W4qzqsAEetUdN0AGzf1enZcWokeBSv9Ugi6VzDQwpDmMZ+99yCY1IVnwMcq1/2y4xmDMJzhoVUm9DsQmWfRTCG1v/Pd+zsv/GanxN3Oak9XnJfya5OxKc3ZRI7
X-Exchange-RoutingPolicyChecked:
	26zXtp7hX5RCsPLcEx+m1mknMWaZ6a7uFKa8e3NoQa0BPGvRWEFxr+EEgHqZhT1PktYsLvR7/S0wNGOilxeeYBgnhZGtU3YsSaO/y5TkiOXFwyeSplws6Euhq4PI8Cs7iJp8fvMIPlynDfyUM0tTyjR31d9pkiB5JSdGn8jdgsBZPPFVUyiVB7Tc1bRx+Ow8EofCJoUW7yXboDqO8Ep/Sc8KGBe9QiqYJB00pikL0Ey1Nv8KrxrUZohl4HRLJgLbNh9PXPW02EWJ/Tskt+xoM0goy30ZOmvI0WFFGoOBooEhPnapDBdBueUiPOgfCuXB03hi/LlQ0DNNKN5tKm8mXQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:46:16.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5052d7ab-ce72-4bdc-77e5-08df08d70890
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Authority-Analysis: v=2.4 cv=fZ6dDUQF c=1 sm=1 tr=0 ts=6a97f06c cx=c_pps
 a=WlRzkYvQEyJpYq9ouSSplg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=GnvaeAglAAAA:8 a=lUXWvxQcQGcwV-cD5oUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VJ5Vpjzos2rChJpMZTb-EQVV6hwK2LMu
X-Proofpoint-ORIG-GUID: VJ5Vpjzos2rChJpMZTb-EQVV6hwK2LMu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4NiBTYWx0ZWRfX2mef0pc3DUAS
 C1YCsIoibRf4SlcbufbSYNw8slsN0PDj2GU5ThRZpiX1SchI0sJ0iao/Taeptgp70Er2veVtspK
 q2vKZhH4Vmn0op4JwuaoHPlS6fN+2mU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4NiBTYWx0ZWRfXzIkIWYzBE3yM
 6mXeoNHPcPzCzAXlVyVmzx939mdUAevrjEMKnt3jydvAB4Ai81c3f5vn4Mn6HefeBvkXbxs4hrO
 gwZWyxBAr4kSkKMghjBmJd5aF+tT78PujP3WSfR2jDOq6T7MKUlBO+6Qyfx6dHPVP35AW04Pt9e
 k65u5D33WD/Zjdfv0PBjymmuY6VECyAT3r8QGkZRQeOzndToJ+P6ngNl/K9uE/zCPOsaGMLlx/6
 svGMnTj2n/4/oZpHuARJLD6ef9Qd3KyPGo/LZF65muck7Hoxnp3AZ885+9wM6B5hhwohvtV9AF8
 djanf++V1R6K6laegXWWjGICX3v4kBE9L8CakdPrWK/YSd74mWE8gN+IbQZ50/hVsB1zhubzoxe
 P8+5LmHh8Kne5Pj0uUtt67Yn4XepjyLObfLs1oNZSbJXkUemieY5DESuLK49fwuH0VJGyIKcPO+
 rRTy8sZnJuRtXyzjsZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020086

Hello Mark,

On 27/08/26 03:13, Mark Brown wrote:
> On Tue, Aug 25, 2026 at 10:47:27PM +0530, Santhosh Kumar K wrote:
>> The Cadence QSPI controller supports a delay-line PHY for high-speed
>> operation. Without calibration the PHY is unused and read capture relies
>> on a fixed delay, limiting throughput at frequencies above the base
>> operating speed.
> 
>> Add an execute_tuning callback that performs delay-line calibration using
>> a known data pattern written to a dedicated flash region. The pattern is
>> either read from a NOR partition identified by the DT property
>> spi-phy-pattern-partition, or written to the NAND page cache before
>> each calibration read.
> 
>>   struct cqspi_flash_pdata {
> 
>> +	bool			use_dqs;
>> +	bool			use_tuned_phy;
> 
> The AM65x has a fun erratum i2189 which mentions that it requires
> disabling DQS for writes:
> 
>     https://www.ti.com.cn/lit/er/sprz452i/sprz452i.pdf
> 
> which suggests we might need separate controls for read and write
> operation.

Thanks for pointing this out.

The DQS bit in CQSPI_REG_READCAPTURE is used for read data capture and
it's not consulted during writes.

However, the actual i2189 issue was that cqspi_tune_phy()
unconditionally set both PHY_EN and PHY_PIPELINE on both read and write 
path - non-compliant with the erratum. So, I'll split the tune_phy()
into two separate paths for read and write.

Will respin the series with this fix and some sashiko-bot fixes.

> 
>> +static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdata,
>> +					struct spi_mem *mem,
>> +					const struct spi_mem_op *write_op)
>> +{
>> +	struct spi_controller *ctlr = mem->spi->controller;
>> +	struct device *dev = &f_pdata->cqspi->pdev->dev;
>> +	struct spi_mem_op op = *write_op;
>> +	int ret;
>> +
>> +	op.max_freq = mem->spi->max_speed_hz;
>> +	op.data.nbytes = sizeof(phy_tuning_pattern);
>> +	op.data.buf.out = phy_tuning_pattern;
>> +
>> +	ret = ctlr->mem_ops->exec_op(mem, &op);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to write PHY pattern to cache: %d\n", ret);
>> +		return ret;
>> +	}
>> +	dev_dbg(dev, "PHY pattern (%zu bytes) written to cache\n",
>> +		sizeof(phy_tuning_pattern));
>> +
>> +	return 0;
>> +}
> 
> spinand_write_page() has a multi-operation sequence, I've not checked if
> any fancy flashes with DQS support actually need that.  _read_page()
> looks more straightforward.

cqspi_write_pattern_to_cache() does a PROGRAM_LOAD only (no
PROGRAM_EXECUTE), and tuning reads the pattern back from cache - no cell
wear. True for all SPI NANDs we've tested; a DQS capable device needing
EXECUTE before readback would need separate handling, but haven't seen one.

Thanks,
Santhosh.

