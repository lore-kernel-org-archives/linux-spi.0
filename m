Return-Path: <SRS0=Slv/=CU=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318BFC43461
	for <linux-spi@archiver.kernel.org>; Fri, 11 Sep 2020 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC76A221EB
	for <linux-spi@archiver.kernel.org>; Fri, 11 Sep 2020 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842915;
	bh=UEtB4jsoJR0dQ5jwP0mVULkK12WZD+SmyMHFkwMhHT0=;
	h=Subject:From:Date:To:List-ID:From;
	b=WaprW83lMgiNEQ2cfCfvKja5CK5whtvvJp+n/9SqgKtC4nflnpJa3rObu40wRXlLc
	 q4YHIV2spVPOoog30QmGJGd8PqQ29ipLKEHlUx4oXQWl/WW5C2qIKYQsF9+pJCCLsm
	 niMeq9NzDIguQba3S4FF8OieVeDjpoR+i4AK48Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIKQsc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIKPHt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:07:49 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599835215;
        bh=UEtB4jsoJR0dQ5jwP0mVULkK12WZD+SmyMHFkwMhHT0=;
        h=Subject:From:Date:To:From;
        b=oOoratufl/gNQR5sMT7cvp45n4Syyi5P4QBw5ky7Y0cMNpPiWFUuX2bpLjA5Fjj5J
         MDjV1fLO4NGPZywfm4i8uh4/PUWwkRG7801UuVs5SQf5XGDH9AyQGjJBkNagQy0YB4
         o6hzEzRbtLCPEc9AdFvII1wQi3m6jKJxbWc1jpUo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159983521553.21508.8749859794785791080.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Sep 2020 14:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T13:03:31)
  Superseding: [v2] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T08:28:06):
    [v2] spi: spi-nxp-fspi: Add ACPI support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
