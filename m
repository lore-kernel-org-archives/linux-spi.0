Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB432C433EF
	for <linux-spi@archiver.kernel.org>; Tue,  7 Jun 2022 10:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiFGKsk (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiFGKrd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 06:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E3F339C;
        Tue,  7 Jun 2022 03:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7250361555;
        Tue,  7 Jun 2022 10:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B2EC385A5;
        Tue,  7 Jun 2022 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598802;
        bh=ekCfkKozMAzzyqQ/p4pW1Ae35RQKaz4B54eLEG/rnjc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JqHZlsBZwDXTasm//ds0HqKarYsEhRH1fwC9igTIFRrDWx/c5FJAHd0KKah8AdhKf
         i6WZsg21jMm0vKb9OGi8S1j9heMiDH3hTumfVCI64axpLs3VZUvmR+MHz2plDO7FOp
         hwWXrDhZbyqCCWnFL3HjGUHP5rJ3Tw8Ky6YgWgtvSMQNP49TvAwzHbB3DwyB7eGQML
         UehZ8IOSI01ma6CVdIXmpOIiieh0EN9jmhOnttI5FGLtEUJfY18yZ/YQKLqjsZv595
         BXnG3/gQ1QMmjyf1/As4oY66qESXfliUDw7wIFNnyT4MtsxyLdO4Wwupf7h8R8wf19
         rQ/0QxrdYehSQ==
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh@kernel.org, p.yadav@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220525210053.2488756-1-robh@kernel.org>
References: <20220525210053.2488756-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml
Message-Id: <165459880111.302078.11490460900047946308.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 25 May 2022 16:00:53 -0500, Rob Herring wrote:
> SPI bus per device properties must be defined in spi-peripheral-props.yaml
> for unevaluatedProperties checks to work correctly on device nodes.
> 
> This has the side effect of promoting 'rx-sample-delay-ns' to be a
> common property, but functionally it's no different if it was defined in
> a Synopsys specific schema file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml
      commit: b658be56e867061a0d5496e837f350974ada5c89

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
