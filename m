Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A081C433ED
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AF6611AC
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 09:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhDOJse (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhDOJse (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 05:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768D561166;
        Thu, 15 Apr 2021 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618480091;
        bh=taNxFBIaMeF22Rc2Jy32dPdUib9hWs26znqsqrdM/b8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fF+LoOWC3UdfA9/DrlHtSzH8Yf+UP3ojQFn2AqXbRUNU0miuWGoOtIct+37C6cd8W
         wGMGTNVGBJJeiHSZRawqcUZYKKiv3xP/HxuR/9M3YULeciASLWIYA3YYBjsDkQSWPY
         v+9LLffebKRLGTCiVKAayG8rfKmZtsjdYIaeWjUWXa8IWDaN6JH9iEYpwpNN5uVjOn
         ISFsnt98gg5/fXSUJL23UAbHFbTYayhvTmEdobpGeNZQOu6vDKgLRbG58C1ODysU4Z
         DfN6u+9f+ZLo0u3zvguJK17gKtwLlT7mENi3Rj2XJKgBddA7S39SR0IumXQRXltuDf
         pARg84ktttapw==
Subject: Re: [PATCH 1/3] spi: s3c64xx: simplify getting of_device_id match
 data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <74b0de2c-1ef0-1dbe-318f-dd238d81c0ce@kernel.org>
Date:   Thu, 15 Apr 2021 11:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 14.04.2021 22:33, Krzysztof Kozlowski wrote:
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
