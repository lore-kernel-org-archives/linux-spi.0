Return-Path: <SRS0=TAp4=7I=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B246C433E1
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC3A204EF
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590498018;
	bh=cgtOg7LRb7mHQVQ0w8JrChyqL9xUacXAwRK8lw4EMOk=;
	h=Subject:From:Date:To:List-ID:From;
	b=hzR/Iti1s1HxGUnN8pbxTBHODMSq8X9VM9nzYuwgr5cUX6XlKhvUG5vi0NQD6ENTE
	 xZZ/EPCJG1+roNLj/xk/JCpTAPW2/2SkYF0T5lKGUBP5WIhMZXCO3f8ob8Kz7R6IAj
	 9BeQHPvyd8+tqnp1LpG5ISCauAuji6fKbPWs2hBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbgEZNAR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 May 2020 09:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389328AbgEZNAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 09:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590498016;
        bh=cgtOg7LRb7mHQVQ0w8JrChyqL9xUacXAwRK8lw4EMOk=;
        h=Subject:From:Date:To:From;
        b=GH6EgMW0jTU0RadjtTJyh2ZyQIeecrE724swCPl7J8K3uz3Pyyh1bnJUu/tksTqUG
         QmvextZ7ZQMmp/W7yavbEdAXJiPLpSRRfSEKhlhFOFYa30PTaEmPgCWCxnJ52notTc
         55+RbSTkL8km6lQCmLfER0o4PGBBEdbe3vaq+YD8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159049801681.12076.9122781115765490183.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 May 2020 13:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add interconnect support to QSPI and QUP drivers (2020-05-26T12:54:43)
  Superseding: [v6] Add interconnect support to QSPI and QUP drivers (2020-05-21T08:29:17):
    [V6,1/7] soc: qcom: geni: Support for ICC voting
    [V6,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V6,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V6,4/7] spi: spi-geni-qcom: Add interconnect support
    [V6,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V6,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V6,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
