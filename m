Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0AC636CC
	for <linux-spi@archiver.kernel.org>; Mon, 13 Feb 2023 14:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBMOXb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 13 Feb 2023 09:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMOXa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Feb 2023 09:23:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0116AD5;
        Mon, 13 Feb 2023 06:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A58AB81233;
        Mon, 13 Feb 2023 14:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58926C4339B;
        Mon, 13 Feb 2023 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676298206;
        bh=h8/G/tuuP5Dd+JS3/9H8ApYG7ecsyGLXgaXz4FfrPJw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rLPqSRlNmkAqlS+JXS2+7Ihysb8zvw510mJe0hEQ/V7HcQhIiK5YL3RfsYS6LvHAg
         3n/FZ9adMhl91SbwN66YZ7C6tKfzeWL9B0CrTB6tGcfN4nBLeDM0qqwx7Els3aHRo6
         u62v++vdcTwWeY3Rs+MTrjAcu/zhppuzYUJZXHByH2dBEioCHl4gULoDncPdlU9P0z
         19OvN4YJ6M4CJ7E+nZTg0HD6zStX57eTUfuyrr+3p4HFXwrHkUYtufh4ZwgW9SRPcM
         +ngED4uBRiOSMiG0+sHpyqlMnuHoN6awmxbFBUSzVORE2OykY+2zQyyJQ9bMWYIzFR
         XAIQ8wqMExITA==
From:   Mark Brown <broonie@kernel.org>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230212205054.26348-1-william.zhang@broadcom.com>
References: <20230212205054.26348-1-william.zhang@broadcom.com>
Subject: Re: [PATCH] MAINTAINERS: Remove file reference for Broadcom
 Broadband SoC HS SPI driver entry
Message-Id: <167629820305.2707397.8230990509140378773.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 14:23:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 12 Feb 2023 12:50:54 -0800, William Zhang wrote:
> brcm,bcm63xx-hsspi-peripheral-props.yaml is not in use at least for now.
> Remove it from the maintainer entry.
> 
> Fixes: 80323599e33f ("MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers")
> Reported-by: kernel test robot <lkp@intel.com>
> https://lore.kernel.org/oe-kbuild-all/202302121840.GtduUT37-lkp@intel.com/
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Remove file reference for Broadcom Broadband SoC HS SPI driver entry
      commit: 937ca916bf4de427242fb78105a0089af0dd43b3

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

