Return-Path: <SRS0=I8nA=CC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CEC433E3
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC71D2063A
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598276035;
	bh=rbqXQJGmHZXen0FPJYIQEZ+d/rRSjBw4X5GiaHWayBI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PiS1e3nSKtdMWEuwGn/+sfw5A/Jbqj4Ds6GxCh5b1hYkqd3FJJekX1qdeFDZNwRjE
	 2808MCl5BOmWP2Kacq3JnCfGNnkit4Lf5twzGa7lcstk2Grni71y/UmGYqfrOvzMyd
	 zZLcEeaL/kTVEIEoxlHiIvTp1sYdPmm273b/xmEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHXNdv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgHXNci (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3151207CD;
        Mon, 24 Aug 2020 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275958;
        bh=rbqXQJGmHZXen0FPJYIQEZ+d/rRSjBw4X5GiaHWayBI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z7PF7QeBSX1TxnlAcCetcFjQLQcBSXqt3dXnI8fV/cAIKdGlDR6kreZQnHugIyXgq
         oPBS4pAqwfYYKT7hnGiMG/48cBiCpVHRFuS738g8DStk2XgRxjWaUbWXXmQLMWKaf0
         N5smIXS15CzR4+khDL2Dx7WS2G7+l12pVCToJ3V0=
Date:   Mon, 24 Aug 2020 14:32:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-kernel@vger.kernel.org, angelo.dureghello@timesys.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20200823212657.2400075-1-olteanv@gmail.com>
References: <20200823212657.2400075-1-olteanv@gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: delete EOQ transfer mode
Message-Id: <159827591891.48232.1958676153438917876.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Aug 2020 00:26:57 +0300, Vladimir Oltean wrote:
> After the only user of the limited EOQ mode has now been converted to
> DMA as of commit b09058bbf5f0 ("spi: spi-fsl-dspi: set ColdFire to DMA
> mode"), we can finally delete this code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: delete EOQ transfer mode
      commit: 20c05a05506361a6c355e9944d5616f5ed1e01c8

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
