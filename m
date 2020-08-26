Return-Path: <SRS0=ASUY=CE=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58182C433E1
	for <linux-spi@archiver.kernel.org>; Wed, 26 Aug 2020 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2A42071E
	for <linux-spi@archiver.kernel.org>; Wed, 26 Aug 2020 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598432414;
	bh=9wH+PrekI/4HiZg7PIDsUoUmgv7hhxxGkPxKsIQRibs=;
	h=Subject:From:Date:To:List-ID:From;
	b=TPAG6MvDs/TD9juznWTwxf+EOBTHyO74I7BMvddTVjRZ34v3CGvkHu9+dxW7hO3eI
	 cyEXPX4/GoWSHGuuhyvoSygD+MEGnKB6+bavgIUr1SzTNN7CGTgdOJG9sM3/pEKOdg
	 neVNCkLWumTX/TzNmo36Uqo0d9Wob2aME6J7zDQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHZJAN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgHZJAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 05:00:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598432413;
        bh=9wH+PrekI/4HiZg7PIDsUoUmgv7hhxxGkPxKsIQRibs=;
        h=Subject:From:Date:To:From;
        b=yNmOaRVBvqxsAYzU6B4krGqRmkccz3xS8wTq8JKGbfTIHghPfk/QLQxVusZsF/R1Z
         iNZBsKY5Q9/zBD+5eJj1VMb9u39Rmc9kNVaLDKTzXunRluk5wCh4F32mSL/bLDenAn
         D+shw3UyJ7+VHkUQ48yfyNZa4aac9fD0EojFAnMk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159843241341.7004.12492687555072180687.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 26 Aug 2020 09:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: Convert spi-mtk-nor to json-schema (2020-08-26T08:54:50)
  Superseding: [v1] dt-bindings: spi: Convert spi-mtk-nor to json-schema (2020-08-20T05:28:27):
    dt-bindings: spi: Convert spi-mtk-nor to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
