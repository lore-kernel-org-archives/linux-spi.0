From: Daniel Santos <danielfsantos-fOdFMYwuEsI@public.gmane.org>
Subject: Re: New driver for MCP2210 (USB to SPI bridge w/GPIO)
Date: Sat, 13 Apr 2013 23:35:36 -0500
Message-ID: <516A3218.1090005@att.net>
References: <5169DE3F.5030909@att.net>
Reply-To: Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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


>   4. How do I specify in my specific driver that it's dependent upon the
>      generic MCP2210 driver?  I know that's easy if it's in-tree via
>      Kconfig, but out-of-tree, during module_init or some such?
hah! Well I appear to have answered two of my own questions now. Looks 
like depmod actually figures out what unresolved symbols you have and 
find the modules that way, very nice!  Maybe this also answers my 5th 
question as well.

Daniel


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
