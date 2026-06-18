Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6635E1B3;
	Thu, 18 Jun 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768303; cv=fail; b=natH6Bhgv5lU7nB066Ck9j+Q8e1nO136SJcE1CHyw1HLWwrZNow0/WwxpqHWtO3xpEP/e98aOIoW38M25pFivfGsYDrXeAniJhsACLKx/2U9rUOrPN+o9gDT64Gukw/BAfTVhnPJz+50LbGRbKpI3lHFVdlpe0AvdWcQ/vrgh/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768303; c=relaxed/simple;
	bh=dQT9BtiEHU2V2MuuGHjTzhml8WFPBRfdwURXDRd+Yzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t81xuno0gfhJrjAz2rN7dFAMT4VezA8cXztEqcZGGq1z94YUGV5YUFqMSikOzt8sBSZdVLt8AeWtWcZfLc15GrD1RVN5R4Y0CI1xHfAGb4vmzW3tfQauqtnVKVdA5MRDzU2MS5gkx4hS/caKq2OgMJ+l+pPk6ZxjX7Y0U29kDdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eX+FgEEI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jq52090N; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eX+FgEEI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jq52090N"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7UQ3o1333596;
	Thu, 18 Jun 2026 02:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=JVeRd9/aAVyEPJfyQgcj4HI1WC3n8r9uyRQgl8pOb
	co=; b=eX+FgEEI4XY5rIfCYPLB6UYrY4nbUEqgfLMhVPgok6U2BAj4LQYeTk5OL
	cQ43ATY0MJ925ztfqWVuRROUOpJviA1StxRkY0o1WtmL0YVCAwLgQMISvkOqq8Yw
	6ipjVMW6IWppq9SFwaKcC56KIP3MAWMovnKh2QR2VLWGo4unTtf4RAScMuHom5tq
	4/9Yoo5LN6sr4qnMDbrHYVWd58b95NtF0FT4UI7jrrmiY1lGsG337RlQwg41TTXj
	rBi7udLmS+5bQJYX6tn/rPD7TAQfmk38HAYaf+kTm+9+SfPPKYH77FnkQBQhgDW1
	WIFjom5psLMx8L89ULw8ifAbFhD1g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eutvept3b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOOHMcta47eRGBQ+NJzthkRJ89VBU/eYOWKOX/OqFDwpYRQ6XNz1YxFXWPoBLqF+BxaW5PiYNwKMutBDTZNv1GghVYycKnb+IJ5cbuVvohjhyCxAAoXOLAMKF4e0s7CowO+cRL+N0pAFrjjFjS0sKAYwf2ygUYeCpU1NqkSsjHvr4oPfUd5P2fQarSoHIySCdr4cuivkDKclt/A86ABkufY9pA+nxDYT4gL9FGFsQ7hCQxf8DbxAmSKOD4T/X5L6rgAlInl///vNL7zX2/pMdGUtofsxpExC/MkjAcM5rVXg/y4h/QSDElFLdezQECunJT0kIaYaDAVDozfUbmCh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVeRd9/aAVyEPJfyQgcj4HI1WC3n8r9uyRQgl8pObco=;
 b=KFOTWANL9TwJoHXQHNyfHmzu+RoKOzCXVsHokT+ZKyQoD02GC7o9/aK/i8iTbgjjGuKXJN1k9cbFxYNjmXLrO5U7YjL5FaYig3GNU1r9WdX9YCz5rMsDO7DfSkALaPDcgtWwGTdE/MHzT/Q+vmOFDjxBEQEkAcJO0gWjBcwAuXGIkcVUfifafyF2ySW30ztZYLomih5yMKL8pL+HWjp3NqD69Qcl9xp5BV7hyPgruFaWq2gvPMsFv83FUKqxMSq43yfVypw6Rd0JsU/YkmklS8UwF3H1/CXPy6o32FJr8VFRIkcfYMjCrtQJEYs0Jok2SVJUW+xgSkmF/pYpSooP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVeRd9/aAVyEPJfyQgcj4HI1WC3n8r9uyRQgl8pObco=;
 b=Jq52090N0QyZ/lUy1Brq0a4rbQwv4KP0opdi3EPE7E7ziAegt99TngXSWHY0b8E8AoSzkoEHlDmj7j0CJtJBq/XLEe3h8/UjzQw1ebN6yO3+rQ0I0nZVW03J0RmoBA8hyHiLUhIp8Qx2Q1wGgl6uwVwUuBbqZ/sO24o5EGUCXoI=
Received: from SA9PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:6e::11)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:07 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::5f) by SA9PR11CA0006.outlook.office365.com
 (2603:10b6:806:6e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Thu,
 18 Jun 2026 07:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:05 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:01 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:00 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvf3521710;
	Thu, 18 Jun 2026 02:37:56 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 04/16] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Thu, 18 Jun 2026 13:07:13 +0530
Message-ID: <20260618073725.84733-5-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d39544-107e-4c87-05c8-08decd0c894e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|82310400026|36860700016|376014|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	znUeQrWwotSH8ABXzVCc+6zS+Bh/cgtSqJz4yB+KIHXEn0+N9BjhHgUvsdW7x4uk9z7N0BRHi5lfJtAJSiKBG5t4+eqgDcfHiT0fL8lGCxvCrm54nvhUz6IX5yTVGlzBKtpXQFRXnnYQNa3fTzRTLC+Hla3+q6IqcwLIyfV56r9/zbV1BkzuYvgSkD5Fnl7atEW77/1PpmWkRamz0nZay4WPWAysKmWKXSqbhoEThMahtZ7GhTSChDVLWqiOGTxgb2rwdjQU1lstjtXKuqENlYWZ+S3Sh75NVCEARzp+qd/u+s0aBB+G2FZI7Z4MRXMBOS35XGLzK4NzVrjm0bAKIpGhGpjC02W91tlEQmlL/bZcte59DD0kFpSBlLVyDBpDrPTnn1ztIOTBcPx+k1wyeXTjUEyIhUYBuVSPykp6vdVu7/lkUqtPHHBl9hyfEUMwl5RCbhXg0x3BZS2Eyu4mu0mgQFYocca0WXoIML4dQDfrcaob2UcdVGn5fqNUeKhAdN+uyvCInDsT7uINvWXs1fnte5TZrIF4tG6E8xzcJIIW+VH44AB+Zop7BHHT18EOaW2uMgp5KJ5IIPuqiMUXPNEsRPsimO/od/6s8JW1OzPZd2Zc2FiNQC1/y2rgnuQGtOVwIcl4CnGRDaiJdcUG25UB+SKd9R7JQxP9bEDX36rxdZJleNk/gm9OfZnK/ZRWOV4Bgm9D5kO9dcP9zDPq7w05RXmgM0bLLkDswdj6LFVwThZKMVoBu5V9/pwPzBs6J2co1nulZBfQkWOesZqiZg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(376014)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G3jKlSlmn/S3SDMMnp04ZnjvxC6WN0u2YW2UVTAHaDL27523ge5TBxgwlA2gtmWEpAZlGWGzWeXon0n98dUhJbXFLuNhe5JuaxhkZs41G02mRFsybnY9XPWHTvNaggGVEyNktkZfzDmCE6d1+DoqBtpU5YMJSlRMy+yAXzA5/hw8X5uDn7ik0/uKEpi8N1BUgOnupnolA37Sv5rwCsG6cU40GGEwlnV2EimdTJZKSEdrOYxHD4frcqLN61sNQJd6qpTlP0ekO94tytVMc+yZvsdmI8ilEnTW26p2J+URZ4NbiqTszRgnFDd614zFV14rRdjJFFZoxremg463Jt4XZQ6w8KdgX6QR8Eilut13/ITJf1Nyhhx+jyDmTSKLSy9pab7a9ZwZIiviPXNCi9/CCib5JaO/nZBM5xb6ye2euWVs8Svp5DpUwm7dExeK+PpH
X-Exchange-RoutingPolicyChecked:
	UCmUHmCdHsCUQP6aN1zFlR3PoR02p7iHMuJSZX3JmwXQX+xsVb9i0VgUDitoJLe0roHDlE3QnNP04/EYohRuxNo9ZxAq5x1JLYgR6TWUHLFEesnyK3uqnzE98py/RlLqq0NRjGEmcSlFKIjSZTOx3Na1H5a0jqHovj/K5VFMGUOsOB6vj8glL+4LsNLyexpbAZrNEZNqb+tqmf0oin0JqNXgeFfj6hbCUQo9vcVPRi+4HtiYz6BGg+7Q8VaWxlM9m7dxNuxfD2is+7ly3sX/OhjAnSyStr80cLrrBTow6CW+VbyC1t93I/0h9QGH4PyEz2LMgZvxAIi4k1QokQH+Wg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:05.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d39544-107e-4c87-05c8-08decd0c894e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a33a064 cx=c_pps
 a=MAgfROEylrrND5Jw8NuT2A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=SJHljg8rPhlK4JAv1-QA:9
X-Proofpoint-GUID: v91EJHzfeIimwGRDsYWQ0R58HCDt3486
X-Proofpoint-ORIG-GUID: v91EJHzfeIimwGRDsYWQ0R58HCDt3486
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX3iQqKMmikMbM
 ZnwD3oOBfFh/plKfIiT2XGR4SHRSr0vV60YKMFxThp68EmawEs4alVXqzbIMAPhHRaz0p2kjy+r
 dXEgKRPpHAAzlskIFOLTBX8FPxD56Cs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX0RQamF78fWh2
 vPGx91Y9HIRYXv24gAxEp4KbTiuiLAM7ONOgeVGnBNZDhv4sDh6roskXCyaYQrATsl8VuA7mGkJ
 omOfoFyjKoI9k/gqm0weUM/u5UQv8PWIoWdVAn4gy8pnfiWht5U1nJx5B1852wgMPpiXZJkKGm+
 bb6gedab7mc94QmfL4sVK4sHojrvxSkNvDR50QfrGlDi5UUadYiw7PAvZeeEu05MpI1fd43Fj6n
 GRGuEfuG56jl6RVVC9R3d9u7zsuOFyWIRz6F0xtVYKMtGreJVLfhduuZ1wpj46XmZBi7oPcn1vI
 uhBph/pNlAlMjSzN0rYoWm2xmmoeQNmpCXDwYjmPXGiaSah2fy3iUTto/j1EyEgAU+Y/eQVw9AM
 cgMbKryul4x2ZHSuUgcqpAGlYG4X2gTEUCvpY3D3dS9h9vP/vLi+G8LHTS4WLqxCJepgpUDBgR8
 7Zu9721oe2cAB95Kvog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180068

When a device exposes both a conservative base speed (spi-max-frequency)
and a maximum post-configuration speed (spi-max-post-config-frequency),
operations validated after controller configuration must run at the
higher rate while all others are capped at the base rate.

Extend spi_mem_adjust_op_freq() with a bypass: if op->max_freq equals
post_config_max_speed_hz (the value written by execute_tuning on
success), return immediately leaving op->max_freq unchanged. All other
ops are capped to max_speed_hz, the always-reachable base rate. This
integrates the policy into the single existing frequency-adjustment
point so exec_op(), supports_op(), and calc_op_duration() all behave
consistently.

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

