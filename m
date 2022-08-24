Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66505C3F6B0
	for <linux-spi@archiver.kernel.org>; Wed, 24 Aug 2022 09:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiHXJnn (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 24 Aug 2022 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiHXJnl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Aug 2022 05:43:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799885F99
        for <linux-spi@vger.kernel.org>; Wed, 24 Aug 2022 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=qmcfRLRJQksIYi
        5/BVMDmHAZIGDTGZ7oQok7HMEm3UQ=; b=SYaJGd0IlYAhZWTZtV2G9PNRXJXrUj
        JE7B/wP+Kw/9bCh7ZZvS1mepUmAX9X/SicXAuRn9UKq8jc6TZAOUX+wT9+RBGPb3
        oppznaDvZFdK5B6iODgFbXxsYzF91KqDI9E8Eayswnmyf2AdQjtE3xE0YffGQtKC
        Qn/p+Wi/p5/S8=
Received: (qmail 2162613 invoked from network); 24 Aug 2022 11:43:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 11:43:35 +0200
X-UD-Smtp-Session: l3s3148p1@fQG+g/nmVpsgAwDPXxw3AFlguiwjsjwa
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
Date:   Wed, 24 Aug 2022 11:43:24 +0200
Message-Id: <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 5de710adfa63..3813e8aaaefd 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -50,6 +50,11 @@ properties:
               - renesas,msiof-r8a779a0      # R-Car V3U
           - const: renesas,rcar-gen3-msiof  # generic R-Car Gen3 and RZ/G2
                                             # compatible device
+      - items:
+          - enum:
+              - renesas,msiof-r8a779f0      # R-Car S4-8
+          - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
+                                            # compatible device
       - items:
           - const: renesas,sh-msiof  # deprecated
 
-- 
2.35.1

