Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F5C00140
	for <linux-spi@archiver.kernel.org>; Mon,  8 Aug 2022 06:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiHHG4e (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 Aug 2022 02:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHG4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Aug 2022 02:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578AEDF96
        for <linux-spi@vger.kernel.org>; Sun,  7 Aug 2022 23:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED65860C21
        for <linux-spi@vger.kernel.org>; Mon,  8 Aug 2022 06:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58876C433C1;
        Mon,  8 Aug 2022 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659941788;
        bh=UQ/azTN4SFNNv+o1dpRNkFMurvr/gxN7QecPeOikOeI=;
        h=Subject:From:Date:To:From;
        b=e+JyIbqiXP4WYz+KQvOdS6Hy8ioM82svLLkrKh551y1W4kUaC8GOeERV92yC3T7Kq
         ZFAu9PeOZPSSVtaqeI7HXN/bAvHVC9Y9MB5uBSgzWSf7p4hGrj5WE9I5FHRSsWzTnc
         rtrGxQjfe+IStKE7dO2anA9KfLf8Y0dszk4vk3AeZdkblZ/I8vPRJ7xMpGf6v+Hw0u
         YhrMvvhbNOGHEEbuyyhvbu1RoyIXgkcftkf/O7Bd4jDUzBfclHVRsfCa0k4AQse7n9
         oHPE0SlooNjE24uCCmlynkVyc9BSgzUU6Yqywl+l+1H34UJBLSlRzkSSHxLkDxj9Rd
         tO51yKkhHt7WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32AE1C43140;
        Mon,  8 Aug 2022 06:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165994178811.6116.18085358940906962435.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 08 Aug 2022 06:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add support for Microchip QSPI controller (2022-08-08T06:45:59)
  Superseding: [v3] Add support for Microchip QSPI controller (2022-08-05T05:30:15):
    [v3,1/4] spi: dt-binding: document microchip coreQSPI
    [v3,2/4] spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
    [v3,3/4] spi: microchip-core-qspi: Add support for microchip fpga qspi controllers
    [v3,4/4] MAINTAINERS: add qspi to Polarfire SoC entry


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

