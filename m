Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A28C433F5
	for <linux-spi@archiver.kernel.org>; Fri, 25 Feb 2022 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiBYQ43 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiBYQ43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 11:56:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2B1EE9D8;
        Fri, 25 Feb 2022 08:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6376361CE5;
        Fri, 25 Feb 2022 16:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702FAC340E7;
        Fri, 25 Feb 2022 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808155;
        bh=/QLXbudEUQREjOuoQKQjWYPKoRiAIsArcj3P6Cq7oHo=;
        h=From:To:Cc:Subject:Date:From;
        b=tP4WaSCasC/yzGYWwsfknTob1ctFZOHEooQatMbxnTvVWuTa49uBe8xhYrSd0a/T5
         ZVExCoaSssb6KNDSGTfDw2eEP63h/wItpV0qBvlHU38gudfxfx450mIqMbT+Ut9RNz
         mTZkkXxMzCVBfDGppX7JlbEmkARyhRnGzFNYkWaqpW24H1BW1deSKeUEWWFsbua4PN
         fAMu0f9TcpYhpF8WFjFu6Ehpp2xn05UO9YWqE1ht9HRIsCKLT6ppmvt6qzi3YIFxCp
         FF4O0LKeCXMClWViY2G/i5toxjhKBG405ODew3VTHrO+wOevD8WqLDWh1ulJ6eFtBb
         636R5l6SyHHrA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.17-rc5
Date:   Fri, 25 Feb 2022 16:55:44 +0000
Message-Id: <20220225165555.702FAC340E7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit f83a96e5f033fbbd21764705cb9c04234b96218e:

  spi: mediatek: Avoid NULL pointer crash in interrupt (2022-01-31 15:24:05 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc5

for you to fetch changes up to 80808768e41324d2e23de89972b5406c1020e6e4:

  spi: rockchip: terminate dma transmission when slave abort (2022-02-17 15:33:18 +0000)

----------------------------------------------------------------
spi: Fixes for v5.17

A few small driver specific fixes.

----------------------------------------------------------------
Jon Lin (2):
      spi: rockchip: Fix error in getting num-cs property
      spi: rockchip: terminate dma transmission when slave abort

Zhou Qingyang (1):
      spi: spi-zynq-qspi: Fix a NULL pointer dereference in zynq_qspi_exec_mem_op()

 drivers/spi/spi-rockchip.c  | 13 ++++++++++---
 drivers/spi/spi-zynq-qspi.c |  3 +++
 2 files changed, 13 insertions(+), 3 deletions(-)
