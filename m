Return-Path: <SRS0=QF/b=D4=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0570C4363D
	for <linux-spi@archiver.kernel.org>; Wed, 21 Oct 2020 02:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20DD22242
	for <linux-spi@archiver.kernel.org>; Wed, 21 Oct 2020 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603248972;
	bh=sgPhWUQ1+o+LCSV+KH56HlgHJg8NMuymfvrpEgz5JlY=;
	h=Subject:From:Date:To:List-ID:From;
	b=lyy11kflTt+xhV8Fwi7ynqsMUamBtmibfHaQPf+XrR8sbFAK3Suz9Rm1I4CfrMAj1
	 n3O3Kz5jDhgBqViQHnncjAcV+R14E4cBj/w8t4LHRHYuux0ybVEItzwvIk3xlsu5iL
	 oDKZhNL74KTyq0CGtsMgSRbTHPcy1EdpjrEFdtEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411467AbgJUC4M (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 20 Oct 2020 22:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411434AbgJUC4L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:56:11 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603248971;
        bh=sgPhWUQ1+o+LCSV+KH56HlgHJg8NMuymfvrpEgz5JlY=;
        h=Subject:From:Date:To:From;
        b=LBuAVCK12RAYfeDFvTBCO5aKvVlEPKoyRiQcvRB3XS+bN2r+ZvhszfrflTelNsWB1
         a+VkcmJ7yuh1vFUfhUIU8W+cKODU7K6FXLqXo44ai/leZReQXRqaH+kzQWzjZAfjC1
         t11RA/pe5sEn/aYylxEX7q+qM6FbPG6F5DeIGhvQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160324897091.7706.137588481375203080.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 21 Oct 2020 02:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:55:01)
  Superseding: [v1] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-20T02:32:20):
    [RESENDPATCH,v1,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [RESENDPATCH,v1,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [RESENDPATCH,v1,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [RESENDPATCH,v1,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [RESENDPATCH,v1,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [RESENDPATCH,v1,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
  Superseding: [v2] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-21T02:36:09):
    [v2,1/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v2,2/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v2,3/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v2,4/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v2,5/6] dt-bindings: spi: Add compatible for Intel LGM SoC
    [v2,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

