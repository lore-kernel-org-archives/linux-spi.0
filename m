Return-Path: <SRS0=3Imn=DB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADAC4727D
	for <linux-spi@archiver.kernel.org>; Thu, 24 Sep 2020 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B8B23772
	for <linux-spi@archiver.kernel.org>; Thu, 24 Sep 2020 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600948886;
	bh=x+9aT8m2KmiQ7xrq0m8rmPW+REb7IHmCBHsFKzhmdJc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=nLH/78w78EmS0oqCsyNyA/DYlwi/FTH0OrdHbYzkvrCVW8WjCW7sAfzszcGgncxvr
	 4Fnv3OIorNtsZk4JtjPWNgp9NAT6+xMIs+mOI5UFSXr96Bn4cFUpKFrIzcfBnqeUhF
	 9UBrSGhEki9oXfm/0TivTtc22LJI9h+/H+mWjKdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgIXMBZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgIXMBY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:01:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C44C2344C;
        Thu, 24 Sep 2020 12:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600948884;
        bh=x+9aT8m2KmiQ7xrq0m8rmPW+REb7IHmCBHsFKzhmdJc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bIjGtro+jpHfw9qczn5Pykpo3IjOcv6eOiJXmm98rJ8VZRrvEth9x9fuZRWSOjSZK
         48l5mzaFDEDAZ/LbOeiHK0MT7I8+QzNyGQPXqkBrCUvPC6KbkkQhYklQ744k4s84oS
         5Zmu9IOT5zrjytemxjWKeA9ZIn72z+zpQQmYTKfo=
Date:   Thu, 24 Sep 2020 13:00:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, git@xilinx.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
References: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [RESEND PATCH 0/3]spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Message-Id: <160094881929.50579.13423581299866478626.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 22 Sep 2020 10:40:13 -0600, Amit Kumar Mahapatra wrote:
> This patch series:
>  - Fixes kernel-doc warnings in ZynqMP qspi controller driver file.
>  - Updates the ZynqMP qspi controller driver to use spi-mem framework.
>  - Fixes incorrect indentation in ZynqMP qspi controller driver file.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
      commit: 91af6eb04a6bbdb8bec8ed6d8ac7850a26604bad
[2/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
      commit: 1c26372e5aa9e53391a1f8fe0dc7cd93a7e5ba9e
[3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation
      commit: f09a433b1e4057e6379b7e1207548fff30d5dca3

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
