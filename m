From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as "spidev"
Date: Thu, 23 Apr 2015 09:21:23 +0200
Message-ID: <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427499742-26916-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 28.03.2015, at 00:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> Since spidev is a detail of how Linux controls a device rather than a
> description of the hardware in the system we should never have a node
> described as "spidev" in DT, any SPI device could be a spidev so this
> is just not a useful description.
>=20
> In order to help prevent users from writing such device trees generat=
e a
> warning if spidev is instantiated as a DT node without an ID in the m=
atch
> table.
>=20
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

So what is now the =E2=80=9Ccorrect way=E2=80=9D to create a spidev dev=
ice via the
device-tree?=20

There is no update in Documentation/spi/spidev how to achieve this in
a =E2=80=9Ccorrect=E2=80=9D manner besides using board_info and the men=
tioned possible
sysfs approach, which is not implemented as an alternative.

If I still put spidev into the device-tree - as there is not other way
to do it as far as I known - then it produces an issue:
[  328.255338] spidev spi32765.1: buggy DT: spidev listed directly in D=
T
[  328.255399] ------------[ cut here ]------------
[  328.255443] WARNING: CPU: 0 PID: 2968 at drivers/spi/spidev.c:730 sp=
idev_probe+0x198/0x1e4 [spidev]()
[  328.255457] Modules linked in: spidev(+) spi_bcm2835 bcm2835_wdt bcm=
2835_dma virt_dma
=2E.. lots more lines with stack-trace ...

So it is just a warning triggered by:
                 WARN_ON(spi->dev.of_node &&
                         !of_match_device(spidev_dt_ids, &spi->dev));

But still it is =E2=80=9Cirritating=E2=80=9D as, it produces lots of me=
ssages in dmesg.

Note that on a raspberry pi the 2 SPI devices are by default configured=
=20
as spidev and only overlays would change the settings to a different
alias. So this change will impact that default immediately.

Thus I wonder if it is wise to produce potential =E2=80=9Csupport issue=
s" for=20
distributions triggered by this patch.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
