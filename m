From: Mark Brown <broonie@kernel.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 15:36:45 +0100
Message-ID: <20130704143645.GA27646@sirena.org.uk>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2315027143937129508=="
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
To: yuhang wang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============2315027143937129508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VJJHO1/Syn9XC8G0"
Content-Disposition: inline


--VJJHO1/Syn9XC8G0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 07:36:48PM +0800, yuhang wang wrote:
> Hi Mark,
>=20
> Thanks for your reply.
> I have added the kerneldoc into the patch below to explain the "DUAL"
> and "QUAD" modes.
> Hope for your suggestions.

Please submit things in the form covered in SubmittingPatches -
especially you need to sign off anything you're submitting to the
standard kernel.

> +Description
> +----------------------
> +DUAL/QUAD means spi can transfer in 2bits/4bits at the same time.
> +These spi controllers provide 8 data lines(4-tx and 4-rx). User can
> +choose tranfer mode(SINGLE/DUAL/QUAD) by setting the certain register.
> +Though SPI is a serial interface, some spi controllers can support
> +transmitting and receiving in DUAL and QUAD modes aimed to improve
> +the performance. Also as spi slave lots of flashes do support this attri=
bute,
> +such as serial-norflash in spansion company.

OK, so all this is about is devices that have extra data lines.  Please
don't invent terms like "DUAL" and "QUAD", it makes things much less
clear.  Just describe it as support for multiple data lines.

> +struct spi_transfer {
> ++       u8     bitwidth;
> ++#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
> ++#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
> ++#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */

Calling this "bandwidth" is really unclear - I would expect a bandwidth
to be expressed in bits per second or similar.  This would be much
clearer if it was just the number of data signals.

> +       t[0].rx_buf =3D buf;
> +       t[0].len =3D len;
> +       t[0].bitwidth =3D spi->rx_bitwidth/spi->tx_bitwidth;
> +       spi_message_add_tail(&t[0], &m);

This interface won't work for bidirectional transfers with asymmetric
numbers of data lines - we need separate fields for rx and rx.

> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -354,6 +354,7 @@ static int m25p80_read(struct mtd_info *mtd,
> loff_t from, size_t len,
>=20
>         t[1].rx_buf =3D buf;
>         t[1].len =3D len;
> +       t[1].bitwidth =3D flash->spi->rx_bitwidth;
>         spi_message_add_tail(&t[1], &m);
>=20
>         mutex_lock(&flash->lock);

This is going to fail in cases where the extra data lines aren't
available.

--VJJHO1/Syn9XC8G0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1Yh6AAoJELSic+t+oim9uugQAIm4QBks/OOBWBBTpvFDd2Bu
3ObH+2yoTh6vuCDk14C8ECNZVs1abrKyez/UQ4gwFTblx6YgEDUFkaES/SBLV5II
ohVZRlafN1dNOZ251sD/ye36zf9CLOU2CDG+mFDoaKgu0vOOlTU3uPTt7RuLmUdI
+uupE1NarWlWbKmoW/bpx/P6YgFRp3SEmkNbTlGN1AtxyDfkh3XdpAEgh0Yy2sGX
247U7a2PT09kr8UPVQ5CD/TIlJEoddBmQtBUCjVBid4Ircq0Im6cit1y/JBjfaXW
NauF/B1qeCiDpC7qNutdX98hHnpFPQNnvX5cVTTOlyi0Kp3EROJfpr+v/YdWNTNO
ttCaAYz5yO6B+Nq782HdZR6CRdRLjl0qS8J4ESMLsXRjj9VnhmpGvHm06jhJiHmm
8FezajKKGuORBtjlIi3JKywtQV8YZypwJQBmuiyjgdCB9kgGMvvm4vQWwJC7EJDN
j7RZ+v51sEbe7LinZvOPUi3I3/R0Ph76c7BOWRolvq+c0WeukbJNTAGcEtVWuJS4
n1DjBm0j6dY6guPGtkSMcHRFwns/GNUa26FWbWM7Gt+aCrqmDcCxSvTc6FXblYnr
4Cf5gKv0UJXw1/ywWhqOtPxxon9QTkDWXxBU9SxyXEVy7fzcanZY98g4aoKBIs0T
Uc4+3+I+tg5jgbYwxHof
=ff09
-----END PGP SIGNATURE-----

--VJJHO1/Syn9XC8G0--


--===============2315027143937129508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============2315027143937129508==--
