From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: register spi child
 devices of spi node
Date: Tue, 27 Jul 2010 15:27:12 +0800
Message-ID: <20100727152712.20a9b35d@feng-i7>
References: <20100727061744.GB22765@jasper.tkos.co.il>
	<298403.16600.qm@web180305.mail.gq1.yahoo.com>
	<20100727151428.4a067f0e@feng-i7>
	<AANLkTikZ4MMqmM3jn8yh49kh5+qOh2nmaYDVBOYhbo-K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	"alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTikZ4MMqmM3jn8yh49kh5+qOh2nmaYDVBOYhbo-K-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 27 Jul 2010 15:00:29 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Tue, Jul 27, 2010 at 1:14 AM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> wrote:
> > On Tue, 27 Jul 2010 14:28:57 +0800
> > David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> >
> >> There are things wrong with the concept of this
> >> particular patch. =A0First, that it's mpc5121-only.
> >> Second, that it's not already handled as part of
> >> registering the platform's SPI devices.
> >>
> >>
> >
> > Hi David, Grant,
> >
> > This actually brings up another topic: currently
> > spi_register_board_info() has to be called before spi
> > controller(master) get inited. But in some case, to solve some
> > device dependency issue, some spi slave device need be delayed
> > registering, can we adjust it to make register_board_info() be
> > callable after spi controller is inited? Which makes spi bus like
> > general pci/usb bus, where devices/drivers have no registering
> > order limit.
> =

> Is spi_alloc_device()/spi_add_device() not suitable for your use-case?
> =

> g.

Yes, I've thought about that, but spi_alloc_device() is called when you
know which spi_master it is connecting to, while our platform need kind
of blind registering (just register something to spi-bus).

Thanks,
Feng

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
