Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F54C433EF
	for <linux-spi@archiver.kernel.org>; Wed,  9 Feb 2022 03:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiBIDDh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 8 Feb 2022 22:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiBIC4V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Feb 2022 21:56:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700EC0613CC
        for <linux-spi@vger.kernel.org>; Tue,  8 Feb 2022 18:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0636FB81E39
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 02:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B87BC004E1;
        Wed,  9 Feb 2022 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644375377;
        bh=F+ZqoJRQxreQ+mwfuQWeV4lehFMjUcBm+OEwyxbS1ec=;
        h=Subject:From:Date:To:From;
        b=UqAQ8k74XvIUcGZf8y3M1ET3CPLkH43ZzoHJVktyNccQXelUiAqqpo/QHm4/GDeDQ
         /iDAYj3FYW5xBjvOGekBUl80+InxI/JBLnJrnaY+GuQIWqGb+ByeIxA9SVQ46XOfYM
         z+UE503pcIowAjUySB2oOwh7uCrlRfrQ+813XyU2ivO0UTia4/3Ch71YmjKM7/aUKz
         ixEWoH/S9tmsx5Guo8Su1lgiNsZCz89Gmq6PWnPH8F+TU1LchuOOxTRc9xjfJ52Esf
         22/oSo96OxkYEiuc9TzR1JEOmIwcSKk1Fm/eme39NvaUUYEwPc4y7WA59StwbigCpy
         G3Iu5EDNnonrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73A83E6BB38;
        Wed,  9 Feb 2022 02:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164437537746.18096.3296652916390173700.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Feb 2022 02:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add compatible for Mediatek MT8186 (2022-02-09T01:44:42)
  Superseding: [v4] Add compatible for Mediatek MT8186 (2022-01-25T01:23:30):
    [V4,1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
    [V4,2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
    [V4,3/3] dt-bindings: spi: Add compatible for Mediatek MT8186


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

