Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93657C77B7F
	for <linux-spi@archiver.kernel.org>; Thu, 11 May 2023 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjEKH4s (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 11 May 2023 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEKH4q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 May 2023 03:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD31926A5
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 00:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6086B61278
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 07:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86548C433EF;
        Thu, 11 May 2023 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683791803;
        bh=wfwUM1xlEZDRIXddZwjYnbshKnLwO8oeCniNwqJXSyE=;
        h=Subject:From:Date:To:From;
        b=qDqDtsbMqLzfzwUY395kxd6At6JhCqswG9fbyB8v1F5TrhjGDvSS5Fro8CMU/H9SI
         pDEy3nTj23xt1jBiD8Ciom/QsSTQZXbq9ifGZyT7A/yZK+2g8rHieTegdrCMXuQ79F
         g044iDNGg2HcDZRHuqKwSo9slNIgyIETNEAWrw8bjsFUysOEvWrPP5V2KDK3egXxJE
         QozW4Vhd7XyJTxGHYkb5G+dx+DKDf7CzKs8KHcletUjFW1MKIlsF2WYHCSP+gF8ght
         9JQ/7n7PzPyPHfScdr0kQqAfKVfRVnKMXcdTsvgt8lZqL8xh2g4tKkdq4Pt5GgjhU7
         ifox5wifOxnhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67A15E26D4C;
        Thu, 11 May 2023 07:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168379180342.16897.7660051237482933416.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 11 May 2023 07:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] spi: Add support for stacked/parallel memories (2023-05-11T07:31:27)
  Superseding: [v7] spi: Add support for stacked/parallel memories (2023-04-06T06:53:29):
    [V7,1/7] spi: Add stacked and parallel memories support in SPI core
    [V7,2/7] mtd: spi-nor: Convert macros with inline functions
    [V7,3/7] mtd: spi-nor: Add APIs to set/get nor->params
    [V7,4/7] mtd: spi-nor: Add stacked memories support in spi-nor
    [V7,5/7] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [V7,6/7] mtd: spi-nor: Add parallel memories support in spi-nor
    [V7,7/7] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

