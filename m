Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE4FC433E0
	for <linux-spi@archiver.kernel.org>; Tue, 26 Jan 2021 02:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A1322AAA
	for <linux-spi@archiver.kernel.org>; Tue, 26 Jan 2021 02:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbhAYPjE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 25 Jan 2021 10:39:04 -0500
Received: from foss.arm.com ([217.140.110.172]:49662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbhAYPim (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Jan 2021 10:38:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 478B9176B;
        Mon, 25 Jan 2021 07:19:25 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AEED3F68F;
        Mon, 25 Jan 2021 07:19:23 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v4 13/21] dt-bindings: spi: sunxi: Add H616 compatible string
Date:   Mon, 25 Jan 2021 15:18:03 +0000
Message-Id: <20210125151811.11871-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210125151811.11871-1-andre.przywara@arm.com>
References: <20210125151811.11871-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the obvious compatible name to the existing SPI binding, and pair
it with the existing H3 fallback compatible string, as the devices are
compatible.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 7866a655d81c..908248260afa 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - allwinner,sun8i-r40-spi
               - allwinner,sun50i-h6-spi
+              - allwinner,sun50i-h616-spi
           - const: allwinner,sun8i-h3-spi
 
   reg:
-- 
2.17.5

