Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED52C433EF
	for <linux-spi@archiver.kernel.org>; Wed,  9 Feb 2022 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiBIQ5u (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiBIQ5t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 11:57:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346AC0613C9;
        Wed,  9 Feb 2022 08:57:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E42591F44C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644425870;
        bh=kPK11mfNCz4YUzavlXfvC9MVi37djtE4QzmyeYWbNb8=;
        h=From:To:Cc:Subject:Date:From;
        b=fYwgLHo2XtBxvW9a+EUTQJPRfPB5gkEKsPeei1QqBlY0/i9+EnDwLHYE1AHicJzbh
         /cXoUseZl87sDDNRkqAzTkiaiuIFEntrHS+ObqGRKUagrEpUIv6njQX3eW4Wz+qHZL
         XAHLhuYwAnybBzEy7EzLZ2sz/d/0OhG1bhJP3lMptd0bPY8f2/7SsEmqWEHHsvOgRn
         sVteAtNc4/pgnO1BeDr84yvaYcg6pIx0jrbBhYF2DciXgfLmomKzqgOvbHirtvvQeO
         iY1RuVs3H9wVeAt06eGsvpYeVoA0+gCO96EctqvsLpxh/Cd+uOrWzDUYMDAyc3X6Ij
         Jg7r4Iy2XGa8Q==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/3] spi: amd: Add support for new controller version
Date:   Wed,  9 Feb 2022 13:57:30 -0300
Message-Id: <20220209165733.43134-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series do some cleanup and add support for new controller version,
AMDI0062.

André Almeida (3):
  spi: amd: Use iopoll for busy waiting
  spi: amd: Remove needless rom_addr variable
  spi: amd: Add support for version AMDI0062

 drivers/spi/spi-amd.c | 79 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

-- 
2.35.0

