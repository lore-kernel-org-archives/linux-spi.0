Return-Path: <SRS0=oBVb=D5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44206C4363A
	for <linux-spi@archiver.kernel.org>; Thu, 22 Oct 2020 07:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC75222E9
	for <linux-spi@archiver.kernel.org>; Thu, 22 Oct 2020 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603353369;
	bh=L+ihSyJd5H30O984ztR1E32S/UuQVGXiBb2bEE8WoNk=;
	h=Subject:From:Date:To:List-ID:From;
	b=Z6VC8FRb2O+HdodueZEM3IggWCWyb4gt0KZY7HkG6YRZGn9i1TRCDmx2ibysWsBDt
	 PH4AbExhzsrXVzbmG6iJXFF46f6XNkxEgnktwrVMkZeperinEn8Diz0uZLZ/0thrHJ
	 CUlEp6tBijJ/vaRmo2NR9hm2Zg78FgiVcw31jj0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438092AbgJVH4I (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509075AbgJVH4I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Oct 2020 03:56:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603353368;
        bh=L+ihSyJd5H30O984ztR1E32S/UuQVGXiBb2bEE8WoNk=;
        h=Subject:From:Date:To:From;
        b=do3Ib9NFVqm8ElZJYkqLlIgWvzRaHbl0rG2hwF4sFvUczwdT3kqEwSJWhRwqx32Mc
         q1wln/ioS/Y0f/wLsCQWEfdyzb4LrRaSnw3XoDe9/a1XV7j0JSoHYLr9uvWXs/OgUN
         v4+IgYouv/caJ2I2ttNHS79MyDCA6+/P62t3Xsmg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160335336785.1082.11836887824810626087.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Oct 2020 07:56:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-22T07:52:21)
  Superseding: [v2] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-19T14:58:33):
    [v2] spi: spi-sun6i: implement DMA-based transfer mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

