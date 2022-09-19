Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC8ECAAD3
	for <linux-spi@archiver.kernel.org>; Mon, 19 Sep 2022 15:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiISP4v (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiISP4u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Sep 2022 11:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A671115E
        for <linux-spi@vger.kernel.org>; Mon, 19 Sep 2022 08:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D0661839
        for <linux-spi@vger.kernel.org>; Mon, 19 Sep 2022 15:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0DEDC433C1;
        Mon, 19 Sep 2022 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603008;
        bh=Rn4V4a7CWuuK9UyqIMNgR4mgNnD16QsvALPZc23epD4=;
        h=Subject:From:Date:To:From;
        b=KdbNkJefNTVFJhBGpCNBpSK0Wj1zo0sCmJK9pr7P1zAnSSU2MdXpVO+3GOFW0HvUq
         Dhr/o83lQWcHx03Sz/m8KAlsgaratfQ9XpjXrkZA2fzI/bNKGmVJ8QMwNe1z5o3nlY
         25Nh0hKcB2vJUx5Eq5Fb5zmboOIBqycGpTfYsbL859cpmyEoSB5wOSIDXzTq76vCrt
         PqZt902cIcLjkJdz0f/N7u+B0VatZdo6Ru2cutQC+0phTQnorAYHHv/2gRV9k5CQGi
         TRl1O5/hP1xAxgp+IRzP+CZIsodq1vxFlTU9Yvz+j2+I8IO/HYVR0LAi2I5m1V62Cb
         Tn06ymoS9j4OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2F6DE21ED0;
        Mon, 19 Sep 2022 15:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166360300866.6966.18283916500953113829.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Sep 2022 15:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Make atmel serial driver aware of GCLK (2022-09-19T15:08:38)
  Superseding: [v3] Make atmel serial driver aware of GCLK (2022-09-13T14:22:04):
    [v3,01/14] ARM: dts: at91: sama7g5: Swap rx and tx for spi11
    [v3,02/14] ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
    [v3,03/14] ARM: dts: at91: Add `atmel,usart-mode` required property to serial nodes
    [v3,04/14] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
    [v3,05/14] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
    [v3,06/14] dt-bindings: serial: atmel,at91-usart: convert to json-schema
    [v3,07/14] dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9X60
    [v3,08/14] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
    [v3,09/14] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
    [v3,10/14] tty: serial: atmel: Define GCLK as USART baudrate source clock
    [v3,11/14] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
    [v3,12/14] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
    [v3,13/14] clk: at91: sama5d2: Add Generic Clocks for UART/USART
    [v3,14/14] tty: serial: atmel: Make the driver aware of the existence of GCLK


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

