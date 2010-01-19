From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: dw_spi: refine the IRQ
 mode working flow
Date: Tue, 19 Jan 2010 09:20:53 -0500
Message-ID: <4B55BFC5.506@octasic.com>
References: <20100119112033.74a0f5be@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100119112033.74a0f5be@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Feng,

Feng Tang wrote:
>  	dws->num_cs = 4;
>  	dws->max_freq = 25000000;	/* for Moorestwon */
>  	dws->irq = pdev->irq;
> +	dws->fifo_len = 40;		/* FIFO has 40 words buffer */
>
>  	ret = dw_spi_add_host(dws);
>
>   
Since we'll be sharing some of our init code, as well as some of our 
init values, would it be a good idea to move:
"dws->num_cs = 4;" and "dws->fifo_len = 40;"

into dw_spi_add_host(), if no values were provided by the caller?

 example:
--------------------------- [PATCH] ------------------
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 31620fa..01ad79a 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -832,6 +832,11 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
                goto exit;
        }
 
+       if (!dws->num_cs)
+               dws->num_cs = 4;
+       if (!dws->fifo_len)
+               dws->fifo_len = 40;
+      
        dws->master = master;
        dws->type = SSI_MOTO_SPI;
        dws->prev_chip = NULL;



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
