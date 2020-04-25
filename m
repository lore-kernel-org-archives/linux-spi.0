Return-Path: <SRS0=/iLV=6J=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D5C54FCB
	for <linux-spi@archiver.kernel.org>; Sat, 25 Apr 2020 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA503206D4
	for <linux-spi@archiver.kernel.org>; Sat, 25 Apr 2020 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587846013;
	bh=PYiAFz/cIN39LG92/2dzxbi02lkErAo+8+RcTb48ag0=;
	h=Subject:From:Date:To:List-ID:From;
	b=VmYd8O7qQosf9Mq7Db7xIr6B9Q0Hl2EI5sDDrnPjSK4Dyl5p9eRKEXvxUtQ79R0CV
	 Pnn2b2sYd1Gw8gi/vAq44mj4YKzRmsxITI1krhjbZCHt84/pGPzJxmsMPzdfu9eVuW
	 BOTzhPq1FrskcVM2qhad7LueqRoVxih1jlbqYyaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYUUN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgDYUUN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 25 Apr 2020 16:20:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587846012;
        bh=PYiAFz/cIN39LG92/2dzxbi02lkErAo+8+RcTb48ag0=;
        h=Subject:From:Date:To:From;
        b=VpZr0xIl1q94MeOVYkhpxtXbi1Gi1StpUu/TiI0E6OnWrWlIhcArT2pJFdsKU5XhJ
         Lx+keXZiWPLMZJ1ayFDw2Hx6kLeXkX7Q6rd//SpsfmPpAM3+hn+Mrt/L5ioE+aFwY9
         OOvQzUuNeoFto0QfrfU4bSxzs2TLfsTqgZn0bC1o=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158784601293.28471.11158290843390102090.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 25 Apr 2020 20:20:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-amd: Add AMD SPI controller driver support (2020-04-25T19:59:48)
  Superseding: [v1] spi: spi-amd: Add AMD SPI controller driver support (2020-04-12T19:28:31):
    spi: spi-amd: Add AMD SPI controller driver support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
