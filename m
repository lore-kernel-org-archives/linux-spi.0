From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: support adding delay between transmission
Date: Fri, 22 Aug 2014 16:33:09 +0300
Message-ID: <53F74695.3010902@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com> <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com> <20140821182035.GM24407@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<m-karicheri2-l0cyMroinI0@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140821182035.GM24407-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 08/21/2014 09:20 PM, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:25:06PM +0300, Grygorii Strashko wrote:
>=20
>> +- ti,davinci-spi-wdelay : delay between transmissions.
>=20
> I don't understand why this is here - there is already standard suppo=
rt
> in the SPI core for client drivers specifying inter-transfer delays. =
 If
> there is a need to provide platform configuration for this in additio=
n
> to that then it should also be a standard property, there is nothing
> device specific about these.

Sorry, may be I've missed smth, because I was not able to find such com=
mon=20
property in SPI bindings document and code. Could you point me on, pls?

In our case it's hardware delay applied between transmissions:
"Delay in between transmissions. Idle time that will be applied at
 the end of the current transmission if the bit WDEL is
set in the current buffer. The delay to be applied is equal to:
WDELAY =D7 PSPI module clock + 2 =D7 PSPI module clock
 PSPI module clock -> Period of SPI module clock"

>=20
>> +- ti,davinci-spi-odd-parity : odd partity enabled
>> +   OR
>> +  ti,davinci-spi-even-parity : even parity enabled
>=20
> What do these mean?

Supported by OMAP-L138/da830:
"
SPIFMTn[23].PARPOL - Parity polarity: even or odd. PARPOL can be modifi=
ed in privilege mode only.
 0 An even parity flag is added at the end of the transmit data stream.
 1 An odd parity flag is added at the end of the transmit data stream.

SPIFMTn[22].PARENA - Parity enable.
 0 - No parity generation/ verification is performed.
 1 - A parity is transmitted at the end of each transmit data stream. A=
t the end of a transfer the parity
 generator compares the received parity bit with the locally calculated=
 parity flag. If the parity bits do
 not match the PARERR flag is set in the corresponding control field. T=
he parity type (even or odd)
 can be selected via the PARPOL bit.
"

>=20
>> +- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.=
h)
>=20
> The bindings should be independent of the kernel, the values need to =
be
> included here (and the defines moved to include/dt-bindings so they c=
an
> be used when writing DTs).

Allowed values here are:
#define SPI_IO_TYPE_INTR	0
#define SPI_IO_TYPE_POLL	1
#define SPI_IO_TYPE_DMA		2

I'll update.

>=20
>> +- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
>> +- ti,davinci-spi-c2t-delay: c2t delay
>> +- ti,davinci-spi-t2c-delay: t2c delay
>> +- ti,davinci-spi-t2e-delay: t2e delay
>> +- ti,davinci-spi-c2e-delay: c2e delay
>=20
> What are all these timers/delays - at least some reference to the
> datasheet please?
>=20

Sorry, I'll update bindings with links on datasheet.

Keystone 2:
http://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf

Davinci:
dm644x - http://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf

Regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
