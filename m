From: David Wood <david-FXZ7EUqcgyfQXOPxS62xeg@public.gmane.org>
Subject: Re: [PATCH] spi: Fix warning about redefinition
Date: Wed, 6 Aug 2014 21:07:04 +0200
Message-ID: <CAO+Sx3ncSgmdQq-PyZwXzN-ZJJ+0VD+kNVNJYzir+mHzVwxbdw@mail.gmail.com>
References: <CAO+Sx3nGKN1jh0VB9NjcFCqV7ZmWWjJge0nohdUGta9BF60EWQ@mail.gmail.com>
	<20140806190412.GA5605@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140806190412.GA5605-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 6 August 2014 21:04, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> On Wed, Aug 06, 2014 at 08:53:41PM +0200, David Wood wrote:
> ...
> That was purely to ensure that there is no hidden use through a macro
> defined elsewhere, not a suggestion for a real patch.
>
> Guenter

I also managed not to notice that I had in fact shown that the fs.h
definitions were the opposite of those in the spi driver, so it would
in fact be significant if they were swapped.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
