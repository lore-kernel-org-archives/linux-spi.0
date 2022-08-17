Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F0C25B08
	for <linux-spi@archiver.kernel.org>; Wed, 17 Aug 2022 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiHQOLN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiHQOKk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Aug 2022 10:10:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC472BB1E;
        Wed, 17 Aug 2022 07:10:38 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 635C8660159D;
        Wed, 17 Aug 2022 15:10:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660745437;
        bh=800RC4ICkbDmhsqVW2aoXXz19mRXLW32RQKJ2uMQKM0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M7aUifx9KeQns+dDyP9sZSXqRhTtgvqLT+7vUAkfVi6ANb4X54d1nQyQpvRnDjKhA
         D7OMf1XhTgZq27DEpqe9xosatYWCP8PLslavQFK5X/Wq146BlY/CPoC8uIQpejxOPZ
         dc1Ji46HdJ9io2ViNSsCjuWJ4KzKlWO+OX6wf93iNAzjDaybTsbF6zBntrR8vvzaCF
         0lCTtVN3xAxUDPMubSlK3N5h/91ae/6Sj0dtTjWhQEJLvSWNPapZfQz/Bs5peP8jwC
         5MyrhaD2DTet34vKUNjObpm3WReNsiF0zSUtm14tqKBB4XQvH+z1qC54b2jPzxZ9wY
         j8tIp0X1xyJKA==
Message-ID: <3e2a0f50-c396-5af6-5cbe-303978378587@collabora.com>
Date:   Wed, 17 Aug 2022 19:40:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] spi: amd: Configure device speed
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220817131809.312533-1-shreeya.patel@collabora.com>
 <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 17/08/22 19:14, Mark Brown wrote:
> On Wed, Aug 17, 2022 at 06:48:09PM +0530, Shreeya Patel wrote:
>
>> Create mechanism to configure device clock frequency such
>> that it is the closest frequency supported by the
>> AMD controller.
> You shouldn't use the closest, you should use a frequency which is
> strictly less than the requested one - driving things too fast will
> generally break but too slow is pretty much always fine.
Hi Mark,

yes, the code is actually configuring it to use the frequency which is 
strictly less than the requested one.
I just didn't use the correct words. I will make the change in commit 
message for v2 once you review the patch.


Thanks
Shreeya Patel

