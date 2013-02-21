From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra114: add spi driver
Date: Thu, 21 Feb 2013 11:56:54 +0200
Message-ID: <20130221095654.GH23234@tbergstrom-lnx.Nvidia.com>
References: <1361281115-20436-1-git-send-email-ldewangan@nvidia.com>
	<5123C18A.9010604@wwwdotorg.org> <5124C18F.6070108@nvidia.com>
	<20130220131112.GE2726@opensource.wolfsonmicro.com>
	<5124CEF5.3060605@nvidia.com> <512506F9.2030508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <512506F9.2030508-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 20, 2013 at 06:25:13PM +0100, Stephen Warren wrote:
> On 02/20/2013 06:26 AM, Laxman Dewangan wrote:
> > On Wednesday 20 February 2013 06:41 PM, Mark Brown wrote:
> >> * PGP Signed by an unknown key
> >>
> >> On Wed, Feb 20, 2013 at 05:59:03PM +0530, Laxman Dewangan wrote:
> >>>>> +    tspi->clk = devm_clk_get(&pdev->dev, "spi");
> >>>> Does this HW block use multiple clocks? If not, I think s/"spi"/NULL/
> >>>> there, just like the Tegra20 driver.
> >>> No, spi controller uses the only one clock. I will change to NULL.
> >> I'm never convinced that NULL is a helpful clock name to pick, it's not
> >> awesome if you ever acquire a second clock.
> > 
> > I had other idea of okeeping clock name here for power optimization.
> > Spi controller can take the power source ffrom different clock source
> > say clk_m (crystal) and pllp.
> > 
> > I want to set the parent clock dynamically based on required speed so
> > that if the desire speed can be meet from clk_m, no need to increase pll
> > count and possible we may endup with siwtchng off pllp which can save
> > power.
> > 
> > So for this I may require
> > 
> > spi_clk = devm_clk_get(&pdev->dev, "spi");
> > spi_clkm = devm_clk_get(&pdev->dev, "clmkm");
> > spi_pllp = devm_clk_get(&pdev->dev, "pllp");
> > 
> > and call clk_set_parent(spi_clk, spi_clkm) or clk_set_parent(spi_clk,
> > spi_pllp).
> 
> OK, so that's certainly an argument for requesting a specific clock name
> rather than NULL.
> 

The list of possible parents for each clock is determined by the SoC and is
already known to CCF, so maybe we just need to add a function to CCF to allow
the drivers to query the list of possible parents?

Cheers,

Peter.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
