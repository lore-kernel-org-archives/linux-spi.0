From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] SPI: spi_sh_msiof: cosmetic clean-up
Date: Tue, 25 Jan 2011 15:02:29 +1000
Message-ID: <20110125050229.GA7183@verge.net.au>
References: <Pine.LNX.4.64.1101211654280.18867@axis700.grange>
 <20110121170247.GB7477@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110121170247.GB7477@angua.secretlab.ca>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 21, 2011 at 10:02:47AM -0700, Grant Likely wrote:
> On Fri, Jan 21, 2011 at 04:56:37PM +0100, Guennadi Liakhovetski wrote:
> > 1. sort headers alphabetically
> > 2. use fixed-size types u8, u16, u32 for register values and transferred data
> > 3. simplify some arithmetic operations
> > 4. remove leading spaces in front of labels
> 
> There's actually good reason to leave these labels alone.  Labels in
> column zero confuse diff and it gives the wrong function name.  For
> example:
> 
> diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
> index 658bd05..840164b 100644
> --- a/drivers/spi/spi_sh_msiof.c
> +++ b/drivers/spi/spi_sh_msiof.c
> @@ -682,7 +682,7 @@ err2:
>         clk_put(p->clk);
>  err1:
>         spi_master_put(master);
> -err0:
> + err0:
>         return ret;
>  }
> 
> See how the function name in the @@ line is 'err2' instead of
> sh_msiof_spi_probe() in this example?  Indenting the labels by one
> space is an easy fix and is intentional.
> 
> I've picked up the patch, but I've dropped the last two hunks.

Surely this is a bug in diff. Or perhaps put more politely,
diff isn't smart enough to realise a) this is C and b) xxx: isn't
a valid function name in C.
