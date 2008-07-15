From: kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org
Subject: configuring SPI for use with the MMC
Date: Tue, 15 Jul 2008 13:19:10 -0500 (CDT)
Message-ID: <11122.216.207.242.34.1216145950.squirrel@www.texascellnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971636729=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--===============1971636729==
Content-Type: multipart/alternative;boundary="----=_20080715131910_62184"

------=_20080715131910_62184
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



In the new 2.6.24 kernel the SPI has to be selected to add the MMC over
spi functionality.

Is this correct?

I could not file
this to be true in the old blackfin driver.

If this is so then
do I have to mask out all other SPI devices?

Also which SSP
should be enabled for this?


Thanks,=20
Kbb

------=_20080715131910_62184
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In the new 2.6.24 kernel the SPI has to be selected to add the MMC over
spi functionality.<br /><br />Is this correct?<br /><br />I could not fil=
e
this to be true in the old blackfin driver.<br /><br />If this is so then
do I have to mask out all other SPI devices?<br /><br />Also which SSP
should be enabled for this?<br /><br /><br />Thanks, <br />Kbb
------=_20080715131910_62184--




--===============1971636729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1971636729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1971636729==--
