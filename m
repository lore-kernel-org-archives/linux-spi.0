Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D47C4742C
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 14:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6B6222E8
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaHKJbpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgKPOeE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgKPOeE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 09:34:04 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605537244;
        bh=h2/Vm8jE+jtwX4E+ehPNN4+IIYsxEl/XVYFBAipg7co=;
        h=Subject:From:Date:To:From;
        b=kaHKJbpPp1cge9akoEriIq8rsXBn75tUazZ5+StHGbHLf6mFX4L0xAWkgzftEyO70
         NncFo0q6ZA3IHki0F2DfSMop01UI526FyENn849ABl7E6ZEGNYUQJlKQS04waSuywV
         uDglEWNrqq8dpTnKlvf5JNb88N5wz2gMwUyZPZCU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160553724407.26255.17615228439924992091.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 16 Nov 2020 14:34:04 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence-quadspi: Fix error return code in cqspi_probe (2020-11-16T14:18:36)
  Superseding: [v1] spi: cadence-quadspi: Fix error return code in cqspi_probe (2020-11-16T14:10:14):
    spi: cadence-quadspi: Fix error return code in cqspi_probe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

