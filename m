From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 9/9] spi_mpc8xxx: s/83xx/8xxx/g
Date: Mon, 4 May 2009 13:53:27 -0700
Message-ID: <20090504135327.13cd42af.akpm@linux-foundation.org>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
	<20090430234833.GI7901@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090430234833.GI7901-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 1 May 2009 03:48:33 +0400
Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:

> Since we renamed the file, we might want to rename the file
> internals too.
> 
> Though we don't bother with changing platform driver name and
> platform module alias. The stuff is legacy and hopefully we'll
> remove it soon.
> 

but but but

>
> -static struct of_platform_driver of_mpc83xx_spi_driver = {
> -	.name		= "mpc83xx_spi",
> -	.match_table	= of_mpc83xx_spi_match,
> -	.probe		= of_mpc83xx_spi_probe,
> -	.remove		= __devexit_p(of_mpc83xx_spi_remove),
> +static struct of_platform_driver of_mpc8xxx_spi_driver = {
> +	.name		= "mpc8xxx_spi",
> +	.match_table	= of_mpc8xxx_spi_match,
> +	.probe		= of_mpc8xxx_spi_probe,
> +	.remove		= __devexit_p(of_mpc8xxx_spi_remove),
>  };

It _did_ change the platform driver name, didn't it?


This patch series had quite a lot of conflicts with the already-pending

spi-move-common-spi_setup-functionality-into-core.patch
spi-move-more-spi_setup-functionality-into-core.patch

which I beleive I successfully fixed up.

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
