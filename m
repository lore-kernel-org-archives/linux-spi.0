From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 5 Nov 2013 02:03:23 +0100
Message-ID: <CACRpkdb0Y+Appwf=Px3fV+aN36fSdgFMpLymAh_7p8jrbfJcgg@mail.gmail.com>
References: <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
	<CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
	<06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
	<02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
	<20131030171902.GL2493@sirena.org.uk>
	<8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
	<20131030215716.GV2493@sirena.org.uk>
	<3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
	<20131031001004.GW2493@sirena.org.uk>
	<18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
	<20131104184511.GR2493@sirena.org.uk>
	<5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A55A832-5313-499C-A483-BF5A6649D69D-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Nov 4, 2013 at 10:43 PM, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:

> I just found out that I am in a chicken or egg situation:
> There is no DMA support whatsoever in the upstream RPI support.
> So sending any patches for spi with DMA becomes impossible right now.

I wrote in my first reply:

 "But I hope that you have the necessary infrastructure using the dmaengine
  subsystem for this, or that changes requires will be proposed to that
  first or together with these changes."

So now you are back at this point :-)

Anyway, doing dmaengine support is a venture on its own and as usual
it falls upward to anyone who first needs it to do that. I suggest you
look at some of the newer dmaengines in drivers/dma for inspiration,
and get memcpy in place first so you can test the driver stand-alone
with drivers/dma/dmatest.c

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
