Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169CFC4741F
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90EF21D46
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604594607;
	bh=nzUBLENvNGw4qP7529IkPGt+67Ej7GsURN40SwoTbuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1i4cmzJxdScI6zbjMTkc7w9dQFf8tbVH9Gjr015HiDaKR/u0s33dDaNKrBORV98c
	 VcmbQMnupdluZitq07V7omHB6n+SDuCIiTNvBTA892nx1vvVH1Fn3XawjcDNShzTax
	 ggZ9sx6ZH/nCOuD4tKbshM1E5iNlli7+7ZqeXpkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgKEQn0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 11:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbgKEQnZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 11:43:25 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B552080D;
        Thu,  5 Nov 2020 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594604;
        bh=nzUBLENvNGw4qP7529IkPGt+67Ej7GsURN40SwoTbuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqIqOxZpYIytUMk1dkb5b3eIQUatp1Du9XOiOGzQ22gJ2Xofp+ZV5a/hHGDK7NXfs
         N4qyhQfu5EeA5H8bNzRWF6Om4Zu+rIJ25FfR+VIktuHEfmU4Cyko/KJc6ie19+JLZf
         HBKenVSBGWEPXANLQiRnbgp7EEh3c7fQVOfbFu6A=
Date:   Thu, 5 Nov 2020 16:43:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        robh+dt@kernel.org, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        joel@jms.id.au, andrew@aj.id.au, bbrezillon@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-spi@vger.kernel.org,
        BMC-SW@aspeedtech.com
Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Message-ID: <20201105164312.GE4856@sirena.org.uk>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <20201105161132.37eb3265@collabora.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 04:11:32PM +0100, Boris Brezillon wrote:
> C=E9dric Le Goater <clg@kaod.org> wrote:

> > Thanks for this driver. It's much cleaner than the previous and we shou=
ld=20
> > try adding support for the AST2500 SoC also. I guess we can keep the ol=
d=20
> > driver for the AST2400 which has a different register layout.
> >=20
> > On the patchset, I think we should split this patch in three :=20
> >=20
> >  - basic support
> >  - AHB window calculation depending on the flash size
> >  - read training support =20

> I didn't look closely at the implementation, but if the read training
> tries to read a section of the NOR, I'd recommend exposing that feature
> through spi-mem and letting the SPI-NOR framework trigger the training
> instead of doing that at dirmap creation time (remember that spi-mem is
> also used for SPI NANDs which use the dirmap API too, and this training
> is unlikely to work there).

> The SPI-NOR framework could pass a read op template and a reference
> pattern such that all the spi-mem driver has to do is execute the
> template op and compare the output to the reference buffer.

That seems like a good idea.

> > We should avoid magic values when setting registers. This is confusing=
=20
> > and defines are much better.

It does depend a bit on documentation though, it's not a hard
requirement.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kK58ACgkQJNaLcl1U
h9DGCgf+I0rBJDAblAFHQZV/Foq1amFegL1fHRXAk5+kobJswoMMwbeep5jlgZ4k
P/9UMfROv98skgwDGByNx79txjX5xCcUMW5Oz10pk7y0e9UQya8fUTUrf0gbQza6
OMXG9IMBZObmiJgUKahOaZqmoYo3CE0XJSwjiZwnk9hXQ23t2nsfFZMKe0ZfIORl
vnx/OpoGDVLmnIwCGNIpV+DjdGXuXCVPB4i7NgsQUdyhORxa8WOJUrWAkwC/FCNi
cGHBoQSQYoe1lxm8KCC/xqPqDe5MqIF5+46TFNLORhzTY529mYEdXcHDAE4QZ6bx
nbw7Y3kGyBBE3YjsakRkeoNj/oFcjA==
=QXki
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
