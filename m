From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-rc2-git] SPI: add 3wire mode
	flag
Date: Wed, 23 May 2007 08:43:50 -0700
Message-ID: <200705230843.51147.david-b@pacbell.net>
References: <200705221242.49050.david-b@pacbell.net>
	<20070523134853.69e5170b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kaiwan N Billimoria <kaiwan-IEKcLuOed2vyqGx8YZ3XskEOCMrvLtNR@public.gmane.org>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070523134853.69e5170b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 23 May 2007, Jean Delvare wrote:
> > --- g26.orig/drivers/hwmon/lm70.c	2007-05-22 09:00:24.000000000 -0700
> > +++ g26/drivers/hwmon/lm70.c	2007-05-22 09:06:44.000000000 -0700
> > @@ -96,6 +96,10 @@ static int __devinit lm70_probe(struct s
> >  	struct lm70 *p_lm70;
> >  	int status;
> >  
> > +	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
> > +	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !spi->mode & SPI_3WIRE)
> 
> I don't know anything about SPI, but the second half of the test looks
> broken to me. Missing parentheses?

Right, my bad ... Kaiwan would surely have seen that in his testing
(by next week, I'm told).

Andrew:  incremental fix appended.


> Also note that (SPI_CPOL|SPI_CPHA) 
> is SPI_MODE_3 according to the defines above, maybe you want to use
> that.

No; I wanted to explicitly highlight that neither mode bit may be set.
It's not obvious that "mode 3" would be valid as a mask.

- Dave


======	CUT HERE
Add missing parenthesis ... evidently GCC warns inconsistently.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hwmon/lm70.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- g26.orig/drivers/hwmon/lm70.c	2007-05-23 08:30:36.000000000 -0700
+++ g26/drivers/hwmon/lm70.c	2007-05-23 08:40:52.000000000 -0700
@@ -97,7 +97,7 @@ static int __devinit lm70_probe(struct s
 	int status;
 
 	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
-	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !spi->mode & SPI_3WIRE)
+	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
 		return -EINVAL;
 
 	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
