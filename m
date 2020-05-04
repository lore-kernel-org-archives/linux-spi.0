Return-Path: <SRS0=rKwf=6S=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB0C3A5A9
	for <linux-spi@archiver.kernel.org>; Mon,  4 May 2020 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A6C2073B
	for <linux-spi@archiver.kernel.org>; Mon,  4 May 2020 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588598415;
	bh=IcwgHHjXg4S85a2xHlC56jdzohDWgNhjhtpFlSvx1ws=;
	h=Subject:From:Date:To:List-ID:From;
	b=ROWkTSJqmCRDrSp8zNn+JbCHYMxLB2u7UGM1kRe/4msaiIcvAqdGwZoXvYrGORJoM
	 OA0jhMA9BKr9BsuU4nofUTZw/5pzDmOdpde9vs+ymBeJ1ryC25Pc/f3cGYb3YWD3Ot
	 +yPIFiClDm10uV8+9gavm12Q3zyb5o7UVoch/g5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgEDNUP (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 4 May 2020 09:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEDNUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588598414;
        bh=IcwgHHjXg4S85a2xHlC56jdzohDWgNhjhtpFlSvx1ws=;
        h=Subject:From:Date:To:From;
        b=2tT0qa9uX0SwNip85PLfXD2EZl3RdwvbenaqIedfGehCri4ZMIjrOGqbsHLDd+4EN
         B6aFGPEiNSSPekqvi3eKOPHe1AiC+PtfonfyZywO4wNhvhDDglyVvrCdt/d7t7PPwQ
         1Km+egp4kmJpCwYp5pfHIBS+lk+Dj9SzFhwFXWSE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158859841491.31652.14372184776756187406.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 May 2020 13:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: dw: Add support for Intel Keem Bay SPI (2020-05-04T13:02:39)
  Superseding: [v3] spi: dw: Add support for Intel Keem Bay SPI (2020-05-04T12:11:44):
    [v3,1/7] spi: dw: Fix typo in few registers name
    [v3,2/7] spi: dw: Add update_cr0() callback to update CTRLR0
    [v3,3/7] spi: dw: Add support for DesignWare DWC_ssi
    [v3,4/7] spi: dw: Add support for Intel Keem Bay SPI
    [v3,5/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
    [v3,6/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
    [v3,7/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
