Return-Path: <SRS0=BYrQ=CL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535CFC433E7
	for <linux-spi@archiver.kernel.org>; Wed,  2 Sep 2020 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3825C2083B
	for <linux-spi@archiver.kernel.org>; Wed,  2 Sep 2020 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599072907;
	bh=zMaRoodXGzTl9JIx6OYzrKhHEphLzLQGpVJkPWXMxek=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=xu4ClV1lKffPbYRx7wcY2nrCn6hBkDIYqEBptC39/9i9OlqAt06mLlNkowg3pDS8f
	 Y86cYVt2PIuHf3NzGVxhY6i0Fd8aS9nghTxnw/+DcxED2cAqWMlYl/RQa9u/GmU9Ia
	 0g/NcgiyxQWpEP/Hj89InjShkr1aI8U7khR0CoK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIBSzG (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBSzG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Sep 2020 14:55:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E05C20773;
        Wed,  2 Sep 2020 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599072905;
        bh=zMaRoodXGzTl9JIx6OYzrKhHEphLzLQGpVJkPWXMxek=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=v0aNulda+AcGp01wZ1x4hthfaOFWmGbbYM8iKd13ovmphwXxayeGV4uuLpPycU60s
         zSx+fEYHGNDDhQaeJUbH1JzIMu8z6xRG/A9FqBIxDzzmgXqZg9kYSnckt0asFjHGW4
         KC4WA//s5xTvx59BDkTkcVpFnK3jqbizqY/Pwg0Y=
Date:   Wed, 02 Sep 2020 19:54:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-spi@vger.kernel.org
In-Reply-To: <20200902132341.7079-1-vincent.whitchurch@axis.com>
References: <20200902132341.7079-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] spi: spi-loopback-test: Fix out-of-bounds read
Message-Id: <159907286571.18171.5445968539102015356.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 2 Sep 2020 15:23:41 +0200, Vincent Whitchurch wrote:
> The "tx/rx-transfer - crossing PAGE_SIZE" test always fails when
> len=131071 and rx_offset >= 5:
> 
>  spi-loopback-test spi0.0: Running test tx/rx-transfer - crossing PAGE_SIZE
>  ...
>    with iteration values: len = 131071, tx_off = 0, rx_off = 3
>    with iteration values: len = 131071, tx_off = 0, rx_off = 4
>    with iteration values: len = 131071, tx_off = 0, rx_off = 5
>  loopback strangeness - rx changed outside of allowed range at: ...a4321000
>    spi_msg@ffffffd5a4157690
>      frame_length:  131071
>      actual_length: 131071
>      spi_transfer@ffffffd5a41576f8
>        len:    131071
>        tx_buf: ffffffd5a4340ffc
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-loopback-test: Fix out-of-bounds read
      commit: 837ba18dfcd4db21ad58107c65bfe89753aa56d7

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
