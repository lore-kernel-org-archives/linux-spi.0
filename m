From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for Atmel QSPI controller
Date: Mon, 24 Aug 2015 19:45:33 +0200
Message-ID: <201508241945.33577.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <201508241303.52066.marex@denx.de> <55DB4EA6.9090807@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55DB4EA6.9090807-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday, August 24, 2015 at 07:04:38 PM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 24/08/2015 13:03, Marek Vasut a =E9crit :
> > On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> >> This driver add support to the new Atmel QSPI controller embedded =
into
> >> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> >> controller.

[...]

> >> +	/* Compute address parameters */
> >> +	switch (cmd->enable.bits.address) {
> >> +	case 4:
> >> +		ifr |=3D QSPI_IFR_ADDRL;
> >> +		/*break;*/ /* fallback to the 24bit address case */
> >=20
> > What's this commented out bit of code for ? :-)
>=20
> I just wanted to stress out there was no missing "break;".
> I've reworded the comment to:
> /* No "break" on purpose: fallback to the 24bit address case. */

Oh, the address is in bytes . I see, yes, it makes sense to be more
explicit here about the purpose of the fallback. I think this change
in the comment will make it easier for everyone who comes back in a
few years and reads this code.

> >> +	case 3:
> >> +		iar =3D (cmd->enable.bits.data) ? 0 : cmd->address;
> >> +		ifr |=3D QSPI_IFR_ADDREN;
> >> +		break;
> >> +	case 0:
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >=20
> > [...]
> >=20
> >> +no_data:
> >> +	/* Poll INSTRuction End status */
> >> +	sr =3D qspi_readl(aq, QSPI_SR);
> >> +	if (sr & QSPI_SR_INSTRE)
> >> +		return err;
> >> +
> >> +	/* Wait for INSTRuction End interrupt */
> >> +	init_completion(&aq->completion);
> >=20
> > You should use reinit_completion() in the code. init_completion()
> > should be used only in the probe() function and nowhere else.
>=20
> Alright. In the next version I'll rename the "completion" member of
> struct atmel_qspi into "cmd_completion". Also I'll add another
> dma_completion member in this very same structure to replace the loca=
l
> "struct completion completion" in atmel_qspi_run_dma_transfer().
>=20
> Then I'll call init_completion() on both cmd_completion and dma_compl=
etion
> only from atmel_qspi_probe() and reinit_completion() elsewhere.
>=20
> >> +	aq->pending =3D 0;
> >> +	qspi_writel(aq, QSPI_IER, QSPI_SR_INSTRE);
> >> +	if (!wait_for_completion_timeout(&aq->completion,
> >> +					 msecs_to_jiffies(1000)))
> >> +		err =3D -ETIMEDOUT;
> >> +	qspi_writel(aq, QSPI_IDR, QSPI_SR_INSTRE);
> >> +
> >> +	return err;
> >> +}
> >=20
> > [...]
> >=20
> > Hope this helps :)
>=20
> Indeed, it does! I still work on the next version of this series to t=
ake
> all your comments into account.

Thanks :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
