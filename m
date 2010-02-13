From: Ben Gamari <bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI-ADC
Date: Sat, 13 Feb 2010 01:38:16 -0500
Message-ID: <1266042736-sup-3579@ben-laptop>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <dc6d3181002122148v6451ebffka164de288738485d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Excerpts from arjun rath's message of Sat Feb 13 00:48:40 -0500 2010:
> Hi everybody,
> 
> can anybody share how to start a spi based ADC linux driver.I am having a
> MAXIM 1242 ADC chip.
> 
> Can anybody share some reference driver for the same chip
> 
I've recently been working on a design for a data acquisition
board to interface with the Beagle Board using the Maxim 5134 and 1270.
I'm using the spidev driver to interface with the devices from
user-space. Documentation on this driver can be found in the
Documentation/spi/spidev file of the Linux kernel tree. My code can be
found at [1]. Hope things are going well,

- Ben


[1] http://goldnerlab.physics.umass.edu/git?p=tracker.git;a=tree

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
