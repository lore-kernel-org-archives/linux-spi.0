Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32703C07E95
	for <linux-spi@archiver.kernel.org>; Mon, 19 Jul 2021 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8E86113A
	for <linux-spi@archiver.kernel.org>; Mon, 19 Jul 2021 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhGSN5J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240946AbhGSN5J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B11A610FB;
        Mon, 19 Jul 2021 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626705469;
        bh=4ppvGCVhxX9Ei4Rx4q2KOHVqpSLD73i38NcVOVLXhdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGNeasbdteWhW2RxWLxU6eqwNcZePwk6U8Hwgzpis6EswU7rdDnkSKGqPeI+z39rC
         0w0Eoieh8qlHJlhAdG11HPY4fNYpOqORWr7t/sSocj5xH19e6A4yAjFjtgRiPCbmbA
         R/0aA69FbJ4FtQ414RnUznf/b4l0EC6pTJlRbc3XUlQvTdLj2k4dEyxXEDv3xfzxD3
         f1bziO/ZaPiEa8ZD84piWC8sVquUKDf8FFxjnceavkhgC6DvFRlx5USlhuDHfUOy6r
         /1fO0OnPGyxz1grrbMn46+Q3dInKS9+WPjBGLgVefBTVsZIAaHq5ijr6hMchP2xJ/I
         DAH1I6gNWChbw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cadence: Correct initialisation of runtime PM again
Date:   Mon, 19 Jul 2021 15:37:40 +0100
Message-Id: <162670536703.50818.12960552667142242389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716182133.218640-1-marex@denx.de>
References: <20210716182133.218640-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Jul 2021 20:21:33 +0200, Marek Vasut wrote:
> The original implementation of RPM handling in probe() was mostly
> correct, except it failed to call pm_runtime_get_*() to activate the
> hardware. The subsequent fix, 734882a8bf98 ("spi: cadence: Correct
> initialisation of runtime PM"), breaks the implementation further,
> to the point where the system using this hard IP on ZynqMP hangs on
> boot, because it accesses hardware which is gated off.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Correct initialisation of runtime PM again
      commit: 56912da7a68c8356df6a6740476237441b0b792a

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
