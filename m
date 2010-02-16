From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] of: add bus-number specification to
	spi_mpc8xxx
Date: Tue, 16 Feb 2010 19:59:43 +0100
Message-ID: <20100216195943.e40e104e.eschwab@online.de>
References: <20100216150850.d966cd79.eschwab@online.de>
	<fa686aa41002160628g62bd6564h50e712e8fb9c384d@mail.gmail.com>
	<20100216160832.730cb00b.eschwab@online.de>
	<fa686aa41002160718u36fe6f7ey7be83ab69317ec76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41002160718u36fe6f7ey7be83ab69317ec76-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> Add a property to the /chosen node to assign short labels to devices.

I'm not familiar with this and will check - does anyone know of an
existing example for this? 

> Unless you're trying to line up disparate data structure, the actually
> number assigned to a bus really doesn't matter.  It is better to let
> Linux dynamically assign than to manually maintain the assigned bus
> numbers for each machine.  Assuming dynamic assignment also protects
> against breaking userspace applications when, for whatever reason, the
> bus numbers get shuffled on a platform.

Hm. What if we have two identical devices, lets say EEPROMs at25,
connected to two SPI controllers. These are set up as 
/sys/bus/spi/devices/spi32766.0/eeprom and 
/sys/bus/spi/devices/spi32765.0/eeprom. 
How can userspace code determine which one it should 
use if it needs to use the one connected to the first spi controller?
Can this be solved with the /chosen mechanism?

Regards
Ernst

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
