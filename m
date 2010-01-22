From: Ben Gamari <bgamari@gmail.com>
Subject: Re:
Date: Fri, 22 Jan 2010 10:53:10 -0500
Message-ID: <1264175450-sup-1219@ben-laptop>
References: <1264016711-sup-309@ben-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ben Dooks <ben@simtec.co.uk>,
	beagleboard <beagleboard@googlegroups.com>,
	linux-omap <linux-omap@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Eric Miao <eric.miao@marvell.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general <spi-devel-general@lists.sourceforge.net>
To: Ben Gamari <bgamari@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-reply-to: <1264016711-sup-309@ben-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Excerpts from Ben Gamari's message of Wed Jan 20 14:47:23 -0500 2010:
> Bcc: 
> Subject: GPIO chip select support in omap2_mcspi driver
> 
> It seems like the rough idea is to add a cs_gpio field to the device
> struct (omap2_mcspi) and add the appropriate code to the
> omap2_mcspi_force_cs() to bring cs_gpio high or low if it is valid. The
> potential problem I can see with this is that omap2_mcspi_set_enable()
> is called to enable the channel before the force_cs() is called (in
> omap2_mcspi_work()). If I'm interpreting the documentation correctly,
> the enable bit starts the clocks, meaning that the chip will begin
> clocking out data before CS is brought high. I must be missing something
> here, no?

Could someone comment on how this ordering works? As I said, it seems to
me like the SPI controller starts sending before CS is brought high.
I would appreciate any feedback. Thanks!

- Ben

