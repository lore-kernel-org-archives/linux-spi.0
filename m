From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] (re-send) spi-imx: improve timing of bursts
Date: Sat, 16 Aug 2014 16:13:36 +0100
Message-ID: <20140816151336.GA5813@sirena.org.uk>
References: <b6c440a488274f0b89a8bb4047d8ee3b@AMSPR04MB517.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Daniel Sobe <daniel.sobe-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b6c440a488274f0b89a8bb4047d8ee3b-xRIOyFSmT1bbVUvU2aK0zQfhPeD8jYilXA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 11:05:49AM +0000, Daniel Sobe wrote:
>=20
> Hi,
>=20
> The patch below addresses 2 improvements:

Please follow the patch submission process covered in SubmittingPatches
- in particular you need to send patches to the relevant developers as
well as the mailing lists, you need to format your changelogs in the
standard Linux style (including word wrapping within paragraphs) and you
need to follow the kernel coding style.

If you only send your patch to the list there's a good chance it'll be
missed.

> 1) Burstsize of a transfer adjusted up to the maximum burstsize of the  h=
ardware --> no unwanted CS toggling between data words
> 2) Variable trigger level allows to increase priority for data transfer, =
 enables continuous transfers up to the burstsize. --> remove gaps  every 6=
4 words

> The original behaviour of the driver is untouched. The additional feature=
s can be enabled via sysfs.

Why would you ever want /CS toggling between words - such behaviour is
just plain buggy?

> +// (sysfs-)tunable attributes
> +static int allow_big_bursts =3D 0; // if set to 1 this enables 32-bit bi=
g bursts
> +static int tx_fifo_thres =3D -1;=A0=A0 // if positive, use TX data reque=
st interrupt when applicable

These would need to be per device rather than global.  It's also not
clear to me that we don't want to enable some level of FIFO threashold
usage by default, perhaps aiming for something just slightly below the
full FIFO so that we minimise the number of extra interrupts but
increase throughput on lightly loaded systems - I'm not even sure that
making this behaviour tunable is needed.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT73UdAAoJELSic+t+oim92ZwP/iy5fU8etN7OcCj9FYnqbc6R
LIquJBmjTmdjxXP7fDMjfBxWGBXoOwWIq+ppyoXuhP900hKlkfBVDQ2kW01tVpe4
69zNomr7+sl/+yVDLLZBeep5w0tXjq3S8OCq4GuG+seBe8UKWuQ8ejwmKGV5DQg9
070BGoVGRJpKhzKAEWJuxays8ZOapwrMCzhpenv6sBsYarpTuxNbS6qVzquY8VCj
me5zXo75VJpn3TAkfcDxwp4Xv8A+dq5xyAaCICMhrmNRHImD6ZJwl9+ljArCsw2Y
j9MyQKYVBzCgv9Se6ZpXNMRJ27nFzG6emujeOPUFMvLZEzEn16LrTTihxLlV+fa0
uZG5EMxn39tAf1dEKxBEskaFUuK874USnAtxdHHDZRUJQ8gqpOrHEU5CUM0G7Mx7
LpyToOo93qRJ/UPVpdmAGF7zfAorgmtRm8c93aOFR9PRrNuoLxH/wr9KmEZWDux4
DkWZ6it1aNFxg0J6Gd4nrQsgt0jpSV77HmatUlxcRekl0c1A8phyEKrUyZ9N28ml
OP7ZgXP5zT3znyEM5Uj5sFRnt1w1EeDcv7Rk//ZKcNspe4ACqnbHMXWfGnNL5E8c
RQ+BgHpFdaHmkJ7Vbn47mCoLVDfyv5BQfOwnuVAWo//IfLqRIYbh3ZIZHmGwT3FS
loL5u04321LdZ2Ig4Bsf
=o0pX
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
