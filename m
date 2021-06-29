Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B45C11F67
	for <linux-spi@archiver.kernel.org>; Tue, 29 Jun 2021 19:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E474A61D9A
	for <linux-spi@archiver.kernel.org>; Tue, 29 Jun 2021 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhF2T7L (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhF2T7L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 15:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A4F3960E09;
        Tue, 29 Jun 2021 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996603;
        bh=ysPtl1vMxhHvFJpM6X83iKkUaaOQFOSTiUjUJ/6g4qM=;
        h=Subject:From:Date:To:From;
        b=R/rrINfTz+treZLOE0eacnNw+lDZp+rZchm/f4x9PBEdUqlNKUqi5k9vA0BXuJFX9
         e9Tac535qoGyZWDlIF/tMqWM1VnOJFXemR85KW9EqUMcXl2JeL+kD5CkSC2B5sH+dj
         AO0MU8K9RuW8lfT2v1bJTzrGcb+WBRZawQ9b6pVHnA1dQuhYGHySkYjYHXwP/l7gCW
         J7u2Oq4ulgYQ/3cXrGZ1cgP4M1S6rDYcYdSM2uGVfg/cdL1gn1JH1kJXpOIp38Sm2Z
         Dk5M/jjSx6Og74IvO5zDxaKWBsikznakiLmjn95FTBfONKfqC3Xu329M0J2tSlY1j9
         EYxFtZwYtY9+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162499660361.29472.14006569895049720827.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Jun 2021 19:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: atmel: Fix CS and initialization bug (2021-06-29T19:22:18)
  Superseding: [v1] spi: atmel: Fix CS and initialization bug (2021-06-29T16:29:14):
    spi: atmel: Fix CS and initialization bug


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

