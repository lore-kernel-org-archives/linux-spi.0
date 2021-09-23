Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389CFC433F5
	for <linux-spi@archiver.kernel.org>; Thu, 23 Sep 2021 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFF7610D1
	for <linux-spi@archiver.kernel.org>; Thu, 23 Sep 2021 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhIWR6i (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241740AbhIWR6h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Sep 2021 13:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F3EC86109E;
        Thu, 23 Sep 2021 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632419826;
        bh=83MovbMuM/GvA4jMeHUyoYYnB8HpJIDQIAHaUoLNqMo=;
        h=Subject:From:Date:To:From;
        b=SChWJ97H3cuRbIZn3jO1DyMk3KNF2wRRL1RFgKWuy70SfQeecZoyu5bCf7aarvfVf
         pGiKAy7O+P70HfwZCBRQI3S6ziX3r580xxL8lUdZ7OzbU6ogF2yI6ng7BQbe5FBkCI
         u6UVLaHhB+T/6l2QKZsKHvCtz2hT5REjDPP8H0db3AZqQ0pDtXIQgRzQAdiTnX+fTB
         j8XiYfE+f9vFZXb26O28p/auL3TE8iKXPJoyLJgtxRwvXWv7F9OTQjiA0WiRQABsyS
         b8S1Ywnb4gX3k++jeaBkoFAircF6vKD0q7JQPKrnexDuNuhQWtD6MpeeOtb8SL6r05
         DxMbMsWyj5Cag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163241982590.30547.6757408529659454930.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Sep 2021 17:57:05 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spidev: Add SPI ID table (2021-09-23T17:20:41)
  Superseding: [v1] spi: spidev: Add SPI ID table (2021-09-23T17:00:23):
    spi: spidev: Add SPI ID table


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

