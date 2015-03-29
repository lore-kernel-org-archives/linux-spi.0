From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: bcm2835: remove dependency on handle_err which
 is
Date: Sun, 29 Mar 2015 11:21:07 -0700
Message-ID: <20150329182107.GR1743@sirena.org.uk>
References: <72441EEF-C509-433B-9DBA-53A936ED5BDB@martin.sperl.org>
 <20150329164818.GO1743@sirena.org.uk>
 <119C0671-7379-483A-B734-441E6354633E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YzdYn+D7cUqe+VA3"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <119C0671-7379-483A-B734-441E6354633E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YzdYn+D7cUqe+VA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 29, 2015 at 07:03:44PM +0200, Martin Sperl wrote:
> > On 29.03.2015, at 18:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Why?

> > When referencing patches please include the patch title as well as the
> > hash, this makes the mail/commit log more directly readable by humans.

> This is what I have received and the patch fixes that compile issue...

...

> handle_err was introduced to for-next with b716c4ff by Andy Shevchenko
> titled: "spi: introduce master->handle_err() callback"

> But this is not included in the topic/bcm2835 branch, so the compile fails
> because of the missing handle_err in spi_master.

> If you merge that one in topic/bcm2835, then you can drop this patch.

Several things here.  First, that merge had already happened so the
problem is gone.  Secondly this is the sort of thing that needs to be in
the commit log - someone reading the commit log should be able to see
why a change is being made - and generally we should be going for the
best fix possible so it would have been better to ask for the merge.

--YzdYn+D7cUqe+VA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGEKQAAoJECTWi3JdVIfQxEoH/2t03r77+W7ePOMl+pX3wOI1
jIXVPnhBrFDnxK0qlndOmHo+zAXYnWY7thgbbYS6Q8YIT0DErFiscjbYbsXmqEi9
utQK7i58ox/Gb+xeHGP10Ybsf92HyMUH0pfm80rF5rwvAKKU5RSEVjX7uOKvi6O+
RiYotvKVXfVIV6zkpUOJKuGCdFmsKJmRraZQ99cHIHHVbY1fME8zRgJBAQvjMtBI
TsFHfuUINRZFXKBxGGzm7g24hjtPLwzpYW4d55VCuRxV7qpDt3VINKZPlIiONf6a
boceSzAaEW2ah2m5bkE0nmsKZryR8Svlg3trR234TfpqEQFr7BHWrJtRWqGxLmI=
=K1OD
-----END PGP SIGNATURE-----

--YzdYn+D7cUqe+VA3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
