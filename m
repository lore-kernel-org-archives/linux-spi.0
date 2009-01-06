From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Tue, 6 Jan 2009 09:14:19 +0100
Message-ID: <200901060914.19435.sr@denx.de>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<20090106020603.GA14074@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090106020603.GA14074-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Anton,

On Tuesday 06 January 2009, Anton Vorontsov wrote:
> > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > 4xx PowerPC's.
> >
> > Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> > Signed-off-by: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
> > Acked-by: Josh Boyer <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> > ---
>
> [...]
>
> > +static unsigned int of_num_gpios(struct device_node *node)
> > +{
> > +	unsigned int num = 0;
> > +
> > +	while (gpio_is_valid(of_get_gpio(node, num)))
> > +		num++;
> > +	return num;
> > +}
>
> FYI, as of commit 749820928a2fd47ff536773d869d2c3f8038b7d1 ("of/gpio:
> Implement of_gpio_count()") you can use of_gpio_count() from
> linux/of_gpio.h.

Thanks for the hint. I'll use it in the next version.

Best regards,
Stefan

------------------------------------------------------------------------------
