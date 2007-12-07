From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: atmel_spi driver
Date: Fri, 07 Dec 2007 10:22:16 -0800
Message-ID: <20071207182216.1DE59F6DFD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <015e01c838d5$6b2b2bc0$2b00a8c0@ARV127>
	<20071207144955.54cf14e4@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: rini-uOUtDB0q1vc@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071207144955.54cf14e4-STKoQgiEtS/cug01aK12UsGzbamoMwWuEvhb3Hwu1Ks@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > Atached is a patch (for the 2.6.23.9 kernel) which loads the RCR
> > before the TCR. After this patch the fifo overrun disapears at out setup.
>
> Ah, nice catch. Thanks.
>
> > Please review it and let me know if you need more details.
>
> Makes sense to me. David, do you think this one should go in before
> 2.6.24? It may solve some of the other overrun problems people have
> been seeing as well, especially those happening at low speed.
>
> Btw, Rini, could you sign off the patch as well? Please see
> Documentation/SubmittingPatches if you don't know what this means.

Yes, bugfixes like this are clear 2.6.24 material.

I'll forward it for such merge as son as I get a copy with
signoff from Rini.

- Dave


-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
