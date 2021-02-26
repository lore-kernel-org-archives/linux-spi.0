Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B6C433E0
	for <linux-spi@archiver.kernel.org>; Fri, 26 Feb 2021 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3080B64E20
	for <linux-spi@archiver.kernel.org>; Fri, 26 Feb 2021 14:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZO5O (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBZO5L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 09:57:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E93664E4B;
        Fri, 26 Feb 2021 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614351391;
        bh=PPJZAQ4QQ5OYqp0RP94k38iy1+YvjTYEPwJJtfNXpzQ=;
        h=Subject:From:Date:To:From;
        b=jN8Wi7a/LI8P3Vz3/0jP1EAsU4UtaAf6YiaXHOWY/QUNCGpOMAd0zZUqA8hGk5vCk
         QlqnUIIaBv/KKL4EtEMoxQqMh6KdfoZWTCa9h84KRqDnT4W5DrDzTECugh2FskNk8w
         i+O9+ChPOlD7UL9vhXEuM84c7EX3dxRIToTa8tKwMlYuVcbAUmiLpuTBLwlTCI+abU
         NrapvPKeYqIyUHdBeDZdWf6VpqRYuzkWni1IQ8GrEOfY2RLnd8nBgmafW3QgyDPZvK
         RYQvi7YuDvuYZxn4sUH1yqa3iglVxFWXoTMse2JV9efuZLNXZEAELE97kytCldGx7U
         MEdpU/4nSlunw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161435139105.7828.14069610643341097740.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Feb 2021 14:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rockchip: avoid objtool warning (2021-02-26T14:00:48)
  Superseding: [v1] spi: rockchip: avoid objtool warning (2021-02-25T12:55:34):
    spi: rockchip: avoid objtool warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

