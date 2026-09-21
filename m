Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C933938C;
	Mon, 21 Sep 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020820; cv=fail; b=oAhiJBQDPc6FHhZfNhAhBiTt1PqB5tl9be5ZK5fwleP/i50ukoTvlPqpH5FLzr2t7Pm37yyzMHkI0wfiWl3DNsWta2FXzU77+GaM9qv7dflSn9ic7Bt1SzAOmV0NBBYfv6WUNtNeGtkUh1C71U92ng6rPE1Ffk5hgVARTT7quW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020820; c=relaxed/simple;
	bh=5GPqOXxCeI/zH4cwUI6xGOw2jePXAIOYNSJ98ea4QTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ls1rM3s0UQytjb7uupq0E6KeVPTpu2olHe+CMSFGHbMFVmSFRO24v/m8nTeO3y3wc14GVKJB+GhG4JvPcfdUswVT+Y8no6I954g4zkNbJP/WCdbJ0clEL2AnACMWKpgaXG6s+Q8cY4/zkg+02UBOY1lByx5IaJ86Cf0xJr+j9mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hu+3qFBG; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hu+3qFBG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKtnMQswjFLVW5sgIT5EtAYm0WjkwSxr5sf8RaXxsHiHqZuimD2l0OIMru4FV02A5v0Bhx+AkI7isrAjxTDA8KYzUmkzixd57lUWYNrOsgAOjLBP97qxWfZ3Oj3YggrDrbg86jqC4ERv7x5Iyp1e3JdQcri0XBQAo77wsyfkerSD+LcxuCruCjQGS64m4WpMEkypBaaO06RylEXYTq+mOewBkUoc36bga8qUpuvT6k2j6eWb7dzRpkR3dJR8I7VpYZwg+9lHPegg+xonZ2fXqMJc1W6x+ZtvZM+XJXG3bRCDGd2kYysEKbssWlnTw/ZQN4pWvWwZ19MRPZSQrQgA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYlqVV0PbzEKRmEPeFUO/QKN7aJnxBLOSZLmwT57Lo8=;
 b=yx8oSKTQzyg0SiP9BkK8FSaRFn1pGnPv8IzIvdIZn0sq5542U9kHHpQ/QwNIEN3FMEG9A47kSUdJXtfMSzWKChpYTM3emUHqhv76UnOn3Vy+M1K/fPdJbi1pJxCCWN6dM0xzrRjMV3GFYY5H4GS49b4UHuMgdwS5NZjths2jr+M0n5pOUqEiDRFHz85m39Hbqp++qusbiTt9gnVvur+3zecQApiPSDIlGqA93Z1KsqbTsCtNex7KjrvxoHcTQGStkpJeHhLAM6evAI5cLmzN8wpgB7g5Ag+9eOew1ikDfw85PwXlyfQuVYAlXFo2CIJgh3+ZR2RPEBzrpdaAJKozzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=glider.be smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYlqVV0PbzEKRmEPeFUO/QKN7aJnxBLOSZLmwT57Lo8=;
 b=hu+3qFBGgRTGb07Y8vWPl8I00f1Y7nFJ/NWwV9Azan3zflRBSLmitZIkcDtA2n8wqLWwDrJHM2AVIqJf4HiF38SgyifpDe8v/9xgx0NyxAuW+tcQC/ZPCL6iwpi0FWcGmz3kFCr3CNhKEvzP0zAhu2yph8TlxEpp0V3T1m+sRgA=
Received: from TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b4::10)
 by TY3PR01MB11528.jpnprd01.prod.outlook.com (2603:1096:400:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:00:08 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4:cafe::44) by TYCP286CA0092.outlook.office365.com
 (2603:1096:400:2b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 20:00:07 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.26])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C0EAA3000240;
	Tue, 22 Sep 2026 05:00:05 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: broonie@kernel.org,
	geert+renesas@glider.be
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is built as a module
Date: Mon, 21 Sep 2026 19:59:43 +0000
Message-ID: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TY3PR01MB11528:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d00e4e9-e5f0-43e4-7597-08df181aef87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Em2dwfz9Poxj7kOCj8avPvfFFpO/fQCeCkd6Jb/EoCzZs9mFqz6O5CXC9f0zlH5M28fzwvVr2rNPN7Feu9xWC51HV/YwD+DjI1g47NTxyBBji1NdJ9Thz570DH4N49o8E6n23uI75O231g44hRVUDkivAeOcLQxKz+MLDKo6uGD6R39xC5AolfU8eZM8rG+B7o910mR767/4O1IoRmJ6pip9jjTMxhuxc95KgNso8Seea6lIj3TJGxem1ETR5T593KJWETIUj89ezWKp3N0gR/d7KfneQ5bwCpfpz5Dx/xkQ37maVXqCT8O6P5BsiCJ+O2JumO2etjhRIURGSuLLlzg55MM6+XaPbUcadH5ejbeh8jeqyhQfp5Mq2uQkES5u+9dLjapxc5BmjFclSefrvJ2e6pCUOi0iURL0HfCsBitvBUaZTdOoFqGV43cdsJFXhYHXTNc98xAj0MzlwY/95hBk7rXnqqEWyRM9vCVg8/OnwFmqEsuBp01LyuH6/5rFqyjvumw2TXMK4ciKYO4T3UpJq4wduFv7NvrRT9Q1JuXk5mQEOuKk9xUMSR3gDZm0v2+0JcygvRURaDrjIxpn/WmST6x/pJeU9aPwInnJ8MS7kMGmHWQI7sHUbB+8xLAow01Tg3VqYcmrPfH/XtGasI3nmP+JlHxALy9OwQj/F4vroUjrQnUj8eAGtybvp9PHC05axDpiS8WGMTWZ/6SWaQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d2Dy7M2Dy7WKrgF1ISVEyImLLjVZCThoc8YPlA5y8yPaZrFCH2oRTO2o75jne85WOEFvDJCm8fUmGHBmaECxVObA5HQfdAEvyJywZPs5e/t4VLECphtq1ottoKA6fcB8ytxSRudQFaRdb2mpXXnudKXyelhazC8IJum9p/ED8juyWSFNywvdfw7/wgzZBCaFNocWCDpuzr/JE5ilG/f++Udoghu71L+K3vNAE38XVuNxwlOb5/DC3n24tmX72JgbVHbEE2Z/eYoRKRN2/wOK2PyMIRQnxMi8eh96E1kk8YDCm5jFaJ2PAOXa1NGtWFDI/rVv3OcXrE8X927sDqtzOOKbJKRlduWfmeWb7AwPGGTlUAAL1de7ZMXX66bEI0YvHjyYn8cv2r6fue8p4BiTMLoZMvIFZvpTgl5ZV09lAr0Cgd1wvHLf9FsSPxlBnZVi
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:00:07.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d00e4e9-e5f0-43e4-7597-08df181aef87
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11528

On the Renesas RZ/G2L platform, the RSPI driver falls back to PIO mode
instead of using DMA when the DMA controller driver is built as a module
(CONFIG_RZ_DMAC=m):

    renesas_spi 1004b000.spi: dma_request_slave_channel_compat failed
    renesas_spi 1004b000.spi: DMA not available, using PIO

The driver requests DMA channels through dma_request_slave_channel_compat()
which returns either a valid pointer or NULL and cannot handle
-EPROBE_DEFER. If the DMA controller has not probed yet, the driver falls
back to PIO directly.

Fix this by replacing the dma_request_slave_channel_compat() call with a
regular dma_request_chan() call. dma_request_slave_channel_compat() is
always passed a NULL fn_param in all code paths, so it actually behaves
like a plain dma_request_chan() call.

Fixes: e825b8dd2b36 ("spi: rspi: Add DT support to DMA setup")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/spi/spi-rspi.c | 49 ++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 38df676774ee..c61edd1c1353 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -22,7 +22,6 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-#include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 
@@ -1091,24 +1090,15 @@ static irqreturn_t rspi_irq_tx(int irq, void *_sr)
 
 static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 					      enum dma_transfer_direction dir,
-					      unsigned int id,
 					      dma_addr_t port_addr)
 {
-	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_slave_config cfg;
 	int ret;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				(void *)(unsigned long)id, dev,
-				dir == DMA_MEM_TO_DEV ? "tx" : "rx");
-	if (!chan) {
-		dev_warn(dev, "dma_request_slave_channel_compat failed\n");
-		return NULL;
-	}
+	chan = dma_request_chan(dev, dir == DMA_MEM_TO_DEV ? "tx" : "rx");
+	if (IS_ERR(chan))
+		return chan;
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.dst_addr = port_addr + RSPI_SPDR;
@@ -1121,7 +1111,7 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	if (ret) {
 		dev_warn(dev, "dmaengine_slave_config failed %d\n", ret);
 		dma_release_channel(chan);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return chan;
@@ -1130,29 +1120,23 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 static int rspi_request_dma(struct device *dev, struct spi_controller *ctlr,
 			    const struct resource *res)
 {
-	unsigned int dma_tx_id, dma_rx_id;
+	struct dma_chan *chan;
 
-	if (dev->of_node) {
-		/* In the OF case we will get the slave IDs from the DT */
-		dma_tx_id = 0;
-		dma_rx_id = 0;
-	} else {
-		/* The driver assumes no error. */
+	if (!dev->of_node)
 		return 0;
-	}
 
-	ctlr->dma_tx = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV, dma_tx_id,
-					     res->start);
-	if (!ctlr->dma_tx)
-		return -ENODEV;
+	chan = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV, res->start);
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+	ctlr->dma_tx = chan;
 
-	ctlr->dma_rx = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM, dma_rx_id,
-					     res->start);
-	if (!ctlr->dma_rx) {
+	chan = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM, res->start);
+	if (IS_ERR(chan)) {
 		dma_release_channel(ctlr->dma_tx);
 		ctlr->dma_tx = NULL;
-		return -ENODEV;
+		return PTR_ERR(chan);
 	}
+	ctlr->dma_rx = chan;
 
 	ctlr->can_dma = rspi_can_dma;
 	dev_info(dev, "DMA available");
@@ -1355,6 +1339,11 @@ static int rspi_probe(struct platform_device *pdev)
 	}
 
 	ret = rspi_request_dma(&pdev->dev, ctlr, res);
+	if (ret == -EPROBE_DEFER) {
+		dev_err_probe(&pdev->dev, ret,
+			      "failed to request DMA channels\n");
+		goto error2;
+	}
 	if (ret < 0)
 		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
-- 
2.34.1

