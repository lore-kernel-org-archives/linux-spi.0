From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v4 09/16] spi: add SPI controller driver for the Atheros
 AR71XX/AR724X/AR913X SoCs
Date: Tue, 04 Jan 2011 13:56:39 +0100
Message-ID: <4D231907.8070302@openwrt.org>
References: <1293994589-6794-1-git-send-email-juhosg@openwrt.org> <1293994589-6794-10-git-send-email-juhosg@openwrt.org> <20110103170211.GA2522@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Brownell <dbrownell@users.sourceforge.net>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20110103170211.GA2522@angua.secretlab.ca>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

2011.01.03. 18:02 keltez=E9ssel, Grant Likely =EDrta:
> On Sun, Jan 02, 2011 at 07:56:22PM +0100, Gabor Juhos wrote:
>> The Atheros AR71XX/AR724X/AR913X SoCs have a built-in SPI controller=
=2E This
>> patch implements a driver for that.
>>
>=20
> Mostly looks okay to me.  A few comments below.  Do you want this one
> merged via my spi tree, or does it depend on other patches in this
> series?  I'm also okay with it going in with the rest of this series.

The driver won't be usable without the preceding patches in the series.
Additionally, further patches depends on this one so it should go via t=
he MIPS tree.

> After addressing comments, feel free to add:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thank you!

>> <...>
>> +struct ath79_spi {
>> +	struct	spi_bitbang	bitbang;
>> +	u32			ioc_base;
>> +	u32			reg_ctrl;
>> +
>> +	void __iomem		*base;
>> +
>> +	struct platform_device	*pdev;
>=20
> This field doesn't seem to actually be used anywhere.

True, i will remove that.

>=20
>> +};
>> +
>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>> +{
>> +	return ioread32(sp->base + reg);
>> +}
>> +
>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg,=
 u32 val)
>> +{
>> +	iowrite32(val, sp->base + reg);
>> +}
>> +
>> +static inline struct ath79_spi *spidev_to_sp(struct spi_device *spi=
)
>=20
> should be ath79_spidev_to_sp()

Ok.

>=20
>> +{
>> +	return spi_master_get_devdata(spi->master);
>> +}
>> +
>> +static void ath79_spi_chipselect(struct spi_device *spi, int is_act=
ive)
>> +{
>> +	struct ath79_spi *sp =3D spidev_to_sp(spi);
>> +	int cs_high =3D (spi->mode & SPI_CS_HIGH) ? is_active : !is_active=
;
>> +
>> +	if (is_active) {
>> +		/* set initial clock polarity */
>> +		if (spi->mode & SPI_CPOL)
>> +			sp->ioc_base |=3D AR71XX_SPI_IOC_CLK;
>> +		else
>> +			sp->ioc_base &=3D ~AR71XX_SPI_IOC_CLK;
>> +
>> +		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
>> +	}
>> +
>> +	if (spi->chip_select) {
>> +		unsigned long gpio =3D (unsigned long) spi->controller_data;
>> +
>> +		/* SPI is normally active-low */
>> +		gpio_set_value(gpio, cs_high);
>> +	} else {
>> +		if (cs_high)
>> +			sp->ioc_base |=3D AR71XX_SPI_IOC_CS0;
>> +		else
>> +			sp->ioc_base &=3D ~AR71XX_SPI_IOC_CS0;
>> +
>> +		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
>> +	}
>> +
>> +}
>> +
>> +static int ath79_spi_setup_cs(struct spi_device *spi)
>> +{
>> +	struct ath79_spi *sp =3D spidev_to_sp(spi);
>> +
>> +	/* enable GPIO mode */
>> +	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
>> +
>> +	/* save CTRL register */
>> +	sp->reg_ctrl =3D ath79_spi_rr(sp, AR71XX_SPI_REG_CTRL);
>> +	sp->ioc_base =3D ath79_spi_rr(sp, AR71XX_SPI_REG_IOC);
>> +
>> +	/* TODO: setup speed? */
>> +	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
>> +
>> +	if (spi->chip_select) {
>> +		unsigned long gpio =3D (unsigned long) spi->controller_data;
>=20
> Casting here is bad practice. =20

It seems that the spi-gpio driver was a bad example. :)

> It would be better to have an explicit ath97_spi_controller_data stru=
cture.

I will add the explicit structure. Expect an updated version soon.

Thanks,
Gabor
