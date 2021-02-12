Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33CC433E0
	for <linux-spi@archiver.kernel.org>; Fri, 12 Feb 2021 00:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF04B64DD5
	for <linux-spi@archiver.kernel.org>; Fri, 12 Feb 2021 00:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBLAUi (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 11 Feb 2021 19:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBLAUh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Feb 2021 19:20:37 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DAC061574;
        Thu, 11 Feb 2021 16:19:57 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DcDf14nxLz9sCD; Fri, 12 Feb 2021 11:19:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, broonie@kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
References: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] spi: mpc52xx: Avoid using get_tbl()
Message-Id: <161308904751.3606979.3399981869225283560.b4-ty@ellerman.id.au>
Date:   Fri, 12 Feb 2021 11:19:53 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 9 Feb 2021 10:26:21 +0000 (UTC), Christophe Leroy wrote:
> get_tbl() is confusing as it returns the content TBL register
> on PPC32 but the concatenation of TBL and TBU on PPC64.
> 
> Use mftb() instead.
> 
> This will allow the removal of get_tbl() in a following patch.

Applied to powerpc/next.

[1/3] spi: mpc52xx: Avoid using get_tbl()
      https://git.kernel.org/powerpc/c/e10656114d32c659768e7ca8aebaaa6ac6e959ab
[2/3] powerpc/time: Avoid using get_tbl()
      https://git.kernel.org/powerpc/c/55d68df623eb679cc91f61137f14751e7f369662
[3/3] powerpc/time: Remove get_tbl()
      https://git.kernel.org/powerpc/c/132f94f133961d18af615cb3503368e59529e9a8

cheers
