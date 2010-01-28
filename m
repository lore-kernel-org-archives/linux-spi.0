From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: McSPI questions pertaining to GPIO chip select support
Date: Wed, 27 Jan 2010 22:15:05 -0600
Message-ID: <4B610F49.9070705@billgatliff.com>
References: <1264016711-sup-309@ben-laptop> <1264651770-sup-5197@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: beagleboard <beagleboard@googlegroups.com>,
	linux-omap <linux-omap@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Eric Miao <eric.miao@marvell.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general <spi-devel-general@lists.sourceforge.net>
To: Ben Gamari <bgamari.foss@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1264651770-sup-5197@ben-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ben Gamari wrote:
> As I am writing this, it now occurs to me that perhaps the chip doesn't
> start SPI_CLK until it has data to send.

... or receive.  This is indeed the case.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com

