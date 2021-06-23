Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC71DC48BC2
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18EF611C9
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFWQLp (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 23 Jun 2021 12:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhFWQLn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6530961002;
        Wed, 23 Jun 2021 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464565;
        bh=thhgwnhMO2xnAWqL7Ceox1dUfMDGS5PkB8ZPYFsW+Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu6bEqeuBDd6kTGAAeS5YwKMnpgcqWz9UE7gsSVW4/F0+fMWe8oQFI2UhkoY9qKM1
         4Yg3QU1nggRKhyPNVrycrtp8teyKYZVI/q+XM16WX6MBmLdu8RcQpa5Vzj4KoH0YxO
         /+E4ys+ccn5pQZN/wT224ZRIgtqIh2DfPjth4o8LMnmRYjH4tzcCoaxjusrOYETv+L
         WAN5d8y4O9KnQ8KK3+RpT5Q9mj+aPp6oBqBcDCrnOOvd7aRYKXP0uWuoMxz66Z8DFi
         h9CbFmmBI8YFbm4JQhHprqZ2ysZA+8PYLKxj1r5W3iOT4bHDxsHSSL5pBdXQfRHiHk
         K1gZmYKZt+ZYw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Ralf Schlatterbeck <rsc@runtux.com>,
        Mirko Vogt <mirko-dev|linux@nanl.de>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] spi: spi-sun6i: Fix chipselect/clock bug
Date:   Wed, 23 Jun 2021 17:08:50 +0100
Message-Id: <162446446389.55587.4675699927821368249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614144507.y3udezjfbko7eavv@runtux.com>
References: <20210614144507.y3udezjfbko7eavv@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 14 Jun 2021 16:45:07 +0200, Ralf Schlatterbeck wrote:
> The current sun6i SPI implementation initializes the transfer too early,
> resulting in SCK going high before the transfer. When using an additional
> (gpio) chipselect with sun6i, the chipselect is asserted at a time when
> clock is high, making the SPI transfer fail.
> 
> This is due to SUN6I_GBL_CTL_BUS_ENABLE being written into
> SUN6I_GBL_CTL_REG at an early stage. Moving that to the transfer
> function, hence, right before the transfer starts, mitigates that
> problem.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun6i: Fix chipselect/clock bug
      commit: 0d7993b234c9fad8cb6bec6adfaa74694ba85ecb

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
