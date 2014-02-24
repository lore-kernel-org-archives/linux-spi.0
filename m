From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/7] spi: sunxi: Add Allwinner A10 SPI
 controller driver
Date: Mon, 24 Feb 2014 09:59:57 +0100
Message-ID: <20140224085957.GB3468@lukather>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393104959-12831-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140223021530.GD25940@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBE4UVSMAKGQEI7F3IAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140223021530.GD25940-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 23, 2014 at 11:15:30AM +0900, Mark Brown wrote:
> On Sat, Feb 22, 2014 at 10:35:53PM +0100, Maxime Ripard wrote:
> > The older Allwinner SoCs (A10, A13, A10s and A20) all have the
> > same SPI controller.
>=20
> Applied, thanks.  Please differentiate between these two devices in
> the subject line when sending patches for example by using "sun6i"
> and "sun4i".

Ok, will do.
Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTCwoNAAoJEBx+YmzsjxAgl5oP/A4TlhDTNH4pRyyuFwxC21TA
4IRTp93oGzkeIYp+Kc3luM44jf/JypdKcV4SU6OfDj4428TGUnCpVBgZ6ZtbkDq+
rP490C78MTCYahOxpAbbY3JS/051Iv90xLphmH9FbVXyqhGIEplr/gEnp1sNqTTe
9twA7Q4OFq0nDpoOI05CbMyCSw+r3VVSh5Ym9cEIjoZuCXlbqJJhG3ZITsfs4nJi
RcTe3yBmdbPbPPOLTuibdbeyMiUzLZIKOIU3/dPGGqoEY1VTzspUq6Nag9qxeQ2i
FzG03hov6zjxApYqax0R/+G8Z/4L4p+SOSsJpYJ9nQc3gD7oqbeo1fVJafaGhGnS
cza0bn/bkC1CMw7MOfjWaLZbyDl+XmHYajBGdte9TR+8dQZXJsuGRg9+zNJ6i8Mx
FrQuS9+24BA54NVWGYpKybkR7bN85BYeQpnVZ/5OhWxPyJATxNreiYcyay1IjPCb
w7lg1PuSq0NOfiVPZtt8NzUp6KuijcZ6pAMJOWsqoN3hAMOhYAfCWXMwqPU45ntp
csiVpBQnTwWhr34pPECi30sY/ujhvI0reE5GDP9uPyNvr57UivDm6N/FHmd1kdPQ
e+/qkqFa2FdvSwz4ddVOntg8hWevCc93nD+/dzlmLR3wSXe89ZLZ9Jh/CuRayk79
+IgcWTnLqGWLhbGz7t0/
=QMzT
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
