From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/12] spi : Use mutex instead of semaphore in driver core
Date: Fri, 28 Dec 2007 17:37:12 -0800
Message-ID: <200712281737.13145.david-b@pacbell.net>
References: <20071229011858.GL2883@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Dave Young <hidave.darkstar@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754901AbXL2Bha@vger.kernel.org>
In-Reply-To: <20071229011858.GL2883@darkstar.te-china.tietoenator.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 28 December 2007, Dave Young wrote:
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

ACK ... if the driver core is changing, this is obvious.
 
> ---
> drivers/spi/spi.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -upr linux/drivers/spi/spi.c linux.new/drivers/spi/spi.c
> --- linux/drivers/spi/spi.c	2007-12-28 10:47:38.000000000 +0800
> +++ linux.new/drivers/spi/spi.c	2007-12-28 10:48:22.000000000 +0800
> @@ -494,7 +494,7 @@ struct spi_master *spi_busnum_to_master(
>  	struct spi_master	*master = NULL;
>  	struct spi_master	*m;
>  
> -	down(&spi_master_class.sem);
> +	mutex_lock(&spi_master_class.mutex);
>  	list_for_each_entry(dev, &spi_master_class.children, node) {
>  		m = container_of(dev, struct spi_master, dev);
>  		if (m->bus_num == bus_num) {
> @@ -502,7 +502,7 @@ struct spi_master *spi_busnum_to_master(
>  			break;
>  		}
>  	}
> -	up(&spi_master_class.sem);
> +	mutex_unlock(&spi_master_class.mutex);
>  	return master;
>  }
>  EXPORT_SYMBOL_GPL(spi_busnum_to_master);
> 


