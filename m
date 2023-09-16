Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2689DC2BA12
	for <linux-spi@archiver.kernel.org>; Sat, 16 Sep 2023 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbjIPS5T (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 16 Sep 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbjIPS4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Sep 2023 14:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A8CE7
        for <linux-spi@vger.kernel.org>; Sat, 16 Sep 2023 11:56:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C5ADC433C8;
        Sat, 16 Sep 2023 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890608;
        bh=YiboOc5TzurkL/65lgMngxhXjyYtoELgAjpSNZoV+FQ=;
        h=Subject:From:Date:To:From;
        b=R5KFMA1Up3dXpnPLtmX9a/jEV7AdtjaVt8oeN9byvPAhr9Tiw6nA/oQhaEhnjabea
         u3m5s70kBRhnDVkMIi4haZ6hpsi1bpojEL+MmbXkwL27753LBxOCPX+p0YX20nrgrL
         BeZWGdSkrYuTsRQzWU302EcEqm2mDZcW8MWB9/5NDIQ6P0rf91HU3s/fe2h4NhVXLq
         5wfrxhD0R9hCtUdya2VRmJTCO5eViPdzODozN6iSoeAE9aElpGywEsdqgvqJcPBjo7
         jN0CJz1O4CQ3H74NrxrSmJVeuCZVIH05uv6t2DRJFyDy4nH/4b6va+25WlvLt/YQvc
         5Ncj2Pp8XW4IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80435E26881;
        Sat, 16 Sep 2023 18:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169489060852.2141.3545502769118577508.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 16 Sep 2023 18:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v18] Add Intel LJCA device driver (2023-09-16T18:37:18)
  Superseding: [v17] Add Intel LJCA device driver (2023-09-14T12:45:26):
    [v17,1/4] usb: misc: Add support for Intel LJCA device
    [v17,2/4] i2c: Add support for Intel LJCA USB I2C driver
    [v17,3/4] spi: Add support for Intel LJCA USB SPI driver
    [v17,4/4] gpio: Update Intel LJCA USB GPIO driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

