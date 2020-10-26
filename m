Return-Path: <SRS0=cekb=EB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49999C388F9
	for <linux-spi@archiver.kernel.org>; Mon, 26 Oct 2020 09:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0336E22202
	for <linux-spi@archiver.kernel.org>; Mon, 26 Oct 2020 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603706219;
	bh=eGy9X7OAL4wkzbeBoEWEG1SGeJHANMG2vppdHyxCWtQ=;
	h=Subject:From:Date:To:List-ID:From;
	b=Zhsxq0rziJaMTCQG/uEClktAjMfMOpNovGjQ6XKs29goFGpK12xZvDEoT/1e1vQh0
	 G7gd0btWKDKX7DPaVmIrI8i+2A/LZgf9OLxqWUH6Vopkl9zt4Ni1aMbwDeWwQ7EYCv
	 3d3pQ1t36q38Dgu483cpoqChAQC+g32kYS8siA5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1735136AbgJZJ46 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 26 Oct 2020 05:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768783AbgJZJ4K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 05:56:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603706170;
        bh=eGy9X7OAL4wkzbeBoEWEG1SGeJHANMG2vppdHyxCWtQ=;
        h=Subject:From:Date:To:From;
        b=HyImArrwbK2fXB6sRS5tyjldkIa5AoFrG05xgNqhAu2BgefhWRbx5V+7oG5pKsTiH
         IqFL4d5G7SpzOowaJn9siIFkYTFA2RI24xVDdCjqm50IT0Vz8hzKbxw6ehe9aq5tuN
         Z7A4VT7bZVNq+S9OfplHWiiFHzNasvp5iQy4Bjms=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160370617030.22691.8838875473685877977.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 26 Oct 2020 09:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-26T09:45:18)
  Superseding: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:55:01):
    [v2,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v2,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v2,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v2,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v2,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v2,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

