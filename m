From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Sun, 25 Jan 2015 09:38:53 -0800
Message-ID: <20150125173853.GA6467@kroah.com>
References: <1420472564.803.9.camel@gmail.com>
 <20150105154834.GV11764@sirena.org.uk>
 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
 <20150123124529.GU21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Esben Haabendal <esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150123124529.GU21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 23, 2015 at 12:45:29PM +0000, Mark Brown wrote:
> On Tue, Jan 06, 2015 at 10:15:47PM +0100, Esben Haabendal wrote:
> > On 5 January 2015 at 16:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> > >> Please consider commit 4302a59629f7a0bd70fd1605d2b558597517372a
> > >> (spi: fsl: Fix problem with multi message transfers) for inclusion in
> > >> stable kernel 3.14.
> 
> > >> It fixes a regression when using mmc_spi driver on top of spi-fsl-spi
> > >> driver (tested with powerpc mpc8313 based board).
> 
> > > Has this ever worked?
> 
> > Yes, I have used mmc_spi with spi-fsl-spi on the same board with success
> > with in 2.6.33, 3.0 and 3.4.
> 
> > I have no idea what has caused this to break.  Maybe mmc_spi driver was
> > not doing multi message transfers earlier?
> 
> So, I now see this has actually been merged into stable without getting
> to the bottom of why it's helping anything...  this is a bit worrying
> since it's adding new functionality and not really a bug fix.  It'd have
> been good to at least get a followup here.

Do you want me to revert something from the stable tree?  If so, has it
also been reverted upstream?

confused,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
