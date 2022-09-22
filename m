Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C978ECAAD8
	for <linux-spi@archiver.kernel.org>; Thu, 22 Sep 2022 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiIVRyV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiIVRyQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 13:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3544710650D;
        Thu, 22 Sep 2022 10:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BFE636C3;
        Thu, 22 Sep 2022 17:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56B8C433C1;
        Thu, 22 Sep 2022 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663869255;
        bh=sPEfNt549leOVSeFwAMTEwbkpSUroLM7+a3d5AF/yOQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OvYT0old6lhYOJhem8X36tPfmhv22eGf3e+sJH/9fHFJYf3i5es8jXKB99PO6jxpV
         fRd8EyvusTckJGk8t3WbrXTYwbF+xBC/rTU+ZEN6XJo8CAp0UzA3S7DKKwqc8XYOHI
         tFALL65D+D2/xDpIAOVRXKJ2jIq4xUPJT4BRyTi9xc+bZ9EHGiDpSrx4tuB/eyXp4F
         oRA4ueKSzej39t+5y32Is7pnueaZWTancF4aTNiUq5OTykHYYnUJUg5KFEJLzslUWH
         xcP7J7vFTi2p7QZCGIBiASP0IkgYm1LbiTTPhwzg2ji88SmtIzRIrMhSz9kVRwEcMK
         MLro8/Fvj071g==
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wei Yongjun <weiyongjun1@huawei.com>
In-Reply-To: <20220922040807.1409540-1-weiyongjun@huaweicloud.com>
References: <20220922040807.1409540-1-weiyongjun@huaweicloud.com>
Subject: Re: [PATCH -next] spi: meson-spicc: make symbol 'meson_spicc_pow2_clk_ops' static
Message-Id: <166386925058.727991.8817892530350799405.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 18:54:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Sep 2022 04:08:07 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The sparse tool complains as follows:
> 
> drivers/spi/spi-meson-spicc.c:570:22: warning:
>  symbol 'meson_spicc_pow2_clk_ops' was not declared. Should it be static?
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: make symbol 'meson_spicc_pow2_clk_ops' static
      commit: 077dac343b54babfd56b1a52cf1f091518118957

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
