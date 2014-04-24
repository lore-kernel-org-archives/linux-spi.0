From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi-bfin: Add missing gpio.h include
Date: Thu, 24 Apr 2014 08:34:32 -0400
Message-ID: <20140424083432.70c80f64@gandalf.local.home>
References: <20140423224035.1de64093@gandalf.local.home>
	<20140424103329.GL12304@sirena.org.uk>
	<20140424113346.GM12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140424113346.GM12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 24 Apr 2014 12:33:46 +0100
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Apr 24, 2014 at 11:33:29AM +0100, Mark Brown wrote:
> > On Wed, Apr 23, 2014 at 10:40:35PM -0400, Steven Rostedt wrote:
> > > Running my ktest.pl tests on all the archs, I stumbled over this for
> > > 3.15-rc2:
> > 
> > Applied, thanks.
> 
> Actually not - I already have a fix for this in -next (on a slightly
> different branch to the one I looked for it on).  Anyway, it's fixed.

Heh, OK, I figured someone may have already fixed it, but still wanted
to let people know it was broken. It's amazing how long something like
this can take.

It's just annoying when my tests break on something that I'm not
testing ;-)

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
