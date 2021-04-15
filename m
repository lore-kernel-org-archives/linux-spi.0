Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A2C433B4
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED73A6124B
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhDOJyd (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDOJyc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 05:54:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BC2E6108E;
        Thu, 15 Apr 2021 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618480449;
        bh=nKovn1QsMyyca20/WPuORRcl5Fs7PzssQbuX0dWNxjE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mWUzwwEC0nSYhGNitegRjMAcqZkYluy4d/13s8E/M9Be2tcRmMIohmfffOWvXmJ2B
         TSiMvNaif2ZkkYzckRqoo556bhrl3nsE3oRCmUBlxh6u9cHgL6/+OwKtjhqD0U+LCk
         f8f6TVd8cD/p8HfQ7Nki65BBx6GJ2PojhHCDcb2xZEN/ZDJMZh5C40UJZ9ri/GpU36
         5nLD4sG3ei96/aEvqoip4//iM5YDYEqRJ6FpcRTUdvP4RSp9oRXhZWo7oJ4yx6DvR/
         Dd2DtAb03/jBN71SF91685QDg8qSDf0jcU/WTyJTS/V++iQ2sEnN/HpBvUUJzcRJG3
         saloOFD3GNriA==
Subject: Re: [PATCH 3/3] spi: s3c64xx: constify driver/match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
 <20210414203343.203119-3-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <90b3fced-f06e-913c-1bc1-08b482630b21@kernel.org>
Date:   Thu, 15 Apr 2021 11:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414203343.203119-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 14.04.2021 22:33, Krzysztof Kozlowski wrote:
> The match data (struct s3c64xx_spi_port_config) stored in of_device_id
> and platform_device_id tables is not modified by the driver and can be
> handled entirely in a const-way to increase the code safety.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
