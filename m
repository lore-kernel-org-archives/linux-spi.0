Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496772D8DA8;
	Tue, 25 Aug 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678410; cv=fail; b=sT8ptK4i7KCh+A+F5G42dw/0EJsX2Qg0EgwZtqV5XwNlJiAyEB7DMntrnuFJMmrAWiO38IsD+1SouGfg0glwZ6nVaMZJF/hlBH4iA78BJjWUBRvukCkK+we+1ODjVE+XgGYDfqva3ggOxmIudG9qHL3IhkUiF8dUFWXegXSwVIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678410; c=relaxed/simple;
	bh=NoM6T/+m/Y8FhxNH09GR379GBnAoDkPBo1RjNaYkypk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho3VW4lkUaUgbuIwl9HaBnlN3Bpz7dkajE8SHX1VoI9keUtUwqbCIMTup7ROTn4AqQtYbHORVdfSvYJo+6yWPBhON/B/6fX/fJU9d+aaIIo7XlEAgR79N7uBJ/IvmrhRygm+WFR8d2Np7g5C9/uyzlH2vK7tJ+tikoR1T0hKWXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VFgh/hwS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tpHAYRWy; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VFgh/hwS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tpHAYRWy"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEUwp61882698;
	Tue, 25 Aug 2026 12:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5
	FQ=; b=VFgh/hwSr5FQ1wyBvGSm/00HXVVWIGsWmpO8nrCeahozxqp0pgmY2tikH
	AW2f9Rezljo4JuWT7M8wY5r1HhxSb88uJmv/SsE2PhRU4VriZQ5IxUaKLeDlO4dh
	xLCDWR7JwlQpu0RPwW66YA++rK0fNORRcQZD0B7Ql2rAAWsebczOExrabijH2scv
	aCPs9pPr/uiSYXR6BqFnLgFkZzHiXilg0n4qxqxUxX+8nz4LR9pxEUiwHDlPRW6a
	7m/XPHv5wtkgzFwoItcz7Z2xSxrWttbz4BMZ5FBHfem9bpnPttOvqJT4LjSXvjEU
	vL9muKjDhYxZjOlgZKAYFaK5q0hwA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g8xga5gen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTpuSzqnxx+CX1i6U5tqv/+gqGh+hisMA2UdcIYPTfN4orm0bSO/zPlyFE727z4vVohlcVOledRyeQsyQ5Rzof+9ejpN41T/Lw5Z/fVqyAjBpEVV4boaeW0OWmR5ZBxuRHExVGvVKk52iAsQzcQ3s/O3TJxNOjLbqMb21GrGkPSZjdp6JKEl6tAH0l6yvOeRUHonLKsM8xAUaFabAC4lxkz5qRY8gTFKD2RcpWphCoL8hiUL0ZrjrVbObf/De2oo+MBJCWQvV+RLALcV6ea8Am+RQ2ywR2oj2qaQUc0WfVGRUI0jldz+5hgCZUElGPWRzHQJEJum6UFbXd6+P36Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5FQ=;
 b=Sjnzlytrfz+xAITeehdGDykvYair0tzjnfxXEVuTb2qpiHkLPGf0cvJqx2PNJzNfbzl6T7CgwZe519JuAXDtOFEzqVUC6SE1XiXOo6WsCqSpaGV9pTZa7gG4bRsiDZJqpbDy8kAj/a+XgKjwfC7+URLivoHZu6IXrGNXZgxfr2461RBuLP0rV53yOWuzjy0a8ETFK2z/OZneLSnrBqfdLC0Q5mS4ofdltQjhoyB/QW/fvgLWKqTh9ULxPhKl3Hq9EQCKNtpQmI4NpF8pf/kKl+Wi9gi3BzR2tY8PXEvyhKXSbWTukrae4ITB5Ozi6YDqjvfTRxFBANlNTeDM0HRQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5FQ=;
 b=tpHAYRWyLijNTRXsNOWgXZaVBlKj3EJm928pG3+gJwC0e3nOvXOzCacsRqf2RbkjcRKOWbA5LUn9hkjCJQd4Xhgm4rZUOvvJhTt8C6uKOzdMfz27WnIDGZg9+h/kWPOtCuIRYp8gs/gfEXLhW6Cf/1UWusivuKx6SOI6p4vSXoU=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:19:51 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::67) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:49 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:16 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:19:16 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3f1436664;
	Tue, 25 Aug 2026 12:19:11 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Tue, 25 Aug 2026 22:47:35 +0530
Message-ID: <20260825171737.776052-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad0c9d3-600d-4571-a5e9-08df02cd119e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|23010399003|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	j/k04B3s7lPeH6JsKCyorJZSu1rKxAXa6d3mpz0HysvyNkL8Fg25zMK27jmG08/EyPqkLPg9Y4zHMDtiuy6KJ33Q26Upb6L+p+/kyj5U7jQbsVRu4WoPi38bSt+awhTXkDXix+BVe9zhPYsLLzeCZKBu3zmcfdo3izURv19YJxZ4Eo/bKQx4jVuJkTkCcNbuqzfgW3sMYkiQR2DLBG1lJoDfOLhmmkd67tweLh70AAPO9it4hBDkn51h8P0ws0YIcKuibbIwIRGzo8R5EyxtxjGVXI31I7Q5lZOuvbPlPhLJMT9Wa4qx2VN/1uFAG6t/gD97Xe0stI0uPQ+i2v5kBMRSM9aZPcTggH2c0Ork/bGtuh2iyATNkp4fnZ5Kv4KcSsGlW+fO9X3zcokWcXhNXM9s7AsceDpWF3kvQnrJfCj+DR9UHpeLdS1PomKSa+fBiHc/hWStma/jtFBZxblUSzb5t2vHh50m9CmWRjMmDK9DpGo7pkMFRiCkgUSEmtoCpNatgpKA8afnIa1anecT1ACQXZshdDkqvgrKlKk5ldISg1mz/UA1W95r6SDtMjTo96bCCEEd8DuhCeeLyU7Kz9cDTFbmYFlWvhPb27SPVTtgY8HPaKQJjNP/DJ/x9lVFfREyIDKH92WKCmN9Vwltg+Vv/rwV590gEywQfaIwhfdMECsDEMOhl2R0BfqzthnyKeXfeOyhq9LewBh1iWAEd8XzUU67y99t2C6iTEVItSLLeY8jdSDCjOpwPKYvRoWn
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UrruMvKVdKSH//jjrB4mGci9Sz6InuBXhhgKubG7urYoiEFd0bVw0a+pf8+YkM3Tz49QC/EeAljwx1PrB28j0YokEkXLEV2j0hAzuxkM62FgRPhcHbkoh+oJm3f8om22uHjfkdzWGdbMTGOYrbyxBXUcQZwhojpyDFonVliCsqwUSNPg8hyJk+eDTmr+GrHI8bEYvzX6EYCcJjls0OEfQRTB1p3NTmEmDC1X7mj9GI5dz2L32UPa4+aYnRyyDbDw1J4RECdGs66elwboRQh+9ac2waVpq+5xz6VmE8QPWCdlnZOuG4znfBSVUb58fC/w5jtc6+PVjoaVcuVn+IkNr1BfwX+B0Vg/P1KzNzr6W6jRgGj7JPVh/b3Y7isXPoSvlZYJfIWA12vzBjdZ8LfAYWHmbrZV6v6EuwFc0AEHCQVom/giaF4qzU9DdF/3nr81
X-Exchange-RoutingPolicyChecked:
	XFpV5kIc5hCO1J3qZqK30xsZ3lD07BlN4fkGO+q4HTODx2TYfy+XkGax8a5z3bhx4Nxf8FqSWxiytzAUUPYdHgvhh9KkCkoQZxW2FQv+Rle5OIROs3zKXv+D3wXZPnFmIOuAR3MaCO7i3EpAl1h0b2qrXAVB/ExWRUY7f/47NMbzc/Qecp+0LJiQWsp80Ilx5SHa8vQKrbVs7YpcnRiZ9+AZatCJyRa3xtx8uUKsCk+GodthwwIDOAq7afQ0SNK30ijRx6exwgPee/lspRVsAsbp7tRf9p1Niw6EZ+bzDmVnASH73XGgkbUuNyXO2DFOHGb1/DEQ7WTVwIkFMza+kg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:49.6103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad0c9d3-600d-4571-a5e9-08df02cd119e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Authority-Analysis: v=2.4 cv=SuygLvO0 c=1 sm=1 tr=0 ts=6a8dcebe cx=c_pps
 a=7APEvFnVlBjFtWv3F9ubqA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=-qpymeGUnIbieU4wEgcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX5T7DdCP5aMuP
 NUE59IuEi5lUXApvwIVYpq/ArNF0LExUS09pfng5BtkInHgykBoCuagkqhJZu56HSgt4b/Yv8rP
 0XQYp8F0u6V/X/yJgipkNg6Ka+Ahyz0=
X-Proofpoint-ORIG-GUID: 2mRTiYPcfwP5ifU3uhcavLEZ9fLCrw3R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX9AsOuHicRWew
 i9rd5neM1v9trpeKHSomvrpcx+IqFzVo1qpILnlh+9T14kmTI0400Q8lEycVj32+ViIxwhFLl5n
 vTtNfyq0rYV3a8ZSl+o8rtqDu27bPHoqvuaePzkFtwmL+gkz14kQnuVegwI8HB6ID3djhKcJtOp
 LdvxKJyf0SImCST38ijIsNN57sd5bZpDdaT+uwja9Cvm7MTqKAOJYFIT4VKTEnskbbA/ShDeEyJ
 D+lFzZsa/50fLWSMbgEdiXxCEpp0R5mB5PzUIqs2JzIeT82N7jmlQ4KviuUdHCmixAnHX0LaJJo
 oI303T2+TO557Q8lmQMQjd4nozpZwgnjs092Xpj/5mm8dptpe/yZ8oV0KMlAsceb5UQUZeqsNcD
 V2AOgs8FfaeRJEUbm22EndsK2Wd2xHtyHGLwNw0r2LeJ1Z8Y9QFkcHYbGueQJ5Yb6R3deLIarqS
 OYGxybTfko3jkL0sCUQ==
X-Proofpoint-GUID: 2mRTiYPcfwP5ifU3uhcavLEZ9fLCrw3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 311 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  14 ++
 2 files changed, 308 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7c3341f1fca0..6e58e0893736 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1284,6 +1284,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1295,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
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
@@ -1542,22 +1545,51 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/*
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
 /*
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
@@ -1574,6 +1606,10 @@ spinand_op_find_best_variant(struct spinand_device *spinand,
 		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		if (match_shape &&
+		    !spinand_op_shape_matches(&variants->ops[i], match_shape))
+			continue;
+
 		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
@@ -1608,7 +1644,37 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
-	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+	return spinand_op_find_best_variant(spinand, variants, iface, 0, NULL);
+}
+
+/*
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
@@ -1745,6 +1811,20 @@ int spinand_match_and_init(struct spinand_device *spinand,
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
 
@@ -1923,7 +2003,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2015,14 +2094,6 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -2051,6 +2122,198 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
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
+				spinand->cont_read_possible =
+					!!templates->cont_read_cache;
+			}
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
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
+/*
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
@@ -2073,6 +2336,20 @@ static int spinand_probe(struct spi_mem *mem)
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
index 5f4c00ae72a7..31e3a0dfe8a4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -792,8 +792,22 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_optimize_controller() for ranked
+	 * fallback when the pre-selected variant cannot be controller-optimized.
+	 */
+	const struct spinand_op_variants *all_read_variants;
+
+	/* Continuous-read counterpart of all_read_variants, if any. */
+	const struct spinand_op_variants *all_cont_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	/* Persistent op templates updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

