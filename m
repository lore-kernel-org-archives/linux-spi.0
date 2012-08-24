From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi/mxs: Fix device remove function
Date: Fri, 24 Aug 2012 16:18:15 -0700
Message-ID: <20120824231815.GA7833@roeck-us.net>
References: <1345831382-7290-1-git-send-email-linux@roeck-us.net>
	<201208242210.12924.marex@denx.de>
	<20120824203739.GA7592@roeck-us.net>
	<201208250007.38141.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201208250007.38141.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Aug 25, 2012 at 12:07:37AM +0200, Marek Vasut wrote:
[ ... ]

> 
> > On a side note, at least some of the spi bitbang drivers have a similar
> > problem. Unfortunately, I can not fix it right now because I have no means
> > to test it, and have no idea what exactly is _supposed_ to happen.
> 
> Which ones?
> 
Looking into spi-xilinx.c:

	master = spi_alloc_master(dev, sizeof(struct xilinx_spi));
	...
	xspi->bitbang.master = spi_master_get(master);
	...
	return master;

put_master:
        spi_master_put(master);
	return NULL;

The call to spi_master_put() releases the reference obtained with
spi_alloc_master, but not the second reference obtained with spi_master_get,
even though there are several jumps to the error exit label. That doesn't
look right. The remove/deinit function calls spi_master_put, which seems to
match the extra spi_master_get in the init function (assuming that
spi_bitbang_stop releases the resource allocated with spi_alloc_master).

In spi-sirf.c, it is even more obvious that there is a problem since "goto
free_master;" is executed before _and_ after the call to spi_master_get.

Then there is spi-ppc4xx.c. Similar to the drivers above, there is an extra
spi_master_get in the probe function, and the error path misses it.
However, in this case, the call to spi_master_put is _missing_ in the remove
function. So this is inconsistent. Either the remove function in spi-ppc4xx.c is
wrong, or the remove functions in the other drivers are wrong.

Those are just examples - actually the first three bitbang drivers I picked at
random.

What I don't know is how the call sequence spi_alloc_master / spi_bitbang_start
/ spi_bitbang_stop() is 'complete', or, in other words, if the call to
spi_bitbang_stop releases the resource allocated with spi_alloc_master.
Presumably it should be equivalent to spi_alloc_master / spi_register_master
/ spi_unregister_master, meaning spi_bitbang_stop should release the resource
obtained with spi_alloc_master. However, this is something I would want to
verify with actual hardware and code execution before I start to submit
any patches.

Hope this isn't too complicated ...

Thanks,
Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
