Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D277BC433F5
	for <linux-spi@archiver.kernel.org>; Fri, 13 May 2022 08:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378660AbiEMI4k (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 13 May 2022 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378663AbiEMI4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 May 2022 04:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD065DA7E
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 01:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA72B82CE3
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 08:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A90BC34100;
        Fri, 13 May 2022 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652432194;
        bh=4/y+f9wjrKfojqTA4YXRajRLmnPafxJ6+e8f2YuoGTk=;
        h=Subject:From:Date:To:From;
        b=q0B6OxEgfnGVS5pXtBQfSVmojUsaBcozJnQnrq/ui3GCJuvrlXgx+xRo9pxoi6A3N
         bba6x3uM0v97cPl/N0tzmEyKzRwS3/tillvO05kTPT7SHRVRfqiUAtX48n6vRmh4kl
         WobvRfAFdAse+6jhOY0QxN5ClLgJkQ5muqA9n6HrHKyvPMXLN9x5frgdTcs9XVrQ+6
         7IQwtjCv5xJb/z5ROmwz4PMaRlnrf1CpLyggrjHy5Cn5ocucmyNUnGMXDU40JKebUq
         5qFPPNxPLcgZ+tmYkNgo33vwicR13AAB8CWvO2MKDNfdEG/eLbrlNwv3YDFZb0US6S
         I0Ciq5Qeevgig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C466E8DBDA;
        Fri, 13 May 2022 08:56:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165243219404.14580.11372648510337320622.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 13 May 2022 08:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra quad: Add Tegra Grace features (2022-05-13T08:08:25)
  Superseding: [v1] spi: tegra quad: Add Tegra Grace features (2022-03-17T01:20:03):
    [1/3] spi: tegra210-quad: Multi-cs support
    [2/3] spi: tegra210-quad: Add wait polling support
    [3/3] spi: dt-bindings: Add wait state polling flag


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

