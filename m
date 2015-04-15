From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Wed, 15 Apr 2015 21:33:48 +0200
Message-ID: <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org> <20150410185132.GU6023@sirena.org.uk> <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org> <20150415185824.GU6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150415185824.GU6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 15.04.2015, at 20:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Running without a timeout doesn't feel safe - the standard thing here is
> to busy wait for a short period then fall back to something that sleeps
> if that times out.

That is what is implemented now, but unfortunately the issue is that the 
implementation as of now is depending on jiffies, which I found out to be
in the order of 10ms and on top requires a timer interrupt which would
interrupt polling in the first place. But it is still sensitive enough
to trigger on some rescheduling of the polling thread.

One possibility could be increasing the timeout to something longer like
one second or a fraction of one second.

Something along those lines:
-	unsigned long timeout = jiffies +
-		max(4 * xfer_time_us * HZ / 1000000, 2uL);
+	/* one second timeout - this should also allow for graceful
+	 * timeouts even when experiencing rescheduling of the thread
+	 */
+	unsigned long timeout = jiffies + HZ;

Would this be sufficient and acceptable?

Alternatively we would need some way to measure the time in uSeconds
quite accurately and then code some "rescheduling" detection into the
polling loop to modify the end-time if the thread got rescheduled or
otherwise interrupted for longer periods. Things would get complicated
here...

What kind of interface could we use for this timeout behavior?

The question here is - is the "simple" 1 second timeout approach
sufficient or would we need something more complex?

The patch removing the timeout worked for about 1.47B SPI messages
using the polling code-path now without issues.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
