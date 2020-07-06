Return-Path: <SRS0=fYXv=AR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA9C433E0
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D3820724
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594050063;
	bh=SwSxahhtuTzmIaKzQUXmibsLSVDRV4OhW+mc2haz7KM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Om+w5BwCyC9oAuIb6exjEwHQq0wPUusSWmbuaOrGjaxL/EsAOGnMS10jOTYYg+D9D
	 fowaCOVK2+QUUTKOzm89naj3ETQkqT808zZ19tLQUwE3dNGw/+Ittc8mM63/haRTLP
	 icUxbwxBETomc2CcLDA1t6iaQqCx+2XP81mA0yv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGFPlD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgGFPlD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 11:41:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5D52070C;
        Mon,  6 Jul 2020 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594050062;
        bh=SwSxahhtuTzmIaKzQUXmibsLSVDRV4OhW+mc2haz7KM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=09dlQzJ1jVSl5Vt0Hi4TyE9xkHREh0s1qpH5wOSbRmkS4dBn0b1zdamEIn90J/7lq
         BO0p9rccngUEdc/o7CDhNWcaxmOT4fSxowdmVlFlPzr3xSHsdfklS7ZwbLShsb/IjL
         7x2ULJ7xukzRktALktio9zzRtK/zIU9jvES8MfVs=
Date:   Mon, 06 Jul 2020 16:40:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/10] spi: spi-sun6i: One fix and some improvements
Message-Id: <159405005854.25601.18322450319577837749.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 6 Jul 2020 16:34:33 +0200, Marc Kleine-Budde wrote:
> this series first fixes the calculation of the clock rate. The driver will
> round up to the nearest clock rate instead of rounding down. Resulting in SPI
> devices accessed with a too high SPI clock.
> 
> The remaining patches improve the performance of the driver. The changes range
> from micro-optimizations like reducing MMIO writes to the controller to
> reducing the number of needed interrupts in some use cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate
      commit: ed7815db70d17b1741883f2da8e1d80bc2efe517

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
