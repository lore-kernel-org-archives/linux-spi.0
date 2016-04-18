From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH for-next] spi: bcm53xx: add spi_flash_read callback for
 MMIO-based reads
Date: Mon, 18 Apr 2016 13:38:28 +0200
Message-ID: <CACna6rzQfX7SxDoL-CTQp3_Ms5_K54pEa8uaUAiTPjR-un=VOg@mail.gmail.com>
References: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
	<20160418112457.GU3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418112457.GU3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 18 April 2016 at 13:24, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 18, 2016 at 01:10:43PM +0200, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>
>> +static int bcm53xxspi_flash_read(struct spi_device *spi,
>> +                              struct spi_flash_read_message *msg)
>> +{
>> +     struct bcm53xxspi *b53spi =3D spi_master_get_devdata(spi->mast=
er);
>> +     int ret =3D 0;
>> +
>> +     bcm53xxspi_enable_bspi(b53spi);
>> +     memcpy_fromio(msg->buf, b53spi->mmio_base + msg->from, msg->le=
n);
>> +     msg->retlen =3D msg->len;
>
> There's no bounds check here but...

That's true, I was looking at ti_qspi_spi_flash_read and somehow
incorrectly (!) assumed there is a check above. Of course there isn't
one and there can't be, I'll simply fix this code. I guess we should
fix ti_qspi_spi_flash_read in ti-qspi driver as well.

I also realized there wasn't any fallback introduced in:
mtd: devices: m25p80: add support for mmap read request
http://git.infradead.org/l2-mtd.git/commitdiff/08922f644878c9163ada8df3=
ef9def89be1d5e90

What shall we do if spi_flash_read fails? Should we always fallback to
the standard SPI flash read? Or should we standarize error codes
returned by spi_flash_read and fallback on some particular error code
only?


>> +     if (core->addr_s[0])
>> +             b53spi->mmio_base =3D devm_ioremap(dev, core->addr_s[0=
], SZ_32M);
>
> ...we only mapped 32M here.  What if something tries to do a larger
> read?  It's also a bit surprising that we're mapping a specific size
> here rather than the entire resource.

This is based on what I found in Broadcom's SDK (they don't release
any real specifications):
#define SI_NS_FLASH_WINDOW 0x02000000 /* Flash XIP Window */

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
