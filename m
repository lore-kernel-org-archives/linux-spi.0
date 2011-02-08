From: LEROY christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Issue linked to component 821034 from IDT
Date: Tue, 08 Feb 2011 19:05:51 +0100
Message-ID: <4D5185FF.5030900@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Good afternoon,

I'm trying to program a Quad CODEC from IDT reference 821034 through 
SPI, and I'm having an issue:

The component requires 2 clock cycles in addition after setting CS back 
to inactive state, otherwise the transmitted data is not latched in. I'm 
wondering how I could do that easily in a Linux driver using the 
standard SPI subsystem.
What I could do is to transmit a 2 bits data after setting CS to OFF 
state, but how can I do that ?

Also, another issue I have is that between each byte I shall set CS to 
OFF for at least 3 clock cycles. This can be done of course by sending 
bytes one by one, but is there another easy way to do the same by 
configuration ?

Regards
C. Leroy

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
