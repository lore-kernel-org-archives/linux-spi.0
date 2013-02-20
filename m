From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] spi: tegra114: add spi driver
Date: Wed, 20 Feb 2013 18:56:13 +0530
Message-ID: <5124CEF5.3060605@nvidia.com>
References: <1361281115-20436-1-git-send-email-ldewangan@nvidia.com> <5123C18A.9010604@wwwdotorg.org> <5124C18F.6070108@nvidia.com> <20130220131112.GE2726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Stephen Warren <swarren@nvidia.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130220131112.GE2726@opensource.wolfsonmicro.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 20 February 2013 06:41 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Wed, Feb 20, 2013 at 05:59:03PM +0530, Laxman Dewangan wrote:
>>>> +	tspi->clk = devm_clk_get(&pdev->dev, "spi");
>>> Does this HW block use multiple clocks? If not, I think s/"spi"/NULL/
>>> there, just like the Tegra20 driver.
>> No, spi controller uses the only one clock. I will change to NULL.
> I'm never convinced that NULL is a helpful clock name to pick, it's not
> awesome if you ever acquire a second clock.

I had other idea of okeeping clock name here for power optimization.
Spi controller can take the power source ffrom different clock source 
say clk_m (crystal) and pllp.

I want to set the parent clock dynamically based on required speed so 
that if the desire speed can be meet from clk_m, no need to increase pll 
count and possible we may endup with siwtchng off pllp which can save power.

So for this I may require

spi_clk = devm_clk_get(&pdev->dev, "spi");
spi_clkm = devm_clk_get(&pdev->dev, "clmkm");
spi_pllp = devm_clk_get(&pdev->dev, "pllp");

and call clk_set_parent(spi_clk, spi_clkm) or clk_set_parent(spi_clk, spi_pllp).







