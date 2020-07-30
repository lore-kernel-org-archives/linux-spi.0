Return-Path: <SRS0=xkiK=BJ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B317C433DF
	for <linux-spi@archiver.kernel.org>; Thu, 30 Jul 2020 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB902083B
	for <linux-spi@archiver.kernel.org>; Thu, 30 Jul 2020 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596148154;
	bh=KwGDSsusd/GMVehYUac5bADuIj+1b5g0N27c/uhAflQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=tNKLl6OV42GDtzJWspmAJHkLQqc5I1QhOyBdP6sU2M8oSwDZFtjKvC0iNDf7NPxac
	 bJDp4qg/JZqfVrbZE4XX37l43bUy9anfu+Ol7ec7tmpNmxvZbdvk8gc7oAFM+hm7Sq
	 q4rJZeqgkTn251bJHd2P/KGTfTgyNdCNt0RLxU58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgG3W3M (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgG3W3M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jul 2020 18:29:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1562320829;
        Thu, 30 Jul 2020 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148151;
        bh=KwGDSsusd/GMVehYUac5bADuIj+1b5g0N27c/uhAflQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Ljz27fSB87EoOFZClLBru0C+YXU/QApJfJrwf6SvRcti387BsBJi3yF9E0iILTOW1
         J954Tk4oygLbx9rHqjb3CKQ06FjrCJNAVoTwm/p4sBrsh/NqdSEnawQJPz7qi9YOC6
         thDcG8fcIhdOIkafWYWvcVj8tazTSAwjr6gQ3QsA=
Date:   Thu, 30 Jul 2020 23:28:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200722083737.8820-1-jon.lin@rock-chips.com>
References: <20200722083737.8820-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
Message-Id: <159614813119.1710.15143804942434946004.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 Jul 2020 16:37:35 +0800, Jon Lin wrote:
> The burst length can be adjusted according to the transmission
> length to improve the transmission rate

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
      commit: 4d9ca632c847ab88f2f7e7e2747aea966f1390ce
[2/3] spi: rockchip: Support 64-location deep FIFOs
      commit: 13a96935e6f66bafb6da92791120546a4bf20889
[3/3] spi: rockchip: Fix error in SPI slave pio read
      commit: 4294e4accf8d695ea5605f6b189008b692e3e82c

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
