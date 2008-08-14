From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.27-rc3] spi: bugfix
 spi_add_device() with duplicate chipselects
Date: Thu, 14 Aug 2008 14:14:38 -0700
Message-ID: <20080814141438.319dfb52.akpm@linux-foundation.org>
References: <200808140215.13641.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200808140215.13641.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 14 Aug 2008 02:15:13 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
> When reviewing a recent patch I noticed a potential trouble spot in
> the registration of new SPI devices.  The SPI master driver is told to
> set the device up before adding it to the driver model, so that it's
> always properly set up when probe() is called.  (This is important,
> because in the case of inverted chipselects, this device can make the
> bus misbehave until it's properly deselected.  It's got to be set up
> even if no driver binds to the device.)
> 
> The trouble spot is that it doesn't first verify that no other device
> has been added using that chipselect.  If such a device has been added,
> its configuration gets trashed.  (Fortunately this has not been a
> common error!)
> 
> The fix here adds an explicit check, and a mutex to protect the relevant
> critical region.
> 
> ...
>  
> +static DEFINE_MUTEX(spi_add_lock);
> +
>  /**
>   * spi_add_device - Add spi_device allocated with spi_alloc_device
>   * @spi: spi_device to register
> @@ -226,7 +228,7 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
>   * Companion function to spi_alloc_device.  Devices allocated with
>   * spi_alloc_device can be added onto the spi bus with this function.
>   *
> - * Returns 0 on success; non-zero on failure
> + * Returns 0 on success; negative errno on failure
>   */
>  int spi_add_device(struct spi_device *spi)
>  {
> @@ -246,26 +248,43 @@ int spi_add_device(struct spi_device *sp
>  			"%s.%u", spi->master->dev.bus_id,
>  			spi->chip_select);
>  
> -	/* drivers may modify this initial i/o setup */
> +
> +	/* We need to make sure there's no other device with this
> +	 * chipselect **BEFORE** we call setup(), else we'll trash
> +	 * its configuration.  Lock against concurrent add() calls.
> +	 */
> +	mutex_lock(&spi_add_lock);
>

It's neater to restrict the scope as much as possible.

--- a/drivers/spi/spi.c~spi-bugfix-spi_add_device-with-duplicate-chipselects-cleanup
+++ a/drivers/spi/spi.c
@@ -219,8 +219,6 @@ struct spi_device *spi_alloc_device(stru
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -232,6 +230,7 @@ static DEFINE_MUTEX(spi_add_lock);
  */
 int spi_add_device(struct spi_device *spi)
 {
+	static DEFINE_MUTEX(spi_add_lock);
 	struct device *dev = spi->master->dev.parent;
 	int status;
 
_


OK?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
