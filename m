Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AAFC433B4
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2A6117A
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbhERJ6A (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 18 May 2021 05:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240585AbhERJ57 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 05:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 452536024A;
        Tue, 18 May 2021 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331802;
        bh=eLJEElBcbS2aTFOPOncQFpECWeTQG0VxXi2f4E3wjjw=;
        h=Subject:From:Date:To:From;
        b=kTNneb148bP+NPxSaxoNLqiBdUp1eWyMCXQx5yCMkRJyLY+RdwJeXhYPhCFusT1St
         sYXSJOc+iTnA731tqEF9GeXRC3iw7+KO3pa9lajmrmEMkH2/OCAIuTBiOXohMOB0Ga
         JhB3ekKhP6Jl3Uv2g2wWOgqrSTy81Mx4AhPAaHN6BNDe8hDOsvDU91IiDOQya4d8yb
         hF5gc+XQCEQh/o5vGUCeYvIgoD5BO2iTCK5oh+yuo/RppxdYuMAddthI1KvNz0R4SV
         Dz1qYvFINioFJWKh0DBdlljDA2AHOs1DPvILruwNpiRzjpHDAJSljSm7thSD2CHgHL
         96v+WV0BDZEkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162133180214.1149.880819803687752750.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 May 2021 09:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] MTD: spinand: Add spi_mem_poll_status() support (2021-05-18T09:39:49)
  Superseding: [v2] MTD: spinand: Add spi_mem_poll_status() support (2021-05-07T13:17:54):
    [v2,1/3] spi: spi-mem: add automatic poll status functions
    [v2,2/3] mtd: spinand: use the spi-mem poll status APIs
    [v2,3/3] spi: stm32-qspi: add automatic poll status feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

