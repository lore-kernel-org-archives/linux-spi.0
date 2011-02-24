From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv2 1/1] OMAP: McSPI: Off-by-one error in finding the
 right divisor
Date: Thu, 24 Feb 2011 12:45:12 -0700
Message-ID: <20110224194512.GB8907@angua.secretlab.ca>
References: <2cfdc20e8a843b5c008b9beaa413e35deb0f24a3.1298574394.git.hannuxx@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-omap@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, tony@atomide.com,
	ext-phil.2.carmody@nokia.com
To: hannuxx@iki.fi
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cfdc20e8a843b5c008b9beaa413e35deb0f24a3.1298574394.git.hannuxx@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 24, 2011 at 09:31:33PM +0200, hannuxx@iki.fi wrote:
> From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
> 
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

Applied, thanks.

g.

