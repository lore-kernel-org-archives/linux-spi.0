From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spidev: fix the check for spidev in dt
Date: Sun, 26 Jun 2016 04:12:10 +0200
Message-ID: <CAOMqctR3MDijTSr0=7tiHK+exygrGLbLQQ=GF_KAH-Y2xvb1Nw@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
 <20160626011315.GE28202@sirena.org.uk>
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
In-Reply-To: <20160626011315.GE28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26 June 2016 at 03:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 23, 2016 at 05:41:19PM -0000, Michal Suchanek wrote:
>
>> The check is supposed to warn about spidev specified directly in
>> devicetree as compatible. This just does not work. I have a devicetree
>> with no compatible whatsoever and hacked my kernel so I can manually
>> bind spidev. This still triggers.
>
> Well, a DT device won't instantiate without a compatible string...
> could you please explain exactly what makes you say this won't work?

That's because the whitelist concept for this check is completely broken.

Without any patches whatsoever I should be able to specify m25p80
binding in the DT, let the kernel create the device, unbind the
driver, and bind spidev.

Then I have the jedec,spi-nor compatible which is not on the whitelist.

>
>> Also I have no idea how this could have build with ! CONFIG_OF since the
>> id table which the code checks is not compiled then.
>
> of_match_device() compiles out when !OF.
>
>> +static const struct of_device_id spidev_check[] = {
>> +                     { .compatible = "spidev" },
>> +                     {}
>> +};
>
> The indentation here is completely non-standard.
>
>> -     if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
>> +     if (spi->dev.of_node && of_match_device(spidev_check, &spi->dev)) {
>
> I think what you intend to say in the commit message is that you want to
> change from a whitelist to a blacklist since that is what the code says,
> but like I say we also need an explanation of the logic behind such a
> change.

It's because the check kernel log message says it's a blacklist and
it's incorrectly implemented as a whitelist.

The change is to correct that.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
