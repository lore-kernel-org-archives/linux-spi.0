Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD2FA3743
	for <linux-spi@archiver.kernel.org>; Fri, 28 Oct 2022 18:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ1SlI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJ1SlF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 14:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052531F5242;
        Fri, 28 Oct 2022 11:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B573629CC;
        Fri, 28 Oct 2022 18:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9552DC433D7;
        Fri, 28 Oct 2022 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666982463;
        bh=dICG5ca+Mxef33RoufsWAibxiDnlRVqeRKRgegkMpfk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FacGQZlenvR0da2LHDn5kJkDQKiQIyd0QRwKR4TGr6+YdJhdGRDmG3BOp1NzBDMEI
         dgXv460d2XU9xs0R0qQxc2zRExaMAMOCHgaoMToLYW1V2WCcoHEhusItbrhgiwVdW4
         p4EQAX4SXbSAeKCGA+q9TeIt8FmebV2mJbarj9+uxmHSppB0YtWjWdJkB+Oe3+XIW+
         8RXtXamHVkmNgJbU8utzNdYvn4DJfLfwJ4YOrsh2K7UAjS5LJmYBsneymi0UZiV+EB
         DehWX3VGyW2g+CP3Iu6OxqzsR6ajrpoeB40kXv7SUVG/VIurI06x9eFceIDGasOtbL
         WqXbei6S73TGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-spi@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-tegra@vger.kernel.org
In-Reply-To: <20221026155633.141792-1-jonathanh@nvidia.com>
References: <20221026155633.141792-1-jonathanh@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Don't initialise DMA if not supported
Message-Id: <166698246231.1295241.12438240346694631931.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 19:41:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Oct 2022 16:56:33 +0100, Jon Hunter wrote:
> The following error messages are observed on boot for Tegra234 ...
> 
>  ERR KERN tegra-qspi 3270000.spi: cannot use DMA: -19
>  ERR KERN tegra-qspi 3270000.spi: falling back to PIO
> 
> Tegra234 does not support DMA for the QSPI and so initialising the DMA
> is expected to fail. The above error messages are misleading for devices
> that don't support DMA and so fix this by skipping the DMA
> initialisation for devices that don't support DMA.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Don't initialise DMA if not supported
      commit: ae4b3c1252f0fd0951d2f072a02ba46cac8d6c92

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
