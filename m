Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769E3D47A9;
	Thu, 18 Jun 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768371; cv=fail; b=CoA9LmxWv/OS2guZInkXIK7xYsgG3we76GO/310uLxa8n436rpDX4j+Edv8YVD9Ktv/nKpAuzkDmz1lyy182f416ZA0FHY3lnUTp7RSzWarFBGgxLgB0hdlMFAGuxblGjuNOvpvv5rQ8a7rrmioNV+epXZ5Eufl+9omAMvbFln8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768371; c=relaxed/simple;
	bh=X9JsfKDqTD0LifOzb15y1NLc84C2UsjYDOcm/3iNhlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTaUgolNgvjUZjP2Hn1r7FIYTuJEK1s/pWWtJk8HeOD0hRERo/oieGtmKEEmVhJkYEdeP9coNKoji3jSBAQE7fBDJkpfS7NqVTQAtiTyUNaQcQQGkYNNTWddZqT/63Ji09ykGEACRnWUgMLD3S/BlxJY7GJZx/BjsWNdRp/gjT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=H+LftAUR; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BjWF1b8Z; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="H+LftAUR";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BjWF1b8Z"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7J29h1333653;
	Thu, 18 Jun 2026 02:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/B7KVUPS93KmLsKww0HkBCyppixp+5ieSO8VEOMMD
	fQ=; b=H+LftAURwtnV2tV8h+eHVnB9/Yy50nWPD79GYLKJMtqpuObkQM5watblO
	Zdz/sCuhaX9QS+NwSw/Kgwpo/HT4UFwwdCUQzdzJyl1EQkJB8NPmYDxbIJ81OHXm
	QCkoNQ7ygeddermpyb02p6pY62YDwOhO/XcOtvue5Dh+kUk8jZVtqmJIStrlea5g
	Ec7zjTwP66+Qi2xFYz0p/biivpWOUNuKZ75eF5EHMJOWPwrikkbhUGMkuJyoqa5C
	c709A8HeyF30WyOONXeSghzs99Ya5JSzlIoTYx8D5uXOJdv0My3NEB7YO4VZsUpn
	oOocIMo37Zk9OWbe8BYDzYXJTJrtg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eutvept8n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iekzvq8NNSyk889FxqdL/g16mu+M6vf+KFlMFIAyeHISRKE1ykAyMpiqd9ZrFixiiHkfzbbbVmU/EM4V1w+i5mVfPCcxlIUdZlByKBfFWQMi3Ik0leGW4KaRHlRF31nFrxUhQ/SaCtR4rU5hOOaZvM/ShyNd0iiYspn6CbkiqCAGh8C9o4jjAaRj10VJZWzgoBEaK7W8lPiycszCy5vAczT597T7lW+j8ZyZkZ/hxLjy8Z5JqZvguknfJ4IocWdjJLtiN0843Fm9QLkN4NCRY4SBUFEm42V1TNyKTMPwcgH8yiY9vFqdvEybXhWq38RGY+EP/5ICTLizBH62h/l40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B7KVUPS93KmLsKww0HkBCyppixp+5ieSO8VEOMMDfQ=;
 b=H2VbGYoUJsMx6m/ydrGet6XW48BnbUhKHTmiCRRhYQsJUaM6tmNn47Th8RfuQTEGWPe6tZ3mHr/CItj46rRZXf+PjRh70aC6ayfJC8WeU60y7MaMc2TU/AyLSkLod0O3SpAqZJK8eqdAGD+KPOfSMSbMjR2jWOrCa39r4YsfILpbDJyCLbc44TUsbyHHCufaBJXtLeMr9deKvdpCu4JdOOutXqngRzfD7LkyW8QZscMPBSiIBbhbgNIw/UJdd6hLoDOmu2Q0Beehsu5vCk0zsQWAC07w+4grZQs502ZHfMltnKOi1IJ9dS+ItWMLzPsVK8QYRsuv8udV/hZBUcTjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B7KVUPS93KmLsKww0HkBCyppixp+5ieSO8VEOMMDfQ=;
 b=BjWF1b8ZhjZ8snTYRY58PwZO7tdvIg5M6r5uK7ky7dxvtoHcscnvK+A8IR6qHivDjlh+U5cg0hDMPBLotyXcRvAhWAGwqAsiolSDaDt5xyPSAIUIAUaGZl1D7O6/pLju4iCKihRdroM9AAi7fDLNfeUYESXFHNCkLgefaDzsmoI=
Received: from SN7PR04CA0191.namprd04.prod.outlook.com (2603:10b6:806:126::16)
 by SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:39:14 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::65) by SN7PR04CA0191.outlook.office365.com
 (2603:10b6:806:126::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 07:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:39:13 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:39:12 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:39:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:39:12 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvq3521710;
	Thu, 18 Jun 2026 02:38:52 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 15/16] mtd: spi-nor: extract read op template construction into helper
Date: Thu, 18 Jun 2026 13:07:24 +0530
Message-ID: <20260618073725.84733-16-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SJ0PR10MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd035d-9d80-427e-58f9-08decd0cb165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|7416014|921020|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+divZIi4/mEl6QJIzR7F7j5PoMmo1u7xsLwvq/z3jdUI5SBSRVoroMgbvlhx3+KrFEQCDsvZgeUM/21VZjZDCC001vUO3nswkpN04BSSyL/cvYCjDlEHjs3bF99J02APz8xXMAlTDl7GIR22PGEw0CCgl5ZY9xHnmgXXLeVi3n+19kDAwcTM2VA4xrVuk9MUlLhAjkxg9NkmfEktcdpWcWqOxIJ5W1zQSGQX6sPdBKCSt7e2qzpc3T4aC50OGYa4TLdPasEYMXKfejybKqQpTqWUz1bg+1PjzlNY09bjqhW3dykX6xNqqPhL8MZKJqnkLAESOQRPLJFs3Kkjx3wA70FjZysl+mDv+Zt/ORVqX3fl+uaq8Wp+8NX4agin7eGROHC/8AUNNgkLtrqWRDXG33YpxcqiDSu6PXAhyF69nON37NaU3ZNtek0szN9JaOfPteATdSDjvEYy3FuZZfEFxYdxL+cwhYI+A61ex7NpQ8SECtToEYXUu8j/xxWgJg5KaM/+eEQh0F+AnAQ5Te8rZB+KPOmWjA+JfLka7iDG4BJnPb94Ebit/sTi6pNonvpZF8t3x/ejrTa1ivy2tWlq0VdXWr7Pln/nR+/MSCEXyTKE1i76b47RWO9CoduCZDItLEpy9dq0Ewzq950DKPMj5bRpB6EBpk9pXIwLx5iS+6gC4DIwxxpH//RykhthS7c1vjLg5gk/Mtbe2JC0Xwksaug3ax53h8oOOTuUV/eVTrrdlZtoltxoKAqES8BoWnjl1gIrH3DOCMqM/qzFoTF0Gw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(7416014)(921020)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6zb8QPhom81wu4ch5fLhPPrm+vuFxfbRbhyN8qz9CON3AFO1jIadWjE7T3iFh1kRVLwYcPxwvvJLz0gPR+qjlIE2HLEZM6tRzKrmW+rL5g1v9iifg5emKc8Q+w56FypnhVLUhdZfs/FOaDuN3h6QOaX3XEWTVm8Zd9M2RYQmAiWroqy+iOzIgzLc9lwM90sIFey3UZFJ7PAxgK19n1r+4gUoQneiwbjRk4UFpDXxZ16uIwADvOAfI/P3unfiz8uLUsXStSpe9q7A/Tl/54rd62/xuxCKF/VGqRvK9JIHSMnrdVwoy5wahruHxhDRtiaFtUJhzJFpe3OpZvi1Uq54wgF2cTLhk5AVbrsWC/IugGpPKpkjq2NtgrHPRyd69O2CgIls4FhVOohQIQm2tFnYVgHF1dS+D2r3eNeCt6KjDxhesRHPmLw29bYEeyxaH801
X-Exchange-RoutingPolicyChecked:
	m4kTg8L/e127n8qo9RU+Wekq51l6yZLTC/lFVwQbczhjpeFj8lbY3M46/lz4nPleP/jKZrAdv5UouDz26H501rRGlx1vsqxdlRvseEyMRSIwMHDjEFNCEYiuaJxd91kl9G9q41c8h8WUDP7bazNr1sjbumzmNR4ztF+HzYXxKagbJnVa4F+aloG36RI4584kswf1Zx346hbu4CKjEehrUz8RPfK0x0x0A5fWIQucyjhyW05vsbzkptlkwtRjxiv0BfcApiEqhohRbk3Ogd1vwIHyOnpiSu1zvnoANFsFZ3ac4JITXJ49k59xsmpM68xXuXBrBzxVFDqWp0/Eia6g8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:39:13.2003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd035d-9d80-427e-58f9-08decd0cb165
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a33a0a7 cx=c_pps
 a=zXfEoyyUBsLHcbwyVEaNwg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-GUID: tEYk6N3K7igcHkcwlTPHzOhNReusP587
X-Proofpoint-ORIG-GUID: tEYk6N3K7igcHkcwlTPHzOhNReusP587
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX0CHF9X4u3+R3
 5FAv7M/RCc2UL5uQ7DVL9Ul80Sw2o5r0S64ZCYigTHDROvrNOCkCMPeM5Ogkvm/GG7/aFbSMEZF
 KmjncLQws0K97K5415vfzpxuT9C4KEM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX/Ls6zX33q4hn
 PVra5n803EnAgjiZjuLIdt5TWSw4hi/AHEcdO7Tk/rTEovGkgZnFMEGb5Vd/svURg5zAt1XEFj7
 3tONVUAfXGsCfUNL11WhpTtd4uRex6iKPbr1Zus84St8HcJNGgpSPGD7XuBSdREQrsHAAV65eug
 U4fXzmct1vbt7x/HdeSOZTjB3IctdiCnhz+HhTVEmEg6Hzw7ClwIQPIq3uhH/rD5LqTfGNUwtKL
 VM+R/pNfu1WGdVZULNQ5C2uu8gOEiPkrdmimc5Zi7sLLiiMcM26yo0GJsSYLSxXE8/PePzC7Chz
 9UeoDzcr0u6TvqTAwwyWmhHiMkHsT61XHf0GHD/zaDXeo1brE1WcioJAFgFVAbthOrxVon/YtpZ
 COOvt+2YgmcmPWE9ftKSoy3AkMd6QUcjNfy4XB/ZfNwrB+8YnASC4V9tBzG9TyL4+M5whZXvweM
 VxZW0gG6J3bs+tluJCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

From: Pratyush Yadav <pratyush@kernel.org>

spi_nor_spimem_read_data() and spi_nor_create_read_dirmap() both
open-code the same sequence: construct a SPI_MEM_OP, call
spi_nor_spimem_setup_op(), convert dummy cycles to bytes, and adjust
for DTR. The dirmap path also needed an explicit data buswidth fixup
because spi_nor_spimem_setup_op() skips buswidth when data.nbytes is
zero.

Extract this into spi_nor_spimem_get_read_op(). Using data.nbytes = 2
as a non-zero placeholder lets spi_nor_spimem_setup_op() configure the
data buswidth without a separate override; callers replace data.nbytes
with the actual transfer length before use. No functional change.

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

