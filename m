Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25DC4332F
	for <linux-spi@archiver.kernel.org>; Tue, 15 Nov 2022 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKOQ4a (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKOQ43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 11:56:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1601AF11
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 08:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA01261935
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CE19C433D7;
        Tue, 15 Nov 2022 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668531387;
        bh=hSct8EheylysMyUngEaSdKitxm4WiWM+tX5+1JiGxEM=;
        h=Subject:From:Date:To:From;
        b=Di7Nmr+6zDEKngBuKLkMHbz78R7SLAeY0N3nVzR1tW4OnaT8/t+tpBDEXOwmkZEVP
         bKj587tOFaRrPpEA2Ij034/1j+KrwFuVC1wmt3gQfDJNShqaEdTuOWRVDQ1XX+DboH
         6Y1fSRiMxEJp03iNK/XIU9KkWzbHYFL+V4tHTwyn6OA+/fXRtQRJcw3kCahMBE8qY7
         ZDW22YAVgRgI9o5m8gxeFIweWSWJzrS/paIRW0sDphSGk1+Jdk5Y80wnpDiezjewPw
         5agj39dH9s8eUbEMjn1W6nfK6mFQU82Rh+/lwRvkCAT9DawpqF48Oz7CqIYJDSAe+S
         +YyMoPIPct/Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30DF8C395F5;
        Tue, 15 Nov 2022 16:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166853138719.24202.5735955149485196954.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 15 Nov 2022 16:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock (2022-11-15T16:26:53)
  Superseding: [v1] spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock (2022-11-15T16:13:30):
    spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

