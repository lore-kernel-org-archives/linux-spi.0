From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH 3/4] spi: bcm-mspi: Make BCMA optional to support non-BCMA
 chips
Date: Mon, 6 Apr 2015 12:09:26 -0700
Message-ID: <5522D9E6.3080008@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-4-git-send-email-jonathar@broadcom.com> <CAHp75VcMg-8X8DtHbQrmugzWG5VzzHXcpWNiyrTT=qmuCvA95w@mail.gmail.com> <551ED345.1000702@gmail.com> <CACna6ry9qxzY9xaaqR8K6XgSEun31c=d1XrWH_vk7Fq7fJTxoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree <devicetree@vger.kernel.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6ry9qxzY9xaaqR8K6XgSEun31c=d1XrWH_vk7Fq7fJTxoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15-04-06 03:36 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 3 April 2015 at 19:52, Florian Fainelli <f.fainelli@gmail.com> wro=
te:
>> On 03/04/15 06:38, Andy Shevchenko wrote:
>>> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
>>> <jonathar@broadcom.com> wrote:
>>>> The Broadcom MSPI controller is used on various chips. The driver =
only
>>>> supported BCM53xx chips with BCMA (an AMBA bus variant). The drive=
r is
>>>> refactored to make BCMA optional and provides a new config for non=
 BCMA
>>>> systems.
>>>
>>>>  struct bcm_mspi {
>>>> +       #ifdef CONFIG_SPI_BCMA_MSPI
>>>>         struct bcma_device *core;
>>>> -       struct spi_master *master;
>>>> +       #endif
>>>>
>>>> +       void __iomem *base;
>>>> +       struct spi_master *master;
>>>>         size_t read_offset;
>>>
>>>> +       void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 =
value);
>>>> +       u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
>>>> +};
>>>
>>> To avoid ugly ifdefs I think better to split driver to core part an=
d
>>> the actual driver part, at the end you will have something like
>>> mspi-core.c mspi-53xx.c mspi-whatever.c. Check for example spi-dw*.=
c
>>
>> Actually, I am really curious whether we need the special BCMA I/O
>> accessors in the first place, cannot we just access the MSPI core on
>> BCM53xx chips using regular MMIO? That would probably solve the
>> "problem" entirely. Rafal, did you try this before?
>=20
> It's a matter of choice between:
> 1) Using one design for all bcma users
> 2) Using one design for all bcm-mspi users
> I believe no matter which one you choose, you'll break another one.
>=20
> If you take a look at drivers/bcma/host_soc.c, you'll see we've there
> core->io_addr. I guess you could use it as the base in bcm-mspi. That
> of course will make you a bit less compatible with other bcma drivers
> (skipping bcma R/W layer).

That would require compiling in BCMA for a driver/chip that doesn't use
BCMA but then I could do DT parsing in init only anyway. I don't think
that's really an option so I'm going to leave as is unless there is
further opinion on it.

>=20
>=20
>> As for splitting the driver into a "library" driver which is mostly
>> independent from the bus and a bus-specific wrapper, I think BCMA is
>> really the only special case here, which is why I suggested earlier =
to
>> Jonathan that we might just prefer ifdefing things out instead of
>> creating a separate layer just for BCMA.
>=20
> I think you may be right, this #if for bcma shouldn't be that bad and
> it shouldn't grow in the future.
> Still, I'd like to get this patch split nicely to review independent =
changes.
>=20

Making BCMA optional was made possible by using DT. I'm not sure I coul=
d
split it into two commits. I would have to add a hard coded SPI device
for non-BMCA as well. I thought the driver was a bit odd in that this
was hard coded. Normally this should be in a separate driver. How would
you use it if you wanted to use m25p80 for example?
