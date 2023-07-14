Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB870EB64DC
	for <linux-spi@archiver.kernel.org>; Fri, 14 Jul 2023 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjGNUA1 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 14 Jul 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGNUA0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jul 2023 16:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9CE5C
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 13:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EB461DD6
        for <linux-spi@vger.kernel.org>; Fri, 14 Jul 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0578CC433C8;
        Fri, 14 Jul 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689364825;
        bh=NMuOnTY4gkbx4Kge9V9x7Kv8In/qlEZ9Qf8Jxh/L9rY=;
        h=Subject:From:Date:To:From;
        b=ePbqfb5zHc0jZEYWEJE89bfAwuvVxGmHUeBSdCga5fJQAAJ40XUppJJiAqa5NQVXJ
         kPaJI8mDExvHZc/OS4CwRbv9K2E1AmqxakdyRlVHG15rs69XX0pokj7+ZnpWFIP9o2
         /6uJNiKaWc0Le3fmqfdDW2vkOfWusPF4mVZLuwhB0+d6pI4MqTjoFBviEeAyAncJ4x
         ozRpvUxM3TbwcK4SLe0DQnNJx0yvaYFsa86+XtOlYmN7hx5dJXFq46TuGv99/Ga7bn
         SCWUckbRMbz0wjKjJ0f+CdfslyQSjxpvhpDtO/w9/XHSSEIdCbHf6IaII6UyJvEpdD
         JE1vtaNj+BWjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2C4AE1B4D6;
        Fri, 14 Jul 2023 20:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168936482474.30217.14584334429009627787.git-patchwork-summary@kernel.org>
Date:   Fri, 14 Jul 2023 20:00:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Header and core clean up and refactoring
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=765647
  Lore link: https://lore.kernel.org/r/20230714091748.89681-1-andriy.shevchenko@linux.intel.com
    Patches: [v4,1/4] spi: Remove code duplication in spi_add_device*()
             [v4,2/4] spi: Kill spi_add_device_locked()
             [v4,3/4] spi: Use BITS_TO_BYTES()
             [v4,4/4] spi: Use struct_size() helper


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


