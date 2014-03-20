From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] v1 ARM: sun4i: spi: Allow Tx transfers
 larger than FIFO size
Date: Thu, 20 Mar 2014 16:14:28 +0100
Message-ID: <20140320151428.GN27873@lukather>
References: <1521319.la1khlz7Zz@nukelap.gtech>
 <20140319170251.GK27873@lukather>
 <1622018.I79WM3hSZT@nukelap.gtech>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R8CP7fzfAHpwDIZp"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: mrnuke <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7ELVSMQKGQEQEYY4BI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1622018.I79WM3hSZT-joXr/IIKmbNbKQuZ0yLBSw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--R8CP7fzfAHpwDIZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2014 at 01:23:34PM -0500, mrnuke wrote:
> > >  	/* Enable the interrupts */
> > >=20
> > > -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> > > -						 SUN4I_INT_CTL_RF_F34);
> > > +	reg =3D SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> > > +	/* Only enable Tx FIFO interrupt if we really need it */
> > > +	if (tx_len > SUN4I_FIFO_DEPTH)
> > > +		reg |=3D SUN4I_INT_CTL_TF_E34;
> > > +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> >=20
> > I'd be much dumber than that. Why don't you just enable both
> > interrupts all the time if we need larger transfers ?
> >=20
> SUN4I_INT_CTL_TF_E34 will trigger whenever the Tx FIFO has 16 bytes or le=
ss.=20
> There are 2 cases where this is relevant:
>=20
>  (a) We have a Tx transaction with a length less than the FIFO size. We s=
tart=20
> the transaction, and SUN4I_INT_CTL_TF_E34 gets triggered somewhere along =
the=20
> way. We enter the interrupt handler, see that sspi->len is 0, and disable=
 this=20
> interrupt.

Well, it wouldn't be triggered, since you wouldn't have enabled
it. But it would be in the status register.

>  (b) We have a long Rx-only transaction. We start the transaction, and=20
> SUN4I_INT_CTL_TF_E34 gets triggered right away, as our Tx buffer is empty=
=2E We=20
> enter the handler, see that sspi->len is not zero, so we leave the interr=
upt=20
> enabled. Exit the IRQ handler, and we're right back servicing the same=20
> interrupt.

Ah, yes. That one is nasty.

> Case (a) only costs us an extra interrupt, whereas case (b) will cause an=
 IRQ=20
> storm, and essentially loop-brick the kernel. I think the current check i=
s the=20
> simplest of the alternatives. It's also why I wanted to separate the Tx p=
art=20
> in a separate patch. This interrupt is tricky.

I guess your suggestion of adding an enabled interrupt mask makes
sense then, just to avoid handling status that we don't care for in
the case of a spurious interrupt.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--R8CP7fzfAHpwDIZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKwXUAAoJEBx+YmzsjxAgUgMQAK2GaC1QiScEGFAVqqgEk2lW
uPd9hya6EuyEf1fiIadjcWyj3SBQqOJtIr1zbQSpUsk/ZRDO3VcsYdhXxaT7ucKo
Wf+qcZgGr1qdzoi01RUstl8Gg8rvppoRVKJU9wb6DW5WdAXa3uicTggwh0aG6dIU
c6GPSquaukjRr4AWRXFUyxm9cqc1/u/hUIYIJBhdDOpQPGsFvv+zM006WANU0Cre
O4Rk2YXsoic2QwzfY5nAyBR8ioSxgPpuNtICH1z/aZxOIOz4+vXvGpy6SXXWhfjp
uLVzVVxkHZlaqkqKCMUQ8i4207CyTkBCynibU2Y8JOHTKhc9inB/32h/b4p9Iec2
xHEtmMLWU70YCgniMQnqHn0T8NDwu3WsL8CB0Q+OGcMKCoN+MVb3v2j88CLU+7LW
yCdFSVc98aWn/Eksrb2YnozfWXAI0X+1MjHBJeUUyB+VuvDtkD9N56W6ktbEHCNA
d+N1apKNAFwZD3qztRNb2jIE2YQQomDP9XTUDDXwnqXrGeK/vvLSN6reIeWhqqYE
PHF3bSJ7UNQPyF4K+gEmI9MJERnWoxgvKL7/bunOr/w63dj5QO+FPlZWPJ0gYdw3
SelxjdNz8JR0rcqlFAqnS4Wo4VvXCPljyHNa2KQqKs2M0AlHr/vkbRIUxqsLJ3e1
Fs/j5zt95jIe1Xv3jYNK
=6UAj
-----END PGP SIGNATURE-----

--R8CP7fzfAHpwDIZp--
