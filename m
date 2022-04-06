Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5687C433F5
	for <linux-spi@archiver.kernel.org>; Wed,  6 Apr 2022 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiDFQEf (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiDFQEO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Apr 2022 12:04:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7334B923;
        Wed,  6 Apr 2022 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649252176; x=1680788176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XoYhWii4g6voxXG1Oc4IkvgPk7IcmXLwZeVxiaR8YJQ=;
  b=J0Ks4w77JdtUYaotZy2HwmFyg8Qtg7Ri1DtNo6A9o/Vwdso9HbhHppq9
   XYN1XQWAxWi0iH0Fndw5YonDrIJrLPVX66vAxIswuF1Gg3St6XWhtvdvU
   OqVpuwugLJx/OvG0XrgMetcoxT4/6CRB5eaiKg04eLJhtogLpNglWzJMC
   YjI6lV9w4h+U1PH0gvVHISBS3bqAF/vFA3TeBl7C2QMSBconOgwYvFrkl
   FxWXZspdfr88jBE+JY4u8CJUrfEUvzBLGrTGfOmVKDqVlpnGzR1WBza7r
   OcXk7dQvZGWWJhRcwxP3R4TlATcsUvpgZrd8LrgwUs6OTdnHzblOKHi55
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643698800"; 
   d="scan'208";a="159134858"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2022 06:36:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Apr 2022 06:36:14 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Apr 2022 06:36:12 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/2] spi: atmel-quadspi: Remove duplicated DTR checks
Date:   Wed, 6 Apr 2022 16:36:04 +0300
Message-ID: <20220406133604.455356-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406133604.455356-1-tudor.ambarus@microchip.com>
References: <20220406133604.455356-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove the DTR checks as they are already handled in
spi_mem_default_supports_op(). This code removal was intentionally not done
in the previous patch that introduced the use of the
spi_mem_default_supports_op() core helper and fixed the buswidth adjustment
between SPIMEM and the SPI controller, so that the fix can be easily
backported to stable kernels.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: no changes

 drivers/spi/atmel-quadspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 938017a60c8e..480c0c8c18e4 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -288,12 +288,6 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 		op->dummy.nbytes == 0)
 		return false;
 
-	/* DTR ops not supported. */
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-	if (op->cmd.nbytes != 1)
-		return false;
-
 	return true;
 }
 
-- 
2.25.1

