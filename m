From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: enable spi_board_info to be
 registered after spi_master
Date: Wed, 28 Jul 2010 09:23:06 +0800
Message-ID: <20100728092306.1168ab7c@feng-i7>
References: <1280223769-19919-1-git-send-email-feng.tang@intel.com>
	<AANLkTi=C48+mnNjrxha8WqagCybF45f7aTn6nxt2qRuU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=C48+mnNjrxha8WqagCybF45f7aTn6nxt2qRuU-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Thanks for your thorough reviews!

Will address most of the comments.



On Wed, 28 Jul 2010 01:27:16 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> =

> for (i =3D 0, tmp_bi =3D bi; i < n; i++, tmp_bi++, info++)
> =

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&bi->board_info, info, sizeof *inf=
o);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> > + =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0mutex_unlock(&board_lock);
> > +
> > + =A0 =A0 =A0 bi =3D tmp_bi;
> > + =A0 =A0 =A0 for (i =3D 0; i < n; i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scan_masterlist(&bi->board_info);
> =

> How does this work?  The same board_info struct is passed to
> scan_masterlist() multiple times.

My bad, I tested 2 cases by calling register_board_info before and
after spi_register_master(), but only with one spi device. Will fix it


> > @@ -537,6 +557,10 @@ int spi_register_master(struct spi_master
> > *master) dev_dbg(dev, "registered master %s%s\n",
> > dev_name(&master->dev), dynamic ? " (dynamic)" : "");
> >
> > + =A0 =A0 =A0 mutex_lock(&master_lock);
> > + =A0 =A0 =A0 list_add_tail(&master->list, &master_list);
> > + =A0 =A0 =A0 mutex_unlock(&master_lock);
> > +
> =

> There seems to be a race condition here.  If a boardinfo is registered
> after this list add, but before scan_boardinfo(master), then a
> boardinfo can get parsed twice for a single master.  I think the
> proper thing to do is to hold the mutex over the whole operation; from
> registering the list or master, until after the scan is complete.
> =


Good point. Maybe moving the list_add(master) after scan_boardinfo() =

can fix this race condition.

Thanks,
Feng

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
