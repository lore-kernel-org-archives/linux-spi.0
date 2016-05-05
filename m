From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mtd: m25p80: add message if mmap flash read is supported
Date: Wed, 4 May 2016 17:54:36 -0700
Message-ID: <20160505005436.GA122798@google.com>
References: <9111b023-d1e5-3084-4320-acf727e828f4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MTD Mailing List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9111b023-d1e5-3084-4320-acf727e828f4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

(moving linux-spi to BCC, since this is MTD-only, and doesn't concern
the SPI core)

On Wed, Apr 27, 2016 at 10:36:48PM +0200, Heiner Kallweit wrote:
> As a follow-up to commit 08922f644878c9 "mtd: devices: m25p80: add support for
> mmap read request" add an info to syslog if mmap flash read is supported for a
> device.

Any particular reason you want this to be printed? There are quite a few
other features we don't print to the log right now.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
