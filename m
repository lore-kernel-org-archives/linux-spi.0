From: saeed <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [patch 2.6.26+] spi:  new orion_spi driver
Date: Tue, 29 Jul 2008 21:54:48 -1100 (SST)
Message-ID: <alpine.DEB.0.99.0807292145300.25994@ubuntu-saeed.il.marvell.com>
References: <200807221228.00958.david-b@pacbell.net>
	<20080728211655.4d51e921.akpm@linux-foundation.org>
	<200807282343.25058.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1134571507-1217408088=:25994"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Lennert Buijtenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200807282343.25058.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1134571507-1217408088=:25994
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: QUOTED-PRINTABLE

> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (orion_spi_baudrate_set(spi, speed)=
 !=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return -EINVAL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (orion_spi_set_transfer_size(orion_=
spi, bits_per_word) !=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return -EINVAL;
> >=20
> > Given that orion_spi_baudrate_set() and orion_spi_set_transfer_size()
> > carefully return an -EFOO value, it's a bit unkind to just rub that out
> > and return a hard-coded -EINVAL.
right, done in the patch below
>=20
> > > +static void __exit orion_spi_exit(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_driver_unregister(&orion_spi_=
driver);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destroy_workqueue(orion_spi_wq);
> > > +}
> >=20
> > Please double-check the workqueue handling. =C2=A0Without looking at it=
 too
> > closely, I think that this is waaaay too late to be running
> > destroy_workqueue(). =C2=A0If a work is still pending, all the data upo=
n
> > which it will be operating will have been rubbed out. =C2=A0I'm suspect=
ing
> > that an earlier flush_work() (or similar) will be needed.

added cancel_work_sync to cancel the work of the device when removing it,=
=20
and flush_workqueue on the driver's removal.
here is the patch with the modifications needed by the two comments:
------------------>8
diff --git a/drivers/spi/orion_spi.c b/drivers/spi/orion_spi.c
index 8d6ad53..a5ed758 100644
--- a/drivers/spi/orion_spi.c
+++ b/drivers/spi/orion_spi.c
@@ -138,6 +138,7 @@ orion_spi_setup_transfer(struct spi_device *spi, struct=
 spi_transfer *t)
 =09struct orion_spi *orion_spi;
 =09unsigned int speed =3D spi->max_speed_hz;
 =09unsigned int bits_per_word =3D spi->bits_per_word;
+=09int=09rc;
=20
 =09orion_spi =3D spi_master_get_devdata(spi->master);
=20
@@ -147,13 +148,11 @@ orion_spi_setup_transfer(struct spi_device *spi, stru=
ct spi_transfer *t)
 =09if ((t !=3D NULL) && t->bits_per_word)
 =09=09bits_per_word =3D t->bits_per_word;
=20
-=09if (orion_spi_baudrate_set(spi, speed) !=3D 0)
-=09=09return -EINVAL;
-
-=09if (orion_spi_set_transfer_size(orion_spi, bits_per_word) !=3D 0)
-=09=09return -EINVAL;
-
-=09return 0;
+=09rc =3D orion_spi_baudrate_set(spi, speed);
+=09if (rc)
+=09=09return rc;
+=09
+=09return orion_spi_set_transfer_size(orion_spi, bits_per_word);
 }
=20
 static void orion_spi_set_cs(struct orion_spi *orion_spi, int enable)
@@ -530,6 +529,8 @@ static int __exit orion_spi_remove(struct platform_devi=
ce *pdev)
 =09master =3D dev_get_drvdata(&pdev->dev);
 =09spi =3D spi_master_get_devdata(master);
=20
+=09cancel_work_sync(&spi->work);
+
 =09r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 =09release_mem_region(r->start, (r->end - r->start) + 1);
=20
@@ -561,6 +562,7 @@ module_init(orion_spi_init);
=20
 static void __exit orion_spi_exit(void)
 {
+=09flush_workqueue(orion_spi_wq);
 =09platform_driver_unregister(&orion_spi_driver);
=20
 =09destroy_workqueue(orion_spi_wq);
--8323329-1134571507-1217408088=:25994
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--8323329-1134571507-1217408088=:25994
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--8323329-1134571507-1217408088=:25994--
