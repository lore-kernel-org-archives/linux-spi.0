Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBBC433F5
	for <linux-spi@archiver.kernel.org>; Mon, 15 Nov 2021 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37CE63422
	for <linux-spi@archiver.kernel.org>; Mon, 15 Nov 2021 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbhKOS04 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 15 Nov 2021 13:26:56 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45170 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbhKOSZC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:25:02 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] spi: dw: Define the capabilities in a continuous bit-flags set
Date:   Mon, 15 Nov 2021 21:19:17 +0300
Message-ID: <20211115181917.7521-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the DW_SPI_CAP_DWC_HSSI capability has just been replaced with using
the DW SSI IP-core versions interface, the DW SPI capability flags are now
represented with a gap. Let's fix it by redefining the DW_SPI_CAP_DFS32
macro to setting BIT(2) of the capabilities field.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changelog v3:
- This is a new patch unpinned from the previous one as of Andy
  suggested.
---
 drivers/spi/spi-dw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 8334e6b35f89..d5ee5130601e 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,7 +32,7 @@
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DFS32		BIT(3)
+#define DW_SPI_CAP_DFS32		BIT(2)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
-- 
2.33.0

