Return-Path: <SRS0=D5D4=A7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8941BC433E4
	for <linux-spi@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6015C22CB3
	for <linux-spi@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255927;
	bh=Sl5vkvc9d7Pqq4EUnvLtOjanNEeRj1VwOKSx7aZzI14=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VQEKN51EYrMmDsOEXqVrgxX376Kaq67n45FPr9Mrca2XsC1Kb7bWLCsToLvqDvRH7
	 12SJX8p+naSdAzt1xkZsAsZnGBBKCM6/Tw+al5FTORu1vx4HVUfkqMr5GishuSRYkd
	 NjhwaN47yXu8oad57OzDQjCu2s2GHrP6t7q1Wms0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGTOir (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOiq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC6F22CB2;
        Mon, 20 Jul 2020 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255926;
        bh=Sl5vkvc9d7Pqq4EUnvLtOjanNEeRj1VwOKSx7aZzI14=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=AntO3O1WJrNSyIAHGVT0w0OvQH6w6ENRy182uH9ETPTyQ8YQB1X801ZHx6A2ys+bh
         0sjFZxpP5yCn1Tv7Rc9q24zCXCYMzVZnAzv4p7EVBceXIIZYr841kGC2E2tJgWPMKm
         MIzsIUyDTe2oK7VdrqEU6JYWgxojnfITzjdwnv7o=
Date:   Mon, 20 Jul 2020 15:38:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-spi@vger.kernel.org, axboe@kernel.dk
In-Reply-To: <20200717215648.20522-1-hauke@hauke-m.de>
References: <20200717215648.20522-1-hauke@hauke-m.de>
Subject: Re: [PATCH v2] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Message-Id: <159525589434.6792.7024407245651480935.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Jul 2020 23:56:48 +0200, Hauke Mehrtens wrote:
> The lantiq-ssc driver uses internally an own workqueue to wait till the
> data is not only written out of the FIFO but really written to the wire.
> This workqueue is flushed while the SPI subsystem is working in some
> other system workqueue.
> 
> The system workqueue is marked as WQ_MEM_RECLAIM, but the workqueue in
> the lantiq-ssc driver does not use WQ_MEM_RECLAIM for now. Add this flag
> too to prevent this warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
      commit: ba3548cf29616b58c93bbaffc3d636898d009858

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
