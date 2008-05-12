From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: Change modalias from a
 pointer to a character array
Date: Mon, 12 May 2008 15:18:05 -0700
Message-ID: <20080512151805.4c2763b9.akpm@linux-foundation.org>
References: <20080509173146.2932.16141.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080509173146.2932.16141.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
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

On Fri, 09 May 2008 11:32:28 -0600
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> Currently, 'modalias' in the spi_device structure is a 'const char *'.
> The spi_new_device() function fills in the modalias value from a passed
> in spi_board_info data block.  Since it is a pointer copy, the new
> spi_device remains dependent on the spi_board_info structure after the
> new spi_device is registered (no other fields in spi_device directly
> depend on the spi_board_info structure; all of the other data is copied).
> 
> This causes a problem when dynamically propulating the list of attached
> SPI devices.  For example, in arch/powerpc, the list of SPI devices can
> be populated from data in the device tree.  With the current code, the
> device tree adapter must kmalloc() a new spi_board_info structure for
> each new SPI device it finds in the device tree, and there is no simple
> mechanism in place for keeping track of these allocations.
> 
> This patch changes modalias from a 'const char *' to a fixed char array.
> By copying the modalias string instead of referencing it, the dependency
> on the spi_board_info structure is eliminated and an outside caller does
> not need to maintain a separate spi_board_info allocation for each device.
> 
> If searched through the code to the best of my ability for any references
> to modalias which may be affected by this change and haven't found anything.
> It has been tested with the lite5200b platform in arch/powerpc.
> 
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
> 
>  drivers/spi/spi.c       |    2 +-
>  include/linux/spi/spi.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 1ad12af..bdf1b70 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -229,7 +229,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
>  	proxy->max_speed_hz = chip->max_speed_hz;
>  	proxy->mode = chip->mode;
>  	proxy->irq = chip->irq;
> -	proxy->modalias = chip->modalias;
> +	strncpy(proxy->modalias, chip->modalias, KOBJ_NAME_LEN);
>  
>  	snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
>  			"%s.%u", master->dev.bus_id,
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 387e428..38a080b 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -82,7 +82,7 @@ struct spi_device {
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;
> -	const char		*modalias;
> +	char			modalias[KOBJ_NAME_LEN];
>  
>  	/*
>  	 * likely need more hooks for more protocol options affecting how

I'm not really able to work out if this is a needed-in-2.6.26 thing.  I
assumed "not".


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
