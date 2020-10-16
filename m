Return-Path: <SRS0=rigy=DX=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106ECC433E7
	for <linux-spi@archiver.kernel.org>; Fri, 16 Oct 2020 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FA12084C
	for <linux-spi@archiver.kernel.org>; Fri, 16 Oct 2020 08:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA1GNd8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404833AbgJPIu0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404750AbgJPIuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Oct 2020 04:50:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD6C061755;
        Fri, 16 Oct 2020 01:50:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so1623776ljj.0;
        Fri, 16 Oct 2020 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l2g0WanDfq/KDOh+/VcHyYkZcE8dM9/DlazBWuJO0Zw=;
        b=JA1GNd8+HG69mXKrInW+0dljGSbVqvNVsQIb2Q4Wl6dfWRYeempCQLpYb9LCCx0tF/
         M//4FdO2QES7EtI0dmhPQ5LSEOjx95yO8c8ekXQETgalMH9LDJJYMryKl7NQY+wTG5P3
         Z3pwCjpROLpJoK87+6xDJczYQvv1oZgEbOt5G8VxPFs45ijMGsNewG+SUAGA2oWWhOEg
         92Jl18IA1nE773vlSc40rcMiXogokilNW+h5C0A2yh2aFVlfYIbztIhTmG8aiZO7rErV
         tpHdPSoVBgF27FnMYuUMLviVlfDXNiiunM4jihEFO01voqCV2NAZ4zeKCMGegQKSYFTL
         fx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l2g0WanDfq/KDOh+/VcHyYkZcE8dM9/DlazBWuJO0Zw=;
        b=uQLr0TtkaGB06LOnQNkX7CcRlBWW3Hvo8su3z8wRAhKbTIZs/IyPY4VmCIKDZreZG/
         W0m0jo6GkNRENJCUDOsP8shU6hg5PE8CVbteB6xbLdgw3klWXyVfnTszTNA/0tUGYu1j
         P7gR5aUGpqgZBT29niAkj8PFJDpj6FxiXRJOaaoY0ugdAC/XLdNxYxF+saTpF6AaeWgC
         F/TWK3Kj0qL3YoYku0wNiwzpDmAOsX+ZDpQiMD6rQMMjuHagdSIYj2q26Mb7eetWZjOz
         xj20b2srGAISUET7E2qXbBgOJIGjIU4lZ+KOme3VniFn9rdQNPgA8AsyEKp+u3qU7Cys
         rqng==
X-Gm-Message-State: AOAM533kT5Kn72rUU/CANuGwCyVy8dPo2Lt5ZEXAYT32O2P1GCHWHhVy
        ylbgKOGI27WjZ4vaBtQ0KEU=
X-Google-Smtp-Source: ABdhPJwdW1Qe4VdACE8m9bGNR8Vib87O4M73lJOUO9VrfM5U5CqccUuVSr6SJSEuRzCSoN2I39zj2g==
X-Received: by 2002:a2e:b5c1:: with SMTP id g1mr1014660ljn.305.1602838224050;
        Fri, 16 Oct 2020 01:50:24 -0700 (PDT)
Received: from ubuntu-18.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id 62sm607435lfk.47.2020.10.16.01.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:50:23 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] spi: rockchip: enable autosuspend feature
Date:   Fri, 16 Oct 2020 11:50:14 +0300
Message-Id: <20201016085014.31667-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If SPI is used for periodic polling any sensor, significant delays
sometimes appear. Switching on module clocks during resume lead to delays.
Enabling autosuspend mode causes the controller to not suspend between
SPI transfers and the delays disappear.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/spi/spi-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 2cc6d9951b52..3e77b1a79bc8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -157,6 +157,8 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
+#define ROCKCHIP_AUTOSUSPEND_TIMEOUT		2000
+
 struct rockchip_spi {
 	struct device *dev;
 
@@ -670,6 +672,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.17.1

