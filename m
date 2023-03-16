Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9BC7618B
	for <linux-spi@archiver.kernel.org>; Thu, 16 Mar 2023 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCPQOl (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCPQOg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Mar 2023 12:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7E4E1FC4;
        Thu, 16 Mar 2023 09:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E32F56208A;
        Thu, 16 Mar 2023 16:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72759C433D2;
        Thu, 16 Mar 2023 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983229;
        bh=x//uJIncR/2xcTiOX+T5UG+4xIMNq70skcorvIQZLVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELgRUA08ehqMMlyIEIsoDzKPY9ySq+KbwdNd+FWGq92ecyZeALelzAw9vMnpgDqUE
         4kGnwlNSdjmG6tn4elYk5oVnZfbZm6ov6YEz7FW64DhYe1tbOHvlCvE0HNA/+CHOGN
         0a8NDHxfgv137ETt526P/JkrGSlytoPyyW1hEheEBxlopHy+egMgjPAGxcR9IQjMzN
         S/gFjVCRuFtBFuCoQ0eNJrTut90yhZLu4JYFBb09lB6aiF1g904/v4o9Pi4AgvHveT
         nTKiUWMmj4t0TW7MOUjNUBtsQSRIKive+NKK+UU9siI0B8R/lPG6m7YoRojJPSZMUF
         8Yt+vl6WyZrhQ==
Date:   Thu, 16 Mar 2023 16:13:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mfd: rsmu_spi: Remove unneeded casts of void *
Message-ID: <20230316161344.GU9667@google.com>
References: <cover.1678704562.git.geert+renesas@glider.be>
 <ae84c1751e79cb49ab584557f4ecd835a8493d7c.1678704562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae84c1751e79cb49ab584557f4ecd835a8493d7c.1678704562.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Mar 2023, Geert Uytterhoeven wrote:

> There is no need to cast a "void *" to a different type of pointer.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mfd/rsmu_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
