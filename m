Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B0C433E6
	for <linux-spi@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD18B64F8E
	for <linux-spi@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhCLU1J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234857AbhCLU0m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE30F64F77;
        Fri, 12 Mar 2021 20:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615580802;
        bh=HMAWEpXbDWhHEH9FS42YarcqzmocgPc+LFqgRCF50I0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZWX7Y52PFS7sgaQBbr3Hd4Hqx6V1tG5wsQe8aAkKsPWatvju4dD++RLnnzRh0wo1F
         t/v4l7ZzRIaecOSsKazeBMS5rUWPjZTUYryTqwpHFvwj1wQklUNf4Qv25NzN289X+I
         XIsvi5LvtY47JBVl+P5YdqHZiHgtd5Pc7kOofkzWnvu0PjXU14djNtsPeEKBxEWbwO
         PQYFJTTNfW/dGHgKBf7BfpZPiOL5tz6lSNMwexyRNJ1hDgUNWYQSGd1NVb+rsD5iKa
         uURI/bHL3D6YT/ez6MjUvtYUPHKkmIvs0cIMlfMcLsV/3mqWANtlPQRIZjvxdI8Dpe
         C1qmAgK4O4TWA==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     antonio.borneo@foss.st.com, linux-spi@vger.kernel.org,
        alexandre.torgue@foss.st.com, linux-arm-kernel@lists.infradead.org,
        fabrice.gasnier@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1615545286-5395-1-git-send-email-alain.volmat@foss.st.com>
References: <1615545286-5395-1-git-send-email-alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: drop devres version of spi_register_master
Message-Id: <161558072331.11700.1813208094032197257.b4-ty@kernel.org>
Date:   Fri, 12 Mar 2021 20:25:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 12 Mar 2021 11:34:46 +0100, Alain Volmat wrote:
> A call to spi_unregister_master() triggers calling remove()
> for all the spi devices binded to the spi master.
> 
> Some spi device driver requires to "talk" with the spi device
> during the remove(), e.g.:
> - a LCD panel like drivers/gpu/drm/panel/panel-lg-lg4573.c
>   will turn off the backlighting sending a command over spi.
> This implies that the spi master must be fully functional when
> spi_unregister_master() is called, either if it is called
> explicitly in the master's remove() code or implicitly by the
> devres framework.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: drop devres version of spi_register_master
      commit: 8d559a64f00b59af9cc02b803ff52f6e6880a651

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
