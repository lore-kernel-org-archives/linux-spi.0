Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB89C433EF
	for <linux-spi@archiver.kernel.org>; Wed, 13 Jul 2022 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiGMN4o (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiGMN4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jul 2022 09:56:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB452CE11
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 06:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F19ABB81FE6
        for <linux-spi@vger.kernel.org>; Wed, 13 Jul 2022 13:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4D5BC34114;
        Wed, 13 Jul 2022 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657720599;
        bh=hepEdhBncACDM93i3Nz3Y6wGZzFrtDBNFLv9f4ccndc=;
        h=Subject:From:Date:To:From;
        b=ScZQ3rpXvtUX3Twt4mmwUzE9LSNCTK9/qpbFchCr80cQJWQVyDDuzTUxosz2zneC3
         TBR+mz81BgY849Gph3t6JLxM4MQ/CUq25A1xEncxvX9vi4QZUKvV7+tapoFEdkATme
         IeJ0fJGbs1M3In863E/WxWBqMzoEP1m4DeM7tnzxbx1qBP5gYu4U5BiS2Q9czm+ryz
         qSI47h3jIyRmj+gPDulpJczk7n9/eR289mOqbd7JHWqrrgG899benWTzdGF4AQGP5W
         GSJGefPaA7UTD6IkRyHY0IQe8/9LdElD7uP41sDU7EXhOsUun3fs0p2my/FhlGlIVL
         vXfRcAWh/w5Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8275BE4521F;
        Wed, 13 Jul 2022 13:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165772059952.11909.1231202650513604231.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 13 Jul 2022 13:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema (2022-07-13T13:29:10)
  Superseding: [v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema (2022-07-12T16:25:55):
    [v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

