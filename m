Return-Path: <SRS0=+Fl2=C7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E1C4363D
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792BB2376F
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600794018;
	bh=fri5PXJJd1fNZhjBnArKug+j8KM0bJFOdCxF8cznoio=;
	h=Subject:From:Date:To:List-ID:From;
	b=ijNNBVgv4z1jm7f5MAgijJDwlZy05oe5U1kdGvFFwvBTmHEu6gFg/rj+gy8zHJY3E
	 kW6eBDo4ETVczS5YmIyQOoW60Qx4Rpwns5UXrWG6h4sDxYpWlMDYJfDllLH6TZlJEn
	 Fig+RiykrlcxQ2a6yXnPmHFb0MCNjxqrgduXLMyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVRAS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Sep 2020 13:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 13:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600794016;
        bh=fri5PXJJd1fNZhjBnArKug+j8KM0bJFOdCxF8cznoio=;
        h=Subject:From:Date:To:From;
        b=ZHfLg+khPnLP22qyOqkav7sc1v3vy9fqreWN0YTwZfDvtKMO+XeLyQ5CQZuIXs570
         tUGtXGsfqdef8llfde+SsCG96z5Uy+vyEKLg/Hle+JbkNyHJj6gAtMJbeq5P25Hcgs
         w3kcix7I0wR28UNS1y0JhY61+WCkZMBmM7gAvNQA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160079401674.29182.15193437103264768742.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 22 Sep 2020 17:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework (2020-09-22T16:40:13)
  Superseding: [v1] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework (2020-09-09T15:27:07):
    [1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
    [2/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
    [3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
