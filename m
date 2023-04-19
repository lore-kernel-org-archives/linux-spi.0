Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CBC77B73
	for <linux-spi@archiver.kernel.org>; Wed, 19 Apr 2023 08:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjDSI4k (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjDSI4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Apr 2023 04:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D584220
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 01:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97895630B2
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 08:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECCE8C4339B;
        Wed, 19 Apr 2023 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681894598;
        bh=BWGFOFk+C5sxQCn3gcctULTtjkO5MTqzaKNmy86BlE8=;
        h=Subject:From:Date:To:From;
        b=V5xIcT1dQIdTjEtWRQq/vBpryilEAdlX8wqBi31LsfocedGEvnaIZVKGmJiOHiWLN
         OB6ntw0fe2qbaTOlaqseFF/5AyFg5q+NGH+grGdwkw3mxD8LnyhtOXrDt4vXhtPS3o
         d3buQEL9jR7n/hf/8yFuOmCl/n3MBOhvrp46cQfsyqzN/xYKdSv7nSEwFaQy2/kURj
         bC/+a9GpuhFr/S2s9WBNuJITBCbhc3ba3fNeN3apd/hnk6iqPzBmX3XV7977hj1XEB
         ojJ9mZBxnmtjXxxhQa5p4/7ty2HH0pp82GKb3lMeJCyprfvoBvAzdD+yLd/YYWdTKL
         J5jthJLCrd2Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8C9FE3309C;
        Wed, 19 Apr 2023 08:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168189459781.21888.17317658585933280299.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Apr 2023 08:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: sh-msiof: Enforce fixed DTDL for R-Car H3 (2023-04-19T08:24:32)
  Superseding: [v1] spi: sh-msiof: Enforce fixed DTDL for R-Car H3 (2023-01-24T07:47:06):
    spi: sh-msiof: Enforce fixed DTDL for R-Car H3


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

