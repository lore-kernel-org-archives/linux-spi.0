Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FA3D522F;
	Thu, 18 Jun 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768374; cv=fail; b=QMROVzRMRcIDfwanktybj31wef56xmq/gjmVNHhvt8Ssp4Im31XRjdMukF2fkc3avm0QHxrrPw0hlTtBogr9JF3PGELtjaPEIdjGoFbh/zLBRtzp3rCuet7vkVw7kZuLtIYROJcTkGEMbV1ZyxHcAd+2Ja15+V4mZuAzTtHHRu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768374; c=relaxed/simple;
	bh=hctqAfgoMyx82vfFDJZA/RKasIcOLJgU72iJK9bfuss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmvGuKiz1Hg6lp5qmoXSxTDA/YsZxccbYVuysSz/JSpV89a5xNFaL/iYbVfcAMzyaa/0EpN/A49hb8iE6mUVrpwX8yb4qmcf0xcuaTtwVoOKlwO9A2goE9U6QVCELhXn3yXBV83c4am25zieHw6XuUYMg+GyhnhAmO3K/dnuoQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Idwzkjrl; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gTAgzWCN; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Idwzkjrl";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gTAgzWCN"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7WrjH2383810;
	Thu, 18 Jun 2026 02:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iyiB4E7JuWAgLkxJkRqXBfyZ5lxOKjiebvcEXuxoH
	6c=; b=Idwzkjrlx1WsL1Ci4m4jH+BEjWQIdSUigWVEZTg/XF4pr/h0gNh1wRWWu
	YiyHJI98SOndWcgsFBlJeGN4YDA3RBjXw6oLc1cp4mx8KfD4J0ht9G9hFfx8LJ0P
	O1qLwGm5p5r4cUgK01xzmS0zgxwgU025f46jF2dFpb1FkiShpwkxX1pvmE7JFMQT
	7Z9qgD46dJnOUeYA7xToP9CGXdSmfWlSadsJdM9gkjbOdHZ75bjXTEJ8Bl8mICJY
	e8SwBJsS4vNuEJ5d8wupx/06Kxd6BBD0d3lO5p7g+3c+DraYPcpnpoys3a0Q3H8k
	kKNGLJy2zPvzx4Re1MDFU5bhiAHFw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	by m0380145.ppops.net (PPS) with ESMTPS id 4euthp6s7c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvCg3ZpiGwHguqhBddeQaSjjtw0W1Vp0VSO0TbfleaK86lYEygn0yPIdin4myRF4aGMCRNn4/d3aDbI0eQJnz5dAASMNcvBdk/XBVjvbqJ7GxhdtnJi6h41FRYupQzXHgGcqmml0qp2sPwJdvel3wKxLOx0GCTHkHaX3YPtMUP5ctOsJizBMa1D/jSx3ENhNf83PdNjKC/Tc8xDCPA7FJeZDwGHm94abrD/yUTkwhSQEBzvYQUtdugjUXPSFFUoTJdKvMzMnONSh18drw4jQIY931vs5fAiEjVDIkJCeNUgdt4y9msjbTsBCTcspIC7PhzJW3pc2e9WUgP0iI2JXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyiB4E7JuWAgLkxJkRqXBfyZ5lxOKjiebvcEXuxoH6c=;
 b=fd7FZDovDASuxI2S1U7z0UCTZH/nW45ipsZ1N2eI+y41/qPrReGZPOk+wHrs3pSDGZTsAo3x1ddyvUEmbtTZmkZgbeG/CD9lUhvjoeNU0rgRFIPJiTP3BV2qSM9jRynIzamQBZ0B9bxEyBHNKmbI6NzB1L6tS+Xh+Ueg5h9uqYJVtKrpa9fmkzjLPvLjAJjR6R1etWFwey85PUiBvvNRiLaD75/2UEkb92ew3eaSEI2XrNVKld/ZU9dbTCzefWuxtspTPVhEvwqKarGmJfB7t9D+TK/a9R8uLTrOL72+sJGuhSQ4wfFa8v35dDBh0naQJUiB+BWDfwWlD1LlCIwa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyiB4E7JuWAgLkxJkRqXBfyZ5lxOKjiebvcEXuxoH6c=;
 b=gTAgzWCNmP5jAksonm6icXD2OjyeMlWa2EvATX6VE8Nte7YWp8LKKFa2OdWE2t1svyETrLxVktMnATqTtrKy8P4W4ZoXCrY6D8DmYpy1WzO7aLYFmzYauTOmZKaGjM/G3bGJhPUMNaX50jSRUXsAMU59v06ttpJBATWSap0PJVY=
Received: from SN7PR04CA0200.namprd04.prod.outlook.com (2603:10b6:806:126::25)
 by DM3PPF9E376D9DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:39:18 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::3f) by SN7PR04CA0200.outlook.office365.com
 (2603:10b6:806:126::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:39:17 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:39:17 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:39:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:39:17 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvr3521710;
	Thu, 18 Jun 2026 02:38:57 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 16/16] mtd: spi-nor: run PHY tuning after init and update dirmap frequency
Date: Thu, 18 Jun 2026 13:07:25 +0530
Message-ID: <20260618073725.84733-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DM3PPF9E376D9DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 65864a0a-eba8-4dc7-fc2c-08decd0cb408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|22082099003|18002099003|3023799007|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	CkQ5j2SdcaEQCf0zNK/cSgn4suY0IBgzacQ17NvLRwRsPiYVKSajCGEyEghtaCptu+ZrSGHjTs3PgfR3YKyerivJjgu9RiNdfZaSeFW94auXaCsPSehX7B2S16SwYsCmk5Id4if7zw2mXpL4iIOvyaKqk2BjBGcM+X5jmGB0M9SIws9IJMeAgXXgr+119BIQEs/xw2mzjW6LG+2zhWjLreCpccbg26KPW5hMKqKHT7xWCZ39FAufqGMorSxchl+A9NKmYmSWIQFWDjiBhScr/NKP3UIGDcsE4LtjgSFh126opwlgRzqBc3MbcrcHgAqE4n38IiMph46teOJnAXLo+Xv0pUif15xeK3iHo5I8nyneyBZ1d1c6/m1noMGK5Kq2EJE0PlPxiiud7DUC7UkyWl25z5YOD+feXe2JdF5xX/TKhue21e/yaSEXGiQgcBGi8lJr+TUNjpVu2zQ3obKuQymhPuYmbUtmCqH2szJ/mxrb/iE5vlhwc5hVKQruhwVQOpRI79JjyGtekC9vJ2exR/XPVBB2z/WaVZ6CNXhGtZFYbPofTPRYGE01/GJhHh70jUsPdXLFhDc0+1m8tkDvmVh/GUBiLg6jMMcTPwovGu1NDQyWCNkGXOC1bR+8JsanzS1VbCX1ID8VfCV8kDJwPPFkyqA0NH7PXpARxkRj4XphMc50hCWp4A4VYgMqS+2Ko77VmnftdMCuh/jb1AynKPg7fdEA/dK+yTly0DKrnsfuonujFkiNmCLaeGH5Ip/oc9//eYcuBw+gCm9cPG+WOw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(3023799007)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fb9PZhqaV6bfAGyFyCpeutbasmeJZfHLCjWxf/dQHvEOtEeMqQtQ3tgUp0m1KpdQCrpg8vk7RN4guf4KGfM+p9WPE57WqRL+h/Andu9bUu7PGiFJMqXum9GV50Wsa0/G65oWSZlZcG2OErTNnsDFh3mcXqVeEPRtAGNbAAcC21RuOaIVvYUfun2xMjF36upbKOSeJJHbVFbMCRFJeAsl+z5iohMvoH3CjHvfmPp5nSrOovlyzkEtQ0/dZsTv8fUT572x4L7Xa1TN259TtefnwCg02CQndxr8vTvp9EAlsIkBkHCw7x/4QnsTcwXqXz9u8vb4l8KbLb871SEk04Fer5r8aTfCteARSo0+mgPdVgl2vFg0zRiyKqbZXriR/LCuM1bYQHWo61w/JGYdIaXfE+icdWwwW8f6vqPi4Vig2j+gEGbyYSZlW3ZE+l1Psj+w
X-Exchange-RoutingPolicyChecked:
	RNPIGTT65IoO8IZ1gYCU+/PFowFUhdPsAa1eATaBswVHoRiZjqp0lCQ/kSiN1Q+Gtnky4UB95NaPK2GfXaKR0Ett2V/sOul66P5WerK8Pb9PqVdGmvvFrTkovicuHHlsNGf5zMlDQZQNZWagDfGQvutPbXrxgYlJCHgdhimf9FNl1pJGDK0MV5PPy15/BE5AQ+8V8sbi8bf8rBrlMI1BKOHRVIctDOKsATlupBgqUgqwCD2s+fcTwxhyJUo0by1TiE+b3aYYvQXR7NckKxQ5BlDNoCqK0QafP1sLPlZ37KJImLoZh3fsat0RS6mdhJC1IJKndZeotNoxHqk3IVIqQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:39:17.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65864a0a-eba8-4dc7-fc2c-08decd0cb408
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9E376D9DC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX/8swKwp7hmS4
 RJoA2iGlA8ntWeZdCSpeNWmRHDV2XyL7KNyVhZn5b71hWjIHYt2K9ciaNgByZ588Q9o+MsCZmQH
 yZGkdz6+PYIjPA9F6Rg8YSLnKjgj0dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX22J5f7mIdK8Q
 5ZPeOlZFptZwssHDrn4MYqSRhyr6U6bqgDpd4SNbPcrNdpggfxRfFiVEeYBZDpokckK9oMiS1D0
 oVF6U0tUFFMtO9NJAV7KBTwDa8a7zjsnBvCM2GjoCBxHAPTlN9jQcuc5GtSGdQaU5nKHgKUgqY5
 R1UfToI42Mobj+H4FByn9vN5Dj+dwwkylc1/CqcGBU8RdXBsmXZCXSH9cmZPJ2cvbhd22aoDEZU
 YbatT3O8ll5tW37vY/kaYbTQE+lL+aLaPoksuPrE9+8+MAlObYr229clQEE09Ew8pRvJV3rwI3Z
 9i5/byra8odr1fv5WYzXsbOf+c40dEjfUvDvPI8pe3kPXF/xtBop3P0RUX9p9K760yxUKJbwk4T
 2XWKOm9N7CpU1FHatdyhrxldUF8qBEX5ECoMONVbN2xpCbR9rYGM+iJVtyErc5PirR8hEiREjyd
 xeasENqv78Xg2D/DPwQ==
X-Authority-Analysis: v=2.4 cv=N/wZ0W9B c=1 sm=1 tr=0 ts=6a33a0ab cx=c_pps
 a=TofqhMGnQVwdh0HkHXulOg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=dAWDYLcBFR4q-bF-ZFAA:9
X-Proofpoint-ORIG-GUID: CBRGxJNQjtTS_vxMAs2ov97uwSYT1N6P
X-Proofpoint-GUID: CBRGxJNQjtTS_vxMAs2ov97uwSYT1N6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180069

Run PHY tuning in spi_nor_probe() before creating dirmaps so the
validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate. spi_nor_spimem_get_read_op()
propagates nor->max_read_op.max_freq into every op it returns, so the
validated frequency flows automatically into the dirmap template and into
regular read ops.

Tuning failure is non-fatal; the device operates at the conservative
base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b683c077a233..a2a2cf3d3603 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -216,6 +216,9 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/* Propagate the validated frequency; zero before tuning. */
+	op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3843,6 +3846,17 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * Populate the persistent template and run PHY tuning before dirmap
+	 * creation so the validated frequency feeds into the dirmap op.
+	 * Tuning failure is non-fatal; the device operates at base speed.
+	 */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "Failed to execute PHY tuning: %d\n", ret);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4b92494827b1..ab498a50f15f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -422,6 +422,9 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	/* Persistent op template updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

