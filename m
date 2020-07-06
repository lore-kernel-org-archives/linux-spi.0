Return-Path: <SRS0=fYXv=AR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB0C433E0
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 09:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA99C2063A
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594028421;
	bh=4mohpQjrOHd3RRJkMEldyedWWYuwVUvEtBy+YtWgAIw=;
	h=Subject:From:Date:To:List-ID:From;
	b=vHAqGrlRl9srXDV5GMXcAsrSYpaHt4tqNa/z9bUPKTiS9v/GpLJRphQoTNANqO6gs
	 tGe1WkCOT4KwKgD7EnvHEufv5nXKEYsepSM3TCty/2cPwhu6KDiKWMAoaTwbtO2DEC
	 Vf+ghUdBwuKDkvqyc8V+zm3dcY8+d8tdZ8+/N5aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGFJkU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgGFJkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 05:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594028420;
        bh=4mohpQjrOHd3RRJkMEldyedWWYuwVUvEtBy+YtWgAIw=;
        h=Subject:From:Date:To:From;
        b=gM1jzlHSuJnOxo4TvZaPi9zKE8g4qzMw1+s+5iuJ7PVbOHpzisZi6u3akhAZ4G1d8
         487qhJR5qd31ECdNJMuXhgJZwp0kXM1yNCFtrdAKej+t5nxttTzvxTZZwr6AlAcg7v
         PKu+gXueAlL8XNnN6pI/hQH9B1dGmd9Yc6nuhBLM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159402842030.22133.13785834946393477533.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Jul 2020 09:40:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Add the SPI daisy chain support. (2020-07-06T09:22:43)
  Superseding: [v1] spi: Add the SPI daisy chain support. (2020-07-03T14:12:43):
    [1/2] spi: Add the SPI daisy chain support.
    [2/2] dt-bindings: Add documentation for SPI daisy chain driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
