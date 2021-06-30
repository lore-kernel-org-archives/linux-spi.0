Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2CC11F65
	for <linux-spi@archiver.kernel.org>; Wed, 30 Jun 2021 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB806147D
	for <linux-spi@archiver.kernel.org>; Wed, 30 Jun 2021 16:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhF3QNb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3QNb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 12:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84CE661456;
        Wed, 30 Jun 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625069462;
        bh=Mn6BvXNRp0phAqi6zTdlYuSEGtWIvr3Z3ZC/zZJaBEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLwnimKq6hyYCW3BqM/23ionIcvsfNBkyoMyHgU6iSp0WZLTbGdggsInvc8h+FuOe
         3iGMY/PoI4WTYi38sKKhiRmbVjWM3eVIGyQXRgEiLQ1PHyh1ZuPJvdtJEVleNyPcok
         r3dwu6rey7IERKoRrDWAn8GxR1d3P5D8JouEJ0PjtWGcIJwB74BLBbkdNg2A7vvzcg
         +M+UzKQKvOiIhmlZReIl4DYBlfNXmRRaEgZl4MLszvikVmbj7G8ZLE2Aa34kS5Vi7v
         XJ3VS4kHXwM/QR1MG+Ld9PCBsXc8oEaOTWtNX0LQI+4msrfaKjPekp9V19suP89V9Y
         qRLv+zdKwPzTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        amelie.delaunay@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>, alexandre.torgue@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com,
        linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] spi: stm32: various fixes & cleanup
Date:   Wed, 30 Jun 2021 17:10:30 +0100
Message-Id: <162506903591.43818.15164606693002988349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 30 Jun 2021 10:45:17 +0200, Alain Volmat wrote:
> This series contains fixes & cleanup mainly regarding fifo
> and the way end of transfer triggered, when used with or
> without DMA.
> An additional patch cleans up the pm_runtime calls.
> 
> Alain Volmat (5):
>   spi: stm32: fixes pm_runtime calls in probe/remove
>   spi: stm32h7: fix full duplex irq handler handling
>   Revert "spi: stm32: properly handle 0 byte transfer"
>   spi: stm32h7: don't wait for EOT and flush fifo on disable
>   spi: stm32: finalize message either on dma callback or EOT
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/6] spi: stm32h7: fix full duplex irq handler handling
      commit: e4a5c19888a5f8a9390860ca493e643be58c8791

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
