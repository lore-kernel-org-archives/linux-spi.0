Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E497C77B7A
	for <linux-spi@archiver.kernel.org>; Tue, 13 Jun 2023 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjFMI5H (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 13 Jun 2023 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjFMI46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jun 2023 04:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D494186
        for <linux-spi@vger.kernel.org>; Tue, 13 Jun 2023 01:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9F662D3B
        for <linux-spi@vger.kernel.org>; Tue, 13 Jun 2023 08:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60E67C433EF;
        Tue, 13 Jun 2023 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646615;
        bh=3phsalFEcjMvJRG2MZF0J8Px5UwRg89l0P/eOh8W5fk=;
        h=Subject:From:Date:To:From;
        b=C++VqT8wRgxctfFUKQiM1puqGB9oR4WtMj1xEXDdQH5P2bafbj15i9W+lStoIjK3y
         tBaNmDKIJ57t5MZpPHYy7vTIfb7jCz3FodRXVmyOASzKN4nm+Rcp5d1L/zw6dVJ2At
         F6wj5rLQoxTczzvQY05wPgzR4NzRUHdj2Y5b70Dhf4y5U1NpQmIolvndtfQ2B8wUPx
         6FazLNiLG0xhYxWiDcQEo06Ajxhrj01JAwqY4TIlMPRjsccO7YRqayMWU+Tg9FUJ/e
         j47Xpp1O+dQi5kZHPQnPBn0I+wyopb106HwkETVucamGdUnivfnNPOAd1LmGH1BdnB
         R6xP8XRkiwf9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 419DFE2A049;
        Tue, 13 Jun 2023 08:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168664661526.17105.12905923310117239708.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 13 Jun 2023 08:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v13] spi: loongson: add bus driver for the loongson spi (2023-06-13T07:58:32)
  Superseding: [v12] spi: loongson: add bus driver for the loongson spi (2023-06-08T07:28:18):
    [v12,1/2] spi: add loongson spi bindings
    [v12,2/2] spi: loongson: add bus driver for the loongson spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

