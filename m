Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1498DC433B4
	for <linux-spi@archiver.kernel.org>; Fri, 16 Apr 2021 19:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36DE611C2
	for <linux-spi@archiver.kernel.org>; Fri, 16 Apr 2021 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbhDPT5J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243879AbhDPT5I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 15:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5CD34611AE;
        Fri, 16 Apr 2021 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618603003;
        bh=6bSQugMkvARej4JDqMfqRjMmWmnKiRv4ExXlTGj5OzI=;
        h=Subject:From:Date:To:From;
        b=pDV2EDLgjk68EYXMx5z6LZzwawO7QwJ8lonGXfqNlwXPm8ai6K1CJsLxuaOyq+k3I
         seHlUicCv2+bVKDSW8jYtLU2tNG2jA9PKyDcZBG0ozfaVK5/e9L+fvUpzjTs1uzfs3
         ovKCPrq2FdvIhvWb3/Qz3h+o8hMIXyFmeAErHkrkqxiuqluei64Klk4cjF4z1bcNHQ
         uhR3Jz0UNnd9xopLPPHGQI1I9bZyMPtbXFFzQ+TNC3ebo4a7LsA6WQNPJ8FDFG9VBs
         HBHUVn7uXl359GHEPnMBS9HU57aHB+bQz/EykK7LgYhWQ3A4DhaxK/99PKNGw4ZK3X
         2RQZ3JqJnJIFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161860300334.19632.8581730501513395323.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Apr 2021 19:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema (2021-04-16T19:47:23)
  Superseding: [v2] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema (2021-04-16T06:23:20):
    [V2] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

