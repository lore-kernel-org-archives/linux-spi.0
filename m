Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D4C433F5
	for <linux-spi@archiver.kernel.org>; Tue, 19 Apr 2022 22:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358323AbiDSWsi (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348030AbiDSWsf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:48:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDE1CFE9;
        Tue, 19 Apr 2022 15:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17941B81CA5;
        Tue, 19 Apr 2022 22:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF78BC385A8;
        Tue, 19 Apr 2022 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408348;
        bh=u69tYpHiAO1T14mzItzq1PV3SIJNfovbMUKmvNnUygA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b5Ah13kbR9kv8OlkKQ4QXtj3Xw1AgbsPxI+F3xXGWSAgpMp61O8TKOduebNlUR0zt
         wVB1RNs/P28ofCAUvY9eL8nvvFdI5b4cyMQlOX21xkl8seeGWpzSgPAZFP8D6rygRm
         eplAIPeQTOwPZAftvUiHRzGhdNDiPsfR7AjWNvvB+HKKZJkntE9p5uHOHWcb1WQZme
         e0CzjbT2dY2GH6Frh1Reiijmmn+emqRKad+v4v8c/Lgsmx61WChbNMKniPJpN2kd6a
         8XtQLgeqxgPa/74ScbVdfjQk58c+Av/cbB0JLDovbLZStRl5UqMpHN6aZ2uLoeTQgu
         Mh056axtM1vCQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, chi.minghao@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220414085637.2541805-1-chi.minghao@zte.com.cn>
References: <20220414085637.2541805-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040834757.1910395.4140546749023589299.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Apr 2022 08:56:37 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 3a2ac5809935e6043dae916bab6cf4741d9dcdeb

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
