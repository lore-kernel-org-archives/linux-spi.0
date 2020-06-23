Return-Path: <SRS0=6LXN=AE=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F7C433E0
	for <linux-spi@archiver.kernel.org>; Tue, 23 Jun 2020 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E2820768
	for <linux-spi@archiver.kernel.org>; Tue, 23 Jun 2020 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592910009;
	bh=gWXEp9lmL2MYEbbcra5C7UFVCy70ePksHRFcy3u19hw=;
	h=Subject:From:Date:To:List-ID:From;
	b=xoyPCoQJXUl4yUFB5NjktHaXL6Vjs7XbF1gHwJqpIpf50w8cjC1OUpF9XxkPec00I
	 NR6lFGSgoTfn+XHZLts18kLl5xbCadCgJ9sn78s1WQrery0QX5vJXwUjaQLx1G6gjg
	 lKjajTrx3mNDC+htJHgGgsBo/2inaA6OYPgDBIUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgFWLAJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgFWLAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910008;
        bh=gWXEp9lmL2MYEbbcra5C7UFVCy70ePksHRFcy3u19hw=;
        h=Subject:From:Date:To:From;
        b=GuVr7VV2E/zPpsZmXo4pPmmVsK2gcU7bPJAURSBTN33H7MESamCcmD83YKPp2XuCm
         5gnKAoCxJa5iaOh64uI4wN7hN0ZFmvpu4bZlFyEVD77ivuVQakgcCfP0wXU7TOSzyH
         yGJQVrEjTsLuShme3GAzQ1MPbX0hO4PWH12reFIU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159291000862.29556.11678514589815795425.git-patchwork-summary@kernel.org>
Date:   Tue, 23 Jun 2020 11:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Some small spi geni cleanups
  Submitter: Stephen Boyd <swboyd@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=305923
  Link: <20200620022233.64716-1-swboyd@chromium.org>
    Patches: [v1,1/2] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
             [v1,2/2] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
