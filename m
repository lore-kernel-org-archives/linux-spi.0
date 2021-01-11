Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E2BC433DB
	for <linux-spi@archiver.kernel.org>; Mon, 11 Jan 2021 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726442250F
	for <linux-spi@archiver.kernel.org>; Mon, 11 Jan 2021 16:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbhAKQ5X (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbhAKQ5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 11:57:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C762A2242A;
        Mon, 11 Jan 2021 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610384202;
        bh=iAMofg0vSyL4UVDFO4ukRUmmd/CNpDli2THXZAJVLjU=;
        h=Subject:From:Date:To:From;
        b=NiKSGpVzAwkR2aBI5coUjgUmwaFtXnWhGxsfMlWxXPm5Ab9iRebVP4Xnnea4shcHz
         UQ2/bx+9kqf4TutdoROTvc+lqa2bvr6Xpvx8LwJKWbgtLBBxXDo8tTQXAFAP18l458
         QLTrvkaijXUOItiylIeir6fqnv1F2M8q/Xg4ZZ+MgoogYZZB0CtP633i8jA+rwB7CF
         1T/Z9o2OLeQd+2FaELE2GnT5b89GE4G3FWPSVFgpgGFPusfX6PAuXsjSAHAMmu5U6X
         eXr2rGR7HmLp0s3BkptP1g1F7ukSeXc2lNn/IrQMb6jxcTdWLM947uWvmR0YssCBTA
         AnhhS/0AlBP3A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161038420275.3886.16606405380311685175.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 Jan 2021 16:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:54:48)
  Superseding: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:26:29):
    spi: spi-bcm-qspi: style: Simplify bool comparison


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

