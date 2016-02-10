From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting cs-gpio
Date: Wed, 10 Feb 2016 21:26:05 +0100
Message-ID: <2743238.b2UJKq0efN@chaos-desktop>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <878u2s2xym.fsf@eliezer.anholt.net> <20160210190204.GD13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160210190204.GD13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am Wednesday 10 February 2016, 19:02:04 schrieb Mark Brown:
> On Wed, Feb 10, 2016 at 10:59:29AM -0800, Eric Anholt wrote:
> > Oops, this makes more sense now.  Subject even mentioned gpio, and a
> > GPIO CS must be getting set around the transfer_one call.  I'll be ready
> > to send an r-b for a v2 with the speed update bug fixed (unless transfer
> > speeds are guaranteed to be constant between a prepare and unprepare).
> 
> No guarantee that they'll not change, especially in a situation where we
> have two devices on different speeds on a bus working at the same time.
Are you saying, that between a prepare and unprepare there could be transfers 
for another device? Then all the clock setting couldn't be done in prepare 
either.
Apart from that, if two transfers in the same message are not guarantied to 
have the same speed, this still needs to be fixed. I'll roll a v2.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
