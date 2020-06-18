Return-Path: <SRS0=zXQu=77=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA75C433E0
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EF4208C7
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592498931;
	bh=pp5uB+H9KaW9/eo4GgCSoMqjhoACdduYxmXmEVk68D0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=tRsrXsKFoiGEU3+gj+MjjPTPWMDuPCqs4W644j4q+cyQ8nQVv5miPe080WiuGNe24
	 E41STyiEKOuMU6gDVlsmiiZAoxXdVu9XE7tBwX/DNZGnX7sxIoQ5/GilCWcQIceFRa
	 UInzQ60d9WDjjUP0ALJpcfz3Jg3ro2GZmcLlHv6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFRQsu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgFRQsu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B87208C7;
        Thu, 18 Jun 2020 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592498929;
        bh=pp5uB+H9KaW9/eo4GgCSoMqjhoACdduYxmXmEVk68D0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BN42uWWE6E2J4HcVIR3nxwvyjQ/RZxwH503W/SALOBGKH+I4CGs9NJT7FiLPw57/s
         I6FEdhYb7n0QH0zD+PbeFj6QvGN3tyjh07AzBw6DBqG7nhdNUpqSbifyxBJgzFG3nj
         GW4bqtq992mOXT66pBMEUvX7ZbYX9pLFui9zp724=
Date:   Thu, 18 Jun 2020 17:48:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200618032125.4650-1-zhenzhong.duan@gmail.com>
References: <20200618032125.4650-1-zhenzhong.duan@gmail.com>
Subject: Re: [PATCH 1/2] spi: spidev: fix a race between spidev_release and spidev_remove
Message-Id: <159249892720.8894.3932380546197111188.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Jun 2020 11:21:24 +0800, Zhenzhong Duan wrote:
> Imagine below scene, spidev is referenced after it's freed.
> 
> spidev_release()                spidev_remove()
> ...
>                                 spin_lock_irq(&spidev->spi_lock);
>                                     spidev->spi = NULL;
>                                 spin_unlock_irq(&spidev->spi_lock);
> mutex_lock(&device_list_lock);
> dofree = (spidev->spi == NULL);
> if (dofree)
>     kfree(spidev);
> mutex_unlock(&device_list_lock);
>                                 mutex_lock(&device_list_lock);
>                                 list_del(&spidev->device_entry);
>                                 device_destroy(spidev_class, spidev->devt);
>                                 clear_bit(MINOR(spidev->devt), minors);
>                                 if (spidev->users == 0)
>                                     kfree(spidev);
>                                 mutex_unlock(&device_list_lock);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spidev: fix a race between spidev_release and spidev_remove
      commit: abd42781c3d2155868821f1b947ae45bbc33330d
[2/2] spi: spidev: fix a potential use-after-free in spidev_release()
      commit: 06096cc6c5a84ced929634b0d79376b94c65a4bd

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
