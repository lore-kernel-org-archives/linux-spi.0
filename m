Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C3C001E0
	for <linux-spi@archiver.kernel.org>; Mon, 31 Jul 2023 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGaUAZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 31 Jul 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGaUAY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jul 2023 16:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D219A2
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 13:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA728612C3
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 118EFC433C8;
        Mon, 31 Jul 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690833623;
        bh=b3xxH73CHAuuvByX5N3swfRJAFncGmfv+FeDwnPn2zw=;
        h=Subject:From:Date:To:From;
        b=P8DzalC0xcJ6KnzJLws7ArX7sXsQLqFMwkzk3qaEufFjd5TzzSbqW6tBzqRba/EeR
         v6m41Fc+lamny/5pXkWR3kwm1rcxZg4wX2Vt5AtMgpkQDMLep5W9OzYA3hgSC3rPfI
         9lxfA+sl/LbEg9OkkMSlxAW0/+RDXce/Ea1OphLHWLrHGjltmh64+GinYnEhdBUU47
         qVl/I4IVoTsrZS/DpXPXS9D2aLwaZEHYOtESprAoElrYhx+okoYS6Cq0i/sIjUE56h
         jUFcqaVQBcQq6a8FhLk+2Mca7oG7PlfaAgvxmOVoiSvYr4AGuuwVwL47k005uVc38d
         KANjVVkukyXLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7F96E96ABF;
        Mon, 31 Jul 2023 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169083362278.16570.3261773183656801438.git-patchwork-summary@kernel.org>
Date:   Mon, 31 Jul 2023 20:00:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: loongson: add bus driver for the loongson spi
  Submitter: Yinbo Zhu <zhuyinbo@loongson.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=756627
  Lore link: https://lore.kernel.org/r/20230613075834.5219-1-zhuyinbo@loongson.cn
    Patches: [v13,1/2] spi: dt-bindings: add loongson spi
             [v13,2/2] spi: loongson: add bus driver for the loongson spi controller


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


