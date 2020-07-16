Return-Path: <SRS0=swU/=A3=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517ABC433E4
	for <linux-spi@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264EC207CB
	for <linux-spi@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943906;
	bh=xvjgkwxyW9akFxk1Dg7inKTp5ykXShPn8Xs5S12o/A0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=c9rLVAV4Uzz3aKPjpzX3/bJZgJ2/XL3//hxt3bV/KRCjHOcWJrCks5ecM/UVJQ9N8
	 7vcnottDqw8OpXAZZDBK6PCF2Plw2aOL1GZZKjT01FHdiI1amtThFWIgzv/4jXcqNv
	 +sask9pYRz6fIUAzwi7n8jZxETYaa5A7KJlx94pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGPX6Z (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00D12076D;
        Thu, 16 Jul 2020 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943905;
        bh=xvjgkwxyW9akFxk1Dg7inKTp5ykXShPn8Xs5S12o/A0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oYnkscCiax9CaJKsdUhVYHtYPQv4FYuBx87pmSdYqnVw1f2o76M+kt7u/wtuU0Nzd
         Lvib16hKq1L8cq51gG/7KiPAke4ma1dvkyFMdNwTpQCu9DWzjDPEIqv2Do6RCjnNhf
         9uYMVXPAgpY2kGj8/BMRzka1D8XSxB/Qh8f7nBf4=
Date:   Fri, 17 Jul 2020 00:58:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     han.xu@nxp.com, trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20200716051144.568606-1-tudor.ambarus@microchip.com>
References: <20200716051144.568606-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH trivial] spi: Fix SPI NOR and SPI NAND acronyms
Message-Id: <159494389042.42455.17570277155590983858.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Jul 2020 08:11:44 +0300, Tudor Ambarus wrote:
> The industry refers to these flash types as "SPI NOR" and
> "SPI NAND". Be consistent and use the same acronyms.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix SPI NOR and SPI NAND acronyms
      commit: 3e84cdd427b24b40d3670a7d61be31514bea1864

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
