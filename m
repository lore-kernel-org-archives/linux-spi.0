Return-Path: <SRS0=qHKQ=AV=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2697C433E0
	for <linux-spi@archiver.kernel.org>; Fri, 10 Jul 2020 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986A8206A1
	for <linux-spi@archiver.kernel.org>; Fri, 10 Jul 2020 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594416020;
	bh=3UyYvgIy5H+iKfnfLG/ORPdVEhbAsGfzsW98aBg8D/8=;
	h=Subject:From:Date:To:List-ID:From;
	b=gQOIs1IcFX0NEZxyeig/4uemkaxFiImFZK4rMR8ipfe3J0CHCHXCmYu1i3QZL1Di2
	 JDiAyy1QHBdkhozCOLq+jOYkf+VmF96SkKAUQjCpJW7taVTj2SE5PRcEzneT9PtnOR
	 FyDb9J0sjOXTOdJmblAVXQa/tWVJgmGsWO37B54s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGJVUU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgGJVUU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jul 2020 17:20:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594416020;
        bh=3UyYvgIy5H+iKfnfLG/ORPdVEhbAsGfzsW98aBg8D/8=;
        h=Subject:From:Date:To:From;
        b=tE/yDLLeWo04qfPaKXWIRL8QbscitlzSwRm4OowLMhm5naFZyaEA0UCcecRLWvvIX
         ngDGjXBHasNZ3RIUJk7qy2F8LtZEaQUwHuT3LMdLupp9GmpNzIFttC9nQET/lbnOku
         15bMuDXFjtkGIsngllQN+0AGRkwT130HSwz0Yh20=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159441602004.28026.3786005516559930278.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Jul 2020 21:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T21:16:55)
  Superseding: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T04:51:40):
    spi: spi-cadence: add support for chip select high


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
