From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.26+] spi:  new orion_spi driver
Date: Mon, 28 Jul 2008 21:16:55 -0700
Message-ID: <20080728211655.4d51e921.akpm@linux-foundation.org>
References: <200807221228.00958.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lennert-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org, saeed <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>, Buijtenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200807221228.00958.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 22 Jul 2008 12:28:00 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: Fri, 27 Jun 2008 19:10:06 +0200
> Subject: [PATCH] spi: driver for Marvell Orion SPI controllers
> 
> This adds a SPI driver for the SPI controller found in various
> Marvell Orion ARM SoCs.  It currently supports only one slave,
> which must use SPI mode 0.
> 
> [ dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: cleanups, meet specs, pass "sparse" ]
> Signed-off-by: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>
> ...
>
> +/*
> + * called only when no transfer is active on the bus
> + */
> +static int
> +orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct orion_spi *orion_spi;
> +	unsigned int speed = spi->max_speed_hz;
> +	unsigned int bits_per_word = spi->bits_per_word;
> +
> +	orion_spi = spi_master_get_devdata(spi->master);
> +
> +	if ((t != NULL) && t->speed_hz)
> +		speed = t->speed_hz;
> +
> +	if ((t != NULL) && t->bits_per_word)
> +		bits_per_word = t->bits_per_word;
> +
> +	if (orion_spi_baudrate_set(spi, speed) != 0)
> +		return -EINVAL;
> +
> +	if (orion_spi_set_transfer_size(orion_spi, bits_per_word) != 0)
> +		return -EINVAL;

Given that orion_spi_baudrate_set() and orion_spi_set_transfer_size()
carefully return an -EFOO value, it's a bit unkind to just rub that out
and return a hard-coded -EINVAL.

> ...
>
> +static void __exit orion_spi_exit(void)
> +{
> +	platform_driver_unregister(&orion_spi_driver);
> +
> +	destroy_workqueue(orion_spi_wq);
> +}

Please double-check the workqueue handling.  Without looking at it too
closely, I think that this is waaaay too late to be running
destroy_workqueue().  If a work is still pending, all the data upon
which it will be operating will have been rubbed out.  I'm suspecting
that an earlier flush_work() (or similar) will be needed.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
