Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2860EB64DD
	for <linux-spi@archiver.kernel.org>; Thu, 13 Jul 2023 12:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjGMM4Z (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 13 Jul 2023 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjGMM4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jul 2023 08:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19A1BC9
        for <linux-spi@vger.kernel.org>; Thu, 13 Jul 2023 05:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0731C6114C
        for <linux-spi@vger.kernel.org>; Thu, 13 Jul 2023 12:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64781C433C7;
        Thu, 13 Jul 2023 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689252982;
        bh=7Rdut50YgmL74I6Ou+u3SqyNxSR8pDcgoL828O5oiW8=;
        h=Subject:From:Date:To:From;
        b=FoS5hlOEWnY+2+JAim9GBAA88vYzjOWiemN7V9L0t9xgJLjNx/bG4la8ALbNy3wwF
         VTGh0EEI3VRQsrmdq/ChqNzv7ufeSfD92xhbKtcIZAXYjto8w7RBOrK5TS49KF3QoD
         +B2S/Ujc0J+iYrPzMdKif6IWEwdd9+8Q2zk8Bf0YjdG8PENzCWFO66VNcZ76nfCIe8
         aHxXSYM8ET/O5SDRFj0LAr/4nFQTV2Rarw3XXS/2xpPridmGD+L/QV2rS7711SLNkT
         0k+KZuK5rYbZphCwjXcgyg1/1L8fbcQsyj6EVMkebVW5/saWoVUi0fkZnUWqqsZPvo
         oIM5PNMJWVJkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4973CE29F46;
        Thu, 13 Jul 2023 12:56:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168925298229.24878.13973234711339152635.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 13 Jul 2023 12:56:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-07-13T11:51:43)
  Superseding: [v5] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3 (2023-07-07T05:16:34):
    [v5,1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
    [v5,2/2] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

