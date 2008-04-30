From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.25-git] spi_mpc83xx much
	improved driver
Date: Wed, 30 Apr 2008 15:46:31 -0700
Message-ID: <20080430154631.b86797de.akpm@linux-foundation.org>
References: <200804301537.07965.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org,
	joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804301537.07965.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 30 Apr 2008 15:37:07 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> Date: Fri, 11 Apr 2008 18:57:21 +0200
> Subject: [PATCH] Much improved mpc83xx SPI driver.
> 
> The current driver may cause glitches on SPI CLK line since one must
> disable the SPI controller before changing any HW settings.  Fix this
> by implementing a local spi_transfer function that won't change speed
> and/or word size while CS is active.
> 
> While doing that heavy lifting a few other issues were addressed too:
>  - Make word size 16 and 32 work too.
>  - Honor bits_per_word and speed_hz in spi transaction.
>  - Optimize the common path.
> 
> This also stops using the "bitbang" framework (except for a few
> constants).
>
> ...
>
> +static void mpc83xx_spi_work(struct work_struct *work)
> +{
> +	struct mpc83xx_spi *mpc83xx_spi =
> +		container_of(work, struct mpc83xx_spi, work);
> +
> +	spin_lock_irq(&mpc83xx_spi->lock);

irq-safe.

> ...
>
> +	spin_lock(&mpc83xx_spi->lock);

not irq-safe.

Deliberate?



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
