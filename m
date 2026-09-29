Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5047045C;
	Tue, 29 Sep 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663863; cv=fail; b=n1rjfmgQu4LcrdECcLjHQvI/njhqSHGJ3SgbG+dOF+neKMNOqBA+YVxa+e5/+LidwRA+GLU5SBtrPEQiYYUYZpahc2ezr2puOyl7uJt8BiU/zithz5kB+G+UBTVViN/HFQTmjfJ/+oc/jSmQ4hhg88X+bCAZUbPyMlz3Iur+sJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663863; c=relaxed/simple;
	bh=W5TT3Xgdw7tXzKyNC8C7xG4n30QEpCLDQYFxS9neuMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAlDYg/ZJyMH7ctudK5CmLEgSMujiMyqtGd6KHWqmmfjNLAF790xYJalPeUwVAuBc0jucCTfYUSRCTp0Uvfo7kPClLY7/usOtHwczEQjADItFWAtPOl40uspq/45zst5jpugdSWP1UtqcERL1ndWiqkTNGp9iKFWlnOs2+4huNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZJggaGO4; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=pQg0ZC/a; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZJggaGO4";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="pQg0ZC/a"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46EFl3557303;
	Tue, 29 Sep 2026 01:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CEXSvKgeC7WH3jD3R6LJx02D4//n5BINOxyeAF1ML
	ug=; b=ZJggaGO4Nk4SHERWI0EDKicS4AV4OaUNtu2SUsezahJG46W7AT9vFjTPs
	EtFm3IiXy4nMSnf72c9RWXy9DEUgfWmXntmJUCfZuYgXvZpU7KGCzj6e4idmAW/V
	V4Nx2/cOu0seN9y9ElISWFvbAJ5oq5O4HOUjCdEd9sI865cgN5B1ciZqA9FikAUf
	4EKegcRADytquSQ/4Ea3KOD0raHQW7uhf49OnElfVudAodP8Hb6qB0XQwj1DIshh
	XUmH374i2xrKSl3595dUAcu5fEGXpqsCmYUTKgKGfpjGVoDJf33JPWUUNXDYfJ1r
	nZGiw3432GIhtV1fCKxebQZ71qd4Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gyyjw3356-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmaHweF5Ffrx1qh/5yy7Xb+wKFRSIJt3wJleJdMiWcIZAr4EZXjVkwcru0Qu/ZGamko/6R+DUxUkff1k9+DiszHmOkZgFV6dLKuPaw7eL722aZx+o2SMFyXFeOmSWOazSDxuESxYjY4tejLRjJcVSiPDfXJz2kW8rIIxWbrwrtr40q+YcqzvdzYdCI7LnezpM791JV4NVy/hFM09IPjQvxyxuhspfsvSR3pqT+LKSmwbyv4AtbDSJ8jIH7hpi/nCnrFerGpa4GKJIV1pKlXV14u8d7UXRY7PyHAD8AW/TKVRHMWKXPukFefhikv4M+A4FzHzJCtNW4NxHUKqwJ3stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEXSvKgeC7WH3jD3R6LJx02D4//n5BINOxyeAF1MLug=;
 b=n4arfuHVLXhdAWeWBLDIsUfVEEobwmFtH1iMMyB5anbFBvr+gnq1vOVWbO1/qz2TQXbb2T22p7fQkbbD9Be3Fd/PHS4ksuV7ryJZGmEk9X3YLTRh9Gs4m/GugWERj9nb8pBfR7RGZbjeN7xny1lDYZltvSpzvr4uRdfxDdiU6GI822UWRYYC4l+ouumyfNxSpZG8Q6mC3hxjnHJ2b8t795Tz+CI0dRF2XMGhkmVNX+G6rfkb95L7T5p2qXCLSrfzTUMKjYRVthNMFjOr4NhmE3VvHyFW7cH4ASnQSTuM2RsGmHbPu8Bzfzf+IZ76PkP3/rKCwAfKUhZ8AHGSxzMa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEXSvKgeC7WH3jD3R6LJx02D4//n5BINOxyeAF1MLug=;
 b=pQg0ZC/asODf6nxbjCbsLRT01JMx5+FmQvsJIChStSkb1ekPyT2ZhLAq2wlMRZ+nt24VMPHJBu7EzMvo5PlRNeI1wFad01IYfHQ3A9hi4urej3JkhB0YUqzC90ZLjQ+WIh4+tSXC9iLvUwpZk5jU6EG/gTf8r2WdC094m3BU4m8=
Received: from PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::34)
 by DS5PR10MB997752.namprd10.prod.outlook.com (2603:10b6:8:340::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 06:37:15 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::b) by PH7P220CA0078.outlook.office365.com
 (2603:10b6:510:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:37:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:14 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:54 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:54 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnD1395904;
	Tue, 29 Sep 2026 01:36:48 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 13/19] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Tue, 29 Sep 2026 12:05:23 +0530
Message-ID: <20260929063529.1235417-14-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS5PR10MB997752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b422420-ef51-451c-5d98-08df1df419af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|921020|6133799003|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HGBlWiJKP75CnIc2AEjTGfYKm3C3bgtCrfXsn8nOI4TBiIUlIQfJ/dzCV9kTuEdjBdpUzeyjbfCmgWKq4Fih8AM+K+NIeL2vOLY6rys+yfdleRaLw1Dxpm5ylApOCamnnVHdPBbiLQGPkuIwbUajylq6Xz4G2+BzZLIDB01KDBuJnVIt2dR4f74xqQ80OQvs3xzIAxNWtuK7jexjH/zEPCs+S0sBNSc/oZ/QbUK9GJ3pEJ/BJOaSKVOtSxfDUzwFkv9qKeSHKvG4g/vkeHMAW7DolXZy0NLCmHUeEudK1cP9uMgPkEmK86w095MV8uGlbxobO1we11L9ymPy4TF1qurmoQhgRdonM7papRKN6imwd1p9klpYf3Xkc+cFeJXnG8Z8EDTz9n7fNMfb1CSy7uGsRHY6hPyXIUP10EchWBXRnga6Hhg5g6AoMKYA7KD+HPB15IJpsYRBZNwG0ttiN6wno2T+Bs+V28EBSlJn8Eg700twxjKriDY7qaHN1gg9glS9VcgwX3w5kph7vaFFWbJa+c3hvd6QHJQd/SrTtkJT4n0PgFPgo3Yyp2wyOyvD37v+Loap3j15jDTGX6F4WX/SUgudUE02VbCwaCeGxOYhQIDnRk7ZsIJFnmMgVqtNL9vLG3o1Ze+FWNptSFZ+UAu3qd9/gxXMLmPcYaf1vk6DL6joLaa2RUZQ4yP5qGHaNOkWy0R/Y8qbUJp0FB6qtN/WzURnS0Xvid4JtEgNs4eRF4QtJ2hMMUXP2OVtxm2+
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xd7NQ0MsUOHZXGIYJeNdR6pQ86P0i+KcLHmrZRSKNqtDm0F/j1SdzAeb3kmRXBokUHWleQtZBRXeOVH0GWN8Q8N921Nccfto+cF5x2PoLDhGquj1iveS94oxj8K/mR3fAj8uHB7SY1hk7GQmgtP3zs3Q3l1tYxNkC1nf5Fk4/9IgnGmAmdnWFG9iNMB96N91j3EQKNQBDnuU9SYSOeP5nIsMjO+6Vl+esAwdSnJTNn48oN3rcFvXndyjSbW6xq9/nAkTwGhYvdEHppNrQFm1gLKa7MEPWgaTH1Ez6SHsQhWv3S2K1jqHq8im0Z1KfSu9Y5ZX2j/7VGIs2yZYmnTIXBXlat8iyIuk+iPFjnxcnbwnYH3N+GZWou87V0QaaK+/OH8aBGUSZaeBA5jFUTVwni6y1Rcy+AGPLuy7SLDHhDP82CzmA0fWP+RmlhMoCrsl
X-Exchange-RoutingPolicyChecked:
	D6ExWcQACTmziF7z+D4EI/H6CdmJsi2e6eo8J0DdJKzI1HkFDBI5yrZckqV7xy3lVg8jwv6VQUsKEDjjsN5Tojc1eQsYDn0ZoJ/knl4Hpfn1jRwybsk4Yyb6R7V3/Jk6IPPTIrRHI+HnyzFSgeFTVaolkRDTb/y1k+r0O+ZCRxfLPzN+FRLvANP8Q9xa4K2GVO0BYTXUucNmH88Zjp3TpKe9rpo/VUSbVUVpSAaiohJ5+SF9fmLNsz18aT/5gWYX0DJZJVu3FWzxwyTo9sbQUvyi0M6ThDzOA1sxwh+ERPC+ro9XTg3LRWCEu4VtzirxNxBUBPd0X27uFuIXpGsL1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:14.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b422420-ef51-451c-5d98-08df1df419af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997752
X-Authority-Analysis: v=2.4 cv=X6LHu2Te c=1 sm=1 tr=0 ts=6abb5c9d cx=c_pps
 a=Jpon84a9jUr9T0N/wBB0/Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=G053T6RcM3nF4xrB7AoA:9
X-Proofpoint-GUID: Y2IuuY20djk17A6iFezlnTwFDWFpCYd2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX8PyjK6RmJemT
 Re59BNSZa6lT9jPshgK31PZD/DPlaHewSg9R+WQdogkvAckgDKJAMI0FED64hwsD1mjHB1Y98jg
 96y7BgqFQ0L7WV/MCM3S/+yu/jKuIzM=
X-Proofpoint-ORIG-GUID: Y2IuuY20djk17A6iFezlnTwFDWFpCYd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX9iMsURzJ/vVe
 nGhePT/faKbFOj8Qlf+eecbVwOH4cR+Lhn1TE/Rwb9yJl24ENmVYCPzeiAb7EMyiKuvlSrBWYwX
 xMHAslBZmMgPgHyvIfdVK2m9Aq50zpekiaEHHp1vz87YFnUuKRRM4Ix78nXIyN3mE2hpGVr5tfv
 OqG7DpnItlYFWhF25rO61F/hzE0JOyg7rxaJ8rC9mPg3STBsyQ1X5JcJbh70HDgh8j68OwfKWQQ
 EKoOrnUV0a0S+DiAmml9EorC26lIDhFWrM4Hl7nS1/iBPwx+JPr8p0j/Efbc47IzOJ+XmeBPGA/
 0gN2tDVFWTDbpoZrOixZG1DBfHdOWykfpFcRlUhPexPSV+r7ta7KK7cS7Tdj0K3VJHBoeGBfhXE
 h1jB59eAquRbfp2Im9gkIa+xXmMacSS8nPekY4ao5vmXzM7shnTvD9QyQgxlnqfC5f7/jp2MCzz
 bYIU35EyIYQjnjYpytQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2752e7cce16c..10a393105ca1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1621,8 +1621,9 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	int switch_cs = (cqspi->current_cs != f_pdata->cs);
 	int switch_ck = (cqspi->sclk != sclk);
+	bool reconfigure = switch_cs || switch_ck;
 
-	if (switch_cs || switch_ck)
+	if (reconfigure)
 		cqspi_controller_enable(cqspi, 0);
 
 	/* Switch chip select. */
@@ -1631,17 +1632,26 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (reconfigure) {
 		cqspi_delay(f_pdata);
 		if (!cqspi->phy_tuning_active)
 			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 					       f_pdata->read_delay);
 	}
 
-	if (switch_cs || switch_ck)
+	if (reconfigure)
 		cqspi_controller_enable(cqspi, 1);
 }
 
-- 
2.34.1

