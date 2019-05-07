From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Tue, 7 May 2019 11:18:53 +0900
Message-ID: <20190507021853.GY14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwX7oKFvAj2SwWc7"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--iwX7oKFvAj2SwWc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 12:01:44PM -0700, Linus Torvalds wrote:
> Mark,
>  gmail once again hates your emails. Your email ends up as spam, due to
>=20
>     dmarc=3Dfail (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkernel.org

That looks like it's a fail on validation of the kernel.org bit of
things which I have no control over and which purposely doesn't
advertise DKIM stuff in the hope that people will actually be able to
send mail from non-kernel.org mail servers.  I'm really unsure why
that's failing at all, there's no policy for kernel.org to fail.

> but it has a DKIM signature for sirena.org.uk:
>=20
>     DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relax=
ed;
> d=3Dsirena.org.uk; ...

which should match the envelope sender.

As far as I can tell Google is going to be unhappy no matter what unless
I use their services - if there's DKIM records it's not going to like
that the from is from kernel.org and if I don't have DKIM records then
it's not going to like that either and I'll be more vulnerable to the
blacklists that try to extort money out of people for permanent
delisting.

Possibly it's not actually anything to do with the DKIM and it's just
upset that I'm travelling and so the mail was injected from a mobile
broadband IP in Japan which doesn't match up with the .uk domain.

--iwX7oKFvAj2SwWc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ6woACgkQJNaLcl1U
h9CVoQf/VViEns1FF+b1XU9wV7gcbUx9zYS/VA3JSRel7Z5EwW95p98WYkw8RG3k
BKLav1zV87dO+uCB2jhW9QZX6M1HC9k09MR3W5hlRPmh9WEYfNdTmhBxAad7MFje
XpYC2lrYAoBeOx4Lf0GwsjbLERG4D4t9zc424sazqj6spnnwIMlgw9LlU8oYpuqJ
CdyWWs3tTPrMhfMo7KyN52/X0xAxuvdNn/ENDgEOlUC49msa/+mAnsgsOKRL4kAd
A7omKODjAzUUXDxPAkjkmtvdtZc5SwdvJ4OJ57OcKtOZkQp6Qjjo6DA6cG3V6Hby
dt2hGyITxKXWX5i1WsjCtLuHrBzWIQ==
=AaKX
-----END PGP SIGNATURE-----

--iwX7oKFvAj2SwWc7--
