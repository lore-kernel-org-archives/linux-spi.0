Return-Path: <SRS0=iNVW=7L=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C0C433E0
	for <linux-spi@archiver.kernel.org>; Fri, 29 May 2020 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFAE20707
	for <linux-spi@archiver.kernel.org>; Fri, 29 May 2020 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590768017;
	bh=s9uKIIumSueiqxLc0PQroWGJM+3A9CLyESbZG6nIASI=;
	h=Subject:From:Date:To:List-ID:From;
	b=N932yQ52rlC4mOC2ZRq+X1LsfccxyLaV7LD4iVj5TpULvHVapj77F8fqQFYcezH0h
	 VSDeD2zDZH4+kCBWY94WlysJy/mHhvt4iVGx4Zi/CmksZI+T+OJcnVuQj6axTHKI9C
	 2gFvRk16cjOIK7xP3ADGLdJk/aSvKyg3wNEuJONk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2QAR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 29 May 2020 12:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgE2QAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 12:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590768016;
        bh=s9uKIIumSueiqxLc0PQroWGJM+3A9CLyESbZG6nIASI=;
        h=Subject:From:Date:To:From;
        b=X2xyUgiWIPCJO4r0YbPH2medyYiU8zPa6jo7kVuHL44H87eJmdPAsT6syog927JnP
         tggvccNgd8f7ukKLBh23IKGXVb609wH6yv2ddRcFPk4APKsHq1MpXk8epdagQPJAYK
         ifrnNJiBDUPd9R3roTFJDz41tUNizLkJXgZdRUGo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159076801674.27920.1572940018995737767.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 29 May 2020 16:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: dw: add reset control (2020-05-29T15:58:06)
  Superseding: [v1] spi: dw: add reset control (2020-05-27T20:41:10):
    [PATCHv3,1/2] spi: dw: add reset control
    [PATCHv3,2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
