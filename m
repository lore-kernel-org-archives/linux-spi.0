Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA08C00140
	for <linux-spi@archiver.kernel.org>; Wed, 10 Aug 2022 13:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiHJNMs (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHJNMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 09:12:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35613FB1
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:12:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a9so21149427lfm.12
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Xt4sTSjZbsVw99EpwkCEf7vaG5aOAi9K9YMX6CS8DbU=;
        b=tDEXm9cJOo9x+jqx0eZjSaW0fOGtKkO/wjuGSXbbyLjhtHUEry6+Bb/qXO5hwNbAAr
         BctplbuasMFj9Osj0FNf1VY0R3cgmEMx0zg7AfozS5nZwReWFfsvnjUdq6y+MSiRcUVM
         mHOBaNNXyy5fS9037dkM6laEaVcv6IqsJ/po2HO4wIdbPDIPS+gH13zNcL5+/JhXqnIR
         YvYFMcqqOng1NzxOzf0w+xfO4IPX11ndEXW0VatliCPM33Q+0pz9ZyBr4Io2Ate93epE
         /4hGd4W+H8xcdAu5bn32XM8CCGMOTUGazEVX/k5gl0Ig4bmqJOXyZbr+eOeQWo3+5Bs2
         /wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Xt4sTSjZbsVw99EpwkCEf7vaG5aOAi9K9YMX6CS8DbU=;
        b=wlbWR8EnXZciRXnebt8l87qyRYiM0fb//nrVhS5oycxzR3Aw42Iejsppe256e3k4t9
         x4gFSLoD+8MvBpe+nMZuv420Rvc4zaPxQ6Kp3VksfUwicFC0Z0zW0+SPHr49bCfSmk4R
         9haBkEOtOZ38wfUUwwTrwXPaafq1lc6gtAof0PQUS5+c8D+etQfsMVTvPieO4lLR/9V7
         TXkiCQe01AWarc1YMe3NiWmCWdS8qZkWWO/ZfRbt6phBsIGeB7I6avPmGYmZH1Df+rZY
         N2/unNsMzbQFTcelPMQJkICGAVh/NJYbILCcEOpO9cu07bOS+CkCe/UmcxB76n13lpIp
         qq9g==
X-Gm-Message-State: ACgBeo0Z7qv5gW2DmOxnJ2ktihI1t8hJ4bWrX5v+LhPqjRmqfzQb4cCu
        m8W2x0qcQ9nhVgTH9TpL92l1qg==
X-Google-Smtp-Source: AA6agR6BSaEUe26xeOlQs51vuNIgdOU/4k/pdSwN9BiMa+HppfBY/RMrzljKL1NTppwuvFsQnxDjSg==
X-Received: by 2002:a05:6512:138e:b0:47f:77cc:327a with SMTP id p14-20020a056512138e00b0047f77cc327amr9836703lfa.277.1660137160254;
        Wed, 10 Aug 2022 06:12:40 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ee02000000b0048b08f0c4ddsm334168lfb.253.2022.08.10.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:12:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: dt-bindings: nvidia,tegra210-quad-peripheral-props: correct additional properties
Date:   Wed, 10 Aug 2022 16:12:36 +0300
Message-Id: <20220810131236.428529-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Re-usable schemas should use additionalProperties:true, so the schema
using it will check for evaluated properties.

Fixes: e23917822d3c ("spi: dt-bindings: split peripheral prods")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml    | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
index 24e0c2181d25..2c3cada75339 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
@@ -29,5 +29,4 @@ properties:
     minimum: 0
     maximum: 255
 
-unevaluatedProperties: true
-
+additionalProperties: true
-- 
2.34.1

