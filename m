From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
Date: Wed, 26 Feb 2020 11:33:33 +0000
Message-ID: <20200226113333.GC4136@sirena.org.uk>
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
 <20200225155354.GF4633@sirena.org.uk>
 <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be@weidmueller.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Herbrechtsmeier Dr.-Ing. , Stefan"
        <stefan.herbrechtsmeier-oss-2t/0UIm1CeVDOHtkgc7UlQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d07a46e6-6c8f-c4eb-0ed1-d57b7604a5be-2t/0UIm1CeVDOHtkgc7UlQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 08:36:37AM +0100, Herbrechtsmeier Dr.-Ing. , Stefan=
 wrote:

> I see two possible solutions.
> a) The complexity is handled inside the client. The client uses the
> controller exclusive and isn=E2=80=99t allowed to use the new panic trans=
fer during
> a normal transfer.

Then someone builds a system with two devices attached to a single SPI
controller...  besides, you've got no mechanism for controlling when a
kernel might panic or power might be lost.  I'm not sure a scheme that
relies on being able to control when stuff happens is going to be what
you need.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WV4wACgkQJNaLcl1U
h9Cj8AgAgZNMsG788wJYCsjCMZT2ULX1+Zz3UdAYOGSMyUntdkDcIaWXOX0WfuxR
+meEYXvkm7hq4Hy4jRv+Ate1vS3s9tqDcCYmRK6rxPmHvzXiI4dnuZUqrPOP2UDE
lWsIw3/rx6kdD5W+MOkMSJ3myaX7MoQIOtsAuYkzgxQxJRC8nXZFF/Sbvud/SU8G
baehLUhLYHck0QNzwYVOGk4t30L8+LQy/s34ESDGb+IZ+asuTwj95jyi8MWFrCjI
jq1Y8fCR4sqmZMRat0CxR/RaQr/sm7wG/L2DI9DIUO5wm0dARJp9oA/nBZU8tqhj
KwcLpMFfFuVjnvoGMFNcVgq3IgzTQA==
=5yJk
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
