Return-Path: <SRS0=+2U+=DN=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B3C41604
	for <linux-spi@archiver.kernel.org>; Tue,  6 Oct 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB405206DD
	for <linux-spi@archiver.kernel.org>; Tue,  6 Oct 2020 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601997744;
	bh=S1iVkiUFy6uy3VDJOO4K1ZuOsQXL4YSszYSoi/VRUN4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=vyS4dOd8q5+87Xle13ILErRD7EmVutK83hVa0LCIOqvyzicEN9F49obgybvbn6Wu5
	 AgENJlpqwc+c1X+t9oJ6i/HAawYFmiEDemI8nyUDHU50/rj/0REoZxqEQ9SD7T/OWh
	 X6yQUSqlXK0mZPx7/W0fouljVrEuRIHmdVEmUrXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgJFPWV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFPWU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 6 Oct 2020 11:22:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA46206F7;
        Tue,  6 Oct 2020 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601997740;
        bh=S1iVkiUFy6uy3VDJOO4K1ZuOsQXL4YSszYSoi/VRUN4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xKBEQODkIy3GsU6oVTT7DQ2AzitYekNw2M5EEtKJaCo53c8gNEQWYThOxvwpcdSno
         KrMDSx943hssEKWWEJrcyCjdUSKWD7rU0AG1+wKo2AxK67ekf/4jHUqs7SF/sz5ChH
         uAPwuKS+o/JOymYjFEh9BR+xshZFU+ajcBCsHZBE=
Date:   Tue, 06 Oct 2020 16:21:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bayi Cheng <bayi.cheng@mediatek.com>
In-Reply-To: <20201006075405.11658-1-ikjn@chromium.org>
References: <20201006075405.11658-1-ikjn@chromium.org>
Subject: Re: [PATCH v5 0/4] spi: spi-mtk-nor: Add mt8192 support.
Message-Id: <160199767222.51670.3734614928082505881.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 6 Oct 2020 15:54:01 +0800, Ikjoon Jang wrote:
> This patchset adds 36bit dma address and power management
> supports for mt8192-nor.
> 
> Changes in v5:
> - Rebase from merge conflict
> 
> Changes in v4:
> - Drop two patches from a list, addressed by an another series
> - Fix 0-day ci 'shift-count-overflow' warning
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] dt-bindings: spi: add mt8192-nor compatible string
      commit: 9935b612a5dba99cf8dc0f9fe7592a2a35c005fb
[2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
      commit: a1daaa991ed1f13b86f6d9df174f21c4e23d33ba
[3/4] spi: spi-mtk-nor: support 36bit dma addressing
      commit: e836d4cf615f89c6695408e5dcacdefa5cf50167
[4/4] spi: spi-mtk-nor: Add power management support
      commit: 3bfd9103c7af07915a84a6849e718622936233c1

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
