From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
Date: Mon, 3 Feb 2020 11:50:42 +0200
Message-ID: <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz> <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200131023433.12133-3-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 31, 2020 at 4:34 AM Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
>
> Add a SPI device driver that sits in-band and provides a SPI controller
> which supports chip selects via a mux-control. This enables extra SPI
> devices to be connected with limited native chip selects.

Thanks for an update, my comments below.

...

>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #

> +#

Redundant line.

...

> +/*
> + * General Purpose SPI multiplexer
> + */

I think Mark wants to have this in one line with C++ style of comments.

...

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mux/consumer.h>

Perhaps sorted?

...

> +       /* do the transfer */
> +       ret = spi_async(priv->spi, m);
> +       return ret;

return spi_async(...);

...


> +       priv->mux = devm_mux_control_get(&spi->dev, NULL);

> +       ret = PTR_ERR_OR_ZERO(priv->mux);

This is a bit complicated.

> +       if (ret) {

Why not simple do

  if (IS_ERR(priv->mux)) {
    ret = PTR_ERR(...);
    ...
  }

?

> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&spi->dev, "failed to get control-mux\n");
> +               goto err_put_ctlr;
> +       }

> +       ctlr->dev.of_node = spi->dev.of_node;

I'm wondering why SPI core can't handle this by default (like GPIO
subsystem does).

> +       ret = devm_spi_register_controller(&spi->dev, ctlr);
> +       if (ret)
> +               goto err_put_ctlr;
> +

> +       return ret;

return 0;

...

> +static const struct of_device_id spi_mux_of_match[] = {
> +       { .compatible = "spi-mux" },
> +       { },

Comma is not needed in terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
