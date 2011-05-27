From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: tle620x: add missing device_remove_file()
Date: Thu, 26 May 2011 21:31:00 -0600
Message-ID: <20110527033100.GL5032@ponder.secretlab.ca>
References: <1305117545.6324.3.camel@phoenix>
 <4DCB9985.2050100@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Ben Dooks <ben@simtec.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DCB9985.2050100@simtec.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 12, 2011 at 09:25:41AM +0100, Ben Dooks wrote:
> On 11/05/11 13:39, Axel Lin wrote:
> >This patch includes below fixes:
> >1. Add missing device_remove_file for dev_attr_status_show in tle62x0_remove.
> >2. Fix tle62x0_probe error handling:
> >    Currently, if the error happens when ptr>  0, gpio_attrs[0] is not
> >    properly remove.
> >
> >Signed-off-by: Axel Lin<axel.lin@gmail.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>

Applied, thanks.

g.
