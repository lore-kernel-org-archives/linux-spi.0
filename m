From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm-mspi: Add support to set serial baud clock
 rate
Date: Sat, 04 Apr 2015 12:12:59 -0700
Message-ID: <552037BB.7050803@gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-5-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428002603-21892-5-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Le 02/04/2015 12:23, Jonathan Richardson a =C3=A9crit :
> The driver wasn't setting the SPBR (serial clock baud rate) which cau=
sed
> it to run at the slowest speed possible. The driver now calculates th=
e
> SPBR based on the reference clock frequency resulting in much faster
> SPI transfers.
>=20
> Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---

[snip]

> +	data->clk =3D devm_clk_get(dev, "mspi_clk");
> +	if (!IS_ERR(data->clk)) {
> +		int ret =3D clk_prepare_enable(data->clk);
> +
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable clock: %d\n", ret);
> +			return 0;
> +		}
> +
> +		/* Calculate SPBR if clock-frequency provided. */
> +		if (of_property_read_u32(dev->of_node, "clock-frequency",
> +			&desired_rate) >=3D 0) {
> +			u32 spbr =3D clk_get_rate(data->clk) / (2 * desired_rate);

Usually, specifying a "clock-frequency" property is done when there is
no clock provider available, yet we take this code path only if we coul=
d
find a "mspi_clk" which sounds a litle weird.

Once there is a proper "mspi_clk" clock, I would make it mandatory for
the clock provider to be able to provide the rate as well?
--
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
