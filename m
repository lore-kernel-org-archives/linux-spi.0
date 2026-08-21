Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05F371D01;
	Fri, 21 Aug 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312997; cv=fail; b=FnFZKYYJYG+uqNk8SJJMkaBtwox7KVDteSphKs1N/21jEGLAU10HlPI2meofWBmSTKSxwEVGYd+q6YCTQSnRr5c/J3C6nwNL2oohakyD1UHjN/U73g17Jg2DV5rUEMFQjuvjs7fY9pBxSEHVJnVtCxAjwlmkBJeuGQq5ZC7YC/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312997; c=relaxed/simple;
	bh=5qnezhdC7z+lORuvm/pjPzGWMGRQvmaJD+gNRZlgLhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT/7ZwwPDTx6Dc8vnZjNvJykNwQ6MSwdLU3ZTlwU7uVawjEW55NbtlZSGbPKXMqW9Lz63B/jObnDfhC5ahH6imjpVl8ds4z8BAskD7HZPzFCTlnOZJjOblN8eretS5n40v0cG9hCWX5nRSVJls1nOiMugAv1boREMpf/9jgRIKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aNfiMKGe; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a7SOM8ae; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aNfiMKGe";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a7SOM8ae"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KKGE3421342;
	Fri, 21 Aug 2026 06:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0T
	so=; b=aNfiMKGePmjXTdP99Dt0K8ng+PrrHni8LUcO4dMeFXbGktCmcyIUO7CR5
	hGzVDULLe7LweEnSX0aFzWADKxv7OLqWfDsU66sQHccqwM5tySBrRsg+FxcZ+EN3
	KkkQPuLpIRHGQ+9MkE2WCqIHpWc/aySFRiJlkMH7/4abloEeZq3fCapg8SpiPbMs
	DasgMfwJZQRT4mIS4TGpVDjyLEqL/twjtjiXepK7v/NWyCVncD9kWd8VrrwU9mm2
	FModkqzd7gwM9P51pxwipuuiD7ORZP3wz/Xoea9cJib25L983xc9xECRcMOfoZpR
	el7nx739KCcN3mmY7bvEEtU9OX6Ow==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6knmrn0g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH0MAlj9PmAPTDtY+wZTelvruVrAX3b+3/ICSiLpmu8ZqoCwN40zLpjj728xJFAgRtIzd4wlmp1D9rk2YZujRMeM8ODR4pndpX1Y2l6zsY07AoA0LbHIiBwGcGJjl7cxV3AVbkMLcoNtBVSQfWbfNwjf1hebxe0A/1wFvqf9QeHUyjTUmTBq8h/ioFNow9wuFWe9ZpzKB6hALZFttYcQWZoCWmep43FFIMvvQJ3fksPosatIyLVOURsW0Rdsn0JWWN1pUu1EaSnJ5ztqLrY6S2BK5pCZhmLYynLY9pxpokQ3qrLMhSg0WAIYI4wCVIwLKAlPRx7NHmwUIKpT68qX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0Tso=;
 b=SeZ5CYwaxH8CC6/lWlBahFawAzoY4dP6MT2tX8nzN8zLdQ9Q6LcqjhdO2eZ/sZ3qvWIFhuNi86Zp+n3XbBkZyKKmOOwwNOGfX0RBrZZmn+jZGFfwCOcdhHAvsdhQZzHQrjSJpKJAeASGlw1fS/yNE7mj7PQSObASEoYQW7qQx9cO5seQXgk82Lupl517IgGY184K1n6RenzcKQBkoD81baQgjYoigOi/YZAbj31YZD/NzJ5HGypboLoXrwGbnyXgHdJlOXyZrEpb35gb6E5HqSZvxc7FHGs1qtbMOqstGOYIYpekALqFzVEGHrO03WEbyuzSM5D0EZZOFRgrQYNZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0Tso=;
 b=a7SOM8ae/z5kf0JciM9LTGNd/xRMsuQl/WXodvJhBRRGYIUEbEAK+t6wefy4GBK9lnCCOYNH7BKt+FVDtI3aR2Pb4LeqJgOTPn31OZsBR3e1dsEQe7aCEtBz+7ShMaXx0Kb31jZ72QmUdbDLOPGIqW0ch3SeE4SQPZkFUH1auZA=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by IA6PR10MB997683.namprd10.prod.outlook.com (2603:10b6:208:5df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:37 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::3b) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:36 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:26 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:26 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlk2022942;
	Fri, 21 Aug 2026 06:49:21 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Fri, 21 Aug 2026 17:18:13 +0530
Message-ID: <20260821114822.4040338-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|IA6PR10MB997683:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b79d25-e17a-41cf-1bd7-08deff7a4670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|82310400026|36860700016|22082099003|18002099003|13003099007|6133799003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	2b8e9QDnpwXLy7Vjc4HH8yK+sXXvmLhPlErMhsbQMYtBzEaH9s+7QRvWXh9IjEJBcKVgnMBmftWtv6Y5JZL7pPzv1x7BN+tPLHfcE7J5XNwxtecnxVl0P2NtqtQxqqQAJBQieAb2B6+lzAEhL6lHEJrhmVGMZZLAS0wbtac0O3H5LEMc6JqjKuXyAuLZKwgRNkUqa79ppyhTXWiYif+VhhXFJAkUqqKAS9EaBVdQ78s4XAF61i2Gs9rKdboE9bmAbIVYjsvy6SB/a1uJOl6bHBogqT8biu8Jkk4CJmFwEXTU4neam8q/HsJyZ+t1QGqpJBcidVyEOUy4JOa/kH+HOyWP4zu/kTMkkCRPR2rcPyyeUI7sIPg+i5t06WK+X5EVtVdnwVIigm15SqbpnyEtV/nMhwDi/b1YPp38tGjwMQEwRWWm2Z57QeKJtY1F6udRuVbDxozgzQp6JPyBIkF1jjO7kKG5FEVVvUo99AX58/GlGwLo3jUSPA8DbFFn+4sCBUOrXXcjaB8isBZy4bgZ4wCbYqj0HfEgs8IIYjOWDI+lhES4fCpuLOZBoSX+1kvyYBRoiXEEX6Ub0kniUlV7L0PJ4zVX+u7njYMDZck+jZRKumdRRbuvCv9YEsKEyqsOKS4xrjyFS721PqL676ip1fHyCcL4ZEr+4gc4dnZu9RZgi0SL+FUANmoSbJYwtt37IAwcC3uwrHNgusdlRE2oyQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(13003099007)(6133799003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8rttgtMZ6qrsjr1L97j6+NlEg/rPjWL///q8Fn47uOoALBxZejciKCa1rjj6fC78LcAYr+gkGOLcWzM3syWlrNI6cexkgGQo6m8rLDwtGNXcyrRuw5NZwZZMA1S9HGbTf+zQx3R0xBzXsJPdMRdiddRryPhTuWFZ6970/fgCauq+kQ/TzTZTXhWSm0kfjv+7XzmbXJnCWocwCLQGltRriJXdjQZbpDklsTEdNi0X7fKH1Ylab0e6loTLhcLKlmhCtCUKaBq3E/OmA6+UnVWrhqPHLYTSEMMjZNsMubl6an4bRnv33dsOGHKBivMfW1LIIW+wGBT6JE0cgBdaIGUxBk61Rvc6FLj6yYi0h7B5a1HcMkTDLth/OTyDcR/fINaMcaY7s4v+8cCGFS/2JFvUbH3qyokCHlSLOHyYlVwqZzDulwKXZSGp0QqvbAhCpttG
X-Exchange-RoutingPolicyChecked:
	iXTiBczCmicTuzmUr0ZhftO8tdUjHnVcEsu8o90mWC8BTQZhnPQYbU/Gya88sqhX6Q9204qViQBjjJYd6BTDQ+Eddzv9MG9TIzYaXa83cQU5v3sl8w0XuVeexRZpJ8mUaq0GJYBp2bFodK8T2uZeCrsYvWzDyrwie8B/DJqEWY/X7M5uGvnv39VXcjmc48SiTCQUuZom64f1q1vNWs8JS/YjDpXgympo6eBVCVOA6iD/KcT/5bWtaCKMQysc7iVyhQWaxhY2kvmjE4g9tOkFVN9J9Xua3mhcJ1I8UPROz14AjQUSB1UpdK3RztEjP+AGdt55xcKNuWelt7ptwLEUmg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:36.4805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b79d25-e17a-41cf-1bd7-08deff7a4670
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997683
X-Proofpoint-GUID: nLW6SBa2rdUK7n_svcM3E8a8jxJb5dis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX4kFT3EW5PM23
 /kiIdpiC/wfw/oAE3Mr4NHB3Hy7J/Ekg7SdmWpsv8eKOti8MJ3FkLmu89TpOUxwW5EHl8YAorIO
 OdhyEEbR2XTJa/FrU9n88sivRhCC15PtSEf7Tu/pzgWEfF98MdTpd8pUZh5KlALj4Tao/PNFOI6
 qkUMwAg4R30j0RZugmOegzGBjD4ibxK3IcwCkuVkf94ntVKcbgLq9TyjuMe7nX4rhis0LIKcHkM
 bXCEdRtty0Aj3L6SS/cu6eg17voBgPmhmoKYXd6ACw5Tvkm/4znwQEKBiQ6shsQTu24TYxIsBa8
 B+iNEXkQZMbe9b5IDFGyBVOBji9A6SnAvqVmj9OevIKkvNb4l8yAoepiub/ii5o/O6kHDupHrfu
 j1takKyys/HVyEw262ryhZXsGD42fj34YBFuhVjzZMRi/27OCHQj7UpF8WLv50EnT7JEPxjGkmY
 MwXDWjGNMiiDT1qm3Hg==
X-Proofpoint-ORIG-GUID: nLW6SBa2rdUK7n_svcM3E8a8jxJb5dis
X-Authority-Analysis: v=2.4 cv=fuzsol4f c=1 sm=1 tr=0 ts=6a883b55 cx=c_pps
 a=2d9FbaPwie0YXhWIRYJR4A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=T-kh0MV4vbdY-aS4Zb4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXzwgH+VDzPcrZ
 gwjkqTUQtPzUpY6d9Trocy7Id22aZAIhBjvrA1uKmOwMC5a1ut8OuTLD4jIsuutJzyqaP2qm70C
 5WJn4ud+gROxd/U1Izuc9qok+cicsj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared — the op-skip signal that tells the
caller to try another op variant.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 43 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5651320426b1..a1aaba7c1a7e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,19 +37,20 @@
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
-#define CQSPI_NEEDS_WR_DELAY		BIT(0)
-#define CQSPI_DISABLE_DAC_MODE		BIT(1)
-#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
-#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM			BIT(4)
-#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
-#define CQSPI_RD_NO_IRQ			BIT(6)
-#define CQSPI_DMA_SET_MASK		BIT(7)
-#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
-#define CQSPI_DISABLE_STIG_MODE		BIT(9)
-#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
-#define CQSPI_NO_INDIRECT_MODE		BIT(11)
-#define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NEEDS_WR_DELAY			BIT(0)
+#define CQSPI_DISABLE_DAC_MODE			BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA		BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION		BIT(3)
+#define CQSPI_SLOW_SRAM				BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR		BIT(5)
+#define CQSPI_RD_NO_IRQ				BIT(6)
+#define CQSPI_DMA_SET_MASK			BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET		BIT(8)
+#define CQSPI_DISABLE_STIG_MODE			BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM		BIT(10)
+#define CQSPI_NO_INDIRECT_MODE			BIT(11)
+#define CQSPI_HAS_WR_PROTECT			BIT(12)
+#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3211,6 +3212,20 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR) &&
+	    read_op->addr.nbytes == 2 &&
+	    (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	     read_op->data.dtr)) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3849,7 +3864,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

