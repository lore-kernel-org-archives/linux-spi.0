From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] spi: enable spi_board_info to be
 registered after spi_master
Date: Mon, 2 Aug 2010 14:25:43 +0800
Message-ID: <20100802142543.6b139c4b@feng-i7>
References: <20100802134736.24854fac@feng-i7>
	<AANLkTi=dEQ9oRi-NOi=oyab3yBeX7HWDOqs+pS5=-Bix@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=dEQ9oRi-NOi=oyab3yBeX7HWDOqs+pS5=-Bix-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2 Aug 2010 13:53:25 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> > =A0/**
> > @@ -365,6 +370,24 @@ struct spi_device *spi_new_device(struct
> > spi_master *master, }
> > =A0EXPORT_SYMBOL_GPL(spi_new_device);
> >
> > +/* Has to be called when board_lock is acquired */
> > +static void spi_scan_masterlist(struct spi_board_info *bi)
> > +{
> > + =A0 =A0 =A0 struct spi_master *master;
> > + =A0 =A0 =A0 struct spi_device *dev;
> > +
> > + =A0 =A0 =A0 list_for_each_entry(master, &spi_master_list, list) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (master->bus_num !=3D bi->bus_num)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi_new_device(master, bi);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dev)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(master->dev.paren=
t,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can't cr=
eate new device for %s\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bi->modal=
ias);
> > + =A0 =A0 =A0 }
> > +}
> > +
> =

> The abstraction isn't quite at the right place because the same code
> block is now duplicated twice.  Consider the following instead:
> =

> static void spi_match_master_to_boardinfo(struct spi_master *master,
> 				struct spi_board_info *bi)
> {
> 	struct spi_device *dev;
> =

> 	if (master->bus_num !=3D bi->bus_num)
> 		return;
> =

> 	dev =3D spi_new_device(master, bi);
> 	if (!dev)
> 		dev_err(master->dev.parent, "can't create new device
> for %s\n", bi->modalias);
> }
> =

> And then from spi_register_board_info, do:
> =

> 	list_for_each_entry(master, &spi_master_list, list)
> 		spi_match_master_to_boardinfo(master, &bi->boardinfo);
> =

> And in spi_register_master, do:
> =

> 	list_for_each_entry(bi, &board_list, list)
> 		spi_match_master_to_boardinfo(master, &bi->boardinfo);
> =

> It will be less code that way.
> =

> Otherwise, this patch looks good to me.  Unfortunately, it's too late
> for 2.6.36, but I'll pick it up into my test branch in prep for the
> 2.6.37 cycle.
> =

> Cheers,
> g.

Yeah, make much sense! Thanks for the thorough reviews.

- Feng



---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
