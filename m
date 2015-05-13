From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Add option to bind spidev to all chipselects
Date: Wed, 13 May 2015 12:40:58 +0200
Message-ID: <CAOMqctSHvP5_RHr6Xi5tz3mUbD1RBdkaVMAN0tvfN3Xgdn9Uiw@mail.gmail.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513093441.80359.qmail@dec59.ruk.cuni.cz> <20150513101625.GY10961@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513101625.GY10961@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13 May 2015 at 12:16, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> On Wed, May 13, 2015 at 09:34:41AM -0000, Michal Suchanek wrote:
>> Bypass the check if CS is in use for spidev devices if CONFIG_SPIDEV_SHADOW is
>> set.  Rename spidev devices to avoid sysfs conflict.
>>
>> This allows dynamically loading SPI device overlays or communicating
>> with SPI devices configured by a kernel driver from userspace.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Output from checkpatch:
> total: 2 errors, 4 warnings, 4 checks, 157 lines checked
>
> ...
>
> I told you a few times already to run checkpatch before sending your
> patches, apparently you make a point at ignoring me. Fine.

That's a good idea to run, yes.

Sorry about that.

I also discovered an additional issue with unused variable when the
config option is set.

>
> That being said, I'm not sure this is the right approach, or at least,
> it doesn't solve anything. If SPIDEV_SHADOW is not set, you will still
> have the same issue with addition of new devices on previously unused
> chip selects, and where we have an spidev device now.
>
> What I think we should do is, when a new device is created, we just
> lookup the modalias of the spi_device associated to it.
>
> If that modalias is "spidev", then unregister the spidev device,
> register the new device, you're done. If not, return an error.

Yes, that's what I intend to look into eventually. However, this patch
is still useful and allows both accessing unused bus with spidev and
dynamically loading overlays that would use the bus.

>
> On the SPIDEV_SHADOW stuff itself, I'm not sure this is such a good
> idea. There's a good chance it will break the driver by doing stuff
> behind its back, possibly in a way that will harm the whole kernel,
> and it's something we usually try to avoid.

What is the possibility to harm the whole kernel?

If the kernel crashes because the device misses a message this is
somewhat worrying.

You could see it as a developer option similar to SCSI error injection
and others that can introduce states that would normally occur only
rarely.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
