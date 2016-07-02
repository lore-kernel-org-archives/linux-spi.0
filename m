From: Andrey Pronin <apronin@chromium.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 19:02:17 -0700
Message-ID: <20160702020216.GA31918@apronin0.mtv.corp.google.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com>
 <20160701082101.GD6247@sirena.org.uk>
 <CAD=FV=W8gt+xgsJ5pPz1uCXGubDHkOnXoDz0mq--cDvkdf-j9g@mail.gmail.com>
 <20160701171708.GC6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Doug Anderson <dianders@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160701171708.GC6247@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 01, 2016 at 07:17:08PM +0200, Mark Brown wrote:
> On Fri, Jul 01, 2016 at 10:05:50AM -0700, Doug Anderson wrote:
> 
> > I'm curious why you you need a timer at all.  Can't you just keep
> > track of the jiffies that you last sent and do subtraction?  ...or you
> > could get even more accurate and use a ktime_t.  That avoids a whole
> > lot of synchronization / locking issues too...
> 
> Yeah, that'd be a lot better.
> 
> > Also: presumably you'll need to make sure that there's some margin in
> > this whole thing.  I'd imagine that if the timeout is 10000
> > nanoseconds and you do the calculation and you last sent 9999
> > nanoseconds ago then you might decide that the other side isn't asleep
> > yet.  ...but by the time the transfer starts it might be asleep...
> 
> Indeed.

Lots of godd points in the feedback. Let me re-visit the whole idea.
And may be I'll move it to a more device-specific driver.
