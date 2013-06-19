From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi controller master
 driver for Blackfin 6xx processor
Date: Wed, 19 Jun 2013 19:39:28 +0100
Message-ID: <20130619183928.GE1403@sirena.org.uk>
References: <1371583828-23788-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5905325496910731273=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1371583828-23788-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============5905325496910731273==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PC9bQVTfFuJ+mkID"
Content-Disposition: inline


--PC9bQVTfFuJ+mkID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2013 at 03:30:28PM -0400, Scott Jiang wrote:
> New spi controller is integrated into Blackfin 6xx processor.
> Comparing to bf5xx spi controller, we support 32 bits word size
> and independent receive and transmit DMA channels now.
> Also mode 0 and 2 (CPHA = 0) can get fully supported
> becasue cs line may be controlled by the software.

A few nits here but mostly looking good.

> +	switch (spi->bits_per_word) {
> +	case 8:
> +	case 16:
> +	case 32:
> +		break;
> +	default:
> +		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
> +				spi->bits_per_word);
> +		return -EINVAL;
> +	}

Just set bits_per_word_mask in the master struct and let the core do
this for you.

> +	if (chip->cs < MAX_CTRL_CS) {
> +		peripheral_free(ssel[spi->master->bus_num]
> +					[chip->cs-1]);
> +		bfin_spi_cs_disable(drv_data, chip);
> +	} else
> +		gpio_free(chip->cs_gpio);

Braces on both sides of the if.

> +	drv_data->regs = devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(drv_data->regs)) {
> +		dev_err(dev, "can not map register memory\n");
> +		ret = PTR_ERR(drv_data->regs);
> +		goto err_put_master;
> +	}

devm_ioremap_resource() will display an error message for you so you
don't need to bother, though in any case the return code should
generally be displayed.

> +#ifdef CONFIG_PM
> +		.pm     = &bfin_spi_pm_ops,
> +#endif

Use SET_SYSTEM_SLEEP_PM_OPS().

> +static int __init bfin_spi_init(void)
> +{
> +	return platform_driver_probe(&bfin_spi_driver, bfin_spi_probe);
> +}
> +subsys_initcall(bfin_spi_init);

Should really use module_platform_driver() on modern systems, the
deferred probe infrastructure should remove the need for faffing around
with init order.

> +MODULE_DESCRIPTION("Analog Devices SPI3 controller driver");

Why not call the driver something like bfin_spi3 then?

--PC9bQVTfFuJ+mkID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwfrdAAoJELSic+t+oim93oAP+QEaST05gJafazh67n3ikQJo
AvAUO9akXNh6SR+JXNkfsU1314N0ev796Ztjho3Zm8OTx4jRf8tofX0ywRnpqrpF
UGIGsCPlzNUrzvJsb7rWS/wmGKynWOmG+Vifkp9t2aLuM5lTuL4KNIoT4zR1I9Wo
ar/u68I+7SyO+q3uZ5gUtUNhjsEr0hwzKOXBsvZEMSDVMdFRIM7uPrCfUhj+3Wmp
4CVTYGPRcydiqEP5JBKdbEemv7Rgq3bD4m9IpdzSSmDH/YvHrNae0hvCx2ij4jix
8/SZTup3yZ+/RSNpTJ8Ko6KPLRYKXegLOfdWjcBzYH1BK7y3li2z2+ky2t0ZXPjJ
gmBjY89CgeodbWODCVXWBAyaaBd7SiYe2plr8RIFjU3vmiBUpNWYo9BQkEjH15Uw
iaW9iSaSHluTqBeqiEfvePEDjChnw/9AQN5wGIQHaVSwGYCOL4IZ6Jhi7JZ3sBJi
ajosyEsCCp8lcDMHCDLJRl6MmGXNJkV4JqdVxKXQgNJs++nCT5R8WduN+Gtt2vPf
4Xozwzr9rIPpOKALo3l4OMZp5uRwDYWX5z0h6vWWAF4LDM6FkZIJwS91cZFZzHBS
8pOadHR/sLZG9ZA7LpWV++yN//8hewp2fp9WuP/ycnQXtvXUz3gaJG40M6YNbvmJ
lG8TZltxfZacokIrhZnM
=b70w
-----END PGP SIGNATURE-----

--PC9bQVTfFuJ+mkID--

--===============5905325496910731273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============5905325496910731273==--
