Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C1C432BE
	for <linux-spi@archiver.kernel.org>; Tue, 24 Aug 2021 09:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA686120A
	for <linux-spi@archiver.kernel.org>; Tue, 24 Aug 2021 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhHXJ5n (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235566AbhHXJ5n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 05:57:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1FAEF6120A;
        Tue, 24 Aug 2021 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629799019;
        bh=2+NKDC48iRbzFQJWgFBnU3ROLrTLkM8OfeKJTZwaph0=;
        h=Subject:From:Date:To:From;
        b=n1mOP86OeMGy0Qb/SD6FnDm7re/+khV1xrY+sfnmIozj7agXy48pfavMRe3fDlhJ1
         /YrMsCAnoJLgYTHggTAX2PwEr3Hre+fdk11l+x8XcDQGQi8OnB/xjabTITiacRRDYC
         C3PwQ83avDhnyg9CUThSTMR8ceNl21tgkMVnHldiAYbgSaOt5Sy7Cwi9oEtlN3D8Sp
         5Pkg1UxVgoYeNKYOdnE7zDXHs57OS6YxU889JRz5BNive7ejNeE0HscR4K5liQr7HS
         xhAi0CP50VeQA6I40Xn2E5IpS1woBcAmNFOS3UjuJ4XbsEhjyTivqFMsU2iqQtC+TJ
         K8R5fZxOQjx8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162979901908.18280.3867769643232813808.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 Aug 2021 09:56:59 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add support for Intel Thunder Bay SPI (2021-08-24T08:58:54)
  Superseding: [v1] Add support for Intel Thunder Bay SPI (2021-07-22T05:33:56):
    [“PATCH”,1/2] dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
    [“PATCH”,2/2] spi: dw: Add support for Intel Thunder Bay SPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

