Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761884;
	b=zKns5Oo415gU9gsS+Dnx1ekD1sLQjklOfY88y8V0vU7xhx/EuKqKB2Ff+xtrW3wzqqV7
	 o/2mUBBkBZkKi10nezUekmmD6IrpaHvrt/F92YiAUARFN2k9JHJIer2hXYn2jW6u+/NxR
	 CqubEemtDzrL33MOw/d4zkAumrKEgG0OXz2FWmtZ5cxgWxOO5kPoHza+3c5xQX621/WhF
	 zKpwIYVq8IHTHryWf5eNGOXuyzHkuDBCaNHwyItFgOt8e5Y7Eze8Xbv0egQfDkf7cRckX
	 E5TIJkG3iV+Ok8AmUiqWo18qkq1iYVdOJnZZwdTFhomyFPh0IDnHq7SGjOSRwPjJmUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761884;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F/Xh9v5w2YGSdHsKKexseTU0ubx1LcejZMghOCa3sK4=;
	b=ZVrXRcJOVnfWo7iTSE42Vl/A42Tc+KRSuuVm7PBwZ2gk8aZlrnKix9079KeIfWVpNp8V
	 cZCv9dFc7j8WuuPzpVjJqbbP6t2+l6kRWHMLJlru+3bBPSJAK49Ii9DvsylFyQK04RfnN
	 gduOGYh2OgZJ8ne2vYpj/W5M6dv2QeJd0tzpNb3lJ7OItZx37qbwO8/183rbt3Tvx3biD
	 UK6aL+N+Ao2VBNEUfZ3D9MrdzTItOkUU/RANNNhkL328dAhISPq1xsDVt8pBGytdhVEBz
	 8EW/Lm2WokIfXSefyiAWiQrcDybyHXz7dm+6BMjBcwmHo7eWWU45u0HZ5f8wiA0Ctjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="cd/u+HFv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.56
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265D606A31D;
	Sun, 15 Nov 2026 16:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8265D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cd/u+HFv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfwLXNGDEl8XdvLwxVTWapb6MJadMvbdQjFmayaDJXA9r2xZTA088jdGcgLYi+V6Z3KUeF+J8MN42e/Xxyqo89IsHEaO+I1ezK8a63bw9XFNrvt6hFVMDLE5XfBBLYm3YCqzwjgqw1rH7hV+p19ZAUVAdW8WxsWuMbRzneQ02QUs3t75+Y6fqiJk61SnFYK7qZKOzO6V7B3XjwMeqSJqPhJ76dAP1rN7iGqRmiD8TuMMj/KuETsd1lbL9BtSf8AywWQQNDDczmw9YcFr0bWMGd3XdyI5pSF90+G5T5+ZMwlSzGW87drmplvq3LPqGLgdG+eRm12pXvHmG1TcuOyG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Xh9v5w2YGSdHsKKexseTU0ubx1LcejZMghOCa3sK4=;
 b=lrzC9sJ52WF2lRQZ7EtWHKsXxrNMDrbdm2bLoDQxlN9NtO1s3k+2m/xt3PjTOAQi7T4lvmUr4/LFWhX5pZ8lE/GOKsyVB+xiSIOKkAsmR0s0nEVek/wMG8loHQrjIM9w0eCVFBsEEemKsqCEXWcKxI7OLxa3OBjhNwx2pUcTnTDHaTdvCoAh8w15MmJeKRXUQQLExM+HhJenhsfcXCwa2YCRNGLSV9boyS6QWKIJPcIgSpg68bbpCM8lvcYpV3SMpnH+0sseYgPbizjqIJMcnaLZ1L71aJQdAfN5skKKBRsMkJySacAviPWg+opRqdx2xnNxM3Yf7V3z7MvPjIKyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Xh9v5w2YGSdHsKKexseTU0ubx1LcejZMghOCa3sK4=;
 b=cd/u+HFvbOmAlDeXRc/9OBh4byOBh1s0GhyhxXbtk8jRb1Oe4NpxXNfk58qyrCaoMpMuSEeNKRD/0z64yziLxoynPzwGMocL6MYSBWKAPW5bbZAEAS7D9u36oB5TrVtA7EPbJly3tz+mKDnQ7d8xVyB3iPWWEhDYL7Rle/IjmQA=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 16:56:58 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::60) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 16:56:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 16:56:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:56 -0600
Received: from xhdsboyapal40x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 10:56:54 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Sun, 15 Nov 2026 22:26:44 +0530
Subject: [PATCH 5/5] spi: spi-zynqmp-gqspi: Use IO mode if RX buffer is not
 cache-line aligned
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261115-qspi_14_11-v1-5-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
In-Reply-To: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
To: <michal.simek@amd.com>, <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761802; l=1419;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=IChAuU+I/BnHBg2J6UTcb3idc3hJUnluYC6NbdLMuJE=;
 b=Bkk7CwSOm1nwekzJiCYaTan9BmQ7nGQdJN+HU8XW5VRNBGDQJ/D+FrnjdF2NX98SvE9lihutX
 HMbxMnmgInZD2AExYYYnjPf0/YUyFIFxp03VR2WodR2CuXoRRGYVj5S
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: 804089f9-789c-4eb2-a63d-08df433975d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nknMpDSi49Rmurx/42d4Lqg6wPcFgRUoWGrPXzftp5iXEpCtlZzbXV9cwKwT0yndM/kv3cRxYNaVLiG9w3yKO5leZIzuieRu49yPTR1PraXkbNsFWHCWmXW3nq3j/9JTdbtjY/Xn7Ezm5rh62F45jjcJoa9WBCbY/v27Zf5sQLdnlKP6slR2F+EyHZruSJXu8d2YvvUxflLWSDHYH2Uo5SLEj7H1w1UvgBuAUm9i7Af6KLs/TQ+ajF2UoU9Qnsgp6OqDi+lqkGncPdMGxxKhhUybYOgaa2v08p+nGl6ktAtxepY7HW4h1rs7SzaKf5U/x0MmjH8WD2roJs0SrmiBMMtTOYm5GO2Ha+xKMcsnrxZbXleDiktiCkoVFX9Rr8/lFVxKa/1xAgSCBtLwKSFrXCKx/N8p2beRbV57FTjxSHAoPNIWEsqbVI7ccCfZ1iGisIlWRBsv3scCrNohmuMIlMmBrIc/S39G/FJVjw/DYRs7RiW3rqNCeBeNBuouf2esRCL8NqbFH2X7HEpJT2wtzCCQIHa8WvoIcc16hF1xLfhTcNt2jVcJQJxbCAyo9OlkS06VxHQvrHWkqPEwyaRxeEmakDpAjxamZOG7L+psWmshvcyJL6gW1S1t1la9mLYY7bBhuZKrJISymJJvKhPN2A93I5xkUBh/+f0qMwAUBuwPgNgfMyhJ+VkwFOv1RS2v01mliKnygFxaofxQyH2GSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SBoC5EZ34TvraxZFqF/8pl5wcj9i4K2AvaRfNZr8RptV1YTvFuAX9101ZeHRBtsNedC6NJo7BAoNceHUlJ9jRy5kiLJ2gJiiQPcIPVyXuTjkWdv1Gal9v1IwCeND/feGqEihhpMxgJBmrwhBcGzC4jvjFpGHnjk7lAwAvKCFPLDYQh3O9lMO50Pe/jUNyif9f3EU8EdjQ65G6aDtEmPKeJX+a/Teib1plcGHJYHqsVjsZcm3sIBQlFVEH48VKe1mrXVhx3y43j2aNhwjKHsEjdhAwzvx55F6ZJCVoYTycTt0fJ2jDZ3+D+P5H327BrdJzUJfBHfVVQP1yXv7R2n8VKcG/Gp3n5S7JPCGSjzelIvZ+Gk8bWO39GtA42PanGjzE/BNRDUS4dQAgI395aNtRnPcPTpTUIEyntSGd+hxIIxu1SFvMb/n0Or+ynuUSFdj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 16:56:57.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804089f9-789c-4eb2-a63d-08df433975d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

The QSPI DMA maps the receive buffer with dma_map_single(). That API
requires the mapped region to start on a CPU cache-line boundary,
otherwise the cache line can be shared with unrelated data and the
received data can be corrupted. The 4-byte alignment check does not
guarantee this.

The ZynqMP QSPI node is not marked dma-coherent. Fall back to IO mode
for the whole transfer when the receive buffer start address is not
aligned to dma_get_cache_alignment(), in the same way as the existing
short-transfer and 4-byte alignment checks.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 28edc5e82c16..487e2e0b4da6 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -871,7 +871,8 @@ static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 	u64 dma_align =  (u64)(uintptr_t)xqspi->rxbuf;
 
 	if (xqspi->bytes_to_receive < 8 ||
-	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
+	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0) ||
+	    !IS_ALIGNED(dma_align, dma_get_cache_alignment())) {
 		/* Setting to IO mode */
 		zynqmp_qspi_disable_dma(xqspi);
 		xqspi->dma_rx_bytes = 0;

-- 
2.43.0

