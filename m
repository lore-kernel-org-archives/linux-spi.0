Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D748C433ED
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFBA611BF
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbhEQQiB (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 May 2021 12:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbhEQQhz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 12:37:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B2C008759;
        Mon, 17 May 2021 08:39:57 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5DE4E22259;
        Mon, 17 May 2021 17:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621265992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0WDQswb29ekOQtBjlBA4WxFqdKsvu0Yca0TvQIERfE0=;
        b=ZFTvVAg2Yy28z5+v0Mka3cXplmZ008I9j57pSez8z/j8MpOmxJ1Tz4y+YTP5ta6dtwuH+E
        bmYzfoBIgeQXgvtrQhM+B1yA1R3Kdgzn/aiw/iP2LYT1ZtNeRsyPccWn9LEpYrXkHHCbXj
        PNcndPvXNafMm1LkPMclEeKm7wbrFzI=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: spi: spi-mux: rename flash node
Date:   Mon, 17 May 2021 17:39:46 +0200
Message-Id: <20210517153946.9502-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The recent conversion of the common MTD properties to YAML now mandates
a particular node name for SPI flash devices.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/devicetree/bindings/spi/spi-mux.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
index d09c6355e22d..51c7622dc20b 100644
--- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -72,7 +72,7 @@ examples:
 
             mux-controls = <&mux>;
 
-            spi-flash@0 {
+            flash@0 {
                 compatible = "jedec,spi-nor";
                 reg = <0>;
                 spi-max-frequency = <40000000>;
-- 
2.20.1

