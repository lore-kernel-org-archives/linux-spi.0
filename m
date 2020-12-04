Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7700C4361B
	for <linux-spi@archiver.kernel.org>; Fri,  4 Dec 2020 23:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FC922838
	for <linux-spi@archiver.kernel.org>; Fri,  4 Dec 2020 23:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgLDXcV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgLDXcV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 18:32:21 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20201204082409.183700-1-jarkko.nikula@linux.intel.com>
References: <20201204082409.183700-1-jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-S
Message-Id: <160712471232.7862.14553685397331355820.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:31:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Dec 2020 10:24:09 +0200, Jarkko Nikula wrote:
> Add support for LPSS SPI on Intel Alder Lake. It has four LPSS SPI
> controllers each having two chip selects.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Alder Lake PCH-S
      commit: b8450e014214982a6df3e62a5bee6c37b94f6b98

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
