Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331DEB64DC
	for <linux-spi@archiver.kernel.org>; Thu, 15 Jun 2023 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjFOM5H (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbjFOM5D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jun 2023 08:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194226AA
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 05:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CEF462D7F
        for <linux-spi@vger.kernel.org>; Thu, 15 Jun 2023 12:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C89DCC433C9;
        Thu, 15 Jun 2023 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686833821;
        bh=/N2iHcpS3TxuhDJZWz5CqFnfr96lG8oySpp2fUSMy1c=;
        h=Subject:From:Date:To:From;
        b=iAV1KCjT8foBhvcz8gc/4yXZEp6Rh+AC/jV1CawD6uADDJwxHRQOv+vb/5Nyev8+D
         L86t2P+wrb1KP8RN5GdtGjKHNzaECn+P3GWMVyVzKjwhccR4af+JUB07/bYteT0CIk
         M7q74jOQ7ZAAv+9rgoYR/qolgw9R9RLAK2e0ojUEAQBsd590kJ6Lzuo/mArBbVpL4R
         E7g6kvLP4/YMnaSfcianzkqMsCKsYjXekII3qISpOgZhDfqSNqingvWRlXLbrXPwXk
         I/RZTOS1RHZdZ7H4Fa1aa+DkF2SFW7//vqVIFEroyLS8ZNaQjKJ7jvpm+9wcYoPUBI
         PS496PrCz+QHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACA39C3274B;
        Thu, 15 Jun 2023 12:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168683382169.23399.736529602057240478.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Jun 2023 12:57:01 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan() (2023-06-15T12:51:45)
  Superseding: [v1] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan() (2023-06-15T09:23:17):
    spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

