Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744C9C433ED
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393CE61166
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhDOJyD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhDOJyC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 05:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A3696108E;
        Thu, 15 Apr 2021 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618480419;
        bh=ADODfuARmar5XlQu+qdM/TYV8hvB2mj+V7nC+qrXlPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lJlX7U9An9gVj5uDMMk9Xajw1JP/Ci+8cjnv93MDYTydnqf7orpf08CImJRpGdFdC
         tqg0J75Wx0oqfrxo8DOYrVcjKNY6kVCWBi3qXQ7AsA1zMPrYGdubV1mFKytT+ZWZpx
         bUG0AmN8ZPgL1CCAeABm/4ndGJzlGDae2AjOx2Zuxnw9IgZyT/+GqtVtiwkjrDUho3
         GUwpKMe0mUYU31AeXPX8LzhAfypi5CIfX0q02ymFA18ayMnMoSo/c946tuTiIW2odB
         bDPjfRZ45zHuP5T4//ydaLlEw34aXbqUGte3+9jUsNlJcZHhWzIxLSrwcXO/CMpyQp
         upOJfBMOGepxw==
Subject: Re: [PATCH 2/3] spi: s3c64xx: correct kerneldoc of
 s3c64xx_spi_port_config
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
 <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <d51a4940-737a-7667-4223-6a5c92133c38@kernel.org>
Date:   Thu, 15 Apr 2021 11:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 14.04.2021 22:33, Krzysztof Kozlowski wrote:
> Correct the name of s3c64xx_spi_port_config structure in kerneldoc:
> 
>    drivers/spi/spi-s3c64xx.c:154: warning:
>      expecting prototype for struct s3c64xx_spi_info. Prototype was for struct s3c64xx_spi_port_config instead
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>


Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
