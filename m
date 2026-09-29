Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF845D5E4;
	Tue, 29 Sep 2026 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663892; cv=fail; b=DOVKDi44fFBPtW7SPA36Sb3AqV0neXKxyfoU1+LmXvBlrTEjRXFkcPNgvzwvk0xJuCPIX39kHQ/XRBznqrah4BmAzAIJfC6ahSLGjTbianuHakElZ4/9QCpXNpD/SqkzQwn8TvgZ5Ii6Rpys5Xd1vxievKXFr/gf9EiW94OlALs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663892; c=relaxed/simple;
	bh=L/AaqLlYKxS8MJ5OBIkOJBpTk2Soj0CAlfypvZxM+dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g82nLwsNm/B5y7/i9gjrK3rZdFttOaxJ7+VCH8uYGCxTOgO2iuk60e40pyBNPYU3KiICnt74U0ThW4n7MZcEx9fYL2Dx/4aEthUQk6ba9GKLKFG6wPpHolHZmjJCoWrsr1CWmVCApG497HqvWFKt7BFZlJdehYVeqOKa61xSHL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ju/d95jt; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=XHAInVMi; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ju/d95jt";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="XHAInVMi"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46TgY037374;
	Tue, 29 Sep 2026 01:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iEn3+g/MG7TN5/pNs8lwj5ujJFsic6K1xG8h3LeMr
	7w=; b=Ju/d95jtfGN1f/8XAHNTjF4CeTdyLxQoqn+ptg09cH0kG4FJeIv/aZNy2
	dc/3ukdTX7K4UIQ4rjQxqG/O0AA5F5Fxx4EbhfwqHlL9zc9iv2Mr+tFAJ6QNU0bP
	Ig7V0xG5uZ5IvIB3qktUhVUGMexy4/0t9cXhvDSHIythQcvea1PsK/tmwyQicgHT
	pe3T1bvzoCvQldno8phDsT0Z4XSX8bqyL2WIdSqxQL1QPq6nyS6hMr6mwu0Wqhsz
	R0wZ4wLOxHA3yRm7lx2EZeAENpVrF4QwOuCFm46YLiUYrI4FaDMiOAUFoF5EN25h
	i0ZMk2yBEhlnv0YcrbfGHpzcBy0Ow==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h02j69x3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVCy0phnExwCSNUmTh1j98pZ4q9RcBIDr7R4/JpgVJRtWi7zmfQZS9k13yaOX6uWru6n+tnbHqM/tZCgd4gxDQwK5eAVNuFMwez6d2Bi/afOY1TYrY+NvuBRsPeA5W6HmthN6A9QFSgUZOFNxytMrfBblSr49R7fI9ZGArqTbiQ90dtA/G19dbf3bhsRDJr5OAHM5W3SkFrQbVHKuGYDROauRDrCjOi/7gctc+bTvkg2vP4PBnzsrZosqW5YECeWbqITLC6jbhoEI6h/j5lDMqObNuuUxwg2W5UT91IAdEA7lrBKb+OljwEUu1iARG1E8ffNGiaLOS8PrP4h5M/fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEn3+g/MG7TN5/pNs8lwj5ujJFsic6K1xG8h3LeMr7w=;
 b=YhhbfOSQnai6EuCkZGpoQ9LCsqKl4GAi+0AQVANBLonN75CaJE/0kEdBokV8LHQfCQ3TRZZSI/HNvsVZl9PZcpGRXgLQECGco8wFaKchwRt9ep7OrHbHS/Nn8jw4r6osGoJk1wCuTR31dH3E4wDXiuK7IJfj6IR6llVKKaNg8QKPmlB7mXY8MyjGhUzze74hSw/c1+H+rR6OsVY91e3O4JxS9xiWvCzbQ4zBK9kXYLD9bA/09vYdiHyzgyqXE+zzmJfjeHzA2HMFlgeKlWwSvjrQyn9cnRzwIU54oijTrwGHoVoLw+6hMnF0M3asCX6mDr1y3JH/w8a7IQuMrL2dcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEn3+g/MG7TN5/pNs8lwj5ujJFsic6K1xG8h3LeMr7w=;
 b=XHAInVMiNVsdmisD+peHR2sgABNiGSrfcO4UUdOuoF3K/OF4LdQisysLWYTt9UR12Liw06tlF/o5Ioyi5W9a8lZasQuOcGfJXDkO7W3o2UiWqqSRjoBB/1/EDasGeLfmMZfqMKkE1QO5Oimlsb451pv5y86TbMBcAL0o3kt0P2E=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:37:53 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::57) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 06:37:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:50 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:10 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:37:10 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnG1395904;
	Tue, 29 Sep 2026 01:37:05 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 16/19] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Tue, 29 Sep 2026 12:05:26 +0530
Message-ID: <20260929063529.1235417-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: e40816c4-7323-4ca2-ab67-08df1df42f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|23010399003|921020|3023799007|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E23Vmg25ukcjuFnu6KY+nREe6dYt1vP5faU0IPSbgmFZkiO96HIVAXkevBoGIbSbhr7ewNNi0fIVRgKVKEMiteQvokAMsHsctu/ChdquLluFjaGos4YuF8LdB9FFiIHNCNNCdpb95GqtcjXXOMNygAMWEWYFaP/8Y9H0b/FXo4QBKpwwNhoXVD/tA/pd2tiBlcsrTAOGBLCoEZTVN4pnYELZQtveNWFulPGpxGV8rRvki5YM4E0gLbn79uzQSCp+Sn0gdVDDk+4psyJnyyTsxnpKmlAP3BAG7RQfeKKyfBvoAfP6xxB42jDkLZ8unmAV63w9d0w48k3GQ+QfUhR3zve4+KPdVY3RkIG65gkrNIueLh6BldkX1bI7cSGlsREzx+kYEHuCq+Tfbn4vdowFz1+T4HiN4S0xVUVXzL209mamJp5o2t8A7HhGb7ySFFCC01fXwG8qX+0o3ssV1Mtu4qEyVFmIDp3nIkaaEHxRCSNpdrbpaeEs44FPqKi48nYgUBMbFbzDp9BMxZ4gnYqVOGYX1uqSlK5uyveIIAH3OyndaVuu1DZ/hEqy97Acs9DLVJ/i4IAzPaG4w1XS1io8P2cvdmk/b9GFL+QAQxh9KAl6VX3bSUyS8QNiaEfLWs8IB/U3ERwL/WSQPhT4+HSWLUURBBWV93GM00lIKrnWYUlx0gGUyiZ9cQBKa2joofg+4C6sFyb09s8ZC3H3qO81j9MrJ95PYyvuPwGk80vj15HRveSDu797CKWxa/bZtufu
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SwYxCJWb0H6YSYs8HJS/V+3YrjA2Jcm4Z1Ay9+Wr6qt9Zj5Mh/j1cQ/6yE/ns+BZ/ZGqdyz7BcOPdzk4RLHjUK0J/z2hBhDsGs6LGN3EhfWEPz+2qqKJ7On+jSlrxopaaROQsuI8/BZEoY0a/9lxdJhHfW5Tne6BXdBdFwz14tXlpqJxFYSsQ5iZFpV5w9GcYh0hwRw5WippavtUUJ8MZZoPoWohvD34+UHFWH4UO/qXCFq2K9uZuT5f94xIzGqjSz/ZrpGUC73A/z5B0OqTucDvQ+s5MW16fecMlaeyrPFHs8GYqPiFt9VvRIi66Jd+nnctjUaYKcN+EYkX59sjqLkptClRGfpsybRtVGUEk0fAv+0JflZzmOTson2EA2LP5MmoilFNer+pACNtQYZxDZO35VOXuvOCv9HynSjxBwrQWfATktn+eZMlZ6URfCAm
X-Exchange-RoutingPolicyChecked:
	yj6/FaN3dXWocX3sUlBWvhacXP4hFVNTUFynlWUaFI/KKoWgl/khz0w0pb3/fn8OB+H2bNmqex6kpj3cMBiLEeUX0PdXXgoQT+hTsxnyiRbAbkF4jUu037eqwIZjuBYW0SdHnKxyZYmkxz9rGz4Gn8JUjFsPyq8fANdljoQtw59Ppa6Pu9bPfyZ3UvNDrLJ9RGymhWP8MNgJxWdLGqhZX1w6KyYZBb7J6g8ydpvuHdEww4o8zygH25U5oCpzbn3NAUhn6G9qhJWluUR7iuPBjIMMRfQU7OnL41O+JtG/iFVgYFU0HounzzHi21+07cOi359IqvtEm0342fVCRIzc7Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:50.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40816c4-7323-4ca2-ab67-08df1df42f00
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX2KcR1uV6vNka
 Kwe7c202jnPJgcvaDpLzi+UAQlx2a15ZjojwStiKtLxbEXng+ip61Zyxc3s1W3JVM0BRTsU+ApX
 GFvbk9YRACY1GIJ8zAns9HUtRlq6mRs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX6ZQu4yRham3k
 S1o7vSCntJC3eCE8Z+cRqERJCwVqkmjBTOp7bf5k/yjb1fW36uONL3yci7L/ZY8hReMqozkBiS0
 HclCH6Jn4GveROs1aeS2RNq7Ot4X9RpmcZ073Wp5jazExQa4fUhvVr5jQum7pd/NhcpQ5PXE1UM
 MPU2CiADX6Ql3/dWTh0tToZbElwRLOtFGDejboeSQv60k3NpOHUVt39LeNm+FmYcCE+nwlERvnJ
 oA44x2M6C7tpsPLeFXk+TvB2DcoGz4rBMMKV6SHr7AdNJVirKERHJ/6+UWlV48oGphUzLkoBEpb
 3Y8U2M229zk69gb4EsMomWa7ad1w1m/I3YbtO6qus0TcjrzdzO5jDInHbQy3DAT3rFDYywpNdR3
 HHOTXBTZfExIQArlZGA3HckKSKSpF5chfdbTwM8flrzxn6OCDc0t7xQ6Ff8xXQzbot6i/xCe3lQ
 GlJ5aIwmPxr5v+Wr6dQ==
X-Authority-Analysis: v=2.4 cv=Z4p5j3RA c=1 sm=1 tr=0 ts=6abb5cc5 cx=c_pps
 a=vtur6dA+JiXx+GD1nKNobw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=ZE5v3KcJ7YqXqyeUJPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: rz8NsXXESXCWaghK2ZdzoEd91qJOw9jR
X-Proofpoint-ORIG-GUID: rz8NsXXESXCWaghK2ZdzoEd91qJOw9jR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

PHY calibration must complete before dirmap creation so the validated
max_freq is embedded into the dirmap op templates from the start; a
dirmap built at the base rate cannot be updated later.

Add spinand_optimize_controller() which calls spi_mem_execute_tuning()
on the pre-selected op variant. If the controller returns a per-op skip
signal (ret == 0, max_freq still 0), spinand_try_ranked_variant()
iterates all remaining variants in descending performance order, trying
ODTR first and falling back to SSDR if all ODTR attempts fail.
Optimisation failure is never fatal.

When SSDR is permanently selected, clear odtr_op_templates to prevent
spinand_configure_chip() on resume from re-entering ODTR mode with
dirmaps built for SSDR, which would corrupt data.

For devices with a distinct cont_read op table,
spinand_try_ranked_variant() re-pairs cont_read_cache with the newly
selected read_cache variant rather than disabling continuous reads
outright. Re-pairing uses protocol-shape matching (cmd/addr buswidth,
addr.nbytes, DTR-ness); addr.nbytes is included because different
address byte counts represent different controller configurations
that cannot share calibrated settings. Mode-toggle devices are
unaffected.

Move spinand_create_dirmaps() from spinand_init() to spinand_probe() so
spinand_optimize_controller() can run first.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 312 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  15 ++
 2 files changed, 310 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9dc43c8c4162..645528b6c2d7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1300,6 +1300,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1310,9 +1311,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1559,22 +1562,51 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/**
+ * spinand_op_shape_matches() - Check whether two ops share the same protocol
+ *				 shape.
+ * @a: first op
+ * @b: second op
+ *
+ * Compares cmd/addr/data buswidth, addr.nbytes, and DTR-ness, ignoring
+ * dummy cycle count and address value. A continuous-read op and its
+ * corresponding read_cache op are expected to differ only in those ignored
+ * fields: continuous read typically needs fewer dummy cycles, and always
+ * targets an internally tracked address rather than the caller's.
+ */
+static bool spinand_op_shape_matches(const struct spi_mem_op *a,
+				     const struct spi_mem_op *b)
+{
+	return a->cmd.buswidth == b->cmd.buswidth &&
+	       a->cmd.dtr == b->cmd.dtr &&
+	       a->addr.nbytes == b->addr.nbytes &&
+	       a->addr.buswidth == b->addr.buswidth &&
+	       a->addr.dtr == b->addr.dtr &&
+	       a->data.buswidth == b->data.buswidth &&
+	       a->data.dtr == b->data.dtr;
+}
+
 /**
  * spinand_op_find_best_variant() - Find the fastest eligible op variant.
- * @spinand:    SPI NAND device
- * @variants:   full variant list to search
- * @iface:      bus interface to consider (ODTR or SSDR)
- * @skip_mask:  bitmask of variant indices to skip (already tried)
+ * @spinand:     SPI NAND device
+ * @variants:    full variant list to search
+ * @iface:       bus interface to consider (ODTR or SSDR)
+ * @skip_mask:   bitmask of variant indices to skip (already tried)
+ * @match_shape: if non-NULL, only consider variants whose protocol shape
+ *		 (see spinand_op_shape_matches()) matches this op
  *
  * Iterates @variants, evaluates transfer duration for each eligible op, and
  * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
- * no eligible variant remains.  Used by both variant selection at init time
- * (skip_mask == 0) and ranked PHY tuning iteration.
+ * no eligible variant remains.  Used by variant selection at init time
+ * (skip_mask == 0, match_shape == NULL), ranked PHY tuning iteration
+ * (match_shape == NULL), and continuous-read counterpart lookup
+ * (match_shape == the read_cache op just selected).
  */
 static const struct spi_mem_op *
 spinand_op_find_best_variant(struct spinand_device *spinand,
 			     const struct spinand_op_variants *variants,
-			     enum spinand_bus_interface iface, u32 skip_mask)
+			     enum spinand_bus_interface iface, u32 skip_mask,
+			     const struct spi_mem_op *match_shape)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1591,6 +1623,10 @@ spinand_op_find_best_variant(struct spinand_device *spinand,
 		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		if (match_shape &&
+		    !spinand_op_shape_matches(&variants->ops[i], match_shape))
+			continue;
+
 		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
@@ -1625,7 +1661,37 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
-	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+	return spinand_op_find_best_variant(spinand, variants, iface, 0, NULL);
+}
+
+/**
+ * spinand_find_cont_read_variant() - Find the continuous-read counterpart of
+ *				       a chosen read_cache variant.
+ * @spinand: SPI NAND device
+ * @read_op: the read_cache op that was just selected
+ * @iface:   bus interface @read_op belongs to (ODTR or SSDR)
+ *
+ * Devices that implement continuous read via a distinct op template (rather
+ * than a mode toggle around the existing read_cache op) need that template
+ * re-paired whenever a different read_cache variant is selected, since the
+ * two are not guaranteed to sit at the same index in their respective
+ * variant tables (some devices omit continuous-read counterparts for
+ * specific dummy-cycle sub-variants, shifting every later index out of
+ * alignment). Matching by protocol shape instead of index is unaffected by
+ * such gaps. Returns NULL if this device has no continuous-read variant
+ * table, or no matching variant is eligible on this controller.
+ */
+static const struct spi_mem_op *
+spinand_find_cont_read_variant(struct spinand_device *spinand,
+			       const struct spi_mem_op *read_op,
+			       enum spinand_bus_interface iface)
+{
+	if (!spinand->all_cont_read_variants)
+		return NULL;
+
+	return spinand_op_find_best_variant(spinand,
+					    spinand->all_cont_read_variants,
+					    iface, 0, read_op);
 }
 
 /**
@@ -1762,6 +1828,20 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache) {
+			spinand->all_read_variants = info->op_variants.read_cache;
+			spinand->all_cont_read_variants =
+				info->op_variants.cont_read_cache;
+		}
+
 		return 0;
 	}
 
@@ -1940,7 +2020,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2037,14 +2116,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2073,6 +2144,199 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/**
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache. For devices
+ * with a distinct cont_read_cache variant table (non-NULL
+ * all_cont_read_variants), re-pairs cont_read_cache via protocol-shape
+ * matching and updates cont_read_possible. Mode-toggle devices
+ * (all_cont_read_variants == NULL) are unaffected.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	struct spinand_mem_ops *templates = iface == ODTR ?
+		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask, NULL))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		spinand->max_write_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			templates->read_cache = best;
+			if (spinand->all_cont_read_variants) {
+				templates->cont_read_cache =
+					spinand_find_cont_read_variant(spinand, best, iface);
+				/* Only clear; never re-enable a denied capability. */
+				if (!templates->cont_read_cache)
+					spinand->cont_read_possible = false;
+			}
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/**
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/*
+	 * Only ODTR variants were candidates in Pass 1; SSDR bits are clear.
+	 * Clear ODTR templates on success so spinand_configure_chip() on
+	 * resume does not re-enter ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask)) {
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		return;
+	}
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 * Clear ODTR templates in either case to prevent resume from
+	 * re-entering ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2095,6 +2359,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index d7c99fcfb85e..87107f0955eb 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -754,6 +754,15 @@ struct spinand_mem_ops {
  * @odtr_op_templates: Templates for all octal DTR SPI mem operations
  * @op_templates: Templates for all SPI mem operations
  * @bus_iface: Current bus interface
+ * @all_read_variants: Full read variant list (ODTR and SSDR ops together),
+ *		       saved when ODTR templates are valid. Used for ranked
+ *		       controller-optimization fallback
+ * @all_cont_read_variants: Continuous-read counterpart of
+ *			    @all_read_variants, if any
+ * @max_read_op: Persistent read op template updated by execute_tuning with
+ *		 the validated operating speed
+ * @max_write_op: Persistent write op template updated by execute_tuning with
+ *		  the validated operating speed
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -793,8 +802,14 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	const struct spinand_op_variants *all_read_variants;
+	const struct spinand_op_variants *all_cont_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

