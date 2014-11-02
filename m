From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC 0/2] drivers: spi/i2c: account completions as iowait
Date: Sun, 2 Nov 2014 17:59:43 +0100
Message-ID: <20141102165943.GT10501@worktop.programming.kicks-ass.net>
References: <1414936689-2707-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414936689-2707-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Nov 02, 2014 at 02:58:07PM +0100, Wolfram Sang wrote:

> However, researching the net, users currently interpret iowait entirely as
> blkio wait. Furthermore, io_schedule() calls delayacct_blkio_{start|end}() which
> worked fine for my tests with I2C but might show that iowait was really meant as
> blkiowait? So, should other subsystems use it?

I would tend to agree with that; historically this has always been about
blkio, not device io.

> To make it more confusing, some people (like Peter Zijlstra [1]) seem to like
> iowait gone, so maybe it is all not worth it?

Yeah, iowait accounting is terminally broken :-) Mostly because the
iowait is accounted per-cpu but that is a very tenuous relation because
the IO devices are not per IO and blocking tasks are not associated with
any particular CPU -- after all they're not consuming CPU time.

If people really think its worth; we could invent new IO-wait measure
that do make sense -- maybe, but the current thing is complete bollocks.
