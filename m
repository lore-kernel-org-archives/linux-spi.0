Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D8C2B9F4
	for <linux-spi@archiver.kernel.org>; Thu, 17 Jun 2021 15:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC96D610A0
	for <linux-spi@archiver.kernel.org>; Thu, 17 Jun 2021 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFQPDr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhFQPDq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74FB60C3E;
        Thu, 17 Jun 2021 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942098;
        bh=lkbsX4FMEiNZKCX7KQ+nzx+aak0hcYsazGytF8y6tIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sE3bXLVcxWoF78FD2whKfWctmaVtxZ8XaKSJZ4SEBVspQK2rcdEd/rEa9lbhEY8O7
         X8z9YlX9eZYRBNpdILtrrZyhuawE2ik4tYZ8zilW2O2RAwsCuO2tIBuucP0LSgPHQH
         K6eaxzKolaKfCnUlf6RE65UTOU+2BL0ULeVhgzmsiKzUfxfqfxk7SNsbSNzzpzAwCA
         rcgJSCot3WIi5iQF9Nw4htRAxd24zhAakLX4yhYHH+BNvNyIBQXSyPQ3hFtJh6Vy+K
         RY/2SYdJfMAivxNLgHcNPN/kWclD5fhsHj+53ppmvM4dSNAXcaGEiFSzgus/z+6Xf+
         EHjolozry+xcA==
From:   Mark Brown <broonie@kernel.org>
To:     michal.simek@xilinx.com, robh+dt@kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: xilinx: convert to yaml
Date:   Thu, 17 Jun 2021 16:01:12 +0100
Message-Id: <162394121400.19455.420926451779149783.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605002931.858031-1-iwamatsu@nigauri.org>
References: <20210605002931.858031-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 5 Jun 2021 09:29:31 +0900, Nobuhiro Iwamatsu wrote:
> Convert SPI for Xilinx bindings documentation to YAML schemas.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: xilinx: convert to yaml
      commit: 476ad3ff8952db3569a77d9ed4a067c5f0f4b733

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
