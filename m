From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Fri, 2 May 2014 09:55:46 -0700
Message-ID: <20140502165546.GP3245@sirena.org.uk>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <20140430180609.GC3000@lukather>
 <20140501011811.GF3245@sirena.org.uk>
 <20140501223629.GJ3000@lukather>
 <CAMuHMdUWa1_n94sDvv=L_goc+SOnD9CAKi5DzifrY7GWYRdQmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QzTImLEHWgBoPYMi"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUWa1_n94sDvv=L_goc+SOnD9CAKi5DzifrY7GWYRdQmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QzTImLEHWgBoPYMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 01:28:26AM +0200, Geert Uytterhoeven wrote:

> And then you want spidev to bind to it. Would it help if DT offered a feature
> to add a compatible entry to a driver at runtime, cfr.
> /sys/bus/pci/drivers/.../new_id on PCI?

Yes, that's what I'd been under the impression that the bind file did -
allowed modification of the list of devices to bind.

--QzTImLEHWgBoPYMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY84PAAoJELSic+t+oim99qAP/1G1pCv1j12jRAdOuTxiwDKz
UPlaDgRSOyKe/FcrGPVVp5LzXp/Ix7diTeTay3/iMcOIloD33UR272cUC9UipliH
0N1ATpF4TQ6ird6UZPhKwFkrcWrsQwyZ1aw0LJUtCNhp9M6pZIf09FhVwwe1XQ3a
Vrsyu5OeS0EB5U+jfMKcNiEZLGmK3E+xhZTeXQ/OYbv2Y5UP3QdxMzpAWyb+ZBMk
sd8v4x71keqXrquP9FaD7gsFA346qtjMPuVKIcIflhhzaSt3FJBHty6abKTTSVzb
rlsu4jgY5dRDsVTTYOBxw0PhbxVmi7zwNMwrE33c3t5rH2E9tbvrmIfHZhCOihCe
P81geH9Z+HsHFoFlqyq1vgM2aDSOt6VlXxlEAIBj7pS7MIusoV7fbNm1ydGoUoTj
bw//FCpvvr5XXjoV3TYRY3OalG1IyYo29Nvy1fFOeYl1x+7J6GwXHuaEDdLJKPsN
uV1FzcGUQNLFfcGUbPOGU060JTWknsIdnzc0Pf0GfoP5hi1j0XFFdymxpyuUQkZM
2yvW2NsRnZpN5vE5ud36vmvJ02FRZ9mFhhY6WA1WMT3/NyRR1UnKStZB3F0S7bgy
LhjEr0WYMhhgp4mwBhOrfAc1dR2eLj5RcRLTJSK51eCzGla1++1gCQumSBDpwlnf
WJAS0tx+YoUejbMMDSut
=2Spb
-----END PGP SIGNATURE-----

--QzTImLEHWgBoPYMi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
