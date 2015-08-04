From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 04 Aug 2015 13:37:48 +0200
Message-ID: <55C0A40C.5070806@martin.sperl.org>
References: <55C05E18.600@martin.sperl.org> <20150804095443.GH20873@sirena.org.uk> <55C08F70.5070303@martin.sperl.org> <20150804111528.GL20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150804111528.GL20873-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04.08.2015 13:15, Mark Brown wrote:
>> We just had one issue with fbtft devices where it would have been
>> nice to change those values on a per device basis (even if it was
>> just for some testing to see why it was behaving badly
>> - see the still un-merged patch:
>> "spi: bcm2835: set up spi-mode before asserting cs-gpio").
>
> I'm not finding that patch particularly enlightening here, sorry...  can
> you be more explicit please?
Well, while trying to figure the issue out we tried to disable or tune
different parameters to see where the issue really came from.

At that time we had to recompile the kernel several times, which is a 
much longer turn-arround than tuning parameters on the fly.

In the end the issue (which the patch fixes) turned out not to be
related to any of those parameters, but a default-clock-polarity change
while GPIO-CS was already asserted resulting in an extra level-change
on the clock getting interpreted by the HW as a clock change, which the
above mentioned patch fixes by setting up polarity before GPIO-CS.

That is where the idea of configuring it in DT or via sysfs came from.

Martin



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
