Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11932395D99;
	Fri, 17 Jul 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314342; cv=fail; b=isorndgzQN7jfQpua0oByd9wUyHGxOcNZY/6UTD8PQP7n1T6JKIDOHlVVHSz3ZMJHEsR5Np+NCa6Y/ogE+Dvt+a0fCh3MpMOcYSPz/pCoFMJkP7eVKngdJRdfihKvnoGMyQpVzYSGNM5BPrJjEdSwooQyUx2yQeywReKm03H0bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314342; c=relaxed/simple;
	bh=4oa26rSgSzLAyhplzRa510WlcMbc4I0GAPg7DwxDKWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF3E1hFFq+HmU8Mmd1gd2F119MsnVjjaftsQ6VF40Wu7kBS+35OHimUP/9IIqUQ1h0FBtEODVG69NI4iENnrXlNvCSXWhMICvp3vHGfrdAREVUsMN0shd6cwePUBMagFhLJMki4dnWODxrzVrBRzDPOp4PPPjBsL+nMzHhwC670=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZKyQv8SF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UX1A+tDI; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZKyQv8SF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UX1A+tDI"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlFLu3222590;
	Fri, 17 Jul 2026 13:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0
	H8=; b=ZKyQv8SF5g3oEgrz+i0UA1sRDUx0IE/K4/fUwxKtqLf/P6FzMU3ASAjns
	bVP9qF5bbwMEJEkbzyIP1xowzjpyDZYHRtr9lRFnymv6XIJbuJ5zNUfAuqigJV3S
	pq+oANrH+SzW+l+iGtva8VfjLYe/jZ3/sPrNVMKeyILkquuBRcDs44J9QmuLsIOB
	XDIs3H/zYTr1d3FrEZHpvrfSDz987yCsmOEOzUKldymEnJGbQagv7MwER8kXkgbH
	ObbZSatoi/FQCSaXrPafE/+1R/26Pc41OBTAJECw2UfGWnNx4ZbL3ysLqqSFqOJU
	meuvDyN+1aQwH/Nvc1GAUmRx2x5QQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3jtx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6d8pUk1m7kFvkMvuDG2mYC1KiMgCSZkbDDKXlcNIRhqxCZcs7TpdPMvtpZx8PWlwRWsPyWBvrAfepMLU7ZtkyIE0XlujhMo4HI1JOmjen04Bxq6XzggFbSN3uBXX2ix3Hg4lhINzQCBOcL2oPKVB+sZek1qN6aZGceoBturUVYsyr0S6aBiceQuXfLK8owuJN2nvTFhDc/wIU7fUi2dng2nqld2bz+s3JCitQaIvVLaLFVYM+JO29gM8DD7ZqnDSXqPJfndWbWXoT+dZRDmWFjIEbp37QuPsyi70I7e/tGdkAN2mkdlT5z5n1UxAfArbanPDWgQhDTbyqxEpQqTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0H8=;
 b=dnCrah+lL3FhhIUQgtR+2Js8yV8xlIARgb/KPbg2OgFJVGMGVOeniFnC8oUVP4K/6753mqf0RaRzJy1P1JsbSYw5LQE9Np/3Sk5KZpUtPtIiPqNTx5rTJWL0DPHtajdmgd35QwfdPWBogU4rWrFno5pE45ZyOhP+cGlaMb853ZeiwDml5I623TzmZinnMevjCqQkhVyFRRqzarkJtwabz94m41W3TWYfIqqxlnwBSBluoSwNkXmNZ1wNwdEjGGM1Kjt2/2wnIvR56jE+QIz7oKPpx8SGsQ0BT5BvoFBHQ2nrDS8ciU1bnbS0bnGxyVce6B7sXfokSBBYuqEzIqCrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0H8=;
 b=UX1A+tDIU3pngBHXlxliuiBWqFUa/u8mz0IONW/18SC6TGAI7ka5v0AhF3yfdXDJmNSrUbgudGD8ko/r29v5extDqG5D03k2GZbXeGh47G6A180IvIEazSGhVIA+paNmASEKxRT0h9EaiLyNvqG98NNYjnx8iDVKtyFVHksxVbk=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by LVUPR10MB997810.namprd10.prod.outlook.com (2603:10b6:408:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:05 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::77) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 18:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:05 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:04 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:51:50 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4n240969;
	Fri, 17 Jul 2026 13:51:46 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 03/17] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Sat, 18 Jul 2026 00:21:02 +0530
Message-ID: <20260717185116.2065505-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|LVUPR10MB997810:EE_
X-MS-Office365-Filtering-Correlation-Id: ed31c573-d272-45b1-1d3a-08dee4347ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	X69xPt3iC2vlifCAnJQWPWOUdTYE+25AJdnjQlZ35eN0zORm+iZEC5DByh3tuqCnQfE2a2w1WkuogIK90nUfkuPXwclHqSX7JsTPGXI/vb7Fy3fAribNrngNyRHkQxhsLXanTBBNeBunaFsCIg5c3DGC12nWs1lwKqKCoKswHHymYIwzlzGv6Yun9+CULNKMIuk5N92hM4dVj9m6oHSAT9D8fwkBeWdKXlL1MzlgcaaLI4BfiLwfD9HpbkTCusrlNxMPbdc3LaHdz18d4hZkXflMSluvWSzSdlLv6TTCW/XYHfOnJtzHUFNC4Ios8+rXzUR8lhU48nxo+nzpx8vSWfpEhq+NMLg/3Wc2oxFZ+GZ0lmbGbQQ715xAgihwgFJpNEYlQUFTBPTS5Aw2FlqeQS3mErXtr/9FW7T4xYTz+gtF6S3PTdMkS/ScjGHvvc2UXtX0c6TqwQNg8JJ6AmSwG42WuHBuT1dksWxx5ElXchLlw/+OOnxDK5BdX+q8ZAzKUVmwxeGH8iyv5zcACrYm27+EQloVnVXFRuzcyKsUbLBL0N/Aig7LATF3Gvs3JDbHXWh4/zKLosYv+GMZ3Y2rztnZVK+sMIlDr023YoerQ9MEeTDOUx1mujXLnp6RbqzrAZZu5L1jD9cfOAy5DIaN00ReOCW4X+t2QaDZEC1TjLuReuihnem/KeNyQmTbx2ghmef1WLxZ1Bxgl7m65JspBqIpF0XkbFgJ/62ivUpRoVYX/ayKb7FAvX2ShmuoK4+B
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2T2OiEEynDlyzBocCcUE3xDsofIkAlgCPfhyYzUx9oEXsg8ECPlToV0bU1kQfghcWmathZhLbWCwbtqRjmmsR5B7nAOGGEjKKooQQ3yam5jJi7rW203U2+2oCQkRti7ARiC+teAZafq86CMAGN4BKUXa5ukn430CheadhLXGj8jhTYHc5WdNzWIQqrJTYUS63Swfvsgkx0z0Olv1kHFLCh2eUQkWOM0oYVItF3H/i0dxOUErZB9Noe8lK3WoyAh/cHkeumeO4sPBc/7nPXaxLJlBGdADm/nSswee6znddgr+hb5ueBiWIqL1VAzCLD8Uv/1G8rNUG//1kZba+0meGmy6sY1ZZUTDsdiHd2H9C9HMg3UTBxzHwHyWStHBY+w2WFtU2SwEI9c/AhleBNm3TvX+DhtlNmE+sSWMsPvSigW+x7iJLwWDPLn8MWpBaLDJ
X-Exchange-RoutingPolicyChecked:
	P6BMpQOMBrevrtIkyKaqMvtO7kA/a7N21kQ5NAR6Tf7uO+R8QSi8OIitogJc2sDWN//Wx66lkDFpyHMCQZLjrdCs46xnQaTb2GVPfZaGAdLNo1jLD9LgDbwiIbXNOnr50dUCuHP+2kTqhOemUfpcVR+FJlj5XaRhU7Y3XEP6xibE/8kW84Al//To2pjWFaT/dghKT5lZipqXkLiyx0dhFQyC92CQ0Fuw2XKkmkzqiACqCBtcWckzV23AykXqilpXXN5jaf2IQlxVOLJoc/DvN3S8Gmbdxe6MVhlZIS/U4A9XhvwXmcG35Q/by4oW6NhOjSooqvB/VwoRqMOEHpS/Uw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:05.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed31c573-d272-45b1-1d3a-08dee4347ef9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997810
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX4JAeFOD9U3e8
 QgTnu0M7wEu1jaJn9YFQUd6MHK3CEtov0Q9u7YQe/m3YfN7tkzzxNMeX6RBgg3iFD5iapwtkyee
 5Kw91wbjAzvLc6DQA9DJXvZ6V3L5zIQ=
X-Proofpoint-GUID: lqm-ifoRnSEg4DaUKU3egV1XHboTIQQo
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a79da cx=c_pps
 a=F8U3mngwmb3oM6JELIq/Eg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: lqm-ifoRnSEg4DaUKU3egV1XHboTIQQo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXypJndXg5PBkd
 MBQwLPyqXA4EbMKV3dgV8gR/DAhABHLawodcI/SxhIfMEcPbF7mCo3vqcYpIn6IFCGxzbmksH65
 3nZoCUwko3S8tq26kEAg300JnZVG5vQULd5A5VePsWYG6uv3gR/2zvqgE3RAu4ZNhJedYVmAxVe
 DkW7DY7JzJDZBwSmBCXF9P7DEtKcgh4I6RWlyjXNRa6pS5I5A7c1EMLm3mR9qaWbRWnZP22vpq4
 ZNkbGMT2LvZkvkNrLj3NAot2z/RVgtC9cc9uyw5k4gLQ14tbUk/q8Bc9qlDqagVLm2gfyg/8vT4
 XupVnBku3kyuOgT1hoeZRt10BoiyuzaYYyvyKrpaWvOV3MdMMsunvHftam+f/mB+X3n/QhAXE+0
 dKltlXK7iNWsqezVi25vtmB3/EDvdMSNuhVIYcbFSQZfel+Id9EtwtIyZO+Z1VNA3HnGvR7Y/cS
 TCuZJGXKCnK719hx7UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..7e7393d25810 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2602,6 +2602,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..aa7b1b34a594 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -193,6 +195,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

