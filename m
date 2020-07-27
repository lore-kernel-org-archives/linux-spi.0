Return-Path: <SRS0=+j3L=BG=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2836C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jul 2020 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F0320714
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jul 2020 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595871620;
	bh=oDqmWZV9Ha4Yhux/RDXfhx6t/+zVWLMsmr3RPjplxIk=;
	h=Subject:From:Date:To:List-ID:From;
	b=ugKnMGPRmwrbI1PbJb+bjJ2wqMAQheSnKZFwwAwjQd/Majp+MrVHnvoc2kQyEq+BJ
	 hzhIOBTRd3E543smG1GMwAF+dumzG3P+BGpstBwe0ZyBGDk8ty7cQO93LzIBgV2dBM
	 4W5Dy2/TovrFqsxkVFbq2NAT9KYXgIcclw3hVSws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgG0RkU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgG0RkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 13:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595871620;
        bh=oDqmWZV9Ha4Yhux/RDXfhx6t/+zVWLMsmr3RPjplxIk=;
        h=Subject:From:Date:To:From;
        b=TlfM28TklCEbrQFKnwwtCx3REFirkLfoTcp9vp8Dyzgx28rOvjtkQG1UW/Qg85hLU
         gl0prKYAQry02+i1fLN63UWiDeDpbHRk0goaA7J5vHge3n4qBU47GHOEGFZH5Ix5Av
         KvMXrUKP6cJwGtpupr6PXGv6QM0K/pYL1vMXmDRs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159587161998.16585.12791863222830457785.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jul 2020 17:40:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-topcliff-pch: drop call to wakeup-disable (2020-07-27T17:29:37)
  Superseding: [v2] spi: spi-topcliff-pch: drop call to wakeup-disable (2020-07-27T13:17:43):
    [v2] spi: spi-topcliff-pch: drop call to wakeup-disable


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
