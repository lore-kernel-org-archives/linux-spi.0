Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CE3C3526E
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE0B23A04
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgLQU3j (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:29:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19156 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgLQU3g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:29:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf880000>; Thu, 17 Dec 2020 12:28:56 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:54 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:53 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 3/9] MAINTAINERS: Add Tegra Quad SPI driver section
Date:   Thu, 17 Dec 2020 12:28:41 -0800
Message-ID: <1608236927-28701-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236936; bh=eUmYkQtzsVe7hTNcXJ04Thtwwti9plDaDD83X+TMEaA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=FVavdbxBEIHdggqJNA9/vhAYusQGruIw7zbbkmAiaPu1CwgyiAyAuX5ep7lZT8id6
         dNBzqRNGncHsD7FVV3U3oyc9okze5EUDjNYwbCVE4FydjVfjejGDaOp29RanmQcka/
         5+Fp0y/goJI63ZPCfOxcQL+nsQaJsnriQAOkBAqWDpWeTPy77A0NQfVa1JbL8zMIxI
         0WN0UvFWz1eKHM4lhzVABdoF5sw9RjGpTN7RUAexh2cgn62uECaMMI4PcW7VvWE36n
         BUK/UyLlHd/evSh2FsC1Yq8q7LFsVsjvCOJwaw+FoFmPeGgSDXfSmybydzboCvUSm6
         Ei1Ql72Hn/3vA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add maintainers and mailing list entries to Tegra Quad SPI driver
section.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b20bab..19db61f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17447,6 +17447,14 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/spi/spi-tegra*
 
+TEGRA QUAD SPI DRIVER
+M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Jonathan Hunter <jonathanh@nvidia.com>
+M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-tegra210-quad.c
+
 TEGRA VIDEO DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
-- 
2.7.4

