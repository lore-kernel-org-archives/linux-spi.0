Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E0C433E0
	for <linux-spi@archiver.kernel.org>; Wed, 30 Dec 2020 13:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F7320773
	for <linux-spi@archiver.kernel.org>; Wed, 30 Dec 2020 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgL3Nrq (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Dec 2020 08:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgL3Nrq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Dec 2020 08:47:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E726621973;
        Wed, 30 Dec 2020 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609336025;
        bh=GqsTBoYp5MW6yqMA10j5wvBewkFDsUP08uwEce4EKh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9T/d3sUHCOgAlhKJGok+8OXXsapDAdZm/RybsgrWEawREIS2oj4aChwuFZ3SZ8e6
         iclJ0H7v1+7EoOP7fHRa3PFsUFngxbesMFEVY5B4CNdYVs4OaKOzPQoB0qVQBmENj5
         bw1ogTX5A03Nrkf6gC/rhSDbG2Yc0lPfEzPz5xfJ90yCP2uvsrNTZmyLft02lKoFY3
         KZuF1YwKMypPgOL8vlzJZgVbnWVU3xFVQ5/cJ+3PWXkYR+AEYgIV0N8y0/gZurIc+2
         2+4eune9fft/EYRYrViLoqYoyY+p1i6iB+gkt0tniukaV4LI32NERvyf+Bq/ayqPDo
         peRqCEILMnd/Q==
Date:   Wed, 30 Dec 2020 13:46:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2] spi: Fix regression when the SPI controller does not
 pass max_speed_hz
Message-ID: <20201230134642.GA8144@sirena.org.uk>
References: <20201229040450.10052-1-festevam@gmail.com>
 <CAMuHMdW4fbp092xbspwn-S-DHUQNJqATp=3Rr02vKsMj14CB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW4fbp092xbspwn-S-DHUQNJqATp=3Rr02vKsMj14CB7g@mail.gmail.com>
X-Cookie: A company is known by the men it keeps.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2020 at 09:05:45AM +0100, Geert Uytterhoeven wrote:

> See also
> https://lore.kernel.org/linux-spi/20201216092321.413262-1-tudor.ambarus@microchip.com/

Right, I already queued that version.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/shMEACgkQJNaLcl1U
h9CTTgf/QOsBZ6K7VRcTTpglWENfyPOmVJAbSBuYTQ9jEsAWT2j3b5YNBMfI5Lv2
wnM6Qdy+GuRJwXEWqvlprQHPIvDyHqoxH1jXDydxMIm7yRIuTQknktvT3SYkZxN7
T4ZRr3B+8zuLTJfCEsnE87Om/Pw74z1k1UfOfe0CnVNv4SmUTajiaJ8dpiKhbMSE
WCoJI5U4mwHDxWmiI1nQe0TMICUu1MdhXkCqr2kd7C80U3GeUyYT0YiosfKRjuZ0
5NzKIFWGuj0bOGZ/xiIk1iFJ/DRg8VCeTOZUWVXRcQ41PIEfobpfKLFHo9YmI/je
KHL6ZeNRJFjeU9yfx6dPcmSeclDAYw==
=me8q
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
