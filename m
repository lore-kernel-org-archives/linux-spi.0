Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A4C433B4
	for <linux-spi@archiver.kernel.org>; Tue, 20 Apr 2021 07:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C6161220
	for <linux-spi@archiver.kernel.org>; Tue, 20 Apr 2021 07:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhDTHCB (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:02:01 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:23577 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhDTHB4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 03:01:56 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 13K6V2oB084137
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 14:31:02 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 13K6UM7b083760;
        Tue, 20 Apr 2021 14:30:22 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        broonie@kernel.org, jaimeliao@mxic.com.tw,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v3 0/3] Add octal DTR support for Macronix flash
Date:   Tue, 20 Apr 2021 14:29:36 +0800
Message-Id: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 13K6UM7b083760
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for Octal DTR for Macronix flashes. The
first set of patches is add Macronix octal dtr mode support. The
second set of patches add Macronix octaflash series support. The
last add the Octal DTR mode support for host driver.

Changes in v3:
- Add support for Macronix octaflash series.

Changes in v2:
- Define with a generic name to describe the maximum dummy cycles.
- Compare the ID directly in the loop, no longer copy and execute
  memcmp().
- Add spi_mem_dtr_supports_op() to support dtr operation.

Zhengxun Li (3):
  mtd: spi-nor: macronix: add support for Macronix octal dtr operation
  mtd: spi-nor: macronix: add support for Macronix octaflash series
  spi: mxic: patch for octal DTR mode support

 drivers/mtd/spi-nor/macronix.c | 217 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-mxic.c         |  41 +++++---
 2 files changed, 247 insertions(+), 11 deletions(-)

-- 
1.9.1

