Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22DC001DB
	for <linux-spi@archiver.kernel.org>; Mon,  7 Aug 2023 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHGRiD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGRhu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 13:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7BF9
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 10:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E456862066
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 17:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8483C433C7;
        Mon,  7 Aug 2023 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691429868;
        bh=KxRO8GCv49oJ7LjC1S+CLJ5YzNMpUcR3GpqWoMiY7RQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OqeE2ZK+mrhG+dfvgG+mjSSjjyY7VdgO7GAdXoxaqSQfKZYQ7GeBw0ia34AMFqSPh
         gMj4gnrq1/hDZJAey14HTiLSRPPP+gHqitNXfAIXZW7wHBrPKHJPvRY5dtzI5kK4wP
         8D3tMR1N1d4tysDtr+ziCv8OaIODlT2kKpXWIC8UwBCfLuUFoOKiCEHujYvTH+eD8r
         F/BPYGMyNF9gt4r6JHxE0OU6kmCJ0Oi1RcLupUB2b0ckR3nwD0ccGCEkLgQ7xPiF2N
         972eedUbm3bPkBssjvt1IKdf4/GsULr6FRsih7cg0UKvYx5VvXKx/6mlq4TrsbsX0l
         envUPoyCeOGZg==
From:   Mark Brown <broonie@kernel.org>
To:     florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230802093238.975906-1-ruanjinjie@huawei.com>
References: <20230802093238.975906-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: Do not check for 0 return after calling
 platform_get_irq()
Message-Id: <169142986647.186586.15665528504726933668.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 18:37:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 02 Aug 2023 17:32:38 +0800, Ruan Jinjie wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Do not check for 0 return after calling platform_get_irq()
      commit: 8102d64c04e8ead02c30bb07ff7dd5c41ed61bce

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

