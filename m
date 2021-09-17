Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E9C433EF
	for <linux-spi@archiver.kernel.org>; Fri, 17 Sep 2021 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D8960F4A
	for <linux-spi@archiver.kernel.org>; Fri, 17 Sep 2021 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhIQO6N (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 17 Sep 2021 10:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhIQO6M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Sep 2021 10:58:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7FAA860EE3;
        Fri, 17 Sep 2021 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631890610;
        bh=ekNFJb4UaeQ7/oS35vJq10kxCG3RspZZciWvL/7/L3k=;
        h=Subject:From:Date:To:From;
        b=HlxSiULukwId+e6nZr1VeKwWJNvtNL8xhhGxBv6fL1F467sBZk1MdkWH4LEedDTxi
         cFW4Eh5AUmjthiklh3Z1tmegzde0V87g3k7Yu3G0KK55Or6q6FRuXK8t5Lc0skwlOU
         kCPj1ZsAR/17e2rFtvPN9xSEtgZ5xonKLaIhKcbbYVGE/Fk9CQ+kZ92JKSkKCPArnB
         oc7CXnKqm8aEfswgEqYnJkPNqp5leQXmBUomjEUZP7+V4N/4v0VRteuziiixHMmIvk
         uSReWXOnFoL0+WUjt3ktGv0nDOskWOmw9WA+dJZUgt6f/kpWx4cTYsT5CH//P7YGDp
         C/HLINM+ZBlpA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163189061047.16577.11723477598651867221.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Sep 2021 14:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] add support for Cadence's XSPI controller (2021-09-17T14:29:07)
  Superseding: [v4] add support for Cadence's XSPI controller (2021-09-13T12:02:38):
    [v4,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v4,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

