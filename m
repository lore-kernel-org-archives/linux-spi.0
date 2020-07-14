Return-Path: <SRS0=18s3=AZ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED1C433E7
	for <linux-spi@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2A320656
	for <linux-spi@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594744821;
	bh=1KO/MpQ3Pq5Ca5GKtVr97k3wPRcbRfJgMXVqW1M2eoA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=laddE/aPA4BlY0iy57D4BJzb/RQVPD8ygQuPRRY2fGCPalnCdr4wam5/0Cr8XkYJA
	 egL3EZOI3K15mm+73fArMbCveh7Ixb+gXpA22/eersYG/qK1HeQPhyhhEsk4ExgAHG
	 q3wssgsWKFXL8C6SS+NZt+MOeYIP/7qbrmMG7v9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgGNQkV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgGNQkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 12:40:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0354B20656;
        Tue, 14 Jul 2020 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594744820;
        bh=1KO/MpQ3Pq5Ca5GKtVr97k3wPRcbRfJgMXVqW1M2eoA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cAUxtEOSBGFzmEruXpkHmxQ6W8B1eJPPcBCM44nndqexZ13bJUv/SoO+9AANoO66B
         Rz/AOl0XTbJC3T/cJSZJ4NppUclCzYrOyoCu3w0XPtY/WusYmshvWMytaMjB+Dx0XK
         PZdtNiMht2DFeJcaanssgqz41Osm0X9DxJp7ZnRk=
Date:   Tue, 14 Jul 2020 17:40:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20200714073357.34879-1-linus.walleij@linaro.org>
References: <20200714073357.34879-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: omap-100k: Drop include
Message-Id: <159474480412.1281.723718354270670730.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jul 2020 09:33:57 +0200, Linus Walleij wrote:
> The OMAP-100k driver includes <linux/gpio.h> but does not
> use any symbols from it, so drop the include.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap-100k: Drop include
      commit: 8257083f8bcf942b8f607272f30e838a0b930c43

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
