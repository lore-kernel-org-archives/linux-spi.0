From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 10:05:50 -0700
Message-ID: <CAD=FV=W8gt+xgsJ5pPz1uCXGubDHkOnXoDz0mq--cDvkdf-j9g@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com> <20160701082101.GD6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701082101.GD6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Fri, Jul 1, 2016 at 1:21 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 30, 2016 at 09:23:26PM -0700, Doug Anderson wrote:
>
>> Also, something doesn't seem terribly robust about this, buy maybe I'm
>> being paranoid.  If something happens where the timer hasn't fired
>> quickly enough then you might not know that you need to assert the
>> wakeup, right?  I don't think there's a 100% guarantee that a timer
>> will fire and finish running within a certain period of time, is
>> there?
>
> No, or at least a minimum bound on accuracy - you'd need to set the
> timer for something lower than the actual limit.

I'm curious why you you need a timer at all.  Can't you just keep
track of the jiffies that you last sent and do subtraction?  ...or you
could get even more accurate and use a ktime_t.  That avoids a whole
lot of synchronization / locking issues too...

Also: presumably you'll need to make sure that there's some margin in
this whole thing.  I'd imagine that if the timeout is 10000
nanoseconds and you do the calculation and you last sent 9999
nanoseconds ago then you might decide that the other side isn't asleep
yet.  ...but by the time the transfer starts it might be asleep...

-Doug
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
