From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Thu, 21 Nov 2013 19:10:04 +0000
Message-ID: <20131121191004.GH8120@sirena.org.uk>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org>
 <20131120112920.GX2674@sirena.org.uk>
 <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7@martin.sperl.org>
 <20131120162449.GJ2674@sirena.org.uk>
 <9DE09AF6-AD13-45DE-A36F-BD65E619C342@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9DE09AF6-AD13-45DE-A36F-BD65E619C342-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 07:42:44PM +0100, Martin Sperl wrote:

> One argument for explicitly naming what IS fixed, is the fact that
> this way the default 0 maps to the current behavior, where you may not=20
> make any "assumptions".

Sure, but then this only applies if the client explicitly calls a
function to optimise things.  Anything done transparently behind clients
should definitely set all the flags but things that are actively
engaging with optimisation are different and it's that I'm thinking
about here.  Otherwise what happens is that if we add a new variable
(like we did when we added support for dual and quad mode recently) we
end up having to go round every client driver updating them to say that
this new thing they never heard of isn't going to change which doesn't
seem like winning.

> I right now started to build a kernel from your sources, but it compiles=
=20
> slowly on a raspberry-pi... (also the default .config is not complete and
> a lot of things are left outside, like can support as module,... - I wish
> someone would maintain a better .config I could use instead of starting=
=20
> with make bcm2835_defconfig)

Cross building FTW :)  If you can't test anyway then build testing on
x86 is fine.

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjlqJAAoJELSic+t+oim9e5YQAIUdqli+nW/V2YheS5CgXTll
+vZbeeDINA3ZqMH0LjOxwauJPKMlmWjwtQgSYvyk7h4WkXizNNAZUKdV57jKduxv
FhNtoDEFRoBAXATOQLgQ0jMFkWNBmnbnIhLyPc3vvIHqZ7j+CUt2EtnOjylUukA9
wIYmA3hDVsqZDKgYouunyRSIWnXHJHzhNRfvvu1LKXeVIvWKKSvAJV3jQ7p4y/Sl
utpyk8K6AFLc+xhBFKQAuG+ALP5jqczeaSosCwdLhg5IuAfQw0FXr/RvpZVrNlea
u7HtmqtZ/3g4EsxY/Y4CXY8D3ufqDv5fcx5dwaUd968a8LEZ2SzcZfigsFLsGOjK
LIs35QeGA1E1o9UOqfTbpC3jpz6goGadADiBac2UU4RTX2qjbjzKIvJM3wYnDWmR
7kzRQ4x/awliFXyt00I1T/4PiS3QPPxQYsGRn2LYTuRQf4S4a6R4dAJbBe4Qm+In
VvCKzZrKuTSA8SYz/ewChvWz2zm7osHDGD6qB6x1dQNTE1Us9QBycZIC7AzddSFk
8ATwKpPJ75o5UczcDPxM+o7vN16LlbR0kYw6JKzWEo0AKRmNEg6G5mvE3mw0FBn4
4ayScH3KnlDJgyhQah5XNJNfKK9XzvEDD0gRpVJunMuHKA9j6hlbmQRxAyab1HuG
5o49pr22bAno44Ko2ntb
=+JJl
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
