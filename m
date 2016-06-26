From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 04:23:41 +0200
Message-ID: <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160626011500.GF28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 June 2016 at 03:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 05:41:20PM -0000, Michal Suchanek wrote:
>> SPI slave devices are not created when looking up driver for the slave
>> fails. Create a device anyway so it can be manually bound to a driver.
>
>> @@ -1543,11 +1542,10 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
>>       /* Device speed */
>>       rc = of_property_read_u32(nc, "spi-max-frequency", &value);
>>       if (rc) {
>> -             dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
>> +             dev_warn(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
>>                       nc->full_name, rc);
>> -             goto err_out;
>> -     }
>> -     spi->max_speed_hz = value;
>> +     } else
>> +             spi->max_speed_hz = value;
>>
>
> I can't relate this hunk to the changelog and there's a coding style
> problem, if there's { } on one side of an if statement it should be on
> both sides.  Why are we making this change?

The intention is that you can specify that your SPI master controller
has a CS available without setting up the slave

&spi2 {
        pinctrl-names = "default";
        pinctrl-0 = <&spi2_pins_a>,
                    <&spi2_cs0_pins_a>;
        status = "okay";

        uext_spi: spi@uext {
                reg = <0>;
        };
};

Then you can amend the slave node with an overlay or bind a driver
that can deal with the node having no configuration.

The check here isn't very effective anyway since slaves with zero
speed somehow creep into the kernel. I have seen people reporting
division by zero in SPI master driver as a result. The proper way to
fix this is to specify the master minimum and maximum speed limit so
the SPI core can reject transfers with speed outside of the allowed
range.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
