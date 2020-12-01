Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC84C8301F
	for <linux-spi@archiver.kernel.org>; Tue,  1 Dec 2020 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C7220705
	for <linux-spi@archiver.kernel.org>; Tue,  1 Dec 2020 21:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ICaWzP82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbgLAVNb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:13:31 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6349 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgLAVNa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d20000>; Tue, 01 Dec 2020 13:12:50 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:49 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:48 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 1/7] MAINTAINERS: Add Tegra QSPI driver section
Date:   Tue, 1 Dec 2020 13:12:42 -0800
Message-ID: <1606857168-5839-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857170; bh=qrhfsrZpqRU/iOlH/GqZ036FOebreDSCDusFYxOFKnw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=ICaWzP82EKEcVwTFISB3QbjtcL2lsR9EPGSA/LX/Je2u3c+LBAGyIHl1BdjeCuk7n
         LOEbfxBP9SCU2dBtZIpB/gdL7AQSIgy6Gy7+3Dnda4NBN7QVRLV/AvYVdv60w0Kkbe
         P78GqZehORoGWApV/E7LltwDy6KpssRfEJxcSmS0dInIU7yb8y+OBuTsquvUgBNd/C
         q6ZpLVdMcvMyARUKD6To9VPKU63PDawQTyAQ24HLpIHQXhRvjZJi0khEbYvcFamXND
         mxT6Ptg0WNnNGdhZ4vOtpZ27mKVJUGH+XJnhSHPQOOFUiZyZTRwkAYw1XFlROfUEJf
         hVtnS3vYP0GuQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add maintainers and mailing list entries to Tegra QSPI driver section.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cec5a0..d0fe832 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17346,6 +17346,14 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/spi/spi-tegra*
 
+TEGRA QSPI DRIVER
+M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Jonathan Hunter <jonathanh@nvidia.com>
+M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/qspi-tegra.c
+
 TEGRA VIDEO DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
-- 
2.7.4

