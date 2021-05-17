Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F04C433B4
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 06:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68225610C9
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 06:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhEQG60 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 May 2021 02:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhEQG6V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 02:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 57A7361076;
        Mon, 17 May 2021 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621234600;
        bh=bid48FrunWPPTrK1ZjKmIt/nVvx4MKjvhSsJM3PEsFs=;
        h=Subject:From:Date:To:From;
        b=AO/3/o2HESPIneZolPQEoGG51k95tkEAvpnEc/uEZZR+CSVT0QjJB0DWBpQ7w6jEL
         MBId+2ruCNVZY3+ACTVb6Jjrr6GFsjANOLTrFU5z/rRvPrjk1ORh1YQkc5iwnNvCoq
         6Z0a3nXlr/gRTKuCfg1kkJbW3zQtTxerQszkUTblT1Z6kAvaBWSADRciIt1Jp6RPum
         GWd7UygpoGM0ZLx1UD7qCEWYCu20NdK7w4xKDWIy8HE8APp6HR2Hv8xxhWm4/PtIDj
         v8PUdNamJ6WPhzH2E6pESZIdZil6I+AlGEyGcNIXCjfat2fzUDJQckWfm451kypHt6
         265iJlhobZRKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162123460030.16396.2889664151086485786.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 17 May 2021 06:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add octal DTR support for Macronix flash (2021-05-17T06:14:46)
  Superseding: [v4] Add octal DTR support for Macronix flash (2021-05-10T08:20:34):
    [v4,1/2] mtd: spi-nor: macronix: add support for Macronix octaflash
    [v4,2/2] spi: mxic: patch for octal DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

