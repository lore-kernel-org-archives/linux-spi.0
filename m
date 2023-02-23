Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485DC636D6
	for <linux-spi@archiver.kernel.org>; Thu, 23 Feb 2023 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjBWNGz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjBWNGv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 08:06:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F351FBD;
        Thu, 23 Feb 2023 05:06:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7491CE2011;
        Thu, 23 Feb 2023 13:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BAFC433D2;
        Thu, 23 Feb 2023 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677157607;
        bh=cNUVJLgQ0s89w+rcSY+BvDkFAtEDdhMXP7+ncfs5okQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a7troAwdaxoMbnDWVX33XJ7VQj0zB4r+Wr0sjv7iHtMrIYYpJ+ddkEHokzmvttyCG
         N7H3qj3SlSvV1CIXY8FgFItUGoZbVtcBvAfd61if+pGXyS16KDvHrZuf7MjDHHTSJm
         SThRkI4DLy5wX6P1XPKA0kXecnMKGuET98UmCef8Zd1LiXdK76bEmp2jnTzKIeaAzJ
         09wJgZjMIN1ICUSTV94WLyrZ4YyJTtfMZzMrLRS7UFu9GdWtAuBSWP8NSujDdDlcKb
         lcNzU6oH7nGVgtcElkERYyW1+qHu5eDyrpJ23mUMrS6Izi3zV5zQLQavAAgroYgQ7T
         9+CmyYYJoAd7g==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <ptyadav@amazon.de>, linux-spi@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-kernel@vger.kernel.org, David Binderman <dcb314@hotmail.com>,
        stable@vger.kernel.org
In-Reply-To: <20230223095202.924626-1-d-gole@ti.com>
References: <20230223095202.924626-1-d-gole@ti.com>
Subject: Re: [PATCH] spi: spi-sn-f-ospi: fix duplicate flag while assigning
 to mode_bits
Message-Id: <167715760528.62178.6653469643907332364.b4-ty@kernel.org>
Date:   Thu, 23 Feb 2023 13:06:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 23 Feb 2023 15:22:02 +0530, Dhruva Gole wrote:
> Replace the SPI_TX_OCTAL flag that appeared two time with SPI_RX_OCTAL
> in the chain of '|' operators while assigning to mode_bits
> 
> Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Link: https://lore.kernel.org/all/DB6P189MB0568F3BE9384315F5C8C1A3E9CA49@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sn-f-ospi: fix duplicate flag while assigning to mode_bits
      commit: 078a5517d22342eb0474046d3e891427a2552e3c

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

