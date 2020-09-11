Return-Path: <SRS0=Slv/=CU=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF44C433E2
	for <linux-spi@archiver.kernel.org>; Fri, 11 Sep 2020 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737B12075A
	for <linux-spi@archiver.kernel.org>; Fri, 11 Sep 2020 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599813618;
	bh=oaCZc4njmLTXFpFHe+1oVsoxKo9lzxtBgyX/XdFn9Ao=;
	h=Subject:From:Date:To:List-ID:From;
	b=b1dKBdJTvTzZ4NTV7sJMZ4mLqhmbAY3UEwKbv+xKbBMiG9j0Pl9rbMgCfqO57QQn2
	 d1iil49lMsf3BnZ10CEwFUlAFwz3P07fkgdOodSHXTTxTI8jFNd7yjMEdOdpuMUsov
	 g01njkgpkDxNwZ/N/H0kEWIjkHWA9YBXD8yJqC40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKIkS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKIkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 04:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599813616;
        bh=oaCZc4njmLTXFpFHe+1oVsoxKo9lzxtBgyX/XdFn9Ao=;
        h=Subject:From:Date:To:From;
        b=D48SB39JmlMfNfs8MR6hSahKNpFdkYzeO42AZjCEg84X8zgUrD0OUhzvJTLZ3ZMcc
         omKJ5oGbThusmbhEZReOHK0wtuYHwECQoHyEPSmU1aLkdisvFqYWJ6dFk7tEhIN7ig
         blAugl8R64QguSQbQh/T5ZG5o46xcTw5boh4t9Iw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159981361688.27782.5740331790212121359.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Sep 2020 08:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T08:28:06)
  Superseding: [v1] spi: spi-nxp-fspi: Add ACPI support (2020-09-08T06:02:27):
    [v1] spi: spi-nxp-fspi: Add ACPI support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
