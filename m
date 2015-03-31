From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: bcm2835: remove dependency on handle_err which
 is
Date: Mon, 30 Mar 2015 21:13:00 -0600
Message-ID: <551A10BC.1010607@wwwdotorg.org>
References: <72441EEF-C509-433B-9DBA-53A936ED5BDB@martin.sperl.org> <20150329164818.GO1743@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150329164818.GO1743-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/29/2015 10:48 AM, Mark Brown wrote:
> On Sun, Mar 29, 2015 at 04:03:22PM +0200, Martin Sperl wrote:
>> in spi-for-next
>> 
>> Remove the implementation of handle_err, the function of which
>> was introduced to spi-for-next with patch b716c4ff
> 
> Why?
> 
> When referencing patches please include the patch title as well as
> the hash, this makes the mail/commit log more directly readable by
> humans.

I believe these days it's also typical to use a 12-character commit
hash when referencing commits; IIRC Linus suggested the following in
your ~/.gitconfig:

[core]
        abbrev = 12

... which would yield the following:

$ git log --oneline -1 b716c4ff|cat
b716c4ffc6a2 spi: introduce master->handle_err() callback

... so you'd typically write the following in a commit log:

b716c4ffc6a2 (spi: introduce master->handle_err() callback)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
