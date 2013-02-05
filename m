From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-mpc512x-psc: add support for gpio chip
	selects
Date: Tue, 05 Feb 2013 14:18:46 +0000
Message-ID: <20130205141846.173C43E1265@localhost>
References: <1358195221-18488-1-git-send-email-agust@denx.de>
	<1358195221-18488-2-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1358195221-18488-2-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 14 Jan 2013 21:27:01 +0100, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> Currently the driver only uses one internal chip select. Add support
> for gpio chip selects configured by gpio specifiers in the device tree.
> 
> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>

GPIO chip selects are now in the core spi library. Take a look at
master->cs_gpios and Documentation/devicetree/bindings/spi/spi-bus.txt.
You don't need to parse them manually.

g.

> ---
>  drivers/spi/spi-mpc512x-psc.c |   80 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> index 89480b2..4b2f391 100644
> --- a/drivers/spi/spi-mpc512x-psc.c
> +++ b/drivers/spi/spi-mpc512x-psc.c
> @@ -20,6 +20,7 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/workqueue.h>
>  #include <linux/completion.h>
> @@ -50,6 +51,8 @@ struct mpc512x_psc_spi {
>  	spinlock_t lock;	/* Message queue lock */
>  
>  	struct completion done;
> +	int num_cs;
> +	int chipselects[0];
>  };
>  
>  /* controller state */
> @@ -277,6 +280,7 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
>  {
>  	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
>  	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
> +	int gpio = mps->chipselects[spi->chip_select];
>  	unsigned long flags;
>  
>  	if (spi->bits_per_word % 8)
> @@ -292,6 +296,9 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
>  	cs->bits_per_word = spi->bits_per_word;
>  	cs->speed_hz = spi->max_speed_hz;
>  
> +	if (gpio_is_valid(gpio))
> +		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
> +
>  	spin_lock_irqsave(&mps->lock, flags);
>  	if (!mps->busy)
>  		mpc512x_psc_spi_deactivate_cs(spi);
> @@ -405,6 +412,27 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +static void mpc512x_spi_cs_control(struct spi_device *spi, bool on)
> +{
> +	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
> +	int gpio = mps->chipselects[spi->chip_select];
> +
> +	gpio_set_value(gpio, on);
> +}
> +
> +static int mpc512x_spi_cs_num(struct device *dev)
> +{
> +	int num_cs, ret;
> +
> +	ret = of_property_read_u32(dev->of_node, "num-cs", &num_cs);
> +	if (ret < 0) {
> +		dev_warn(dev, "no num-cs property\n");
> +		return of_gpio_named_count(dev->of_node, "cs-gpios");
> +	}
> +
> +	return num_cs;
> +}
> +
>  /* bus_num is used only for the case dev->platform_data == NULL */
>  static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  					      u32 size, unsigned int irq,
> @@ -415,8 +443,17 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	struct spi_master *master;
>  	int ret;
>  	void *tempp;
> +	int i = 0, max_cs_num = 0;
> +	int use_internal_cs = 0;
> +	int num_cs;
> +
> +	num_cs = mpc512x_spi_cs_num(dev);
> +	if (!num_cs)
> +		use_internal_cs = 1;
>  
> -	master = spi_alloc_master(dev, sizeof *mps);
> +	dev_dbg(dev, "using %d gpio chipselects\n", num_cs);
> +
> +	master = spi_alloc_master(dev, sizeof(*mps) + sizeof(int) * num_cs);
>  	if (master == NULL)
>  		return -ENOMEM;
>  
> @@ -425,12 +462,14 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	mps->irq = irq;
>  
>  	if (pdata == NULL) {
> -		dev_err(dev, "probe called without platform data, no "
> -			"cs_control function will be called\n");
> -		mps->cs_control = NULL;
>  		mps->sysclk = 0;
>  		master->bus_num = bus_num;
> -		master->num_chipselect = 255;
> +		if (use_internal_cs) {
> +			mps->cs_control = NULL;
> +			master->num_chipselect = 1;
> +		} else {
> +			mps->cs_control = mpc512x_spi_cs_control;
> +		}
>  	} else {
>  		mps->cs_control = pdata->cs_control;
>  		mps->sysclk = pdata->sysclk;
> @@ -438,6 +477,28 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  		master->num_chipselect = pdata->max_chipselect;
>  	}
>  
> +	if (!pdata && !use_internal_cs) {
> +		for (i = 0; i < num_cs; i++) {
> +			int cs_gpio = of_get_named_gpio(dev->of_node,
> +							"cs-gpios", i);
> +
> +			dev_dbg(dev, "cs %d: gpio %d\n", i, cs_gpio);
> +			mps->chipselects[i] = cs_gpio;
> +			if (!gpio_is_valid(cs_gpio))
> +				continue;
> +
> +			max_cs_num = max(max_cs_num, cs_gpio);
> +			ret = gpio_request(mps->chipselects[i],
> +					   "psc-spi cs");
> +			if (ret) {
> +				dev_err(dev, "can't get CS gpio: %d\n", ret);
> +				goto free_cs_gpios;
> +			}
> +		}
> +		master->num_chipselect = max_cs_num;
> +		mps->num_cs = num_cs;
> +	}
> +
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
>  	master->setup = mpc512x_psc_spi_setup;
>  	master->transfer = mpc512x_psc_spi_transfer;
> @@ -485,6 +546,11 @@ unreg_master:
>  	destroy_workqueue(mps->workqueue);
>  free_irq:
>  	free_irq(mps->irq, mps);
> +free_cs_gpios:
> +	while (--i >= 0) {
> +		if (gpio_is_valid(mps->chipselects[i]))
> +			gpio_free(mps->chipselects[i]);
> +	}
>  free_master:
>  	if (mps->psc)
>  		iounmap(mps->psc);
> @@ -497,6 +563,7 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
>  {
>  	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
>  	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
> +	int i;
>  
>  	flush_workqueue(mps->workqueue);
>  	destroy_workqueue(mps->workqueue);
> @@ -504,6 +571,9 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
>  	free_irq(mps->irq, mps);
>  	if (mps->psc)
>  		iounmap(mps->psc);
> +	for (i = 0; i < mps->num_cs; i++)
> +		if (gpio_is_valid(mps->chipselects[i]))
> +			gpio_free(mps->chipselects[i]);
>  	spi_master_put(master);
>  
>  	return 0;
> -- 
> 1.7.5.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
