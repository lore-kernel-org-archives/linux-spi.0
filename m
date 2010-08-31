From: "Soulard, MathieuX" <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: controller_data handling through spidev.c
Date: Tue, 31 Aug 2010 14:58:49 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496irsmsx501gerc_"
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496irsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm using spidev.c to test a SPI controller driver from the user space. Act=
ually some SPI controller drivers handle a specific spi_device.controller_d=
ata as input in their setup operation, and the controller driver I'm testin=
g uses this field in its setup operation, if provided.

The driver spidev.c handles many commands through ioctl but it does not pro=
vide a way to setup a specific controller_data.

I would like to get your opinion about this field usage from the protocol d=
river, since I'm not sure to understand the way this field has be used: is =
it really supposed to be used by the protocol driver to deliver some contro=
ller's specific setup, or, is it a field we should ignore from the protocol=
 driver perspective as it is supposed to be only managed by the controller =
driver if it needs it ?

Then, I would like to get your opinion about the attached patch I'm using t=
o get an access to controller_data from the user space. I wrote this patch =
since the SPI driver I'm testing handles a specific spi_device.controller_d=
ata in its setup operation. It allows me to provide it from user space thro=
ugh spidev.c.


Thanks
Regards

Mathieu
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496irsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496irsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496irsmsx501gerc_--
