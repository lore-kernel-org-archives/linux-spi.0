From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] documentation: move spidev_fdx example to its own
	source file
Date: Tue, 19 Feb 2008 19:48:57 +0200
Message-ID: <20080219174857.GC31955@cs181133002.pp.htv.fi>
References: <20080218162625.1b4bd079.randy.dunlap@oracle.com> <20080219174719.GB31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, akpm <akpm@linux-foundation.org>
To: Adrian Bunk <bunk@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759534AbYBSRto@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080219174719.GB31955@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 19, 2008 at 07:47:19PM +0200, Adrian Bunk wrote:
> On Mon, Feb 18, 2008 at 04:26:25PM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > cc: dbrownell@users.sourceforge.net
> > cc: spi-devel-general@lists.sourceforge.net
> > 
> > Move sample source code to its own source file so that it can be used
> > easier and build-tested/check/maintained by anyone.
> > 
> > (Makefile changes are in a separate patch for all of Documentation/.)
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  Documentation/spi/spidev       |  168 -------------------------------
> >  Documentation/spi/spidev_fdx.c |  158 +++++++++++++++++++++++++++++
> >  2 files changed, 160 insertions(+), 166 deletions(-)
> >...
> 
> Wouldn't samples/spi/spidev_fdx.c be a better place?

Scrap this comment, I just realized that this is userspace code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
