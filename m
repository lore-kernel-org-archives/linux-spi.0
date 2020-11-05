Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA40C6379F
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE2520BED
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 12:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgKEMEm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:04:42 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:48537 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgKEMEm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 07:04:42 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A5BxvqB068678;
        Thu, 5 Nov 2020 19:59:58 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Nov
 2020 20:03:36 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <clg@kaod.org>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 2/4] ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for spi-aspeed.c
Date:   Thu, 5 Nov 2020 20:03:29 +0800
Message-ID: <20201105120331.9853-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A5BxvqB068678
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

- Adjust the value format of "reg" property:
  Instead of platform_get_resource(),
  platform_get_resource_byname() function can be used
  for more human-readable.
- Add "num-cs" property for FMC/SPI controller:
  Each ASPEED FMC/SPI memory controller can support more
  than a chip select. By "num-cs" property, FMC/SPI
  controller driver can know how many chip select related
  registers should be initialized at the probe stage.
  Besdies, with this property, driver can avoid accessing
  chip select which CS number is larger than the maximum
  one supported by the controller.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index b58220a49cbd..8a5c798db54e 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -89,14 +89,16 @@
 			};
 
 		fmc: spi@1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>,
+				<0x20000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-fmc";
 			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs = <3>;
 			flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
@@ -118,12 +120,14 @@
 		};
 
 		spi1: spi@1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0xc4>,
+				<0x30000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
+			num-cs = <2>;
 			status = "disabled";
 			flash@0 {
 				reg = < 0 >;
@@ -140,12 +144,14 @@
 		};
 
 		spi2: spi@1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x50000000 0x10000000 >;
+			reg = < 0x1e631000 0xc4>,
+				<0x50000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
+			num-cs = <3>;
 			status = "disabled";
 			flash@0 {
 				reg = < 0 >;
-- 
2.17.1

