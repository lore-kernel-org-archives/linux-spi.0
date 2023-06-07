Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC8C7EE25
	for <linux-spi@archiver.kernel.org>; Wed,  7 Jun 2023 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFGRYM (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFGRYJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jun 2023 13:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A31FFD;
        Wed,  7 Jun 2023 10:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A30863BC1;
        Wed,  7 Jun 2023 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E68C433EF;
        Wed,  7 Jun 2023 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158641;
        bh=aGQlmMGWqLT3KzAf24Mh9L2icJkIzcPJBAx7qmhcwQE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KFRlZPP397UES14BvXzR+pbDlUScz/3OjSmUoF8M8wiCR0nH5y+l67xUTZ7oNBW8+
         oAY1dtuXWrWGIQyVd3EnDUjCTSBAWN0OoKcec0ky3MuxcILFf6AcrgNoeITQZ5cO4l
         eRLfXzx6o0e2Y8AcLYsjkn2eqX2A1n1H5ZzPQJS4BmV+bgrLv7XoGAVlehOzEfoZ1w
         OU7YMTlI5/ca8oiau8s/gJYGA+cXmAuTkaU6EOmZ5pj6tGfYdyU5Nqz/6dYHmuMQif
         VIEEC5vMs09ra8cL2GT0eqFZDzGs3aQWa40uLnzOfbMM6P9lf75eFjsGxyQTVmOSaZ
         zQBv1LLXEfwrA==
From:   Mark Brown <broonie@kernel.org>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20230606012051.2139333-1-andi.shyti@kernel.org>
References: <20230606012051.2139333-1-andi.shyti@kernel.org>
Subject: Re: [PATCH 0/2] spi: s3c64xx: Cleanups
Message-Id: <168615864038.61821.6026678872508499940.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 18:24:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 06 Jun 2023 03:20:49 +0200, Andi Shyti wrote:
> two small cleanups in the probe function. The first puts in use
> the managed spi master allocation while the second implements the
> dev_err_probe() function.
> 
> Thanks,
> Andi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: s3c64xx: Use the managed spi master allocation function
      commit: 76fbad410c0fed0c203c22e7e5ef8455725f3338
[2/2] spi: s3c64xx: Use dev_err_probe()
      commit: b4f273774c8b2b7c6f5e0cb9b18a234a8ca322b4

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

