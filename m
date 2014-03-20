From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] v1 ARM: sun4i: spi: Allow Rx transfers
 larger than FIFO size
Date: Thu, 20 Mar 2014 16:08:45 +0100
Message-ID: <20140320150845.GM27873@lukather>
References: <2167943.Zs1zPAMITN@nukelap.gtech>
 <20140319165507.GJ27873@lukather>
 <29069269.5VPQtL8a7I@nukelap.gtech>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AAnJd2yLvu+tR7U7"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: mrnuke <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBT4JVSMQKGQEA3SQ6FQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <29069269.5VPQtL8a7I-joXr/IIKmbNbKQuZ0yLBSw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--AAnJd2yLvu+tR7U7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2014 at 01:03:45PM -0500, mrnuke wrote:
> > > -	/* We don't support transfer larger than the FIFO */
> > > -	if (tfr->len > SUN4I_FIFO_DEPTH)
> > > +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> > > +		return -EINVAL;
> >=20
> > Why do you still need this test?
> >=20
> SUN4I_MAX_XFER_SIZE is not the FIFO size. It is the max number we can wri=
te in=20
> SUN4I_BURST_CNT_REG. That's the maximum SPI burst size (16 MiB - 1) that =
the=20
> hardware supports. Anything larger, and we'd need to break up the transfe=
r in=20
> several bursts. That's a different problem than the one I'm addressing.

Ok, it makes sense.

> > > +	/* Receive FIFO 3/4 full */
> > > +	if (status & SUN4I_INT_CTL_RF_F34) {
> > > +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> > > +		/* Only clear the interrupt _after_ draining the FIFO */
> > > +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,
> > > SUN4I_INT_CTL_RF_F34);
> >=20
> > Not that it's important, but it really doesn't matter to do it before
> > or after, the interrupts are disabled in the handler.
> >=20
> I think this was one of those bits that keeps being set by hardware until=
 the=20
> Rx FIFO is under 48 bytes (less than 3/4 full).  I'll have to look into t=
his=20
> again.

Ok, it would deserve to be in the comments then :)

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--AAnJd2yLvu+tR7U7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKwR9AAoJEBx+YmzsjxAgt+cP/34mjs+f43K0lWXCO0Rmh1dn
Z1QvtLR9ucghyfK5JBYLrJaLLN334v2RFv43t5qFmfgIlz2qE0usZaTBAuWpf3LI
Bqb9JfFf0hoLYXkAiHvPAkj5PSbFWM0lj7iPILCNP5a13UQy0sI5TJiuVg5qQncm
MR9/M0wizpdG+8wxUrnP+UBqxCdZ69I+ZrBPAxjnhLgxm04VjUzmBpbZYC7XGMIk
5y7kNYKDBDXKvzqgrYxAn4wHv0YL8h2zpDOc8v/rSrGrsorfPmVIl+BvWHeU1eqZ
sTA3zDELB/h9h8+CExOOd+BOHSFVscgQh+soerIz4NVK6AeHE4bjtTYC4ZTsT/Xd
Jz7B4Sk/8WDRohSiBCJpB6TQEGlCijEcW89PZeJhwtGciNnVPlKujFVdLCZxyhG0
qjdZu5LiAremcs32Cq63FzDik2IROtLWoedk2mXycn0/hAEmjPD054ZjIho3IBaH
y4K+4J8Kvn5BP09wLEbBpK111VNRR7W5LlkulW1b8jCy3Gh+cFDXxoheKwXd/dVo
3ndvBxdbvlThyPuGTRLSfGM3cR/G8yZgss3xxNQ4T/siWAXDxesgqnl8+2c9xyT8
TCDRDijb2AfhKeExM00zPYGsfpRlN0QbyMUAdXszUnUIzDyKxpayTqfO1UHzw/A/
uFY+Od28pUCm+SFx1Yb9
=W9vc
-----END PGP SIGNATURE-----

--AAnJd2yLvu+tR7U7--
