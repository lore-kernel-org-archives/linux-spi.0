Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFA3876CE;
	Fri, 17 Jul 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314409; cv=fail; b=hvvFGo5Lhj1jgqn6OX7wwQe/UIB4HpxWr/PF3+1/IT/9r1MJ1JjtYKk8ixsh7Q/pv3JqFAx6vQtu+5kjnLEXdrJgC8gXKTDfHtZgpXQIciU6IqjZisqga5rn/o7wwW6BPdu0flem6fFsxJ8XPHhQ9+x5//5BqzmRE8e/pCTw6HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314409; c=relaxed/simple;
	bh=zyzIHZWkbZiJeCTqvhBe5bpyE69d/84Z/bMFLKqBSj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkZD82eFKXvDPITks7DGOw2eMktu6pDVuLtpLgJ1XjNbGicl0XBJKD8ZX/DG8sJx06TebUn3+D7V0T5OZM2F351c3YpRT9cjCqRui1GgAI/JzrZHWb7/yaXaEQIsrDfJWdv6oUpsgSIj1LepqYzficumrfl2UpNBx4kguuEz7m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oD4ffpUC; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d4FBZ731; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oD4ffpUC";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d4FBZ731"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlUBv1570175;
	Fri, 17 Jul 2026 13:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yy
	U4=; b=oD4ffpUCYNaFXrSXHSO6aZJsy82vlkm3G+SCXiTb0q31PrziRgo4SdCfO
	ck0VoR9oODNpGfyhJ9nivF64JQVg0Dwt9YvYg3SobA9tUVuI9HVrMkwzC5HKOJfZ
	5u/JsoqYVCx6er631WdP/zBhO1jFFjfTO8QIVCWKeY1OQHhubrsh4N3MPGcOom1r
	p9aG4YCNrO1FLzDPSSdiEeQkon40RLLyfG2vrSJWa7VEvQUilfioi+fHdFS+wJPY
	lzwZhSmpGcnHn7iZuUKtcy+/CXOA3XFifruHXHZPfZyvKDx69hBKpJmwH1mkbRmG
	DwlA3xXh/jLk5Xoj3+q6A1sPG+75A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmbgxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:53:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0f/b9f7Xm2ZFH/TwjVfE0c8VddvwczdPK+nssPEhXooEx+YaSUyovXbkXa2csntVAGpZKnTB36asL6HmWVaz5jneTzemV7uQOc2nSl5azt5mO0wsayuexcNfKG+R+H/fTVEhMfPHaCwbIzXuC/0At9q4KKlZ1ZRMAHR9vvyjzOV4cRsTWKWW6lO4MOYO9yQvJkTPf3ENqPutEy4jQEUZ6ZfZNbxhPHqNRXjiUYTgSFR41pTDuy9PPJMta5nQvbuksES3ZVuU3D3IkpY5Hq6ZFKbU4gjZGPz4EBt0Ys8sEOIhnPPosFWpUXHIHG+VNLB49bkvtf64tsKJkRPurUyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=FYHLe92e7a75EowWVc8ku2WrGqhVsE5SZ59WwfKYbGcX9ac6SoWcZvlK99vOxQ+lDbbpBYyjTwrIWTgKF1bYJIUFn2KmMmcdTWLQpTP6SMg/OiAzhb58mXvH0sCxofWRnsfQHoS3bX3hTKZfsc+mCOdIjTGf2m3oXLQ8hPHvMPLhnADHEXLbR3Oj5RgSjEpZs7/Jg8lCI1AlG82fUWp6adWl9cm/Kx/ep2dAimSg+sdXf3XuxnX7JBdtRJlDuAsPvTLvevcj91K73uGqCSDhnhuXW7QPWPl6HlnSZUMHlBRg00AMOyPJI42kThrlZgHB8RnxnA7MMe8FFgJbxgROYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=d4FBZ731BhClLE6k8bVl41jFAbABLL2/0A7nTGX6jyTSip1hmPDEEq6qN5mRy+fG3vLpR+eHw9Pg2DlXgvxoa+Px7MqqZ1gccRJFm/RcwjVMrqPR/MOdGKA0ce2GwPVD6L23sFYrvChGdw6ZO7yLVpsbc9mUMd0hxA7t3LcqokM=
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by DS7PR10MB7249.namprd10.prod.outlook.com (2603:10b6:8:e6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 18:53:10 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::86) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Fri, 17
 Jul 2026 18:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:53:09 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:55 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:55 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU52240969;
	Fri, 17 Jul 2026 13:52:51 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 16/17] mtd: spi-nor: extract read op template construction into helper
Date: Sat, 18 Jul 2026 00:21:15 +0530
Message-ID: <20260717185116.2065505-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS7PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b98fd82-11e0-4ebf-d456-08dee434a525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|36860700016|1800799024|921020|10067099003|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	3rt+pcjzlA1Hokrly4WJa5SjTFNzNhhO32b+rAJLlGBGodEPGDmaJi+n0cSQpkw/LRgvR11wsKsWhdmIL2RznZRuVvMRreWk9AKCzFK6+fmrk3Ks5eFLXLyeJNe7d4EfzTSy3A8HMd3yevVkibMGOPIqlsCnVay53QpMlWzcAkUxr//v4OJ16GG4P/Pf98IhzTJpEWgMPNY8eIx1aFCO9oOf1goqiHJ8aw1vHDk6sC5a7nfpwICf0ADft/umJiW60BlApD71OGWrhcZ91Rgk/5bNST006sBki9OJF6TJFQFY6ny03E2ShhZEAr1bNmO71Q8Q24UTwOBjMLJvRAUVIAjF8NKwRzH9l+zH4+YyqR6oF41R+nFdeSP0p1ICaMv/HQJXvgoI7Uyc6U8FhrKqyeXqpWzT9jUWtLjYL7K5AhiiH/adNQBIqkrIh5OPXXb3Wk+oN4ys+ZYPToMdQRlTQ/pRMDwxfK3VHf8DFYhmOLaQJblSVOcy0eVkqELpyhperDeU2MZS8e1TJFffElxyYBxan/S2A+iupKIIvvP4IvtyaBDLiLL6+sAS3mSXeVWMdGsSQfGP+U96wRBH+eaAU5e1eEPvWepgAtygC4wrZx7u/lo1x7Q8alVjeoJn+Q76stWLsnvU4tkre5X3bkUey+02c2PcPSEYQzWF7OsxpxRNWnAMKARDV3a3kzNI669WhNxKD4tbSBuOA77CTJVXvGF+klUrtZJGxv0TFKZlFdif+rjDwzsuZF5oZJXUEqiW
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(36860700016)(1800799024)(921020)(10067099003)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WLUxVf4A8Xlqjj6dd4HAHNfhAWSZTuQnbfXzKiSXmsKCJ5r+qp8hKJCBQq2n/hxVwZxhTvTxtQxgAjygUQxasF8WQd/vqYYrFBUlpqaaxbFy7FDCK+39fBCE4ggL7b1n/oa7NYPzIZxDhPjP5SkMsBBU266u40RcglV4kaGg+kgk1UoV6FeKo9+Zd7wOzvCleFf4rT4BoZEb7vlbv9zQVj97TApMpu4irDUjjbFEnRtHbMivamEDIXXVG/UhPpdTwv+Pc4/b1T7vlAdUsauk98e5WVZ+8lalfXISNxrua0qg37gc5brccOZDHQ7GuKVjhXAQQBvbcdCopbAjdjBa2wJaHqhS+grl6+WH7UgFkwzRoPspUcNR5jsX6Yqx8czerKoR1r/Kv1n7M7p8aj1aczCetyBujx0WQ+IXGsrccRuR9MMIlhUdLp7+TB6Q1GI1
X-Exchange-RoutingPolicyChecked:
	JQIIH7ZstJ8UcrvFeXoe27H7TFX6LszXpjfC6OzOkS/glf7anos8owBw0VBEeticxWwWZv46wlCJimHBu0f8A2Ydv0RJ5MVSx47bIOGJczVCgxxjHWAfOa83hsdLJVEeWwsTKMC9hnWmgr6WxDSD4RbmvKVs75B1tZkJ5BGpq9oqqjRJ4kZk3F0DVlDrITcyzcrNk/A3lXl89M37SiVZ+p9RtYj4TuyeReoPhfVD+/BmazAux0b1T4J1itDoUANAYJQcuj0v8kqpq2aaFdQhMlJ+BNfmsrintp+D3+rVGJEKtNGtIUd2ev4in7IWpFoXTkvTk+JeJeuwkBbN4A585w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:53:09.2039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b98fd82-11e0-4ebf-d456-08dee434a525
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7249
X-Proofpoint-GUID: iNMrb2X4ldVj60xSeAS14zkZ32X-sDXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX6CWg7p7ABuuS
 62Qbxoi2XwbMYm2Czyky4q51YrMPfSgH8fVVqZkklaFr6vDL6MgCnVHYZriXQZHeLAqYju+0748
 0CxRtrUiMwmTNaNrCJOPJ80kB8q2SUWmZgxBWkifOPtW0JeCT7hWqKMedM1g0F5tQd15qHO4Iz9
 gBz5gLHgr4QEWPe0+DWHsFtKtE7TcRscQ8pUCk8/XuDUyKkWBWEeuVv5fxH6gyDdMg4QiQm+Oqg
 AtzJiUdQ6CoaKx03t+k3d55kpQOxtfBy/BrfeJnauiKS5RpjOM+KV8ab3bLolZKAKw2t5nZDKXf
 uMvxrqLNFgF/Q8yC3jcQUnyKWgDsCcZpQIjBic71Pw788n9MqZy2x3EFB/up17zg684j9Ld73ka
 qrYbF6noCkxJZrmyRPi7oY4MY/dwuAoGPXx3xOhJu01RnegQFcjMJbTIe8Ho2edYI191/nrtj+X
 CjGhHVinAy8x7WkQK+Q==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5a7a1d cx=c_pps
 a=diJABEK3oI6sFh9r2i/CNg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-ORIG-GUID: iNMrb2X4ldVj60xSeAS14zkZ32X-sDXc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX95CglwnpocTE
 Sbs3JlbI7NZbHsHy0fAPT6HLwPZPBoBkZWaAAX4OUxS48W75QHOqb5RNRxGOb/SwzhYznLt1YX8
 KvBfAgVcjNLhLQxD/+2KIaXGxo7D5IM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

From: Pratyush Yadav <pratyush@kernel.org>

Extract spi_nor_spimem_get_read_op() from the duplicated op-template
construction in spi_nor_spimem_read_data() and
spi_nor_create_read_dirmap().

Using data.nbytes = 2 as a non-zero placeholder lets
spi_nor_spimem_setup_op() configure the data buswidth without a separate
override; callers replace data.nbytes with the actual transfer length
before use. No functional change.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..b683c077a233 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -188,6 +188,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -201,21 +232,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3712,28 +3736,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

