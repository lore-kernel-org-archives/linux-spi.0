From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions
 exist
Date: Tue, 23 Jun 2015 11:26:33 -0700
Message-ID: <20150623182633.GO4917@ld-irv-0074>
References: <cover.1433364398.git.hramrach@gmail.com>
 <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Han Xu <han.xu@freescale.com>, Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marex@denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@micron.com>, "grmoore@altera.com" <grmoore@alter
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 03, 2015 at 09:26:40PM -0000, Michal Suchanek wrote:
> On Exynos it is necessary to set SPI controller parameters that apply to
> a SPI slave in a DT subnode of the slave device. The ofpart code returns
> an error when there are subnodes of the SPI flash but no partitions are
> found. Change this condition to a warning so that flash without
> partitions can be accessed on Exynos.

So judging by the subsequent discussion, you're looking at handling
nodes like this:

	flash@... {
		compatible = "m25p80";
		...

		controller-data {
			samsung,spi-feedback-delay = <0>;
		};
	};

Now, I'm not a real fan of this controller-data node in the first place
(did that binding get reviewed?). But this is especially bad since
we now have collisions on what to do with subnodes that don't have a
compatible property. By legacy, ofpart has already claimed ownership of
subnodes of an MTD node, where the subnode does not have a compatible
property. See Documentation/devicetree/bindings/mtd/partition.txt:

  "NOTE: if the sub-node has a compatible string, then it is not a
  partition."

So it seems the natural solution is to just define a proper
compatibile property for this subnode, and ofpart.c will naturally
handle this. See:

commit e79265ba6bdb31437bd4c3e7911950f9d1262a07
Author: Josh Wu <josh.wu@atmel.com>
Date:   Mon Aug 5 19:14:38 2013 +0800

    mtd: ofpart: add compatible check for child nodes



Brian

> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/mtd/ofpart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
> index aa26c32..a29d29f 100644
> --- a/drivers/mtd/ofpart.c
> +++ b/drivers/mtd/ofpart.c
> @@ -94,10 +94,10 @@ static int parse_ofpart_partitions(struct mtd_info *master,
>  
>  	if (!i) {
>  		of_node_put(pp);
> -		pr_err("No valid partition found on %s\n", node->full_name);
> +		pr_warn("No valid partition found on %s\n", node->full_name);
>  		kfree(*pparts);
>  		*pparts = NULL;
> -		return -EINVAL;
> +		return 0;
>  	}
>  
>  	return nr_parts;
> -- 
> 2.1.4
> 
