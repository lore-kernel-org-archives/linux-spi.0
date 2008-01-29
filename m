From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Need help w/ SPI dataflash AT45DB011B on
	AT91RM9200 linux 2.6.20
Date: Tue, 29 Jan 2008 11:29:30 -0800
Message-ID: <200801291129.30497.david-b@pacbell.net>
References: <85a5c2010801290750j624ffe3bt3d30f5fb7d5df020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: "Matt Gessner" <mgessner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <85a5c2010801290750j624ffe3bt3d30f5fb7d5df020-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 29 January 2008, Matt Gessner wrote:
> Hello,
> 
> I've got what seems to be a very odd problem.  There's a specific word
> (offset 0x20000) in my dataflash that for some reason I can't change.
> 
> I wrote a simple program that does the following:
> http://rafb.net/p/RU5LPy71.html
>      a) open the dataflash via /dev/mtdblock/0, seek, read a 32-bit value, close
>      b) open the dataflash via /dev/mtdblock/0, seek, write a 32-bit
> value, close
>      c) open the dataflash via /dev/mtdblock/0, seek, read a 32-bit value, close
> 
> The value in c) is the same value as from a), not that which was
> written in b), which is horribly wrong.

If that were a character device, I'd agree with you.

But it's a block device ... and you're not doing I/O in
units of one block. Sso I would not expect that to work.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
