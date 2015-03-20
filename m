From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: fix all checkpath --strict messages
Date: Fri, 20 Mar 2015 07:26:29 +0100
Message-ID: <7727F65E-D8BC-4299-A359-56FA449C3379@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <550BA8FE.7030001@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550BA8FE.7030001-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 20.03.2015, at 05:58, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
> Do you have a list of the warnings this fixes and why? The extra
> wrapping here looks a bit odd, since the lines before your patch are
> well under 80 columns.

scripts/checkpatch.pl --file --terse --strict drivers/spi/spi-bcm2835.c
drivers/spi/spi-bcm2835.c:182: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:191: CHECK: braces {} should be used on all arms of this statement
drivers/spi/spi-bcm2835.c:234: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:256: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:271: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:346: CHECK: Alignment should match open parenthesis
total: 0 errors, 0 warnings, 6 checks, 403 lines checked

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
