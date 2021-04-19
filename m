Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B561C433B4
	for <linux-spi@archiver.kernel.org>; Mon, 19 Apr 2021 17:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3452761246
	for <linux-spi@archiver.kernel.org>; Mon, 19 Apr 2021 17:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhDSReq (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhDSRep (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33295611F2;
        Mon, 19 Apr 2021 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853655;
        bh=htNNx7uBOidFypvXGwoCYr9UZZ2Sg1E6sIsSdEnYbN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASDjUDEYW8rujcLm+wJLZFz9u9jxfhs1zXPs8NZ+MvFysLfPnsshvzNMJWx5RMHOw
         +dLLK952CW9d7u1wLYxnrZvmJoVelJtwpQiIcz4Mn3fvlycS/vCX5fS+D9dvFTEngz
         +LPbcwlUUFZ3ggC69Z3/zu4bc3PdtyetQuHmgHidd07ZvPitNTs5clryLQyy5jzCLG
         G5Z3sAH75LXVR45lYOqPCr+vIGHs9kI8QJzQ1QjsNjOTT7cHJOWqmDkY2zcyzgNuDc
         FUw3tQfHEel0LlUwtI0hFYbk3eTABRYkRAMqNmm/deGCulL1XlcG50z9wdkRk84W1F
         Y2z+oEVkdtUNQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, David Bauer <mail@david-bauer.net>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sync up initial chipselect state
Date:   Mon, 19 Apr 2021 18:33:44 +0100
Message-Id: <161885314931.4710.17119271938651822220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416195956.121811-1-mail@david-bauer.net>
References: <20210416195956.121811-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Apr 2021 21:59:56 +0200, David Bauer wrote:
> When initially probing the SPI slave device, the call for disabling an
> SPI device without the SPI_CS_HIGH flag is not applied, as the
> condition for checking whether or not the state to be applied equals the
> one currently set evaluates to true.
> 
> This however might not necessarily be the case, as the chipselect might
> be active.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sync up initial chipselect state
      commit: d347b4aaa1a042ea528e385d9070b74c77a14321

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
