From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spidev: Adjust five checks for null pointers
Date: Mon, 22 May 2017 13:33:59 +0100
Message-ID: <20170522123359.vc4mmxncove6cup3@sirena.org.uk>
References: <c5452d8c-d123-d5e9-b2cc-a386d1325aec@users.sourceforge.net>
 <df3e58c6-f70d-a5d3-102e-4fab2f7df126@users.sourceforge.net>
 <20170518112846.tcirhguyps3kk3ra@sirena.org.uk>
 <5d9f71d4-2f0d-7083-fd28-fb505841b502@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3tttw5w2z75wvwga"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d9f71d4-2f0d-7083-fd28-fb505841b502-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3tttw5w2z75wvwga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 04:34:45PM +0200, SF Markus Elfring wrote:

> >> The script =E2=80=9Ccheckpatch.pl=E2=80=9D pointed information out lik=
e the following.

> >> Comparison to NULL could be written !=E2=80=A6

> >> Thus fix the affected source code places.

> > This changelog does not describe any purpose in making this change,
> > we could equally well say the exact opposite.  Why should we do this?

> How do you think about to reduce the usage of the preprocessor symbol =E2=
=80=9CNULL=E2=80=9D?

Why would that matter?

> Can it help if the source code is a little bit shorter after the
> proposed adjustment?

Not really - clarity is important but the size of code isn't too
meaningful in and of itself.

Please if you don't really understand what you're sending try to
understand it first, don't throw things out without that.  I know a
number of other maintainers have already raised concerns about the
quality of what's being sent and the effort required to review them in
relation to their value.  There's nothing wrong with doing small
cleanups but if that's all you're sending and there's often problems
then it becomes more trouble than it's worth to review your changes.

--3tttw5w2z75wvwga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlki2rYACgkQJNaLcl1U
h9AxmQf/bd5U5IKJPlS+wkcz/80U8IQYwkkUe7th/TLPIVmFx0nzY5MlfR1JlN8g
/VMExoMD80bciscx/lA7SXNbEMbQ2a6oAzAsFvDxiLQfcKMPstyo3vdwzKgCC/Eq
CLdm3bbBHnXzjC/zChbyEtM/CrPYWb3aD4G3Z6LI5eMw4z/oP3c2+w3Eo4fOkcjD
uxj0dUt6FunHEPNLay8A/ZHkU4Pnm0RCA3IwZHOY07Uac1LrTdg6hwyK1/b5T6uC
h0fm4yg7Vv5Va0JlF1U1CX4bboP41C5YPSFI0pGd3QPfZYC8uFQsDJkTCFWMX0bW
cjx9wAazyUTvbzUUvkj/FQq80Lx4SA==
=4hCV
-----END PGP SIGNATURE-----

--3tttw5w2z75wvwga--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
