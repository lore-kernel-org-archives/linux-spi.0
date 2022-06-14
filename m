Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44906C433EF
	for <linux-spi@archiver.kernel.org>; Tue, 14 Jun 2022 07:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiFNHAQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiFNHAP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jun 2022 03:00:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C63B00F;
        Tue, 14 Jun 2022 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655190013; x=1686726013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4nzZezDWWWUTOy8OMeuQhCOxOSUCA20xYUUYSUJEJ4=;
  b=xtGnTo4nJB5KINBX3erdkGK3vH9x+W3apBUbeoRsGzce1uvlNToY6ohF
   MPIa5qdprHE48Izp8LoF8CBi6+KxC2AHYChxRer8eXCl6n8YPP1YqKfwj
   KPTiTfn5Z3Y71SrljSHoa7jFtThP1RYI6vFyS+nWpPG+B7J/xblkZeQX/
   J9f4y1+EZqxmK9xsC7QdAzyysis7dnVpp3IV6YRIsT8h8GpH0hmIYV9N3
   BhipSxorQNpL6a3KSJu7uEhyN3z7tb+p7ex1naFxby3N3A0F9QVgP57UK
   SfTCt76CvMlLDwnSwxMfrwGuzL9ytfKVJXfwdf1fG6rr1+y2moVOhPw5/
   A==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="99902883"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 00:00:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 00:00:12 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Jun 2022 00:00:10 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] spi: microchip-core: fix potentially incorrect return from probe
Date:   Tue, 14 Jun 2022 07:58:10 +0100
Message-ID: <20220614065809.1969177-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If platform_get_irqi() returns 0, the error case will be triggered but
probe() will return 0 rather than an error. Ape the other drivers using
this pattern and return -ENXIO.

Reported-by: Yang Li <yang.lee@linux.alibaba.com>
Link: https://lore.kernel.org/linux-spi/20220609055533.95866-2-yang.lee@linux.alibaba.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b22a1395554..856a68fd8e9f 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -541,7 +541,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
 		dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
-		ret = spi->irq;
+		ret = -ENXIO;
 		goto error_release_master;
 	}
 
-- 
2.36.1

