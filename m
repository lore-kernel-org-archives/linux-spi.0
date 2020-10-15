Return-Path: <SRS0=2ph6=DW=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A66EC433E7
	for <linux-spi@archiver.kernel.org>; Thu, 15 Oct 2020 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F4F21D7F
	for <linux-spi@archiver.kernel.org>; Thu, 15 Oct 2020 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602773683;
	bh=yFwUiDTQCWn4oO+HyQGrXZ/37RFpwrYTUYMU0Um6h1c=;
	h=Subject:From:Date:To:List-ID:From;
	b=ErOxtv636iTgevLvqfQlgwsJK3LaN18O4/hwYl7eFdOQ2BvH6+9x+pqN6niZgztAM
	 cEeEknyKOWnIJkAtsxLJtFhMqbBW/CTsPPpWFS4U8Bk+3mN9t0OBY+NY1D5SGQRdCB
	 Gh3KjUArCT28zs346JKoRGTrwUE5Xqth7RexoV88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbgJOOym (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388348AbgJOOym (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 10:54:42 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602773682;
        bh=yFwUiDTQCWn4oO+HyQGrXZ/37RFpwrYTUYMU0Um6h1c=;
        h=Subject:From:Date:To:From;
        b=Thd22s7q+sx04sKrKCv2IFsXkjGoMBuAGFTxvRQrhCQ410+CruZDkiLjNCUmyOhv9
         bj00R2MwXbePXylzd48Ot1FT0hqSfCI/feTJYFIzy9jGXENsbgZA52f+2WV7bve6S+
         lccz6Ep4//mt24GwpbHKZGOB8Sl1O14Sfrsl07O8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160277368223.9314.14644802045097761016.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Oct 2020 14:54:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: unbinding slave before calling spi_destroy_queue (2020-10-15T14:38:34)
  Superseding: [v1] spi: unbinding slave before calling spi_destroy_queue (2020-10-15T14:29:51):
    spi: unbinding slave before calling spi_destroy_queue


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

