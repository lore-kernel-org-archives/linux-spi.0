Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC4C433DB
	for <linux-spi@archiver.kernel.org>; Thu, 25 Mar 2021 14:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15656619FC
	for <linux-spi@archiver.kernel.org>; Thu, 25 Mar 2021 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCYOwK (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 25 Mar 2021 10:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCYOwA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Mar 2021 10:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B21961A02;
        Thu, 25 Mar 2021 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616683920;
        bh=xtiUPNT+gkTEazvbg7RxBkrQf7RL170bGGKjxpmjJS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeDkvV8rzROkU74VYQUxbJHUUZAOMbF8D7fDqwaptHpMqTjdhwAGiAi18DGzzrcdh
         NpYMo1iRR08fJHEi6H3fCFVdXZlTAtYrh2BrnTbgymBTaWJjSDKQ7Vm+3UmZ7niky9
         yQ2BuA/9CoBf76Nqfih8q0oTES8Sd6skCRb7MoxfWEo61ZYDh2uBfO4KHr5e/DmpRW
         UbaSq/T7qQHcpIvO7EtIGeoTcXc4Tcq3KGYDVpp5wHHMU10/M7dP1Zduv7iOpcyubM
         /XF9J8TuAkBNm9hiyDwezoV/ATqTZ791t/YnrJIF1LwTQio+Goq+Kr018vTXU/4Deb
         bMaOlprtLjY/w==
Date:   Thu, 25 Mar 2021 14:51:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au
Subject: Re: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted
 chips
Message-ID: <20210325145152.GB4620@sirena.org.uk>
References: <20210324220516.41192-1-eajames@linux.ibm.com>
 <20210325135038.GA4620@sirena.org.uk>
 <d79291deaa1e9960a177dd887884724f22eb0ea6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <d79291deaa1e9960a177dd887884724f22eb0ea6.camel@linux.ibm.com>
X-Cookie: Offer void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 25, 2021 at 09:46:50AM -0500, Eddie James wrote:
> On Thu, 2021-03-25 at 13:50 +0000, Mark Brown wrote:
> > On Wed, Mar 24, 2021 at 05:05:16PM -0500, Eddie James wrote:

> > > Updated restricted chips have trouble processing multiple sequenced
> > > operations. So remove the capability to sequence multiple
> > > operations and
> > > reduce the maximum transfer size to 8 bytes.

> > That's a very small limit, it would be nice to be able to identify
> > devices that can use the larger limit so they don't suffer
> > needlessly.

> Yes, this is only for the "restricted" controllers which are marked by
> a different compatible string. I guess the commit message isn't
> perfectly clear.

The commit message reads like there's a new version of the restricted
controllers that have even more limits.

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBco4YACgkQJNaLcl1U
h9CDvQf/UtiQ7EaCZ+2IcZpzTTE1c/bJov/6eb3QLgO84bk1cVoyKuiVGpYlaW9I
7Dvi/yDWbpueWJyXAXbplps0ME5HdjVJnIn5h81Yc4cPCAN5co8aBwndiZBlyU6c
N/8aqhG6mtT4oC4+9V7HxyCtePpiXPieSkG5vydJrtoTwEhWI0fw/lpzPDreuyjm
Mlwya1G0SA6oPtVAWFQ0y5h71zYSpAio5AYgVEBe9cMCwfVzOBCJGjcTrkKE1mkS
v2LyXr1uTrgr0SQnRiGmZhBpXCL2Pb8Tb/7n0Djb9c9m9ylmn4zfGulq8Bx43Ewd
tPojaow/meTZ9YHT3egJVXK1zs2HQQ==
=YPnl
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
