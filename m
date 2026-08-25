Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7043332907;
	Tue, 25 Aug 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678351; cv=fail; b=Fh9mr0b1K4UNIACWQ1aCpbOmJrc024qIco7jnjCL4Oe2HlhpiLY56VmkQoJpl2ziHhItudGKyBZVsxFAMWE7AWD/mjwkeWXIsTAu+w0zN7D+ODpFSRgLak2bScRhe405V9+LIB+/IQNJJP7wuuVIR+REaKFvg8eyMW/Rpfprrzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678351; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB4iUNyan8u3unIua50comXFEbp8POl2UMiziSHfOF1WsCbYorcA6uDOo1jXp+OsYqYsekaWK5tW1eaK+2zmj2wwO/qLMgQv4+T3jn0tOJCEr7doiJ1Zoah4wdUdfly87Uw4oBFDSBNG2c07hIDlWS5iPqJfZSKqrU7qZEFSVMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=g+Ax0OB6; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iXf38b0X; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="g+Ax0OB6";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iXf38b0X"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEUued1882643;
	Tue, 25 Aug 2026 12:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=g+Ax0OB6ItzGiJl2u3kDxcvYuRJn5PQtK572KA7UIiSuzWC2eIbfapQqJ
	FLn8uCSQAyTGmu5gV9MxqlZA1rgqH6/6Q0HteTfB2b+2XkHZePLRkDS+6cVAPiTW
	SmOsKYrVP5IXovXPDTqSYL1+x2LnMV0A0ERSHjGQc5iqIQeVY4swbyJfCBzOwXTJ
	WHVdPUKGnxfUbZGms1wIW2OcWMbq/g7cjKbzZhL3VCAmUCJmEO6UHBKuos5+YLSB
	Li5j+G15/0udZGF46vWD5tYxkoY95zyuCOJ9rXQ4XcviUPimCm4ijfWIJTqYwtsm
	CaQZpesiTftQT70w0Nka6IKIjJXag==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g8xga5g95-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtnRP+fbtr7K6Ev7QRiAM0VAsms+7pZKNioLMpR7mmCmv/19Ct+/UKK5uuvdAdIYF0s1aR+KsbicPNHfS5OKQBODx0ajLpnsMnDrDN8hbAfO1A9vVr+8080PEs+47rtyf8cctZ+DP3isc65BeSwewqfBJvkjO7W6Ex70sRXAOpe47Cx2UfkI25G8o59Rkz2Ub92TnAIO+03vgJenyjy0LkxesUHcCYypatZCPIixlKhRjus/vj2/NPKDcwVRCwx5OBXeqLMMEKEYJRMXL4fcmVFks1mO8kVSVSthSDob6tcCyBZ54YU4d05YEh3K2TrXWWxf1bXJd6CauXr41rdWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=PpStRhjVkO9jg66LdSMDxuqcrN8LzHzhUdXcljpPBd+DlaPEu40W2/W5ZUxAJWk7qxn/IYu7zeKv9iFn3qS8W8B/baIi0ed6giVU0a98LUVD3cxJCYoinHIdrbpsU9BpXw5cFkLujbwAWx9wcqahe4nHh5TLQUnOZIYb1EkOi3ybFG7ofWEb9Fa6ZAAsm8B43O227LRaTxj3H0nBTYeJgXrJa1t4P3QhvV4hmY1lyE4uTo/XhKsEMOeDA7wzIe4q1TP+tsATS1DI6GIdQzfY3lFGGRXzDn0wUXglDvjvKTTFZQ+uGpJLAtkrYTPAh+0Ft5fiVxVCzPSc0ioQYKaeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=iXf38b0XpkaHPQp7Esc5jt6YxZGHFeNtxSWT27nVmr2/7UKydWpu3Plx5kJk0nLD+Ph1Vw2tLWABHbJ86zk0VNVwniHUkwKahUxFn1Vy/c1kzXKtGx7AtZRan7qtl32qwcHgx8Qzt+cMl3mWMiGG0DsxrhVb67PUgfk5TAAZK1U=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by CH3PR10MB7646.namprd10.prod.outlook.com (2603:10b6:610:179::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 17:18:48 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8f) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:41 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:21 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:21 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3V1436664;
	Tue, 25 Aug 2026 12:18:16 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Tue, 25 Aug 2026 22:47:25 +0530
Message-ID: <20260825171737.776052-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CH3PR10MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: f2109c1e-89b6-48d8-4523-08df02cce8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3z+dseex4UCJYYYymrNJ0IAgXiUXwQ6CW009JCiVzKTALloAUFCGZOAcnN4LUBlx0mT9pz8FXbNZxfVM7kPVCU7nA9QaSahtRSW7KT+CT6zA7j5+gJl6WIPqauqkee50PPV7B0mQdVRjdxjyZ6sHsSzKsP2BI8ORQYeVQYAjMMYpg/II0StiXyydOhJRTcYMjH02MmH2bTBtP27nBpZeiApat0Cdta6PqLr5//mDIuDsBf3s+D7eTRbf1zUm+V7n6Tyc+lwE1xo3e3UFX8zYqezxc1Ed8Ep1vJb5IvnKcrLyJ3020zQTzQX32+6Q6xdG4FCfFQrdk0M8p2srkCeyhhQRFk1NibIfOgesDSzGyuWBgxMf44OS6TV8ZdS1qxzve5dxL66wgP8sYslwBjMoFaRuYXv/YzmneC0HqVn5VOHecGYrIed//y6pVlIPFJ+sdRiSt4GQG19pC4kdsPyxPTKHNvKAWjNV+3x8AILxcRH2ZOmQQf58BxeH9ZmmMdMpr9ue9unc0Aes1o4lrg9U+VSK6ljyLOEr7+dQzONrJCgXz/RA684EGIfvDtd+wPunmJX7CwMTtcSqAh+UvONe875NcXwPbDJtBfnkQWRv62Iyn3OHcZ460cVy/zt2eLiiL0taG9uWVz9oz0pvA6+FHmWK1MkoOS3pJYYFEEJ3rYLcvDcT0eSjqNe+UW5awC54VPJ7JCZjvDJih5JNs9M57h6MlApVwVltAWuRVEedQlJm6JC9e3txIkTyozuk982L
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(921020)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAoS7hTgnEm1fxLWG7n7KdGiR2lez/NpUrJRLlpyV/+AfXkvoNok59C9hN7tom8D4/ctb7hCs7JtJBh4TuawxiBtOsMZM0UzdCWWQosWmxZIO1gRHrX/mIPlheeCVdY7lnaFk55gdBjNdkvR2c7dLK3oB/wUXXdOk0Tu9ioziDBrlSUP7PnVoPZSfbHQ+Q3sWbOGcUnrtOKin04Qqhr/rxIJUBBOb/eUlMrGzORgLdgytyFDCzbhmzPWIce1h2RHR+r9sQEOcLf1hvbZFGznD3tomwNPuH+tci0Asf8CdYPcJHpM+t3MitRazHe4kfVT8CmeFl/B+DXrzK5Tt+q33/rrceAtZUQjK1GRuvnUqW2YB26di1NiCuwvyNUDi4PDVtwWwkR7yA0xuTxiyP0IlKcuQ4sAP1U+cATi5mpYw1KYGM7jTyIniYgd99ookEAe
X-Exchange-RoutingPolicyChecked:
	wTEY473iJ45LbhC1ikHE06DugBhhXBDZN8i/5tSorOe7Ati1rvHH3yfcIgO6an3mE0VIra05d4/YEZKZ5A3PP4HHUiCG1nAdilaCq9A4Du7mQyMJihZUpyBboNJTVuK2kygRE/DhCcV8mm3FmoLTAyYh8folNUOF6pUp8vl9eq8F40aKHl8Fzty7fX0+MV2QUTLvOeefoTZzn/XnNmj2TB0QhabDwoN2eEg9ucZgEOUxw/KqIsAKVpEi6o5grClSRJyZtZVK+jt2NCLDZjIFm2Oe5ZXbwfEgTMDYCkn//vzamEB5+OMIHw8n7e6EKErEsERrUhnY1i30a5I2hltWdQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:41.3668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2109c1e-89b6-48d8-4523-08df02cce8f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7646
X-Authority-Analysis: v=2.4 cv=SuygLvO0 c=1 sm=1 tr=0 ts=6a8dce84 cx=c_pps
 a=P2JTm3oOj23y55bZWJDDIw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2vpyfyhlguDYHLkT4YcA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXy1sz334VciAe
 Tnu4OEgnxSQqNumikvCI8AMvgdC5ZngrppDE4mTL+8Yt1oSSX1WhAf+OL+ASM2iQ4dN12skMOT3
 uuzvfeOJUe+m/LFgNq9EZIwW8n/Nod0=
X-Proofpoint-ORIG-GUID: 3ZNdhEIrRPfDNuMqGOYqNK4ePoPcDdGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4VlgnrDdv2yT
 tUCMxW157+KKnoZ35nt9TgSLrblNdqGAyCnpoT4qMjK7drNLop0YpuGdj41UbeuBAMU3jckfyZ8
 swJAg3OXo2kTvUV8szpCzNU7GDWhrqS3j27mDxWok/OOAmYy4lPI3XflKJ/CpyeW8q/tSp/rjgV
 BExsDeME9tW73rDnZEmw05kgfOfdFACiiQSy7pE5jNdv6+q4zYS0RGyI9aIEKUa7eSSkRqWTrFz
 qPcN155KWyiviAvu6yTOGIpBVmhghzAV2VHWlFlbNfBj7NVbqSOM1egWJLYuOdSE3Js3pfKYaP9
 6mPioALPw6UwwXQkuX7uh6jnldE7QNZoJJFaLNmQjqIR61ZKGRR+nlWdUKGku5P/+v54ykUokke
 b6w3VpIpXpfE3/Gdx/1a+cJhF73T5Wh1LuQUkozTb+ry+RPyd1M19fntsPbLM4cC9MEeJl1RhFe
 uz3FqcAfgzWscszG8cA==
X-Proofpoint-GUID: 3ZNdhEIrRPfDNuMqGOYqNK4ePoPcDdGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..f8e266372367 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -457,6 +457,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1274,29 +1296,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1

