From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Tue, 7 Jun 2011 10:28:29 +0800
Message-ID: <20110607102829.01392e7e@feng-i7>
References: <20110606071829.10334.90865.stgit@ponder>
	<BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
	<BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
	<4DED0510.1030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mike Frysinger <vapier.adi@gmail.com>
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DED0510.1030600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 7 Jun 2011 00:49:20 +0800
Dirk Brandewie <dirk.brandewie@gmail.com> wrote:

> On 06/06/2011 09:38 AM, Grant Likely wrote:
> > On Mon, Jun 6, 2011 at 10:31 AM, Mike
> > Frysinger<vapier.adi@gmail.com>  wrote:
> >> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
> >>> Sort the SPI makefile and enforce the naming convention spi_*.c
> >>> for spi drivers.
> >>
> >> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but
> >> perhaps those are only for /proc/ status tracking ?  worth double
> >> checking ...
> >
> > I just talked with Dirk Brandewie, who has a major rewrite to the
> > topcliff spi driver.  I'll let him comment on whether or not
> > changing KBUILD_MODNAME will cause any problems.
> >
> 
> My changes are to the designware driver :-) I will get my patches
> re-based onto the spi-next branch and see if there any issues.

If there is major rewrite to the dw_spi driver, please submit to this
list, as it is used by many devices out there and needs a broad review

Thanks,
Feng

> 
> --Dirk
> 
> ------------------------------------------------------------------------------
> Simplify data backup and recovery for your virtual environment with
> vRanger. Installation's a snap, and flexible recovery options mean
> your data is safe, secure and there when you need it. Discover what
> all the cheering's about. Get your free trial download today. 
> http://p.sf.net/sfu/quest-dev2dev2 
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
