Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D2C48BE5
	for <linux-spi@archiver.kernel.org>; Tue, 15 Jun 2021 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDAF61420
	for <linux-spi@archiver.kernel.org>; Tue, 15 Jun 2021 11:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhFOLQz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFOLQt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Jun 2021 07:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5031661019;
        Tue, 15 Jun 2021 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623755684;
        bh=do5/Ft0Ug2QKKV16pIjm1Cav55ZqsPnnwJ2SakLmvUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5659nm7mU8dbxL5ejjETuQPnC819oWthIJGpuxoabBaVSQZEW67rqKNug+7bEK6p
         70b7X9PRCzK5cXOMptsXhWm7vN/I3GRo9emqOZNo3amltpwwkP777VMUVTDwM4y91F
         PCjbtDFwjk3B8zPdN3UxZCqMA7mcYd9LTEyglBgm092Z+smm3naHWPj9rUtJ7Uuefk
         oWdwi+U/f+GbYFThQBY3oGcf8U/YDxZOT0yblQOqm2IPthiSWH59Vn5AA92gCztV81
         bYOgY5bxw0QLMNv7nOt93OT4E8nAb2G8DoXLEiSDwehLcQQ/OFTxlM96TpaB/SkKuK
         dSeNH+HRii2Pw==
Date:   Tue, 15 Jun 2021 12:14:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        hanks.chen@mediatek.com, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-ID: <20210615111426.GC5149@sirena.org.uk>
References: <1623721803.24597.9.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <1623721803.24597.9.camel@mbjsdccf07>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 09:50:03AM +0800, Mason Zhang wrote:
>=20
> this patch update spi document for MT6779 SOC.

I don't have either patch 1 or a cover letter, what's the story with
dependencies here?

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIi5EACgkQJNaLcl1U
h9DQ+wf/Yux273+r+yGK72dvXlm0Ap8q0DbSKRRXYm+S8/dxa/Z4yP6+Oj994oi6
AS5dArwtt0+KTpwXnxX/J9oEhOtSMfE2alLqgJ02tjbog38w1z00WH07fe34Ni1C
XH49gqs9bN6JhcXFeDI1VgwzzKDS+6/ZG9CFWlv3394hE4pKtxs2s2plneaqj106
voLcaPSGCJrwtiXG+xUmZO+KzBZhx/ZKAOYZ66k172OuC3eGzGbUANSDlnp7MdPv
IuKwLhwGPQDzr721R7jq8/7zVfrj+hv4lzgrV9lDCBQvpwM/hR9sPFKBbCUM+S9l
nh9imKNN80d/DKW/HQWZ2IwMTWhAyw==
=ux+v
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
