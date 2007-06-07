From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Simple driver for Xilinx SPI
	controler.
Date: Thu, 7 Jun 2007 12:21:00 -0700
Message-ID: <200706071221.00571.david-b@pacbell.net>
References: <4666BF47.8080103@ru.mvista.com>
	<200706062209.09731.david-b@pacbell.net>
	<466850FB.5030505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linuxppc-embedded-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Andrei Konovalov <akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <466850FB.5030505-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
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

On Thursday 07 June 2007, Andrei Konovalov wrote:

> >> +/* Simple macros to get the code more readable */
> >> +#define xspi_in16(addr)		in_be16((u16 __iomem *)(addr))
> >> +#define xspi_in32(addr)		in_be32((u32 __iomem *)(addr))
> >> +#define xspi_out16(addr, value)	out_be16((u16 __iomem *)(addr), (value))
> >> +#define xspi_out32(addr, value)	out_be32((u32 __iomem *)(addr), (value))
> > 
> > I'm rather used to seeing I/O addressses passed around as "void __iomem *"
> > so those sorts of cast are not needed...  :)
> 
> I've decided to make the base_address (u8 __iomem *) to make it easier to
> add the register offsets to the base. Like that:

Adding register offsets works with "void __iomem *" too ...


> > You should not need an abort primitive.  ...
> 
> I am paranoid enough not to rely 100% on the spi_device's and the spi_bitbang
> doing all that :)
> Agreed, xspi_abort_transfer is bad name here. But I still would like to
> leave these two writes:
> 
> +	/* Deselect the slave on the SPI bus */
> +	xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
> +	/* Disable the transmitter */
> +	xspi_out16(regs_base + XSPI_CR_OFFSET,
> +		   XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT);
> 
> in xilinx_spi_remove(). Just in case :)

What happens when you add a BUG_ON to catch the device still being active?

Really, you need to rely on the rest of the system working correctly.



> > I take it you can't support SPI_CS_HIGH??
> 
> There is no clear indication in the SPI controller docs that SPI_CS_HIGH
> would work. I suspect it would as we don't use the ability of the controller
> to generate the chip selects automatically (the auto mode doesn't support SPI_CS_HIGH).
> But it is more safe to advertise SPI_CS_HIGH is not supported.

If you don't explicitly support it, it's unlikely to work.  :)

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
