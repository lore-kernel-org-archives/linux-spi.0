From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] spi: Fix warning about redefinition
Date: Wed, 6 Aug 2014 12:18:34 -0700
Message-ID: <20140806191834.GA12488@roeck-us.net>
References: <CAO+Sx3nGKN1jh0VB9NjcFCqV7ZmWWjJge0nohdUGta9BF60EWQ@mail.gmail.com>
 <20140806190412.GA5605@roeck-us.net>
 <CAO+Sx3ncSgmdQq-PyZwXzN-ZJJ+0VD+kNVNJYzir+mHzVwxbdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Krause <xerofoiffy@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Richard Weinberger <richard.weinberger@gmail.com>
To: David Wood <david@dtwood.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO+Sx3ncSgmdQq-PyZwXzN-ZJJ+0VD+kNVNJYzir+mHzVwxbdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 06, 2014 at 09:07:04PM +0200, David Wood wrote:
> On 6 August 2014 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Aug 06, 2014 at 08:53:41PM +0200, David Wood wrote:
> > ...
> > That was purely to ensure that there is no hidden use through a macro
> > defined elsewhere, not a suggestion for a real patch.
> >
> > Guenter
> 
> I also managed not to notice that I had in fact shown that the fs.h
> definitions were the opposite of those in the spi driver, so it would
> in fact be significant if they were swapped.
> 
See it positively: There is someone out there doing an excellent job
of forcing various kernel maintainers to have a close look into areas
of the kernel they would otherwise never look at. In addition to that,
we all gain valuable knowledge on how to validate patches.

Guenter
