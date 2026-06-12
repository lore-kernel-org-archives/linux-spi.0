Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022094.outbound.protection.outlook.com [40.107.149.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206925B09D;
	Fri, 12 Jun 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261594; cv=fail; b=I1Or8n9HEW3ake7xiKG08x+tymDNfmevx2xS2tYkH0yo9OIGXHXWoxSZwWdn0gcjE8lUcR5lEqprDjh/UCv8zrMrpmYkG4dfPZhIQeO3qQuqZDAn+9VsXYcVmfHpi2RZvRmTvxAkw7dgNcGPNYU1cdjK14i4t8jqKPuuENfiuwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261594; c=relaxed/simple;
	bh=ZmIlcgIuOZoZIGxXBFHphgAViknnM47xUopn6dJdeas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZCpL6Q7y1gc5EvSmIq5t9c8Agv10CSJMpr5Msci18m4LbCb/egYmRhGGuJnE8xRe0v9ccSqdKV44h7v0g0/04zLPCs5zBF3wxKRJ3VLLJPkKyWX1C/l6icdD+X8MDqhwOcJKNSakCIJge+QsOjiO1uwsth4V2MUlJGzMfz6703w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com; spf=pass smtp.mailfrom=edag.com; dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b=QhNmFVZz; arc=fail smtp.client-ip=40.107.149.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edag.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b="QhNmFVZz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owMOIJBfpRWAut08sy6hWI+Rak1dBz2bC0dF1BHye5BRFhQZGzNdTU3d5UJrT1ipIISST/DwtLoRz6G2NQwBGnoZgNV/AfN3kCPc7/rQyBsAvRh0O/VIEyrSZGRg1F7eAk1l2bOoa5kgJODvQaT404B6mQbkkBSZWpHoJj/CPLMiCqCPyCujdVDBV55yL3LPozAZjrLNDTRCL23PSIjIeiOjU91gkXVimYy82eBjF5hZEvoM5lUpppQ5uVLQVpsH6R3XDs3VeTqWRY2FygEudeOk7V5/gikpi4QZsS75Oj9SwwtM55pd7zQ7j7l7jB9gmz8an1Q1bdJI1Nk2Y+LgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2LE5/VgFMJHiP4Bq9WrUu4QQWR3eSsq4Vr4GP4VbEM=;
 b=J7vlYKbVr7xHK5JiQz+pf9bWasnSiGuKJThl6denTflba5kXIIp2sD82OLjcGaKfGE9UtBTZ521J0smLw3LWexPwCFXGYdwt/XeQoSYf1DD0Kf3/nU/7+qR6XHSKjMc3Gm7vrMf9l3W0F6eJVK3efS8pTxqD3561IN4oZAn1TJEd44ShCuMvV6hYV51lKeP9tJmGr8r5Et/9/GaiyihZc1d9iZCQKh1ZhysuSyJgGt7sR93Vb8FcO7dNe5dgS38ta/w1QgBXBR+UmIdEE49ujmdF99RCfavH6nLbgj6sF4ALT5jSsB996460aQstpIP79oz3Q9ytlLbYp8VxqpWULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.141.91.64) smtp.rcpttodomain=amd.com smtp.mailfrom=edag.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=edag.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edag.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2LE5/VgFMJHiP4Bq9WrUu4QQWR3eSsq4Vr4GP4VbEM=;
 b=QhNmFVZzwnhBR/zrNICb/OG3CRzILtq3NvhcNDlKBuN9SJbTzafAiEGZRUsKDklqJnbr9xowKCqFParZN1ydJG5O09tSbr0IfvOBKgfJLJacbGn7j/OsUKOzkAKC31Xl5OGH4EVEZSTorEGjv/EIb14so6E6+brm+1zL9K1DfoX+eW75QhJP24zSE1B9G3VUialZfJdiBLNkUNEl20LR56ISJQgLzhCrHGDX0NB/Vei1C9OrFKNw+p+eCyr0nRQAUr+9HPcIpGWnbMksuPYoOM9ynYaFW3YsghGDHtYTunFsC7Py06NTMhfWCYXOmicRX6XyTX/CILcFeFQy/Enk4w==
Received: from BE1P281CA0416.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:83::20)
 by BE3P281MB5547.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 10:53:06 +0000
Received: from BE1PEPF0000056D.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83:cafe::9f) by BE1P281CA0416.outlook.office365.com
 (2603:10a6:b10:83::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 12
 Jun 2026 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.141.91.64)
 smtp.mailfrom=edag.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=edag.com;
Received-SPF: Pass (protection.outlook.com: domain of edag.com designates
 193.141.91.64 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.141.91.64; helo=mxexo01.edag.com; pr=C
Received: from mxexo01.edag.com (193.141.91.64) by
 BE1PEPF0000056D.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Fri, 12 Jun 2026 10:53:06 +0000
Received: from lnx06-mail0602.edag.de (lnx06-mail0602.edag.de [10.82.17.140])
	by mxexo01.edag.com (Postfix) with ESMTPS id 6B6A5140073;
	Fri, 12 Jun 2026 12:53:06 +0200 (CEST)
Received: from x06-sysimap01.edag.de (x06-sysimap01.edag.de [10.82.18.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by lnx06-mail0602.edag.de (Postfix) with ESMTPS id 55EA019F526;
	Fri, 12 Jun 2026 12:53:06 +0200 (CEST)
Received: from edag-wuerfel.fritz.box (dhcp-10-102-7-76.edag.de [10.102.7.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by x06-sysimap01.edag.de (Postfix) with ESMTPSA id 1016C1C004C;
	Fri, 12 Jun 2026 12:53:06 +0200 (CEST)
From: lars.poeschel.linux@edag.com
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mahapatra,
	Amit Kumar <amit.kumar-mahapatra@amd.com>,
	=?UTF-8?q?Lars=20P=C3=B6schel?= <lars.poeschel@edag.com>
Subject: [PATCH v2] spi: xilinx: use FIFO occupancy register to determine buffer size
Date: Fri, 12 Jun 2026 12:52:44 +0200
Message-Id: <20260612105244.9076-1-lars.poeschel.linux@edag.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1PEPF0000056D:EE_|BE3P281MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: b4781ecc-f6f4-4bb2-da93-08dec870c8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|61400799027|82310400026|11063799006|56012099006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UWaqTP7q8QaqQTIhBeo0oMvGGZVTScFfPQc4OnmrHIcaW2bUx43+/O2O0SKfm4zldTztNfkcBj7wRZPTlJ5moxesa5sMB8WWAPJcD2hXU2gFaKeihFHuyoEkW9vmO0xrsezdaqqJMrRGR/rwb7xfjycWSd+rMBVhn8346KcJUBcs5L8+eHHylT4ha/hAU4DENaLeskgzEyETE1f+lsnIBUie8FVAAFdH4UKyHgEGODTKCUivShVSMOCY9PzeXqkiUVzo2f1X72vS4mH0NBTZzPq9eE9/74sKEKxjhYqPZwp4sJTfqsTat/eBpZBHfYnc7h2XPbwx96qZanh/Gwi8fzqXHju6bsGpkixEH0aX2GcbpjCD8PPT7qyvhbQ0ad72Y6Up2RCtuGlYFe3abap6OX+EQECxhz69G4f7pNjbK5H22uuuA76fJw29kPyzA73/Ng+lBSVoYoad2BlZsFLctjKs0MU3vTZLYs+mKwoHBRc571ezjY6BIgzBoRISOYT1Tr9KTRldlH9L/9dYGxM8SzAb1LcMr/2nUU+UiHYrheaid+QDh+SJbOAqm419PySo3t//9kX3Ehc3X1s4sgj8w7AZ3qGQlAtgyO89wml5p0YBYzngwEc6PbpSeI9J18Tw3AjWaDWxwUdmxII4tl8Ls8ZmyfG7Gxe7XWOOBgEJijMvUhDOdbi+GjBsEaTZ055a9RTu3FYLe4SvztCaVu+kuqW/bJezvSff7NT6ZHniY4c=
X-Forefront-Antispam-Report:
	CIP:193.141.91.64;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mxexo01.edag.com;PTR:mxexo01.edag.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(61400799027)(82310400026)(11063799006)(56012099006)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d34VGSUaH1nZVADUBtvLW6OAkFRnrmfgDIIiW1TQ4EbzzSDKg7eVOz1CkNwylfi/FjlZ/MOdHQrHc6D1KFVMA12JcvZvWo0TgeMEYM29Emv32NyBYq95Sy2/edIoZMnuyOiCwHUIsef/0ldnT7c/8UpzbyVa5u9fGqBuWOK+P3pJ4Kq1qbMF5n7noy/ZMq0mn3miPWjZZtkvUJhL+qP6IjzgRISX19yISy49s2vb6xO09aiGEs6ta3lfXRTOPmUnhW87kRcZiiaTiyf6r77iVOJ0r1jpIc5TqA5VIUzsmJfdUk+ZcxvEkJY+/90oe+YXctn52d3vltlIcgH5cCbwKRj+Gy/idkfJl1rriv9bVoyRp/UcF8+VNv8gDw8SEBf3CITAQME84P5WBDuz9Z35oAKBlks7KWwVq4ovOVZtMda7hjqnDqm/Ja59E7pKL59f
X-OriginatorOrg: edag.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:53:06.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4781ecc-f6f4-4bb2-da93-08dec870c8fc
X-MS-Exchange-CrossTenant-Id: 4812a7f3-cbc9-4f88-b59f-87b73b966886
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4812a7f3-cbc9-4f88-b59f-87b73b966886;Ip=[193.141.91.64];Helo=[mxexo01.edag.com]
X-MS-Exchange-CrossTenant-AuthSource: BE1PEPF0000056D.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5547

From: Lars Pöschel <lars.poeschel@edag.com>

The method the driver uses to determine the size of the FIFO has a
problem. What it currently does is this:
It stops the SPI hardware and writes to the TX FIFO register until TX
FIFO FULL asserts in the status register. But the hardware does not only
have the FIFO, it also has a shift register which can hold a byte. This
can be seen, when writing a byte to the FIFO (while the SPI hardware is
stopped,) the TX FIFO EMPTY is still empty. So, if we have a FIFO size
of 16 for example, the current method returns a 17.
This is a problem, at least when using the driver in irq mode. The same
size determined for the TX FIFO is also assumed for the RX FIFO. When a
SPI transaction wants to write the amount of the FIFO size or more
bytes, the following happens, for example with 16 bytes FIFO size:
The driver stops the SPI hardware and writes 17 bytes to the TX FIFO and
starts the SPI hardware and goes sleep.
The hardware then shifts out 17 bytes (FIFO + shift register) and
simultaneously reads bytes into the RX FIFO, but it only has 16 places,
so it looses one byte. Then TX FIFO empty asserts, wakes the driver
again, which has a fast path and reads 16 bytes from the RX FIFO, but
before reading the last 17th byte (which is lost) it does this:

	sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
	if (!(sr & XSPI_SR_RX_EMPTY_MASK)) {
		xilinx_spi_rx(xspi);
		rx_words--;
	}

It reads the status register and checks if the RX FIFO is not empty.
But it is empty in our case. So this check spins in a while loop
forever locking the driver.

This patch fixes the logic to determine the FIFO size.

Fixes: 4c9a761402d7 ("spi/xilinx: Simplify spi_fill_tx_fifo")
Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
---
 drivers/spi/spi-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 9f065d4e27d1..b95485710e2f 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -371,11 +371,18 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
 		xspi->regs + XIPIF_V123B_RESETR_OFFSET);
 
 	/* Fill the Tx FIFO with as many words as possible */
-	do {
+	while (1) {
 		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
 		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
+		if (sr & XSPI_SR_TX_FULL_MASK)
+			break;
+
 		n_words++;
-	} while (!(sr & XSPI_SR_TX_FULL_MASK));
+	}
+
+	/* Handle the NO FIFO case separately */
+	if (!n_words)
+		return 1;
 
 	return n_words;
 }
-- 
2.34.1

