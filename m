From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 2/3] spi: Add spi driver for Socionext Synquacer platform
Date: Mon, 15 Jan 2018 18:24:45 +0530
Message-ID: <CAJe_ZhdD+pDxCcKEXYKaDOO2Ht-dHuXq4+rfx_s40J3rURvNUA@mail.gmail.com>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
 <1515503448-9025-1-git-send-email-jassisinghbrar@gmail.com> <20180109174141.GF11471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180109174141.GF11471-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 9 January 2018 at 23:11, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 09, 2018 at 06:40:48PM +0530, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>
> This is basically fine, a couple of style things plus the question I had
> on the bindings:
>
>> +++ b/drivers/spi/spi-synquacer.c
>> @@ -0,0 +1,664 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Synquacer HSSPI controller driver
>
> Mixing C and C++ style comments on adjacent lines looks messy, just make
> the whole thing C++.
>
Fixed.

>> +       speed = xfer->speed_hz ? : spi->max_speed_hz;
>> +       bpw = xfer->bits_per_word ? : spi->bits_per_word;
>
> I'm not a big fan of all the ternery operator use in the driver, it's
> not super helpful for legibility.
>
This actually goes away now.

>> +     if (sspi->bpw == 8)
>> +             words = xfer->len / 1;
>> +     else if (sspi->bpw == 16)
>> +             words = xfer->len / 2;
>> +     else
>> +             words = xfer->len / 4;
>
> This should be a switch statement; a safety check for invalid values
> wouldn't go amiss either.
>
ok

Thank you.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
