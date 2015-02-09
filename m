From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi: spi-fsl-dspi: new(ish) memory leak in dspi_setup_transfer()
Date: Mon, 9 Feb 2015 13:07:41 -0800
Message-ID: <20150209210741.GR18140@ld-irv-0074>
References: <54d91b9c86b36_26777a33202121b@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54d91b9c86b36_26777a33202121b-lbsL4oTxM+QrR8w/LlRrqHGm410w5Vya@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

FYI, Coverity reported a "new" memory leak since this commit:

    commit 973fbce69ed8e79b5fe3ad19cfecb581a7ef8048
    Author: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
    Date:   Tue Jan 27 16:27:20 2015 +0530

        spi: spi-fsl-dspi: Remove usage of devm_kzalloc


On Mon, Feb 09, 2015 at 12:42:04PM -0800, scan-admin-S5/EvlXga/RWk0Htik3J/w@public.gmane.org wrote:
> New defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
> 
> 
> ** CID 1268408:  Resource leaks  (RESOURCE_LEAK)
> /drivers/spi/spi-fsl-dspi.c: 356 in dspi_setup_transfer()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1268408:  Resource leaks  (RESOURCE_LEAK)
> /drivers/spi/spi-fsl-dspi.c: 356 in dspi_setup_transfer()
> 350     	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
> 351     		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
> 352     	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
> 353     		fmsz = spi->bits_per_word - 1;
> 354     	} else {
> 355     		pr_err("Invalid wordsize\n");
> >>>     CID 1268408:  Resource leaks  (RESOURCE_LEAK)
> >>>     Variable "chip" going out of scope leaks the storage it points to.
> 356     		return -ENODEV;
> 357     	}
> 358     
> 359     	chip->void_write_data = 0;
> 360     
> 361     	hz_to_spi_baud(&pbr, &br,
> 
> 
> ________________________________________________________________________________________________________
> To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/128?tab=overview

It's not exactly new, but it's more obvious now.

(The report requires login, which can be done through GitHub, but all
the relevant details are in the email above.)

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
