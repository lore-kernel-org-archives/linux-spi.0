From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] spi_txx9: Fix bit rate calculation
Date: Wed, 14 Oct 2009 12:44:36 +0200
Message-ID: <20091014104436.GA27483@linux-mips.org>
References: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp> <20090904163227.GB6699@linux-mips.org> <20090925.021039.179960776.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david-b@pacbell.net, linux-mips@linux-mips.org,
	spi-devel-general@lists.sourceforge.net
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20090925.021039.179960776.anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 25, 2009 at 02:10:39AM +0900, Atsushi Nemoto wrote:

> On Fri, 4 Sep 2009 17:32:27 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Atsushi's patches should probably be merged together.  I can take care of
> > that if the SPI bit is acked by a maintainer.
> 
> David, could you give us Ack ?
> 
> [PATCH 1/2] txx9: Fix spi-baseclk value
> [PATCH 2/2] spi_txx9: Fix bit rate calculation

Nothing heared so I've just merged these two fixes and will push them to
Linus asap.

  Ralf
