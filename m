From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi:spi-gpio: fixed space coding styple issue
Date: Mon, 05 Jan 2015 05:38:53 -0800
Message-ID: <1420465133.2652.12.camel@perches.com>
References: <1420459263-2190-1-git-send-email-nizamhaider786@gmail.com>
	 <1420461363.2652.6.camel@perches.com>
	 <20150105133014.GP11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150105133014.GP11764-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2015-01-05 at 13:30 +0000, Mark Brown wrote:
> On Mon, Jan 05, 2015 at 04:36:03AM -0800, Joe Perches wrote:
> > On Mon, 2015-01-05 at 17:31 +0530, nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > > From: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> > > fixed a coding style issue
> 
> > This is a checkpatch defect and not a coding styple (style) issue.
> 
> > Please don't blindly take checkpatch messages as dicta.
> 
> No, it's a coding style thing.

It's a coding style consistency thing.

> It may have been identified by
> checkpatch but that's what it is.

__pure is a #define for a gcc attribute

include/linux/compiler-gcc.h:#define __pure                             __attribute__((pure))

macro attributes are almost always used
with space separators in the kernel.

All instances of __pure in the kernel have
a space before the use.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
