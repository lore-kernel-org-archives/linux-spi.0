From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 3/3] SPI: spi_sh_msiof: fix wrong address calculation, which leads to an Oops
Date: Sat, 22 Jan 2011 12:26:32 +0900
Message-ID: <20110122032631.GA9453@linux-sh.org>
References: <Pine.LNX.4.64.1101211655550.18867@axis700.grange> <20110121162743.GA7477@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110121162743.GA7477@angua.secretlab.ca>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 21, 2011 at 09:27:43AM -0700, Grant Likely wrote:
> On Fri, Jan 21, 2011 at 04:56:47PM +0100, Guennadi Liakhovetski wrote:
> > NULL + <small offset> != NULL, but reading from that <small offset> address
> > is usually not a very good idea and often leads to problems, like kernel
> > Oopses in this case, easily reproducible by writing to an SD-card, used in
> > SPI mode.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Applied, thanks.  Since this is an oops fix, I'll push this one to
> Linus before the next -rc.  The other two can go into linux-next for
> 2.6.39.
> 
I haven't been following too closely, but this may also be a good -stable
candidate.
