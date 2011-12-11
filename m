From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] SPI: add CSR SiRFprimaII SPI controller driver
Date: Sun, 11 Dec 2011 16:05:48 +0100
Message-ID: <20111211150548.GA30502@pengutronix.de>
References: <1322797883-28915-1-git-send-email-Barry.Song@csr.com>
 <20111208131509.GA13430@pengutronix.de>
 <CAGsJ_4xeN5D47UbG-Xfr0NkvkcuYjP-LRUjumHz+OqTbH=y-_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5428611167274093801=="
Cc: workgroup.linux@csr.com, Song <zhiwu.song@csr.com>,
 grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org,
 Barry Song <Baohua.Song@csr.com>, spi-devel-general@lists.sourceforge.net,
 Barry Song <Barry.Song@csr.com>
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4xeN5D47UbG-Xfr0NkvkcuYjP-LRUjumHz+OqTbH=y-_g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============5428611167274093801==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> + =A0 =A0 writel(0, sspi->base + SPI_RXFIFO_OP); =A0/* TX, RX FIFO sto=
p */
> >> + =A0 =A0 writel(0, sspi->base + SPI_TXFIFO_OP);
> >> + =A0 =A0 writel(0, sspi->base + SPI_TX_RX_EN); =A0 /* RX, TX disable =
*/
> >> + =A0 =A0 writel(0, sspi->base + SPI_INT_EN); =A0 =A0 /* Disable all i=
nterrupts */
> >
> > I'd think the comments after all those writel are stating the obvious :)
>=20
> the last two are. but the first one can still be there by:
> /* TX, RX FIFO stop */
> writel(0, sspi->base + SPI_RXFIFO_OP);
> writel(0, sspi->base + SPI_TXFIFO_OP);

ACK. There are similar "obvious" ones in other places of the code, take care
you get them all, please.

> >> + =A0 =A0 mem_res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
> >> + =A0 =A0 if (mem_res =3D=3D NULL) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Unable to get IO resourc=
e\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> >> + =A0 =A0 }
> >
> > devm_request_mem_region() is missing. Or use the new
> > devm_request_and_ioremap() function (although currently only available
> > in linux-next).
>=20
> many drivers ignore the process to request mem region. if you like, i wil=
l add.

That doesn't make it "right", though. In fact, this flaw was one reason I w=
rote
devm_request_and_ioremap().

> i'd like to use devm_request_mem_region() + devm_ioremap() at first,
> then move to devm_request_and_ioremap() in next window.

Why? You could just pick the patch into your branch and mention the depende=
ncy,
so we will merge it after drivers/base.

> >> + =A0 =A0 spi_bitbang_stop(&sspi->bitbang);
> >> + =A0 =A0 clk_put(sspi->clk);
> >> + =A0 =A0 clk_disable(sspi->clk);
> >
> > First put then disable?
> clk_disable(sspi->clk);
> clk_put(sspi->clk);

That looks better :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7kxssACgkQD27XaX1/VRvnYgCfWt0vq8f5XVKg96iCjrwqlIEC
I60AoJkCxGSZcUOySBv+NUCReSv/wM8u
=vbv9
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


--===============5428611167274093801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5428611167274093801==--
