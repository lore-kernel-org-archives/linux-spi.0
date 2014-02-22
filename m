From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/10] spi: sh-msiof: Add support for R-Car H2 and M2
Date: Sat, 22 Feb 2014 12:14:30 +0900
Message-ID: <20140222031430.GV25940@sirena.org.uk>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
 <1392907389-21798-8-git-send-email-geert@linux-m68k.org>
 <CANqRtoQVJzEgo_AdVxrPSRUY6ocyPaQ=RKQJyxoExDrfYxiJ3w@mail.gmail.com>
 <CAMuHMdUByWPcYM8M_m5NVM4QP5cQE_tOLGQg=2fTNF7gqkUhig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1J4USyVh4Jt5OGCL"
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUByWPcYM8M_m5NVM4QP5cQE_tOLGQg=2fTNF7gqkUhig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1J4USyVh4Jt5OGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 05:13:16PM +0100, Geert Uytterhoeven wrote:

> "renesas,tx-fifo-size" and "renesas,rx-fifo-size" are part of the existing
> bindings, so I'm a bit reluctant to change these.
> Hmm, since the original bindings didn't specify the default values,
> I could make them chip-specific, though.

That sounds like a good idea, you could also change the properties to be
deprecatedn and recommend that people just don't bother setting them at
all.

--1J4USyVh4Jt5OGCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCBYTAAoJELSic+t+oim9lvoP/RoR4Z6LiWUY98jRsxcfSFdB
aiYH+RmELi+0iGI8+VSibqRZK0QVLhqSfsH4LfnhAiEdrnfYuwqfTcdZ/+U/7SG1
x26D7AxO6GwNndlXCQze3ZUo3P/8EUP9X0pXuvi95qdwsjx4u5a4EJulEVs6LCYN
+66bWijGcwKcBMrxiaBxOy+uIXd2QxwocmooiTYq85ZSTXThG4o1cPbmVYxq7let
qYwciQCJXosOWlhHtXN0Ctk3eFSbR/buNssiXCgNnEpKsBKBRG1pvBy0bbkjd2sR
PMOnai1/fTE1uMdY22SkmAdlKWL7MKV67tv2DgN3FhKV7+NVxwdR+BaaL7/w0Z7G
rxPmvATqLp7EHZe9021nYJHV8RjCErpSR6Vk2RRhUpvzTNGvL5A5/N0/wd4cOGpo
VqrUDASlvJpSyhMOhBBZO9xYBs2i16tmqEU6ToA917YE4N2s69/6f7KV7hvIjmti
ucqo/x9a+tw6K401vRwo4xaiLZ+pbGa2htAIkHJjQoOMXrMCFELZEnKTU43UkZdh
nc1dX1geAwLqa6JFRgX96wyFugUHjiRUMBd9HpeUHXXONwbAJM3Fea5ZTIKD1rWC
nktH6mViSCVHyiEotW8JsWDVqgP1OBkOljBoaze+UxPXG/y6Qle0qp9U/pE5oZ2w
tH+yFWQqYNHl+/ukIdyp
=oyed
-----END PGP SIGNATURE-----

--1J4USyVh4Jt5OGCL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
