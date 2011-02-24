From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] OMAP: McSPI: Off-by-one error in finding the right
 divisor
Date: Thu, 24 Feb 2011 09:00:46 -0700
Message-ID: <20110224160045.GB17735@angua.secretlab.ca>
References: <22be8985c86a32b9829ff740ce72bc4bd2e383cf.1298556551.git.ext-hannu.m.heikkinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-omap@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, ext-phil.2.carmody@nokia.com
To: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22be8985c86a32b9829ff740ce72bc4bd2e383cf.1298556551.git.ext-hannu.m.heikkinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 24, 2011 at 04:13:31PM +0200, Hannu Heikkinen wrote:
> Off-by-one error, gave erroneous divisor value 16 if speed_hz is over zero but
> less than OMAP2_MCSPI_MAX_FREQ / (1 << 15), that is, [1..1463].
> 
> Also few overly complex bit shifts in divisor fixed.
> 
> Also one dev_dgb line fixed, which indicated max speed exceeding transfer speed.
> 
> Introducing a new function omap2_mcspi_calc_divisor() for getting the right
> divisor in omap2_mcspi_setup_transfer().
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> Signed-off-by: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>

Applied, thanks

g.

