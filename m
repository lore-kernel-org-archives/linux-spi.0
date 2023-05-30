Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD99C77B7A
	for <linux-spi@archiver.kernel.org>; Tue, 30 May 2023 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjE3TVL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 30 May 2023 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE3TVK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 15:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDAF7;
        Tue, 30 May 2023 12:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F6F61A55;
        Tue, 30 May 2023 19:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBF1C433D2;
        Tue, 30 May 2023 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685474466;
        bh=+NWhOKqpRR9aVfz4q8kpaELANrYT5D+vsyfwRKOeXPg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pdgxBxWWz5vV+xz4BUG05IHciGgGrjJ/5DqcwTZ65FKand3sZ2xnXdyEhLXkM3z0n
         p7KQ622J/LyoJB9dc/yPE0QOkk/BeAV6Qsf3f4MEjoSiWnbLG60pCFVrUIHo+O8YRg
         YHAtRCGkBYLB7faxG6fp9Kl+u0YTqfxX1ie9+uVY8QvhNxgG1i7X0HWj2E9CGLdQyk
         qRiYxaagaKg6YUW3DOLV7rFIs8JvE8GZCnDk29MJz7Xkfl0fvjQYFV/JMI3bvOCpBA
         v0T4BVUAKWd0ITaUGCXq73iKrxLSp76mujeBlsP4ptJ7CpLaAZDgz6nf5AJyDQdixI
         2ZyngbmttOs7Q==
From:   Mark Brown <broonie@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20230530111348.1.Ibd1f4827e18a26dc802cd6e5ac300d83dc1bc41c@changeid>
References: <20230530111348.1.Ibd1f4827e18a26dc802cd6e5ac300d83dc1bc41c@changeid>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Add newline to PIO fallback
 warning
Message-Id: <168547446379.1401559.10908750603999270634.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 20:21:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 30 May 2023 11:13:48 -0700, Douglas Anderson wrote:
> A warning added in commit b5762d95607e ("spi: spi-qcom-qspi: Add DMA
> mode support") was missing a newline. Add it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qcom-qspi: Add newline to PIO fallback warning
      commit: 55c33e5ee6d3dff13125bdd32b7fa98260680a31

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

