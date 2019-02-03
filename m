From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 9/9 v3] staging: spi: mt7621: Remove superfluous
 pre-declaration of struct mt7621_spi
Date: Mon, 04 Feb 2019 09:42:07 +1100
Message-ID: <87k1igjxz4.fsf@notabene.neil.brown.name>
References: <20190201101715.3760-1-sr@denx.de>
 <20190201101715.3760-9-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6427590758942016230=="
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Crispin <john@phrozen.org>, Mark Brown <broonie@kernel.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>
To: Stefan Roese <sr@denx.de>, linux-spi@vger.kernel.org,
 devel@driverdev.osuosl.org
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201101715.3760-9-sr@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

--===============6427590758942016230==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01 2019, Stefan Roese wrote:

> This patch removes the superfluous pre-declaration of struct mt7621_spi.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: NeilBrown <neil@brown.name>
> Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: John Crispin <john@phrozen.org>
> ---
> v3:
> - New patch, changes spilt into separate patches
>
>  drivers/staging/mt7621-spi/spi-mt7621.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt=
7621-spi/spi-mt7621.c
> index d6385220b796..167d0f09823b 100644
> --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> @@ -51,8 +51,6 @@
>  #define MT7621_CPOL		BIT(4)
>  #define MT7621_LSB_FIRST	BIT(3)
>=20=20
> -struct mt7621_spi;
> -
>  struct mt7621_spi {
>  	struct spi_master	*master;
>  	void __iomem		*base;
> --=20
> 2.20.1

Thanks,
this and all previous patches in the series
  Review-by: NeilBrown <neil@brown.name>

(compile-tested too :-)

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxXbj8ACgkQOeye3VZi
gbklVBAAjBjHDnFm3MxRTDytfhYf4tc99tS8fKxHs0XQYdC1vKpVKmub3elGvsZ2
UqO/khJv+hpVPOOC7ivZaY+5Omj35T9THDeqLP7bY4yzxHusQF+p7qvv6l8GvjBc
6nCeZ8pQqOKUFM6uToqeo8ErJZv2zfF5WWpnwCpNK7vRQ2zYVfcFMfC79mRRBBvQ
ee0e1Du+rImZlcvDU7yw+Hr2UGNkhe0G05PMBsfkV5uPwkBRHF6O/fjZ76Qzs9nw
B3j2aU2tJ6frLSRdgg9Wcy6XDl7lrrGRBKoH6oHcEJlB6RQKjedfi0Ov6djT/hsN
iNaYHAmoEpcQeEW/4yGdVc7QrHoLZey1pP/yvMP8WlHmqmlskruQuTygu+McecoK
BUWTWzkv212BXHDdDVEbuHOLoifnZ7YbifIlIRSCZz1xtcURTqHt73e9MMHlJ/Nb
lhrtdz+uF7m6yiKr5VzYEjL/I93sUyl3GiD4fW8PTBhaw5+QXhmiy44Kl/S/ZaWR
vChRlKCyWLuISicT7ndSPvLLsYzkesFRUJHQszFbVatRCoT2x2SOL4KPG8TmH7tB
vMTPKN09SaldYSUN8CxYicweZFbrgolfJbrZTvXXTrTAak3GgV8VR+M/RSQVB9wQ
Uhah2mtBGscW+ovb4sZ1h4Lj39bHGNGpyJ70MlDMDNTdi995jYc=
=wae1
-----END PGP SIGNATURE-----
--=-=-=--

--===============6427590758942016230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6427590758942016230==--
