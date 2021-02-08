Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0760C433E0
	for <linux-spi@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FB64EB9
	for <linux-spi@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhBHSls (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235746AbhBHSln (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 13:41:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF4664E60;
        Mon,  8 Feb 2021 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612809662;
        bh=zMU5Txxi6EftYM78NHHqsb4/587gsoUlvcEIxX2ebVQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ff/3TkeJI6WjlF4lDY0FDRb0CEGuN/LV9lw9qbdpg+VodoutBZxLBaaQmKpMMDrOf
         Rql0W4ieu+3RNTjcfEiC+Y4cuQceEh+fnlVJS0i6dC2jAfL+Q/SykjE3jYKYe5pU/C
         o56UkSDJYo66lLuL3/AaSX1oIF8JE34R8udt0MwH9RRi4KIjJd0nAkLSlSp8Q3juJH
         kTrqCk6GGIce9YnNJqMx7JVrBIbUXcQzDEZtz5WANisGeJ7OGV6ydaOwIKUJH+GRuo
         2f4ennxV90SzmAaMhtup+KKzHNL7pq1IcijqNRvhTLq49xt1DYZ37MAyFwt6bvkdbI
         NK+z8OEBYHjUw==
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20210207030953.9297-1-leilk.liu@mediatek.com>
References: <20210207030953.9297-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH 0/3] spi: add set_cs_timing support for HW/SW CS mode
Message-Id: <161280960941.11009.17680678012347479205.b4-ty@kernel.org>
Date:   Mon, 08 Feb 2021 18:40:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 7 Feb 2021 11:09:50 +0800, Leilk Liu wrote:
> Some controllers only have one HW CS, if support multiple devices, other devices need
> to use SW CS.
> This patch adds the support of both HW and SW CS via cs_gpio.
> 
> leilk.liu (3):
>   spi: add power control when set_cs_timing
>   spi: support CS timing for HW & SW mode
>   spi: mediatek: add set_cs_timing support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: add power control when set_cs_timing
      commit: 4cea6b8cc34ee61358d681bd2009b8bac1736ffe
[2/3] spi: support CS timing for HW & SW mode
      commit: 0486d9f91d373e7f47276f30898ee0cb12656a70
[3/3] spi: mediatek: add set_cs_timing support
      commit: 9f6e7e8d432e39d4f3d5d3c80129aec7f383b2b4

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
