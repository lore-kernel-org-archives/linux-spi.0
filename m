Return-Path: <SRS0=fYXv=AR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31336C433E0
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5CA206CB
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594046423;
	bh=sZhAHk6xSzpkTc47/KVzKOvA6I1XRM312wff6DOZgM8=;
	h=Subject:From:Date:To:List-ID:From;
	b=uxkQ4TDW8uQ5Y7jYOI082bVPJ5wnEuUz8iRt1L6n0jikS+TmcEhiyI1HMl7ifN9PM
	 lrQTXQ6SA9kgx+SCGadg6CG6LVkQGF/Dlj18ZNDoMBKBXKzwSQ8hhGINCs+T5guIqm
	 ZuOz8nN3a7V5yBWLz0PNKYCog6YVBHNd48/oOiH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgGFOkW (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgGFOkW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 10:40:22 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594046422;
        bh=sZhAHk6xSzpkTc47/KVzKOvA6I1XRM312wff6DOZgM8=;
        h=Subject:From:Date:To:From;
        b=TZOFV9RUwNX5brRzahZJ/d9tNgQgS76fR51uuwK99AKdi7iJ66tWLJ+HKYZ7Ab6eh
         r0/zdGIZvVJxOhnyVr840ULuu/jtyY9dqaMZ3yBuW11bjieRnFaNrSX/fa3bKw81HU
         rZqMA87GbSGaXWjc2IYximPp3iwLVWcrKFqOLsbc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159404642222.7346.17929472966217732825.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Jul 2020 14:40:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-sun6i: One fix and some improvements (2020-07-06T14:34:33)
  Superseding: [v1] spi: spi-sun6i: One fix and some improvements (2020-07-06T07:17:52):
    [1/9] spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate
    [2/9] spi: spi-sun6i: sun6i_spi_transfer_one(): report effectivly used speed_hz of transfer
    [3/9] spi: spi-sun6i: sun6i_spi_transfer_one(): remove useless goto
    [4/9] spi: spi-sun6i: sun6i_spi_transfer_one(): remove not needed masking of transfer length
    [5/9] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
    [6/9] spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
    [7/9] spi: spi-sun6i: sun6i_spi_fill_fifo(): remove not needed length argument
    [8/9] spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
    [9/9] spi: spi-sun6i: sun6i_spi_transfer_one(): enable RF_RDY interrupt only if needed


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
