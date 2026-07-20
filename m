Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8A41B8D2;
	Mon, 20 Jul 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552136; cv=fail; b=Rgz9jrMzOqQBbi7m1bxeWMBzQcLJJyUKIh4VkFKnSd5OawUm4UVamdLXUnYV6po+FfTtbbzV4stWg4fuFM6p1LPP0UyaT6VZJO2X66QKgY/1xjHq1bNHFMGTfH2aqRzyrHC0xzwgQsJiiqfFtL2/RD+WxB49OH3MwMWuQolYmQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552136; c=relaxed/simple;
	bh=ECPd1K33R8uYQbVXAJ7u3DWqLVFwuvuwtGbxhslrM3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dGrxYpldXGgCzL523ja/2KVutLoA1MVS2YB2oigHjL052go86j72aUpQyR9ZfZGPnhLGSYlSs0FJlT16V4xAC4afMWT24x4f9UppO3aPvtnonDVVOtmtcnlW9xpBWo+xTvlIexH2HCtk1zv35kZLmdaFuteIuWZi7uWGQn7PErk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WaW6B8/y; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WaW6B8/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZne9PFDOdQUZUaIxuMx1fbJXaA7/zBzM0OdmTB2So0b3IPfR+jNW3Fyj5WNrx2VWkeNN93ez25RCfLJNubM7+7xW3piFQiQrUglZEHjWulli2zKDqy8XT5Dp6fZPyUc2ZO82xUei5y8gFLssbl69GuXZ11IBDXINaWZIQ5ve3JIqR4+DU2ZsO4hlY9uv+dvfSSAReDFoWNpZw3CMLiHMfAlPyq9PLECplJvT2JdXeNu5C14EXojfNNHAaMvPvshcEiXbS0w6tqOT6OWWI8Loxug/1Pk9tJzEzSmN/q8u2E8DKo8hjW2L1/S1s7I8mi8CUc8nirI9bGX7ohAzF7V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cRSYOYHb9cVxop4QR9Wk4ufCWRtSNeQWqCKL/Ca8iI=;
 b=F+QVeyA0t0GOmj6yRplDlX/IT4LNBOvcOde5Ua5R782cBklvX4cEZEz9LuT4OzEuIYF4E/UhgGVEhNAYceE4F6yw3EXWpcqeBQl0EkNtQokx8FnHLFE4Fo5Z0NYVyV1UFf/TnvqUK8BnOuWWnP/JzewBjqvvrtsJF+KK4Z939+5qtHrbU6vLhT7z8TdKZG482SZUDNzIfTkA/wz8X9qG/NKL5jOcbVnz/cDwbTb3z/ys2Hr0taozksUhIUL0FQqaE6M8GLrOafjunr7YAUTyeUzaCQ0voCNl62AFzd8d1fAic781KIPoTSapVgpOd/K0q+iyM8D6JWRx4fxKVGy1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cRSYOYHb9cVxop4QR9Wk4ufCWRtSNeQWqCKL/Ca8iI=;
 b=WaW6B8/yjS4OoK7G+LdGWYDaPvT4kTiFE57B1Bav7+FcQmVZa6C/0N7QyTwaZASn0enJ370FMFDbK/FLrUxyExIAkoqsgZetnUbAHuW5XLei41Xh8U4vBjiyrePlf+rF5kywjkM3Yz3P8IVL3YKSNQVO4cYkpdHbzDxU9kCo6ug=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 12:55:28 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::85) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 12:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 12:55:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 07:55:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 07:55:27 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 07:55:25 -0500
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: Mark Brown <broonie@kernel.org>
CC: sxauwsk <sxauwsk@163.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Srikanth Boyapally
	<srikanth.boyapally@amd.com>
Subject: [PATCH] spi: spi-cadence: Move TX FIFO full busy-wait into FIFO
Date: Mon, 20 Jul 2026 18:25:10 +0530
Message-ID: <20260720125510.60166-1-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: f155175e-965c-4e66-645f-08dee65e2cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	bTzjr5zeJZMgUnxP7GPqdVef4rKvoIbi8gJxNrKgaZywMKnDy1RxsP/QU4ZOGFBkwIO0u/kaKUK29BR3oyeHVBCKbRURJ6mxmieuI2o3+wC7Y5p9LEx9vu4u3gRL9qKNomuR6WcnHjK2MeVPgie5wORZidUDT5U6IcXsmGPDiPxFikCFSRAY2WvLxMfR9rdyESokZn6XFdmrh3dirCCfwip27f7Zw4Bq2xJqt9nFsyhUGS8z+xwePXY3/Yxmga7C7zD8qxiocZ1TFrhD4nGH5zXGsrEbGLguoL3OkZ7Wtp3oNI5fuB63MemZ81AFCAEac+Y2du9ty9PK54nJHvRQavLR3IR/OVCi2Uqo0hi1y0G6vKqtKDy6ir1TA9pZrwpppO1iAdVYcbvHR/HvrhuRYzyPzbFsV+Io653DR/qALyBRvP3duZvX/OWrE/PMFe8GGq/XKJwwHLaR8jootzz+jmi4ginIFJvXOR/abcPa72SYmTXYvIFzTyNvjLqJ/Pdm5ODnRGTAdifMRlsj/nz8bo/EZ3XVX50/d4u3xzUeYUCQEWSEuPbQebmiLslaipPrFKb1lUNdtGHBxZU/90rBvib8JPWJyuPOHudYsWGb5BM9UqI9xWZ5HYohJGlikFYuj7AdSjbdT/Ia0J2tu4pEaOHioscnyzlt6dh7GySuQCXdYFyeailMbFaltv1NAnZ7Ompad6sPk4g1kDe1dlb0aA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oqRHjgRWWya4ErkoBsiZbdobFfpDbyGgsTBf4kA+qyCTt4QUs3O6slRYglQ3dYOEfoX2PWyuAv6G18hL0rHKCBwhgPJ23y7KB0N9fI+MGbykhKFIQEmAKxU/Pil04vRgIp0ezqkJl0D4UeKbSgpEtJx8Zi1mRSnYNqut1yFe2RHLQuAqvtH/Mmww/8pHG5ZxKIY5UG6Mf4Ce829Pk5Jf4IDY04mbhTJ0vmRwzfzgoX0yZQqloF9zNuX96VT1lEQKtPd0dw27FUV3bLi0T/19Q+OCAbJDbP2ZmpS5QAYViHzj7462L+U8AF+yqTaT8Gf+a/uahCHla1QGW6CvBlA4baDqKDhaVqaiWvxpTGLbnzR2llvAaK2itPIYodEy5hv1IOKB4nf2j/B1apmAYUuq1WKgcCzSDU6pnw+++T1+p6ysqm+V6kdLkxzMtan/e8sj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:55:28.4543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f155175e-965c-4e66-645f-08dee65e2cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

SPI host transfers could intermittently stall with spi_transfer timeouts.
The TXFULL condition was checked only once in cdns_transfer_one() before
cdns_spi_process_fifo(), so if the FIFO became full again during refill,
writes could be dropped and the transfer would never complete.

Move the TXFULL busy-wait into the TX path of cdns_spi_process_fifo() so
the 10µs back-off is applied per FIFO entry during filling, ensuring
forward progress and eliminating spurious timeouts.

Restrict the delay to host mode using spi_controller_is_target(), the
controller is passed into cdns_spi_process_fifo() so the check is made at
the point of use. In target mode this delay must not run as it causes the
target to miss its transfer window and corrupt data.

Fixes: 49530e641178 ("spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()")
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
Note: checkpatch suggests usleep_range() over udelay(), but this code
      runs in interrupt context where sleeping is not allowed, so udelay() is
      intentional.
---
 drivers/spi/spi-cadence.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 9b4e5b7013ae..af1a05e78492 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -388,11 +388,13 @@ static inline void cdns_spi_writer(struct cdns_spi *xspi)
 
 /**
  * cdns_spi_process_fifo - Fills the TX FIFO, and drain the RX FIFO
+ * @ctlr:	Pointer to the spi_controller structure
  * @xspi:	Pointer to the cdns_spi structure
  * @ntx:	Number of bytes to pack into the TX FIFO
  * @nrx:	Number of bytes to drain from the RX FIFO
  */
-static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
+static void cdns_spi_process_fifo(struct spi_controller *ctlr,
+				  struct cdns_spi *xspi, int ntx, int nrx)
 {
 	ntx = clamp(ntx, 0, xspi->tx_bytes);
 	nrx = clamp(nrx, 0, xspi->rx_bytes);
@@ -407,6 +409,16 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 		}
 
 		if (ntx) {
+			/* When xspi in busy condition, bytes may send failed,
+			 * then spi control didn't work thoroughly, add one byte
+			 * delay. Only in host mode; in target mode this delay
+			 * causes data corruption as the target fails to prepare
+			 * data in time.
+			 */
+			if (!spi_controller_is_target(ctlr) &&
+			    (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL))
+				udelay(10);
+
 			cdns_spi_writer(xspi);
 			ntx--;
 		}
@@ -460,14 +472,14 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
 
 		if (xspi->tx_bytes) {
-			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
+			cdns_spi_process_fifo(ctlr, xspi, trans_cnt, trans_cnt);
 		} else {
 			/* Fixed delay due to controller limitation with
 			 * RX_NEMPTY incorrect status
 			 * Xilinx AR:65885 contains more details
 			 */
 			udelay(10);
-			cdns_spi_process_fifo(xspi, 0, trans_cnt);
+			cdns_spi_process_fifo(ctlr, xspi, 0, trans_cnt);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
 			spi_finalize_current_transfer(ctlr);
@@ -520,17 +532,11 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 	}
 
-	/* When xspi in busy condition, bytes may send failed,
-	 * then spi control didn't work thoroughly, add one byte delay
-	 */
-	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
-		udelay(10);
-
 	xspi->n_bytes = cdns_spi_n_bytes(transfer);
 	xspi->tx_bytes = DIV_ROUND_UP(xspi->tx_bytes, xspi->n_bytes);
 	xspi->rx_bytes = DIV_ROUND_UP(xspi->rx_bytes, xspi->n_bytes);
 
-	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
+	cdns_spi_process_fifo(ctlr, xspi, xspi->tx_fifo_depth, 0);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
-- 
2.34.1

