Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F1C433E6
	for <linux-spi@archiver.kernel.org>; Wed, 10 Mar 2021 12:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E3B64FDD
	for <linux-spi@archiver.kernel.org>; Wed, 10 Mar 2021 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhCJMKL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 10 Mar 2021 07:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233003AbhCJMKC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Mar 2021 07:10:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BB564FC8;
        Wed, 10 Mar 2021 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615378202;
        bh=4UsdUZcgfn3U5kBos3d325ZWU5xFGI9Uw9n3S63rJIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttietl6wH0OObTD/pHjfmq6oRGbMjyyqT1eBtykkrMIO1n2dsGWII8jzKqwTVsnnf
         86muKxyQnRD3EQlS4tOK3h30H2wB0ZssbVCEiY756MGS1bybFPmaywlz/gIGSwZH2e
         bWH0Z21av6xUN7W1iv1n1o1rUS2wx1bFYl2esMjgsJ5dYNs4omyS7d3IbA+K7HTxLG
         AsX/7HG+heEo0a0XRMeHjdu0s4CsCMsB4INekcuyrAxHS6UsLFm3Ry5u/BrUdyuwhW
         7APxVOc8kGBIKxrLWry3O3ZOjI2Onea54TzsK49N2NaLYqM/rOvszGYLZLdtQ9PhHg
         xyA0hvqwkTYlQ==
Date:   Wed, 10 Mar 2021 12:08:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Message-ID: <20210310120850.GA4746@sirena.org.uk>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309123601.GA4878@sirena.org.uk>
 <DB6PR0402MB275840529A4F50EBFC723E1AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309173138.GC4878@sirena.org.uk>
 <DB6PR0402MB27582479DBE5A2011ABB049FE0919@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27582479DBE5A2011ABB049FE0919@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2021 at 10:24:21AM +0000, Kuldeep Singh wrote:

> > Like I said in the mail you're replying to please send me a copy of the patch.

> I hope this will suffice. Please let me know in case of any other requirement.

Please submit the patch following the process documented in
submitting-patches.rst.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBIttEACgkQJNaLcl1U
h9C+nwf/V0tpHeRcWrrr0mFyI9HT+MWYHUlMdejOUVaU9o4Ro+RzU2gBObwRjrx0
bqZDgpxiLz4I7bMPi84ZboTSwfVZYPoUC+Itl9Lr0akw5Cw1HCLvfIbO5a/lpwAe
xsqQV6XZQpZCQVpzWUGWSfn8SAIUiHNI3811oiOXRbWWKIiZJPmJRrnX45zB6nc7
eRi5OqWEaBW0Ho95kbIILp9JfSEh7PzU3GnhtumjRYuEyXGH4dQq1kaig2lrpPuZ
OkuAFAkzBTKtgWLm4RcSDX+GNRH7hW6CtcR+zb48iIJVBqtNjQPlxnwjORonGeZM
oE6IQNiz3G8MFbww3m/Wfd+1FwwQ5A==
=MUZe
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
