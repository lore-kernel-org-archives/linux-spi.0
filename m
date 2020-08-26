Return-Path: <SRS0=ASUY=CE=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C9EC433E1
	for <linux-spi@archiver.kernel.org>; Wed, 26 Aug 2020 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E82214F1
	for <linux-spi@archiver.kernel.org>; Wed, 26 Aug 2020 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598467001;
	bh=otwpDEzZSRBssl/+1zrjH3xCNpCmo924Wtj31WjR9iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TruXrvzv3Zg3hgA8cM7WzYDWYbW1DMBxpnDCtiVwwbmDY/t3sZwbv4mDgXkI4jK9D
	 dJ5yfr1CSGDh6pYOB/WWwNbrjMDVz5vlzffBxoHyjltt/2UwyDarPmAqUE71fSP7OS
	 +N89TL6qvx206MZBeDcsNn4daOKc9apGv1rRFCsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZSgl (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgHZSgl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 14:36:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1545208E4;
        Wed, 26 Aug 2020 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598467000;
        bh=otwpDEzZSRBssl/+1zrjH3xCNpCmo924Wtj31WjR9iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRyeBbv7zw3Qgz+1MarwIiLtV5PmPxI6SOQ15jjIgjvRS1JPksfsHgut7rjXAQTYz
         24bL3dNpGkC7ZXTX8dk0iOHeON5wfK3tKPIkzRuHeyNJc5GYWMhrNvXRrSkqr0u09F
         wGMpiAVAZdgzpCuQh/1ErqEgaGRuewiXolUbQ2PY=
Date:   Wed, 26 Aug 2020 19:36:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826183603.GP4965@sirena.org.uk>
References: <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
 <20200826160950.i3k2oy6w2dlvmj34@skbuf>
 <20200826170205.GL4965@sirena.org.uk>
 <20200826183044.4g6jvfrgkhpxki3k@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/DkgDsqJFFamjKX0"
Content-Disposition: inline
In-Reply-To: <20200826183044.4g6jvfrgkhpxki3k@skbuf>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/DkgDsqJFFamjKX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 09:30:44PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 26, 2020 at 06:02:05PM +0100, Mark Brown wrote:

> > That's not something that it's particularly idiomatic to actually use in
> > ACPI and you end up with the same namespacing problem assigning IDs so
> > I'm not sure it makes life any better.

> So what's the idiomatic thing to do in this case, allocate the first
> free PNP ID now for DSPI controller on LS2085A, then another one for
> DSPI on LX2160A later, etc etc?

AFAICT yes, assuming you don't make it look like a PCI device and
enumerate that way which is more how these things more normally end up
getting done.

--/DkgDsqJFFamjKX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gq5MACgkQJNaLcl1U
h9C6twf+PyPo8Vp/efexBeGZf6oJ4vE+zGVxxKbzWoPyzKTy2VlBDNQU7Oqd0r6+
EZhJ1MRWMI9S2+IGprqddt8oc8IFgQpiFe+NOZf69AieZU5bTvhLRdCxSglm+7Zv
ZvIjIZbYW9wV/MiUQCOADvdAdkETDr1U9NNJVpNG+1EGd/2Tt6NUBxdPcc/OKXFI
p8bCtzZ/04cEaPZMuvm3IP7V6TgeTngxN1Z4bFtVKnPnlwAvW0fDTCvKlRCUrhSn
3iWtim8aC8rdSju4yuT4djzX3VFl0xBrOsKMNQhLoTwYV8+uvtOnpiqmE5D685Gb
Q6JLO1s9uXGKVgo0n4GWn8iIJS1dbQ==
=R2TH
-----END PGP SIGNATURE-----

--/DkgDsqJFFamjKX0--
