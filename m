Return-Path: <SRS0=iNVW=7L=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74497C433DF
	for <linux-spi@archiver.kernel.org>; Fri, 29 May 2020 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF702071A
	for <linux-spi@archiver.kernel.org>; Fri, 29 May 2020 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786369;
	bh=eG7ApO4bNVe4vy71o9oLIHf9qDungmx4X5vZGoEOric=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=S6drJmBneyD8MfSTvtzUqqtEj4cwIhZpOgmEbiOdPKyhnf+x074es621eA+K9W4VA
	 VKmbcDDJva752WhsZwuqUSQ/UKiRU/XH03m+acHddz1CVqXB5QVCFhJ01hqS9Sx5js
	 ES4fqnycUfNn0D3QMCRPWdmO35d/ViYqKuOyL3Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgE2VGJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 29 May 2020 17:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgE2VGI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 17:06:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE22B2071A;
        Fri, 29 May 2020 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786368;
        bh=eG7ApO4bNVe4vy71o9oLIHf9qDungmx4X5vZGoEOric=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iUBP81gsEGAIVVRmimTGNSSYVOADgvPtSf8LuwRbCql1RV5X4bjEN7BLbWkjUo+1Z
         hAmzVDV0zo1OlYGeWlIC3is1kn/OKvO7hBFZXtiFX51cp07oksUA0HJAbMx9enRryO
         sb4KOZFItiuJrYNOniWYobNklcCFneq6ggNa/23I=
Date:   Fri, 29 May 2020 22:06:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
Message-Id: <159078636491.21150.5166126211100294804.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 29 May 2020 21:31:49 +0300, Andy Shevchenko wrote:
> The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> did a clean up of global variables, which is fine, but messed up with
> the carefully provided information in the custom DMA slave structures.
> There reader can find an assignment of the DMA request lines in use.
> 
> Partially revert the above mentioned commit to restore readability
> and maintainability of the code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
      commit: b3f82dc26c0d4e1348ef81e0189cb8838b8b0d22
[2/2] spi: dw: Refactor mid_spi_dma_setup() to separate DMA and IRQ config
      commit: 3d7db0f11c7ad19979a1a01cac1d379ff040e886

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
