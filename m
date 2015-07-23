From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2 2/5] Documentation: mtd: add a DT property to set the number of dummy cycles
Date: Thu, 23 Jul 2015 09:02:53 +0200
Message-ID: <201507230902.53358.marex@denx.de>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com> <201507221543.54761.marex@denx.de> <55AFCBE9.2030700@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55AFCBE9.2030700-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, July 22, 2015 at 06:59:21 PM, Cyrille Pitchen wrote:
> Hi Marek,
>=20
> Le 22/07/2015 15:43, Marek Vasut a =E9crit :
> > On Wednesday, July 22, 2015 at 03:17:07 PM, Cyrille Pitchen wrote:
> >> Depending on the SPI clock frequency, the Fast Read op code and th=
e
> >> Single/Dual Data Rate mode, the number of dummy cycles can be tune=
d to
> >> improve transfer speed.
> >> The actual number of dummy cycles is specific for each memory mode=
l and
> >> is provided by the manufacturer thanks to the memory datasheet.
> >>=20
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >> ---
> >>=20
> >>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 +++++=
+
> >>  1 file changed, 6 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.t=
xt
> >> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
> >> 2bee68103b01..4387567d8024 100644
> >> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> >>=20
> >> @@ -19,6 +19,11 @@ Optional properties:
> >>                     all chips and support for it can not be detect=
ed at
> >>=20
> >> runtime. Refer to your chips' datasheet to check if this is suppor=
ted by
> >> your chip.
> >> +- m25p,num-dummy-cycles : Set the number of dummy cycles for Fast=
 Read
> >> commands. +                          Depending on the manufacturer
> >> additional dedicated +                          commands are sent =
to the
> >> flash memory so the +                          controller and the =
memory
> >> can agree on the number of +                          dummy cycles=
 to
> >> use.
> >=20
> > Can't you just try negotiating this value at probe time, starting w=
ith
> > some high value and see how low you can get with the negotiations ?=
 This
> > way, you'd be able to effectively auto-detect this value at probe-t=
ime.
> >=20
> > I might be wrong though :)
>=20
> I don't know whether it would be reliable enough. It is the exact sam=
e idea
> as for the latency code used by Spansion QSPI memories. Micron memori=
es
> allow to skip the step of converting the number of dummy cycles into =
a
> latency code, you directly program the right number of dummy cycles i=
nto a
> Micron specific register, the Volatile Configuration Register.
>=20
> However for both manufacturers the number of dummy cycles to use duri=
ng
> Fast Read commands is given though tables found into the memory datas=
heet.
> The number of dummy cycles depends on the Fast Read command, the SPI =
bus
> clock frequency and the Single/Dual Data Rate mode.
>=20
> It should be confirmed by Quad SPI memory manufacturers but since the
> number of dummy cycles depends on the bus clock frequency, I guess th=
e
> values provided by the datasheets are recommendations. I think a too =
low
> value should not be so easy to detect. For a given frequency one Fast=
 Read
> command may succeed whereas the same command with the very same numbe=
r of
> dummy cycles might fail on the next try. To be honest, I'm not sure a=
bout
> the memory behavior in limit conditions so maybe the command will alw=
ays
> succeed or always fail.
>=20
> Also we can't be sure the read data are valid if we don't write them =
first.
> So we would have to save the original data to restore them at the end=
 of
> the probing. Writing data at each probe would also reduce the memory
> lifetime. We should also be aware of the bad blocks, which is more a =
job
> for upper layers.

I see, understood, OK. I really like how you explain those things btw :=
)

> It would be interesting to have some feedbacks from Micron, Spansion =
or
> other QSPI memory manufacturer :)

Definitelly!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
