Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACECC433ED
	for <linux-spi@archiver.kernel.org>; Thu,  8 Apr 2021 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FCD61056
	for <linux-spi@archiver.kernel.org>; Thu,  8 Apr 2021 16:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDHQzb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhDHQzY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5DBA610CB;
        Thu,  8 Apr 2021 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900913;
        bh=rbTuItiTLFrD2UbPN0IdtgNS9mA9OgOsKwcubsBPYNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNZsOZPmvJkKgwtcS2YKhgyARl9pGvz7IJbNYMHlheeG0YM1oNpXaJoS3xk1nSZ/L
         17+d8VA4EhI7yGma93bBPe8zK7cb4KBSHOsXA1hWKWoMKR0Y2GUN9VU+sppPFhG9M6
         HmtKSNLkXiCsnyx12qrZ3ScqZifFRm+387PGcDHrSnqbgJ1u8iFH5IO4A/rWQ5Gkzi
         v8s5S/JnrVI9WpUQdQc7NJ1wAZxneEIU6F0hxqX/xP14mGs9ENq6ZUkECiUMPEzuNk
         IeJMxjd82Roq4zna+zhNoCUyxo7dai2z7dSJawUaSjatIZCNlNd2sJwPRNcqErA/RR
         tEQBzYdWKbrcQ==
From:   Mark Brown <broonie@kernel.org>
To:     "William A. Kennington III" <wak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix use-after-free with devm_spi_alloc_*
Date:   Thu,  8 Apr 2021 17:54:34 +0100
Message-Id: <161790025317.17096.2046216267474815618.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407095527.2771582-1-wak@google.com>
References: <20210407095527.2771582-1-wak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 7 Apr 2021 02:55:27 -0700, William A. Kennington III wrote:
> We can't rely on the contents of the devres list during
> spi_unregister_controller(), as the list is already torn down at the
> time we perform devres_find() for devm_spi_release_controller. This
> causes devices registered with devm_spi_alloc_{master,slave}() to be
> mistakenly identified as legacy, non-devm managed devices and have their
> reference counters decremented below 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix use-after-free with devm_spi_alloc_*
      commit: 794aaf01444d4e765e2b067cba01cc69c1c68ed9

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
