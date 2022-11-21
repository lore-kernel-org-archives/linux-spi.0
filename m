Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37439C433FE
	for <linux-spi@archiver.kernel.org>; Mon, 21 Nov 2022 01:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKUBsW (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKUBsV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Nov 2022 20:48:21 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 796A91DDF6;
        Sun, 20 Nov 2022 17:48:20 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Nov 2022 10:48:18 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 006EA20584CE;
        Mon, 21 Nov 2022 10:48:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 21 Nov 2022 10:48:18 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 96CD4B62AE;
        Mon, 21 Nov 2022 10:48:17 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] Introduce Socionext F_OSPI SPI flash controller
Date:   Mon, 21 Nov 2022 10:47:58 +0900
Message-Id: <20221121014800.13989-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds dt-bindings and a driver for Socionext F_OSPI controller
for connecting an SPI Flash memory over up to 8-bit wide bus.
The controller supports up to 4 chip selects.

Changes since v1:
- Drop vendor-specific properties for devices from host dt-bindings
- Drop a function to parse vendor-specific properties
- Fix wrong maximum addr.bytes (5 to 4)

Kunihiko Hayashi (2):
  dt-bindings: spi: Add Socionext F_OSPI controller bindings
  spi: Add Socionext F_OSPI SPI flash controller driver

 .../bindings/spi/socionext,f-ospi.yaml        |  57 ++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sn-f-ospi.c                   | 703 ++++++++++++++++++
 4 files changed, 770 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
 create mode 100644 drivers/spi/spi-sn-f-ospi.c

-- 
2.25.1

