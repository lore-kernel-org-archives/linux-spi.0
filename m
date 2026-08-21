Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D644C64E;
	Fri, 21 Aug 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312984; cv=fail; b=LcgfFyzLkqxqbfRIMZOxoCFRpo4rOjUwHCuurnG5A0xG40R6suDXT06IgxfxhLcD/DU+neYKL7O+t9dASAML0r39/snavZDCptIcIVLuiCfRQ+TLoCVnHZOIfLVch15XCiRabXjacXIAekE8pRRXn033SpeoEFLpW3yGAcaTHx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312984; c=relaxed/simple;
	bh=NpoT/cBBl4rAzM2NVlulrn3aPKLC+iksPz2nkPNIsok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY4CwI9kjD0uBBfF2Y7QMWRD5eUDiMgNFyWyFEt4wBXMDxfxXlQXGEp1eCGauGNM1unjoDT2esBaYp0+aIxPULM8ugyd54qG7op5s1ThPmpzxdubphSyHKzdFS6YFzNww7WyNMPvzAq+iNfQbHe9zlU7WxcTiOl3kEnl8vqBolg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=AuMF4Ijt; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kOiQC+Mm; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="AuMF4Ijt";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kOiQC+Mm"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KNI03254941;
	Fri, 21 Aug 2026 06:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTY
	Hk=; b=AuMF4Ijt8dXz2EjyqoMTeCUaetHpGNMgZ1AGps2Y/hByumUtm2XY2VgIK
	Q6Rrcd7hLylFQNIbnw3WkKcAeGId6Wpm7RT81Ad2Rp3vZ6DnUPOro9mEN02g9lVM
	pKpXvEi7tqQwhSUL3pvmuI7N1ZCwT+pWcTK+2ICv/ZvkbU5I5ioQc8S/bCDHmhGQ
	7gO8Ov/LBb1L3eTRWuOHenPgFWi72f5fKSMk1vXcFxQ7tNcSvLF9zhTQ484fuRvL
	lLDjPTIRvo/AQSlkPMjeh08Q+UQpzQ7auMJLltJjIENJrMoZ0R1AnySG7ddXWl44
	P6U67G8mD4JQFnvaIDXrxjp3ixbEw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1de9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwJDA1f1mZ27Iro3/GPzbKDkvB+ZpTZpE6WZ6bYdFaML8aSWxmtg+Hke+LfiAUqPhlbd7XGxN+X4sZJupNS+evH+kkxDRBa4I7ompx3HbQFZf7OM/689dDE/Cn6j93H4PfLTd41oyzTFD2bOwN3NjHsOVbYlesbEdvfdE7DtwuwLNkKCAcQ4uBx1rNp2X6aJ70whcrAvcIpayceVpe3mCvxUoMy8Mfl4II2BWLxWdnZRCwOTdalMJCoyfPN+i6eVEIUdN2iJvt60atGpa5R+tJEYeZwNke8Vg8j2H203DMCeucQn9QIUYrY1lJjgvfeZmJBsACuY9JmmGqgkWmWwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=oXbF+570L8OVMUu5zT5Kts+ILkWXEcbmstfsXLcZD3zupEnM1Ki1ziOIMKWvTD6qlqfonL5yEGaBUHwG+4lf6Ut41XkdRoeXdB91dum1TrdTE3pQjnIwvsadYA1LbFfyACcBphKYXPMApCnNDXLGaSd/CkSbUVT8wLlED2hDWAsRKjN57gWY16Kk3yYsO9Q/atyt/abh8gv0vfVSblabFFSEhlrgv9eH2rDWmu1pejoEVEKPYvDKoq/0sGa4heNYXK5m7ZeABcXZH/krQDFvANL1v4vVo9ExhzcNNSHcpNd7U7qshwlpO+iAS1ojliOfoNKQRmi2po1gguPU8sKtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=kOiQC+Mmxfra0O2LCjzltCntY2HA4g9Fc7I2g3cMlItZKUKhHPrDq6DgimgZHMMW0+tpixThMWE7vf4mi1Uv00sGSQJT8GfxGp8j7gvNrIM0dcJeNzs+jDewsUvz9zpXvpxCh0hrSbFk3irHDCS8QOXysREEW438A2tWzo/sDA4=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 11:49:19 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::7b) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 11:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:17 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:42 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:48:42 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlc2022942;
	Fri, 21 Aug 2026 06:48:37 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 01/18] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Fri, 21 Aug 2026 17:18:05 +0530
Message-ID: <20260821114822.4040338-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 683c801c-0bc1-4125-89ca-08deff7a3b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|7416014|82310400026|376014|56012099006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	68QfZyQQkVBI7/XLY2b/6xjmLDOyAjtiYKoOMZLZHMe7BRfSJfh98Bk/l3heLaIaheThGXYDDefuIliHzCd6++TU7rKgLAm3O+q9Bfm7bf2GHuowOiZWfP1eQ8gmN4AdYNZ7Bq0zr0TquEM/ZEs/MT1h/PmVc9YNSU0OZ9UQofz1f6TpIy/fnl6EZaE+D4Ew2guyHcOdlGrjc9GmtNctC7FwXKdgHZx+XL9hmaZoo+7NTXUMPSCo1Tm7v0g7ep68Im1+FY+rq61P0NJHdiMHPrBlqLULbWl+F+T4GjxWDFenoH2ZoF4lD/cBT9jMm7xAi5SZWIGdAP89NbhJwIMh3RLmlb7eA4avvmS5kKJOGl1+fLIQ5ggA+edIMPt30BlEZe331zAUZQhlpjQghk+wooM1MODE3X3g9/UtZYLGJANwhfvFkx6nApKlm1SZNaHSWxmU8IgWEtCrWZMQzx9nQ++pQbtVhkCFmANjcdS+oUvkUFnig+Q45OLfIJE/7vEY1kBVDfqe6ld5UWeQoCnWUN/JC1eiDKx32y7uZyDqkGnoj9ZsL/6Y22c83i7BOgQqWMsBggnyVn5bvIR+ILpSMldNSasC2w1boZN3afKW4HIAPrY0jSBNgV+pMIxv9IB+fEI69TBx557j1dzeSQzT4efbZmU+EsKXTxqxUuxRGu2AASZmYmJg0++cIR9fpq/bTnyJpzlBBRz6U6VdHDrue9lSsMavtTW0vEUBhjl2L8gv9KrtfN7xmbi3/j+XkbtP
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(7416014)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j8T9Mlcuhcv++FOfrYHkWpuV3rmlTN68JZOdf+d5KWkklj1y4xkfX/vLd/93h9O2RIQqzBvZWjjTN7azp1LqeASxq8ikX/Jb07CjwguJYcXpVYboyb733GQwtMoV3zOqb66HB3Xt1F9MvDhEwq4Hh4v93bWRvF6KV/J6uB3k776y+2QYSu0DtiMd+a4hxEKLv+reynaKpXd4YTt9AfRtMSd8YyrCltrGK7SpQztitZZGbJeJxv4hUdMrd+J/JNRQ1jP/p260/H/1RsdEK3s7uvoOoKo6drqgEW/IIecL7ROdtXU2Fyh6td0TRfhOhadPnq/mNxt4jnwzbXgqo1dNnp6wvY7T8Sa2eTzWfJnFE1rRiZmjs7PBOD+j2yyIw5Nda9LojTg54hXIk/ZpKKOGLHX5VX8eizAbAIzVIG9ryPqKwLzM3zAcWYhHk+ScIt8T
X-Exchange-RoutingPolicyChecked:
	pg8lpJPUQymh0cH/7l9gz8XyKA5lPiF7oZWKl6wEw9KUPiDnw3L7Q+3YJGRiLKE74YX8sI0YmsH0Ivc3jYggP8Zc5zI5ZxXRcwtn3Z0PeG4DEAUv5q5lVWDrLjGzgjqRvN3dUbPljN79Z6LVap4isR1Nt0ircydyzAMrkECa7ftwYPtPqgpamozqWFZlqgchUVEgdXoSKSxlJnYa7koIEyO/HQCr006OBRybtR8KOiLKifjFaNflSVlIeyU3kCZ6/zHl/EAACAiS9939pIl9fi2J+jE+CXBP+tR3xFZg4jAFu5v8See9QxlexspilZxABOMA0HQI5oyjBWth0vE3qg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:17.4499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683c801c-0bc1-4125-89ca-08deff7a3b16
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b45 cx=c_pps
 a=3/9ZW+mBBPtU5+OO10+n1Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: nBIZVHcBYHRwE9J6Tn4MgTiHaCBQDFhi
X-Proofpoint-GUID: nBIZVHcBYHRwE9J6Tn4MgTiHaCBQDFhi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX+Hti4bWH0MEM
 /fUohhm3garA2R8EI0tvSn2uAWmg6vlEtJ160C4fQox3tsjTTaZO31Qc1UbQZ/9upq+jxdOrxKm
 9SIL2bPc4fs6xWSFn6CGwausExwpVfg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXxrESoefxnRHX
 +i/Z15SIakve7fmdtGYwpd1hrfMWrKLITGUOMeWONJYoWDo3n+yOZXw/ht7aklGmc42W5avn6VS
 7LwqG75tf+j8MMAm/PiS7IN1d5EW3CMfYSrOZ9wxcqpFlOU2a9eTWxMyFB/gMQGJewNZqM/hPpR
 IK/X5cvh/pv14aknHSSVF+sXCXnf3YpvCDRa66zmXVKDrpLAGCCED7bvCwu4BXUP1tFMpE140YE
 OC75PQ0aTZsHlv1sSHhkprY2w2MSmf/K8gB+wqle1WAU5Ni7SyC0oSgUq53o+TfmapNPxm216zP
 aDHXkD1oG1B9m9Sc4wbSjAFllV5nA7oItokQPbdgaifDueQ04F58yi02MOietIqhRcbuphiyYsR
 T1LNCfZBVHtNuzMw9gn+aNlVYY1lcgZbYOait3o8Hk8fqDbJ09X/l0XuZHYWQzDcJLjywwYvHSp
 LxRij16x++/h59n454Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Add spi-max-post-config-frequency-hz, a generic property for SPI
peripherals that operate at two distinct clock rates: a conservative
rate always reachable without controller configuration, and a higher
rate achievable only after controller-side configuration.

When both properties are present, spi-max-frequency gives the
conservative pre-configuration rate and spi-max-post-config-frequency-hz
gives the higher post-configuration target.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..84976fd3ee1b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,12 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency-hz:
+    maxItems: 1
+    description:
+      Maximum SPI clock frequency in Hz achievable after controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

