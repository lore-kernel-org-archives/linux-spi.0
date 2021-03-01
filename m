Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001AC433E0
	for <linux-spi@archiver.kernel.org>; Tue,  2 Mar 2021 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B34264F25
	for <linux-spi@archiver.kernel.org>; Tue,  2 Mar 2021 13:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbhCBNXb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 2 Mar 2021 08:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346260AbhCAXkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 18:40:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A5C860C3E;
        Mon,  1 Mar 2021 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641959;
        bh=lD2SkyugVzga06mWkg354UptjEsLdfh72kAzjiRP6fg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JOOw/tZ17ZJ2Tn9ZK+gXHBKdtD+riuvLSnYyM/8GRS18mZ2R+XcNi6bhOZG48XbOb
         lCrSHfYFP3lxODCEWoYvaDMGSqFamKdEZF/LGPwX2zQa1VrzL5OIAHh5Cc28JYe++O
         9KRHuf06QtnyLit5MYJ5s+xnlFLAMyCk3jG8RjKe+z0Ic7Ac4VqFJl9stuCKdJEXb0
         z2pVvq9hFWmsNUSPQZCLwH83Y20EDIl6R/NGuf08voT8rx9AsdK0Od6FhpqOSHx++q
         BE2Dp6NK8hCUrncR6LKME7m+rK1V/cbf4YtxJt+U77e9j4U4p9CpPOaqxl4CT5OPLf
         BOwx4O/VvcihQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        linux-spi@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210218132840.131898-1-tudor.ambarus@microchip.com>
References: <20210218132840.131898-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: atmel: Drop unused variable
Message-Id: <161464187230.31555.12644458080257725528.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Feb 2021 15:28:40 +0200, Tudor Ambarus wrote:
> The DMA cap mask is no longer used since:
> commit 7758e390699f ("spi: atmel: remove compat for non DT board when requesting dma chan")
> Drop it now.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Drop unused variable
      commit: c5f754fd0a31d2c6f2f8d11f3db1427b5566f1e7

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
