From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Mon, 2 Jul 2018 19:34:21 +0200
Message-ID: <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sWzj7fEt7Y4w1rr2FIAP8hyaiPz38TJL1"
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>, linux-spi@vger.kernel.org,
        LoRa_Community_Support@semtech.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702161258.GA18744@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sWzj7fEt7Y4w1rr2FIAP8hyaiPz38TJL1
Content-Type: multipart/mixed; boundary="B9CNNcm1k51gNZaMkQ62WgoUvDlLVWStw";
 protected-headers="v1"
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>,
 "David S . Miller" <davem@davemloft.net>,
 Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>,
 =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 Ben Whitten <ben.whitten@lairdtech.com>, Steve deRosier
 <derosier@gmail.com>, linux-spi@vger.kernel.org,
 LoRa_Community_Support@semtech.com
Message-ID: <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
In-Reply-To: <20180702161258.GA18744@sirena.org.uk>

--B9CNNcm1k51gNZaMkQ62WgoUvDlLVWStw
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Mark,

This driver is still evolving, there's newer code on my lora-next branch
already: https://github.com/afaerber/linux/commits/lora-next

The reason you're in CC on this RFC is two-fold:

1) You applied Ben's patch to associate "semtech,sx1301" with spidev,
whereas I am now preparing a new driver for the same compatible.

2) This SPI device is in turn exposing the two SPI masters that you
already found below, and I didn't see a sane way to split that code out
into drivers/spi/, so it's in drivers/net/lora/ here - has there been
any precedence either way?

More inline ...

Am 02.07.2018 um 18:12 schrieb Mark Brown:
> On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:
>=20
>> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enab=
le)
>> +{
>> +	int ret;
>> +
>> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
>> +
>> +	if (enable)
>> +		return;
>> +
>> +	ret =3D sx1301_radio_set_cs(spi->controller, enable);
>> +	if (ret)
>> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
>> +}
>=20
> So we never disable chip select?

Not here, I instead did that in transfer_one below.

Unfortunately there seems to be no documentation, only reference code:

https://github.com/Lora-net/lora_gateway/blob/master/libloragw/src/loragw=
_radio.c#L121
https://github.com/Lora-net/lora_gateway/blob/master/libloragw/src/loragw=
_radio.c#L165

It sets CS to 0 before writing to address and data registers, then
immediately sets CS to 1 and back to 0 before reading or ending the
write transaction. I've tried to force the same behavior in this driver.
My guess was that CS is high-active during the short 1-0 cycle, because
if it's low-active during the register writes then why the heck is it
set to 0 again in the end instead of keeping at 1... confusing.

Maybe the Semtech folks CC'ed can comment how these registers work?

>> +	if (tx_buf) {
>> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_ADDR, tx_=
buf ? tx_buf[0] : 0);
>=20
> This looks confused.  We're in an if (tx_buf) block but there's a use o=
f
> the ternery operator that appears to be checking if we have a tx_buf?

Yeah, as mentioned this RFC is not ready for merging - checkpatch.pl
will complain about lines too long, and TODOs are sprinkled all over or
not even mentioned. It's a Proof of Concept that a net_device could work
for a wide range of spi and serdev based drivers, and on top this device
has more than one channel, which may influence network-level design
discussions.

That said, I'll happily drop the second check. Thanks for spotting!

>> +		if (ret) {
>> +			dev_err(&spi->dev, "SPI radio address write failed\n");
>> +			return ret;
>> +		}
>> +
>> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx=
_buf && xfr->len >=3D 2) ? tx_buf[1] : 0);
>> +		if (ret) {
>> +			dev_err(&spi->dev, "SPI radio data write failed\n");
>> +			return ret;
>> +		}
>=20
> This looks awfully like you're coming in at the wrong abstraction layer=

> and the hardware actually implements a register abstraction rather than=

> a SPI one so you should be using regmap as the abstraction.

I don't understand. Ben has suggested using regmap for the SPI _device_
that we're talking to, which may be a good idea. But this SX1301 device
in turn has two SPI _masters_ talking to an SX125x slave each. I don't
see how using regmap instead of my wrappers avoids this spi_controller?
The whole point of this spi_controller is to abstract and separate the
SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
instead of mixing it into the SX1301 driver - to me that looks cleaner
and more extensible. It also has the side-effect that we could configure
the two radios via DT (frequencies, clk output, etc.).

You will find a datasheet with some diagrams mentioning "SPI" at:
https://www.semtech.com/products/wireless-rf/lora-gateways/SX1301

>> +	if (rx_buf) {
>> +		ret =3D sx1301_read(ssx->parent, ssx->regs + REG_RADIO_X_DATA_READB=
ACK, &rx_buf[xfr->len - 1]);
>> +		if (ret) {
>> +			dev_err(&spi->dev, "SPI radio data read failed\n");
>> +			return ret;
>> +		}
>> +	}
>=20
> For a read we never set an address?

To read, you first write the address via tx_buf, then either in the same
transfer in the third byte or in a subsequent one-byte transfer as first
byte you get the data.

If you have better ideas how to structure this, do let me know.

>> +static void sx1301_radio_setup(struct spi_controller *ctrl)
>> +{
>> +	ctrl->mode_bits =3D SPI_CS_HIGH | SPI_NO_CS;
>=20
> This controller has no chip select but we provided a set_cs operation?

Oops, I played around with those two options and was hoping SPI_NO_CS
would avoid the undesired set_cs invocations, but it didn't work as
expected and so I added the "if (enabled)" check above.

Thanks for your review,

Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)


--B9CNNcm1k51gNZaMkQ62WgoUvDlLVWStw--

--sWzj7fEt7Y4w1rr2FIAP8hyaiPz38TJL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF08DRxvMIhphdW+W+i7RLT5+AT8FAls6YiMACgkQ+i7RLT5+
AT+YUBAAl/FK2qKsblWJ6+otXwCmonR5gi5rkdQgqVaYnd6eAxXrLK4Hrk/05XHZ
oc5DxgsKyMBnP8dBgbR9YCtuNgMg33/9D4IjQyPrJLVNZKnkHADCP5mmtiCGI5mX
6zj504aPUGey3LMrQ2EKFwOmzqWU2JuF8uQpi/1jfKoS+b+TF6FsKv8zfbMll9TC
WPPzbVdV5rBKRbOrZl6eyM6dAi2zwF72rMwK23WIeN1DzLiW0AxfVTyWKIVk44by
OQ8AVegB8ZOEBp9729huKMDN4pfiuhLCkHNe70oNHChVChl+xLAp/jzJyw2YayF6
R7QenizR7PmeWcPVYOsJftYD1c3xlTpMlY9mYDJsEdcUoffDvSAwAd0bKPdpNkw6
1wWe1dcRSrIOUGhc8o42xXvs3J7xYS50bKV9FoZOkJ1tRYwW5dLiTCS3RZvlzyfB
lczmkupUgz4V5qs4F6j/G4kZ1syIQ0uwRC/b55lhgEDrh0JCYC8IGDDWqkH41M3+
0tVADUjQfB3rNFGxoecSwKbJZ87wkcLK6dHy5xKLHbI7CExzN7eVjI4/lcM76hDZ
XHpmf0piqR2Jb0fXWFbEOutrRN3wb+J1EOuNOeio4rxMabwGvU0uAGPXE37cFQGU
KvCrouZ8my7lfPWDDrOP4iC1mVj39dn97ItMX6lay3JPvFgEJJA=
=poSp
-----END PGP SIGNATURE-----

--sWzj7fEt7Y4w1rr2FIAP8hyaiPz38TJL1--
