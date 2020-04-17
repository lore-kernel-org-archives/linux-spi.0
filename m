Return-Path: <SRS0=jfaC=6B=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C1C38A2C
	for <linux-spi@archiver.kernel.org>; Fri, 17 Apr 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385FF20771
	for <linux-spi@archiver.kernel.org>; Fri, 17 Apr 2020 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587139744;
	bh=ShAfLvze6neVAoDWPaXYXQisPi9FN5TwTVidUf14oME=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=v+FZJ3jOdt2y/ai3wjI13DZAgDX2BIe/b47h5Lerp8p64JCL4921R7mHfcKZyn5W0
	 vxjk4gj+474fqGuP3pvQkBAE2qMccuGZprhakHnqHAzZGZrzTAHxyE0cJiL2pxS4eC
	 rtwkDsgl47XWIuWo9RM+0vqCn4b6Opm9Eb2Sk7x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgDQQJD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbgDQQJD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Apr 2020 12:09:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D591020771;
        Fri, 17 Apr 2020 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587139743;
        bh=ShAfLvze6neVAoDWPaXYXQisPi9FN5TwTVidUf14oME=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Wl6+88x5UwXfMqMVd+G9LxBGnHmtAmq7L7B2M47cAV0I67P8oT+J2lpN7NTZoePfh
         wJTeVYYo4BaYNIPiJ6bQorgW89GsueEL0q1do3P7IeNbWvuK7yt4ztvmTzTmCC/r0N
         ZwoCQFhq98S5IDqGBMjaSQmacCVEu/M26z4sqDQw=
Date:   Fri, 17 Apr 2020 17:09:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200413180406.1826-1-andriy.shevchenko@linux.intel.com>
References: <20200413180406.1826-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
Message-Id: <158713971398.21137.7877907919665375095.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Apr 2020 21:04:06 +0300, Andy Shevchenko wrote:
> By unknown reason the commit 64bee4d28c9e
>   ("spi / ACPI: add ACPI enumeration support")
> missed the DataBitLength property to encounter when parse SPI slave
> device data from ACPI.
> 
> Fill the gap here.
> 
> [...]

Applied, thanks!

[1/1] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
      commit: 0dadde344d965566589cd82797893d5aa06557a3

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
