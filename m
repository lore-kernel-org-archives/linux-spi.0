Return-Path: <SRS0=bXrU=6I=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80767C54FCB
	for <linux-spi@archiver.kernel.org>; Fri, 24 Apr 2020 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0A320736
	for <linux-spi@archiver.kernel.org>; Fri, 24 Apr 2020 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587754817;
	bh=gCdkO4dsfzc67MLfvVbuq7Tg5l0+rbtqM9T4F8feKPs=;
	h=Subject:From:Date:To:List-ID:From;
	b=uCwIj5br87GYVNUMgGLeh0OYcetxtCFttxjf6cK8HdQZl0g+KWWGv7Ec7J1kPJUmJ
	 9sC0LitpYOT/pgOh6+DAF27qGM87sgvIPble98df08KH0q43F7g14AiSmLNyNWvi4J
	 oK3I+J8SCOsXXnBfSqCnAfNlhSGT4KQm1FLPl+Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgDXTAR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXTAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 15:00:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587754816;
        bh=gCdkO4dsfzc67MLfvVbuq7Tg5l0+rbtqM9T4F8feKPs=;
        h=Subject:From:Date:To:From;
        b=hohOgoSQrawySSONnyBCtmS2BJ2PaBilEdl5U6uU60myoEfVGB8ZQ14+UD34maYuy
         77btvDCraO8wMzCjbtnkFf45u3UHs5garlXiJ6YcptvwoHH5Rrv34tgSHTvSBIgeuo
         7aAvuDjGbyQLaaoCqiytNcTZrm7c1pjKcGL4YlnI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158775481655.18320.11315524796504827195.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Apr 2020 19:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] mtd: spi-nor: add xSPI Octal DTR support (2020-04-24T18:43:55)
  Superseding: [v3] mtd: spi-nor: add xSPI Octal DTR support (2020-03-13T15:46:33):
    [v3,01/12] spi: spi-mem: allow specifying whether an op is DTR or not
    [v3,02/12] spi: atmel-quadspi: reject DTR ops
    [v3,03/12] spi: spi-mem: allow specifying a command's extension
    [v3,04/12] mtd: spi-nor: add support for DTR protocol
    [v3,05/12] mtd: spi-nor: default to address width of 3 for configurable widths
    [v3,06/12] mtd: spi-nor: get command opcode extension type from BFPT
    [v3,07/12] mtd: spi-nor: parse xSPI Profile 1.0 table
    [v3,08/12] mtd: spi-nor: use dummy cycle and address width info from SFDP
    [v3,09/12] mtd: spi-nor: enable octal DTR mode when possible
    [v3,10/12] mtd: spi-nor: perform a Soft Reset on shutdown
    [v3,11/12] mtd: spi-nor: Disable Octal DTR mode on suspend.
    [v3,12/12] mtd: spi-nor: add support for Cypress Semper flash


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
