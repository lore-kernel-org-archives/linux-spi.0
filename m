Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22740C388F7
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B33206E3
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKsTocGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgKITsm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729899AbgKITsm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:42 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53B8E206D8;
        Mon,  9 Nov 2020 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951321;
        bh=aly6Zly1UrqXEKfpiByGQzxM4mo/jvzIOFWLA1/Ew4I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nKsTocGjqTHSpGsf2C61HtKBtUmF/GiumhE93Das9w+ng/puucYaRw5UUm2lmDBqR
         5JLLh9UnLBAhDi55FxY79Y32HMQHNDW0RSWTd27eXHYXAbjL07kU+usSB+j4TrosWa
         tjVlAygAGT3WEQqtHJjRcG5CqaPvpUtWuDmOPZeQ=
Date:   Mon, 09 Nov 2020 19:48:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20201103074911.195530-1-miaoqinglang@huawei.com>
References: <20201103074911.195530-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH v2] spi: bcm63xx-hsspi: fix missing clk_disable_unprepare() on error in bcm63xx_hsspi_resume
Message-Id: <160495129749.49337.12919860085282006110.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 15:49:11 +0800, Qinglang Miao wrote:
> Fix the missing clk_disable_unprepare() before return
> from bcm63xx_hsspi_resume in the error handling case when
> fails to prepare and enable bs->pll_clk.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-hsspi: fix missing clk_disable_unprepare() on error in bcm63xx_hsspi_resume
      commit: 9bb9ef2b3e5d9d012876e7e2d7757eb30e865bee

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
