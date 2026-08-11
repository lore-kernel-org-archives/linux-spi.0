Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985783803E3;
	Tue, 11 Aug 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473320; cv=fail; b=Gkji05hcMYL3sUFChpyJnROV0aBqHgZ1+cCNUZoScPzIH02+PZ1wBdBtUxXIhAT8D1AoOotyYQylikiVfOEspqaXWOyVR0sdYLkv3ZDal+mkjynNmAycMbthuKgzxu7DcSqGd8lChS/vSxuDniinywcRwX/ymKiB/q5aOHdZ/EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473320; c=relaxed/simple;
	bh=QCZfApz0WI4MJamsj+4VqpsLIBBqXuUtwo6CKXU3FV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeKKOJC02tUer9sNYdJpE/sPRVDAYda+ZhATUOLycueVymIHKAGt4kWj0bHuYH/KUlZwhjx5I1p0TQERPyWSbqP2WBt222zOQm3Keo6+a0b7oGTwiG5NmNV0253CTlesp1CozyNOZvkp9x+vcGYJtW6A0wJKUPZ/XzWbzoeIDLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=cq0etVM5; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ieFz7rGj; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="cq0etVM5";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ieFz7rGj"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMNbf1824579;
	Tue, 11 Aug 2026 13:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJR
	yk=; b=cq0etVM55pNppS7b1wDZxvEA4CflKjz+kj64z3BUl3IpHTcPRTKBE/9i5
	jw2STZV5wNJyj1QZwEFFOYgztyEQDH3PgsgskmKYeUwn10P2cLcppSIlvgEyX6/5
	GhjpaCecCMA1yE708FyTInG1C9GGUmCo/WPrWhVUzapoij2DkmJrN4mWjBnMYFck
	MTUPv8J59RvYcYXXAPhCh4Tjzt+G7mJjjfiSmnQFT6lJpzImz6CNYaOYY/WnuWJo
	btThpMiyzpSNUWeaSAP+6T7aK4FUezsjF7A+AdI8dWmlKB0yD1ellSxdV0Wi3n87
	qoWnY2c2C6adhJnKHGlHF9DZiL4vA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00wnbkbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlgUfXJa5EOY+vWpoCM4cp1Y7eRaxJj9gJ8nNxJjt4sHRRFyUnQyvPdLHaqzQdCPaDlFzU8DPHbSimq6cXtwydbN1enrYBL5ug6x6OZy0ujaW4kkjp6Wpn90VIXabh2S3rD3LhqCdqIcOrvZN7HdcLOxkT5um8sPhhXJKc1PDR+YNYinQ42u0qgp5z7ZCLwfNq+EG2PL+yPJ32s2rna1637PENVvo/urvoKWCQRVJwFniFdkHrO66NTzcitJEnjAs09lVQgLfwEg+l/g0dVA+wq3JSES5lXcqvNWV+1PRh+0zFxhLiHKTrOUPEYjKBx4FGiuoH1UozWTW4umSt925g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=lz2tNRqk9cqZinoB/m0v6+Sx6h8MflgL7Bq8m6dliKhOPX6UY1FVE6hicQo48aN1W76D2P6ly0Q9c/235YflzFMf81N5pUZXCAOEH0vKnVHyRyPU0cVg6AISVo+MvskBNdx/hH00FUOjo09UDcOAOT+rcwwKKvI7mjprz5bmKqqvbRHfWi0y+a6s8RVZHUBmESCx49H5+2IBKpJIuG5rneEjtBmu89X5L4SrkXsBULpUD1HQydMeiKLSfc1xqQL46prJEj819dZ6k/tFlYPqgqR0z7MiIryRqcrcvP3C71TSzbl5aguho/wEHPk2pk/X6MmsvvPllX9rLbqEWOEYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=ieFz7rGjEplBdkbMjDPM6MzONNDWn89krfE1q/zc9FE6AplxawOiY547o1Tmp1x0m68uRpCYZ13piOl7OhfaO8JnfI+mGqzjt1ZzV9FTE/cPPLtuG4tft+MbiEfswelwT/FZxXVaaEaOMfHCExn9IE7yArHaham/MWp2oZEQ8RM=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:35:03 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::80) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 18:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:35:01 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:52 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:52 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIeA659766;
	Tue, 11 Aug 2026 13:34:48 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 18/18] mtd: spi-nor: run controller optimization before dirmap creation
Date: Wed, 12 Aug 2026 00:03:13 +0530
Message-ID: <20260811183313.1550425-19-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9cf197-d2af-4263-01f6-08def7d74150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|22082099003|18002099003|921020|10067099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Kmt7m2RuN+1zePww5ENTmHvrrE3IMQeFuXg36ObrrT9ta6M2U7GFWDb2iOLuEl7bvR+Ll0/UV4gzwwc/GpU3wXA+dYlOHg2RlqLbZErj//pWtIoOiRWb9FP0GpsAYErAKAIXRVEN+jWZGivkk4taemacj/oennbLLZVtQXtFF9teI+Z22hp2jerVMzUSzhDjYs1xUGIcYI43hXODy0wi8vHtDi3z4REdkRSXO/LT21xcvgvlVm8eb5EWLkVow6fAiXWnMt7yHQrFekJENKOT6jcuqIWKr8KNRIEhAjoheuSkfGn8STGBNRikpEyOGx0xhZ48FsLRQI+OLG/jmckgLrYrebHWTGFQtXspLQ8si/81GeREiUZKi8ZizYuJ5JH1WEM1GVbeLxgLRAfM+usptAmrJOSsqhD4Oen1jxaLaB8AfPwoMnAly5zq4SyG5d4WSVudiSYt4m6KBCrxiNByeqnY6lq5etgo5SxkOL7C6KxOiMfFQi3mNQnKphDYdsnitH0PgfGFg9Qvx3BkQ8KDHwQEeDE3YTnymEGkdQ2LPwyHWSInly+gZyzjiC1uutMm6GbjHJaCEweaF+q9vH9ZDOpb8U02xlql3mGCNeW90b141+BYUwbBSIiYhjGVgrkxwUyS/nk5DHuEX/3zR54WpypjDla92hV2eSwWIF7CQutiry5zqZ+Tuf+diz4G3oEi6+VWwU3pfMbePjPEmSBjO3+P9yEevmu2dJSoBeqXFKgU7Dap23UG5Tk1kwdL+iwJ
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gDC6WW5HEY1g4r+0EYQxNdBsZBO52jFae5ILd5uHPKIICVTog78eY17iFKIsLw71ESDD2moxFS2Od2XFl1ODWdzn8vF2cQW+A0QuQMCp5QjtWbgzklZZ4ve/VgLVn9C1b9KVdq0/yIrEuVD3HsvXi0qhaL+8k2THu5axwgzCdM1Blx/gqhZ9jVPyz1wlDNnRmThsVDwu9KVCu2IhZvDdd7TobjdTq9IwS7q2HlJVw/4RTjeR5f5wUwgE1Wn7Xdy03Xsyu+ZFOhjWeLXLlCpetmQbfXE+cLSApib9pnFZPGLjinw0oSUXdI+giXkMfTqaI9T31d1/MCwiR0f19tiXDpLtw1LMtEuONkQoI2y5cNIJ1wWyT1MxIdP13j7HYlqyMnDiXG1NJSRbje45bNmvpsb1Temlfw1yToVWfUwmo/X9nvRhQnzMrQSZed/MOZxx
X-Exchange-RoutingPolicyChecked:
	ssmzCYXHF/mQJyINjkkP7WNDYL+pKytRd5EbnY+77qYIvyDnsrGic14dJbt9hASAiTpkepi6EacBUdITZPhdcfk1/7T2H3io++jbIWoMv51yDbnJchrF7uyV5WyA6cXb7o0oRFhiZQ9Iz9KxQCaXsW9EM+Oy1/RI1AQhTo/OnUcKgMNEyTPRA/tWJpuNFfm3T2SwhJbk9VXVQH9rlt21sctd7U1OM2L7soLVuVCPauNvnO+rzjImZec0A3pgcloj5VZyIgWxL+RDYI6WR0lCr4eGvUx21hbNvR/IJikEiRytfjZuwhxFHOA9C+nnv9dPZaDWQqMCOpAfglugJjtnIw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:35:01.7669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9cf197-d2af-4263-01f6-08def7d74150
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX1JXy4YnTx2uU
 CYCuAEb78a2Jm6kmuanDalX09FfAynKLFB8nWtyrjfmKDFxBs3qdP0nWghyv84Kx5xVZ3L3DJ29
 2lOTXkQ2+5vNwYhp4ZgfqP0TizHp0Ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX2S1c8E9SPCmd
 ZHHR/6MFxLOC1UfXN7BhCKnyZenVydNMsGxX1rplLbVleyXVrTOyGLcZnZbTkJy+fM4cOmaYzDv
 UzlH77rGElHhClf381eNkckxsBJk8j5M151pGZouD1VMnU4SiC9bcHgjXqanWKzLFjsM8uw23JW
 t+SfICo+PQrVpc2sIxaR9LWatPxmPwIBdPfLYz+pya9Tu4zKybgpg8PZyqau5ajhV5IuntsUUdI
 4TWss2hofi7LNtm23UDns2oWNfiEp11qIhJ0LKQO45uQ61Y5YOZFZYuA8CaVoc6/iltdzWvuOug
 Nmzm0KefT6t6T3R7wQetEG1yRaurMUQ2/89CZ6d+zgll1UzvDtTbyj4j9kibAPl8ZHL6CsLvwdV
 crNZceFJSrdj5HDnYXBo4tby5pVhwpc3hBapIGuxfTgKzCF5wmjm6GDOXBP574mROAJGtI0X/iF
 Hjpi7qbCkcpXSas2mQw==
X-Proofpoint-GUID: TnxmyzMaCXRHdEeZgh27l09KcPdRQGer
X-Authority-Analysis: v=2.4 cv=cYziaHDM c=1 sm=1 tr=0 ts=6a7b6b5d cx=c_pps
 a=EbvyHBp0GqBzY/XWR/wUiw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=dAWDYLcBFR4q-bF-ZFAA:9
X-Proofpoint-ORIG-GUID: TnxmyzMaCXRHdEeZgh27l09KcPdRQGer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Run controller optimization in spi_nor_probe() before creating dirmaps
so the validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate.
spi_nor_spimem_get_read_op() propagates nor->max_read_op.max_freq into
every op it returns, so the validated frequency flows automatically into
the dirmap template and into regular read ops.

Optimization failure is non-fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b683c077a233..2efcdc7f637f 100644
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
+		dev_dbg(dev, "Controller optimization failed: %d\n", ret);
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

