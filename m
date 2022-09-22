Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FCCC6FA82
	for <linux-spi@archiver.kernel.org>; Thu, 22 Sep 2022 10:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIVKaf (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIVKae (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 06:30:34 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B158B56FA
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 03:30:33 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4H-00Bx10-Ef
        for linux-spi@vger.kernel.org; Thu, 22 Sep 2022 12:04:31 +0200
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4H-00Bx0w-AR; Thu, 22 Sep 2022 12:04:29 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4G-004cfB-Mj; Thu, 22 Sep 2022 12:04:28 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: [PATCH 0/3] Add support for the Airoha EN7523 SPI controller
Date:   Thu, 22 Sep 2022 12:04:07 +0200
Message-Id: <20220922100410.1101874-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver will likely also work on other Airoha SoCs, but this will
need testing. Only basic single- and dual-bit transfers are supported
for now, with DMA mode support yet to come.

Bert Vermeulen (3):
  dt-bindings: arm: airoha: Add documentation for Airoha SPI controller
  spi: Add support for the Airoha EN7523 SoC SPI controller
  ARM: dts: en7523: Add SPI node

 .../bindings/spi/airoha,en7523-spi.yaml       |  54 ++++
 arch/arm/boot/dts/en7523-evb.dts              |  20 ++
 arch/arm/boot/dts/en7523.dtsi                 |  11 +
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-en7523.c                      | 305 ++++++++++++++++++
 6 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
 create mode 100644 drivers/spi/spi-en7523.c

-- 
2.25.1

