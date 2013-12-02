From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based chipselects
Date: Mon, 2 Dec 2013 23:09:06 +0100
Message-ID: <CAOiHx=krrM+NZ7detAv9_UsB+bUXtKL0m4=pDHO30uduJsDdFg@mail.gmail.com>
References: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
 <CAOiHx=nAcGdk7QgKPrbmkbQYzWL6qNb2cnJj3c_A+9++RrLoeA@mail.gmail.com>
 <1385996099.869286515@f24.i.mail.ru> <CAOiHx=kLkiWjnuUV_1-rVrO-EDQw=Ut0eZE5egYrmiVK9wmxfw@mail.gmail.com>
 <20131202201722.GZ2982@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131202201722.GZ2982-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 2, 2013 at 9:17 PM, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org> wrote:
> On Mon, Dec 02, 2013 at 19:03 +0100, Jonas Gorski wrote:
>>
>> On Mon, Dec 2, 2013 at 3:54 PM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
>> >> On Sun, Dec 1, 2013 at 8:59 AM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
>> >> > This patch takes the CS active level from the GPIO bindings,
>> >> > so we remove the special property "spi-cs-high" for chipselects
>> >> > that use GPIO.
>> > ...
>> >
>> >> > -       cs = devm_kzalloc(&master->dev,
>> >> > -                         sizeof(int) * master->num_chipselect,
>> >> > -                         GFP_KERNEL);
>> >> > -       master->cs_gpios = cs;
>> >> > +       master->cs_gpios = devm_kzalloc(&master->dev, master->num_chipselect *
>> >> > +               (sizeof(int) + sizeof(enum of_gpio_flags)), GFP_KERNEL);
>> >> >
>> >> >         if (!master->cs_gpios)
>> >> >                 return -ENOMEM;
>> >> >
>> >> >         for (i = 0; i < master->num_chipselect; i++)
>> >> > -               cs[i] = -ENOENT;
>> >> > +               master->cs_gpios[i] = -ENOENT;
>> >> >
>> >> >         for (i = 0; i < nb; i++)
>> >> > -               cs[i] = of_get_named_gpio(np, "cs-gpios", i);
>> >> > +               master->cs_gpios[i] =
>> >> > +                       of_get_named_gpio_flags(np, "cs-gpios", i,
>> >> > +                                               &master->cs_gpios_flags[i]);
>> >>
>> >> I don't see you initializing master->cs_gpio_flags anywhere, so won't
>> >> this cause a null/unitialized pointer access?
>> >
>> > A few lines above. Memory is being allocated together with cs_gpios.
>>
>> I see the allocation, but I don't see the assignment of
>> master->cs_gpios_flags. Only master->cs_gpios gets assigned.
>
> It's a side effect of the of_get_named_gpio_flags() call (passing
> the variable by reference).
>
> Don't worry, I felt the same when I read the patch.  Took me a
> while to spot that everything was still in place. :)

I still don't see it. The patch adds an additional pointer member:

> struct spi_master {
>        (...)
>        /* gpio chip select */
>        int                     *cs_gpios;
> +       /* GPIO flags */
> +       enum of_gpio_flags      *cs_gpios_flags;
 };

Then it changes the memory allocation to allocate additional memory for it:

> -       cs = devm_kzalloc(&master->dev,
> -                         sizeof(int) * master->num_chipselect,
> -                         GFP_KERNEL);
> -       master->cs_gpios = cs;
> +       master->cs_gpios = devm_kzalloc(&master->dev, master->num_chipselect *
> +               (sizeof(int) + sizeof(enum of_gpio_flags)), GFP_KERNEL);

But it only assigns the memory pointer to master->cs_gpios, but
master->cs_gpios_flags will still point to whatever it was initialized
to (likely 0), and is never actually set.

Then

> -               cs[i] = of_get_named_gpio(np, "cs-gpios", i);
> +               master->cs_gpios[i] =
> +                       of_get_named_gpio_flags(np, "cs-gpios", i,
> +                                               &master->cs_gpios_flags[i]);

will pass the address of the i-th element of the "array" pointed to by
master->cs_gpio_flags, so basically 0 + (i * sizeof(enum
of_gpio_flags), and not the intended value of (master->cs_gpios +
master->num_chipselect * sizeof(int)) + (i * sizeof(enum
of_gpio_flags).

Unless there is some serious black magic in of_get_named_gpio_flags(),
but I doubt that would be allowed in the kernel ;)

So as far as I can tell there's missing something along

master->cs_gpios_flags = (enum of_gpio_flags
*)&master->cs_gpios[master->num_chipselect];


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
