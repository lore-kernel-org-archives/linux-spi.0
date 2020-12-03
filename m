Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A50C433FE
	for <linux-spi@archiver.kernel.org>; Thu,  3 Dec 2020 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52993207AA
	for <linux-spi@archiver.kernel.org>; Thu,  3 Dec 2020 15:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgLCP5u (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbgLCP5u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Dec 2020 10:57:50 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607011030;
        bh=5BF1NVXy+1r1+ZKXC+JNUX7k8HIo1BjB19tdKg0XA7o=;
        h=Subject:From:Date:To:From;
        b=TAgXGERqiZBxejsTpNzKlAgyu3w1besrhNa89sPXonSnAf6o4pXMGNVbACWOPV/sO
         01wgSnQAQ8ZcpVULLYYx7qhw83bFjfXu6tsueHKPsykAaP/kBE03jneitPb3qdAOvq
         zamJ6GMv6UuxFF5a7+QjVbLoxeveaYRHNQMdyCAuHlOu0MSbErfmsNihgOGnwo36Vc
         80t8Gse7AoRkC5gREi/Ck1tlsj4K+kcHJ4+Zcn4iil1xmI179DoEzillJR7ipm/aFD
         5X+wQMbd448WCcSQWG60sHbn037MNKXIB/b6ohWriL5zGxU8GNhfs+T9XYTyQEd9RY
         myIktHeVccW1g==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160701103005.16329.15397994334196222821.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 03 Dec 2020 15:57:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: uapi: unify SPI modes into a single spi.h header (2020-12-03T14:05:29)
  Superseding: [v3] spi: uapi: unify SPI modes into a single spi.h header (2020-11-27T13:08:32):
    [v3,1/3] spi: uapi: unify SPI modes into a single spi.h header
    [v3,2/3] spi: Add SPI_NO_TX/RX support
    [v3,3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

