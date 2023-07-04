Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4B8EB64DD
	for <linux-spi@archiver.kernel.org>; Tue,  4 Jul 2023 09:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGDJWa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGDJWL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 05:22:11 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6302010E5;
        Tue,  4 Jul 2023 02:22:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BCDB0828C;
        Tue,  4 Jul 2023 17:22:02 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 17:22:02 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 4 Jul 2023 17:22:01 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [RESEND v1 1/2] dt-binding: spi: constrain minItems of clocks and clock-names
Date:   Tue, 4 Jul 2023 17:21:59 +0800
Message-ID: <20230704092200.85401-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704092200.85401-1-william.qiu@starfivetech.com>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
so there add minItems whose value is equal to 1. Other platforms do not
have this constraint.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 91e540a92faf..42bb34c39971 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -11,6 +11,7 @@ maintainers:

 allOf:
   - $ref: spi-controller.yaml#
+  - $ref: /schemas/arm/primecell.yaml#

 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
@@ -34,12 +35,16 @@ properties:
     maxItems: 1

   clocks:
+    minItems: 1
     maxItems: 2

   clock-names:
-    items:
-      - const: sspclk
-      - const: apb_pclk
+    oneOf:
+      - items:
+          - const: apb_pclk
+      - items:
+          - const: sspclk
+          - const: apb_pclk

   pl022,autosuspend-delay:
     description: delay in ms following transfer completion before the
--
2.34.1

