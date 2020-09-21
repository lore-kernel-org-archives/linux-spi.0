Return-Path: <SRS0=mVQ7=C6=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC267C43463
	for <linux-spi@archiver.kernel.org>; Mon, 21 Sep 2020 07:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C321207DE
	for <linux-spi@archiver.kernel.org>; Mon, 21 Sep 2020 07:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sSF+ozve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIUHRp (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 21 Sep 2020 03:17:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:18009 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHRp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Sep 2020 03:17:45 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 03:17:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600672664; x=1632208664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7QMYWVfZ+QkjHPJoRrIf1pbZoykGyVRzJSYOFZvErAE=;
  b=sSF+ozveLa50iV2nw/gAixI0cihGYTNCTboFq2boxOv30Pu0RXoQZiOH
   RMhFr+QXxZARngzy4ti+9mZ9Qp1BsMUPMxA/UN/DNGy6CS9CCLLyOFvoK
   SK2WLxsbDwGhkk//k2a0o1dBpYEijneUeA1c9AnZvxGmUyhAMtGUu24jx
   2U3UdaaeBRRA2bEMJbAjKdx2r9uJWgpivWykAXN1/7bA+NOuEloKAF6b2
   QyTWgx8xrOILT/+ip3m2TSHIhqvMRpoaRLdCQPCZ/q0hwRwJtKTG/Lg3g
   01LVjyecwP2zfDLKVXNg7eQZQogb3BAMBb4l6svA0arW6ePr9Hnn3PbeF
   w==;
IronPort-SDR: arLCkEPZ3idr6VkpE1+LdRt3XnVI2wWdG+ZnuTYIiOUvKX1iOP4frfsGqH9GdflB+i2g+B50UY
 DCR7x3Mz4hHkuWLwT4Uj91HicvGKrjUnCvK897lFCcGBih5njATCahBQz5i9qFeXOhktk340iE
 gPlVYaBOugb8PpvZDXtEz5HO2n7qiiwL5GGyT7k1jJ+PsbO1l93+je6FHvL2r63qWpgaw6538K
 hlAoHDfChJY38SqpN8xVssjogDVUwewWiXCEIdiQ48wlHV/FxYSFnDelXXLM2zKHAuC/xiIQHb
 QiY=
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="96528077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2020 00:10:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 21 Sep 2020 00:10:38 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 21 Sep 2020 00:10:36 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <thomas.kopp@microchip.com>, <tudor.ambarus@microchip.com>
Subject: [PATCH v2] spi: atmel: Exposing effective spi speed
Date:   Mon, 21 Sep 2020 09:10:36 +0200
Message-ID: <20200921071036.2091-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch implements the reporting of the effectively used speed_hz for
the transfer by setting xfer->effective_speed_hz.

See the following patch, which adds this feature to the SPI core for more
information:
commit 5d7e2b5ed585 ("spi: core: allow reporting the effectivly used speed_hz for a transfer")

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2cfe6253a784..799229bc34e1 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -859,6 +859,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	csr = spi_readl(as, CSR0 + 4 * chip_select);
 	csr = SPI_BFINS(SCBR, scbr, csr);
 	spi_writel(as, CSR0 + 4 * chip_select, csr);
+	xfer->effective_speed_hz = bus_hz / scbr;
 
 	return 0;
 }
-- 
2.25.1

