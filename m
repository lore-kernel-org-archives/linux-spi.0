Return-Path: <SRS0=q92/=BB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB41C43457
	for <linux-spi@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B47D20684
	for <linux-spi@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595425526;
	bh=o1jYZWn/sCrcloS83rhA9Xi9FUtFoKkQvr/MsgkeLvQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ORM5DZo8JCLRQcuPdPpJsLkg5bTUIjKh2ATY4t3bKFEImJe5okQmy+/HQg9L8ZvVI
	 FDdyJ0IxHE9hOKaTxzJLy7SWB3wZzIX98j32u180fUSaYz668G89NsMA+1UoLaKoXB
	 LvIT4TaoqZdi+tE2Um2zLOe180JRohdfCuohetqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgGVNp0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgGVNpZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DB62065D;
        Wed, 22 Jul 2020 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425525;
        bh=o1jYZWn/sCrcloS83rhA9Xi9FUtFoKkQvr/MsgkeLvQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YBYISbNtR3BPGk7DB4ghYIdUURz/gnTg3ZsGhlxk+C6N/KX/Iq+HIq7B+lrQs2/hD
         TJvWIT5UiSV4ppEYwLcOMNkRfOmxWodyn2Avw+2E8bhnIY4iRl6kcMZn490iOXXMJJ
         L6ebl0uRQ01KsH6l+NJQ+6YI/R+5/rP6CMQUuR/w=
Date:   Wed, 22 Jul 2020 14:45:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200714072226.26071-1-linus.walleij@linaro.org>
References: <20200714072226.26071-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: ppc4xx: Convert to use GPIO descriptors
Message-Id: <159542550175.19884.1291452700922629224.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jul 2020 09:22:26 +0200, Linus Walleij wrote:
> This converts the PPC4xx SPI driver to use GPIO descriptors.
> 
> The driver is already just picking some GPIOs from the device
> tree so the conversion is pretty straight forward. However
> this driver is looking form a pure "gpios" property rather
> than the standard binding "cs-gpios" so we need to add a new
> exception to the gpiolib OF parser to allow this for this
> driver's compatibles.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: Convert to use GPIO descriptors
      commit: 4726773292bfdb2917a0b4d369ddccd5e2f30991

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
