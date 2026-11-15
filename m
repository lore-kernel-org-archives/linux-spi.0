Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761821;
	b=4oc21CKqSmWQQUuXirwDXNPCWU4yoc3xTTBW8fYVMk+J1auGZknZ51y4FIghqrtK2KRB
	 t2/EcjUc+lGJRdZNm4nX4FexBn6CTD7KBWCTuqILnum4E97hkL8NIHqe1HTyCKTtGc+tp
	 wvqCUi8UVpaEuNt809QYPWZkpX/hYmLUaGB31ueMOy9alKDYHpxfkTLTWjrsBV2bbnvTU
	 U9rHfw8N1bt0RbnAAU+NXmDhUzkkFe8gSHbT2JfoiBLcdz7vYtlXH6bzNgz5or8+vblr9
	 +g+3KGKM6zHLFjMHLXurObpqVeknib0ePqWuHCenrXj9pZhRT1Z/zo/dapY+R6PpZzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761821;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
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
	bh=HmeQbw7jMfLA/ETtC5sTdn/ENgWCTOOgdRGlwupEjEw=;
	b=dS+dJBI776Bh4MlQrmq8m2763L3E7SLiJvuUGxI/UoZv5ttUeht2qb/nexR+rIue4cvQ
	 942n9Y9ROn+T0748PFRZTdgRwUKmVelFfGJaB7QA2a/SVg518piOc6B4z9a6YeEr0wWbD
	 L1uPImzH4qF3rmwtZ77EzLuQfJIaOgu/BFMtQgwbK6JYKkm8Xq+9BdS9dYvbsPahGFra7
	 /MdAcbdl2Jb8Z+/MVTw6PK6vNipVHkcynYbrHvIQFRQyFBV8boW9r3wm7AEBEdcm5pqp6
	 1MCKJYWP2thYj7p5CduUD1YZNxrIgQnJ+nfNCxsp0Vc9hme5fCwSQvD+fGQdHhZyN1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0TueWoRo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CB606A32D;
	Sun, 15 Nov 2026 16:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1CB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0TueWoRo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfSyIJfqcQKs0/OCiILRXbATcOxd7fcL7v3SswQZU29lvA1Wy53lsv+Giuh6vwbId3U+Gvo//pmMeGm6Q5stYxrOLicz+2PoE8bhbtGic/Rk5lh9zD0U6ImUjZN6CWaeMAbmT47Q4pFfBXuLY4zZXYOqVHFkSiyJVEf2iOItLi1NP4tmiKqNS6aCh45PJ/WBUnJZOkRV9xHTVy5UDwIVC3+Drq/u2KKHYVsp6vbiNFwiLEYdGd3AT4fKR8GRNyx4ohw3Vm7UBJvAFSYxb/rHVlL98I1QDVa9o7QR5qlMtDEuoh6G5xRFgfq0v3lt4IprFOiItDXqAJSo0kh+M3Tk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmeQbw7jMfLA/ETtC5sTdn/ENgWCTOOgdRGlwupEjEw=;
 b=WMIAQilKdRQW9AuGPItDIlF8RhyJYB2pKn8+l+77uYN6EDiVTiRoKC7RskoxBcEpQiwZW8A+cDyeQJ2azw+tHyCCOy/M2MnU73mFY26u0XCZH/3RHtzsGf9b1CnY3njXCbWNHjp3OY8gimH2aeqDSRm40kCix//6kY/2617TRti2nLPnATb7I0XpJW+WdiZ0aEIEsSf3+/d8cZ/iiu/NOZfGmDd+VLNrK4IxMQOfHoD6tTBMZqAxPByFXhHVlwuKz3iEZHdy8kHVx/DNnDhL4Ey2G5tprkuq835jd0sJzYoxXEKwwofYgisbLh/M3S+aaxQoyjAWBq3QtUTxXyzYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmeQbw7jMfLA/ETtC5sTdn/ENgWCTOOgdRGlwupEjEw=;
 b=0TueWoRoO5d06ziAJg/+1I0tCCIdAj2TwZQ8wHRk9TzVGGGBbMlNBhgzcu6iaWlGYy91b5qYc6HoOhVDwTQ4desSXJ1XosY4rTwyKL1w7rVykFDDX2zqAtUsOu7zllvrJWqOBB7PgZxdB4SAgdjuJjkgS/jfVPWfOl3K4Y2rVIA=
Received: from PH7P220CA0152.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::10)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 16:56:56 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::18) by PH7P220CA0152.outlook.office365.com
 (2603:10b6:510:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 16:56:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 16:56:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:54 -0600
Received: from xhdsboyapal40x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 10:56:52 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Sun, 15 Nov 2026 22:26:43 +0530
Subject: [PATCH 4/5] spi: spi-zynqmp-gqspi: Drain RX FIFO on RXNEMPTY in IO
 mode
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
Message-ID: <20261115-qspi_14_11-v1-4-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
In-Reply-To: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
To: <michal.simek@amd.com>, <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761802; l=2587;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=+QQsPESySobSuHhTeWHnq+TR+Guw33o1WGBUJSE3i4M=;
 b=nc3ON6bymKpivLqgFe7rvcedbN4MlnNQzTo0owL/qYCP7gTRXVKAAWfWntXwja2kIuobxoLTf
 O5hzAN+gNAyCKrgrZGHm6BJ6YBpHKA/9//h7ANpQ72Icmyep9y0gisy
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: c21fa6b2-8846-43d7-002c-08df43397493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+YcyzsHt3fx2c6qq72HzZpR1PVPnZijHOBtdDmQ8UuTH0aIhHtReI4ffVt/9X/HZC5U2MBK5cp/0Z3dLGUgynxEtVH8mH+1hLktXAUfoa4PZmcOwQJ9bNwsf5fO9wo7kkk5UhBOH/GsCj4cltUkqbgj+9lVXPOWy9QY0inFDfJ6t/AB5OFiCX50bgpE+uuu/VP3pkQTGxZR674RdOosR8661YHH0Xc2oZpvpiO7zCtDS75rIDNmkU5+xTUcywKFfZ9BuPC9bzhcBF4NRNXGi/B80H4s+TWZfubMqrYMcyvoGjJPYsVwQDggpvYna+kAkAb2gcG7snX3o0C04U6l0iIENb5nPFOQwPXPNAqoHQgmxFhRYNK8+spZUUDGq+Uhii5XO29VFxv3XjmWl/kznM61ZiOOnhIhFT2tQDUmCMM9uc512NkS7abex64Jicag+MBVvZHs/QBp8A7IzUU8/kMGE/jiY1AZHuSXUWpS6aio8t+MF7jK2fJtpJ31ar7+z1cdEQEmR2cj8VS/PZUBSVYyrXfjZARIRnlnuk42CLSdMJ3SalXEaOV0eaFrEgq7AdY4fxXKtF8roeA/VKA6vqN90zedk65l6mxu5yC4qmZK8NcJSHPMRpp50Y+lf/HGlnqqakYDKE1JENAYW/0sjMJP1lzxd0x34nGMdU5udaMNTAqcyvV4ygx0jUbpsFym9QTwvE41Hu0dDB/mbqstoWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xg0xRtkfyXqE+JRhUcQJDpC9PCQ9dOjnk749EtPUBv4JEnMebkKApzxxZ/ysEXqmDU3k10dyv39nFadi4u8mKIF+epygULZO2sU8jP0XJIsYPnQrxvtI62N4IS3lpmOHEEhuwxI5qd/VXLofvqO9uXFzWIq8yWPaCalf0iyiAnqA3vW2q+sDoAXW69MmONg6HSorIprOjXDbpS0QNtek4P/0niD94OJ1Ev/duC7Ksq3TwFL+C8Tc3VrRrkEu6G/IDmhoC/JlPpn2pE9XSQ1Vyq+CNxybbyq/wS5OAV7AnJcvNWGa6CvyXHcudMBs4wZHxE4/JlUSiTSiMdy3j5tb7SGkCtKHtAvN3rcBsT6N0MHs8VmlexABaVq3qamoEiYArO4uX/8zU9H/cin5JYk386pRbFvvaIR19vk3IA8UFmFNCSiN/F2WVFeyKkJEeXpz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 16:56:55.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21fa6b2-8846-43d7-002c-08df43397493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

From: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>

In IO mode the IRQ handler drains the RX FIFO only when GENFIFOEMPTY
is set. IO mode is used for a read shorter than 8 bytes, and for any
read whose buffer is not 4-byte aligned. The unaligned case uses IO
mode for the whole transfer, so the length can exceed the RX FIFO.
Once the FIFO is full the controller stops clocking, pending GENFIFO
commands do not complete, GENFIFOEMPTY never arrives, and the transfer
times out with "Chip select timed out".

RXNEMPTY is already enabled for those transfers and signals that RX
data is ready. Drain the FIFO on that interrupt as well, so the
controller keeps clocking and the transfer can finish.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Signed-off-by: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 39f90fc3f453..28edc5e82c16 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -810,9 +810,10 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
  * @irq:	IRQ number
  * @dev_id:	Pointer to the xqspi structure
  *
- * This function handles TX empty only.
+ * This function handles TX empty, and RXNEMPTY in IO mode.
  * On TX empty interrupt this function reads the received data from RX FIFO
  * and fills the TX FIFO if there is any data remaining to be transferred.
+ * On RXNEMPTY in IO mode, read up to GQSPI_RX_FIFO_FILL bytes from the RX FIFO.
  *
  * Return:	IRQ_HANDLED when interrupt is handled
  *		IRQ_NONE otherwise.
@@ -840,11 +841,14 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 	if (mask & GQSPI_ISR_TXNOT_FULL_MASK)
 		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
 
-	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK)
+	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
 		zynqmp_process_dma_irq(xqspi);
-	else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
-			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
+	} else if ((mask & GQSPI_IER_RXNEMPTY_MASK) ||
+		   (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
+		    (mask & GQSPI_IER_GENFIFOEMPTY_MASK))) {
+		/* Drain on RXNEMPTY for IO-mode transfers > GQSPI_RX_FIFO_FILL. */
 		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
+	}
 
 	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
 	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {

-- 
2.43.0

