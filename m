Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0431C4338F
	for <linux-spi@archiver.kernel.org>; Tue,  3 Aug 2021 10:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A15160FC2
	for <linux-spi@archiver.kernel.org>; Tue,  3 Aug 2021 10:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhHCK5B (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhHCK5B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 06:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BADA861029;
        Tue,  3 Aug 2021 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627988210;
        bh=1AmrHVzrvJkzqw+V2IoaTym4cbGV1ukXZStbCmVv4Ok=;
        h=Subject:From:Date:To:From;
        b=pDGMwpHQ89YcIyZYTvjMsR3NZK17EmiJNvdYYb6/e9LFj4gqflDRbs5OipwLjBz5y
         Gsxt81CDrM1QlSk3T/wS/nU9kUNMeV/IgP88yYstp0mMN2n1dbyPtVkBHjJO3iUx7U
         eTlOrkow0bGK4ExJ3mBiU2xEf8qAGqO8XnpJFzSJKa3R8cn0hmQOhXNY1BdLRdjYxz
         4l6dU9Kdx+tBm7IyoIESmVuM64jbP2YsapeWHq/B9Grq3pJDjRdYejtA7thmp4+AHl
         XXlOtquaeNced3fUr+MUChxyA90k7dSuJrqDZ6Eb3vSbVfmJEiUvX+yA/4HWCTN7+B
         SPeAxiDA5WU2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162798821073.6133.6866260520229343519.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 03 Aug 2021 10:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] *** spi cs_timing restructure *** (2021-08-03T10:22:29)
  Superseding: [v1] *** spi cs_timing restructure *** (2021-07-19T09:15:26):
    [1/3] spi: move cs spi_delay to spi_device
    [2/3] spi: modify set_cs_timing parameter
    [3/3] spi: mediatek: modify set_cs_timing callback


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

