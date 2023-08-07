Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79FC00528
	for <linux-spi@archiver.kernel.org>; Mon,  7 Aug 2023 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHGO4w (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHGO4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35C10FD
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF2261D9F
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 14:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD68C433C8;
        Mon,  7 Aug 2023 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691420204;
        bh=kcsvVFWIAftHSqIkp/lOkvf6L+7mCnPJCYsRxXia0dA=;
        h=Subject:From:Date:To:From;
        b=iB0bdRQ+eJVq9ZyMYHe3ujnJhZJ6YnNugaOnFPZ+4kviBigAOnZTwFi4e0iLOnrfa
         LMLzFJePMqQPZaQ18DJtWDAnT4WU6lon5CeUidzF6HdYsQaMhH86JNYOlCL+9kCl1A
         4kiqcJE3E0stvuKJFY0RH3WH4bNCvBlGvw+gZvDREoSQYw6FYtV1PunzSeetuwABZA
         /ejZfu2tyRyAGhhvMRRhOlccjogVEMfxIjV7BAP4HWa0vermq9RR+9VM2lJXjOTSVk
         Y0MXXosXZWK66ThwR7n/RRZdeFHfP/cbJkNdf+29EiOk/1OG/SCIa8qn77dbhTRoa8
         1AbXp7jwfqr7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83020E26D5F;
        Mon,  7 Aug 2023 14:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169142020452.30977.15473523691221658015.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Aug 2023 14:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-08-07T14:49:41)
  Superseding: [v3] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative (2023-08-06T08:37:33):
    [v3] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative

Latest series: [v2] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative (2023-08-07T14:49:42)
  Superseding: [v3] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative (2023-08-06T08:37:34):
    [v3] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

