Return-Path: <SRS0=d3ll=DG=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55696C47423
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0440820C09
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601396670;
	bh=dhKVn14Jw3VzBvqZ7pteBlKnBHkITxetT0CvZPxh7ps=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=LTdJUJGvAKRUugSIDTw4XddEMTFSAPngO5T2jj4mfnLfxkt+g5XwdvOAozSgqggjY
	 xJ7xtFIly+Uuizbg2en1P2sJv1xdyxpLOB7AhIhbRgp2mW8X67FeAUG5H/Ucfi1zg5
	 gpVmfjU41pxybwokBfx3mvsT7NBOw+r4Ge1xAxrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgI2QY0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgI2QY0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 12:24:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E43C20936;
        Tue, 29 Sep 2020 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601396664;
        bh=dhKVn14Jw3VzBvqZ7pteBlKnBHkITxetT0CvZPxh7ps=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WjLEtiGDnXaRoHtQM3NgjSZcKDn2UyFfuKgX0ZXnxMP+8kEf0A5LnSVKo+sjOTW6o
         X7lgMCoAglxIavtaaSZF7EG2flKMkoBupr2ZHxIjJXNotAMm2N/lrwgk3UVUZrHAVr
         CiU7hlYszwOiTjTjVGpm8qrv4dcnQ3Cp27lEAfEc=
Date:   Tue, 29 Sep 2020 17:23:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-Id: <160139659999.766.14300777884222792440.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 20 Sep 2020 14:28:44 +0300, Serge Semin wrote:
> Originally I intended to merge a dedicated Baikal-T1 System Boot SPI
> Controller driver into the kernel and leave the DW APB SSI driver
> untouched. But after a long discussion (see the link at the bottom of the
> letter) Mark and Andy persuaded me to integrate what we developed there
> into the DW APB SSI core driver to be useful for another controllers,
> which may have got the same peculiarities/problems as ours:
> - No IRQ.
> - No DMA.
> - No GPIO CS, so a native CS is utilized.
> - small Tx/Rx FIFO depth.
> - Automatic CS assertion/de-assertion.
> - Slow system bus.
> All of them have been fixed in the framework of this patchset in some
> extent at least for the SPI memory operations. As I expected it wasn't
> that easy and the integration took that many patches as you can see from
> the subject. Though some of them are mere cleanups or weakly related with
> the subject fixes, but we just couldn't leave the code as is at some
> places since we were working with the DW APB SSI driver anyway. Here is
> what we did to fix the original DW APB SSI driver, to make it less messy.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: dw: Discard IRQ threshold macro
      commit: 07918df724f2fed02327e3cbfe58a5d5568b2cc2
[2/9] spi: dw: Initialize n_bytes before the memory barrier
      commit: 8225c1c9a073c323f68833d136fcf94fbc75a275
[3/9] spi: spi-dw: Remove extraneous locking
      commit: 0b6bfad4cee4a3d5c49e01fa00284db4b676360e
[4/9] spi: dw: Clear IRQ status on DW SPI controller reset
      commit: a128f6ecd56a32e559889145003425b0c7d406e3
[5/9] spi: dw: Disable all IRQs when controller is unused
      commit: a1d5aa6f7f97b15e8fd917169239088823471741
[6/9] spi: dw: Use relaxed IO-methods to access FIFOs
      commit: 7e31cea7d1e0f4b683dc45c21530cd3ee82559b4
[7/9] spi: dw: Discard DW SSI chip type storages
      commit: 675e7c9d71cedee3988b554c47971be77e72d2db
[8/9] spi: dw: Convert CS-override to DW SPI capabilities
      commit: cc760f3143f53ea8387cd76cffc43bdc89db9df4
[9/9] spi: dw: Add KeemBay Master capability
      commit: ffb7ca54c95b4c76ad8a9aa1b2b16d61df2a7139

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
