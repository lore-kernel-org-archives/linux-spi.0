Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8AFC001DC
	for <linux-spi@archiver.kernel.org>; Thu, 20 Jul 2023 19:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGTTLd (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTTLc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jul 2023 15:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BEE75;
        Thu, 20 Jul 2023 12:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7186761BA7;
        Thu, 20 Jul 2023 19:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B472FC433C8;
        Thu, 20 Jul 2023 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689880290;
        bh=CQQ6H3A+0VM71IQHoBL3hnVKvWrzOIVuzLlOqZfDdL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DELywHrRc+nKmj9Oy7iMDpSIfkRAJS76fSASrDLksXbLHHoe2riBXN8y3DISWoLPb
         YfjApBK6jVXY2ue5OL3Wq6jKMRSYOTnG3UhMXkvh8dvsK+hfBbu0iFSTkjiLnp23Ts
         A1XQUvAPEKoFfK/1067+9y1A1ADKk5mmOlpaen4hKQDgdTgZ5RcgDkb/AEqN9ssATg
         zJLxTO+/iDSBPjxG8vO7dWDWEDA6IZBXMX8quHGKoqbNw+qt8q2MNWt56b5eWsuM63
         BQAHBBx9QRtlxf/n9l1TZONiS42jYp6DLv064vVHFVLADSQgma9fdSOOcTwgaDIQyC
         BQtIFLNg95edQ==
Date:   Thu, 20 Jul 2023 15:11:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>, andi.shyti@kernel.org,
        krzysztof.kozlowski@linaro.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 04/26] spi: s3c64xx: change polling mode to
 optional
Message-ID: <ZLmG4RrXzCXVGP1V@sashalap>
References: <20230709151255.512931-1-sashal@kernel.org>
 <20230709151255.512931-4-sashal@kernel.org>
 <ZKsjHAaH41V8J+Dc@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZKsjHAaH41V8J+Dc@finisterre.sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jul 09, 2023 at 10:14:04PM +0100, Mark Brown wrote:
>On Sun, Jul 09, 2023 at 11:12:33AM -0400, Sasha Levin wrote:
>> From: Jaewon Kim <jaewon02.kim@samsung.com>
>>
>> [ Upstream commit d1a7718ee8dbcc488d3243d52e19c755123e0024 ]
>>
>> Previously, Polling mode was supported as quirk for SOC without DMA.
>> To provide more flexible support for polling mode, it changed to polling
>> mode when the 'dmas' property is not present in the devicetree, rather than
>> using a quirk.
>
>This is a new feature/performance improvement, not a fix.

Dropped, thanks!

-- 
Thanks,
Sasha
