From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
Date: Fri, 9 Nov 2012 14:59:22 +0000
Message-ID: <20121109145921.GJ23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
 <20121109143841.GG23807@opensource.wolfsonmicro.com>
 <20121109145504.GC8598@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6097520093800692132=="
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
 patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
 Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
 Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121109145504.GC8598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============6097520093800692132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 03:55:04PM +0100, Steffen Trumtrar wrote:
> On Fri, Nov 09, 2012 at 02:38:42PM +0000, Mark Brown wrote:

> > We should be converting things to regmap if we're going to do this -
> > we're trying to phase out the ASoC-specific I/O and this makes the code
> > simpler anyway as the core will just be able to get the regmap from the
> > struct device without bouncing information around through the private
> > data and so on.

> I wasn't aware of that driver. That sounds way better than the private data stuff.

If you look in mainline there's a bunch of conversions been done
recently, it's fairly mechanical so hopefully they'll show you what
needs doing.

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnRpDAAoJELSic+t+oim9q34QAInSqgrdzlwX9NvNvo1jAXxT
9Gy/nBq9AYJz27PcuBRF72u2lmy5TEdbbG/vfEzzrVndExVVxYfwvp/bXPgYEYFb
OwichlvXKj5acammff9L0RYh9cRQR/+aw8xL4qdEQVaxgRLOa0fIzgGHIaYsN3q+
3axqzarXksBMphwrpWiCrUSUMYrKEaLoq+y6yDvlkTkKLtv8stH2gv3QJyX1UC04
Y3nvBQcFwUeUGdVOZL1S3Tqj/dbEMW2Ms+pqwyHYlXMvnepQmAdsg0wF1IARxs7X
g6aB8tdJtA2j/5dY8RHgNbB4gWMdnZ88LzHhvp7eXlYpU8lMqQ8ycWZho0qE6jjt
uW5pnqLHTurDUCt5VNeyu5vg1dTOoK0kL4bh8mETDKTB3+Nwv5Fgf1Sp6bUVCX7d
IGLcnmoCaX30xNIA/LRKSc+D1me/6W40w2wHsA5OBNwp1gDiBJjfAm4oJnOS1ao6
15TZ1MDE2CfCH3gdwH6kShQmdYnonLcaQYkZcBokCLm7tUnGRB27ywby4iHrb48T
D5ByWOueyGziEYh3VHwHAkaHlfVlUAOpRKuBKY0wUwnBB1r8fWkSmWCMNHikGhYW
8g2eR2f3AxY2lEkcNSuINOVZsL7wgFxZ4uG/Tp+m3weaQeJ0D/B8V3pDej7btitR
SApaXGEt81c9Y2vE/3Jg
=no2K
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--

--===============6097520093800692132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6097520093800692132==--
