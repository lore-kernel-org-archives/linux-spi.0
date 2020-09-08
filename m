Return-Path: <SRS0=Lsrg=CR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F9C2BC11
	for <linux-spi@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138D8204FD
	for <linux-spi@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595554;
	bh=MY/DSqxbqV2n2fD7zRBPwYDNqFZz1cBsqEDi/lzWy2I=;
	h=Subject:From:Date:To:List-ID:From;
	b=0wbeIxtg5lllvRn2b7GUgZjl29n2jOCRuRWXfJran/lSgzTDMN9nfpOdxmEOy+QSP
	 KIcGEgD2kDZ61fHfdo9nh3v0HU7gT5Lu9OgxOF2F8sjWqvpFRE/9VGv5likLwRCY7G
	 fWTFYkriz4X9tfOHjrngfj9jRSn+BP7qrjg62M04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbgIHUFq (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbgIHPV5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:57 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599576009;
        bh=MY/DSqxbqV2n2fD7zRBPwYDNqFZz1cBsqEDi/lzWy2I=;
        h=Subject:From:Date:To:From;
        b=gAhuYxc5spOE2IsSsP85ZVFZC7nchOzJu6q1GV+ev0xZ9zxFezRldInohddRuZBqA
         zQYAl6E4cWlO4vgySzcxPWiVNw8pXBOYooW4Smar03J4Wr2zKGkfwRJt1VWfoDAN53
         XqzvS1Lp7k9RDeotF1C7WOnyS/d5cMXEcdMsGDj0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159957600914.24414.8315822306651192078.git-patchwork-summary@kernel.org>
Date:   Tue, 08 Sep 2020 14:40:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
  Submitter: Vignesh Raghavendra <vigneshr@ti.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=341031
  Link: <20200831130720.4524-1-vigneshr@ti.com>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
