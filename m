Return-Path: <SRS0=YCby=7J=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372EBC433DF
	for <linux-spi@archiver.kernel.org>; Wed, 27 May 2020 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1AF2078C
	for <linux-spi@archiver.kernel.org>; Wed, 27 May 2020 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590613217;
	bh=PXpFIjWAEBo3xJ2IC2L7EGvG0VhQFsdjUbGyjEJdVGo=;
	h=Subject:From:Date:To:List-ID:From;
	b=gy03crjCiEUEpN9tader0F83/sKadMgmLHxQQRLfPQQFSZ0g609BUr3vahLiRaQAO
	 4COrRcSELdpy/Rgw4zuLwv2XUlvUn5MaMPR/ovAWiqYv5spbRcClc6aJzkneTCkvjk
	 DtjFy80JVNqaWp+9ttorRcicj1k4jlPKPddTpK6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgE0VAQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 27 May 2020 17:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgE0VAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 17:00:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590613216;
        bh=PXpFIjWAEBo3xJ2IC2L7EGvG0VhQFsdjUbGyjEJdVGo=;
        h=Subject:From:Date:To:From;
        b=RsP07RWaJSMg/Xfzh6wRJoao4IplAwCUDgUoOU/tdkdUuAlKu910qUIJtuOmWfO6f
         Jg/p4Po+f65hnrMETduGubHEoQ3/Nnh6jMgvaTA48zOwTyD+vVEGXKr9sRBKUgsaqe
         r4cbYGydzyondT5EDu00zSZ1Dty1T+uJmQilEo/I=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159061321616.15976.910752900062309253.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 27 May 2020 21:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: dw: add reset control (2020-05-27T20:41:10)
  Superseding: [v1] spi: dw: add reset control (2020-05-26T15:12:17):
    [PATCHv2,1/2] spi: dw: add reset control
    [PATCHv2,2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
