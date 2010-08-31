From: "Soulard, MathieuX" <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: controller_data handling through spidev.c
Date: Tue, 31 Aug 2010 15:25:50 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AF@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AFirsmsx501gerc_"
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

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AFirsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

It seems the patch that I mentioned in my previous mail has been trashed, h=
ere is this path:

>From 97ad3082149695f14e621861e73ef03fa1b33ec7 Mon Sep 17 00:00:00 2001
From: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Fri, 27 Aug 2010 10:33:11 +0200
Subject: [PATCH] Add controller_data ioctl accessor to spidev.c

Signed-off-by: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c       |   70 ++++++++++++++++++++++++++++++----------=
----
 include/linux/spi/spidev.h |    3 ++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index ea1bec3..21d7991 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -433,36 +433,62 @@ spidev_ioctl(struct file *filp, unsigned int cmd, uns=
igned long arg)

               default:
                              /* segmented and/or full-duplex I/O request */
-                             if (_IOC_NR(cmd) !=3D _IOC_NR(SPI_IOC_MESSAGE=
(0))
+                            if ((_IOC_NR(cmd) !=3D _IOC_NR(SPI_IOC_MESSAGE=
(0)) &&
+                                           _IOC_NR(cmd) !=3D _IOC_NR(SPI_I=
OC_WR_CTRL_DATA(0)))
                                                            || _IOC_DIR(cmd=
) !=3D _IOC_WRITE) {
                                             retval =3D -ENOTTY;
                                             break;
                              }

-                             tmp =3D _IOC_SIZE(cmd);
-                             if ((tmp % sizeof(struct spi_ioc_transfer)) !=
=3D 0) {
-                                            retval =3D -EINVAL;
-                                            break;
-                             }
-                             n_ioc =3D tmp / sizeof(struct spi_ioc_transfe=
r);
-                             if (n_ioc =3D=3D 0)
-                                            break;
+                            if (_IOC_NR(cmd) =3D=3D _IOC_NR(SPI_IOC_MESSAG=
E(0))) {
+                                           tmp =3D _IOC_SIZE(cmd);
+                                           if ((tmp % sizeof(struct spi_io=
c_transfer)) !=3D 0) {
+                                                          retval =3D -EINV=
AL;
+                                                          break;
+                                           }
+                                           n_ioc =3D tmp / sizeof(struct s=
pi_ioc_transfer);
+                                           if (n_ioc =3D=3D 0)
+                                                          break;

-                             /* copy into scratch area */
-                             ioc =3D kmalloc(tmp, GFP_KERNEL);
-                             if (!ioc) {
-                                            retval =3D -ENOMEM;
-                                            break;
-                             }
-                             if (__copy_from_user(ioc, (void __user *)arg,=
 tmp)) {
+                                           /* copy into scratch area */
+                                           ioc =3D kmalloc(tmp, GFP_KERNEL=
);
+                                           if (!ioc) {
+                                                          retval =3D -ENOM=
EM;
+                                                          break;
+                                           }
+                                           if (__copy_from_user(ioc, (void=
 __user *)arg, tmp)) {
+                                                          kfree(ioc);
+                                                          retval =3D -EFAU=
LT;
+                                                          break;
+                                           }
+                                           /* translate to spi_message, ex=
ecute */
+                                           retval =3D spidev_message(spide=
v, ioc, n_ioc);
                                             kfree(ioc);
-                                            retval =3D -EFAULT;
-                                            break;
+                            } else if (_IOC_NR(cmd) =3D=3D _IOC_NR(SPI_IOC=
_WR_CTRL_DATA(0))) {
+                                           void *save =3D spi->controller_=
data;
+
+                                           tmp =3D _IOC_SIZE(cmd);
+                                           if (tmp =3D=3D 0) {
+                                                          spi->controller_=
data =3D NULL;
+                                           } else {
+                                                          spi->controller_=
data =3D kmalloc(tmp, GFP_KERNEL);
+                                                          if (!spi->contro=
ller_data) {
+                                                                         s=
pi->controller_data =3D save;
+                                                                         r=
etval =3D -ENOMEM;
+                                                                         b=
reak;
+                                                          }
+                                                          if (__copy_from_=
user(spi->controller_data,
+                                                                          =
              (void __user *)arg, tmp)) {
+                                                                         k=
free(spi->controller_data);
+                                                                         s=
pi->controller_data =3D save;
+                                                                         r=
etval =3D -EFAULT;
+                                                                         b=
reak;
+                                                          }
+                                                          retval =3D spi_s=
etup(spi);
+                                           }
+                                           if (!save)
+                                                          kfree(save);
                              }
-
-                             /* translate to spi_message, execute */
-                             retval =3D spidev_message(spidev, ioc, n_ioc);
-                             kfree(ioc);
                              break;
               }

diff --git a/include/linux/spi/spidev.h b/include/linux/spi/spidev.h
index bf0570a..dbc3796 100644
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -126,6 +126,9 @@ struct spi_ioc_transfer {
 #define SPI_IOC_RD_MAX_SPEED_HZ                     _IOR(SPI_IOC_MAGIC, 4,=
 __u32)
 #define SPI_IOC_WR_MAX_SPEED_HZ                    _IOW(SPI_IOC_MAGIC, 4, =
__u32)

+/* Write SPI controller_data */
+#define SPI_IOC_WR_CTRL_DATA(size)  _IOW(SPI_IOC_MAGIC, 5, char[size])
+


 #endif /* SPIDEV_H */
--
1.6.5.2

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

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AFirsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AFirsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--_004_9F3EABD6E3419B4C81F34EAABB4D4018810CF7F4AFirsmsx501gerc_--
