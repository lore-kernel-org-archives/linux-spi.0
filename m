From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
Date: Mon, 30 Dec 2013 12:58:45 +0000
Message-ID: <20131230125845.GX31886@sirena.org.uk>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1tcKVLXPU0QafK6"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388175362-17132-7-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+1tcKVLXPU0QafK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2013 at 09:16:00PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

You've not CCed any maintainers on any of this stuff so I'm assuming you
don't want any review or the patches applying.  You should in general
always CC maintainers, things that only go to the list can easily be
missed.  However I did take a brief look...

> +- num-cs	   : Number of chip selects

Why is this variable and how does this map onto hardware?

--+1tcKVLXPU0QafK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwW4CAAoJELSic+t+oim9ZPQP/2nd3HMmCR2psp65DPPYxhdy
dEKLTndZvFcSAN5OxpykTfNUW4s+cEplfYE9qSvD6mJx7XlKhFDvtbbS7/kTyxWn
n09MH+URO0Tphydi0kXznvQhAj2WYndoYOeWIo3F+xNcrmqy3ejAra5/qQzHxSS+
2Un6Sn0hNejpR5coQgtiy155VZhYMjGWmUpaKxK8OWRR7uhwrJ5uEBi5VkymWNoy
iETHs5SWfIIrw525J0zI6HBbiYS3dlrcnc4AmIqgGSnZumEq9vfLI+XjlobNt6lN
f9FhxJFqt+R3fo+uFno0+Rh4IiZOVxLOOEZCexJ35sjGfcPHLXXotD/1ujqGEUZi
CBFjWUmDOet0xq1MFH3n84Gbg3T5eUSVaFPusCkMK6o3Kr6MPx7Hyis89nfqSO1J
GriHQoxzs5c0VdeIkN5yuTuUq29KSfyeZAfV748/lOW7L1Z0Y/w3o/ZaQ3uOjZrC
vi7d5AQViWoxdpxeHW25Gik0QdfEhUF2VW+ERdXSooIgKHbO2ggGA4rvmJMujXZz
tOCTA19CffOvyYuSxH2mu+ifkokJFTy4ve0JmwijbJPcNjurCr6SlqU89jX4GZ83
SEp4pMJ+QO6QPR3ruHTcyFfAKXfI/kUgp8xFIqwGOuYAaX8aZmryefrctlDXrOGE
pYb/UsveOosAG9Io7Kg8
=W25w
-----END PGP SIGNATURE-----

--+1tcKVLXPU0QafK6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
