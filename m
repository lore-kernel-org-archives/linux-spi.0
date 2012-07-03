From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2 07/12] I2C: MV64XXX: Add Device Tree support
Date: Tue, 03 Jul 2012 17:59:13 +0200
Message-ID: <2232439.93KkEvHiYj@flexo>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-8-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1341325365-21393-8-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Andrew,

On Tuesday 03 July 2012 16:22:40 Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Also extend the
> kirkwood DT support to supply the needed properties.
> 
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
[snip]
> -	if ((pd->id != 0) || !pdata)
> +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
>  		return -ENODEV;

This is more a reminder than a real remark, but the driver here should not be 
limiting us to a single platform_device. In fact kirkwood55 (88F6282) has two 
I2C controllers for instance.

>  
>  	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> @@ -546,19 +549,35 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	init_waitqueue_head(&drv_data->waitq);
>  	spin_lock_init(&drv_data->lock);
>  
> -	drv_data->freq_m = pdata->freq_m;
> -	drv_data->freq_n = pdata->freq_n;
> -	drv_data->irq = platform_get_irq(pd, 0);
> +	if (pd->dev.of_node) {
> +		of_property_read_u32(pd->dev.of_node, "frequency-m",
> +				     &drv_data->freq_m);
> +		of_property_read_u32(pd->dev.of_node, "frequency-n",
> +				     &drv_data->freq_n);
> +		drv_data->irq = irq_of_parse_and_map(pd->dev.of_node, 0);
> +	} else {
> +		drv_data->freq_m = pdata->freq_m;
> +		drv_data->freq_n = pdata->freq_n;
> +		drv_data->irq = platform_get_irq(pd, 0);
> +	}
> +
>  	if (drv_data->irq < 0) {
>  		rc = -ENXIO;
>  		goto exit_unmap_regs;
>  	}
> +
>  	drv_data->adapter.dev.parent = &pd->dev;
>  	drv_data->adapter.algo = &mv64xxx_i2c_algo;
>  	drv_data->adapter.owner = THIS_MODULE;
>  	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> -	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> +	if (pd->dev.of_node)
> +		drv_data->adapter.timeout = msecs_to_jiffies(
> +			of_property_read_u32(pd->dev.of_node, "timeout-ms",
> +					     &drv_data->freq_n));
> +	else
> +		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
>  	drv_data->adapter.nr = pd->id;
> +	drv_data->adapter.dev.of_node = pd->dev.of_node;
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
>  
> @@ -577,6 +596,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		goto exit_free_irq;
>  	}
>  
> +	of_i2c_register_devices(&drv_data->adapter);
> +
>  	return 0;
>  
>  	exit_free_irq:
> @@ -602,12 +623,19 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	return rc;
>  }
>  
> +static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitdata 
= {
> +	{ .compatible = "marvell,mv64xxx-i2c", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
> +
>  static struct platform_driver mv64xxx_i2c_driver = {
>  	.probe	= mv64xxx_i2c_probe,
>  	.remove	= __devexit_p(mv64xxx_i2c_remove),
>  	.driver	= {
>  		.owner	= THIS_MODULE,
>  		.name	= MV64XXX_I2C_CTLR_NAME,
> +		.of_match_table = of_match_ptr(mv64xxx_i2c_of_match_table),
>  	},
>  };
>  
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
