Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9946E82CB1
	for <linux-spi@archiver.kernel.org>; Wed, 27 Sep 2023 16:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0Q4z (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0Q4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Sep 2023 12:56:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA799C
        for <linux-spi@vger.kernel.org>; Wed, 27 Sep 2023 09:56:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09A85C433C7;
        Wed, 27 Sep 2023 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695833813;
        bh=tK/2UkqsmlEMlaCAv87OtFnigjp4QLSaKKmjmJ8EnAA=;
        h=Subject:From:Date:To:From;
        b=JohIpk5Oq9boR0wwmqLqSOr17CQJ9DKzLm5zIaVdZZqrzAeqYtFaLC/Ltly96Ws5M
         5FCHh0DQyXftHKoHBzEYMzHtqRaF6KGC2TmjBSyIuDA0K9CSXAkTiU7ZMS5KdhnGwY
         GBkMLzLOhbMxJNaBL/n8h8rtjvwOxJlEBHiuu9wWEP91DEBSpTw58+dCkdyjNOF6Ii
         jjJjBdF5Tglph22b2kzeoIHUF1xnp5f/EHe7uZmjLx6h1NqTdYE4KpF4KCat6uLTZP
         da91SXdpc2BBk2hKt7+25aUCpBV3re8/FM2cBhY5i6YDo9XYrvYWXq3zNGdIQFFG1j
         xwPdYg7o+eibQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2865C43158;
        Wed, 27 Sep 2023 16:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169583381292.17458.7888902534770011411.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 27 Sep 2023 16:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add RZ/V2M CSI slave support (2023-09-27T16:25:06)
  Superseding: [v1] Add RZ/V2M CSI slave support (2023-09-26T21:08:18):
    [1/2] spi: renesas,rzv2m-csi: Add SPI Slave related properties
    [2/2] spi: rzv2m-csi: Add Slave mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

