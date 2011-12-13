From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: Fix device unregistration when unregistering the
	bus master
Date: Tue, 13 Dec 2011 16:45:20 -0700
Message-ID: <20111213234520.GA24922@ponder.secretlab.ca>
References: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw@mail.gmail.com>
	<1323648906-24863-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323648906-24863-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 12, 2011 at 01:15:06AM +0100, Laurent Pinchart wrote:
> Device are added as children of the bus master's parent device, but
> spi_unregister_master() looks for devices to unregister in the bus
> master's children. This results in the child devices not being
> unregistered.
> 
> Fix this by registering devices as direct children of the bus master.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/spi/spi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 2e13a14..b423fe9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -318,7 +318,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
>  	}
>  
>  	spi->master = master;
> -	spi->dev.parent = dev;
> +	spi->dev.parent = &master->dev;
>  	spi->dev.bus = &spi_bus_type;
>  	spi->dev.release = spidev_release;
>  	device_initialize(&spi->dev);

Yes, I agree and I think this is the correct fix.  However, I'd like
to make sure it behaves correctly.  Can you test and confirm that
with this patch in place and an spi_device in use (bound to a driver)
that the kernel will either refuse to unbind the driver, or correctly
release the spi_driver from the spi_device?

Thanks,
g.


------------------------------------------------------------------------------
Cloud Computing - Latest Buzzword or a Glimpse of the Future?
This paper surveys cloud computing today: What are the benefits? 
Why are businesses embracing it? What are its payoffs and pitfalls?
http://www.accelacomm.com/jaw/sdnl/114/51425149/
