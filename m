Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D5C433B4
	for <linux-spi@archiver.kernel.org>; Wed, 28 Apr 2021 16:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11D96143B
	for <linux-spi@archiver.kernel.org>; Wed, 28 Apr 2021 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbhD1QzF (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241394AbhD1QzF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Apr 2021 12:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1909861400;
        Wed, 28 Apr 2021 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619628859;
        bh=ySVMghZeI5fHPHGYBJlnrPCfazx2RoOVY8KdQHG61H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRs7Asae99E4vJRp7lVpghzBTWdsq0UoLygYsZpGDZvGB3S9/5pX569euCGClWFiH
         JSNcO/lnn1RznW54ZNqZGKBc4HeJxpgTDtMGtxS5mJaoD12xH8O4s4qC6EkVVFWS+Q
         sC2CA/kzTKGbAUKY1SjD26CJCLRl8pEECmop7ieCvOZY46Uw0IlHs/UJDIkSGwnUJp
         pWZ9q+ISvM78szCzh04xooHVt4Y8Pur3Ko/suNOLz0gM1MeCCLiVM6Wa+9+mJ6meA6
         /HwTgKTghD3EO0pm20c0MkWr9e2hXPSAFcGc3mP9oGNa6lkkT8FZ0ICk/yEGkWdK+h
         u5L15vdsOUouA==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: altera: Make SPI_ALTERA_CORE invisible
Date:   Wed, 28 Apr 2021 17:53:42 +0100
Message-Id: <161962869504.49700.12411113153375718641.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <f0cb8e66baba4506db6f42fca74dc51b76883507.1619534253.git.geert+renesas@glider.be>
References: <f0cb8e66baba4506db6f42fca74dc51b76883507.1619534253.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Apr 2021 16:38:42 +0200, Geert Uytterhoeven wrote:
> The SPI_ALTERA_CORE config symbol controls compilation of the Altera SPI
> Controller core code.  It is already selected by all of its users, so
> there is no reason to make it visible, unless compile-testing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: altera: Make SPI_ALTERA_CORE invisible
      commit: 41f48a29ebd5ce944e412f491f1876b5abeff1d6

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
