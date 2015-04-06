From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm-mspi: Add support to set serial baud clock
 rate
Date: Mon, 6 Apr 2015 11:54:10 -0700
Message-ID: <5522D652.4020205@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-5-git-send-email-jonathar@broadcom.com> <552037BB.7050803@gmail.com> <20150406094636.GC6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406094636.GC6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 15-04-06 02:46 AM, Mark Brown wrote:
> On Sat, Apr 04, 2015 at 12:12:59PM -0700, Florian Fainelli wrote:
>> Le 02/04/2015 12:23, Jonathan Richardson a =E9crit :
>=20
>>> +		/* Calculate SPBR if clock-frequency provided. */
>>> +		if (of_property_read_u32(dev->of_node, "clock-frequency",
>>> +			&desired_rate) >=3D 0) {
>>> +			u32 spbr =3D clk_get_rate(data->clk) / (2 * desired_rate);
>=20
>> Usually, specifying a "clock-frequency" property is done when there =
is
>> no clock provider available, yet we take this code path only if we c=
ould
>> find a "mspi_clk" which sounds a litle weird.
>=20
>> Once there is a proper "mspi_clk" clock, I would make it mandatory f=
or
>> the clock provider to be able to provide the rate as well?
>=20
> As far as I can tell it's already mandatory if the property is presen=
t -
> it's taking the clock presented to the block and then using an intern=
al
> divider to bring that down to the desired rate.
>=20
> We are missing error handling though.
>=20

Thanks for the review. Yes that's correct. I also tried to make it
backwards compatible with the current version of the driver where you
can ignore configuring the frequency. The result being ref clock
frequency / 2 * 255. If you provide the clock then it will
enable/prepare it. If you also provide clock-frequency then it will
configure the SPBR. If you don't provide anything then it works as
before - it assumes the clock is already enabled and uses the h/w
default SPBR.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
