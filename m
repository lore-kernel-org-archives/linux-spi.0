Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83749C433ED
	for <linux-spi@archiver.kernel.org>; Fri,  7 May 2021 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4120D6141B
	for <linux-spi@archiver.kernel.org>; Fri,  7 May 2021 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhEGN5j (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 7 May 2021 09:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234081AbhEGN5i (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 09:57:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0B76B6141B;
        Fri,  7 May 2021 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620395799;
        bh=VhbBaARQ+KKNUGy1KAQHnVZY7xPV1+bgye4ENfDaD8A=;
        h=Subject:From:Date:To:From;
        b=fvaA6TwoPrH7RcQRK/ySDBstFlMQHZTOE1dfHI3I5zcmjXuBTOQTZMlnO63M+fg86
         Iw/2EAxGqS3sCkApFv+RZtRP6Tw4ZXMKamVQ7ypXGAr9Y0k+2xyKZLiHVe1GgeKPZW
         ZJ3hptFecGq41T/pKRmZR/kO6KWLgV6NtZuEvOqj0fgPsJbL9cPYyLBbVQFyxs70bq
         L9mqM+3okE8OlJvOdk6yL1iI1WZjMB/14xNiAknPlnSzYGccGtuh/mC72GOCJBVOdY
         FJtg2QZMoJPkfkOtueXyv/Orc6e+q6GtXsxiDoytx2Jz5YVASBdacPcpDqv54aggNc
         VFJ5pcFAx6gQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162039579889.6317.15460359067847282044.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 07 May 2021 13:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] MTD: spinand: Add spi_mem_poll_status() support (2021-05-07T13:17:54)
  Superseding: [v1] MTD: spinand: Add spi_mem_poll_status() support (2021-04-26T14:39:33):
    [1/3] spi: spi-mem: add automatic poll status functions
    [2/3] mtd: spinand: use the spi-mem poll status APIs
    [3/3] spi: stm32-qspi: add automatic poll status feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

