Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79017C4338F
	for <linux-spi@archiver.kernel.org>; Tue, 27 Jul 2021 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A18A610D2
	for <linux-spi@archiver.kernel.org>; Tue, 27 Jul 2021 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhG0MQE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhG0MQE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Jul 2021 08:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C38FE610A1;
        Tue, 27 Jul 2021 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627388164;
        bh=x6LDweg5jTM9n2rGbuuoUfNt5pbuuAoQ8cYxKHYb+KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3QfOZOl26e1nynDNPGUC0lHc0xR4H5YBWsF5hSNtOlTEXQ0iVGSQVmVcM4wsgumR
         eEDF3YKPaQTs+9b7XI3JIL5ry1/b+rjFjK6Ffg8SJ0spooMrcxyoHIDDldNUU8UAef
         1r5NXYUN0BE5JaIK53IXVwdUewiZ5IV2bzW/vpXFwsglWDbyUBvDeY2eAU86kBBmBg
         +6Th84G3RLmiR1/iBq7Xxk2xAVOUtxkceoSwEjpa/L9HwG8dr9I+7QfGTm7twUO7w5
         jpnI+o08wnxgZ43gWPOzWMoLjIWhLTCIc3VohvJTEFcYMN1sMdAEeccVPX0otBgMWH
         ONFhPQy0XqAAg==
Date:   Tue, 27 Jul 2021 13:15:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Message-ID: <20210727121554.GA42404@sirena.org.uk>
References: <20210726101502.6803-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20210726101502.6803-1-marex@denx.de>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 26, 2021 at 12:15:02PM +0200, Marek Vasut wrote:
> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
> the min_speed_hz must above 222222. Update the comment. No functional
> change.

This doesn't apply against current code, please check and resend.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD/+PkACgkQJNaLcl1U
h9CIOwf8CY69720ZxooRACDfqDCL+lwb8z7n2TDkdKZessYKfZdvwoWKF7/KlsSN
9CtflEFkZSNNFsp/19XTDnvv4UW/m4c64AFVqUFG/sll/Dx4FAi4EajOMhrDbnoM
mzvkcgzqQXFnN13jIZXLXDqEL0UnmM4jo4K/VwYjAg0HENa8wrE34xHLw02Baqe4
SvbpQQuR0Hf44xeNTSNn9lrcWi6Ur8uBk2B/4SxpcvpXsfzeC03YEYLbm1aoDeD/
thcQmpBWrI/oAL/e2M+CYcu92R1TiPKtwH/OZJkgiEdh7xiwtjFc0Eg73Zkx8zlW
sQE1v6L2u9PKNCEong1YGLKSn+Jw7Q==
=nARo
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
