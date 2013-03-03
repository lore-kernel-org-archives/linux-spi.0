From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
 wrongly set.
Date: Sun, 3 Mar 2013 11:27:43 +0100
Message-ID: <20130303102743.GM30595@game.jcrosoft.org>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
 <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard.genoud@gmail.com, JM.Lin@atmel.com, nicolas.ferre@atmel.com,
 linux-kernel@vger.kernel.org, grant.likely@secretlab.ca,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 14:47 Tue 26 Feb     , Wenyou Yang wrote:
> if the spi property "cs-gpios" is set as below:
> 
> 	cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> 
> the master->num_chipselect will wrongly be set to 0,
> and the spi fail to probe.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/spi/spi-atmel.c |    2 +-
>  drivers/spi/spi.c       |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index ab34497..5bf3786 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -944,7 +944,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  
>  	master->dev.of_node = pdev->dev.of_node;
>  	master->bus_num = pdev->id;
> -	master->num_chipselect = master->dev.of_node ? 0 : 4;
> +	master->num_chipselect = 4;
Nack

we use 0 hardware gpio we only use the cs-gpio

and you do not follow the binding

it's
	cs-gpios = < 0 0 0
	 	    &pioC 11 0>;

so the code work a expected

Best Regards,
J.
>  	master->setup = atmel_spi_setup;
>  	master->transfer = atmel_spi_transfer;
>  	master->cleanup = atmel_spi_cleanup;
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 19ee901..d88cbef 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1070,7 +1070,7 @@ static int of_spi_register_master(struct spi_master *master)
>  	master->num_chipselect = max(nb, master->num_chipselect);
>  
>  	if (nb < 1)
> -		return 0;
> +		nb = master->num_chipselect;
>  
>  	cs = devm_kzalloc(&master->dev,
>  			  sizeof(int) * master->num_chipselect,
> -- 
> 1.7.9.5
> 
