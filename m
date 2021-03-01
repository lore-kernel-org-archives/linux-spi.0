Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C08C433DB
	for <linux-spi@archiver.kernel.org>; Tue,  2 Mar 2021 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018C264F44
	for <linux-spi@archiver.kernel.org>; Tue,  2 Mar 2021 13:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhCBNS5 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 2 Mar 2021 08:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346256AbhCAXkB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 18:40:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 498E460240;
        Mon,  1 Mar 2021 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641943;
        bh=11tc3XCd4ttATWcpDw1lCPmytuMBwWlibLxpQSnMXC4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GcmFDVy/XO0MF3h2k+3kRlAYVcIjZhsNdcaOD1aAC0d++PaSK8FIatnNxc2asVRH1
         KVsQlpwfgQC7AlTMuhmxCj7cTSJoNagR8eincqRB258X1vTWmc20y6Eh/orJRkm7BT
         tU2yWjneoN24CCcSFhLKsMydQrYBj6sTAcBzf0b/KJF6ASjwClDudoGWvn0Vj3poy0
         6ZXZMQ6zZlSh72LdObtMK5FSbcyPwvtKbI2KEvz4wuV1FTyi4R0EvjU6qiBGIevc9a
         leyq4vLdyN2PesuaeeJoc3P+1qvqxF1y43zQjNvycpgY/ewF1s9mrBeeGrxO4V/T1O
         aMP/TBHCfCuPg==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20210226140109.3477093-1-arnd@kernel.org>
References: <20210226140109.3477093-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] spi: rockchip: avoid objtool warning
Message-Id: <161464187231.31555.9991392584243139110.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Feb 2021 15:00:48 +0100, Arnd Bergmann wrote:
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
> 
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> 
> Change the unreachable() into an error return that can be
> handled if it ever happens, rather than silently crashing
> the kernel.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: avoid objtool warning
      commit: d86e880f7a7c5b64a650146a1353f98750863f21

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
