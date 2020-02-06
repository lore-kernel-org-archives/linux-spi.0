From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Date: Thu, 6 Feb 2020 20:33:33 +0800
Message-ID: <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A@mail.gmail.com>
References: <20200206084443.209719-1-gch981213@gmail.com> <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk> <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 6, 2020 at 8:30 PM Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > It looks like this could just be a transfer_one() operation
> > instead of transfer_one_message() (which is what this is in spite
> > of the name)?  There's nothing custom outside this loop that I
> > can see.
>
> Chipselect is also handled during transfer. Controller asserts
> corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
> is set, controller will deassert chipselect after current transfer is
> done. I need to know whether this is the last transfer and set
> SHIFT_TERM accordingly.

Oh, I remembered that I saw transfer_one function name somewhere and
thought maybe I could shorten the function name a bit. I'll correct
this back to ar934x_spi_transfer_one_message in v2.

Regards,
Chuanhong Guo
