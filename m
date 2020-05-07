Return-Path: <SRS0=Zlro=6V=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2CC38A2A
	for <linux-spi@archiver.kernel.org>; Thu,  7 May 2020 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358E2206B8
	for <linux-spi@archiver.kernel.org>; Thu,  7 May 2020 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588855391;
	bh=GHRCGjLIZFkeZrzK2SzSVP/KSJPp1NjRDjnVBt2g46Q=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=JBy0x8BFH5YL4KpMGzAJYsZ+K4JJi1xty0t2y4YMjMcksZ3IPN89sUN5/vh8JlWlo
	 o8UuYOGsYM+qOqQkxaBDczZIBUAxOBsPgLUq3jkk1DS0T/xUpcS/v2Y8kZEZcuC7xT
	 AcUhgZTn4KZsqPgr9Qk6LSdsdqEOU6pBNDSFKFWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgEGMnK (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 7 May 2020 08:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGMnK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 May 2020 08:43:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1E0206B8;
        Thu,  7 May 2020 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588855389;
        bh=GHRCGjLIZFkeZrzK2SzSVP/KSJPp1NjRDjnVBt2g46Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sEc/fFkMcDfhFZKOJz568dH2RJPzmrOgVqvS5PawlNQDKY8Ve5/NHpRf3898cRykb
         xIQKperK0S+jJEXwaj1WjwXCQJxRAYlG/LNKz0QLchdYf25NhP3xfhydJsvWp4bWwv
         0s/o8L6ZAe/pvp7af+JHAqwJ0ws/zwhMYWh+dB4I=
Date:   Thu, 07 May 2020 13:43:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200507115449.8093-1-andriy.shevchenko@linux.intel.com>
References: <20200507115449.8093-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: dw: Avoid useless assignments in generic DMA setup
Message-Id: <158885538736.44532.12869199023796188797.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 May 2020 14:54:48 +0300, Andy Shevchenko wrote:
> Generic DMA setup doesn't rely on certain type of DMA controller and thus
> shouldn't use Intel Medfield settings, although it's harmless in this case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-dw-mid.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/2] spi: dw: Avoid useless assignments in generic DMA setup
      commit: 140e45e1e62dd56ed4c264db1443a5d4f5f40352
[2/2] spi: dw: Get rid of dma_inited flag
      commit: a041e672cb57201d152bfc314e52d41e7643375d

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
