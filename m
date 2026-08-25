Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83278332907;
	Tue, 25 Aug 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678343; cv=fail; b=EmFBC+Dpqo1i4ObdH+ACxSFxuSLGt2uPHHnQVzIdsSgHDNK7CODgjFuzTbFj7U+U6SGYArJt8mtmB/l8weKB6t9afiw6H6XrY8ZicSpIuwhLncXDaF8c238EscwlQacg52TCkWF/wAazOA09doU/UxOIcB9AEZm7P27pBYU3Ilg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678343; c=relaxed/simple;
	bh=NpoT/cBBl4rAzM2NVlulrn3aPKLC+iksPz2nkPNIsok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNpnFbQguw3OgblLZ5dCkj2A9K6h0DZvRyLvafSr7xXeLAOOwxfuPoWPH639dRruat6ft8OXnMzdUErZQ+tVsCur07lmyWWuFgg4tNXv+op5mfZvjNVSoQhTm2F1uRGc+I84UWk039O7AxUx3aayLObETx/9v7UwisYY2T9VToY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FClIvASD; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JhQu3bJb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FClIvASD";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JhQu3bJb"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEUwot1882698;
	Tue, 25 Aug 2026 12:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTY
	Hk=; b=FClIvASDEgXsVXhneQZ1ejuhXfdR2pMCKoqg59O0b0W0RkGzL8wu0oeY/
	rpIsQ+k+euX/T8tddICO+okJLR6kw0Cq4NwId3cSOjnoRSoCGDo5fIDSFveBBH7l
	3RrmucCrcWB3XvTBoSKODUz+GS2lFOOr537VhGTwV+Ya0GU6EfpjFS6iRZFhnNAr
	uumZa4LEa3hvxJlsglUodvwD7WVb3vDsSDh4BsjKBTWTeN7al388YeGo/wNO7dla
	a51q/6ZU19A7758XamA2j0l0WgzC02LvA4uCY9b0w4xG7F4vKD4S74nNlEWTZMey
	It2rvC3jMliu+tFAoiMn7rViMi05g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g8xga5g8h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eo5RJyrETInEV6e4CAxSM8IqUmo0jjySs/nQqybfaNt8eqJxLbHVuEnDywROn2XGC54tf7sKx2Rb+oCtfvYgPRC5ANDcNDBQ9v10dXeMEH4FkcDPow5Fxt9gDaZOSyk/K7wZXf4RlmEm2sQFmOtKCVj8mdQ3jjqA2MA0GOdIL7jVGnqVjGnV56iW3w8ThHyzcMJ2fF6OrWuQZyTSf5iygNKL06lYmCypX5Q3AJvGAiCtJy0LqZ7zFNBG/vA8FQDaJfrbxrYFvyJRpCIqAhNM/Wrarg+PncSnOYgjFKHcoTryetvgoFQf3MJ6I0m/NPx1Z8brd74Em90TFVzSj5DV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=VtXO7WLjoSTd79ZF7jobNTW5NWR+biIqzaROuu8d4cxK7Vr9aFGS4Zsq5VL46hFhF4Q1xaA4wPq9L/V6PLuI224MD1wJA8BIs2OUb+QrL5TYRR9gwrQPRbHA5mQdRyEraO3gLcjNa5p/n9MQK5Vw5L5mZEfGuO7H8DEnCB/M53/0Zin+LLQ2Ej1fSMPmRJASWWTnlyQtT1dSh99u6qnxydyoMdT3vehLjepYzDje5EnUE3LoD2rzyL70rTj7yO/EDMAbuBR62PKFWmYU3s6WhnwYgIhPAJ1VBWb6XW6neGbhKoGCQjbfEptc0Op0t7IfRq13nXl+/hQfP7tfZz6v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=JhQu3bJbB3zVNvjwNedF07NTw2/CnOC4MHGQiCQ6+SnW3V9wEr6pgaEej0O29tmg4lV8bOOhPgpfAAblhIdVnX5CQq6/CUX0lCryfd96yKDtSGgO3EWd/BgawX4kRI0jzZCCqLQNeSD/x+MKeVU1A5Z4U6ThJ9zF0BrUq3Rk69U=
Received: from CH0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:33::29)
 by LV8PR10MB7920.namprd10.prod.outlook.com (2603:10b6:408:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 17:18:43 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::42) by CH0PR08CA0024.outlook.office365.com
 (2603:10b6:610:33::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:41 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:53 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:17:53 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3Q1436664;
	Tue, 25 Aug 2026 12:17:47 -0500
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
Subject: [PATCH v9 01/18] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Tue, 25 Aug 2026 22:47:20 +0530
Message-ID: <20260825171737.776052-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV8PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e7a29d-b2a7-41f6-642e-08df02cce8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	jmZE7O+CRXX7vc2QfcUkzKFedb7g6XgZMHyA1ALlxlu1ZY6JPkkW97KwmDypN7ro2uL+1i45kjRIyJjfYdUsctHkS/btNep08qsw1NpF0VuW6AgQFsfntIYCiuxCwpDYV9EDSo4HizqQcWDs5ZgzOYiv8uvFYVNGQmMveTpH5DAAKtUhjpUcnsTaKfEc+y/zJus5FvKEQTGKc8VqJgKmtxqEBFMuV0RBEKOZHDsdIXWfjdodJmPU+5YsV6+1ZTwTha7ExbKQ/o6k3oSW1iBFHALD4N0MHK5zc3067OCyn6mFABEF3WjBZrefZQuLyDm1VvBqL2iLyNWO/1EdwTslThiOQMLj6w/04OzAgKgI7qLUuyNo3Hv8Nna8VvyPqCsdDY5cW/ni3FzqPOVrLRzLtQ0S9rMyshSpEpDJXfnrmfIt4UrRxKuQZYrovSwKJCV015/H93RPi7wmhoj33nBvly3qLY51BmgJzSRuChnPqy9l1EyaIJ2hv6zaiekFAO0ADDHMfwdUdtZRxHiBqvvLiKoU6MwiG+qacRSI0CyuvytlVrAlgB9ql07ISfdL5O2/pDxGPfIV4Q6QbS6wPWzKIOTbHVKrX3hYBho3OivpVJc3ZM0mVxcpKPrFHpk0vO6N003z4lwjn8P2oLt6NXjeOMjyHyJLMnzdBVOgS2QLn7blQ0QH29l+2FMtSE8X8CC0z2jLjrEmYACpKdRB9KuJIwU20iuJRFsJ8Zq5Qv8h3cCr2Ij6l0VsaSBYbUTJAFKU
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hfA4j/ESoOO/lenP0qeHFAX051WqBg7A9NdoB44+P+MBnPn7sTOe0PfHT4ppmVZWUQI5qwRAfQ1MVcX2JhH26senauRshlAkpk8qexvrUzVfABCZLzLFs+ZRemtZFYoOa0HsvbgWdw10cXEiM1uB6uwqfKEYAwO5HECMNq0r/AX183mg7fgIrZ0VkZcGpjGEimif+V8xJ4PdXnIptJUB5O3HLI1lPbxzMF0yS6v/4JQvHEGdkKxR69RKM4XiLo89LbRg5M49CLTe0ndkbc0pxRP/51iSGft1lwvHA62qSWFaAu2kI/VVc1cM3SFSCHeopgK4gAYkJcDAn/JgjkxLyxCr8amB0VPu5ylJXVR4rQ+2ZEQ+ciAz6/bjBkR8TSYTh4i8XbO8edmQSx8+LTUIxvl7VoBO45HqopZyPKLN8euetClHVYE6QHMy1aG/M/q/
X-Exchange-RoutingPolicyChecked:
	V/3Q3qNVF9FcI+T0+Z1T2HqNzZ4bhwmt7+r7auSkdmKLrhGA0HpQXziboUhyZoIMCRRicab+cMiJNuB1fct38WwIkOpbnmtQK4798k3Fx0jbihf6P9lT+X+Nze/o+Ai7jfHnmr+XpCW/uewvz/KlWRBe1OQUfiPGzqAlhKqu6g+A66Ryh0pNjXMBwqPT6YCs+LaYes5PmqJ9yJKSGFXZHwvp80wiqzE6EenWP5AaA/nG/T0K8Y1KchNugrKIw+zTaG/itXJUH+LlAndePgphFDqEVZuoLSEv7K27v2idlFEX4TqXc2AO+KjqWTB4Ces/zpT/ftZFAMkns4KlWzp4Ng==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:41.1103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e7a29d-b2a7-41f6-642e-08df02cce8ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7920
X-Authority-Analysis: v=2.4 cv=SuygLvO0 c=1 sm=1 tr=0 ts=6a8dce79 cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX6zuLkOU+tyt8
 tCeFRSCNfywxqtwqCnOexdAbq6R9/B7Mqhu6MnI3qLn9Edc25resVMinxholXvql6v16zUC/sHf
 LsTbgjZTtjf/EwWK9IEQh+O9Yp30Aaw=
X-Proofpoint-ORIG-GUID: sxjFvqJYt-Lo5eohrXIS8T6yxBRVTDxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX2uWYdOVydueA
 6P+12cV6zctm90WMwaKoifJplT2Zf5a5GN3t43F3IWe4IukTdFiOXcoBCprPljWDsIWwuFbhSDA
 yQid2S/W1I+/6KsgP1lrLJdbTLMDLz5HCcGo7zwNRkkAMKmrSyNbJJIUqT/u+RSgrUXlEfaxh1y
 rjAY9KO/MdNQW5W1MnbXtvtJPykFMSRh1QrfnGE8GC/3mG5DCA9at76iUC4SEMCuLpKBdQBUXes
 Tx7KYfsNuezhX0JY0icGiF3SZnTWwSBwjaQfyzBa22+f3xUCqQOkQtdil0YI2UwFYPIL0aKYMS4
 8tYNxlOF5dHmHl3oza7kjhi9C1B81ewMKua89k2T3mWkrMRFzuoJ8OuWXpnKai31lQE/a83D0Eh
 JL1/jzYNa/Sp7AUDv+JGJko8PRw32ofwPRXj1Rfva7ZNA++R2q9ugVRI+Ube0xM5oeHvD4kMWrV
 1tRvZ9KNu/gyuVg1Fiw==
X-Proofpoint-GUID: sxjFvqJYt-Lo5eohrXIS8T6yxBRVTDxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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

