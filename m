Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2992C433F5
	for <linux-spi@archiver.kernel.org>; Wed, 27 Apr 2022 11:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiD0LIF (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiD0LHz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Apr 2022 07:07:55 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 04:01:52 PDT
Received: from smtp109.ord1d.emailsrvr.com (smtp109.ord1d.emailsrvr.com [184.106.54.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BE2904E4
        for <linux-spi@vger.kernel.org>; Wed, 27 Apr 2022 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1651056871;
        bh=ddNlq5a2SOtmxvXApNEVeoZ2XeV9vzsOaLURDCY5Qwo=;
        h=From:To:Subject:Date:From;
        b=CVZgAGVEPeKwnPqIFQt62LxJQyN9C2ner9d547kxW3nsR6xV3qHWa00lQXZh+WBqv
         0LFutu6QbOqzQLOO963fWypXGPPqreDgkgsPE4YCMbo1mQ3xcY1fXbAGTY9S15zhcv
         Ccv1jetlEEkauYkvCa9nJeZ1YEUoQ8/35tWWKHR8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 96A9BE00E8;
        Wed, 27 Apr 2022 06:54:30 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     stable@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5.15 0/2] ARM: socfpga: fix broken QuadSPI support
Date:   Wed, 27 Apr 2022 11:54:05 +0100
Message-Id: <20220427105407.40167-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3bf3f977-eed8-458c-82a7-dc4c605c474d-1-1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Write support on the Cadence QSPI controller on the Intel SoCFPGA
platform was broken by 9cb2ff111712 ("spi: cadence-quadspi: Disable
Auto-HW polling) and fixed by 98d948eb8331 ("spi: cadence-quadspi: fix
write completion support") and 36de991e9390 ("ARM: dts: socfpga: change
qspi to "intel,socfpga-qspi").

1) spi: cadence-quadspi: fix write completion support
2) ARM: dts: socfpga: change qspi to "intel,socfpga-qspi"

 arch/arm/boot/dts/socfpga.dtsi                    |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi            |  2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi |  2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi     |  2 +-
 drivers/spi/spi-cadence-quadspi.c                 | 24 ++++++++++++++++++++---
 5 files changed, 25 insertions(+), 7 deletions(-)

