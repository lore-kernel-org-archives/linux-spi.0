Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E641471253;
	Tue, 29 Sep 2026 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663869; cv=fail; b=uIhr3O7nHr0GbNm6vTw0TTl/Z5+8VhnecmMV+UfUWjrKqwqnTKI9tGST+rdOZXs28taX6G5B9a1NN6XcDjlPdubcY19pbhs2F5/JOjrpPGpuf9Rxxj67t/yZ6PsDWmQbiivsiyX1SFBDRuwjKN1FJNoHmHUfXco32IogJyQvvsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663869; c=relaxed/simple;
	bh=aJKu7ZSwDw85e5Aryac3caouhTtmg4hQhsMwgupjKVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYi2ZPEJYgXn5hsfEL85Egv+34EYqu+NcNQ4HNqm+aFxJHJhnTpoveWtqxIsRDGA5IJJnyd45Psz9dqgJR/pI4Tgswsr6DlFNkohGqV73uCMl5+OIMB1s7NCzRGh7PxCJOjlSVASqqzO+aATAVqH3y9wGY7m6/hyLwkCXHs3sfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FpXlMuD1; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=REMAn4O2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FpXlMuD1";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="REMAn4O2"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46ONe3786973;
	Tue, 29 Sep 2026 01:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lYosdayu3K2R5eKvMG6fQysgEo9UH0wuVb1/hgaFv
	uo=; b=FpXlMuD1bi3o1kKiJAE50ivjmpbv/Mftje/Yc1OPnZTOVmIv1/1aHb5K+
	Dki4q4BFtaApm1j3nQcXLemMMAo/qQQs0bUxclYPaRWrA5qnMTZfkNjMj/WS2oX9
	Y/2fhpZYYYSYzXeX0VL2XWvgc0f2+ApHKEP7G+wMNbGcfeZmArBKE47+ExYMo02i
	oS6cQN7VSMBGIPkapbahbkZ9SxQur7v2jUcPF5rNbbSI23GlxvgLIJQmQHeFtJOB
	zazPg3jZiYfk6p02oWXL42BI4t1bxVm+APK+TfmhvYFN0kyAuzm5BY0SCHl7rIly
	C23zSuedbkOKAdxc++7e2iKQbKbcg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h02grj09k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPMi0DXawIMtBGErUIxSrq7q2qC6/KH0qj+RBOpg5Co9/sVoXinFUn4kYFj6wVGj80FjHyOcXUG1JA5YWBPi5zDdd+ltNzpdUMQ56Xqamrn6bw3O4fojQxADWzpCCYAfzu1nqfDXFcynPFgMzt7mrK+fcE2lCHLE5212iH6klU0KXA5OfAEXUuMYe/znul5gaWFwCuuTlVFP9YUY3NGKjor04P3DJr+wGNQ/2cTK4rPS90L1LT+WHRKl40rE1yHPkkynUXtR4pxCf2qz3D0Sf96JJ9vxpq2BJ4UKxyeCFI8H+LfGh0Jm9Vo36lWvPCL8p5z+XzEO7RpdSB06AbrDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYosdayu3K2R5eKvMG6fQysgEo9UH0wuVb1/hgaFvuo=;
 b=ufry+OI4UsGCFMCswoWM63PiPXFvUeewP+IIcka/G13WKU/auy9RSWajgvp2OsbHUHvtTJKzmZBvYJWMe1fv6Lu/oTXsf84KFLNQKuWM43sIUl8xlFh2gv+u6Umwg1lNoYkAGc6NcG6GJBvQdMSoq/F6LZoSc+tStZ43xV8i/lFqKq61x+GFPRTKEz7dwBNhAORT64JHaUlk1Pr5uH4d3fNA1Uc/UAY8RIGfQcsNAvrC/s80N/iZmawzROMmn+Bw7do8iJ1/4vsNl6mrM0HQRNwXeKm1XzoicCHZp/9c+NX3HTY7wPTKtIiP76X9tYfjOXjArPS/fN86jAym4V+FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYosdayu3K2R5eKvMG6fQysgEo9UH0wuVb1/hgaFvuo=;
 b=REMAn4O2829qFrIkoMxPe+MkAL55kF64wofmoiQm+kW20AocsDMktwCzQn/k0Bk62wWrRbriz4CdViE/B0ikCy9TfKQhvMIojLboTh/QsyQrlmlTAJzq98IHT+piaPcIIEzH/dO8VVHflif6OxWQmUYkr1WJOmkoOdI0okkqFyM=
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:37:30 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:37:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:29 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:16 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:37:16 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnH1395904;
	Tue, 29 Sep 2026 01:37:11 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 17/19] mtd: spi-nor: extract read op template construction into helper
Date: Tue, 29 Sep 2026 12:05:27 +0530
Message-ID: <20260929063529.1235417-18-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d3960d-a27b-4120-eb8d-08df1df4221f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|10067099003|22082099003|3023799007|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	SDINlEnJjk1pnIpr3EXV5sI/9rWjLBnG1TS4O5/zqg7Y79EOMXTe0T07o6bol9dLK8gQSy+uTOvxUUMSLYLsXUplijAIfL6q5bquZDVKx0lQdnx3EqA4qIl8KyfexuNgZRjEHnJqtMcaVbc6eWxWMiNDHvkaa4MkTY/WhTbx4ipTIq6122p3qnzRK6G6V/k2CykMr4UN4/iRvrEAbDUznwHeEWY20GmFHGz89tZ4MlEAY1EvsS4NexOfw5BPdk5MfTP3jOjVS0DP1zRLyuwO28s6ZKH8h2hGE16lDZQ/Sko7s1xmnH+fDVKXbGGzaSnduj7fI4rkIz+epxuNbUGmxIkgIsoO5OallVgOXShrEn0MpYMyi7PpiTxmN/HFrIuaIavLYTw00pxW20+wH1f13A/WvnFGYUfsb718lZhkksJT5Hppj9WOsjcySNP5EmdSFnqEDwDIB9VzV32R99u1Y3EsMFn9vypUc/2vz2ojB0AQa/s+AhItxlbEDZr188RwLQ1g44TX3Wq7Q4XtfrhZ079WlgsrlJ+HF7ZGUw4QUxrZAwX6/EoNae/75s76Gk17V530yfkexnQdckFEAvXatucpqXfsqzAR6WW0XUTus4O2chEp2Aj5Rbwm6MClCAvvWlBFlqtJ9VxyI8Aoi+KzPf0PF6JOlAFHAQaJNpOxZh2F6JdZY3EkQPxaLDpGflVYRDEMb0CaHeMgNZSNhnZRx4fR1vsM56kAhk7gcs+HUsnkZJ0Y7h9TDHr9JwMq/exf
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(10067099003)(22082099003)(3023799007)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tFXaIjDYmYp/cJRt6jqnuWVcPUfQHbeS7B3tMZajHos1MD+rtfq2qUupiBWl8VAFUryOzjiB8g7+xUrc3+nzo8QO0vPzI/8KhUHObrgQh5utKJHfg21mpvivDE9U/acLVX2RIHBBXoOjlKJBODM/LdopFf0mwHsiIJExWGJ8BeMW9ewFXMnXPxqXVU9quevcOiatxQ/4Y1g8Zb3HSw5sU0GII2RyRCCOXOXKk4qzj9RVW7VTJMw6Pi1reBJJuwSSJgJtbfuqSllwMowqIsVl8tlJ/piJHiQvGWiVmexw9FunjZkikxhxHBsO9r7v/qb2VVENnccfiG9d4WU3NNUTmZWh3Z22MX4JpKjqO0xkWkiDl/CohMSEDb3tFvwqm/CLCceWQkBTqk2vfiU3YyYObozIBQ3nG3iRt1kAhqFxD+n9X7zfrlFJ5GEIcSE9EtuU
X-Exchange-RoutingPolicyChecked:
	eeLvG5oGllrxGVW0GI6ZErcPG8KLDWBqJX7qfZORXyibRppyyrzPCEkO6ZE0bavN91UvN40xR+wANCNs+D/jOqFpmAhPwFVbL1n9MNjBvg7iBEZrIqmjplDWCf2exz699/Jgkh1Z9FspCmPce7V9/b+sQNhueaCZObgNZ4PUbbCFRgA9wweoztl4zDFpIkfPLSaYrInMk3yrJt6W0XVhmUr12tIFdgYLlUpIBfeD6BICHZItUrLzwcdQrQgN5Vji8JPEnPGZcwW4erAK5eRHlffaxTwLwpFm05n2JxBFJZ44YkoNB87T/s0h6eHTqYFeN78CW+iqQSB/6DF5s9nN8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:29.0279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3960d-a27b-4120-eb8d-08df1df4221f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Authority-Analysis: v=2.4 cv=SsEFe/O0 c=1 sm=1 tr=0 ts=6abb5cae cx=c_pps
 a=021mb8W6rIxzgUEI7A/+3A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=4qKnfErNU7RVUF9lCTYA:9
X-Proofpoint-ORIG-GUID: pGfvAIU7vZOsP_bExf81WaXOkHDbMo_e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXz+XECpiSgFu4
 Tb1BTrgNHUY4FeIU60jdF+mwdktNFhqwQB6OI3INvBOGPzh7XJ2yNt9BLHQHE1tAc1li4qu6A1w
 PJ+jtfJRUoXiyFAwD8WBo3xaA4SEPNM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX+s9/SFmOKVmd
 p7qwzxu9U00GwroU9gVdG9wZL2SzNP5CS7QcbsRQcOLt1c1LcbstTj8HvlCvwQKtXYqQx0RaD8z
 MVLePzgqZGC50KuRqf42YYzPO9fTEzEub4CTENl0DST3ev5L15UjRLpzEOlUjqc8K06kZaCQRY4
 Gagu2dg+LManbDSmSkSLYzyM2orSm0elW5Lz1PhIgy1NTmLe2dOpAuHwBGi0ekoWQWC/hPYGJ3K
 qGSVBW/UBli384qEhEepyj3GHEiz63AszbjHMPxbInOLLCVMckmS61i50/6u2kFXvU4SO6DNT4A
 iQi1XK0qlNResFqRLzJWq3jOZS1cC1HkAK/iDe+rsEB3CPX2dVchIEdAG8ADMizgHh0+7ZjmvVS
 HGAgL1vgMuvCf2lglyXnaWxcnr2AnOK4PnDjxSiCu3XjCmdTiB7xA2lEFApEKizv5e/svxdChzj
 xB0xrmfoNfduNlBxs5Q==
X-Proofpoint-GUID: pGfvAIU7vZOsP_bExf81WaXOkHDbMo_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

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
index 90524c58602e..d114d828a788 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -189,6 +189,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
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
@@ -202,21 +233,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
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
 
@@ -3491,28 +3515,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
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

