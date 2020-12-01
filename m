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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B628FC8301A
	for <linux-spi@archiver.kernel.org>; Tue,  1 Dec 2020 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652D420705
	for <linux-spi@archiver.kernel.org>; Tue,  1 Dec 2020 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i+OhcqrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgLAVNg (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:13:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14574 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389199AbgLAVNf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d70000>; Tue, 01 Dec 2020 13:12:55 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:54 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:53 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 5/7] arm64: tegra: Enable QSPI on Jetson Nano
Date:   Tue, 1 Dec 2020 13:12:46 -0800
Message-ID: <1606857168-5839-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857175; bh=eqoVZOt8xggWd8HDz8qlrd3I75eKS5YnjXsWNfXliw0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=i+OhcqrHfWkuxL98jbKN2BXdg1Yd5uL7hnp+9pY6QyHE+RY7BrSX5sIFNiUJFXc07
         Jr0DJn+2blV5Fgb8+y+NivvWrEb7UxRUr2P7zDF1cFYS8cPjKeNSREweBW4vGb9zGs
         QQqYS1bRmfqTareAmkPx0IyYDjZ4DRVPJsPW9kawppCy6K1VB3je/VcUm0yfZrVhEH
         p6tM24zDsYUluwhcPgIcaz+6nCV+Np5IfX0YE56M9WrxPxDREDRKKhSq5ydciI3xgQ
         Fg/cqpvAMpAi27Vw4KSYmw8Cee8/ecpaFvkukJ1kd34IlFaedRwmerlQvu8GliTHSL
         +Xf13WLnJD9Mg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Jetson Nano has Macronix MX25U3235F Quad SPI Flash.

This patch enables QSPI on Jetson Nano.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 6a877de..a1b4603 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -638,6 +638,18 @@
 		};
 	};
 
+	spi@70410000 {
+		status = "okay";
+
+		flash@0 {
+			compatible = "spi-nor";
+			reg = <0>;
+			spi-max-frequency = <104000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
+	};
+
 	clk32k_in: clock@0 {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
-- 
2.7.4

