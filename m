Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA0FA373D
	for <linux-spi@archiver.kernel.org>; Fri, 21 Oct 2022 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJUPc1 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJUPcG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 11:32:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1119046F
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 08:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE44B82C98
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 15:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF8AC433D6;
        Fri, 21 Oct 2022 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666366307;
        bh=nNMpahqhITRxHeDUZKKlJYBgzqITQHfN6JwdZm/AqWQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aGi32uvXzebx1tpP9xFLxubpjSVsUNpctHCAmdi3u+hvUsc687m3JM7btJR72YCWI
         SY9mTld9kf5nC5dsmGi7EsDZlIHGQ7EOMGJDguOR6bpTmj0kG454rl865Gb54uYHFU
         yeJHgs1ApnZ1WhJyETA0K2Sqm3gjqCWzub8nuhj2Avb9uuFaDa7syEIdjPSMfCxhNM
         eDuEyQpeN2XmyoelETxyy9wwCHJ41GrK52sEH/C+5vvmU6oNCUn+JaxT5GpfLIUP0h
         LGcnF/+JRHozpcsdqXZnVp7Wz3ZIaESdqJixCCuC5CBvplZNRifPWt8p9vGRH67Szn
         SeOD5fZT/Rqrg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20221021131051.1777984-1-mkl@pengutronix.de>
References: <20221021131051.1777984-1-mkl@pengutronix.de>
Subject: Re: [PATCH] spi: spi-imx: remove unused struct spi_imx_devtype_data::disable_dma callback
Message-Id: <166636630609.311920.13260993160112371914.b4-ty@kernel.org>
Date:   Fri, 21 Oct 2022 16:31:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Oct 2022 15:10:51 +0200, Marc Kleine-Budde wrote:
> In commit 7a908832ace7 ("spi: imx: add fallback feature") the last
> user of the struct spi_imx_devtype_data::disable_dma callback was
> removed. However the disable_dma member of struct spi_imx_devtype_data
> and the callback itself was not removed.
> 
> Remove struct spi_imx_devtype_data::disable_dma and mx51_disable_dma()
> as they are unused.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: remove unused struct spi_imx_devtype_data::disable_dma callback
      commit: 0a7693a0da649e7ab7d07a5373fbda21231e67b2

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
