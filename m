Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761810;
	b=ur06X9irV+aXsJwS24Z3QOr1e34/5przgX+yE+tl6yoKwr/5l2oI/4GRRq305jhbb7en
	 +LUff94z+WLo8FfN5BM/Xv90pTm1rMM2/5/ZTp8eUr2gkUG4BGuz1YYqUhkTdhFSixkWT
	 7nE+Pr/E0428iebD9ZQai/3aPoUPLsyNVeAjghS4Cyv5lZVgtGd5W8tFOu+1UPMjUkGU6
	 9PKt/BbzXfK4hl/8Z/xYi6nraSq5CSslS55Z7VX6JgewG2JIwH1yc3/TpkxkaKx8xKLXv
	 04/gZ5NbrKwvNf8+7sRWvTEi69Bv28RDY0SwoXQGi76mqmHzDehBjRqHyL9wxqaCb0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761810;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rI/QGfrjM3i7FEH9pkXzGGNmIFzxXp3sVm5FtW/Duu0=;
	b=B4TfcHkmRwptZORSDpOJ0X/0p47lAcr7n/X7hnSLzVFV1afO9m8ludvbuoSdfnxyGiEe
	 QIynJ3DG35NuiLp722ShCCJ3aSQiIt9oRodFiSf4dwo3foSHZOybp7Ynjzsfzauf3HM80
	 I3mCg34Ntx/KCgobKhE7Y/xis7DtFqtadz/fJAYugsrsvyzpfFrpLNiD6134auaO+rc1p
	 mT1mi8yC0aD7sBpTa34XzeGdtGWfpIoZdFIqxUBT33WqDCR6bUqwkII2bfIIJhKoYG1TQ
	 aOqPL0MrEA0max/0dAkG+8Hu14jmCbAMHVl3Te/OLdTvzN/0puaMWV4K9bD5vwF8HwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="A8gz/SZx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.54
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765E606A31D;
	Sun, 15 Nov 2026 16:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E765E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A8gz/SZx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHHELrfOSprx3mlhLBIplFERLLehhXyV1XnYTQnUnkyB0SqBzZ85uxkDL6M/fLidqWuMA2vAHY1L40Qz5kqxrDH6fy87pPas7sWtaUl50itqOOaFvh6fEEtMmOIqhgOSTm+wQ7WMPCCklCSBT5Vd7D2V8udXd3icyVaQwXZRvuYH56CEwmyXS2OLUBcdwfQOtkha+/4NNyrpu+BiomHxHP0iIscaEu63fa7cX1cTcGjqRI/o8onW4A70qCB3aqYs/3qO7lJS4MT6qHxYGnaO5hAZz0UmSn2NkOc+wO+bKl+0SUgQiBw033i9ea2MMjribVc1lg6CB/HTdeE1/DHakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI/QGfrjM3i7FEH9pkXzGGNmIFzxXp3sVm5FtW/Duu0=;
 b=bttLYeBDVp42r9GmJmRC+RhZHqxto36j4C7k9CEmc9fWmS3z76It2D/teRWl5zCMqBr2162H97vKgzXtQ7SjYS19jUYVLMRbWHhvH4pbqxM5mQyva7xFo7iCuTWBVyUWkn2nLBw+huCnGv8Q9kMcZFGq6V2/F49weF2FpCyvnOXmkzLblbdQ5vjwGGV9d10IAOXT9fwiVIHP5jbEQw3ZegyfXkSkRgFmreLyNh3zZkwYRYhtWu/u5SN7fLCiJdHg/J2BUbki0+5rL244SnnAupCxzrtQhhOhKipCO86GOylYNuYGyf70sfWXRhcIoFNjG1cCkVE1PbFOSQNuJ1H/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI/QGfrjM3i7FEH9pkXzGGNmIFzxXp3sVm5FtW/Duu0=;
 b=A8gz/SZx0IeEmk7yDT014n+zvI61HsiyIxE2RRyvtOOgFnNxo1CBv2txCaQVBboxszvaITL92kMWdsT3ra3BZW0E8cON+zE/zt4Q/msHpnlMphZFuo4JnQdcQwZvOHzz6myKEIUYfUUdQ+5X/jdZgYk4qUEIz76jeMPjTDL+u+k=
Received: from CY5PR22CA0095.namprd22.prod.outlook.com (2603:10b6:930:65::13)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 16:56:46 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::aa) by CY5PR22CA0095.outlook.office365.com
 (2603:10b6:930:65::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 16:56:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 15 Nov 2026 16:56:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:45 -0600
Received: from xhdsboyapal40x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 10:56:43 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Subject: [PATCH 0/5] spi: spi-zynqmp-gqspi: Fix remove and IO-mode reads
Date: Sun, 15 Nov 2026 22:26:39 +0530
Message-ID: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAEfk+WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MT3cLigsx4Q5N4Q0PdRNOkZAvLRDMDMxNTJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAJBSW7puAAAA
X-Change-ID: 20261114-qspi_14_11-a5bc89a60645
To: <michal.simek@amd.com>, <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761802; l=997;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=cxWTGmA+AsSETKdMw7Ryor0HxRhlm0ddw7Oo4AuBqpE=;
 b=AUFMaozOZwzfSG9isQHPUySteub2DcOxUIxtKyrnPAinEDDkJnrrUTLnSMOu7daUHEmOLmf9/
 tiNvK7IwDFDBzYqge663QTeJI6Ply/SUQas/F1wmLNmeKAUfL+YeJUF
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c760942-7f48-4f10-e7c9-08df43396ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UgHhJsj6p3bcB7eUsGHsUrRmlg/0OlueSX4LztQJFfDXr6cc6sqzUx8SCD8dST1KGBOg9YYGiU4FhdWfI8mLv2TJxkRWfp/ZD17Gq2bocIFRvnIipYLRGD+7t3S7GwvgDuJ4DlFIouAMqTG0tIBUf4u1tUmklY8/iMOJOXKN7XlzMlbDaubYmgP6c+XcyaSneuZjusMMarA0tokBT1vLnRsdt8CqZ9EE0xZ0BCvdvdC5ZbzhRfBdmZgU8LZvv048iw8kh3To7iW8MpnTNkzcuoVhrC62RUsIdhen0xUQf81g+13blL0VteEUewQnIOHX9JR5X3OiuwgYChXTQYpiKnb0j8GcC3sgAmRTTmvF6SjqAvHt9SrbNlkm/ntyTFNjbbEuK9OYroAwSAJovvwtIyNVUkhDdkCjyISGoYcWRVNRIutLKJRGdIuyzHYHYitUYViwspPORZd4wisj+X8UQQeewkHuRblsLOPSEyZdSPUqwuvp92ylUWD6V2PWB3+eBn2jTs3j6h/VWibnujywwKAX32OQsqS1rd5UbHZx2XxGOkOz4AvsBf/43aNr3z5gcl4MxmtI6DWOa5DCaUcsL9KdmU1clLo8JMt/oh8ahzFBHmE9lEx8up6V7AfD1m25a0CPXO8xv1e+Jl+drMZF/qOQAPXXR4BIJlxNh4uUMjbLqONy3WSX2yPsyT9rt70vIpC0acusKhFaC74N6QncdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wH5J7U/vINHckyGRi6s8jjIUkZAj5QoD55T+G4m5x+fqT5gURDh2ETOAETkpLUuKgKNR/azE795L87Yda5v9C/kdasU7yhODuoqO9XkBP9Mr4h6BHozHOK8MK+W8oRdCCB2WVBFRCqLUniK2jg/nw5PwLX0gsgBcUBkYKcqOf3UXVm+fiZaLbN0QeqYOKKVVG9iC3BGfuD9t0E07nF84TsdZS7chKmbHIll/4u4CrlQvZ5PglWLFsWTCihOhgptw0MkU4T1HC6J9w1N65JYXEzSVWL/fpk7l2VnoJtmcbDCKYkQ8+lerqh7dA1p4gjShpR+6fNGg5xB7Zo7HWi3ayzXdpPOOABcx+jOWWAoVVqPN/EE7FndO9X+V5LwZj+kjZBNWDtOXFLSLojV9PT79dWC3t0MYSRFev+WPOn08bjGIZmdvd9jli1L+K/XQJLyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 16:56:46.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c760942-7f48-4f10-e7c9-08df43396ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

This series includes improvements to the ZynqMP GQSPI driver, covering
unaligned RX buffer handling, controller shutdown during remove,
interrupt and clock handling, and RX FIFO draining in IO mode.

Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
Amit Kumar Mahapatra (1):
      spi: spi-zynqmp-gqspi: Use IO mode if RX buffer is not cache-line aligned

Mohammad Zeeshan (4):
      spi: spi-zynqmp-gqspi: Factor out zynqmp_qspi_disable_hw()
      spi: spi-zynqmp-gqspi: Mask the interrupt before gating clocks on remove
      spi: spi-zynqmp-gqspi: Stop the controller fully on remove
      spi: spi-zynqmp-gqspi: Drain RX FIFO on RXNEMPTY in IO mode

 drivers/spi/spi-zynqmp-gqspi.c | 86 +++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 27 deletions(-)
---
base-commit: 7a043c9d31af627f0689757b29b8aad6155a9376
change-id: 20261114-qspi_14_11-a5bc89a60645

Best regards,
--  
Srikanth Boyapally <srikanth.boyapally@amd.com>

