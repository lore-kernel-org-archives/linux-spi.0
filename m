Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2699C12002
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jul 2021 03:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDD5613CF
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jul 2021 03:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGPD7a (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Jul 2021 23:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233921AbhGPD73 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 23:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ACD7B6115B;
        Fri, 16 Jul 2021 03:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626407795;
        bh=LlSbQrhJSBU+Sf6iqROOBzPL6dcVJ2xX7v8a6lfDkME=;
        h=Subject:From:Date:To:From;
        b=iTPOvBpUOsD7E2gddLjRZC/EaGiunlVg+nbSdzyIe5ZceI0L6hbJ+fHx6tJ9PKY1S
         dhVDbqQo/g7gtk2S0QvFopKP9HQt7cULklmGU8OOKA/QnWEYYeOSB0qbIv7PGPMUyz
         +aN8oj1sneQ3Zagj6wmHYUyDbLf5p6Igfca8p9MBGUyKosl+br+FhUY0qlzuq4Sk5B
         tLrW1MBNuTf80BrRVM1WrQIlskCP3amAl6ag3DruXo0gzm22A3RfOo3kbAL/rWrlXZ
         6EVqF5rYFcRG6l1ShptD14fdmlaWameM7eRv0dmRo5IblqPMN73PpbeBi3iiiJ5bep
         M/AJTNMQKvvyA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162640779556.489.2067281022826510321.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Jul 2021 03:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-16T03:05:28)
  Superseding: [v3] spi: spi-cadence-quadspi: Fix division by zero warning (2021-07-15T16:21:32):
    [v3] spi: spi-cadence-quadspi: Fix division by zero warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

