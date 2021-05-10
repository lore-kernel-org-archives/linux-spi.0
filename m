Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54409C433B4
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B636101B
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 08:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEJIWx (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 10 May 2021 04:22:53 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:26834 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhEJIWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 04:22:53 -0400
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 14A8Ldmm031761;
        Mon, 10 May 2021 16:21:39 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, broonie@kernel.org,
        jaimeliao@mxic.com.tw, Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v4 0/2] Add octal DTR support for Macronix flash
Date:   Mon, 10 May 2021 16:20:34 +0800
Message-Id: <1620634836-13181-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 14A8Ldmm031761
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for Octal DTR for Macronix flashes. The
first set of patches is add Macronix octal dtr mode support and
Macronix octaflash series support. The second add the Octal DTR
mode support for host driver.

Changes in v4:
- merge patch 2(support octaflash Id) to patch 1(support octal dtr)
- add switching back to default mode(1-1-1) support if octal dtr is
  disabled
- delete the duplicate code settings initialized by the Profile 1.0
  table. (such as cmd_ext_type, rdsr_dummy, rdsr_addr_nbytes, etc.)
- add a description about stacked die

Changes in v3:
- Add support for Macronix octaflash series.

Changes in v2:
- Define with a generic name to describe the maximum dummy cycles.
- Compare the ID directly in the loop, no longer copy and execute
  memcmp().
- Add spi_mem_dtr_supports_op() to support dtr operation.

Zhengxun Li (2):
  mtd: spi-nor: macronix: add support for Macronix octaflash
  spi: mxic: patch for octal DTR mode support

 drivers/mtd/spi-nor/macronix.c | 172 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-mxic.c         |  41 +++++++---
 2 files changed, 202 insertions(+), 11 deletions(-)

-- 
1.9.1

