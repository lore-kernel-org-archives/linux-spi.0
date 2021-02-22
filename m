Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC9AC433DB
	for <linux-spi@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAA464EC3
	for <linux-spi@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBVQKm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:10:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhBVQKS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Feb 2021 11:10:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4624864E61;
        Mon, 22 Feb 2021 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614010175;
        bh=GyFLH81VMs6/P3bcf8bluurPketQ/FaZVV/MxCmeGD4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IOllDqe3+vtgTV82/Bwi2NNIwEB4D/kf5rQiEOofwIvZvPLSbV1HOavLbYUomMj76
         B4kiyLIZWgyCdLx6+4KsWlRTREYwLJblc2y5hlQf5+jCQrI9FGZ1FYAlsoor1VJEJC
         QxBgiG3ek71W6tMapRramw+X04tAWAHZhMhZWsNRFUWwI93mY5amWPwjy+pfP/a5ht
         aCwKCEeJa3u2DKnFAk+bDT7O/RRlKX70mA6HUqU4tRnSmylgLGavnIE9nrtWAIXttT
         Nk+tof/0lcm+Tp6pTi+fj/+2ej8WyVMsVaiJqXbzaBLZ6e+uw1fF3bdfA3NOXNeRjj
         zQjH/WAECmC3A==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, vigneshr@ti.com
Cc:     stable@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210218130950.90155-1-tudor.ambarus@microchip.com>
References: <20210218130950.90155-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2] spi: spi-ti-qspi: Free DMA resources
Message-Id: <161401011449.2654.15347175815378368271.b4-ty@kernel.org>
Date:   Mon, 22 Feb 2021 16:08:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Feb 2021 15:09:50 +0200, Tudor Ambarus wrote:
> Release the RX channel and free the dma coherent memory when
> devm_spi_register_master() fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: Free DMA resources
      commit: b3c15f78befc6031de7d5bcb683d37018b20c425

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
