Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFE5C636CC
	for <linux-spi@archiver.kernel.org>; Thu, 16 Feb 2023 13:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBPNXr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBPNXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Feb 2023 08:23:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC854579;
        Thu, 16 Feb 2023 05:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E915661FF5;
        Thu, 16 Feb 2023 13:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B6BC433AE;
        Thu, 16 Feb 2023 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553824;
        bh=erojs45d0jxAXUZzIrxqgpVrUG2ZaS/aS/eC0hZuboI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lhe5WQZAQvK0ZORtMx+VxuBKOxoltzMeXuIw/vRX/QWh2PXtQ3ZigajQ3FUCBh8CL
         l1QbiszyVlESLDuseiONsvU/T8RNJ4NPnNUltraDFXaS7uomry6SRjwhrjqAhQMRo4
         yhOYtbqPxHy4rtEcIKkKhYK6KlzXH1sZXYo1eYKkfnMZWDCfUImgWkjvIIT1F2nk5R
         PXQ3V4uFLakjYr/Lqq0B4SzXKojBuLVsCKAqw2PprPq4rv3pRKh4LBqZ0aNqu1tRrN
         KMRnYp93VFpZTalVPR582oodi7N4PY2VVfqloPZ68o67uogcAR00APWlRu+08U2rSo
         yZdYURlLU8zfQ==
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <Y+zmoGH6LubPhiI0@kili>
References: <Y+zmoGH6LubPhiI0@kili>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: fix error code in probe
Message-Id: <167655382233.3676429.7341927577915213769.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 13:23:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Feb 2023 17:05:20 +0300, Dan Carpenter wrote:
> This code accidentally returns success instead of a negative error code.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-hsspi: fix error code in probe
      commit: 97b7cea04f52c3263a74b945a4738f678181b117

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

