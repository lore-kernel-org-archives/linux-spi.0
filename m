From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5] ARM: sun4i: spi: Allow transfers larger
 than FIFO size
Date: Tue, 1 Apr 2014 18:22:16 +0200
Message-ID: <20140401162216.GN26751@lukather>
References: <20140331104522.GD26751@lukather>
 <1396318611-8997-1-git-send-email-mr.nuke.me@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TXIPBuAs4GDcsx9K"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYGQ5OMQKGQEZ4B6GWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396318611-8997-1-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--TXIPBuAs4GDcsx9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 09:16:51PM -0500, Alexandru Gagniuc wrote:
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
>=20
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
>=20
> For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
> replenish the FIFO on large SPI bursts. This requires more care in
> when the interrupt is left enabled, as this interrupt will continually
> trigger when the FIFO is less than 1/4 full, even though we
> acknowledge it.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Hmmm, you forgot to Cc Mark Brown. Please resubmit it Ccing whoever
shows up using get_maintainer, otherwise, your patch won't be applied.

You also forgot the changes between this version and the previous one.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--TXIPBuAs4GDcsx9K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTOue4AAoJEBx+YmzsjxAgMJIP/jR7QQBuY9DmcZEzRc1S6nEZ
f2eTmxGIh2956Mv7bZeXRdNclOhs1u+m1r/jr6oyGsTSosmLQ2AMzlExwE8vPzNO
lw8dCxufChimXgNJEMnMTwpCDGEgN8mC9cDLKtNqVGf/exDZyffAGcjw23yLc7Rc
5o4w/0pZyjHexSAabvP3yEs+talV8r2vXSpTt9ZPA/CUanfoeraDJGkQZlriHzw+
kRITGFD9rVs89ZRYvdK1Cq2hXh3SDKefhO/CuLWfGSxCcBlr23SMS8Pyv5KA4Mps
DTEdwyn2tcnE9Tn5oMPQyfPcaNmBXkk4XM08My5knCvdKLKw+Lki03SM1XqmXZKG
RW6M+W5vV6XnxKBFSqPvHv8TOhdv73PUYONeMxkBNgj1lC+A0ESk1lVWX7j06Zhs
kP8Ca9iBnyXgAouVCyMFZOkLZ9XfcEEjwJE/E79Ih8+sQe9ibf9WFn0o3WvL62l8
u/5qnN+P9UbDlIlawZ9XbOovyKoLsze8uQ1h2ZVaFh35WehDIYU91+w49jAKvd4t
lxws7AQa/Kk60XJS/DJxRxVDgtaO9HjUtc1fzx2iZIM1fwpChSinRfaiydBMVuNl
wQdq7R++QbuM9jRV1aBXlxGuzySlft61t5dfE5GNjVh/OMg+pwdujMn3rt9pAdju
K/ejO1iiulUyvEq8B9ul
=sdNk
-----END PGP SIGNATURE-----

--TXIPBuAs4GDcsx9K--
