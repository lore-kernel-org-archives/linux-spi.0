Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC96C25B4E
	for <linux-spi@archiver.kernel.org>; Tue, 24 Jan 2023 08:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjAXI4W (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 24 Jan 2023 03:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAXI4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Jan 2023 03:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8438039
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 00:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8076DB810DB
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E36C4339B;
        Tue, 24 Jan 2023 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674550578;
        bh=deHa8FXaqgaux5Box1ub3CFCb0Coqj1U+iWyuaouJQg=;
        h=Subject:From:Date:To:From;
        b=jiJzENCltr9yQkHXHQ+7WhwK/pfOXD+t9h9IlfBvxpfCJgXBHS7HhQv9gT8XRlL86
         CcHgHK8d5KKnoQe3C0IoJo8o0YMLlwgGskR+xbHxvZHO7Kr2tkH8OlN/dOT9ThnCij
         c1KYPGwN+WXEBuf4lL47avrsQOQ9+oyOwun3JblZFfLLe1QLnIvwFcSRm8xyMc4XGE
         eiaYxgYh1qnkzao53mu8OXVOTGgTAho6acvJlpfyQxyoIEu2a1EYJpV5j78UMGy9YS
         fvy2NR4Go1ai2w/lopYpXduAo4zKplb+N+hjGbgAuRlzFrvYkvDyOqX/anRZvYg3SS
         Vjg9jUjkYcUTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D2E9C04E33;
        Tue, 24 Jan 2023 08:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167455057811.25569.4105589366594086379.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 Jan 2023 08:56:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dt-bindings: drop unneeded quotes (2023-01-24T08:33:41)
  Superseding: [v1] spi: dt-bindings: drop unneeded quotes (2023-01-18T17:39:31):
    [1/2] spi: dt-bindings: drop unneeded quotes
    [2/2] spi: dt-bindings: cleanup examples - indentation, lowercase hex


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

