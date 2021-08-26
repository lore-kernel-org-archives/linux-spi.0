Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34539C4320A
	for <linux-spi@archiver.kernel.org>; Thu, 26 Aug 2021 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18CC460524
	for <linux-spi@archiver.kernel.org>; Thu, 26 Aug 2021 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhHZJRV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbhHZJRU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Aug 2021 05:17:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F1C06179A;
        Thu, 26 Aug 2021 02:16:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so1949729pjt.0;
        Thu, 26 Aug 2021 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDoHbMmNmpCXjL+1LQmy12F8mGDRmsYjHo9WcFavq1Y=;
        b=BAiZGGqI+HHBBO684td2NHcmUlE2atxF+SiCXSrdcS22tmzszXW82yidM3mCfN1NA8
         4MDpaAWspDA2YhwyaBVduE6cKwb7FHuaRAFxdWMWpgfbmSrFdWaQY2EmOcmocDb2vyPj
         qg9aUThsxZnFlidsP2E9GiXYp2wQoj58gYREtf4nUYMlrHtfv41Hr183VEJZe1ntgrPa
         NcrVh9ouGjkVT0rY7TKb1MICB+PMPCcydRJdB9Iz7K/yQH5HxhhUhnjCbmhRU2d2YQUV
         806PtoA3QYrtgQ/XAVSzUSWQA+HBX2imZw3IGfhHPbYXzy7EzqbZVBHxZhHWpfT7mj3W
         OM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDoHbMmNmpCXjL+1LQmy12F8mGDRmsYjHo9WcFavq1Y=;
        b=BUEovS58LH5cpeHlVidHXIAkLNPxh30b4dlUGvp6aaAf6448F1GSGqfRBYVxj+cm3e
         AX0HTEUFzmQCZJFZNfIBDBnw4T/QusXAIE5WUXqVtpJj845ELbAAkw6/GfIz0f8pgjzj
         wVmM1cS39oNCgrYd5M8cC+L4MHVttqBEwaZy1IVpzVCPKmcK96/vfOnsZE93fAFdVnX/
         RbGFv3XRpkly327k0bjb0t+Nz7If2AImuIHZDC0pdY7QHNVM/CrIeW20neW/86FSs8AG
         UO2AzVo4RusjqlhYWY74dYkFz0o34O4sp+5YcYmDMYXaNIJlQQswbLc4m6tk/35Gl3tm
         Ja1A==
X-Gm-Message-State: AOAM530KQbAlXFk8UTCFNYAnTLTlyPKtQK5TBfVeigRfXNxDixJXmaaT
        R8HVWqwLJPYNIfOyv9EsCok=
X-Google-Smtp-Source: ABdhPJzjWfySGAYnKw3HLlI9HzwebEDcTkorRHFV/cZD1c84/1Igd8F+YlZIc0tLn4VzaE+WvnVkVA==
X-Received: by 2002:a17:902:ab07:b0:133:dad9:ee80 with SMTP id ik7-20020a170902ab0700b00133dad9ee80mr2881482plb.38.1629969391636;
        Thu, 26 Aug 2021 02:16:31 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm2777569pgb.2.2021.08.26.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:16:31 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 4/4] dt-bindings: spi: add sprd ADI for sc9863 and ums512
Date:   Thu, 26 Aug 2021 17:15:49 +0800
Message-Id: <20210826091549.2138125-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826091549.2138125-1-zhang.lyra@gmail.com>
References: <20210826091549.2138125-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch adds support for sc9863 and ums512.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
index 3e399d31168b..fe014020da69 100644
--- a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -50,6 +50,8 @@ properties:
   compatible:
     enum:
       - sprd,sc9860-adi
+      - sprd,sc9863-adi
+      - sprd,ums512-adi
 
   reg:
     maxItems: 1
-- 
2.25.1

