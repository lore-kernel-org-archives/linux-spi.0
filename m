Return-Path: <SRS0=dNl4=7Y=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC9C433DF
	for <linux-spi@archiver.kernel.org>; Thu, 11 Jun 2020 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CF2206DC
	for <linux-spi@archiver.kernel.org>; Thu, 11 Jun 2020 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591890008;
	bh=489mP0CI2c/wPHJP+unLMs0gU9chyW5UBSZ8Y4xx/vA=;
	h=Subject:From:Date:To:List-ID:From;
	b=JC+226I8Q1ZATa6n/FYr+yKvBUuGQ4Os1+xV45U+ZoemrqZMA1/jvT+m0GoqOqvSe
	 VLIGjv8Bg1eCYcqJBG8Jc1g1fFC0YYc/Yf7tzx5phJ0S24J4weteAMTk2jHp4Lot4r
	 YgxtASM40pP5fTuk6UdIq8/H+Fd8Y7SIJU6MMkrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgFKPkI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFKPkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 11:40:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591890008;
        bh=489mP0CI2c/wPHJP+unLMs0gU9chyW5UBSZ8Y4xx/vA=;
        h=Subject:From:Date:To:From;
        b=mW6BTfV2jDoBc9YsBi+f1RqBruf12Qf0a21jbAmLAvcaOUwIMZnwRjZSyv1zvdbVh
         M/Jq8CFY6Ee6HD8ClztO5cYAucHRT6NwEmNVBPzeNMY2+0xiUGRjWhcrfgGJn3f4d8
         R7J9leZoa84a78RCTso+fF4cR9oRIAF6bDjVwgew=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159189000813.27079.9502809325466450376.git-patchwork-summary@kernel.org>
Date:   Thu, 11 Jun 2020 15:40:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v2,1/2] spi: tools: Make default_tx/rx and input_tx static
  Submitter: Qing Zhang <zhangqing@loongson.cn>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=301299
  Link: <1591880212-13479-1-git-send-email-zhangqing@loongson.cn>
    Patches: [v2,1/2] spi: tools: Make default_tx/rx and input_tx static
             [v2,2/2] spi: tools: Add macro definitions to fix build errors

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
