Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD4C4361B
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE9C2376F
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgLQR5c (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgLQR5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 12:57:32 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608227812;
        bh=YGwhc187CDjxiT3xpAuFDHLqiY4RY9zZkFYG/OEn9lM=;
        h=Subject:From:Date:To:From;
        b=OUzHEKkCmpaIi9OVakFuA/MvQfizx6RkeB5SswvHqUVc7IMZpV8g+2K0EfWU/fjl5
         1uDq3hDTdLjDHFi5P5YYd82Nxyv5ywwSd29eiKuJ887ySw0C3soEKfmmd5A1TBG1Zy
         o5Pmsv4+iO9AfScj6GCBRPAYFaEK6oeSzo9x1XT5xhAHf0xf2gZRL+iNXRvMAV6Rr5
         AHmdbRr0M1RC1JzkUzAGkv6QH6+lCb6frHTXtYdkxbyorkgR0S5JP8qUt2LwTQkMeu
         nPHG7vdfaxou63tB55tKIVjGXSygQeC4AsMrOTyLiKQw/tQ9g9Ng/U1iAwtAEgFerP
         J+/qRQqYIG00A==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160822781187.5318.2971247797090387496.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Dec 2020 17:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: new feature and fix for Marvell Orion driver (2020-12-17T17:09:30)
  Superseding: [v1] spi: new feature and fix for Marvell Orion driver (2020-12-17T11:27:05):
    [1/3] spi: orion: enable clocks before spi_setup
    [2/3] spi: orion: enable support for switching CS every transferred byte
    [3/3] dt-bindings: spi: add support for spi-1byte-cs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

