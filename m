From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add driver for IMG SPFI controller
Date: Wed, 12 Nov 2014 23:06:24 +0000
Message-ID: <20141112230624.GA3815@sirena.org.uk>
References: <1415828274-24727-1-git-send-email-abrestic@chromium.org>
 <1415828274-24727-3-git-send-email-abrestic@chromium.org>
 <20141112220740.GR3815@sirena.org.uk>
 <CAL1qeaH1rMcy37vcoHZ9xsmYs5iHz3Pp0GrC7agLmQ4Y7==iTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HmqCnFV+ySQ80OU5"
Cc: James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaH1rMcy37vcoHZ9xsmYs5iHz3Pp0GrC7agLmQ4Y7==iTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HmqCnFV+ySQ80OU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 02:54:57PM -0800, Andrew Bresticker wrote:
> On Wed, Nov 12, 2014 at 2:07 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >>  drivers/spi/spi-img.c | 703 ++++++++++++++++++++++++++++++++++++++++++++++++++

> > How about spi-img-spfi?  That way if someone makes another SPI
> > controller (say a more generic one, this one seems flash specialized)
> > there won't be a collision.

> Despite the name, I believe this controller is used for generic SPI
> stuff as well.  I'm not sure if there is a separate one which is more
> generic (James?).

It would still be better to use a name less impressively generic - this
is an entire company, not even a product line.

> >> +             cpu_relax();

> > Seems random - we already relax in the data transfer?

> We don't relax in the transfers - would that be a better place to put
> it?  I thought it was better here since we reach this point once the
> TX FIFO has filled or RX FIFO has emptied.

Oh, that was the FIFO drain I was thinking of.  I guess here is fine.

> >> +     if (tx_buf)
> >> +             spfi_flush_tx_fifo(spfi);
> >> +     spfi_disable(spfi);

> > What does the enable and disable actually do?  Should this be runtime
> > PM?

> It starts/stops the transfer.  The control registers (bit clock,
> transfer mode, etc.) must be programmed before the enable bit is set
> and the bit does not clear itself upon completion of the transfer.  I
> don't think it makes sense to have this be part of runtime PM.

Perhaps these functions need to be called start() and stop() then - the
names sound like they gate the IP?

> > This will unconditionally claim to have handled an interrupt even if it
> > didn't get any interrupt status it has ever heard of.  At the very least
> > it should log unknown interrupts, ideally return IRQ_NONE though since
> > it seems to be a clear on read interrupt that's a bit misleading.

> There's a clear register actually (see the writel() above), but yes,
> an error and returning IRQ_NONE sound appropriate in the event of an
> unexpected interrupt.

Don't add the error print - the interrupt core has diagnostics already
and it won't be nice if the interrupt ends up shared.  My recommendation
was intended as an either/or.

--HmqCnFV+ySQ80OU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY+fwAAoJECTWi3JdVIfQ8+AH/iKP7McJD0aZPpdX46LKx+HX
KqmdqIQAipOA5CKYEXcSNnX0RbzJ1+odvGgxjnOET0KddT85SWAXqjI9ZAq5gQQQ
Kqj1SdOJ1t6lMXEmePAYlGHiWqSwrGXf+XGemwEfj20UBPmBA0u9VUvTxDYBvXeA
m44PvzhXER2yvhIJd2QOQ15DDU+6CqAMXvK4ESgrfJNWMB2tHNTNRhHsUYSsvuKj
iQAt3X+IpXbzmAnSjW1wVjke5TU/ncowYz0V0pYMeJieB1xluEjMWQNoJCXq9KLl
aG/E9Mk1saDw2Dnx/sf8zD/Oq+1OSgfU+X814KGyy5smROC2cA+6PDxW5yZFIU8=
=tazb
-----END PGP SIGNATURE-----

--HmqCnFV+ySQ80OU5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
