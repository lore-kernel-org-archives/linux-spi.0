Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B419C4708A
	for <linux-spi@archiver.kernel.org>; Thu, 27 May 2021 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C1A60241
	for <linux-spi@archiver.kernel.org>; Thu, 27 May 2021 16:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhE0Q6Z (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 27 May 2021 12:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233979AbhE0Q6Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 May 2021 12:58:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 789DF60241;
        Thu, 27 May 2021 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622134611;
        bh=eqGRT8+0Q3Rmh6KbWrgwiBmTSaJZANI0gXdqD+KAZwI=;
        h=Subject:From:Date:To:From;
        b=aXH5lUE+pvcBrIE+aMJH9t1M4vM7wcRYz7XNnwwBd9p5gnwsbKv0jykNI1bUpIVRX
         7BRsX6OMP4WaUVHvCLSXP/G9JvBSUBK6WRC1W2fbjCCvy/ZFJYmGKf+hed8VnTar8Q
         uQFDsFY5pBbVkDq0ORS2e3e4a/7SzyOhiK2DNNzGa2iVZTtZFpbDX48wyKUhyyznp1
         QSMsQouvvHTj38FoYb27wnnf7GPLa4CEcIa7+hHKfPOBb4ZGv9xZPBPiANz6nSTJn0
         ZckeFFL/skPuNAJX1fLtJwganOk9AA1+BgG5nUJhQEF4SZB+0LLKNZuyBa9qEsTFug
         EakdwWNQixIjg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162213461146.19479.5017833721653328596.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 May 2021 16:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spinand: add SPI-NAND MTD resume handler (2021-05-27T16:12:52)
  Superseding: [v2] mtd: spinand: add SPI-NAND MTD resume handler (2021-05-27T08:49:59):
    [v2] mtd: spinand: add SPI-NAND MTD resume handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

