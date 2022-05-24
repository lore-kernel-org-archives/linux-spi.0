Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10521C433F5
	for <linux-spi@archiver.kernel.org>; Tue, 24 May 2022 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiEXJ4m (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 24 May 2022 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiEXJ4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 05:56:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86445F8FF
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 02:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FEB1B8169C
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 09:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20EC8C385AA;
        Tue, 24 May 2022 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653386196;
        bh=cUpm1FZCoFY5B2xuZ/lNdSat2zUvdL5NmWVW4NUciHI=;
        h=Subject:From:Date:To:From;
        b=sRpL5gqDlIw6pqmqiynJ+SYtPvV7QWplOXrKFwZYJdHCWCm/pPDU5FDItZptXbLdm
         CY/1blCfuFv98CbSEQNaTUJtJ+6PiG+xrgXzMUv1c96uYfCsq2RDAnjLL6ngWjXIaW
         4pfw36sKyIijEUt4VJjP7MZpRcYBb/8iBu/oE2cqKe08u729viCjew1ajo0Az7903U
         QNCuNo8ZVIkdLiAdeVQ08SiPpziusqt4+W1cC/kaGWHYCD/dGaT/kdqtxNGxra84QA
         0yVsDliBbqyboDNSNWjq6us/GRmRMoNbQ4U7Nb6KUi2HcTtKdH6KBQ3PkxDnOYohS0
         WEtZyWEcxU20g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CB05E8DD61;
        Tue, 24 May 2022 09:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165338619604.21110.14105967081546027241.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 May 2022 09:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t (2022-05-24T09:18:08)
  Superseding: [v1] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t (2022-05-23T14:20:09):
    drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

