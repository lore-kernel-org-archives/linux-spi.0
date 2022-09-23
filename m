Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD11C6FA83
	for <linux-spi@archiver.kernel.org>; Fri, 23 Sep 2022 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIWRVu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIWRVt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 13:21:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8312756E
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 10:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0FE75CE2561
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 17:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB988C433D7;
        Fri, 23 Sep 2022 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663953705;
        bh=stMfFnVH/juCurSRTNCRk0c423DHo1u24Crm6CU1vz0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aB+p8r1CVsvPoo2lVwqArrrdiibKUjyAlj/wAgl+Q2WFLrSQyPfdtE+KLPquENasv
         niZ31sKEEp4CTZ6Vo/foIeirjcAUYcmVH3PUej6yCrXt610wOgHFc0PrVSRs5xvzmL
         afhJ6WCnzuakPfRpvC3Bym1mjp09VXpis8VJB+/9WLyEaCqltf83FbXqOGImvPGowh
         ObGWMFcHTeMjOwHLi6Taze6wgxOQ5QqzY3ifq6R2AZOSEWvqgQLvIdT5I3P/BcTyOg
         FXjRA2BeYDSqOQIWx2X0pOy9wbN+Ptq+d5ETTAV2LzQ5S1vmJuvyS6pyFlZLbxLuHF
         gDU56aF0GF4jA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, clg@kaod.org, andrew@aj.id.au,
        chin-ting_kuo@aspeedtech.com
In-Reply-To: <20220923101632.19170-1-shangxiaojing@huawei.com>
References: <20220923101632.19170-1-shangxiaojing@huawei.com>
Subject: Re: [PATCH -next] spi: aspeed: Remove redundant dev_err call
Message-Id: <166395370362.637404.4217222260781909886.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 18:21:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 23 Sep 2022 18:16:32 +0800, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Remove redundant dev_err call
      commit: 04e0456f778de550a14d222d1a9ae0625511244d

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
