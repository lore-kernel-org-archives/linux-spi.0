From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based chipselects
Date: Mon, 2 Dec 2013 19:03:57 +0100
Message-ID: <CAOiHx=kLkiWjnuUV_1-rVrO-EDQw=Ut0eZE5egYrmiVK9wmxfw@mail.gmail.com>
References: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
 <CAOiHx=nAcGdk7QgKPrbmkbQYzWL6qNb2cnJj3c_A+9++RrLoeA@mail.gmail.com> <1385996099.869286515@f24.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385996099.869286515-/wTItXjRvv7WO3iv0lnsqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 2, 2013 at 3:54 PM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
>> On Sun, Dec 1, 2013 at 8:59 AM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
>> > This patch takes the CS active level from the GPIO bindings,
>> > so we remove the special property "spi-cs-high" for chipselects
>> > that use GPIO.
> ...
>
>> > -       cs = devm_kzalloc(&master->dev,
>> > -                         sizeof(int) * master->num_chipselect,
>> > -                         GFP_KERNEL);
>> > -       master->cs_gpios = cs;
>> > +       master->cs_gpios = devm_kzalloc(&master->dev, master->num_chipselect *
>> > +               (sizeof(int) + sizeof(enum of_gpio_flags)), GFP_KERNEL);
>> >
>> >         if (!master->cs_gpios)
>> >                 return -ENOMEM;
>> >
>> >         for (i = 0; i < master->num_chipselect; i++)
>> > -               cs[i] = -ENOENT;
>> > +               master->cs_gpios[i] = -ENOENT;
>> >
>> >         for (i = 0; i < nb; i++)
>> > -               cs[i] = of_get_named_gpio(np, "cs-gpios", i);
>> > +               master->cs_gpios[i] =
>> > +                       of_get_named_gpio_flags(np, "cs-gpios", i,
>> > +                                               &master->cs_gpios_flags[i]);
>>
>> I don't see you initializing master->cs_gpio_flags anywhere, so won't
>> this cause a null/unitialized pointer access?
>
> A few lines above. Memory is being allocated together with cs_gpios.

I see the allocation, but I don't see the assignment of
master->cs_gpios_flags. Only master->cs_gpios gets assigned.


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
