Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0714C3DA7D
	for <linux-spi@archiver.kernel.org>; Tue,  3 Jan 2023 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjACOsa (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 3 Jan 2023 09:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACOs3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Jan 2023 09:48:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAD2BDB;
        Tue,  3 Jan 2023 06:48:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4380B80E4A;
        Tue,  3 Jan 2023 14:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58DC433EF;
        Tue,  3 Jan 2023 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672757306;
        bh=HQ/f5bb2T+vCcsil5attd5ZhSruOb+wwCOJdncMEw34=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KHlVYqB2TXbti8UdT3LdyF0rLG60zuy+c68G3irf9GnbDNjjIEpC0IbXOoNBY7sZ1
         RAjDRlZA8HVaJSF8/j/plrD3U6ZoQ9ejkRmR6m3RhTJqtyerUnASmmgHeoHFZknJxh
         K4ukOvooVWDQQKxMxzETP8KrqsMAb+JRralS7lmnEs6sGIcMZkA12Nye7xtxhdSyFS
         wNpnwwSathahyAf1CXKHc2hsKKKamJoNS5CDPeqWSDYmP3MeNcXmKiNkPAyLHLGUj7
         2AbR/alUi+dF9Mzt7FkT4CrMdysWAV37dUs0OrwJgITtNSJzAjHt+PsDHylY+o6wOm
         OIT2XYkPVO31A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230102160852.3090202-1-vincent.whitchurch@axis.com>
References: <20230102160852.3090202-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] spi: pl022: Only use DT-specified DMA channels
Message-Id: <167275730502.106091.7148795609007337973.b4-ty@kernel.org>
Date:   Tue, 03 Jan 2023 14:48:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 02 Jan 2023 17:08:51 +0100, Vincent Whitchurch wrote:
> When a platform is booted with devicetree and does not provide a
> platform data structure, the driver creates one internally.  enable_dma
> should not be set in this structure when creating it; the probe function
> will set it later if DMA channels are specified via the devicetree.
> 
> Setting enable_dma = 1 when creating this internal platform data can
> lead to pl022_dma_probe() finding bogus DMA channels (since there is no
> channel filter specified) when no DMA channels are specified in the
> devicetree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pl022: Only use DT-specified DMA channels
      commit: dfce16722b9cb842a6f23500ee80b3d07b47bdd4

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
