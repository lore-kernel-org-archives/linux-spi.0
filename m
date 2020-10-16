Return-Path: <SRS0=rigy=DX=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5200EC433E7
	for <linux-spi@archiver.kernel.org>; Fri, 16 Oct 2020 08:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC32E207F7
	for <linux-spi@archiver.kernel.org>; Fri, 16 Oct 2020 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602835293;
	bh=Gs+eAf+oEcGnGfdqLx2+MWqTU0Eoyu+owpgoUcsc8N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h5a5sW7rZrx2qjCZeyCjTD1yBRwwRE9L5QJZDfVjAhFUqFrDso9VFalm1+krZTwYM
	 yvbgiBmCdLGE2ZqFF0lyrzgW8qKYJ3u62RsO8NfplsQsTzpbX3ZMmW4lL54f4uK7HZ
	 e5iMDZxbiSx3gYuJBaGu4ng2PrHZKTba0rUNQlI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404916AbgJPIBc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404892AbgJPIBb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 04:01:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358F020829;
        Fri, 16 Oct 2020 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602835290;
        bh=Gs+eAf+oEcGnGfdqLx2+MWqTU0Eoyu+owpgoUcsc8N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIhmrDoIhMDRPJ1pkfcNgBqmCin/B36+grkP0Sjrysu4UijjVLlyG9igQl2U3T2LF
         A1o6544PnNXw5nlD+Hsa2wWKHIJmnzzG6w/0Ra0mFhbrH0KJ0pgMj0OEgFQMjfDu9P
         t4v59M5YI64BIK8Bu9kleutVpVkBv5BSYScKZ+lk=
Date:   Fri, 16 Oct 2020 10:02:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     sashal@kernel.org, broonie@kernel.org, linux-spi@vger.kernel.org,
        stable@vger.kernel.org, yi.zhang@huawei.com,
        chenwenyong2@huawei.com
Subject: Re: [PATCH 4.4.y] spi: unbinding slave before calling
 spi_destroy_queue
Message-ID: <20201016080201.GB1355531@kroah.com>
References: <20201015143834.1136778-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015143834.1136778-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 15, 2020 at 10:38:34PM +0800, yangerkun wrote:
> We make a mistake while backport 'commit 84855678add8 ("spi: Fix
> controller unregister order")'. What we should do is call __unreigster
> for each device before spi_destroy_queue. This problem exist in
> linux-4.4.y/linux-4.9.y.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  drivers/spi/spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, now applied.

greg k-h
