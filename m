Return-Path: <SRS0=f80B=AT=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EAC433DF
	for <linux-spi@archiver.kernel.org>; Wed,  8 Jul 2020 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7C120772
	for <linux-spi@archiver.kernel.org>; Wed,  8 Jul 2020 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594212019;
	bh=84a41jrUrMj7xKtBeZv6uw6CbSwXukZPkpljU6waUOI=;
	h=Subject:From:Date:To:List-ID:From;
	b=AjO1xtZ+xSeynUgO5fUBREBUPfLv4DRogzQgGc1eLGAVyGhkcDcx47h3UveQIYBmL
	 QVwfM+rymnzZ886hmI+uRZxOr9+FwE3ODzOy+Ivk+HssiM38CwYZglUI7suVEDTjFt
	 +hL5WCc62e9od6xiaajNS3AGJNA1NGN5LWtyvZZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgGHMkT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgGHMkT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 08:40:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594212018;
        bh=84a41jrUrMj7xKtBeZv6uw6CbSwXukZPkpljU6waUOI=;
        h=Subject:From:Date:To:From;
        b=M5Sa3Qr39VtDr7IAQ5eLeuWyQjM9lFbOoGoXzjhSKdfDD/9Vwfy6x/fz7ffm2GwHU
         zr58Ft4Ea7Wek3pfAaVO1td4k/WLnGkqMHD7RchUlYcoeSLMqFjkbLcDtZai+l04xt
         oVFF+kOItwxAQmzSzwcXvHaH8UWkA88m8DUdT688=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159421201873.15391.11707397168500299081.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 08 Jul 2020 12:40:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: use kthread_create_worker() helper (2020-07-08T12:33:49)
  Superseding: [v1] spi: use kthread_create_worker() helper (2020-07-08T07:09:00):
    spi: use kthread_create_worker() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
