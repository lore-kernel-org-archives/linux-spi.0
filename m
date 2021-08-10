Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF3C4338F
	for <linux-spi@archiver.kernel.org>; Tue, 10 Aug 2021 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D81360E9B
	for <linux-spi@archiver.kernel.org>; Tue, 10 Aug 2021 08:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhHJI5J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhHJI5J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 04:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B602260E9B;
        Tue, 10 Aug 2021 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628585807;
        bh=2NoWXigMY9qzTAdJo8k8yJGD823uznJAGISn+Tf6QKg=;
        h=Subject:From:Date:To:From;
        b=WjuZlwXu3wxWQ7RtEiY9EnnvqrqVnIY3x1Gmzf/p3iWzsgb50LLpB55qlmvNKAvu5
         3JOHmFC9VoiUAbhyeVpnHfDWJgG0PhpNUx3A939agyvhJyPd2THgMtx7BEKqlF5ywE
         aJaE/yBjNYu6vGPmXDQymSjyOe2PHbpyyqxhRGf+DjoE9zhBTnIXUxphJJbHVfWOsh
         7GZSIfzl62/7jmMweuVbTQ7q1SFe5S2ouoYn5JiX8yJnZYNEh2rBuxy9aA+yAC6VQp
         FoyGQU/u+eaeo5dBf0cdURSr7oRX3y7pTdC5HuuW3MeoVUfMbCz/h3deNDdtjKXcDF
         LZ3+e0j7QBogw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162858580768.21398.2005558731490061579.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Aug 2021 08:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] spi: mxic: patch for octal DTR mode support (2021-08-10T08:29:46)
  Superseding: [v7] spi: mxic: patch for octal DTR mode support (2021-08-09T09:39:23):
    [v7] spi: mxic: patch for octal DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

