From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/4] spi: Use Apple device properties in absence of
 ACPI resources
Date: Wed, 28 Jun 2017 22:14:23 +0300
Message-ID: <CAHp75Ved89cCzTCt-7VnNp+xAgpkFxUmG2v9=5Mn=VBB_WzD5A@mail.gmail.com>
References: <cover.1498636759.git.lukas@wunner.de> <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 28, 2017 at 8:20 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> for SPI slaves, causing device initialization to fail.  Most of the
> information that would normally be conveyed via _CRS is available
> through ACPI device properties instead, so take advantage of them.

> spiSclkPeriod   /* period in ns */

> +#include <linux/math64.h>

> +       if (!acpi_dev_get_property(dev, "spiSclkPeriod", ACPI_TYPE_BUFFER, &o))
> +               spi->max_speed_hz  = div64_u64(NSEC_PER_SEC,
> +                                              *(u64 *)o->buffer.pointer);

Why do you need 64 bit division here? It's obviously 32. It makes
nonsense to have variable more than NSEC_PER_SEC (if one paranoid
enough it could be checked).

> +       if (!acpi_dev_get_property(dev, "spiWordSize", ACPI_TYPE_BUFFER, &o))
> +               spi->bits_per_word = *(u64 *)o->buffer.pointer;
> +

> +       if (!acpi_dev_get_property(dev, "spiBitOrder", ACPI_TYPE_BUFFER, &o) &&
> +           !*(u64 *)o->buffer.pointer)

In such cases I would prefer the notation like
ret = func();
if (!ret && ...)
 ...

Also we usually name object variable as obj, though it's minor here.

> +               spi->mode |= SPI_LSB_FIRST;

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
