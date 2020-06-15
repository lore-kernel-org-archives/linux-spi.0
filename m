Return-Path: <SRS0=lX55=74=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8BC433DF
	for <linux-spi@archiver.kernel.org>; Mon, 15 Jun 2020 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3604D206E2
	for <linux-spi@archiver.kernel.org>; Mon, 15 Jun 2020 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592209220;
	bh=qDeIK91JNiHba84/kTdlY0EgdWJJbdIZnJPdTk3tySM=;
	h=Subject:From:Date:To:List-ID:From;
	b=lG2JD6JyrY+uGqvydT3Nucj9CCJCiy4Xr7lCdNEew5foVfCVOgSDfaq35ESwW8wHN
	 R81a3rhajdiWeb5Z2bgByuqAkyRIqMnsmxLR8bcpnvaJ/O5gBaeTNbCaOTBZupzLyK
	 7NcAzsobPs8o+5dCaOML72PpQc09V87gAyQ2Ndv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgFOIUS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgFOIUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 04:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592209217;
        bh=qDeIK91JNiHba84/kTdlY0EgdWJJbdIZnJPdTk3tySM=;
        h=Subject:From:Date:To:From;
        b=vbeXJfdpdlmPwC6/q0dpsWp7nRwVs4Wz6FcgyMC9xXKqjzHLv2Ts7eHUL/BlGUisV
         A9Wmus4ZcsjLKgDUDoUOiLxhPtqq6yet2gojm8brg162ZN1Kb5XDYQerEy397fkVMy
         B+aai0jKG4tBx0ZrflJ2DL186nZLJYTyTfuTdmc0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159220921743.25874.1598464229068126619.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 15 Jun 2020 08:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-fsl-dspi: Fix external abort on interrupt in exit paths (2020-06-15T08:07:17)
  Superseding: [v1] spi: spi-fsl-dspi: Fix external abort on interrupt in exit paths (2020-06-14T10:55:54):
    [1/2] spi: spi-fsl-dspi: Fix external abort on interrupt in exit paths
    [2/2] spi: spi-fsl-dspi: Initialize completion before possible interrupt


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
