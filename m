From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: spi: spi-fsl-dspi: new(ish) memory leak in
 =?UTF-8?Q?dspi=5Fsetup=5Ftransfer=28=29?=
Date: Tue, 10 Feb 2015 17:54:39 +0100
Message-ID: <1ee64e5218bf046c00cbe97a5b04bc31@agner.ch>
References: <54d91b9c86b36_26777a33202121b@scan.coverity.com.mail>
 <20150209210741.GR18140@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150209210741.GR18140@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-02-09 22:07, Brian Norris wrote:
> Hi,
> 
> FYI, Coverity reported a "new" memory leak since this commit:
> 
>     commit 973fbce69ed8e79b5fe3ad19cfecb581a7ef8048
>     Author: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
>     Date:   Tue Jan 27 16:27:20 2015 +0530
> 
>         spi: spi-fsl-dspi: Remove usage of devm_kzalloc

Afaik, this has already been resolved by
https://lkml.org/lkml/2015/1/31/145

--
Stefan

> 
> On Mon, Feb 09, 2015 at 12:42:04PM -0800, scan-admin-S5/EvlXga/RWk0Htik3J/w@public.gmane.org wrote:
>> New defect(s) Reported-by: Coverity Scan
>> Showing 1 of 1 defect(s)
>>
>>
>> ** CID 1268408:  Resource leaks  (RESOURCE_LEAK)
>> /drivers/spi/spi-fsl-dspi.c: 356 in dspi_setup_transfer()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 1268408:  Resource leaks  (RESOURCE_LEAK)
>> /drivers/spi/spi-fsl-dspi.c: 356 in dspi_setup_transfer()
>> 350     	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
>> 351     		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
>> 352     	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
>> 353     		fmsz = spi->bits_per_word - 1;
>> 354     	} else {
>> 355     		pr_err("Invalid wordsize\n");
>> >>>     CID 1268408:  Resource leaks  (RESOURCE_LEAK)
>> >>>     Variable "chip" going out of scope leaks the storage it points to.
>> 356     		return -ENODEV;
>> 357     	}
>> 358
>> 359     	chip->void_write_data = 0;
>> 360
>> 361     	hz_to_spi_baud(&pbr, &br,
>>
>>
>> ________________________________________________________________________________________________________
>> To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/128?tab=overview
> 
> It's not exactly new, but it's more obvious now.
> 
> (The report requires login, which can be done through GitHub, but all
> the relevant details are in the email above.)
> 
> Regards,
> Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
