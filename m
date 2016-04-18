From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH for-next] spi: bcm53xx: add spi_flash_read callback for
 MMIO-based reads
Date: Mon, 18 Apr 2016 19:18:32 +0530
Message-ID: <5714E5B0.2020700@ti.com>
References: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
 <20160418112457.GU3217@sirena.org.uk>
 <CACna6rzQfX7SxDoL-CTQp3_Ms5_K54pEa8uaUAiTPjR-un=VOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACna6rzQfX7SxDoL-CTQp3_Ms5_K54pEa8uaUAiTPjR-un=VOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 04/18/2016 05:08 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 18 April 2016 at 13:24, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Mon, Apr 18, 2016 at 01:10:43PM +0200, Rafa=C5=82 Mi=C5=82ecki wr=
ote:
>>
>>> +static int bcm53xxspi_flash_read(struct spi_device *spi,
>>> +                              struct spi_flash_read_message *msg)
>>> +{
>>> +     struct bcm53xxspi *b53spi =3D spi_master_get_devdata(spi->mas=
ter);
>>> +     int ret =3D 0;
>>> +
>>> +     bcm53xxspi_enable_bspi(b53spi);
>>> +     memcpy_fromio(msg->buf, b53spi->mmio_base + msg->from, msg->l=
en);
>>> +     msg->retlen =3D msg->len;
>>
>> There's no bounds check here but...
>=20
> That's true, I was looking at ti_qspi_spi_flash_read and somehow
> incorrectly (!) assumed there is a check above. Of course there isn't
> one and there can't be, I'll simply fix this code. I guess we should
> fix ti_qspi_spi_flash_read in ti-qspi driver as well.

My assumption was controller will provide ability to map entire flash
under memory mapped region either in oneshot or in parts. It would be
odd to have some parts of flash accessible under memory mapped mode and
some only under SPI mode. Therefore there is no bound check in case of
ti-qspi(but I see is no harm in adding one. I will fix it up).

>=20
> I also realized there wasn't any fallback introduced in:
> mtd: devices: m25p80: add support for mmap read request
> http://git.infradead.org/l2-mtd.git/commitdiff/08922f644878c9163ada8d=
f3ef9def89be1d5e90
>=20
> What shall we do if spi_flash_read fails? Should we always fallback t=
o
> the standard SPI flash read? Or should we standarize error codes
> returned by spi_flash_read and fallback on some particular error code
> only?
>=20

spi_flash_read() can return error for incorrect protocol format
(opcode/data/address_nbits), this will fail anyways for normal SPI mode
as well. Else, its the error code returned by master->spi_flash_read()
callback (individual driver dependent). Not sure what can be
standardized here.
I think fallback would be to try SPI mode when ret!=3D-EINVAL.




--=20
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
