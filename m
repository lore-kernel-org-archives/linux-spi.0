From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer
Date: Thu, 19 May 2011 14:44:54 +0200
Message-ID: <20110519124454.GC2219@pengutronix.de>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129458426=="
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Magnus Templing <magnus.templing@stericsson.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
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


--===============1129458426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> -		/* FIXME: insert a timeout so we don't hang here indefinitely */
> -		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
> +
> +		timeout =3D jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);

Won't you miss the transfer if you get interrupted here longer than
SPI_POLLING_TIMEOUT?

> +		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
> +			if (time_after(jiffies, timeout)) {
> +				dev_warn(&pl022->adev->dev,
> +				"%s: timeout!\n", __func__);
> +				message->state =3D STATE_ERROR;
> +				goto out;
> +			}
>  			readwriter(pl022);
> +		}

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3VEMYACgkQD27XaX1/VRul9gCgyDrXeT0zitKbn1GnN5DapJdC
CLcAn3JnWdo0Sr46O+7Uqd06er9RTAEd
=6aIh
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--


--===============1129458426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1129458426==--
