Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834E459AFD;
	Thu, 23 Jul 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804597; cv=fail; b=Wtnm7zopG0aatHuJqrXjXglbB+fKshgqfO9ywmcgQw8hY9A38s9al0D0NZoL8+ViSNa5oiv2a2gZicZKp/ZTyyuBEqpXEsOUbd9tHEKgTa5Ig/65wZRp1Fta4m50/KWbUni/PoNS7yGhLTHf3fCl1k3B2STWekIkOPpCT7GT+88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804597; c=relaxed/simple;
	bh=s0jYk/5KEpyTn+gQ2ZgsqurVBgOxWDscHJlq6GjcfSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPCraff8SiFAwH3nHejZI54YBeAo0qHuM1IVUeoKdXLnhBwqPNpIWj4Jgvmmu5kC6jxGg9SszPgA68Rcz1c0JH84xfuePDJtXF7iq3OBuZvVsaAvfv3Hw7l+SnhAx55+t8P30D9nIBdVhmB576L9ak2Jzmu7/HfnO16XE4xyM2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FK/HOpQi; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oNpdzia4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FK/HOpQi";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oNpdzia4"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MK4o4111149;
	Thu, 23 Jul 2026 06:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dF/dA9rfFrlBBCask2DwOPti+dzd1RR7KKfCA52tD
	cI=; b=FK/HOpQiaFeLjlcftquTYPHDUAvPFnq7/FEQL/NO4AUs0uKLKSSjgagqb
	nO2EeN/yZdl9O0wZXkOPZ1myLYJ74oFoJ9X4DI219RTc/gffJN4CqE5C8mOPoVyy
	I2bdGlmUKf+gy80tLbSFgh6YnXC6NgMVp1EIRBHSBnuxGY3W2OLqiSF+sLm+yt7o
	hpqA63SdCHVVxARHpfTTrd+6j2YmtIfT4XCvTsLUUKEOh2NewN16JhtlCt9VkZFz
	82JnddD6yfkYxnvicoEsqgQnZtmbAm5105aY7nMKYNotywxUSAxkZ67T8/nO2RBe
	KbdeC+N31n0w+/ybr6nzotRgVXODg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908ctn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:02:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgAkY7vFQgv2JPY3/U3GBFL/45QshyunT3ciisbEXxyOYlYloHRyQazd5A7yIXtLWJerb65gcSTY371jw3znQEBpy7wCXx5owi3FXIkR1MgNjLdTWSpnCElspRreELpmQPSYohfcMIuuEQBa6OC66B5Ce1C7BDLFggJidgQ8wifoFtrEq39ZunMtB/h8owb/zs7MlR9mjUMHZjXe9g/EJhN/+vcwkcxp2KLJwunepVXW8hcL4PLkrhagqmWQLNxvrH2hhlKz+dYIk/Q5rvOA7LXyU+Afyc31LXN11Txi5I7SkYosY4axkK90t0Mejxn/1Fg8FnRvb5sr/GITEifObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF/dA9rfFrlBBCask2DwOPti+dzd1RR7KKfCA52tDcI=;
 b=k2Po5c6IHs/Y9lwAYyGjeCJ9kWjQPeiBcyy1L6H5XQy1LlpjcxN5ftecZKAma/jXirs1PJMogMGSlgFcANqwaw6w8CGYqB1nxibP8fnmKGwFYxwIQUeOcYha9OrJil37gbgfYd5rpVCZA1pqFV28wKEuQZEtju3tji+o5wcJYQQEODQww2CDDZe9lculDO+4qXvbCGT50QSsASpuNstPVtxIUHNIQte/4sMWXAJqPnG7CSqq4asd08KbnA4ENRbrIRH/D3eLu4hz6oxJc9yRZAJrr6VrjcevRgxtDToXLPI7RUa2lB4fxQMZpoNZtK8LWpTKkg8MYDYWWvE8vr2wpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF/dA9rfFrlBBCask2DwOPti+dzd1RR7KKfCA52tDcI=;
 b=oNpdzia4XcFbPdbYQogAsnLW9xuPJtaHWJSZDWd5CjNpJiLhsRzOvrjs/LE4hlpBdYMw1sRvlO3KclOGwRl5RfkqkIKzW+Rv1X7xb9sxtoLgfQ90Su0DOar6G2u7Quxge5SqNCfH/rLcL3EJToxQz+csb+v1f3y+5J3TvmJc7rM=
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 11:02:54 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::86) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:02:53 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:52 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:52 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW01577597;
	Thu, 23 Jul 2026 06:02:47 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 04/17] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Thu, 23 Jul 2026 16:32:06 +0530
Message-ID: <20260723110219.3180747-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fb2fb8-5b96-4a12-e775-08dee8a9f1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|36860700016|376014|921020|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1d+oTefWt/KsrOWW214e7Zb9qIfOYl0yCq5n4iJXv112CjDMTjkuYClk4NOvApm7mZomPU57eDleiO6FwQZVM5+q0e1FWqDQrKK3Xhq683dtg3A5GKLDEgf6VUdc/aD5+EOwVh8H9fGI09VshAbYNpPKdA8WF750irl4dnR5Z67eLiAOlO1JH808JeoUJQk76AXYD9crPI3OllOCHboZpx2BmW0oXeThfzxZOht5KUSRgv0WABXotDFX5keLsoeMuaKX2uI/yAaFlInFyh+O8G5Q6xHWUMSZeXT1PAIoolWJneJYXyh01TZ5Q0HOMlsfg1mZQPkerIBVZG++FwIMJ4iRIEojcAC4Bj4mNXAa1hoxSmlLMgVmEqq4kg91Nxi42huMRl/XzoL0ix3v46aQiEH6f/U3xLz2KF6r4dLCQWAGcXpnh8V7J+4w17Hkhe5ca2XPkhhIEpVNy6EhGnR1u689Ur7/Dt9R6bBkKXqS/R0qKuL9Buusb3RteeL+DxMbb8EQdYuTah0iWLjYlFW7+DAKBR+PjA10L+EerAwT3CYmAq+7aAAVl9Y+/cj98Tej7lBw8fepZP0oCElfAhi9ey/SensE+h7vfEaYxD1qo9VHmM1okqvXsgS50fn7nxiMhBZk50vZ+wpqQkIc5+C3XjZetNQ7EScKT72emOmEfhyux/iApf0k8E0DslBD+DDZmpP0h47ZCTo+FHZJ9DoTmJh89hl9ohEg281daebH335vOSwxoOuX5PTCv2nQPMmg
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(36860700016)(376014)(921020)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hqaG+kP2WwV8XoeaSbRkGtOdHWYuinmPDPb2TAr10UoUqwzFGcUAJe7Gritl6wrVzhBgl+que4eAUdniTsRqLVplg9foSTM5KSwypEB9InVBkauuuroUCNPihlE121pfalOHEHWgHDwVD76xOzeV5NYWgKrc/Vwc1o6uRzbp+tqBU25tE/lWr41THbUXBN/t/H3Q1rya5Y/tF1jA9brGpMmVPBSxTAe7lHmEPNHhMAnpwSsMTV0lReWVgtqq8oRbC6XYNo6H+GrJ8ZIGo12L9n6yRo8+mYv0VWttETfro+x0jY7JmZMdBy53dE/CLgbosjtKygMDeZ2QdAonypedTNFUOToHDbr3ck1ALipy9WRN1lJX9A7ccNyVrCc8w/qO4UgOy2Pd3JbHucs87w1y0lElxIIlwyHwHMIFahet0PRGbLBNNdloyELb6FOuIRsW
X-Exchange-RoutingPolicyChecked:
	bANIOwB9z9pQa/RhIaX7B+EWAnTyH1PcDMO2ipRo9OvSQBkcKIa3Spo9TcCts9AvFZ23dl/48b2XH/Q6n233/zBHfjDBzsmGSd8ITLflZN9XOPG8UXBlGgf9lAHZQruez5R8wAroOVYGvUV42n9pAIlRdc3z4nouMRWaogUtKb0AYlxl0rWOadsj7kw4Lpuua0ggZ4tync3TIulorm6UMWIYXM6031EhK7hnnDjbM0iHhFMkQqtetpqMyo98THIU7nxnRRLaNjNyUbHbg2ZcVz3G161r8U4k9tVt1DYQb2+7tQXjFX4XuNnXNSS1+yw+qj6RiHKgdThLV4ZhNl7smg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:02:53.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fb2fb8-5b96-4a12-e775-08dee8a9f1df
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXysojJ92YWl3h
 LjwpSlqACpYoT/B0x0BinKZsi7ZJdG5Uq/MhhtV6lb1Tyn8LETR6qQq36OJbqMkL/F/bu+9ISfc
 XMj+86VtnWkwp1jpxi/fpdklAyKUpTNLoTZIbDa5dviJCe1w9ZqUiHK20HhkvvV2wE8/W96Hw/p
 QU22UcSDRr6bs7sY6b3Mz+Y1ljApw/8wtP9jMN8hiVK02zGW+jn+WpRaNRE+SXHruQHu1WNBwND
 Gb3z4qwP1Dst0q1VJvfGA3MSKWLsZXGPzteq7l0qLbWoEmLzfvkHtOkPSgIge2GbcGuaM6xhM0d
 d1gxc1oeL6kx3CH3nod8zGVDFFTGrkjkZUfaHiYv/yMn6KBuXZSpy+n5H690TU+ztp+SsATVXi2
 rNjH6rjiLKEXsSjPW4pg2J0i0nRF97vADpCX7s2/qvSy786vv964hHkf5xorCJQc8OyKP+OJ0kc
 +HkcKx117pCAlLwFK3w==
X-Proofpoint-ORIG-GUID: 2YagQIoYkOYrPT03CqXNvZ52zM4kkxtx
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f4e2 cx=c_pps
 a=kAM6CeFpMxeFc5AoNv8A9w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=1EK_O1AJX7ox_F5CMUYA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX3ccfclLaTFUs
 dWesldEIap2LG144gyL1zXlHkQ7nRpL4RyRWfKMUf8pYrS3MmO7xH4q60y5p5wxLVBlzB5QPGAa
 s6K5wobc9lJ57Q7+qtJkk+6fUeWMnBI=
X-Proofpoint-GUID: 2YagQIoYkOYrPT03CqXNvZ52zM4kkxtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Extend spi_mem_adjust_op_freq() with a bypass: if op->max_freq equals
post_config_max_speed_hz (the value written by execute_tuning on
success), return immediately leaving op->max_freq unchanged. All other
ops are capped to max_speed_hz, the always-reachable base rate. This
integrates the policy into the single existing frequency-adjustment
point so exec_op(), supports_op(), and calc_op_duration() all behave
consistently.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a88b9f038356..e20eca1b8245 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -591,9 +591,18 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
  * Some chips have per-op frequency limitations and must adapt the maximum
  * speed. This function allows SPI mem drivers to set @op->max_freq to the
  * maximum supported value.
+ *
+ * When @mem->spi->post_config_max_speed_hz is set, ops with @op->max_freq
+ * equal to that value are treated as post-configuration ops (e.g. PHY-tuned)
+ * and are allowed to run at the full post-config rate. All other ops are
+ * capped to @mem->spi->max_speed_hz, the always-reachable base rate.
  */
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 {
+	if (mem->spi->post_config_max_speed_hz &&
+	    op->max_freq == mem->spi->post_config_max_speed_hz)
+		return;
+
 	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
 		op->max_freq = mem->spi->max_speed_hz;
 }
-- 
2.34.1

