Return-Path: <SRS0=zXQu=77=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF01C433E0
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A61620734
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592493618;
	bh=NTKLfPva2y1Qfd/pD0F0oA8h4O9JiS7Qe1vXmXwLhFU=;
	h=Subject:From:Date:To:List-ID:From;
	b=Sf8zHSF+4p+wPGJU6hKmNcO8AReQOscA/d9bqTpbhRl9npH2Yygb2qKdwIahkrjg7
	 nOWJvGDEtrWUP5cDf4dvT3b1dPIm7gt8X0/FJRgwDy6wohR/4NUBIgOgGeW42jp52A
	 sw2UqDy9j/ONqgTDGUb5XfJxeANd39ImZDhde/CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFRPUS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFRPUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592493617;
        bh=NTKLfPva2y1Qfd/pD0F0oA8h4O9JiS7Qe1vXmXwLhFU=;
        h=Subject:From:Date:To:From;
        b=BHCuRORcXsvBNbM1YplPTUlHhzcrvulmYemeVMCGu54DuA/yEd7iKs+LM3QZjkLoF
         +Og1xxVT+N+sijPjakq4UixLz71fbiQgr4JusUWM/FC9zZhdFxFfwrGZqtUb+kvtj6
         oG9/vbTqqx3q0CyH8ZqPJmwhc8gqA72cw6A8+wnA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159249361748.11477.17617425409636453575.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 18 Jun 2020 15:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-geni-qcom: Fixes / perf improvements (2020-06-18T15:06:23)
  Superseding: [v3] spi: spi-geni-qcom: Fixes / perf improvements (2020-06-16T10:40:45):
    [v3,1/5] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
    [v3,2/5] spi: spi-geni-qcom: Mo' betta locking
    [v3,3/5] spi: spi-geni-qcom: Check for error IRQs
    [v3,4/5] spi: spi-geni-qcom: Actually use our FIFO
    [v3,5/5] spi: spi-geni-qcom: Don't keep a local state variable


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
