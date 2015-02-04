From: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Wed, 04 Feb 2015 10:03:33 +0100
Message-ID: <1423040613.3304.10.camel@gmail.com>
References: <1420472564.803.9.camel@gmail.com>
	 <20150105154834.GV11764@sirena.org.uk>
	 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
	 <20150123124529.GU21293@sirena.org.uk> <20150125173853.GA6467@kroah.com>
	 <20150125201254.GX21293@sirena.org.uk> <20150125220723.GD29924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Esben Haabendal <esben.haabendal@gmail.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Stefan Roese <sr@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150125220723.GD29924@kroah.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 2015-01-25 at 14:07 -0800, Greg Kroah-Hartman wrote:
> On Sun, Jan 25, 2015 at 08:12:54PM +0000, Mark Brown wrote:
> > On Sun, Jan 25, 2015 at 09:38:53AM -0800, Greg Kroah-Hartman wrote:
> > > On Fri, Jan 23, 2015 at 12:45:29PM +0000, Mark Brown wrote:
> > 
> > > > So, I now see this has actually been merged into stable without getting
> > > > to the bottom of why it's helping anything...  this is a bit worrying
> > > > since it's adding new functionality and not really a bug fix.  It'd have
> > > > been good to at least get a followup here.
> > 
> > > Do you want me to revert something from the stable tree?  If so, has it
> > > also been reverted upstream?
> > 
> > The patch just isn't an obvious -stable patch - it's adding new
> > functionality, not fixing a bug, and I was surprised to discover it had
> > been added as a result.  It's fine as new functionality and therefore
> > hasn't been reverted upstream.
> > 
> > We can probably leave it there, though if this is OK that's a bit of a
> > change, but if this new functionality is a good fix then we're probably
> > leaving other systems unfixed which isn't good, I would be very much
> > happier if we understood what had changed here.  If new functionality is
> > OK there's a probably a bunch of other changes we should be pulling
> > back.
> 
> New functionality shouldn't be added, but sometimes things slip in due
> to the volume of patches and how people word-smith changelog entries :(

In this case, I don't believe anybody has tried to fiddle with changelog
entried.

I merely stated that the commit in question fixed an (observed)
regression.  The commit itself states that it changes behaviour of the
driver, although my interpretation of this change in behaviour still is
that it replaces a clearly broken behaviour (returning -EINVAL for all
multi message transfers) with a proper handling of these.

I suspect that the regression I have observed is caused by the
combination of the following two commits:

commit 059b8ffeee5b427949872bb6ed5db5ae0788054e
  spi: make sure all transfer has proper speed set

commit e6811d1d7a6a38ee637fe219c3b67dbfe17e8b3f
  spi: make sure all transfer has bits_per_word set

And the broken behaviour of the spi-fsl-spi driver prior to the (now
backported) commit 4302a59629f7a0bd70fd1605d2b558597517372a.

A side effect of the two above mentioned commits is that the spi all
transfers (in multi message transfers) have their transfer speed_hz and
bits_per_word set, which is not handled properly by spi-fsl-spi.

As such, I believe the backport is a valid bugfix backport for all
stable kernels including the two spi commits mentioned.

/Esben
