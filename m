Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12133D3D1A;
	Thu, 18 Jun 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768303; cv=fail; b=UgSJcL+stWQHY9WspHCu8qZLvEFefKAyB6JFG7K8sJAXBi/7DMPgmif8FBgAqhtK9v8T7Q7O93cSaXpEZ3TiVJpoIRVGCCevLQThqF4jL7Uqaj5lKWqZnUnEWkvUEWbndkekwaF7tn2i515sLI1MtRIiiESnL525iZ2vQCxxMb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768303; c=relaxed/simple;
	bh=Y+/RqBSTVSE8voR2NvvZxxAvxN5wbWU+037GIN6R47c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/iATG6Yc6Q7N/f3pwJi+T1mrPhvYlFwG0LI6gsxJxqTKvzGOKrpmXJN65DXftoJwZYxoG52F/Q2NLB8FEtogkAxUTSN2ai/O+XysfMqa91VvUOAePQ1hGs3gHcgC4cXo68rpx4ku+/rsDVDHd8n0rjJ4O2Pa8zyWbb1fIrHP/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=AdRIcMbS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iEfOseTH; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="AdRIcMbS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iEfOseTH"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3ne6f3790566;
	Thu, 18 Jun 2026 02:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=1aatmYLlcC0l5UoTFBkid383BeZCZ0O/sLOtEY0Pg
	G0=; b=AdRIcMbSQwUOHZb0YOj0Qi15yPcbSk2OIcRpnchFMpVw1y+6pe+Qb0Fid
	SsyFuBUPXu9Mv6xyjCLUpyXERSk1j+wQRdjNftE4qaSc6HtX183ThEppVi4LgIV1
	c5k4XX9T5hB9maGnpgJagdrHzevNRhzr3h7KR6XKROy4wDDIqr81xeDKcYhhZZYk
	mUx9RSGzWucYGNSpPyYBMypsnTy2U9ziAH/6MSXwTTqQHSf41uoXzj6XWN7FPKec
	nfT6vcJxf9CUZYIKNK7Pq2sW28hPRiZkS7vt72ir1M7f8Gzvp32x93m6sp4w5Tn2
	EX5oSGc9QC0dtx7vKUQRme6MTxmJg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev944932u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0ZCOLXDnnqx2KHaDTVqaGMtWcD5lR/9oW1tJRwOlVd5GHj9hzXArgcckI3Ew3hPvcJCgFiWMATT13i8GQo2Cb9kqn3+omznruE0F1lPIK9NNk2AwdOsyCQ8Pv0i0RaRESx8PMcFYs46AcElitJRTNcUY+/V7AAABV4wOC1qEhzsEAzBj9DdgpBni1A9WE0/3pIIq2j//kUubalQ+SMvOf+n3ECCiSnRZZOvwQMgIs+dNESQJqFydbJn0qNGAolsAbuTzXbkQxHvBoSW6aQ9210DKtsdBJH32qH/oqX+mbaI6Wdd9Q9QbMaLG0ibL5Pg96k4GpQohS3lsUM/xF8irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aatmYLlcC0l5UoTFBkid383BeZCZ0O/sLOtEY0PgG0=;
 b=wUpkqL+5cm56esBrSvF8uYHXUUPslddmxAY6AhKn9gzk6qSllDvPMoyik4+2VDHrfyg+MgBuYsUFaJG13FrJV5q6NLaG5Iv1NwYfUzSiMc/ur3Y/eyJg0lcFijGnxYkIID4mFwzNGA0tkNR84L0DHD+N1wP9rQo1CCR5I5g0+nrmPoMuyETX5JAXSRSE6TRPk8RsDieKeEn+/EFMesBeUC+srk7o1zxjKUCabLZ4Lf4BRYTmyCI3uk9URFWg/7oJPifWY+1xUEFr7uHHUZcpV8RIkDahdWFvfYqt6WIuO/353szVPtTsPL+WDoyPYGrigdUTFFL/nm/pel1UI/YSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aatmYLlcC0l5UoTFBkid383BeZCZ0O/sLOtEY0PgG0=;
 b=iEfOseTHfIhOqBUx4+YJFdFw9PbsxCRkmq6HeTwyBZMiwC3ly2efiYWA+cFVyPFJCJSfpOKw4UMVYxiGi1VRx37vK4yhQh+kl9Y67lnfbOWPcGpErd+pHUvHhhENeyHq9nETMXiD5ffARv3UkZFWXqxGEA+B4R0hmhCsg0ELKXY=
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by DS0PR10MB8198.namprd10.prod.outlook.com (2603:10b6:8:1f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:01 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::9b) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Thu,
 18 Jun 2026 07:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:37:59 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:50 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:37:50 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvd3521710;
	Thu, 18 Jun 2026 02:37:45 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 02/16] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Thu, 18 Jun 2026 13:07:11 +0530
Message-ID: <20260618073725.84733-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DS0PR10MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d93efe-b8da-42cc-588a-08decd0c85b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|921020|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	uKbicOQLk6BaW+urOR3ApDKuaANAh/5aohf0Ydz+w5bHE+KvChYq4DOwg6mGjFUW5pvYvWzgmZ8Kv/qVj/pF5WPyIBEvw5SM7WVjF8YlCbYo6FGcn6C8xr/krINo2X0HbzhLMEbet15qFeHpHrMTCc0wrR6zNJM9H0BI3Y9/qNRPWJ8pXo0aSXid4iJQAJNuBBsKrQ9r/MzsXPF+tTtYqVPc4xAqVyz7jRwtmWKHzzEA5I2ua5CZtcAWcbP8A/N3MmoIOtIn0tAjuh2VGdGdacjuEB3Dys4lizJZH6G2AZGCbDGiLnUCgArvtwY9HxQrKyDb3urTfIMMyGxsfEV2n/U2Ku/wJd8B/8CVioyl9bSs2np/3YFEE7FbcpVkBLJxSTXJCz+NLUyXLGmRm4Z2haJlU8XpKt1fGcK87BAbysGQogrwJNWOkXPHrxWrloqwPTnzY48H3J+DdGIG9xpSUkmRRRVgmymqUyICLOWfy9nD/+qHIvmSazXf3IcSUla1WwELRLNsHPCl6QO0F4R1kcVexOlGvbuwgEj8i74njQSHCFZQ2zCRh/gVHc1znH2MEEG8ceuVqOsfWMO/QJa2pDRYzLffbKZ1LC7MaAhfFNltJPy89qkAilp3lDCXsvSDLIV397fS2Cz8QHqtvVYKoAjMt7Q5qpu0b++r9gCW1EYYrnL+Jf8mFEk0joQsjfngEpwsDzPvLpYJLbr8t647aRf3otPAl7V1OfsRV3rQw/d1EPnBZEIbUXVFrlnia5ygW5XBCyKPTeX1gHJc3MWDCw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rePHVCB3y/ymPu7CdrX82u5KeHGsPmNBTEzd+qOkjfwEc/TT5lgquzkJs9rs5Dt7MRiQvr/T6ErCRz1YrNlMo84+Dniz+MDq5eDBScGXR7/8sLmlSXRvnpio03Uk2+kAA4NHfU6/f1r82eJEa7IyF6hfBOti+Cqy8ezGavPA8m85IgAaT7qWq9x48DG+hgnE+PAdGvIhmzwa0c4y8dd8YalsOI/vpduhCPxuH58QGUkE9nt0CPEO8LUIkEUvE9xoH5Q70N/a5Uwx9K8lzUuz4aAjXDi40oBycE3RkxvZuP/irotg2aBR47BZ60pd9yfUid8ZF3/fyQBoLq2amXHu0YWgUegzTumwgAlLsPnPmV6Ud0USvgXiI4SG6pA18YhzehJrsbgTz6VsxBVsK6nQXo4QHB7DGKX7jjZo396cS8M+rUMjDA9ucAUgesqwKXCy
X-Exchange-RoutingPolicyChecked:
	Mn/auHgDgtiEKGOE3T1wksCCTyAEUy7BQJWCG/4mQa3BHqaS1JjpprXeU0+KaZro8olEtwfvOOB3L9qvFslWvEKtwMY9Cf22smacl9D/V8J4VGjSQ7Er3+6Zbv5Nb0LEqeYVKdTIlWDxLJirCWCjEM910YV8J8nw5tPuxR/m15Ttqs74z9C1JU35OnYr+LPhBrc8DeFU0XpWkkGQ85gy4JwsdNU5eNCH14NB+YmUefUZtZbibgW+SzmB2P1p6bG2SRlblt8jHX+fwiQnp1LRGASyQ56XmIC+36rww9CIH536V7z9owmnFfcBGpRSJIxxwIFGxAu0OpW45ahRPqKluA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:37:59.9199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d93efe-b8da-42cc-588a-08decd0c85b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8198
X-Proofpoint-GUID: 2TARor_gIDzge74-omxG5JjqkVUDydvQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfXz8QUedQddT/r
 P/H9f9qsQhkLDecp8vnece4Ddb4SK6CQJKpNz+Gwxb8o1FGNZc3P+TpxZRHI5isXz4lsrZgldcw
 Dp4QWdq56Tf5bctp4PlHVNhax+5iZRI=
X-Authority-Analysis: v=2.4 cv=QMxYgALL c=1 sm=1 tr=0 ts=6a33a05e cx=c_pps
 a=+3f3g5PcVU0WeXiSVbezXg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=S03zC1y9aomtN7BeUG8A:9
X-Proofpoint-ORIG-GUID: 2TARor_gIDzge74-omxG5JjqkVUDydvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX5zf05cCnv0DU
 CXUTHfurte3YeXDUhgfQDPUJveDUpWkmScK/WH7HIBz+2rOvSgO+8p2aTlATQ/cfM15bZMIQ68D
 SSuMo3Sn++WRYaCxV0a9vrdOziNE1rqP23u6nlKnjrCCZWBBJaFVNKC6LcwgEUqdrxwwrt7yruw
 4zex+oipIdahRVtLYGAXHAl2FgsffwhoVhYSmuUoVtORa7t8GSQ15EuHwzT7rPQMBOyXluyE0gm
 XC/yFMaDl9YZCADNcuSIKFd2lT/A1o92a4qmQtsrUmIlReB7653FKwXKL54d0wOo0KXSDifb2Ss
 c7bVKNyRHVZAKR2WcGWGL4D81p4KMeDm+DcKuXIY6GUaFv/9KRnN2lWpNGitTAO/Jql4VUZdnoC
 jVvQqMPj82t8G6L6P/Kao2s9O8gaqU2TvO7DxA/sco4atdfR9n23z9+A28ke5jVs5va94AQi3rQ
 SPSXN8mF+nEkcImPARA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180067

Add spi-phy-pattern-partition, a per-device phandle property on the
flash sub-node that allows the DT author to directly reference the
partition holding the PHY tuning pattern. Used to locate the pattern
data during PHY tuning when the device cannot load the pattern
dynamically.

"Read PHY tuning" works by reading a known data pattern from the device
repeatedly while sweeping controller delay parameters until the
capture window is stable. For SPI NAND, the driver loads the pattern
into the page cache once using write-to-cache opcodes, then reads it
during the sweep. SPI NOR devices have no equivalent opcode, so the
pattern must be pre-programmed in a dedicated flash partition. One
partition per device is required to keep the procedure unambiguous
when multiple devices share a bus.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../bindings/spi/cdns,qspi-nor.yaml           | 19 +++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 891f578b5ac4..c6f1b1d1251d 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -204,10 +204,29 @@ examples:
         flash@0 {
             compatible = "jedec,spi-nor";
             reg = <0x0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
             cdns,read-delay = <4>;
             cdns,tshsl-ns = <60>;
             cdns,tsd2d-ns = <60>;
             cdns,tchsh-ns = <60>;
             cdns,tslch-ns = <60>;
+            spi-phy-pattern-partition = <&phy_pattern>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "data";
+                    reg = <0x0 0x3fc0000>;
+                };
+
+                phy_pattern: partition@3fc0000 {
+                    label = "phy-pattern";
+                    reg = <0x3fc0000 0x40000>;
+                };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index ece86f65930f..38708f8197f9 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -123,6 +123,13 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-phy-pattern-partition:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the flash partition holding the pre-programmed PHY tuning
+      pattern. Used when the device cannot load the pattern dynamically during
+      PHY tuning.
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip
-- 
2.34.1

