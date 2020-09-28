Return-Path: <SRS0=BcLs=DF=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA4AC2D0A8
	for <linux-spi@archiver.kernel.org>; Mon, 28 Sep 2020 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EE0208D5
	for <linux-spi@archiver.kernel.org>; Mon, 28 Sep 2020 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601321813;
	bh=9RJdTfPpdguwugYvXbpDbhHA8LGsJ3B5t6OkG5gTgWY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=IIkE1mAddjTwFVMM6MRY0/F9jgD2EY2dyNld9wOSQA1vXpxEtjSN/aJ7HSSh0CtqA
	 9WmdA1Ko2BvoCmuCgyXBFt7p+pI/TiYudC2mMQQDMqbG9U38wUf7IigEy1+wERDVzR
	 Nfm24Lhf7Ac9mp5RqdGDYkeQzngZSgchfycfWMKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgI1Tgw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgI1Tgw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Sep 2020 15:36:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBA620773;
        Mon, 28 Sep 2020 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321812;
        bh=9RJdTfPpdguwugYvXbpDbhHA8LGsJ3B5t6OkG5gTgWY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nB7N8nMacIuTdt0q4gWaEvps46sh5PhMQnhxVIMDcLxUAMT6pAQsvtQuwB0D+zgkR
         Up2JIrvaVWJRcOCnhZkJ8sEua/MovyuOsa2pF41fEaRW7VVMTgD67gRLTwXDnZw+8d
         uOSR91GO2bsWDc9I3Q4gawMVfEfh1zVmEDE+451g=
Date:   Mon, 28 Sep 2020 20:35:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Colin King <colin.king@canonical.com>,
        John Garry <john.garry@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200928123042.125359-1-colin.king@canonical.com>
References: <20200928123042.125359-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] spi: hisi-sfc-v3xx: fix spelling mistake "occured" -> "occurred"
Message-Id: <160132174502.55568.4062890961950897599.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Sep 2020 13:30:42 +0100, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-sfc-v3xx: fix spelling mistake "occured" -> "occurred"
      commit: 0e9683659c6926fd3f30345f9f58893e630379ed

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
