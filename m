From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as
 SPI-chip_select
Date: Wed, 25 Mar 2015 14:02:15 -0700
Message-ID: <20150325210215.GN3572@sirena.org.uk>
References: <1426755714-28130-2-git-send-email-kernel@martin.sperl.org>
 <550BAA89.5090707@wwwdotorg.org>
 <20150320095247.GE2869@sirena.org.uk>
 <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
 <20150325151611.GA3572@sirena.org.uk>
 <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
 <20150325165441.GI3572@sirena.org.uk>
 <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org>
 <20150325185007.GL3572@sirena.org.uk>
 <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561486F6-3580-4884-8A6A-8477D8C3BDC9-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 08:43:36PM +0100, Martin Sperl wrote:
> > On 25.03.2015, at 19:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This sounds like you're trying to work aroud the core rather than work
> > with the core - enhance the core so that it can express what you need.

> Working in a single driver makes things more local without having
> a "moving" target with lots of other patches. If done right most of it
> then can get moved to the core - if needed...

That's fine for your out of tree stuff but not for mainline.

> >> Also there is another point here, that Stephen pointed out:
> >> Would not a switch from the use of the "native-cs" to "gpio-only" mean
> >> a required change in Device-tree? And isn't DT assumed to be a stabe A=
PI?

> > Can you be more specific about what change you think might be required?
> > Currently the driver doesn't support GPIOs as chip selects at all so
> > anything enabling them is going to be new.

> Well, if we say we "need" gpio_cs to be set in DT of the master, then
> that might be assumed an API change that might break some custom=20
> device-trees - I was mostly referring to that.

> So how would that situation be with the requirement to use the GPIO_CS=20
> explicitly?

I'm sorry but I still don't understand what you're saying here.
Assigning a value to a variable in the kernel has no obvious impact on
the DT, and anything that adds a DT binding to the driver that doesn't
exist already is obviously a change.

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEyJNAAoJECTWi3JdVIfQ1yUIAIVO+c2TiX9f3WWIqckpw3Qr
litV74SCH39z/iHRuVOef626sB7V+CAKB4O5k4BKG+1/nZTraMrVys4fN32xj9ve
oxsH0BCHGJ1dtAxuwumV2YNjgAPvy5W9NCQNmuRUrTU7Opet7u8bRGcCSSj5I5L3
J8EolxyT2Rqb+R6doTPMG9psKHpZiMiHfIF6GWEp1WCR/C19fZ/fVWzjRqlKstyO
83t0Ll4CDFEAsFt6S83YMKw5U97AvhPgvciIY4HkQlgKFddSSiN2W8Hbe6NTJQd7
YUrTh2vOM6jUt4nMgVIQjP1zWtmFCbUheZl+cW8wmY9qIXHSdglO2Ef0fC73djg=
=PGeJ
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
