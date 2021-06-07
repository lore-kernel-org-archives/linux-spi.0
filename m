Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5ABC47094
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F3A610A2
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGLAR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:00:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:57080 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFGLAQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 07:00:16 -0400
Received: from localhost (unknown [192.168.167.105])
        by lucky1.263xmail.com (Postfix) with ESMTP id 009E9CD662;
        Mon,  7 Jun 2021 18:58:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26721T140687081854720S1623063484717111_;
        Mon, 07 Jun 2021 18:58:06 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8c7099462556522c4efe0feccf8f4ae2>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/6] Support ROCKCHIP SPI new feature
Date:   Mon,  7 Jun 2021 18:57:56 +0800
Message-Id: <20210607105802.23796-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Changes in v5:
- Change to leave one compatible id rv1126, and rk3568 is compatible with rv1126

Changes in v4:
- Adjust the order patches
- Simply commit massage like redundancy "application" content

Changes in v3:
- Fix compile error which is find by Sascha in [v2,2/8]

Jon Lin (6):
  dt-bindings: spi: spi-rockchip: add description for rv1126
  spi: rockchip: add compatible string for rv1126 and rk3568
  spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
  spi: rockchip: Wait for STB status in slave mode tx_xfer
  spi: rockchip: Support cs-gpio
  spi: rockchip: Support SPI_CS_HIGH

 .../devicetree/bindings/spi/spi-rockchip.yaml |  1 +
 drivers/spi/spi-rockchip.c                    | 95 +++++++++++++++----
 2 files changed, 80 insertions(+), 16 deletions(-)

-- 
2.17.1



