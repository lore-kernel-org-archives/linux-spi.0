Return-Path: <SRS0=SzkN=EI=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956CC388F9
	for <linux-spi@archiver.kernel.org>; Mon,  2 Nov 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07D121556
	for <linux-spi@archiver.kernel.org>; Mon,  2 Nov 2020 07:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgKBHxG (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 Nov 2020 02:53:06 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:18020 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBHxC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 02:53:02 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A27mtqW046597;
        Mon, 2 Nov 2020 15:48:55 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 2 Nov
 2020 15:52:23 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <clg@kaod.org>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/4] Porting ASPEED FMC/SPI memory controller driver
Date:   Mon, 2 Nov 2020 15:52:09 +0800
Message-ID: <20201102075213.32404-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A27mtqW046597
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series aims to porting ASPEED FMC/SPI memory controller
driver with spi-mem interface. Adjust device tree setting of SPI NOR
flash in order to fit real AST2600 EVB and new SPI memory controller
driver. Also, this patch has been verified on AST2600-A1 EVB.

Chin-Ting Kuo (4):
  dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory
    controller
  ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for
    spi-aspeed.c
  ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
  spi: aspeed: Add ASPEED FMC/SPI memory controller driver

 .../bindings/spi/aspeed,spi-aspeed.yaml       |  66 ++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  26 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  18 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-aspeed.c                      | 967 ++++++++++++++++++
 6 files changed, 1078 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
 create mode 100644 drivers/spi/spi-aspeed.c

-- 
2.17.1

