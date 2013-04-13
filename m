From: Daniel Santos <danielfsantos-fOdFMYwuEsI@public.gmane.org>
Subject: Re: New driver for MCP2210 (USB to SPI bridge w/GPIO)
Date: Sat, 13 Apr 2013 18:47:29 -0500
Message-ID: <5169EE91.9080308@att.net>
References: <5169DE3F.5030909@att.net>
Reply-To: Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5169DE3F.5030909-fOdFMYwuEsI@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


>   3. When my driver is called via the functions exported in the struct
>      spi_master after I register it with spi_register_master(), I'm
>      presuming these will never be in an interrupt context (soft or
>      hard).  Is that correct?  (I'm planning on using simple mutexes for
>      locking.)

Correction, I'll be calling transfer_one_message() instead of 
transfer(), as I now see that this function is depreciated (thanks to 
the output in dmesg).  And the docs say that I can sleep in these 
functions, so I presume that mutex_(un)lock is fine.

Daniel

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
