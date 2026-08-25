Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45D48822F;
	Tue, 25 Aug 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678369; cv=fail; b=i8Hh4V33OACCOp/PtU4ER21UxqRQc2uq55uUAMXKHvwq1BAmII059GV0sEO6M0K5hh5oE/mdtrlHBHMeXmuCoChDvlBXHbjXzm+LIU8GysGXyZQvHjPcVGK7sGZjkirpQxRLu2OQ9kmVu5H6T/VhmMXVS1xmDy2cBufGH/wgH4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678369; c=relaxed/simple;
	bh=9Iq/1uBUkxEUMeWc+9NiUJ1APojdTc/mXVF3tv2vgv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqRUlLn/vme2rXBe7/DVBhiIdqzYc/wJiRh/EAft4wFkNRYJYPd3kPk9u57Uis1rl59KpHQ3BJWxPzD/85nnny84O2yNx4LPZJs76dQEezGsZtyE6noho/Q2mWG50WGDF6JLCP0Jd3UtUAxHbQ59coCSkGjlgVplxvFF4lG1DCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=F/I6sQmu; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r7K16yRp; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="F/I6sQmu";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r7K16yRp"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVhg81165448;
	Tue, 25 Aug 2026 12:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3VXPdrsyhZGDpdbt4CKz7m5ZxNnAEugVbNQhjm8jO
	3Y=; b=F/I6sQmukdSXYmHyZYfM4S4ZsmAjTPJvmPwkndAmevj266wSnSeSGRtrp
	SSAmU07wAAP94mv02EiHEvTDgmlRpxAPvmZKCyoaQBy75BNmc/nZor048TbRZXBf
	7BSFgxgXxf8zGupsGu3EbZu44R6Op+OttlncePWpsW2QBCPySa0bNOLaHb5pNQKa
	ePiXxGwko5/iMMZZadjK/glsoUEnWlBy2RPZj8IE5urnUJ1fH0AXoXS5FWyFAALm
	pGWbszd/oXTu+lmZYUTlVfXbuXMqSxTPVBj4E36pI0ilnAZJeymIbFPoFcwxJcUG
	DOIw+YXOvidM+7v2rhPiINH0d0DnA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxmjn8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFZVV40nAFDn/2RRRPPR5BkqyxQI32+U7OfwhleHQypISdBxDHqD5SZlwtSKMtysWBCmm47/Ebk8arpI01C6fj8SMoN/6kkYSP05ONIJXJfGP5Y+ktkp7POjpJ13oB2tPO/i7c87goyh49DABUraSjUQEWLV4APKIYJgeHFmXGmXlx5O8LBo+zSMMfpb+GGqOMJ05HLKAU8Kn6vH6TF85loB6g7l+WRSvByiwzLRPK8uHpZ5OSFq1c+Xc7o58ehohrxeu7vPBWpkDz4cva9OobwhHwlgkCZM7lAUjcJlXQFUd3aplkwQR4lNuKjkXHRzAw4O1WHGnsL9J/Nz5qr6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VXPdrsyhZGDpdbt4CKz7m5ZxNnAEugVbNQhjm8jO3Y=;
 b=N5ZoE7DFnT22sMxAcx/0+Ow6zqad+CKv4uMQoxYrukKFK0ZWRMwxxis0NbBf2YFLbwiCZWSU12r/e1CqWJCoR6+GMCVgfHYzAHWnlo7j/KCkHfHMzOnM+YwWFpuwCZ4nPUbzscKC0QqL1MCEzQkMkFiD2ntFiMM8oTX1D+OmK+qSqo5zlu/nAvxtbSSRE712GHUIoqSRmIU2dXe5YwlPY1hWXk8CNreMz75q1gjacfI3l4prksYrPw1K5GhE0EenzeDeCZuhhQlFkP6fm8GP5QFKHN5BIOr2ApMf0ojhS05pXXWD3RF3AjYUgGE/tQusnWzKQ73bJu8WQC8kFTzIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VXPdrsyhZGDpdbt4CKz7m5ZxNnAEugVbNQhjm8jO3Y=;
 b=r7K16yRp0Jj9mt23k9oHvRxQo4eGoTYTer1ujIJR1QiJCnSngqVzfXFmdlrc+HE3sugKEtbFMqpBHVnorCBA8vOQ1JKpvjsTT+okhd9MmB1MH2MnAKTSv6kUET4r2mAbMS+i1c2KzNrFWISNubHVtl0mBrV+MDd177b42kALcHM=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by LV1PR10MB998098.namprd10.prod.outlook.com (2603:10b6:408:3bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 17:19:17 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7f) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:13 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:44 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:43 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3Z1436664;
	Tue, 25 Aug 2026 12:18:38 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 10/18] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Tue, 25 Aug 2026 22:47:29 +0530
Message-ID: <20260825171737.776052-11-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV1PR10MB998098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d75a556-bcbe-402f-dd68-08df02ccfc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|921020|18002099003|22082099003|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	bJg7rQg4MdPkuEON1lluAG9l/2TZp6NqTgGA4EP2hu9EU7EaVs9UF4qhJwJ2YSKYrbrkI4+eU4YzgCSzP9aVGCW4qEu9XivlQqC4bYAInREJ31qp5FQpaF5pv0xNj+yRlN+WiUjuncxX39vL/0Bpojyv7DS0abUbXCkuHoj0fEEt8pHkxRVBwOMf0f6V/U7KdKN85b5fbM64xpyjqjj1Z/2LPQXhr9aa2HJMV93O4vB0jX6zch4Uw+LU8JEH7ysmTsGPXTR1Ayn6cCIZgJdVzYbWpQqBz+6FhrN6L8S72fD2wasXnDNWk9f/cas6dAsvnygUA8gt1ticlVLj/18UidgOC+kGzrHVe5hBHE7JeqibhINQy4S0N4j0Q5TuYsE1VzrOHm9puthkOezvRqzOrb8CyGgChZuuxpQF7JnQ6141Kre2IYb5XFKuXUujqrecazrwDuKZihibiuHgmOm6COCa3vB4NsBjRoC/ERCl5QrZeyD6/Et+am8a25YCfv0/QXCjAcIOu8E3jfAjPMi00ykPtplOowehGXw/AZYztYjzIpeQKRAAC2l+aWYti/7z7y4p00K/TckXAbpq1K/piEOUKdU4yLketIJp8rk29UWcHvroJchYthrAEh2sf7kSLKXPg5sVzPoUIv3qRYFE/AXu/Yf77PSKr8u6ITDRixr3XPTMyz8t/Qf183UTkOYyrjWkJAzt5i+KazW/mhy8B8ar40HVeo/dlc0xvo6dS5aTGjiO2jNjiMSkaTVhYWmB
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2l9a8Vw7NzDolq2c+xqOSF6TpoQscN/QrJIvdE7GBTwCLYsZuRI3yvfQzu0T3Qnk6oaElEC6yXYvq7ExIFfnhOYFeTfdAE0Y2SWmD/JyzeOl5ZlHBjDQA3Ib+ZetrBEHaAIsC8a6fu6CDVF/r9ufQjz+gctPGNUTIEjYRSh2z2egSsSalJpyDsqU8xfs0RYYuTQKKIabdQWwSKm/qSMXrNbq6WxKFx4gXFIqItovsDst2wVnzOVKmd2adEXbicudhz8sn4G/AnfY8AIVPBJ76CPsAimpE2uxF2kazVJcZ0dj7ZjatOgsFpE6UHcj52K6M17QgUpPAhseWWnJJywufYv9pfM8DZtJRFwmRiS8Cy6i/3r1rsu7531X0FZECGTDKHpMI/VOKsE0evsQTWv2XCFlo40utKCAQYFY3WPp3PKGHBxpvW31wf4ExLMl1/5v
X-Exchange-RoutingPolicyChecked:
	PELgtueubpks5p3KrPGDY4nejq6KWMMIQj4VR9JmqKAWOlkTX8m89uuO4CbwwxveR3lLNKwePsaFLRzMOPDwnzPwB316hlzs7sJdcZPAvpNy922PjFm4bQR89s93oiEMk7lNg8KrYO9FoWMfraNkiVwRDOkOcpFSpdIWnB5HItuMw5TEdzuk9h9WCo4rI/PFnRuTZsGWlnIN3xb4Q6bnhtM5oRNJMRrf/T0nyZrHDJUafot+fxNealmR0fj1/HoeF0a/mrcZ9UcIVQrOnajk1hOrw4HIwrxNRwrxES2cDJUnPy5mqrmpAeiQwDrhEmOsD5RiW4yHfEFAwQl2TpZSdg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:13.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75a556-bcbe-402f-dd68-08df02ccfc4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR10MB998098
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXxR4q/F7W6gGQ
 GgIJxTP9obJ30/hcC+mF6NmoltAkKhEEYLIt4F0xsg+IMGr+kyAFyBh6J+BaEMh13j0GCw6B3y9
 h0btyek66ZLdA9aeSiIn25eGBiudkBg=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dce96 cx=c_pps
 a=MYJxclL+TLfs1lE1Gew55Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=aauMkRGVHSVL3AvwFNMA:9
X-Proofpoint-GUID: ZyNM3xOOGPkfOzKsoYn-hOtZML55g0W2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXz/eoE/v/0P1m
 LW48zzow1SEWJQ9nFVz3cLopBM6JQRAftuiN374PFhkYE9YLDmyDi8TODWUEAQUh0pc8pB8Wy99
 IKRDMyVEhweov2TLFEC583SdTW3aUHrvFD+CQZf6WIiKMAWfmdIe65WH4GvS9eRQnF0PRtnzWyQ
 E3dvmbpvv0frWcrCs5KxZYKVpdU1kzZt27fLOIhFqjcthGQqmsmSSWhzN/ABtODtRO8chiUFXGh
 8nw5PiNyBsMe/dbJr+ySapp+aaDCXjcu/AYw+iI1IqedjKWpHmPDHoSh/C1GEJyW42glkiy0+Kq
 Mz9qSTlQaaZnHO7UsGFG+3WpUN6zauADWGzoFmave01WTsth2Nxt8+QPVz26vtXu3Scm7oJ5fZ8
 QqSIbUV5eOvmPBEa/LMzO4FURQVrMifqHNOilB+nwa8h9IDKt4rXhCkH9HsfrEHDdBsb1ogRq6r
 H4dQ+iOJXzRj3qCR6Pg==
X-Proofpoint-ORIG-GUID: ZyNM3xOOGPkfOzKsoYn-hOtZML55g0W2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, using 2-byte-aligned I/O reads for 8D-8D-8D mode to
satisfy the minimum 16-bit AHB transaction width required by the Cadence
OSPI controller in that mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 75 ++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index fc33bbf56dd6..58bca15dbd6e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
+#include <linux/unaligned.h>
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
@@ -155,6 +156,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1529,8 +1532,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1542,11 +1545,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1588,8 +1586,63 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			put_unaligned_le16(__raw_readw(from), to);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/*
+		 * Use an explicit 32-bit read loop for the bulk; this
+		 * guarantees the minimum 16-bit AHB transaction width required
+		 * in 8D-8D-8D mode on all architectures.
+		 */
+		while (count >= 4) {
+			put_unaligned_le32(__raw_readl(from), to);
+			from += 4;
+			to += 4;
+			count -= 4;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			put_unaligned_le16(__raw_readw(from), to);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1605,7 +1658,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1633,7 +1687,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

