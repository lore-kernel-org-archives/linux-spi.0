Return-Path: <SRS0=zioz=DI=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BD5C4727C
	for <linux-spi@archiver.kernel.org>; Thu,  1 Oct 2020 07:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66482145D
	for <linux-spi@archiver.kernel.org>; Thu,  1 Oct 2020 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601539052;
	bh=i/y/eqbwrBJsGrjJuefZOEXjj8c6YFv6ds1b6/v9zik=;
	h=Subject:From:Date:To:List-ID:From;
	b=ZL5adkxqbrlOddPUZ6Uoezt7PYIj3TEPGhaazK5aSfLdPc5P+wBiWcATW18QLjyLh
	 WOLkGAQZgp2a31IgCgtZDuNAobeogGSUkqJA8voCZzCTPS/IxGPawrJfzJ6yTTJw8G
	 X2hSE9q1TstfXsGb0qyZboyCXAuKlhBjsmv2rSOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJAH5c (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJAH5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 03:57:32 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601539052;
        bh=i/y/eqbwrBJsGrjJuefZOEXjj8c6YFv6ds1b6/v9zik=;
        h=Subject:From:Date:To:From;
        b=crFL64M9baBPWf4kkDDfkrQmB4I7W9Wqf/DjWpmNYgnUHSn7DjjomijAnNvat9jzi
         WjkMtQJ+Oa8ihNsZqq80gMrpPml6XeY1gT0RuJrMvfgMM5OR2f0kNhGN1EMzuuSQgO
         LjW7+BqPDtP+wlnT1BQX5UJP7SSMBu1SmhtylVh8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160153905204.23196.9184702581587824131.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 01 Oct 2020 07:57:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] serial: max310x: rework RX interrupt handling (2020-10-01T07:44:15)
  Superseding: [v1] serial: max310x: rework RX interrupt handling (2020-09-30T13:51:37):
    serial: max310x: rework RX interrupt handling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

