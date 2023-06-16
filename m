Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5FEEB64D7
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jun 2023 14:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFPOUn (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Jun 2023 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjFPOUm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 10:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2DA30FD
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 07:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADE861A5A
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 14:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CCC433C8;
        Fri, 16 Jun 2023 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686925235;
        bh=QUrrHnVCVpFi+0SUkzA9QDw3PRWToKgbNs31GnkccdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Znn39VCI22YhDksNXCBU1D3tsNwP1FJLakeakAonnxJku66AP6viSOvd0TzxDzB2o
         I4N/4grylKSZyRXeR8DOpdgDYxpr2FazlprLI4S02vLUW4kCHcGjhV3AJ5YbGWXfzO
         Ot4SDFknK8Yyr0GCJdDZK1PUCTR/Slm5pb1Yf48iSQVCa/bPsEIc/lp4HNX+tKLK9/
         YtlVhZe8LRpHm+7iLQQYkN+U/gymF+TFxALIWVNqcjjJqGqUyFUvYcOkB7LYcbWmlF
         nMUlUpw2fcnBvhjiuEUEUfpCvDIU/mi/x0To7gJCFqky0EVf/23tI4hxUdwjnNCTpD
         e2M6KXClQPavg==
Date:   Fri, 16 Jun 2023 15:20:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d//bkwvyX7K+37bx"
Content-Disposition: inline
In-Reply-To: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
X-Cookie: P-K4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--d//bkwvyX7K+37bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2023 at 04:12:25PM +0200, Miquel Raynal wrote:

> -#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
> +#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
> +#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))

Given that we know the bus speed can't we just calculate this like other
drivers do (we should probably add a helper TBH)?

--d//bkwvyX7K+37bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMb6oACgkQJNaLcl1U
h9CUvQf/XzYcOxAzFD0wHWbBV8b/SOmoZaFx8dy3HA9FTN5ZXoiMYz9YHylGEAVn
fI83jzgtcpxRM0W7f+LaO6YEwLsm+gy9h3vxH0lcrFdTk6WjLx1DWhSG/sk1eMmg
lygQ9mWgGtp+LJq8chs4V+MMospOmgbS1dYoHmPCrcrZRrww3rWuNGrFFG/AQgH6
hL2ck+EwZpkyMPTJdsIdlBZRrMyxCFKAaB+jOMJYx6EBDXqK6v9vsA2Uw/ykpI2c
qGAI+ZA6fQWyfnD6GRyLtxmkLUkTGBP47HYx67ZWd7qO0ymuDJvxkBEf7ZNm6czI
VCN0YT7hmWBLP2XOWldJT/R8QREocA==
=x5Wz
-----END PGP SIGNATURE-----

--d//bkwvyX7K+37bx--
