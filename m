From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: of: allow instantiating slaves without a driver
Date: Sat, 30 Jul 2016 19:45:10 +0200
Message-ID: <CAOMqctTRon3mqswhPnWeTvdKUvyU=4kefd737bwBrzvc-ssZ1w@mail.gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com> <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach@gmail.com>
 <20160718230234.GX30372@sirena.org.uk> <CAOMqctS0+eaufGdsGV96h3SJCOGrjhaAL1aRxxkMRtpK_p_3YQ@mail.gmail.com>
 <20160719105212.GA30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160719105212.GA30372-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 19 July 2016 at 12:52, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jul 19, 2016 at 10:31:54AM +0200, Michal Suchanek wrote:
>> On 19 July 2016 at 01:02, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Tue, Jul 19, 2016 at 12:35:41AM +0200, Michal Suchanek wrote:
>
>> >> SPI slave devices are not created when looking up driver for the slave
>> >> fails. Create a device anyway so it can be used with spidev.
>
>> > Nothing has change since you last sent this patch which converts
>> > of_modailias_node() into something which looks up a driver so the
>> > patch description still fails to describe what the patch is doing.
>
>> I have split the other part of the patch. Regarding the commit message
>> if you have suggestion for better wording please do share it.
>
> As covered in SubmittingPatches your commit message should describe what
> the change does and what the intended effect is.  If we were looking for
> a device driver the code would be looking up a struct device_driver or
> some other struct that contains one.
>
>> From my point of view the conceptual change described in the commit message
>> is that whenever SPI slave node is encountered in devicetree you get either
>> a device with active driver or a device with no driver whereas
>> previously you either
>> got a device with active driver or no device. So yes, it's about
>
> This is not the case, it is perfectly possible to have a device with no
> driver bound to it otherwise it would not be possible to use loadable
> modules for drivers.

Ok, I missed this part. That makes the commit message indeed broken.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
