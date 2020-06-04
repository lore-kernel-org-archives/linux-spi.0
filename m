Return-Path: <SRS0=yMTu=7R=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BEC433E0
	for <linux-spi@archiver.kernel.org>; Thu,  4 Jun 2020 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3094D207D8
	for <linux-spi@archiver.kernel.org>; Thu,  4 Jun 2020 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591237216;
	bh=pn1JuVQFm+aHXQeH9NGf5KtJxSKNXmMEFoeLpVnmruM=;
	h=Subject:From:Date:To:List-ID:From;
	b=pearENz0NseS35D74VHzp4LOjaOM6Bg/B5NlAAzg66AksCv3UM/Vlin3+UiueIqvq
	 IVqPkysr8WR/m4S9EkOVEvGoZx0EEAH3fAAScsrsU9KyOr4rJmOneblskgw0Cizxnf
	 2RLu6YVegzbcEc5+dbPvzLje61mE2opnwdC4y+i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFDCUP (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 3 Jun 2020 22:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFDCUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 22:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591237215;
        bh=pn1JuVQFm+aHXQeH9NGf5KtJxSKNXmMEFoeLpVnmruM=;
        h=Subject:From:Date:To:From;
        b=dNWsB05hUQhA4X1FZiC/hUSAKsU+mkoE5pzmpBUZLjlOaPa6BEGT0G6Vi29DrfL0g
         arpfPeBc5unAXa2oFDEsCxTp4ZyWtgkvLnne1k9CDS23QNFCnmHfqn1EyVUISJ3rQa
         z8/vbelmUFNqmxfnsXe3U5XEVek1lJveVh+tHgBA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159123721555.21865.14695315803898344928.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 04 Jun 2020 02:20:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-04T01:55:28)
  Superseding: [v1] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-03T06:13:26):
    [1/3] dt-bindings: spi: Convert mxs spi to json-schema
    [2/3] dt-bindings: spi: Convert imx cspi to json-schema
    [3/3] dt-bindings: spi: Convert imx lpspi to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
