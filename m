From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SPI: MIPS: lantiq: adds spi-xway
Date: Wed, 22 Aug 2012 19:59:44 +0100
Message-ID: <20120822185944.GD7995@opensource.wolfsonmicro.com>
References: <1345103821-12543-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZgsjCHEQV+PhxuqO"
Cc: spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
To: John Crispin <blogic@openwrt.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1345103821-12543-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org


--ZgsjCHEQV+PhxuqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2012 at 09:57:01AM +0200, John Crispin wrote:
> This patch adds support for the SPI core found on several Lantiq SoCs.
> The Driver has been runtime tested in combination with m25p80 Flash Devic=
es
> on Amazon_SE and VR9.
>=20
> Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
> Signed-off-by: John Crispin <blogic@openwrt.org>

I'm not seeing any binding documentation in here but there's OF
bindings - any new device tree bindings should have documentation
attached.

> +static inline u32 ltq_spi_reg_read(struct ltq_spi *hw, u32 reg)
> +{
> +	return ioread32be(hw->base + reg);
> +}

Can you use regmap_mmio?  Not that it makes much difference, really -
it's totally unimportant, just something to consider.

> +static void ltq_spi_hw_enable(struct ltq_spi *hw)
> +{
> +	u32 clc;

Obviously it'd be nice if this were only done during SPI transfers,
currently the module is enabled whenever the driver is loaded.  Again
just something to consider.

> +static u32 ltq_spi_tx_word_u8(struct ltq_spi *hw)
> +{
> +	const u8 *tx =3D hw->tx;
> +	u32 data =3D *tx++;
> +
> +	hw->tx_cnt++;
> +	hw->tx++;
> +
> +	return data;
> +}

I can't help but think that there's some stuff here that ought to be
factored out for bitbanging controllers, but it's not that important.

> +static void ltq_spi_cleanup(struct spi_device *spi)
> +{
> +
> +}

Just remove empty functions - if the function is mandatory it at least
needs an explanation as to why your driver doesn't need to do anything.

> +       if (of_machine_is_compatible("lantiq,ase"))
> +               master->num_chipselect =3D 3;
> +       else
> +               master->num_chipselect =3D 6;

This is very suspicious - why is this being done based on the machine
rather than based on the IP?  Surely there can be machines with this SoC
on which aren't compatible with whatever (reference?) board this is
matching on.  I'd expect that the driver would have multiple compatible
strings which it uses to distinguish the capabilities of the IP.

Though actually the driver never reads this value so perhaps the code
can just be deleted and we rely on the fact that if the /CS isn't
physically present nobody's going to hook it up on a board so just
always set it to 6?

> +	pr_info("Lantiq SoC SPI controller rev %u (TXFS %u, RXFS %u, DMA %u)\n",
> +		id & LTQ_SPI_ID_REV_MASK, hw->txfs, hw->rxfs, hw->dma_support);

dev_info().

--ZgsjCHEQV+PhxuqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNSwZAAoJEFJkBDiqVpZ4resQAKCc897zqNB64a312J97AKbY
q+R+3JoT5w4kJEbkKgadrhHhVvOwy+LE5GNRbWcWhMLur+R/7bmyaZy7uPy4A+pU
UezFOo9IagEaF0IMJMD/eB90N7sBq+wzj7XlNuq+K5+2pmwzvNL9jSuFz1M+LKyP
M1hEOGppLvA33k7zKJZuoHmcT1qkbtBeeEzuq4TcQtGz0t1XYD04vMpT9jZY0MVg
TUCcZgLQD+8FUDaQm4wNV9EP0sQJ0EfkwH2IPVjNa+kHhhijg2G+PhlvzRJ+0/Jd
x+6oDwGMQOo7J1UtIs7B0TDReXtmxejJMsQpDiJHZDTBIbrSUlRywwLAUUTx/2PB
7TKSpEjwqWi+Tmiz1guHeLOwoys+UA4jI+B4IZK29hrYNqfdZvRFlSC1rVRKEkTA
YTq0BaKaVPhL8Cq6mE59O0NiNAkJyntKJFv6meXMlYAgmga8EA8ceChPes62O27O
SFrGKpszUVzER/nbiE1zy0AA+jz8m2eZCmzz6cpDNMk8yZcinEgMIvM5hGRNbGfu
chg/GMElyCd5HKEko/1aaffu+YhAV/0X4C1UJ/pInBLAQHTJdOeGiwTiQo4zCyer
8kVigLW6kV3se/fnbAuAGLdrZ9VVPNd9H6QHGxU6OvyN7JVaDxmh/Ke5itkzZKMN
7L6bsAv/UVg8HxocSNrk
=8c1x
-----END PGP SIGNATURE-----

--ZgsjCHEQV+PhxuqO--
