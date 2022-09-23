Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD3C6FA82
	for <linux-spi@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIWO46 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiIWO4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 10:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17B12C696
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 07:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B23BB815A6
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DFE6C433D6;
        Fri, 23 Sep 2022 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663945007;
        bh=msrGID6mMDTkqR3J+9lHQal9PrHaPwaE3LNtdO/anq0=;
        h=Subject:From:Date:To:From;
        b=o018+1gbARAZYbAAFDbI8LkgIUfRkZBVkpnjfS/cGOnr93ewTKhpIvL7963DgmiiY
         mM54jcnfMrEpWMLM5LpHDYx49er5px8qNlCaHxf7F0xh7AX9nHNscirh8eGZRAzvLU
         zEeAM4q9UJ9qHjuh9M+7V27sLDA8GDaywsknAdGQOvkjpdZGDK0huONJdaG/fEwohd
         rX82bYcTVi8GIXtgoNNIDYm0E4uZNasrlGnGZV6RWF3BUkN5y/Jv6oU2/gHJjga5rD
         ifjzyblBBbfyI5Idz7fKxSi5pUfDPJzgKFdewBANLyIlRklzl72Rt6ylWmL0rLrqaE
         kBYi3+QUjMsXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02E05E4D03A;
        Fri, 23 Sep 2022 14:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166394500700.16726.8973368764723020566.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 23 Sep 2022 14:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Documentation: devres: add missing SPI helper (2022-09-23T14:18:03)
  Superseding: [v1] Documentation: devres: add missing SPI helper (2022-09-17T12:26:39):
    [-next] Documentation: devres: add missing SPI helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

