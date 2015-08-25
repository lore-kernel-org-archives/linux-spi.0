From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
Date: Tue, 25 Aug 2015 11:46:08 +0200
Message-ID: <CAOiHx=kExyKAoGW4ciWHHxGNosNR0VdvHHrSqeo7RH1rNOXgig@mail.gmail.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de> <55DB4EA6.9090807@atmel.com> <201508241945.33577.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Bean Huo (beanhuo)" <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201508241945.33577.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Aug 24, 2015 at 7:45 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> On Monday, August 24, 2015 at 07:04:38 PM, Cyrille Pitchen wrote:
>> Hi Marek,
>
> Hi!
>
>> Le 24/08/2015 13:03, Marek Vasut a =C3=A9crit :
>> > On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
>> >> This driver add support to the new Atmel QSPI controller embedded=
 into
>> >> sama5d2x SoCs. It expects a NOR memory to be connected to the QSP=
I
>> >> controller.
>
> [...]
>
>> >> +  /* Compute address parameters */
>> >> +  switch (cmd->enable.bits.address) {
>> >> +  case 4:
>> >> +          ifr |=3D QSPI_IFR_ADDRL;
>> >> +          /*break;*/ /* fallback to the 24bit address case */
>> >
>> > What's this commented out bit of code for ? :-)
>>
>> I just wanted to stress out there was no missing "break;".
>> I've reworded the comment to:
>> /* No "break" on purpose: fallback to the 24bit address case. */
>
> Oh, the address is in bytes . I see, yes, it makes sense to be more
> explicit here about the purpose of the fallback. I think this change
> in the comment will make it easier for everyone who comes back in a
> few years and reads this code.

I think you are looking for the term "(switch case) fallthrough", not
"fallback". "Fallback" makes it sound like there is something missing,
or an invalid state.


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
