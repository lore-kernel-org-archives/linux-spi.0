Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11844EE49AA
	for <linux-spi@archiver.kernel.org>; Mon, 21 Aug 2023 21:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHUVJh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHUVJg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B88193;
        Mon, 21 Aug 2023 14:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF13E64BDC;
        Mon, 21 Aug 2023 21:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4F8C433CB;
        Mon, 21 Aug 2023 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692652164;
        bh=oitRchK0DBxJZoFQt52HD6uowcK5E1z/NZAT/5+qCrc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cr+eue5pFaWQiUpeR+AuEy3FWIrxIPMfqD55wyupoThGheBmGPGdOB2lAIvth+0Yo
         CWNmrbdyuDfvLdq2TqJseyEZMwSUwOwRh9MiwzBUp4NXJM6a3HHRtghHQIjBMgY31U
         y4itR2xHlb1LsVc/NVvYQR3V96XPITTKnj4lDpZmTmlkcVzy3Pm83oDKqxFY9dHx9s
         tV1I4LwYTdYOMl+GHO1YwlXifM9jnmGyI68GYiH3ZVvp8grYmE5BvDmiXUJ0oOBY88
         Czt86oXD+3sDJT85JRVOLsCp3WponU2/ZCaQqsBrEqWHdV8soOKIw6P16Le5W0/n0q
         Md3YEbbM8t86w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, gcnu.goud@gmail.com
In-Reply-To: <1692610216-217644-1-git-send-email-srinivas.goud@amd.com>
References: <1692610216-217644-1-git-send-email-srinivas.goud@amd.com>
Subject: Re: [PATCH] spi: spi-cadence: Fix data corruption issues in slave
 mode
Message-Id: <169265216295.467713.17554225884007828710.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 22:09:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Aug 2023 15:00:16 +0530, Srinivas Goud wrote:
> Remove 10us delay in cdns_spi_process_fifo() (called from cdns_spi_irq())
> to fix data corruption issue on Master side when this driver
> configured in Slave mode, as Slave is failed to prepare the date
> on time due to above delay.
> 
> Add 10us delay before processing the RX FIFO as TX empty doesn't
> guarantee valid data in RX FIFO.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Fix data corruption issues in slave mode
      commit: 627d05a41ca1fbb9d390f9513af262f001f261f7

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

