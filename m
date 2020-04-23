Return-Path: <SRS0=H9tS=6H=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FEC54FCB
	for <linux-spi@archiver.kernel.org>; Thu, 23 Apr 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2769E20781
	for <linux-spi@archiver.kernel.org>; Thu, 23 Apr 2020 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587656137;
	bh=ZXsmhC1kCxLDQflOaCytnmzs8ahECJZVXNH4EJLbqws=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PjL7P16vs0SooM9cO8QJ4qfsXFrzNS97CRrXlISwCOCM6pDpI8exp5tkrV/zgDnG2
	 EXeS0PxQONwAtpo+YnAKnwRAdf7P6oCPs3wrpXdEX8lAco7FsqjgsD1H4hc9y5BhnD
	 PX1vUpeElvlLgbKamfnzBICLkZGaQ3CcuS/l9e/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgDWPfg (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgDWPfg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Apr 2020 11:35:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA91920767;
        Thu, 23 Apr 2020 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587656136;
        bh=ZXsmhC1kCxLDQflOaCytnmzs8ahECJZVXNH4EJLbqws=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Arreyk1tf1E51/09x0x5bLKIf5iB7lkPyPRClZmKtHr1x+2nngah+r2Zk5EJUX7YP
         KrQq3bqbsQaGYu1tngrQr1D7DBVxm16U5DTLhC6YDcuiIdAvAsHe2fQsbZjXjXH6pU
         ap4gB46Wx8mZdX35bcj6GDyBRwI+XeoDTltNLkRk=
Date:   Thu, 23 Apr 2020 16:35:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20200416101418.14379-1-geert+renesas@glider.be>
References: <20200416101418.14379-1-geert+renesas@glider.be>
Subject: Re: [PATCH] spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices
Message-Id: <158765613372.1156.6140454895577267978.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Apr 2020 12:14:18 +0200, Geert Uytterhoeven wrote:
> Currently buswidths 2 and 4 are rejected for a device that advertises
> Octal capabilities.  Allow these buswidths, just like is done for
> buswidth 2 and Quad-capable devices.
> 
> Fixes: b12a084c8729ef42 ("spi: spi-mem: add support for octal mode I/O data transfer")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices
      commit: 80300a7d5f2d7178335652f41d2e55ba898b4ec1

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
