Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F8C433EF
	for <linux-spi@archiver.kernel.org>; Thu, 10 Mar 2022 12:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiCJMOa (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCJMO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 07:14:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7077A0BDA;
        Thu, 10 Mar 2022 04:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640C3618B3;
        Thu, 10 Mar 2022 12:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C6FC340E8;
        Thu, 10 Mar 2022 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646914407;
        bh=cmrIX5GYknBVl6iI+66Qn4zD4J81OajoQH+p0d8oR/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=aitcLcrAOnx6j0tj+ZzWSbpQkQWC7CooIKWegLgYUC670R7VBC2+PqCQqOD2bM8AC
         f8iycwbUnSQLdgYPVHCuvQdR6ov4OKeOfPy7cQBTpqZMIhGn8dxsH5kiazTQUK2nXx
         npRnTvkq4tRydzXj8E9piV5UG/d9fGEHygnj98eG9wjyxhl8xy/9P1jaaFYJPMtl1i
         AEm3k9CWOwY3kk/kaa/3QT1rzinhvUZdElwBbl/lZal/+6hdzTJNfxxS7Zv3ZDNlqb
         74K3VFLCOSwdmkuZ/PObswGn6ZSpSS7LF21bmQBpxcj1akkcthtHzQqEkiefQq6yu+
         GEuSHCGHfJ6XA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.17-rc7
Date:   Thu, 10 Mar 2022 12:13:11 +0000
Message-Id: <20220310121327.63C6FC340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 80808768e41324d2e23de89972b5406c1020e6e4:

  spi: rockchip: terminate dma transmission when slave abort (2022-02-17 15:33:18 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc7

for you to fetch changes up to 1a4e53d2fc4f68aa654ad96d13ad042e1a8e8a7d:

  spi: Fix invalid sgs value (2022-03-08 12:27:33 +0000)

----------------------------------------------------------------
spi: Fix for v5.17

One fix for type conversion issues when working out maximum
scatter/gather segment sizes which caused problems for some systems
which where the limits overflow due to the type conversion.

----------------------------------------------------------------
Biju Das (1):
      spi: Fix invalid sgs value

 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
