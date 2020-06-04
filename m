Return-Path: <SRS0=yMTu=7R=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA1FC433DF
	for <linux-spi@archiver.kernel.org>; Thu,  4 Jun 2020 21:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC552067B
	for <linux-spi@archiver.kernel.org>; Thu,  4 Jun 2020 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591306816;
	bh=TeSmEY+TVBb8+A4+cQegXDDceL3BFxY1guTobU3jp4A=;
	h=Subject:From:Date:To:List-ID:From;
	b=yn9L1mzJK8H5G8J69UnWEpK2uprLrLwA53bK3JDPPOy9Zl9kAk5UT72AndZW//HBa
	 YjzzPLVw6s3+4o3gKw5YNGuM4OALraS0spAWF6sqZzAAdgpoVq530nzbX0QUJ+Y3y9
	 /hYc1O4nIZC6/pqRcnb0HvfWY/nfE0j8LBj5BRiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgFDVkQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFDVkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Jun 2020 17:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591306816;
        bh=TeSmEY+TVBb8+A4+cQegXDDceL3BFxY1guTobU3jp4A=;
        h=Subject:From:Date:To:From;
        b=S0luqapUdFDwniY/4+pqj1cc4TOF+aIXQ1v9nnOnU5hqgqZ2CUzZQZOhBIEuFk1YI
         faRJhvr4dNtwdiwdzC15IoyjxHR78yOwrIXvLioYyE46UMKYXYn5dku5U5wyCf+7u3
         NSYWG+f7ku3lEdDnpxKcoGi5jKHbgo/mGBb9mR/g=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159130681619.3040.3676063996278331402.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 04 Jun 2020 21:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm2835: Enable shared interrupt support (2020-06-04T21:28:19)
  Superseding: [v1] spi: bcm2835: Enable shared interrupt support (2020-06-04T03:46:52):
    [1/3] dt-bindings: spi: Document bcm2711 and bcm7211 SPI compatible
    [2/3] ARM: dts: bcm2711: Update SPI nodes compatible strings
    [3/3] spi: bcm2835: Enable shared interrupt support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
