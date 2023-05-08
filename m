Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88BBC77B7F
	for <linux-spi@archiver.kernel.org>; Mon,  8 May 2023 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjEHN1c (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 May 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjEHN1Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 May 2023 09:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E912C934;
        Mon,  8 May 2023 06:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C4D63D37;
        Mon,  8 May 2023 13:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B0EC43444;
        Mon,  8 May 2023 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552435;
        bh=VmioKvMeW+maOIOKu0n0+qRuaeyRIeqxpHMV5dMfC0w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V74D4b2QExeZ1zgCrgjD9WcalDiRaHpgLCGGBOznkiqY9IeEZvDCGOnenBAsg8KOk
         WxhTeBp/DIAHcFhrdK1XITaxv/AMxyszkEFRtmCVEi0rkUoI3YcKiWG9enVLEnYp5H
         1Ixpk5jPGkNcYys1tx5gG1OZnX4K0wVWbMvBqFY6S5T9ohJt8DoUyNVnrHVhn+66Fr
         BW8mphk2lsJZ70frjHDGun6iVCh2weaDrEUCMEMPb9+bGnbfJVXpCQV7rLd9r3HQUv
         elibEdRy8NDt6POqwoFNPrgjgr/VDdIuP+eWXlHD5z9QZjP1xdYnARPFgdA+WyI2k5
         VUCDihHj6e4tA==
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230505064159.3964473-1-xiaoning.wang@nxp.com>
References: <20230505064159.3964473-1-xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: lpspi: run transfer speed_hz sanity check
Message-Id: <168355243447.260152.13021056693074873743.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 22:27:14 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 05 May 2023 14:41:59 +0800, Clark Wang wrote:
> Avoid config.speed_hz is 0 when it is a divisor.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: run transfer speed_hz sanity check
      commit: f571d9132e0657b4aae40a8ffe758224d1f41047

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

