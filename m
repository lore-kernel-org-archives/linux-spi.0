From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: allow transfers to set transmission speed
Date: Tue, 17 Nov 2015 16:57:47 +0000
Message-ID: <20151117165747.GV31303@sirena.org.uk>
References: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
 <CAGNoLaPnbfKP+aQpWaNuWC7YQTe33wpezJxSv4KHSeuiaDY9TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2rVImvqWGvKULsk"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGNoLaPnbfKP+aQpWaNuWC7YQTe33wpezJxSv4KHSeuiaDY9TQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D2rVImvqWGvKULsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 04:50:54PM +0100, Marcus Weseloh wrote:
> 2015-11-07 23:41 GMT+01:00 Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> > Allow transfers to set the transmission speed, only fall back to
> > board max_speed_hz if requested speed is not set or invalid.

> Just a quick follow-up: is there anything else I need to do to push
> this patch along? Or do I just need to be more patient?

I don't have this patch, presumably there were review comments that I
was expecting to see some action on.

--D2rVImvqWGvKULsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS1yKAAoJECTWi3JdVIfQFjgH/jCu/1sran6AJZADfrRZofX2
2M4Q+7NY3QKvdV6JzzvmSRlcF9/cS7slI1NfDos9OYEN53P3hceGcxnLJBI47sZO
kbvyfZxxkxEd7g5MUsnsAvyeE+ceIyTDotzZ/KO4bSJ23iICK9zuUIlpXRq5L1wV
ScChTBOcwEUXnNMUUigUHjMPzVOuI0YGPe1yBrSyiMNFL2eIKPWPeH3SVFD75jnv
vqsVBZLHIJY8t+Aiuz1dlh81U0rmJb15qPHpGN9mgGQs3H2vuSLN7KQU0+sVuewz
RXRYTisEIaL2ga7goK4S2uqHPEYE2zKq39Nh1jfCnrBnb6jGFOVHR2GMBNg5Y1c=
=KB16
-----END PGP SIGNATURE-----

--D2rVImvqWGvKULsk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
