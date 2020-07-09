Return-Path: <SRS0=rD+8=AU=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD18C433DF
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jul 2020 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBD320663
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jul 2020 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594306820;
	bh=w6vF5o45btek5BabCxCPGw68qHvD2b/lXsAHVNYchYA=;
	h=Subject:From:Date:To:List-ID:From;
	b=RGs8bwAfEruG0sEiZS36OI2QTK7iVLZMhiEZkLY+MXUd48+rSyD4TgKlqx4PHeKLD
	 O18u9+9IslMGheAoxWBaAitMpeVPcM3qbTLZmbVfY/Da6TtlyrxhXkXUX5nDFbmStT
	 xg90eZ9BiB94g7j2Uj5+YdBY0Pof7sgU5MiCrcqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGIPAU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgGIPAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 11:00:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594306820;
        bh=w6vF5o45btek5BabCxCPGw68qHvD2b/lXsAHVNYchYA=;
        h=Subject:From:Date:To:From;
        b=O86g//YMNOhKk/nRfl08OtVPn8eDGLMwoY/WIQhynaNil59AwVtRTPdIA6zhUiEYV
         fgkOaHEVl4iegG3kODUkFG48vR8eSOkSIAp7ZijbmTUadF2AUfOzyYniWniHR612yz
         l3cnAAs8y2bVQ9oG9v785gFNRugsjutJoUQNPY0A=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159430682026.15207.6097074180965313553.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Jul 2020 15:00:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-qcom-qspi: Avoid some per-transfer overhead (2020-07-09T14:51:44)
  Superseding: [v1] spi: spi-qcom-qspi: Avoid some per-transfer overhead (2020-07-07T20:16:39):
    [1/2] spi: spi-qcom-qspi: Avoid clock setting if not needed
    [2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

Latest series: [v2] spi: spi-geni-qcom: Set the clock properly at runtime resume (2020-07-09T14:40:49)
  Superseding: [v1] spi: spi-geni-qcom: Set the clock properly at runtime resume (2020-07-08T23:39:39):
    spi: spi-geni-qcom: Set the clock properly at runtime resume


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
