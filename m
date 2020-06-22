Return-Path: <SRS0=uPEC=AD=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B9DC433E1
	for <linux-spi@archiver.kernel.org>; Mon, 22 Jun 2020 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA8020708
	for <linux-spi@archiver.kernel.org>; Mon, 22 Jun 2020 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592838009;
	bh=xhAOCU2jOSXPmAfCdrD+YhDx88scZurNj251LepzMvY=;
	h=Subject:From:Date:To:List-ID:From;
	b=TLqkX8rgH316g0m4xxdktWVl4FEFLDvqqcqyxRbQ8qE8X+OEfR0xzkaYreXPW8xJb
	 PYC0ni0SEsxN8So9MMFvUi+VoaBNmuq7kn5TsnM9h5zzz1o6pm3AYVgdmR+E2T9QDE
	 lQuy4X3C4naXxE1dUmAOlEyPSbVZaOYxXF9CRjZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgFVPAI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgFVPAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jun 2020 11:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592838008;
        bh=xhAOCU2jOSXPmAfCdrD+YhDx88scZurNj251LepzMvY=;
        h=Subject:From:Date:To:From;
        b=t5tzlei/rrnY855kYO05Jgiv/gbq3WUcR7CJHWttsFu+2UnXbn0Us8lRfw4IUA2SU
         kOgOUKV/9yXHBRKhkFLUzdgzNamUIz34E8qKJSRmn/CCvcKGLU9rj1dY3Cld/fmP6f
         +atMfuu5HVPYgjk9syDNBwrkJFmQI6pVfnVJhoi0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159283800824.19223.9841350253360531369.git-patchwork-summary@kernel.org>
Date:   Mon, 22 Jun 2020 15:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v4,1/4] spi: spi-fsl-dspi: Fix lockup if device is removed during SPI transfer
  Submitter: Krzysztof Kozlowski <krzk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=306461
  Link: <20200622110543.5035-1-krzk@kernel.org>
    Patches: [v4,1/4] spi: spi-fsl-dspi: Fix lockup if device is removed during SPI transfer
             [v4,2/4] spi: spi-fsl-dspi: Fix lockup if device is shutdown during SPI transfer
             [v4,3/4] spi: spi-fsl-dspi: Fix external abort on interrupt in resume or exit paths
             [v4,4/4] spi: spi-fsl-dspi: Initialize completion before possible interrupt

Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
