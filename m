From: Kevyn-Alexandre =?ISO-8859-1?Q?Par=E9?= <kapare-7qmld2CjetYf4mhTGKTGE9BPR1lH4CV8@public.gmane.org>
Subject: How to mesure current SPI transfer speed
Date: Fri, 07 Jan 2011 13:51:59 -0500
Message-ID: <1294426319.3892.11.camel@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	gumstix-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

What's the best way to calculate the current SPI transfer speed?

Right now I use something like that and transfer one spi_message with 1
spi_transfer of 100000 bytes and I do the math... I know that this is
not accurate and was wondering if anyone have a better way?


struct timeval tv_before;
struct timeval tv_after;

do_gettimeofday(&tv_before);
    status = spi_sync(spike_dev.spi_device, &spike_ctl.msg);
do_gettimeofday(&tv_after);
    long elapsedTime = (tv_after.tv_usec - tv_before.tv_usec);


Thx

--
Kevyn-Alexandre Pare


------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
