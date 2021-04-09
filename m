Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3BC433ED
	for <linux-spi@archiver.kernel.org>; Fri,  9 Apr 2021 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2516108B
	for <linux-spi@archiver.kernel.org>; Fri,  9 Apr 2021 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhDIQXs (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234000AbhDIQXm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E59A6103E;
        Fri,  9 Apr 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985409;
        bh=x47F8ElZJRgnbWvKxg8ERBb96pRnIYASca71WTeGtXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC0degoThvSLalgM+klx5DuN69+2qD7e1J2gBxfJhGzDi13E500SWex+YvRjp67yk
         CGlCezYINyf+SS7jIfeEa/R2uyyOl9hbZj96UtxHwnE/2MJ8JGuyXUU+g2jgUDa2RI
         FSnIySnwywIEiLMfSL6wD1EY4SR5zKbTubrN/rYum3LnGcOsRlplr407tuawSDaYqB
         hhffgKZg+ikCCysgd80ljrKTuVXZ0a/whmMwWJq/Z4NdndqxqsVSlm4OiDfdlY+lRu
         qKOvBLsKwaIDCAHLB4fvUlnzE7z69OvhLj2NMVQb4SBQ8u7gnexOsS/Az9cOTBTggQ
         Sos4zBt4EIOdQ==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Tian Tao <tiantao6@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3] spi: davinci: Use device_get_match_data() helper
Date:   Fri,  9 Apr 2021 17:22:43 +0100
Message-Id: <161798356988.48466.11934953711806321676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617152319-17701-1-git-send-email-tiantao6@hisilicon.com>
References: <1617152319-17701-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 31 Mar 2021 08:58:39 +0800, Tian Tao wrote:
> Use the device_get_match_data() helper instead of open coding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: davinci: Use device_get_match_data() helper
      commit: 30700a057ce84e6f18f4cc3627570f8b2ae3c17f

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
