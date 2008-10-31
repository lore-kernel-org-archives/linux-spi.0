From: Josh Boyer <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Date: Fri, 31 Oct 2008 06:34:48 -0400
Message-ID: <20081031063448.3fcb3421@zod.rchland.ibm.com>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
	<200810310931.19565.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200810310931.19565.sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 31 Oct 2008 09:31:19 +0100
Stefan Roese <sr-ynQEQJNshbs@public.gmane.org> wrote:

> On Wednesday 29 October 2008, Josh Boyer wrote:
> > Looks pretty good.  Just a few minor comments/questions below.
> 
> Thanks. I also added some comments below.
> 
> > Also, do you have a patch for a DTS file that gives an example of how to
> > instantiate the SPI stuff in the device tree?
> 
> OK, I'll add a DTS patch to the next version.

Ok thanks.

> > >+	/* send the first byte */
> > >+	data = hw->tx ? hw->tx[0] : 0;
> > >+	out_8(&hw->regs->txd, data);
> > >+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
> >
> > Maybe iowrite8?  Same comment elsewhere.
> 
> Why? We use the in_/out_xxx() accessor function for all other 4xx driver as 
> well.

Yeah.  We used to have all of 4xx in arch/ppc too.  ;)

Seriously though, it doesn't really bother me too much.  The
io{read,write} functions do have a bit better clarity as to endian-ness
though.

> > >+	wait_for_completion(&hw->done);
> > >+
> > >+	return hw->count;
> > >+}
> > >+
> >
> > <snip>
> >
> > >+static struct of_device_id spi_ppc4xx_of_match[] = {
> > >+	{ .compatible = "ibm,spi", },
> > >+	{},
> > >+};
> >
> > I'm wondering if that is too generic of a match.  In theory,
> > IBM could have another SPI controller that isn't for 4xx.
> > Maybe "ibm,spi-4xx" ?
> 
> Right. I was doing it the same way as already done before, e.g. "ibm,iic". For 
> the gpio driver we already switched to "ibm,ppc4xx-gpio". So how 
> about "ibm,ppc4xx-spi"?

Sounds fine to me.

josh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
