Return-Path: <SRS0=swU/=A3=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB3C433E8
	for <linux-spi@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6F2076D
	for <linux-spi@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943921;
	bh=Vp9znY1wArAHg1obDXgiQdFCwvn3664Vxa8iozCXYXI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=Cpy/eM7WsTByCwWz0R5FCOyx5U/aGEIxQ1zxO5brTBngQqFhCJHRj17LNqXfx7Xzd
	 KeRy8V/R7Io+nl7JSO6j/eQWr57mmSJC37UxhMb+ElJv4yeUdmBk+MwHqZKalbLr1k
	 02ilSRU5wjYBcP+jwqHKdJCIy6Z4gEovax8jb2oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgGPX6k (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E032076D;
        Thu, 16 Jul 2020 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943920;
        bh=Vp9znY1wArAHg1obDXgiQdFCwvn3664Vxa8iozCXYXI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ylOWCr6uU0jjDA7LbMzseOLiMFQapcwGzNJLWn4RubQ6U6aPLA6savBc6r9pxpWC0
         a5kJ3VnlRVPGifunHFMf1BKq/yKwseSwJNJvOy7I1TwuMYEh+KOhheMtKgH5zYTqde
         Q0CipKE5VWcLFh8YtgDVxd9jk8SVuhY6i46Wl3lY=
Date:   Fri, 17 Jul 2020 00:58:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20200715163610.9475-1-broonie@kernel.org>
References: <20200715163610.9475-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: Only defer to thread for cleanup when needed
Message-Id: <159494389041.42455.2810165265122915280.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jul 2020 17:36:10 +0100, Mark Brown wrote:
> Currently we always defer idling of controllers to the SPI thread, the goal
> being to ensure that we're doing teardown that's not suitable for atomic
> context in an appropriate context and to try to batch up more expensive
> teardown operations when the system is under higher load, allowing more
> work to be started before the SPI thread is scheduled. However when the
> controller does not require any substantial work to idle there is no need
> to do this, we can instead save the context switch and immediately mark
> the controller as idle. This is particularly useful for systems where there
> is frequent but not constant activity.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Only defer to thread for cleanup when needed
      commit: e126859729ed4a5143e5690186b8bec1c1157113

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
