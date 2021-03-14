Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1044BC433DB
	for <linux-spi@archiver.kernel.org>; Sun, 14 Mar 2021 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C4364E33
	for <linux-spi@archiver.kernel.org>; Sun, 14 Mar 2021 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhCNQ4n (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234074AbhCNQ42 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 14 Mar 2021 12:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E4EA964DE1;
        Sun, 14 Mar 2021 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740987;
        bh=cDb09i7K2Q37yw744IM0YDE89NM41sApCHfOBpv12kA=;
        h=Subject:From:Date:To:From;
        b=hM6ZipPM9I7fnRD18dBLM0z23QVnVEiVmho25e85R/M756kLLhE/IFNOOMVVjndZS
         pCCY2V0WMzmRD/po/ut7IWEOVdM2srDgIDVddkLjRfn0rCtneqptOC9NkBzXJevKSq
         SMwWJ3PUlLSBGwW5ZyxDLEf+SBqfvgf7zMmpLy32xbFg1Ry1C9aqJzNruy0U1UhPZz
         a2atZuh+s4fThIFXNm34m5oyY9I/sz7TgU1R//bfZOrlGep7fGou2Kvui/OFkcgQph
         VkWxMcixdVDXN4L3Iu7RLUYM4o88BAyk5i4oSKQbf0mfi2suGtuFZttOmzp83ZePFl
         +XXX0/3pd8xoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161574098786.1477.12978661312248949658.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 14 Mar 2021 16:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Introduce devm_pm_opp_* API (2021-03-14T16:33:54)
  Superseding: [v2] Introduce devm_pm_opp_* API (2021-03-11T19:20:51):
    [v2,01/14] opp: Add devres wrapper for dev_pm_opp_set_clkname
    [v2,02/14] opp: Add devres wrapper for dev_pm_opp_set_regulators
    [v2,03/14] opp: Add devres wrapper for dev_pm_opp_set_supported_hw
    [v2,04/14] opp: Add devres wrapper for dev_pm_opp_of_add_table
    [v2,05/14] opp: Add devres wrapper for dev_pm_opp_register_notifier
    [v2,06/14] serial: qcom_geni_serial: Convert to use resource-managed OPP API
    [v2,07/14] spi: spi-geni-qcom: Convert to use resource-managed OPP API
    [v2,08/14] spi: spi-qcom-qspi: Convert to use resource-managed OPP API
    [v2,09/14] mmc: sdhci-msm: Convert to use resource-managed OPP API
    [v2,10/14] drm/msm: Convert to use resource-managed OPP API
    [v2,11/14] drm/lima: Convert to use resource-managed OPP API
    [v2,12/14] drm/panfrost: Convert to use resource-managed OPP API
    [v2,13/14] media: venus: Convert to use resource-managed OPP API
    [v2,14/14] memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

