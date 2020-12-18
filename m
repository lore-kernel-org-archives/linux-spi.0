Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031ADC4361B
	for <linux-spi@archiver.kernel.org>; Fri, 18 Dec 2020 18:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51C323B5D
	for <linux-spi@archiver.kernel.org>; Fri, 18 Dec 2020 18:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLRSaZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 18 Dec 2020 13:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgLRSaY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Dec 2020 13:30:24 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, msavaliy@qti.qualcomm.com,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        akashast@codeaurora.org, Girish Mahadevan <girishm@codeaurora.org>,
        linux-spi@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
In-Reply-To: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
Subject: Re: [PATCH v3 1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
Message-Id: <160831617040.28906.13669127312905606998.b4-ty@kernel.org>
Date:   Fri, 18 Dec 2020 18:29:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 17 Dec 2020 14:29:11 -0800, Douglas Anderson wrote:
> In commit 7ba9bdcb91f6 ("spi: spi-geni-qcom: Don't keep a local state
> variable") we changed handle_fifo_timeout() so that we set
> "mas->cur_xfer" to NULL to make absolutely sure that we don't mess
> with the buffers from the previous transfer in the timeout case.
> 
> Unfortunately, this caused the IRQ handler to dereference NULL in some
> cases.  One case:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
      commit: 4aa1464acbe3697710279a4bd65cb4801ed30425
[2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
      commit: 690d8b917bbe64772cb0b652311bcd50908aea6b
[3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
      commit: 3d7d916f9bc98ce88272b3e4405c7c685afbfcd6
[4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS
      commit: 17fa81aa702ec118f2b835715897041675b06336

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
