Return-Path: <SRS0=zXQu=77=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4633C433E0
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC345208C7
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592498935;
	bh=JjYy4elxxB+2wBR7hAUU2Tjb0skJmcm3jUXYNY6Jq38=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Z2dTVju9zF+hifR6S1RmlRsOpoDV/iuLmpdYae/HKZrXcM38mauKqpPDk0UG4Wzx9
	 1GhiekMV7ZLpbz6AMxuTcTYkXn2PMKL5YBG4VagDjlh+endVIdCdr/Ob3ZBd/mk3X5
	 TfjgH4DVV2o+8NVBKRwrdjmQQQ5XjSfIk7M3i52Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgFRQsz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgFRQsy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1709D208C7;
        Thu, 18 Jun 2020 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592498934;
        bh=JjYy4elxxB+2wBR7hAUU2Tjb0skJmcm3jUXYNY6Jq38=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FNKtWEyWKqxztlMMa/0EFi/o/yLTGyx7C/kLP+hw6kYFEh+cL+puFC/uZLMr/IV8H
         CC/T8I0fKH9brkUZq9gyAvaxTk8XUJ3IowINRZNe8lH2mQKIRVw44AFu/+Z6FYkxjf
         zQQaa6RxMAEAZGQ0ND+6+hKdYO4n4M+NN7gUiczA=
Date:   Thu, 18 Jun 2020 17:48:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Dilip Kota <dkota@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org
In-Reply-To: <20200616104050.84764-1-dianders@chromium.org>
References: <20200616104050.84764-1-dianders@chromium.org>
Subject: Re: [PATCH v3 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Message-Id: <159249892720.8894.5843182459934461610.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Jun 2020 03:40:45 -0700, Douglas Anderson wrote:
> This patch series is a new version of the previous patch posted:
>   [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
>   https://lore.kernel.org/r/20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid
> 
> At this point I've done enough tracing to know that there was a real
> race in the old code (not just weakly ordered memory problems) and
> that should be fixed with the locking patches.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
      commit: 539afdf969d6ad7ded543d9abf14596aec411fe9

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
