From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Tue, 21 Aug 2012 12:49:36 -0700
Message-ID: <20120821194936.GA7145@roeck-us.net>
References: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336772086-17248-3-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 11, 2012 at 08:34:46PM -0000, David Daney wrote:
> From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> Add the driver, link it into the kbuild system and provide device tree
> binding documentation.
> 
> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
[ ... ]

> +
> +static int __devexit octeon_spi_remove(struct platform_device *pdev)
> +{
> +	struct octeon_spi *p = platform_get_drvdata(pdev);
> +	struct spi_master *master = p->my_master;
> +
> +	spi_unregister_master(master);
> +

I know it is a bit late, but ...

The call to spi_unregister_master() frees the memory associated with master,
ie 'p', and the spi_master_put() below without matching spi_master_get() is
unnecessary/wrong. One possible fix would be to use 

	struct spi_master *master = spi_master_get(p->my_master);

above. That protects master and p while it is still being used, and makes use
of the call to spi_master_put() below. Another option might be to move
cvmx_write_csr() ahead of the call to spi_unregister_master() and drop the
call to spi_master_put().

Guenter

> +	/* Clear the CSENA* and put everything in a known state. */
> +	cvmx_write_csr(p->register_base + OCTEON_SPI_CFG, 0);
> +	spi_master_put(master);
> +	return 0;
> +}
> +

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
