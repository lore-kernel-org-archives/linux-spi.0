Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020130.outbound.protection.outlook.com [52.101.169.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62E37CD2F;
	Thu, 11 Jun 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161882; cv=fail; b=hG1I/cRpdBb9nu8l15QI8N+5WJ2bleSyYE9iYqHEqNaJX1ZgmSe1wfPKSDeGz6VDO5kEs8VPuXmM48PzZQfLdMFnMYK4arkrB8dzaez3zrVyTVBcgQ40WNgg/VENc5zPU0LUQEeVdxie/LdYCCelpze7DGWgQ9v6tSna5w/Jh5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161882; c=relaxed/simple;
	bh=6AwlHQYXRxegWopR7WFj5WnrYZlrdyMemXxFNEIb1LI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ly1R8ENyfZ5SYB/s1fjCgYBAYF85pd5FYXO4EOvXSAUj9EX+PakEO6194O6YOer5Pf3l2WkQxc1aGVH+Qg9uzZmbgvM22mZD7BHn+250YOrwc20BlVNOQYw7kQPgHwy3OyNcMR1GhYXK5vbnYd0X7aeKfNk6/Z4DKAUzgCVGYBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com; spf=pass smtp.mailfrom=edag.com; dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b=Xpypjl+x; arc=fail smtp.client-ip=52.101.169.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edag.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b="Xpypjl+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shjPgbqywWCnbsuaWi1TeLQfy8BKmKgqEcmt0eG8KfmCfSAZ+mn15v1NT4oCEwNkSDC9Q3v6PMFCObknRJ5VWaoNYcLLjZ6719gHu895euExph6Ixx5bIE2wjG5oscDiDk4ByRN4p4+NhdhkeNM/8aB2xm2sxcBQCg5ntutiDjR3xayaIzroVz6RYgaDqeHnKQOMIaaG0a7zRPOQQeiMtEG+paa7VKjkvbYbOuwvcV1K4hpwCSq+DDdB5Uf3UBzPi/9/UNT7uvCTURvDcVM57u/o648QULeOsDU28EgDvkXC2j9pjCKl1RFCCKUcynQbA87L59oTZ4SLqtMs8QUqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fiOVMt2v4g9GrLIKlOli4aHoq8JKi9WnEm6yRPpkDA=;
 b=ZvgxzA6f3Y/3yla2iyJXQ/hL8eqQ83CwsVKtFm8GoOlErLnvc1w5vBSVH90ivj1kpymwfDozxBxfn10Q4BTBYKDLBbhKGC2IdJTEsM3I7JTpPwn4dPK2LPwMglKcP+pN1kMv8ZGSKN1Py+yv4EBwhcgKR2VMtIcWpF2bBdzXmcnzJYE7wHAATcVZDVHdfUNvo7xAHJcii2dTfmT5XdO15yeSa9YwWyexV/obL7G8hDbtbLsrxE7kO4L0+I792jrkYvV9REFEySVV5Of6/rHCulSMDknIW3mphb5XzWrGYtYatnPtoHydtuSR3MpT6JAeFqmtg24RfkryE8J3CqfF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.141.91.64) smtp.rcpttodomain=amd.com smtp.mailfrom=edag.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=edag.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edag.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fiOVMt2v4g9GrLIKlOli4aHoq8JKi9WnEm6yRPpkDA=;
 b=Xpypjl+xIICeyAV0KBgR/zemk8IksdwwLEZojZKo9sfLwIpWXC9/cyYD4wtA0Ccpiv+eIBRx7ZH78uqny/S36zIGnUfniGW2nbhZCeZw+FrRwvw+iBPETjNm76MZ849u47Em9pDTpHoup2bcdeKZEeyOFBSXoIgfFxgLB51iZ4vpkFpQIfcPq4JMDMfa0CJjV618hGh4XAKWdQpSAq5XtTMpc+9rJC3Btu0vxLRMXmnElrCJ+tRElMX/oP0M8b3tSfR18a1Uw1LeUfvZkZgaOAvNpL+C2JkLEonwkXGJo2MwNZ0/TlVzObSEArp7NELJbvJ9Vmbgeb+KD5G5aP4N5w==
Received: from BE1P281CA0238.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:8c::11)
 by FRYP281MB0127.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.18; Thu, 11 Jun 2026 07:11:13 +0000
Received: from BE1PEPF0000056D.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c:cafe::6e) by BE1P281CA0238.outlook.office365.com
 (2603:10a6:b10:8c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 07:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.141.91.64)
 smtp.mailfrom=edag.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=edag.com;
Received-SPF: Pass (protection.outlook.com: domain of edag.com designates
 193.141.91.64 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.141.91.64; helo=mxexo01.edag.com; pr=C
Received: from mxexo01.edag.com (193.141.91.64) by
 BE1PEPF0000056D.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 07:11:13 +0000
Received: from lnx06-mail0602.edag.de (smtp.edag.de [10.82.17.140])
	by mxexo01.edag.com (Postfix) with ESMTPS id 45FE4140061;
	Thu, 11 Jun 2026 09:11:13 +0200 (CEST)
Received: from x06-sysimap01.edag.de (x06-sysimap01.edag.de [10.82.18.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by lnx06-mail0602.edag.de (Postfix) with ESMTPS id 3726319F3C7;
	Thu, 11 Jun 2026 09:11:13 +0200 (CEST)
Received: from edag-wuerfel.fritz.box (dhcp-10-102-10-49.edag.de [10.102.10.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by x06-sysimap01.edag.de (Postfix) with ESMTPSA id 0066A1C004C;
	Thu, 11 Jun 2026 09:11:12 +0200 (CEST)
From: lars.poeschel.linux@edag.com
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Lars=20P=C3=B6schel?= <lars.poeschel@edag.com>
Subject: [PATCH] spi: xilinx: use FIFO occupancy register to determine buffer size
Date: Thu, 11 Jun 2026 09:10:33 +0200
Message-Id: <20260611071033.1937983-1-lars.poeschel.linux@edag.com>
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
X-MS-TrafficTypeDiagnostic: BE1PEPF0000056D:EE_|FRYP281MB0127:EE_
X-MS-Office365-Filtering-Correlation-Id: beebeeb7-b5dd-4e2f-8988-08dec7889f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|23010399003|36860700016|376014|16102099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	da2xO1avTpWmMKFks6pfgDq1yksXyNE32U3Ts4XmccIW7J4fsNiVVxwcutMuU+2TvSS8KOmS5kiH0ZrbOgxHcThYBB8OwNT9e3ULv58cO7VmPx/bPkyVqZH1EkTNZ5mudKb4XoGIu8f5UnzL2WjOPujQbM70Hp8JE7xTpgLU3r2BBBntt6Bf5F8jaGVjuRr8kVJ4qF2ZRWohDkngDW7nnEixiwQeEXw3rqa7QChrCi1m0xAD4MkKQ62ofI6FhpgvWau/Ip/XIeQuaLInuQ4V2CQ7FOcDOYwRttc20kZI1E/BGbMGV1pJr5fgmzgFk8piYSKx+v2mPmnBIumtjlCx7pcW+kkfYsLLPMIHXX3WDmtXTTarzeir+bU3eGj5fgXUy5Zr23yX3o7EHyUh+KPH0rv0wGgDeE4Uvu2sxJDttnmLxTkh/HIWx9nfSn4U7D3YAWi9TCKGQfgWJKOmhi+T+jJQMm4NOVAoXKXjp8vJLenmjP+oRjAp6QRRcim7gYaj1qUkFiQiLLSK4v7K9+wo9Fbuj496SQkV9Q9uTNtFDS+OueLmU1h9H9HfQp3G4SrQx7Ty++0hcnEw2NXccJHEhj06cTrkBcJZr0wxuxornuiRnhoiPuLFLzSA14isuf9ueiofcNO1Fn7kTAuB4g7qCsbMD738TzoR3u9bLY6sBlA+lXQu0XoMSug52ZjHZAqSsvYzGdp2KwcZrFrCZaBUSBk3FeNe/OTDC/hLzkySMbM=
X-Forefront-Antispam-Report:
	CIP:193.141.91.64;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mxexo01.edag.com;PTR:mxexo01.edag.com;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(23010399003)(36860700016)(376014)(16102099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rsfNZoUEIIGfJM6oHB0rJ58qCJ0ynZRknNBJoTenAKOe5XCYKXbWanZ1IoDB/U0gsMF63d8pb1YLr9RK0szKjcwp2E+DrAmaTo+6B6Q2EfC3SmQkqgC5AM41UFeS6/vuL9HyVEEPUpsOFURjyZHG2Di/ySKOLKzSFhs5go+8NMn/DJF52VmGX4jbu79JWjsg7M7ietGFcQus2ShfSf5/rij1AlHrdOZGQU2jbJdBI3uFe+Ln3sGa3quIXfAVgEV8sQNuoK7TalL2j0irUjEsSfVW4yT9ilRYZ+HaWNIweGJFfXO0hdMRT0VrZxLwH8mu5EEoMwAoMnMuFnFHLhJ6SfJeZeIu1Veu0p1f4agRpM/QdYLRJ2o3P+quW+6jyd7tYzem+YwKysiZo340JY8sn4XHmTDzzzIUdDAX0liHsiUOqlFEO93T/+PBrF9QgKRU
X-OriginatorOrg: edag.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:11:13.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beebeeb7-b5dd-4e2f-8988-08dec7889f59
X-MS-Exchange-CrossTenant-Id: 4812a7f3-cbc9-4f88-b59f-87b73b966886
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4812a7f3-cbc9-4f88-b59f-87b73b966886;Ip=[193.141.91.64];Helo=[mxexo01.edag.com]
X-MS-Exchange-CrossTenant-AuthSource: BE1PEPF0000056D.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0127

From: Lars Pöschel <lars.poeschel@edag.com>

The method the driver uses to determine the size of the FIFO has a
problem. What it currently does is this:
It stops the SPI hardware and writes to the TX FIFO register until TX
FIFO FULL asserts in the status register. But the hardware does not only
have the FIFO, it also seems to have a shift register. This can be seen,
when writing a byte to the FIFO (while the SPI hardware is stopped,) the
TX FIFO EMPTY is still empty. So, if we have a FIFO size of 16 for
example, the current method returns a 17.
This is a problem, at least when using the driver in irq mode. The same
size determined for the TX FIFO is also assumed for the RX FIFO. When an
SPI transaction wants to write the amount of the FIFO size or more
bytes, the following happens, let's assume 16 bytes FIFO size:
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

The new method for determining the FIFO size is to read the SPITFOR (TX
FIFO occupancy register, value = occupancy - 1) after filling the TX
FIFO to obtain the true FIFO storage depth, which also equals the RX
FIFO depth. In non-FIFO configurations (n_words == 1) the register does
not exist; return 1 directly in that case.

Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 9f065d4e27d1..2d31e30fc4eb 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -54,6 +54,7 @@
 #define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */
 
 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */
+#define XSPI_TFOR_OFFSET	0x74	/* Transmit FIFO Occupancy Register */
 
 /* Register definitions as per "OPB IPIF (v3.01c) Product Specification", DS414
  * IPIF registers are 32 bit
@@ -377,7 +378,9 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
 		n_words++;
 	} while (!(sr & XSPI_SR_TX_FULL_MASK));
 
-	return n_words;
+	if (n_words == 1)
+		return 1;
+	return xspi->read_fn(xspi->regs + XSPI_TFOR_OFFSET) + 1;
 }
 
 static const struct of_device_id xilinx_spi_of_match[] = {
-- 
2.34.1

