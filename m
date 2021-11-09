Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB8C433F5
	for <linux-spi@archiver.kernel.org>; Tue,  9 Nov 2021 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C2061038
	for <linux-spi@archiver.kernel.org>; Tue,  9 Nov 2021 09:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbhKIJ7u (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243350AbhKIJ7t (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Nov 2021 04:59:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 47C0E61038;
        Tue,  9 Nov 2021 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636451824;
        bh=ftlJuslO2nIC8OGS6y3GkS6a7eXTXft3sTtm2ABu2vM=;
        h=Subject:From:Date:To:From;
        b=h0DDIRCUTUAGdLNvHKY9bLaONe4bArddzDB554CRjxqa4xlvLo7xvl00ZsDSOvFwV
         cEgtoNcxUTMGj50zuvmCGBH0JPye+4ryksZKV/6XtM09p/264ji5nXUwN0C6B4tx31
         VxUqLqM4H+k7ErD8E4ykvjxZjlXJNfhzzWH7sxX7nSSGA5F2C+dcgOLe4Erqg4uDu+
         f/6pwCkLtfbHGBmU9YfaiVORgLRIpJ5ZcV1vtAwAtnnnaZSllfwhmIi05i8VtDstST
         INAoA/yCKEMhC0SQ2ZutJSUqPAUjnOwahXCngjKrp9ktQfh0fxhDcQrtMRMVN685aK
         mnVl5HVyEuBhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163645182425.27777.7398646948372442595.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 09 Nov 2021 09:57:04 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add SPI control driver for Sunplus SP7021 SoC (2021-11-09T09:01:26)
  Superseding: [v1] Add SPI control driver for Sunplus SP7021 SoC (2021-11-01T06:18:43):
    [1/2] SPI: Add SPI driver for Sunplus SP7021
    [2/2] devicetree bindings SPI Add bindings doc for Sunplus SP7021


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

