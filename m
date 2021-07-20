Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A63C07E95
	for <linux-spi@archiver.kernel.org>; Tue, 20 Jul 2021 18:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A2760720
	for <linux-spi@archiver.kernel.org>; Tue, 20 Jul 2021 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGTSIA (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 20 Jul 2021 14:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhGTSHp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Jul 2021 14:07:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFC7A61009;
        Tue, 20 Jul 2021 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626806903;
        bh=pDnPWStFctmWL6EDjvYaPuRJTNwmF3Oh0LAPMY0O398=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KE/UGNHvwnMLz4mEYnFJqcoeVEZnQYbzw68vzjo+7M+zdtVm8i89Kz3AbdMIamM8U
         4wd2WGXgFln6d8jHKycs0eu/6BWnION81zZDcFe3j/yvNGdvvAN0GC/MMQmbVp2sE6
         vlncgFgx9u2wBcLe+yK+WtwYN2dTFMkjnYo8WhyP9IipEofzJlJtUVN8+yT4QGc/hS
         VBcbmB2cKRj5VM+eV69UCzQJCrO5AhwvjgQWUlMMA2nZCLEGf/6SLCWxdSFWctNXHk
         gGWGORsDmO60BuqfwlKcOE3aF5QIUOrO9yM1OoymyYY/KT/aWzfQHNKiktlgpIBpcc
         6FSLiw6c/bGDA==
From:   Mark Brown <broonie@kernel.org>
To:     alexandru.tachici@analog.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, swarren@wwwdotorg.org,
        bcm-kernel-feedback-list@broadcom.com, bootc@bootc.net,
        nuno.sa@analog.com
Subject: Re: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Date:   Tue, 20 Jul 2021 19:48:16 +0100
Message-Id: <162680680557.11423.14003826010912823109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716210245.13240-1-alexandru.tachici@analog.com>
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 17 Jul 2021 00:02:44 +0300, alexandru.tachici@analog.com wrote:
> The bcm2835_spi_transfer_one function can create a deadlock
> if it is called while another thread already has the
> CCF lock.
> 
> This behavior was observed at boot and when trying to
> print the clk_summary debugfs. I had registered
> at the time multiple clocks of AD9545 through the CCF.
> Tested this using an RPi 4 connected to AD9545 through SPI.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-bcm2835: Fix deadlock
      commit: c45c1e82bba130db4f19d9dbc1deefcf4ea994ed

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
