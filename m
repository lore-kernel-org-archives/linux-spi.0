From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Tue, 7 Jun 2011 11:01:14 -0600
Message-ID: <20110607170114.GD17754@ponder.secretlab.ca>
References: <20110606071829.10334.90865.stgit@ponder>
 <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
 <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
 <4DED0510.1030600@gmail.com>
 <20110607102829.01392e7e@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mike Frysinger <vapier.adi@gmail.com>
To: Feng Tang <feng.tang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110607102829.01392e7e@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 07, 2011 at 10:28:29AM +0800, Feng Tang wrote:
> On Tue, 7 Jun 2011 00:49:20 +0800
> Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> 
> > On 06/06/2011 09:38 AM, Grant Likely wrote:
> > > On Mon, Jun 6, 2011 at 10:31 AM, Mike
> > > Frysinger<vapier.adi@gmail.com>  wrote:
> > >> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
> > >>> Sort the SPI makefile and enforce the naming convention spi_*.c
> > >>> for spi drivers.
> > >>
> > >> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but
> > >> perhaps those are only for /proc/ status tracking ?  worth double
> > >> checking ...
> > >
> > > I just talked with Dirk Brandewie, who has a major rewrite to the
> > > topcliff spi driver.  I'll let him comment on whether or not
> > > changing KBUILD_MODNAME will cause any problems.
> > >
> > 
> > My changes are to the designware driver :-) I will get my patches
> > re-based onto the spi-next branch and see if there any issues.
> 
> If there is major rewrite to the dw_spi driver, please submit to this
> list, as it is used by many devices out there and needs a broad review

That is always the requirement.  I'm not going to pick up anything
that hasn't been posted for review, and Dirk is currently working on
getting his patch posted.

g.
