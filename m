Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F2CCA47B
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jun 2022 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiF0UdQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiF0UdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 16:33:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADBD5FF9
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 13:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B89B81B81
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 20:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0A4C341CC;
        Mon, 27 Jun 2022 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361992;
        bh=PpGb9nzERWRd0fU4h3E+hTdsSoxXS9SYCNSRtsuUbto=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=FqX5yoDLM7sKVevDtlWXafjla7YHDufIDLPwILIga11TsCX441Iywq8rSWSXOFiK6
         88+/ZFvdvKxF/ruP4+NqCbJlSymWw2Ppa3kzD3TXBMKdvVcGeLfNhIxnBisGclLMLg
         8jSiznA5Y3djbos/UTTNYJV4Z5MYkDDjU+Vezufarj7keUttKiPHStnOYNJeLW2KW7
         MGGn7ruzlaARAABC7e4Uf93lUbBChGrbNPS6E67NDmo6cYuzOLZWHgNbqVtBEv/+xp
         z16A4oimU6yDu00QP9vSfNBTLd+FZPz10AcAmiN9VmBpuDT84EGLipdWDtwtm9ROld
         uUd48taxwhBag==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, broonie@kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220613121946.136193-1-broonie@kernel.org>
References: <20220613121946.136193-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: mpc52xx-psc: Switch to using core message queue
Message-Id: <165636199122.4094756.6914973829832652160.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:33:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Jun 2022 13:19:46 +0100, Mark Brown wrote:
> We deprecated open coding of the transfer queue back in 2017 so it's high
> time we finished up converting drivers to use the standard message queue
> code. The mpc52xx-psc driver is fairly straightforward so convert to use
> transfer_one_message(), it looks like the driver would be a good fit for
> transfer_one() with a little bit of updating but this smaller change seems
> safer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx-psc: Switch to using core message queue
      commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b

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
