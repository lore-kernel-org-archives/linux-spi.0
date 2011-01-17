From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: Fix unregistering of the SPI master and SPI devices
Date: Mon, 17 Jan 2011 10:12:34 -0700
Message-ID: <AANLkTinufhbNoAkozt2-xf7Nnd4GAs77mYy9X2NxO8uV@mail.gmail.com>
References: <Pine.LNX.4.64.1101171659550.16051@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1101171659550.16051-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 17, 2011 at 9:00 AM, Guennadi Liakhovetski
<g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> The actual SPI master device instance and SPI devices on the bus are all
> children of the same parent, typically, the SPI host platform device. Not
> taking this into consideration leads to SPI devices never being unregiste=
red.

Conceptually, the fact that spi puts the master and the slaves at the
same level doesn't make very much sense to me.  I've been toying with
the idea of changing it so that the slaves become children of the
master.  It is conceivable that a single device would contain two or
more spi master instances, so it would be wise to separate the slave
instances from each other.

David, what's the reasoning for making slaves and the master peers?

g.

>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> ---
> =A0drivers/spi/spi.c | =A0 10 +++++++---
> =A01 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 34bb17f..0fa6c6c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -636,9 +636,13 @@ done:
> =A0EXPORT_SYMBOL_GPL(spi_register_master);
>
>
> -static int __unregister(struct device *dev, void *null)
> +static int __unregister(struct device *dev, void *data)
> =A0{
> - =A0 =A0 =A0 spi_unregister_device(to_spi_device(dev));
> + =A0 =A0 =A0 struct spi_master *master =3D data;
> +
> + =A0 =A0 =A0 if (&master->dev !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_unregister_device(to_spi_device(dev));
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -660,7 +664,7 @@ void spi_unregister_master(struct spi_master *master)
> =A0 =A0 =A0 =A0list_del(&master->list);
> =A0 =A0 =A0 =A0mutex_unlock(&board_lock);
>
> - =A0 =A0 =A0 dummy =3D device_for_each_child(&master->dev, NULL, __unreg=
ister);
> + =A0 =A0 =A0 dummy =3D device_for_each_child(master->dev.parent, master,=
 __unregister);
> =A0 =A0 =A0 =A0device_unregister(&master->dev);
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_unregister_master);
> --
> 1.7.2.3
>
>
> -------------------------------------------------------------------------=
-----
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand
> malware threats, the impact they can have on your business, and how you
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
