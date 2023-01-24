Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F940C38142
	for <linux-spi@archiver.kernel.org>; Tue, 24 Jan 2023 23:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjAXX4T (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjAXX4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Jan 2023 18:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56846D45
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 15:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE50C61301
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 23:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A14C433EF;
        Tue, 24 Jan 2023 23:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674604577;
        bh=epG4/xJYCFiMJ0RwToyd7qA/+qsIUYHFno6fR4Qsg88=;
        h=Subject:From:Date:To:From;
        b=L6azsfc2giSQco0afMc77RnjzDB/rK3+BBYqHDI06LIn3t2fwJGnWLR/MVFe/E8E7
         eIWEhgTgCmQ3KKZqXQi4Gs6clKPIK8k7RzVgHuGRYK4C8eW6gqGmtVJcwFUtACNwOB
         63k0ghbsTSaWPGiGCt96Dn1lVmYMT1ozEjZjM9gZt7v6Vz8pBjXKChAWs5WLPv+6VG
         vVMf218V59qRWQC1valPhwrdT71uL3C3ZB5hlKa4Y6mRuspI76s8oVrqZ6S4B2JA80
         iZ3vxzo7iPJd6bLUakFiG65/eTFA4uAdcx+nHItn14Uni53/ZBoHymQLhluT33PEHb
         VfLOj6ZSbDxgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03753F83ECD;
        Tue, 24 Jan 2023 23:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167460457701.28528.482831899194700484.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 24 Jan 2023 23:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] dt-bindings: Add missing (unevaluated|additional)Properties on child node schemas (2023-01-24T23:02:28)
  Superseding: [v1] dt-bindings: Add missing (unevaluated|additional)Properties on child node schemas (2023-01-24T23:00:48):
    dt-bindings: Add missing (unevaluated|additional)Properties on child node schemas


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

