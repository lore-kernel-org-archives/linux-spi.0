From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi_set_drvdata() handling in spidev_probe()
Date: Tue, 13 Oct 2009 02:32:12 -0400
Message-ID: <8bd0f97a0910122332y321138ak8294e5f152064344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

i was browsing the change history of spidev when i noticed the change:
aaacf4bb51b243875b203e6ff73b5047636b4efa spi: avoid spidev crash when
device is removed

which seems to be due to this change:
3d81252ddb10f63ae4db713d9b32faabe641b850 device create: spi: convert
device_create to device_create_drvdata

getting an incomplete revert with this change:
a9b12619f7b6f19c871437ec24a088787a04b1de device create: misc: convert
device_create_drvdata to device_create

my point being is that the original code was doing the
spi_set_drvdata() while holding the device_list_lock mutex while the
new one is not.  shouldnt the code be changed back to the state
previous to 3d81252d ?
-mike

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
