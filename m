From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: spi32766.1 when probing via dt
Date: Wed, 25 Apr 2012 10:14:58 +0800
Message-ID: <CAAQ0ZWQvA=a65_y-tNnzGbRq2M25-qD_xv0FepPgPFamrxbnVg@mail.gmail.com>
References: <CAOMZO5DH96X8i=UWL5fj4vwg8cskHK6arq3Nizz6fhnPkYGOzw@mail.gmail.com>
	<CAOMZO5BgubdvTVu2tz6khgGbsVKJ0BAEB_91BiDE37M5aQf86w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOMZO5BgubdvTVu2tz6khgGbsVKJ0BAEB_91BiDE37M5aQf86w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 25 April 2012 09:52, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> =A0int spi_register_master(struct spi_master *master)
> =A0{
> - =A0 =A0 =A0 static atomic_t =A0 =A0 =A0 =A0 dyn_bus_id =3D ATOMIC_INIT(=
(1<<15) - 1);
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev =3D master->dev.par=
ent;
> =A0 =A0 =A0 =A0struct boardinfo =A0 =A0 =A0 =A0*bi;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EN=
ODEV;
> @@ -986,7 +985,7 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* FIXME switch to an IDR based scheme, so=
mething like
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * I2C now uses, so we can't run out of "d=
ynamic" IDs
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D atomic_dec_return(&dyn_=
bus_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->bus_num =3D dev->id;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic =3D 1;
> =A0 =A0 =A0 =A0}
>
> Then the spi bus number becomes the same in dt and non-dt cases.
>
> So maybe the current behavior is expected because the usage of =A0dyn_bus=
_id ?

I would think so.  Not sure if you are interested in solving the FIXME
in the comment right above that.

Regards,
Shawn

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
