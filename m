Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8FAC433B4
	for <linux-spi@archiver.kernel.org>; Thu, 20 May 2021 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF336135B
	for <linux-spi@archiver.kernel.org>; Thu, 20 May 2021 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhETV6G (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 20 May 2021 17:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhETV6G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 May 2021 17:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9215F61246;
        Thu, 20 May 2021 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621547804;
        bh=jOOO8H2/NxOnWiOwwC205QHlZho0dyOUJHfwkpcLfNE=;
        h=Subject:From:Date:To:From;
        b=exwAvfOGOA7RZwXuDGREN3zHAQhaEXy2nfhl685oaYESHmgfDwBIkme8VhDJX9RpQ
         fEXMOg0vi2ePajHLscTuf+5xrWMeE7DLGnbZqCVjGv113+j7kW7VmoG49MuSYOJ0EI
         lZzem1Ft+mPRER2CVHx3lqPJM4wgkvltK7MhcCa3e0nhpKgrj4uebh4UBU8oQniVAU
         OE5UOefy2i0BdBy3vScJFBIwiZux+6cvgv6TmFgmR0o3XtdVUKE57v3lEscVrZMtR9
         MTCdMboXpl7VHJKhKqF2RNnSAv3xBGoeNtqRxPHJADRWQ2XgGgLGwgbO9se5ni0DAJ
         9EeeJRaAkDfdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162154780454.2612.13022225890093400797.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 20 May 2021 21:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Adapt the sja1105 DSA driver to the SPI controller's transfer limits (2021-05-20T21:16:55)
  Superseding: [v2] Adapt the sja1105 DSA driver to the SPI controller's transfer limits (2021-05-20T20:02:21):
    [v2,net-next,1/2] net: dsa: sja1105: send multiple spi_messages instead of using cs_change
    [v2,net-next,2/2] net: dsa: sja1105: adapt to a SPI controller with a limited max transfer size


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

