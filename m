Return-Path: <SRS0=xt6i=75=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF770C433DF
	for <linux-spi@archiver.kernel.org>; Tue, 16 Jun 2020 04:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EA720734
	for <linux-spi@archiver.kernel.org>; Tue, 16 Jun 2020 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592282417;
	bh=qhkFTbzLIjC0qCbpevtvOvb4/YHo8fKjFgRrtAgyEAI=;
	h=Subject:From:Date:To:List-ID:From;
	b=ZBkKJ/PCFZcQiLsCQOKB7QmYRgq4AnRIOof75m1IcE0QwVjxAo4iJwi2T4Dy2SMaK
	 OrhQj3ZXijh1hwu3XTxmo3cYpEQjA5AcPddHzl5GGrkFu6VStuhF8hGVGXAs5xrLQk
	 6bxX98WS8KtyDMNDhqH2SgH9NGsvPm0ZhzARuJwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgFPEkR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPEkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 00:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592282416;
        bh=qhkFTbzLIjC0qCbpevtvOvb4/YHo8fKjFgRrtAgyEAI=;
        h=Subject:From:Date:To:From;
        b=AKgosTNgiITqj0oqIVYgAjUxt3WZGIh6y7G6yxPEv+hmXRIj62bK08tP1YUdKv861
         aj5mOrHIhveNgnCdbqmAyIpk+4SpRoKvK6rJCnM/6D04rlXyh7JVawOLfVbte09E0q
         wHw9uiavEljduaqFtgzuYkUm8IIiADFsE2LBOlI4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159228241662.11635.3312496003661387561.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 04:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-16T04:26:15)
  Superseding: [v2] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-04T01:55:28):
    [V2,1/3] dt-bindings: spi: Convert mxs spi to json-schema
    [V2,2/3] dt-bindings: spi: Convert imx cspi to json-schema
    [V2,3/3] dt-bindings: spi: Convert imx lpspi to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
