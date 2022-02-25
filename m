Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B37C433F5
	for <linux-spi@archiver.kernel.org>; Fri, 25 Feb 2022 01:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiBYB47 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 24 Feb 2022 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiBYB46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:56:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460612C0323
        for <linux-spi@vger.kernel.org>; Thu, 24 Feb 2022 17:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05B6DB82822
        for <linux-spi@vger.kernel.org>; Fri, 25 Feb 2022 01:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2F76C340E9;
        Fri, 25 Feb 2022 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754185;
        bh=GwQnKdR2imsIZTpjNFWlNQOpgf1gopeFq6FSAaEiiZA=;
        h=Subject:From:Date:To:From;
        b=cs+xRukv+QNosxiBjYX/yzIxn/WEjp4WxgW5Gw8cf4UJOBw9J4LYAx10aZe8R0L6O
         VyQzGF3H/7R/xsI6IRh0hQWYYHW6wtzr92QjAnqRzZT3Vv6UvnQvTdF4YORvhbwx4u
         xlPhQWYCm6UxA5gGdnxQBfB8LZocO89UK++TDXh3u9mqBK/FG4zqUff1PRQSco6ajM
         hXkUOR9SqIccYBnc0iWVN8GsRQbWOh8rWrTfLePnLlHuv12vHC0yYgOhbNTMiSuQk3
         DABhebM/zv2yfz/R10v8jsXr8Gat+Evl62dfNJ/LbGg5olU6QkzvPA4NAis4D/4FWu
         +5xs3GZ7p+VDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E037E6D453;
        Fri, 25 Feb 2022 01:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164575418564.8791.7055068353313855628.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 25 Feb 2022 01:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add spi-hid, transport for HID over SPI bus (2022-02-25T00:59:30)
  Superseding: [v3] Add spi-hid, transport for HID over SPI bus (2022-01-15T02:31:30):
    [v3,1/5] HID: Add BUS_SPI support when printing out device info in hid_connect()
    [v3,2/5] HID: define HID_SPI_DEVICE macro in hid.h
    [v3,3/5] Documentation: DT bindings for HID over SPI.
    [v3,4/5] Documentation: Correction in HID output_report callback description.
    [v3,5/5] HID: add spi-hid, transport driver for HID over SPI bus


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

