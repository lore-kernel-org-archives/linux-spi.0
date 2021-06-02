Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31724C47083
	for <linux-spi@archiver.kernel.org>; Wed,  2 Jun 2021 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DE56161E
	for <linux-spi@archiver.kernel.org>; Wed,  2 Jun 2021 16:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhFBQSu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 2 Jun 2021 12:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhFBQSt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Jun 2021 12:18:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E288761940;
        Wed,  2 Jun 2021 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650626;
        bh=2bWCvQYKGRBcjdYh34l3GP8PzgVh5PoOZaMAl2vhUqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVsG0SqlOWY7fjt2SDOOnZq28x10KqTjHQ93n9zfE0nlmWOdO51t8faxfz6NK0As2
         ePs53DcnBMSRIFP9pCrHfJgrJEjkr98GtWiiPKhdkJKJyEAADit3Td3VDvKxP/ptMl
         m/rcEGrGva92Vm/0zaSVSVA7TfgKg8ZJGQEP306laX5bcSQlmL/g9/ssaSsl2Z43QP
         BdncqV63F8i+mHtQYSw5H3ZhSdOJye26bfaHPzyd3JXEwIiqqc8SNfwSadTey3Un3j
         EHtwTRHRzgDHMgQbEBDfB25nRMgz8i9lkzJz7+JhBj5uj9kn4uZ0asm+FIAwpfrUie
         BcCZExB4QQy5g==
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-spi@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v2 for-5.14] spi: bcm2835: Allow arbitrary number of slaves
Date:   Wed,  2 Jun 2021 17:16:46 +0100
Message-Id: <162265058629.22666.7423439187883024357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <a847c01f09400801e74e0630bf5a0197591554da.1622150204.git.lukas@wunner.de>
References: <a847c01f09400801e74e0630bf5a0197591554da.1622150204.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 May 2021 23:32:00 +0200, Lukas Wunner wrote:
> Since commit 571e31fa60b3 ("spi: bcm2835: Cache CS register value for
> ->prepare_message()"), the number of slaves has been limited by a
> compile-time constant.  This was necessitated by statically-sized
> arrays in the driver private data which contain per-slave register
> values.
> 
> As suggested by Mark, move those register values to a per-slave
> controller_state which is allocated on ->setup and freed on ->cleanup.
> The limitation on the number of slaves is thus lifted.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Allow arbitrary number of slaves
      commit: ec679bda639fe84b78d473526ae27c74dea383fb

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
