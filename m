Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0088C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 21 Dec 2020 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3722B30
	for <linux-spi@archiver.kernel.org>; Mon, 21 Dec 2020 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLUVTB (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:19:01 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4588 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLUVTA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:19:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe110ff0000>; Mon, 21 Dec 2020 13:17:51 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:47 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:46 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 8/9] arm64: tegra: Add QSPI nodes on Tegra194
Date:   Mon, 21 Dec 2020 13:17:38 -0800
Message-ID: <1608585459-17250-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585471; bh=/lSTqqTHqFE9roqfGoRxcE4iFCumGPCqs0O1t4Uo1Wk=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=PzW/jtIIkTslF1CXB5Zmhv6Hhtu6i63nQqqyT6CcwTZS1re6tpEmA211EJlyXRMm0
         pNcxMBtRWJQ8bSpKi4xGLsYuv+D3UJtIOpkH9DeJqNj4rNepK1p2FR7Acp0jL5XfHn
         qODaxcJOdTCs+BO9BGRK69i7zp4tPhrRVRF+rMgKJshqTopLYCLutWB8hlpITZcXAH
         uwZ7rVU8uSysXywoWgQ6+Nte/zDxxDF+HmwMB5aE+X/2DDfHBJR+uxsxKmg+1ovMgC
         7kiP/mU/jxvh3ulOeVYSn08AE7PcN/0q13gCwnHXsmH3lukjQTNWtnO0R6GKFDBdjS
         Mq7Om+AluFO1g==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra194 has 2 QSPI controllers.

This patch adds DT node for these 2 QSPI controllers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 25f36d6..852980f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -609,6 +609,34 @@
 			status = "disabled";
 		};
 
+		spi@3270000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3270000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI0>,
+				 <&bpmp TEGRA194_CLK_QSPI0_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA194_RESET_QSPI0>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
+		spi@3300000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3300000 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI1>,
+				 <&bpmp TEGRA194_CLK_QSPI1_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA194_RESET_QSPI1>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
 		pwm1: pwm@3280000 {
 			compatible = "nvidia,tegra194-pwm",
 				     "nvidia,tegra186-pwm";
-- 
2.7.4

