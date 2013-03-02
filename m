From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-xilinx: Use DT information for bits_per_word
	value
Date: Sat, 02 Mar 2013 21:22:30 +0000
Message-ID: <20130302212230.E17D73E220D@localhost>
References: <51191C11.9070607@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Jens Renner (EFE)" <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51191C11.9070607-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 11 Feb 2013 17:28:01 +0100, "Jens Renner (EFE)" <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org> wrote:
> From: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
> 
> This patch overrides the default value of bits_per_word with the actual value
> of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word
> lengths.
> 
> Signed-off-by: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
> ---
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index e1d7696..03abdfa 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -487,6 +487,12 @@ static int xilinx_spi_probe(struct platform_device *dev)
> 				       &len);
> 		if (prop && len >= sizeof(*prop))
> 			num_cs = __be32_to_cpup(prop);
> +
> +		/* override default number of bits per word */
> +		prop = of_get_property(dev->dev.of_node,
> +				       "xlnx,num-transfer-bits", &len);
> +		if (prop && len >= sizeof(*prop))
> +			bits_per_word = __be32_to_cpup(prop);

Hi Jens,

Please remember to update documentation when modifying a DT binding.

Also, if you use of_property_read_u32() the code will be a lot simpler.

g.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
