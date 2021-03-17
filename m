Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E286C433DB
	for <linux-spi@archiver.kernel.org>; Wed, 17 Mar 2021 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F9664F6A
	for <linux-spi@archiver.kernel.org>; Wed, 17 Mar 2021 13:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCQNl7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhCQNlp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Mar 2021 09:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3F3A64DFF;
        Wed, 17 Mar 2021 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615988505;
        bh=f4UAEQNRtpH9UQ8NCylaE3uRW1RanW+ukgXOpvx74bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1UzE2tMaILyKBm56VgA1V0PMwetYlAH/QWUHR1FC8Mm3LZk9mcVGWe4mWuUs0cnF
         iiYF7xgK74j6gZ9co/YQ9biC9kWUZmMfbKoQbRQB71j+QFQPL2o6YMpPTWEkm5gE+o
         dmuHWXAeXZnR28enHkriTxQuU5sodQfb8lvlV1rio+mq9ZSmWlSPzbXCkzQiexY2DU
         5cVV+vD2j+NzZLm53+VvqPM1x2oZJVr3rxhf3zunZYEihz4TpnnlHi4XndkvFTgDlw
         xnz/Xt19lkA6pRuv9XkvHrvWv5AyqTM1XhHOZLu70CNWU/F1r2IxTrYIuG4dVvqfXl
         xhZRW7AkW5lAg==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, s.hauer@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Improve driver description
Date:   Wed, 17 Mar 2021 13:41:37 +0000
Message-Id: <161598843909.8643.6777001095876039228.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316180922.239805-1-festevam@gmail.com>
References: <20210316180922.239805-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Mar 2021 15:09:22 -0300, Fabio Estevam wrote:
> "SPI Controller driver" is a too generic description.
> 
> Make it i.MX specific instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Improve driver description
      commit: 92bad4a4c755cdf286f6b303dd482a573f2b89e6

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
