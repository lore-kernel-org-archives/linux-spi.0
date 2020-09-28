Return-Path: <SRS0=BcLs=DF=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B8C2D0A8
	for <linux-spi@archiver.kernel.org>; Mon, 28 Sep 2020 08:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F9E20E65
	for <linux-spi@archiver.kernel.org>; Mon, 28 Sep 2020 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601283450;
	bh=O/8Wl+7cDhc2Fib7BoMxMciXI2MK0uqa2a1aU2xOgME=;
	h=Subject:From:Date:To:List-ID:From;
	b=m+4EkAIekj8VJZHVgZQrw2bkNe2loRkP7Qks+zW2aBI2Fo1DVgglf/TIHVHACqvgC
	 PNcxE0/5OEtqP896dLcbr98AkhdXWsGgFysf42J+LRP3exG1R6OeiBD4qNqmapC3p8
	 xhXvhftWLuoVqgU03+XYTkfBO2skJprxBzk9mbIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1I53 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 28 Sep 2020 04:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1I53 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Sep 2020 04:57:29 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601283449;
        bh=O/8Wl+7cDhc2Fib7BoMxMciXI2MK0uqa2a1aU2xOgME=;
        h=Subject:From:Date:To:From;
        b=z37m29ZmTn7Q7J6PLvSnRrZlGhSDps1qY97FE6qxOxIWxFlAFzrTQ2xfk0FTIMi3u
         +ldaDpURdOQGF9pSeAl9Osa40qlcaQ/c/wmFYRSRg8z8p1+rMVCW0tVAf1JZd8ZfbC
         mY5iHzicGQCyxZ/f5hmczVa1wc1PfA6lDp0TfTvw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160128344937.7014.238336427169176508.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Sep 2020 08:57:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: fsl-dspi: fix NULL pointer dereference (2020-09-28T08:55:00)
  Superseding: [v1] spi: fsl-dspi: fix NULL pointer dereference (2020-09-27T22:43:36):
    spi: fsl-dspi: fix NULL pointer dereference
  Superseding: [v2] spi: fsl-dspi: fix NULL pointer dereference (2020-09-28T08:32:38):
    [v2] spi: fsl-dspi: fix NULL pointer dereference


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

