Return-Path: <SRS0=F24D=CD=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60258C433E1
	for <linux-spi@archiver.kernel.org>; Tue, 25 Aug 2020 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CAF20738
	for <linux-spi@archiver.kernel.org>; Tue, 25 Aug 2020 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598388015;
	bh=2tR5WO2uWmOE+IQQxRvppRzVGBfqg7FmzQND5ziZLXA=;
	h=Subject:From:Date:To:List-ID:From;
	b=yaHOGrsRstty6zt2fY6t2ZEn4s0sTtfVglMUNhXLKgz3Z8iddqR+tY6gX6LD93KRE
	 AcpLYUOf8B2IAxQpaYZ1oByNHFxa/SXD5TNnsotAUGGw1EJP8uLs/H0pcY3YBbSN15
	 opDPdxpyG7v8kUjHviZSgiN2Znv3SIk9hosG0foo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHYUkO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 16:40:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598388013;
        bh=2tR5WO2uWmOE+IQQxRvppRzVGBfqg7FmzQND5ziZLXA=;
        h=Subject:From:Date:To:From;
        b=prCNGlYW91iNj7saMnyzwXU8LtwhHha3mC1xy68qqIMeLmXQTp47D2NWJVrP865oJ
         3+6wioPG6GDo2OB7Zgq+c9mQzVcxmSwfgw8CHABXXRogi2RM+nDuKnPjyuPsD9x8Es
         ISSk9w5I2xdDaJLT6SLRG19/pyF/2KMmAF1PEHmg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159838801360.18496.5637697097839392948.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 25 Aug 2020 20:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers (2020-08-25T20:17:43)
  Superseding: [v1] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers (2020-08-25T17:17:30):
    spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
