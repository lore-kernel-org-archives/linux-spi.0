Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CEC4338F
	for <linux-spi@archiver.kernel.org>; Wed, 28 Jul 2021 23:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8F76101B
	for <linux-spi@archiver.kernel.org>; Wed, 28 Jul 2021 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhG1X2K (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1X2K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96DCA60E9B;
        Wed, 28 Jul 2021 23:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514888;
        bh=4zRkPw86lvSt/UuJL0q/2Fk79VClXXHqjS/jH3XIJzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdRWNOGlC3TDIhYQoJi2yhiqWRe/lsZw0GIrE9dSZgMv4vjx/cNg/P2/BDCU3jW2u
         7L+5eyG097KYeVb7gL6JKwLw09u8nPC3WaIeZvXjcF3EeBYw7Ej9Uwv2auLrfIyqkw
         n1Ihhl2i5zLLeI5JAylzUCT4HvE3PxZI/6Y1wjzpPsWOwaZqOlju5Ct/wVTi4vvaxd
         Hueg8OLtZG7vYw0kSGsJ7wlRfryS0GyHz/tOMVBAgyrpTu+0+1eGjWVJxNA7IRJoOP
         RHAvnVTo6qaXk1GmVxF63w9RuaLknIzmgiTS6GAVUDjWFNJkDZdrSJVr77cgHBcdqM
         zqu4pr4+A6OUA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Date:   Thu, 29 Jul 2021 00:27:51 +0100
Message-Id: <162751436509.10613.6487263379205830431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727160428.7673-1-marex@denx.de>
References: <20210727160428.7673-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Jul 2021 18:04:28 +0200, Marek Vasut wrote:
> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
> the min_speed_hz must be above 200000 (i.e. 200001 rounds down to 9, so
> the condition triggers). Update the comment. No functional change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
      commit: 36c2530ea963884eeb0097169f853fdc36f16ad7

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
