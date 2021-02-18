Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D414C433E0
	for <linux-spi@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF9A64EB4
	for <linux-spi@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBRSv2 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233453AbhBRQ5Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Feb 2021 11:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 17260614A7;
        Thu, 18 Feb 2021 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613667394;
        bh=4tUMsKz0ZAnR2CqoiXSeVjHOeCtzj5DSN9LaGSrqJVs=;
        h=Subject:From:Date:To:From;
        b=ELjBSVwx6gukl2Eiccxrz8XBnVbU5DnZwFfQo3FwEYY9vmypUo/bfQhxe5U6Ch8MX
         Fo9LXksY+OIzer5d07irjPOopiTuQUdl2p7JfwndoTP+RsM9J1omcbEPxi08fpqG1o
         ul7wCc2wDTzMq7FI+Eu/fSndZYvFImeGtphx4td4U2pVu2+T0+QohP1pN0QfMCqP9Z
         Drp75FcKoNocX0N1Is/NJo6xqnri82d5BdVsDlyZe3uvwRK9FsSM2OA5PQFQc8HE1c
         LWlMox1TLjW62Dcr7Lchj1/Y9rOrhuHImYJWNoY4EuHWUWuTDheso/WNKBg2l9Q0fz
         X6sOxJFj7MBDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161366739393.12823.12104038863903641809.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 18 Feb 2021 16:56:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-ti-qspi: Free DMA resources (2021-02-18T13:09:50)
  Superseding: [v1] spi: spi-ti-qspi: Free DMA resources (2021-02-18T13:01:04):
    spi: spi-ti-qspi: Free DMA resources


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

