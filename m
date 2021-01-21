Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02283C43381
	for <linux-spi@archiver.kernel.org>; Thu, 21 Jan 2021 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C103023A40
	for <linux-spi@archiver.kernel.org>; Thu, 21 Jan 2021 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhAUTnX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 21 Jan 2021 14:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbhAUTm7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Jan 2021 14:42:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8480523A57;
        Thu, 21 Jan 2021 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258132;
        bh=Po502srur/DE1k+jB0+dic0UD5htIqDZA3k0KRXqPLE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dPxqkySvSs6a6t8HKeOFlpgTdmxFcHeYOT5CyUuVgQn4ObOF4vXLhHUkMymjaSi/j
         CNnE+pK8CKRJa5zmUeXo4dg6Hj6t9eS6hEeutrfXkCosaHQuadBzCXautPincNk7MJ
         Y5ecZwKUDRp1nvy5cqBjjvFS6cLYDPsta8IGcUfO8VKih7ItufPNHGyf8DN50qabNo
         eSBkSZ/3HKwM7TCzo0Nd6jrpJkZ9427UsF+BheEN3x2P6FiLghRLt0FXqY6zmrWxKj
         ht6jFilzvVP/hAIvnEf7/Dh3tGDT4FxWV1t/WER5sxQgvmoSZ8lp6RItxi2h3L6SYf
         0w8meucyUTmcA==
From:   Mark Brown <broonie@kernel.org>
To:     Pan Bian <bianpan2016@163.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120050025.25426-1-bianpan2016@163.com>
References: <20210120050025.25426-1-bianpan2016@163.com>
Subject: Re: [PATCH 1/1] spi: atmel: Put allocated master before return
Message-Id: <161125807797.36053.9018873168932356463.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:41:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 19 Jan 2021 21:00:25 -0800, Pan Bian wrote:
> The allocated master is not released. Goto error handling label rather
> than directly return.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Put allocated master before return
      commit: 21ea2743f015dbacec1831bdc8afc848db9c2b8c

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
