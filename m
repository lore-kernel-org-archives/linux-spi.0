Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07591C433DB
	for <linux-spi@archiver.kernel.org>; Mon,  4 Jan 2021 01:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C353720771
	for <linux-spi@archiver.kernel.org>; Mon,  4 Jan 2021 01:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbhADB5U (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 3 Jan 2021 20:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbhADB5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 3 Jan 2021 20:57:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 96D0120771;
        Mon,  4 Jan 2021 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609725399;
        bh=NdWn5Hh/jllnWcGWiT3/gx5LVzhMfSwuKe9FJf9Qwfc=;
        h=Subject:From:Date:To:From;
        b=s0L6/SqFz3iYrFeZjX4IKd+TjFK5CameJ6FxBYUYzed4yrevczv75NAHx2hMY3wxL
         uuY0ncUarzI/A/ysdEWsbEYno0LSsfUbNZOlVQZVySMYHRH5mD1NlH1iMB/W+n677Y
         cT32MaEVE+9I05RRh6wthNO3jzIvMNhgbeheWQi4ZKgF/W8adH+mE3uSOwk2akRthB
         TJ3VLqzaauy6vGbBWzwEDBQQ5lZSplmekcmIX/sVTFqqOdPlK3SCHdWMizQ3SvzAdA
         GVXtsaEwjFFvPIIymcfUQfp/jqNvIAGA+yjVCS8I4EBJiGQl7jav5S7M5NiZxiiug/
         014s284On4AwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160972539945.5770.6342375627861976552.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Jan 2021 01:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: fix the divide by 0 error when calculating xfer waiting time (2021-01-04T01:29:09)
  Superseding: [v2] spi: fix the divide by 0 error when calculating xfer waiting time (2021-01-02T02:59:46):
    [v2] spi: fix the divide by 0 error when calculating xfer waiting time


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

