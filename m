From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Writing SPI flash driver for Broadcom BCM53xx ARM SoC
Date: Fri, 1 Aug 2014 19:00:36 -0700
Message-ID: <20140802020036.GR3711@ld-irv-0074>
References: <CACna6rzhD9=Pkb5gRqd9A23gfaqnHmYe_vm0fwT_mefAibmhYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Andre Renaud <andre-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rzhD9=Pkb5gRqd9A23gfaqnHmYe_vm0fwT_mefAibmhYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Mark, linux-spi, Huang

(Mark, this is the hardware I was talking to you about at ELC!)

Hi Rafal,

On Wed, Jul 30, 2014 at 11:27:15AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> I own BCM53010 (AKA BCM4708) based router which has (obviously) a
> flash memory. Only part of this chip is visible to me (because of the
> radiator), but I read a following label: winbond 25Q128FVFG (it's
> barely visible). Broadcom documents this flash as:
> /* ST M25FL128 128 Mbit Serial Flash */

When I look up the Winbond part number, its datasheet looks relatively
sane. Although sometimes, manufacturers are known to make very similar
parts (both ID and part numbering) that behave quite differently.

One note: the 'FVFG' extension seems to indicate a part which has QE=3D=
1
(Quad Enable) on by default. I don't think this means the part is in QP=
I
mode by default -- just that it's ready to accept the quad-enable
command.

> It seems that Broadcom ARM SoCs use real SPI to access flashes.

I believe the SPI core in this SoC actually has a 2 parts to it -- a 'B=
oot
SPI' (BSPI) portion which is designed for read-only and can handle a fe=
w
clock rates and I/O configurations (dual, quad); and a single-I/O MSPI
(I forget what it stands for) that handles true SPI access. MSPI is use=
d
for everything that's not a {NORMAL,FAST,DUAL,QUAD}_READ.

> I played a bit with this flash and it:
> 1) Doesn't respond to SPINOR_OP_RDID (no JEDEC), returns all zeroes

That's troubling. (But your right, it matches the SST driver.)

> 2) Responds to 0x90 command (SST25L_CMD_READ_ID) with 0xEF 0x17. Or i=
f
> you prefer longer read: 0xEF 0x17 0xEF 0x17 0xEF.

OK. Sane flashes seem to document 0x90 as a legacy alternative to 0x9F
RDID. So that makes some sense.

> I checked Broadcom code and it treats 0xEF (NXPART) as: /* ST compati=
ble */

0xEF matches the Winbond code.

> So far it seems there is some compatibility between Broadcom ARM flas=
h
> support and the sst25l.c.

Only the lack of JEDEC 0x9F RDID is similar.

> I decided to compared erasing flash memory.
>=20
>=20
> *** Erasing in Broadcom code ***
>=20
> mspi_disable_bspi [controller specific]

I believe this is the main portion that does not act like a SPI
controller. It's a lock-like operation that switches from read mode
(BSPI) to 'everything else' mode (MSPI).

> write WREN command (0x06)
>=20
> write 0x20 xor 0xD8 xor 0x21 xor 0xDC and offset
> wait for RDSR command (0x05) & 0x1 being 0
>=20
> write WRDI command (0x04)
> mspi_enable_bspi [controller specific]

Aside from the MSPI/BSPI, this all matches m25p80.c/spi-nor.c.

> *** Erasing in sst25l_erase ***
>=20
> wait for RDSR command (0x05) & 0x1 being 0
> write WREN command (0x06)
> write EWSR command (0x50)
> write WRSR and 0 commands (0x01 and 0x00)
> check RDSR command (0x05) for having WREN (0x2)
>=20
> write 0x20 and offset
> wait for RDSR command (0x05) & 0x1 being 0
>=20
> write WRDI command (0x04)
> write EWSR command (0x50)
> write WRSR and BP0 and BP1 commands (0x04 and 0x08)
> check RDSR command (0x05) for having WREN (0x2)
>=20
>=20
> Again, some compatibility, but not really enough for us. First of all
> I'm not sure if Broadcom flash is going to accept these extra command=
s
> when enabling/disabling writes (EWSR, WRSR). Not sure what they are
> about.

I don't think we want to try using sst25l for this. The only reason is
that it uses the 0x90 legacy RDID (or as some newer datasheets I see
call it: "Read Electronic Manufacturer and device Signature (REMS)".

> I see sst25l_erase is also lacking support for some extra erase
> commands:
> #define SPI_SE_CMD 0xD8 (for block size 0x10000 and up)
> #define SPAN_FLASH_4P4E 0x21 (for new SPAN devices with block size < =
0x10000)
> #define SPAN_FLASH_4SE 0xDC (for new SPAN devices with bigger  block =
size)
> (on the other hand 0xD8 and 0xDC are used in spi-nor.c / m25p80.c).
>=20
> What's worse, I have no idea how I could add controller-specific call=
s
> in the flash driver (mspi_disable_bspi / mspi_enable_bspi).

Yes, that's the tricky part.

> Btw. I took a look at m25p80_erase and it also seems so be a bit
> similar... These differences between sst25l.c and m25p80.c seem a bit
> tiny to me.

I don't know the history here, but it seems like sst25l.c mostly exists
because a couple of the command sequences were different -- most
notably, the 0x90 vs. 0x9f RDID commands.

> So in this situation... do you have an idea how I could implement
> flash driver for Broadcom ARM SoCs? I wanted to use SPI subsystem and
> re-use existing SPI flash drivers, but it seems a bit tricky now.
> Should I write a standalone MTD driver handling SPI communication on
> it's own?

You can probably write a pure SPI driver (drivers/spi/) that uses only
the MSPI hardware to do (slow, single-I/O) true SPI, and hooks into
m25p80.c.

But if you want to integrate the accelerated BSPI for reads, it gets
harder. You might be able to export a kind of 'lock' API from the MSPI
driver, so that a BSPI driver can utilize the MSPI for most
transactions, but then lock it down when doing BSPI/read operations. I
think with a little bit of work, spi-nor.c can accomodate the right kin=
d
of callbacks to allow you to do this. But the coordination between
drivers/spi/<MSPI> and drivers/mtd/spi-nor/<BSPI> would be the hardest
to architect, I think.

> You can see Broadcom's spiflash.s in DD-WRT sources:
> http://svn.dd-wrt.com/browser/src/linux/universal/linux-3.10/brcm/arm=
/shared/spiflash.c

(FWIW, I have a MSPI/BSPI driver here at Broadcom that fakes being a
drivers/spi/ driver, and it just intercepts the opcodes that look like
m25p80.c read commands, kinda like Huang was doing with his
fsl-quadspi.c. The faking kinda sucks, but it might be a good reference
to compare with. I can see about posting it sometime.)

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
