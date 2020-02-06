From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Date: Thu, 6 Feb 2020 20:30:21 +0800
Message-ID: <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
References: <20200206084443.209719-1-gch981213@gmail.com> <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200206113158.GK3897-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 6, 2020 at 7:31 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, Feb 06, 2020 at 04:44:42PM +0800, Chuanhong Guo wrote:
>
> This looks good, just a couple of comments below:
>
> > --- /dev/null
> > +++ b/drivers/spi/spi-ar934x.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SPI controller driver for Qualcomm Atheros AR934x/QCA95xx SoCs
>
> Please make the entire comment block a C++ one so things look
> more intentional.

Got it. I'll do this in v2.

>
> > +static int ar934x_spi_transfer_one(struct spi_controller *master,
> > +                                struct spi_message *m)
> > +{
> > +     struct ar934x_spi *sp = spi_controller_get_devdata(master);
> > +     struct spi_transfer *t = NULL;
>
> ...
>
> > +
> > +     m->actual_length = 0;
> > +     list_for_each_entry(t, &m->transfers, transfer_list) {
>
> It looks like this could just be a transfer_one() operation
> instead of transfer_one_message() (which is what this is in spite
> of the name)?  There's nothing custom outside this loop that I
> can see.

Chipselect is also handled during transfer. Controller asserts
corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
is set, controller will deassert chipselect after current transfer is
done. I need to know whether this is the last transfer and set
SHIFT_TERM accordingly.

Regards,
Chuanhong Guo
